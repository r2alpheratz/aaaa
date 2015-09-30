/**
 * project : KORAIL_YZ
 * package : com.korail.yz.yb.ab
 * date : 2014. 3. 26.오후 2:16:13
 */
package com.korail.yz.yb.ab;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Service;

import com.korail.tz.sa.ISA0001SVC;
import com.korail.tz.sa.XframeControllerUtils;
import com.korail.ws.schema.OUT_FORMAT;

import cosmos.comm.dao.CommDAO;
import cosmos.comm.exception.CosmosRuntimeException;

/**
 * @author 한현섭
 * @date 2014. 3. 26. 오후 2:16:13
 * Class description : 통합메시지코드 등록관리를 위한 서비스
 */
@Service("com.korail.yz.yb.ab.YBAB001SVC")
public class YBAB001SVC {

	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public  static final Logger  LOGGER = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);

	
	/**
	 * @author 한현섭
	 * @date 2014. 3. 26.오후 2:16:13
	 * Method description : 통합메시지코드를 등록
	 * @param param
	 * @return
	 * @remarks 김응규 수정(2014.12.16)
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> insertMsgCd(Map<String, ?> param)
	{
		LOGGER.debug("param ==>"+param);
		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		
		ArrayList<Map<String, Object>> resultList = new ArrayList<Map<String,Object>>();
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsMsgCdItem");
		

		String intgMsgCd = inputDataSet.get("MSG_TP_CD").concat(inputDataSet.get("DUTY_DV_CD"));
		Map<String, String> inputPkSet = new HashMap<String, String>();
		inputPkSet.put("msgSrt", intgMsgCd);
		
		ArrayList<Map<String, Object>> resultMsg
		= (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.yb.ab.YBAB001QMDAO.selectCdMaxVal", inputPkSet);
		
		String maxCodeVal = (String) resultMsg.get(0).get("INTG_MSG_CD");

		inputDataSet.put("INTG_MSG_CD", maxCodeVal);
		inputDataSet.put("USR_ID", XframeControllerUtils.getUserId(param));
		LOGGER.debug("maxCodeVal--->"+maxCodeVal);
		LOGGER.debug("inputDateSet--->"+XframeControllerUtils.getUserId(param));
		
		
		int insertCnt = 0;
		try{
			insertCnt = dao.insert("com.korail.yz.yb.ab.YBAB001QMDAO.insertMsgCd", inputDataSet);
			resultMap.put("RESULT", "OK");
			
		}catch(Exception e){
			throw new CosmosRuntimeException("WZZ000012", null); 
			//등록 작업이 실패하였습니다.	입력값을 확인하십시오.
		}
		LOGGER.debug("등록 ["+insertCnt+"] 건 완료!");
		
		resultList.add(resultMap);
		result.put("dsResult", resultList);
		return result;
	}

	/**
	 * @author 한현섭
	 * @date 2014. 3. 26.오후 2:16:13
	 * Method description : 통합메시지코드를 수정
	 * @param param
	 * @return
	 * @remarks 김응규 수정(2014.12.16)
	 */
	public Map<String, ?> updateMsgCd(Map<String, ?> param)
	{
		LOGGER.debug("param ==>"+param);
		Map<String, Object> result = new HashMap<String, Object>();
		ArrayList<Map<String, Object>> resultList = new ArrayList<Map<String,Object>>();
		Map<String, Object> resultMap = new HashMap<String, Object>();

		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsMsgCdItem");

		inputDataSet.put("USR_ID", XframeControllerUtils.getUserId(param));
		int updateCnt = 0;
		try{
			updateCnt = dao.update("com.korail.yz.yb.ab.YBAB001QMDAO.updateMsgCd", inputDataSet);
			resultMap.put("RESULT", "OK");
		}catch(Exception e){
			throw new CosmosRuntimeException("WYZ000007", null); 
			//해당 자료를 수정할수 없습니다.	수정자료를 확인하여 주십시오.
		}
		LOGGER.debug("수정 ["+updateCnt+"] 건 완료!");
		resultList.add(resultMap);
		result.put("dsResult", resultList);
		
		return result;
	}
	
	/**
	 * @author 한현섭
	 * @date 2014. 3. 26.오후 2:16:13
	 * Method description : 통합메시지코드를 삭제
	 * @param param
	 * @return
	 * @remarks 김응규 수정(2014.12.16)
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> deleteMsgCd(Map<String, ?> param)
	{
		LOGGER.debug("param ==>"+param);
		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();

		/* 입력 오브젝트 */
		ArrayList<Map<String, String>> inputList = (ArrayList<Map<String, String>>) param.get("dsListChecked");
		
		
		int deleteCnt = 0;
		LOGGER.debug("inputList 사이즈:::::::::::::::"+inputList.size());
		
	    for( int i = 0; i < inputList.size() ; i++ )
	    {
	    	Map<String, String> item = inputList.get(i);
	    	try {
	    		LOGGER.debug("INPUT INTG_MSG_CD :::"+item.get("INTG_MSG_CD"));
        		deleteCnt += dao.delete("com.korail.yz.yb.ab.YBAB001QMDAO.deleteMsgCd", item);
			} catch (Exception e) {
				throw new CosmosRuntimeException("WYZ000009", null);  //롤백 & alert 메시지 
				//해당 자료를 삭제할 수 없습니다.	삭제 자료를 확인하여 주십시오.
			}
	    	
	    }
	    LOGGER.debug("삭제 ["+deleteCnt+"] 건 수행하였습니다.");
	    
		//메시지 처리
  		if(deleteCnt < 1){
  			XframeControllerUtils.setMessage("WYZ000009", result); //해당 자료를 삭제할 수 없습니다.
  		}
  		else
  		{
  			XframeControllerUtils.setMessage("IZZ000011", result); //정상적으로 삭제 되었습니다.
  		}
		
		return result;
	}
	
	
	/**
	 * @author 한현섭
	 * @date 2014. 3. 26.오후 2:16:13
	 * Method description : 통합메시지코드를 조회
	 * @param param
	 * @return
	 * @remarks 김응규 수정(2014.12.16)
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListMsgCd(Map<String, ?> param)
	{
		LOGGER.debug("param ==>"+param);
		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		
		/* 입력 오브젝트 */
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");
		

		ArrayList<Map<String, Object>> resultList
		= (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.yb.ab.YBAB001QMDAO.selectListMsgCd", inputDataSet);

		//메시지처리
		if(resultList.isEmpty()){
			XframeControllerUtils.setMessage("IZZ000004", result); //해당 조건의 자료가 존재하지 않습니다.
		}
		else{
			XframeControllerUtils.setMessage("IZZ000009", result); //정상적으로 조회되었습니다.
		}
		result.put("dsList", resultList);
		return result;
	}	
	
	
	/**
	 * @author 김응규
	 * @date 2014. 11. 17. 오전 9:35:50
	 * Method description : 메시지코드 등록/수정/삭제 후  EAI 호출
	 */
	public Map<String, ?> callEaiMsgCodeInfo(Map<String, ?> param) throws Exception
	{
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		LOGGER.debug("메시지코드 EAI CALL 시작!!!!!!!!!!!!!!!!!");
		com.korail.ws.eai.EaiWSCall eai = new com.korail.ws.eai.EaiWSCall();
		
		OUT_FORMAT out = eai.eaiCall("YZ_if_XframeMsg", null, null);
		
		String rtnCode = out.getCODE();
		
		LOGGER.debug("Return Code:" + rtnCode);
		if(!"SYSEA0000".equals(rtnCode))            //리턴코드가 정상이 아니면 exception 발생 후 롤백
        {
            throw new Exception("EAI 에러 : " + rtnCode);
        }
		LOGGER.debug("EAI CALL 끝!!!!!!!!!!!!!!!!!");	
		
		//화면하단 메시지 처리
		XframeControllerUtils.setMessage("IZZ000013", result); //정상적으로 저장 되었습니다.
		
		return result;
	
		
	}
}
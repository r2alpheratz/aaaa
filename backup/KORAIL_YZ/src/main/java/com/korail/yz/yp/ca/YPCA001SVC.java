/**
 * project : KORAIL_YZ
 * package : com.korail.yz.yp.ca
 * date : 2014. 7. 11.오후 5:55:51
 */
package com.korail.yz.yp.ca;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Service;

import com.korail.tz.sa.ISA0001SVC;
import com.korail.tz.sa.XframeControllerUtils;

import cosmos.comm.dao.CommDAO;
import cosmos.comm.exception.CosmosRuntimeException;

/**
 * @author EQ
 * @date 2014. 7. 28. 오전 11:17:51
 * Class description : 할인통제관리SVC
 * 열차/객실등급별로 할인등급을 통제하고, 이에 따르는 예상 수입증가분을 분석하기 위한 Service 클래스
 */
@Service("com.korail.yz.yp.ca.YPCA001SVC")
public class YPCA001SVC {
	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public  static final Logger  LOGGER = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
	
	
	/**
	 * 할인통제관리내역 조회
	 * @author 김응규
	 * @date 2014. 7. 28. 오전 11:19:00
	 * Method description : 할인통제관리 대상이되는 내역을 조회한다.
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map<String, ?> selectListDcntRgulMg(Map<String, ?> param) {		

		Map<String, Object> result = new HashMap<String, Object>();

		LOGGER.debug("param ==> "+param);
		// search input column dataset
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");	
		LOGGER.debug("inputDataSet ==>  " + inputDataSet);
		
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		if("".equals(trnOprBzDvCd) || trnOprBzDvCd == null){
			trnOprBzDvCd = "000";
		}
		inputDataSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		
		//할인통제관리 조회
		ArrayList<Map<String, Object>> resultList = (ArrayList) dao.list("com.korail.yz.yp.ca.YPCA001QMDAO.selectListDcntRgulMg", inputDataSet);

		//메시지 처리
		if(resultList.isEmpty())
		{
			XframeControllerUtils.setMessage("IZZ000004", result); //해당 조건의 자료가 존재하지 않습니다.
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result); //정상적으로 조회 되었습니다.
		}
		result.put("dsList", resultList);
		
		return result;

	}
	
	/**
	 * 할인통제FLAG 수정
	 * @author 김응규
	 * @date 2014. 7. 7. 오후 5:36:00
	 * Method description : 승급좌석의 사용자조정수를 수정 처리한다.
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "unchecked" })
	public Map<String, ?> updateDcntRgulFlag(Map<String, ?> param) {		

		Map<String, Object> result = new HashMap<String, Object>();
		LOGGER.debug("param ==> "+param);
		ArrayList<Map<String, Object>> resultList = new ArrayList<Map<String,Object>>();
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		ArrayList<Map<String, String>> dcntRgulList = (ArrayList<Map<String, String>>) param.get("dsList");
		String userId = String.valueOf(param.get("USER_ID"));
		
		int updateCnt = 0;
		int insertCnt = 0;
		int deleteCnt = 0;
		
		int cnt = 0;
		
		LOGGER.debug("dcntRgulList 사이즈:::::::::::::::"+dcntRgulList.size());
	    for( int i = 0; i < dcntRgulList.size() ; i++ )
	    {
	    	Map<String, String> item = dcntRgulList.get(i);
	    	
	    	LOGGER.debug("dsList["+i+"]번째 ROW =====>"+item);
	    	item.put("USER_ID", userId);	    	
	    	
	    	
	        if(item.get("DMN_PRS_DV_CD").equals("U") && item.get("FLAG2").equals("Y"))  //요청처리구분코드가 U : update && 현상태가 OPENED이고 조정상태가 CLOSED 인 경우
	        {
	        	updateCnt = dao.update("com.korail.yz.yp.ca.YPCA001QMDAO.updateDcntRgulFlg", item);
	        	LOGGER.debug("수정"+ i +"번 ["+updateCnt+"] 건 수행하였습니다.");
	        	
	        	if(updateCnt < 1)
	        	{
        			insertCnt = dao.insert("com.korail.yz.yp.ca.YPCA001QMDAO.insertDcntRgulFlg", item);
        			LOGGER.debug("등록(CLOSED로 변환)"+ i +"번 ["+insertCnt+"] 건 수행하였습니다.");
        			cnt += insertCnt;
	        	}
	        	else
	        	{
	        		cnt += updateCnt;
	        	}
	        	
	        }
	        else if(item.get("DMN_PRS_DV_CD").equals("U") && item.get("FLAG2").equals("N")) //요청처리구분코드가 U : update && 현상태가 CLOSED이고 조정상태가 OPENDED 인 경우
	        {
	        	deleteCnt = dao.delete("com.korail.yz.yp.ca.YPCA001QMDAO.deleteDcntRgulFlg", item);
    			LOGGER.debug("삭제(OPENED로 변환)"+ i +"번 ["+deleteCnt+"] 건 수행하였습니다.");
    			cnt += deleteCnt;
	        }
	    }
	    
		//메시지 처리
  		if(cnt < 1){
  			throw new CosmosRuntimeException("WYZ000007", null);  ////해당 자료를 수정할수 없습니다.	수정자료를 확인하여 주십시오.
  		}
  		else
  		{
  			resultMap.put("RESULT", "SUCCESS");
  			resultList.add(resultMap);
  			XframeControllerUtils.setMessage("IZZ000013", result); //정상적으로 저장 되었습니다.
  		}
  		result.put("dsResult", resultList);
		return result;

	}
}

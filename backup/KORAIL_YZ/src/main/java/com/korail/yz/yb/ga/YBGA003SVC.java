/**
 * project : KORAIL_YZ
 * package : com.korail.yz.yb.ga
 * date : 2015. 3. 19.오후 5:55:51
 */
package com.korail.yz.yb.ga;

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
 * @author 김응규
 * @date 2015. 3. 19. 오후 5:55:51
 * Class description : EAI인터페이스처리SVC
 * EAI인터페이스처리결과를 조회(IF_YYBB999) 
 * 실시간으로 EAI인터페이스를 실행할 수 있는 Service 클래스
 */
@Service("com.korail.yz.yb.ga.YBGA003SVC")
public class YBGA003SVC {
	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public  static final Logger  LOGGER = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
	
	
	/**
	 * EAI인터페이스 처리내역 조회
	 * @author 김응규
	 * @date 2015. 3. 19. 오후 5:55:55
	 * Method description : EAI인터페이스 송수신 처리내역을 조회한다. 
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map<String, ?> selectListEaiInsf(Map<String, ?> param) {		

		Map<String, Object> result = new HashMap<String, Object>();
		
		LOGGER.debug("param ==> "+param);
		// search input column dataset
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");	
		LOGGER.debug("inputDataSet ==>  " + inputDataSet);
		//열차운영사업자구분코드 추가
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		inputDataSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		
		//고객승급관리 조회
		ArrayList<Map<String, Object>> resultList = (ArrayList) dao.list("com.korail.yz.yb.ga.YBGA003QMDAO.selectListEaiInsf", inputDataSet);

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
	 * @author 김응규
	 * @date 2015. 3. 19. 오후 5:55:50
	 * Method description : EAI 호출
	 */
	public Map<String, ?> processEaiInsf(Map<String, ?> param)
	{
		LOGGER.debug("param ==> "+param);
		Map<String, Object> result = new HashMap<String, Object>();
		// search input column dataset
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");
		String sInsfId = inputDataSet.get("INSF_ID");
		LOGGER.debug(sInsfId + "  <========  EAI CALL 시작TEST!!!!!!!!!!!!!!!!!");
		
		com.korail.ws.eai.EaiWSCall eai = null;
		OUT_FORMAT out = null;
		try{
			eai = new com.korail.ws.eai.EaiWSCall();
			out = eai.eaiCall(sInsfId, null, null);
			LOGGER.debug("====================>>>>>> "+ out.getCODE());
		
		}catch (Exception e){
			LOGGER.debug(e);
		}
		LOGGER.debug("메시지OUT ::: "+out.getMESSAGE());
		String rtnCode = out.getCODE();
		
		LOGGER.debug("Return Code:" + rtnCode);
		if(!"SYSEA0000".equals(rtnCode))            //리턴코드가 정상이 아니면 exception 발생 후 롤백
        {
            throw new CosmosRuntimeException("EAI 에러 : " + rtnCode, null);
        }

		LOGGER.debug("EAI CALL 끝!!!!!!!!!!!!!!!!!");	
		
		//화면하단 메시지 처리
		XframeControllerUtils.setMessage("IZZ000013", result); //정상적으로 저장 되었습니다.
		
		return result;
	
		
	}
	
}

package com.korail.tz.sa;

import java.util.HashMap;
import java.util.Map;
import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Service;

import cosmos.comm.dao.CommDAO;
import cosmos.comm.exception.CosmosRuntimeException;

@Service("com.korail.tz.sa.SACO001SVC")
public class SACO001SVC {

	@Resource(name = "commDAO")
	private CommDAO dao;

	@Resource(name = "messageSource")
	MessageSource messageSource;

	public final Logger logger = Logger
			.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);

	public Map<String, ?> selectTestList(Map<String, ?> param) {

					
		Map<String, Object> result = new HashMap<String, Object>();

		// User ID
		String userId = XframeControllerUtils.getUserId(param);
		logger.debug("==========> >>>>> " + userId);

		// search input column dataset
		Map<String, String> inputDataSet = XframeControllerUtils
				.getParamDataSet(param, "dsSelectTestList");
		logger.debug("inputDataSet ==>  " + inputDataSet);

		// search input column data
		String inputData = XframeControllerUtils.getParamData(param,
				"dsSelectTestList", "test_id");
		logger.debug("inputData ==>  " + inputData);

		// return Query Result
		result.put("dsSelectTestList", dao.list(
				"com.korail.tz.sa.dao.SA001QMDAO.selectTestList", param));

		// message put
		XframeControllerUtils.setMessage("code", result);
		
		//업무예외 처리
		String userID = "a";
		if("a".equals(userID)){						
			throw new CosmosRuntimeException("999", null); //"999"는 업무에서 정의한 코드입니다.
		}
				
//		//error message
//		String s = null;			
//		if(null==s){
//			String errorMessage = XframeControllerUtils.getErrorMessage(messageSource, "biz.001.error", "biz.001_error 코드의 메시지에 추가되는 메시지이며 없으면 null 로 입력");		
//			logger.debug(this.getClass().getName() + " : "+ errorMessage);
//			throw new CosmosRuntimeException(errorMessage, null);	
//	    }
		

		return result;


	}

}

package com.korail.tz.sa;

import java.util.HashMap;
import java.util.Map;
import javax.annotation.Resource;
import org.apache.log4j.Logger;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Service;

import cosmos.comm.dao.CommDAO;

@Service("com.korail.tz.sa.SACO001SVC")
public class SACO001SVC {

	@Resource(name = "commDAO")
	private CommDAO dao;

	@Resource(name = "messageSource")
	MessageSource messageSource;

	public final Logger logger = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);

	public Map<String, ?> selectTestList(Map<String, Object> param) {		

		Map<String, Object> result = new HashMap<String, Object>();
					
		try{
			//test
			//BLOB 입력
			Map<String, String> inputDataSet = XframeControllerUtils.getParamDataSetBlob(param, "dsSelectTestList", "IMAGE");		
			result.put("dsSelectTestList", dao.list("com.korail.tz.sa.dao.SA001QMDAO.insertBlobTest", param));

			//BLOB 조회
			result.put("dsSelectTestList",  XframeControllerUtils.getBlobResultList(dao.list("com.korail.tz.sa.dao.SA001QMDAO.selectTestBlob", param), "IMAGE"));									
			
			/*			
			String blobFileName = "BLOB_TEST.JPG";
			String blobColumnName = "filename";
			
			//inputDataSet.put(blobColumnName, imageByte);
			param.put(blobColumnName, imageByte);			
			*/
			
			//1. InputDataSet Load -> getParamDataSetObject 함수사용
		   //Map<String, Object> inputDataSet = XframeControllerUtils.getParamDataSetObject(param, "dsSelectTestList");
			
			///* BLOB Put
			//2. BLOB Image 를 Byte 형으로 변환
			//byte[] blob_bytes = XframeControllerUtils.getBlobImage(blobFileName);				
			//param.put(blobColumnName, blob_bytes);								
			
			//DB Insert 
			//result.put("dsSelectTestList", dao.list("com.korail.tz.sa.dao.SA001QMDAO.insertBlobTest", param));
			
			//3. BLOB Image 삭제
			//boolean isDelete = XframeControllerUtils.delBlobImage(blobFileName);
            //*/
			
						
		}catch(Exception e){
			e.printStackTrace();
		}	    	

			logger.debug("훽훽휅휅휅휅휅휅휅휅휅휅휅휅휅휅휅휅휅 ");		
			
			// User ID
			String userId = XframeControllerUtils.getUserId(param);
			logger.debug("==========> >>>>> " + userId);

			// search input column dataset
			Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsSelectTestList");
			logger.debug("inputDataSet ==>  " + inputDataSet);

			// search input column data
			String inputData = XframeControllerUtils.getParamData(param,	"dsSelectTestList", "test_id");
			logger.debug("inputData ==>  " + inputData);

			// return Query Result
			result.put("dsSelectTestList", dao.list("com.korail.tz.sa.dao.SA001QMDAO.selectTestList", param));		


			// message put
			XframeControllerUtils.setMessage("code", result);

		return result;			


	}

}

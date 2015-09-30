/**
 * 
 */
package com.korail.tz.pl;

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

/**
 * @author SDS
 *
 */

@Service("com.korail.tz.pl.TEST007SVC")
public class TEST007SVC {
	
	@Resource(name ="commDAO")
	private CommDAO dao;
	
	@Resource (name = "messageSource")
	private MessageSource MessageSource;
	
	public  final Logger logger = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
	
	
	public Map<String, ?> selectScnList(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>(); 
		Map<String, String>inputDataSet = XframeControllerUtils.getParamDataSet(param, "dsCondition");
		
		logger.debug("inputDataSet ==>  " + inputDataSet);
		
//		ArrayList<Map<String, Object>> resultList = (ArrayList<Map<String, Object>>) dao.list("com.korail.tz.pl.YZPL003QMDAO.selectMenuList", inputDataSet);
		ArrayList<Map<String,Object>>  resultList = (ArrayList<Map<String, Object>>) dao.list("com.korail.tz.pl.YZPL007QMDAO.selectScnList", inputDataSet);
		
		result.put("dsScnList", resultList);
		
		return result;
	}
	
	
	

}

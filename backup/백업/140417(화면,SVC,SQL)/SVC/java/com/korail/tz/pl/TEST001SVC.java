/**
 * project : KORAIL_YZ
 * package : com.korail.tz.pl
 * date : 2014. 3. 5.오전 6:09:06
 */

package com.korail.tz.pl;

import java.util.ArrayList;
import java.util.HashMap;
//import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Service;

import com.korail.tz.sa.ISA0001SVC;
import com.korail.tz.sa.XframeControllerUtils;

import cosmos.comm.dao.CommDAO;

/**
 * @author 민지홍
 * @date 2014. 3. 5. 오전 6:09:06
 * Class description : 코드 목록 및 코드 상세 목록을 조회하는 서비스.
 */
@Service("com.korail.tz.pl.TEST001SVC")
public class TEST001SVC {

	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public  final Logger logger = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
	

	/**
	 * @author 민지홍
	 * @date 2014. 3. 5. 오전 6:09:51
	 * Method description : (페이징) 공통코드 분류코드 목록을 조회한다.
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectComnCodeList(Map<String, ?> param) {		

		Map<String, Object> result = new HashMap<String, Object>();

		logger.debug("param ==> "+param);
		// search input column dataset
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");	
		logger.debug("inputDataSet ==>  " + inputDataSet);

		// search input column data
		logger.debug("inputData ==>  " + inputDataSet.get("QRY_NUM_NEXT"));		
		logger.debug("inputData ==>  " + inputDataSet.get("PG_PR_CNT"));
				
		//spring MVC Locale�뺤씤
		/*
		Locale locale1 = Locale.ENGLISH;
		Locale locale2 = Locale.KOREA;
		System.out.println(messageSource.getMessage("errors.sql.notexists", new Object[]{"TEST"}, locale1));
		System.out.println(messageSource.getMessage("errors.sql.notexists", new Object[]{"TEST"}, locale2));
		*/
		
		ArrayList<Map<String, Object>> resultList = (ArrayList<Map<String, Object>>) dao.list("com.korail.tz.pl.YZPL001QMDAO.selectComnCodeList", inputDataSet);

		
		//return Query Result
		
		if(resultList.size() == Integer.parseInt(inputDataSet.get("PG_PR_CNT")))
		{
			inputDataSet.put("QRY_NUM_NEXT", String.valueOf(resultList.get(resultList.size()-1).get("QRY_NUM")));
		}else
		{
			inputDataSet.put("QRY_NUM_NEXT", "0");
		}
		
		for(int i=0;i<resultList.size();i++)
		{
			logger.debug(resultList.get(i).toString());
		}
		
		ArrayList<Map<String, String>> condList = new ArrayList<Map<String, String>>();
		condList.add(inputDataSet);
		
		result.put("dsCond", condList);
		result.put("dsComnCodeList", resultList);

		return result;

	}

	/**
	 * @author 민지홍
	 * @date 2014. 3. 5. 오전 6:09:51
	 * Method description : (페이징) 특정 분류코드의 상세 코드목록을 조회한다.
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectComnCodeDetailList(Map<String, ?> param) {		

		Map<String, Object> result = new HashMap<String, Object>();

		logger.debug("param ==> "+param);
		// search input column dataset
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");	
		logger.debug("inputDataSet ==>  " + inputDataSet);

		// search input column data
		logger.debug("inputData ==>  " + inputDataSet.get("QRY_NUM_NEXT"));		
		logger.debug("inputData ==>  " + inputDataSet.get("PG_PR_CNT"));
				
		//spring MVC Locale�뺤씤
		/*
		Locale locale1 = Locale.ENGLISH;
		Locale locale2 = Locale.KOREA;
		System.out.println(messageSource.getMessage("errors.sql.notexists", new Object[]{"TEST"}, locale1));
		System.out.println(messageSource.getMessage("errors.sql.notexists", new Object[]{"TEST"}, locale2));
		*/
		
		ArrayList<Map<String, Object>> resultList = (ArrayList<Map<String, Object>>) dao.list("com.korail.tz.pl.YZPL001QMDAO.selectComnCodeDetailList", inputDataSet);

		
		//return Query Result
		
		if(resultList.size() == Integer.parseInt(inputDataSet.get("PG_PR_CNT")))
		{
			inputDataSet.put("QRY_NUM_NEXT", String.valueOf(resultList.get(resultList.size()-1).get("QRY_NUM")));
		}else
		{
			inputDataSet.put("QRY_NUM_NEXT", "0");
		}
		
		ArrayList<Map<String, String>> condList = new ArrayList<Map<String, String>>();
		condList.add(inputDataSet);
		
		result.put("dsCond", condList);
		result.put("dsComnCodeDetailList", resultList);

		return result;

	}
}

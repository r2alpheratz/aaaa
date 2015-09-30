/**
 * project : KORAIL_YZ
 * package : com.korail.yz.yf.aa
 * date : 2014. 3. 5.오전 9:09:06
 */
package com.korail.yz.yf.aa;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Service;

import com.korail.tz.sa.ISA0001SVC;
import com.korail.tz.sa.XframeControllerUtils;


import cosmos.comm.dao.CommDAO;

/**
 * @author 김응규
 * @date 2014. 3. 5. 오전 9:09:06
 * Class description : 역그룹정보를 조회하는 서비스.
 */
@Service("com.korail.yz.yf.aa.YFAA001SVC")
public class YFAA001SVC {

	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public  final Logger logger = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);

	/**
	 * @author 김응규
	 * @date 2014. 3. 5. 오전 9:09:51
	 * Method description : 역그룹정보를 조회한다.
	 * @param param
	 * @return Map
	 */	
	public Map<String, ?> selectListStgpInfo(Map<String, ?> param) {		

		Map<String, Object> result = new HashMap<String, Object>();

		logger.debug("param ==> "+param);
		// search input column dataset
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");	
		logger.debug("inputDataSet ==>  " + inputDataSet);

		// search input column data
		logger.debug("inputData ==>  " + inputDataSet.get("STGP_CD"));		
		logger.debug("inputData ==>  " + inputDataSet.get("TRN_CLSF_CD"));
				
		//spring MVC Locale�뺤씤
		/*
		Locale locale1 = Locale.ENGLISH;
		Locale locale2 = Locale.KOREA;
		System.out.println(messageSource.getMessage("errors.sql.notexists", new Object[]{"TEST"}, locale1));
		System.out.println(messageSource.getMessage("errors.sql.notexists", new Object[]{"TEST"}, locale2));
		*/
		
		ArrayList<Map<String, Object>> resultList = (ArrayList) dao.list("com.korail.yz.yf.aa.YFAA001QMDAO.selectListStgpInfo", inputDataSet);

		//ArrayList<Map<String, Object>> listCnt = (ArrayList) dao.list("com.korail.tz.pl.YSAA001QMDAO.selectListCnt", inputDataSet);
		//return Query Result
		
		//페이징처리시..
/*		if(resultList.size() == Integer.parseInt(inputDataSet.get("PG_PR_CNT")))
		{
			inputDataSet.put("QRY_NUM_NEXT", String.valueOf(resultList.get(resultList.size()-1).get("QRY_NUM")));
		}else
		{
			inputDataSet.put("QRY_NUM_NEXT", "0");
		}
		inputDataSet.put("TOT_CNT", listCnt.get(0).get("TOT_CNT").toString());
		logger.debug("TOT_CNT =====> "+inputDataSet.get("TOT_CNT"));*/
		
		for(int i=0;i<resultList.size();i++)
		{
			logger.debug(resultList.get(i).toString());
		}
		
		//ArrayList<Map<String, String>> condList = new ArrayList<Map<String, String>>();
		/*condList.add(inputDataSet);
		result.put("dsCond", condList);
		
		logger.debug("dsCond ====>"+result.get("dsCond"));*/
		result.put("dsStgpInfoList", resultList);

		return result;

	}
}

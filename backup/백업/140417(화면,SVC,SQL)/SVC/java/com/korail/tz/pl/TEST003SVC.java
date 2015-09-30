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
 * Class description : (파일럿) 메뉴 목록을 조회하는 서비스
 */
@Service("com.korail.tz.pl.TEST003SVC")
public class TEST003SVC {

	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public  final Logger logger = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);

	/**
	 * @author 민지홍
	 * @date 2014. 3. 5. 오전 6:22:19
	 * Method description : 메뉴목록을 조회한다.
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectMenuList(Map<String, ?> param) {		

		Map<String, Object> result = new HashMap<String, Object>();

		logger.debug("param ==> "+param);
		// search input column dataset
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");	
		logger.debug("inputDataSet ==>  " + inputDataSet);
		
		ArrayList<Map<String, Object>> resultList = (ArrayList<Map<String, Object>>) dao.list("com.korail.tz.pl.YZPL003QMDAO.selectMenuList", inputDataSet);

		
		//return Query Result
		
		for(int i=0;i<resultList.size();i++)
		{
			logger.debug(resultList.get(i).toString());
		}
		
		inputDataSet.put("QRY_CNT", String.valueOf(resultList.size()));
		
		ArrayList<Map<String, String>> condList = new ArrayList<Map<String, String>>();
		condList.add(inputDataSet);
		
		result.put("dsCond", condList);
		result.put("dsMenuList", resultList);

		return result;

	}
	
}

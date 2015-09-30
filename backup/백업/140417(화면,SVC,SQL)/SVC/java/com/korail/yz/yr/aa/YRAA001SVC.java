/**
 * project : KORAIL_YZ
 * package : com.korail.yz.yb.co
 * date : 2014. 3. 11.오후 3:32:36
 */
package com.korail.yz.yr.aa;

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
 * @author "Changki.woo"
 * @date 2014. 3. 21. 오후 1:05:54
 * Class description : 
 */
@Service("com.korail.yz.yr.aa.YRAA001SVC")
public class YRAA001SVC {

	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public  final Logger logger = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
	
	
	  public static boolean isEmpty(String str) {
	      return str == null || str.length() == 0;
	  }
	
	
	  
	/**
	 * @author "Changki.woo"
	 * @date 2014. 3. 21. 오후 1:06:06
	 * Method description : 
	 * @param param
	 * @return
	 */
	public Map<String, ? > selectListTrnPrDatePrRunAcvm(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> getParamSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");
		
		ArrayList<Map<String, Object>> resultList = null;
		
		resultList = (ArrayList) dao.list("com.korail.yz.yr.aa.YRAA001QMDAO.selectListTrnPrDatePrRunAcvmQry", getParamSet);
		result.put("dsList", resultList);
		
		if(resultList.size() < 1)
		{
			XframeControllerUtils.setMessage("IZZ000010", result);
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result);
		}
		
		return result;
		
	}
}

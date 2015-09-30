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
 * @author SDS
 * @date 2014. 3. 14. 오후 5:19:21
 * Class description : 
 */
@Service("com.korail.yz.yr.aa.YRAA007SVC")
public class YRAA007SVC {

	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public  final Logger logger = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
	
	
	  public static boolean isEmpty(String str) {
	      return str == null || str.length() == 0;
	  }
	
	
	/**
	 * @author Changki.woo
	 * @date 2014. 3. 14. 오후 5:20:50
	 * Method description : 입석자유석실적조회 SVC
	 * @param param
	 * @return Map
	 */
	public Map<String, ? > selectListAcvm(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> getParamSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");
		
		//srchType == "0" 이면 일자별
		//srchType == "1" 이면 열차별
		String srchType = getParamSet.get("DATE_TRN_SRCH_FLG");
		
		ArrayList<Map<String, Object>> resultList = null;
		
		if(("0").equals(srchType))
		{
			 resultList = (ArrayList) dao.list("com.korail.yz.yr.aa.YRAA007QMDAO.selectListAcvmByDateQry", getParamSet);
			 result.put("dsListByDate", resultList);
		}
		else
		{
			resultList = (ArrayList) dao.list("com.korail.yz.yr.aa.YRAA007QMDAO.selectListAcvmByTrnQry", getParamSet);
			result.put("dsListByTrn", resultList);
		}
		
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

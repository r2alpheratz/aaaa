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
 * @date 2014. 4. 13. 오후 4:42:19
 * Class description : 구간통과율열차별조회SVC
 */
@Service("com.korail.yz.yr.aa.YRAA009SVC")
public class YRAA009SVC {

	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public  final Logger logger = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
	
	/**
	 * @author "Changki.woo"
	 * @date 2014. 4. 13. 오후 4:42:58
	 * Method description : 
	 * @param param
	 * @return
	 */
	public Map<String, ? > selectListSegPassRtTrnPr(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> getParamSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");
		
		ArrayList<Map<String, Object>> resultList = null;
		ArrayList<Map<String, Object>> resultListForCht = null;
		
		resultList = (ArrayList) dao.list("com.korail.yz.yr.aa.YRAA009QMDAO.selectListSegPassRtTrnPrQry", getParamSet);
		result.put("dsList", resultList);
		
		resultListForCht = (ArrayList) dao.list("com.korail.yz.yr.aa.YRAA009QMDAO.selectListSegPassRtTrnPrChtQry", getParamSet);
		result.put("dsCht", resultListForCht);
		
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

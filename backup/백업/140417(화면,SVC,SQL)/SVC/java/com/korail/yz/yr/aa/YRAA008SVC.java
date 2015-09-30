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
 * @date 2014. 4. 11. 오후 5:54:24
 * Class description : 입석자유석 잔여석실적조회
 */
@Service("com.korail.yz.yr.aa.YRAA008SVC")
public class YRAA008SVC {

	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public  final Logger logger = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
	
	/**
	 * @author "Changki.woo"
	 * @date 2014. 4. 11. 오후 5:57:08
	 * Method description : 입석자유석 잔여석실적조회 SVC
	 * @param param
	 * @return
	 */
	public Map<String, ? > selectListRestSeatAcvmByDate(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> getParamSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");
		
		ArrayList<Map<String, Object>> resultList = null;
		
		resultList = (ArrayList) dao.list("com.korail.yz.yr.aa.YRAA008QMDAO.selectListRestSeatAcvmByDateQry", getParamSet);
		result.put("dsListByDate", resultList);
		
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
	
	public Map<String, ? > selectListRestSeatAcvmByTrn(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> getParamSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");
		
		ArrayList<Map<String, Object>> resultList = null;
		
		resultList = (ArrayList) dao.list("com.korail.yz.yr.aa.YRAA008QMDAO.selectListRestSeatAcvmByTrnQry", getParamSet);
		
		result.put("dsListByTrn", resultList);
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

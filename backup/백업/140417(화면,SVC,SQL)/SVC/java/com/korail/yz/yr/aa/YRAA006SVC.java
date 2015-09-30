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
 * @date 2014. 4. 9. 오후 4:38:25
 * Class description : 일별 운행실적 조회
 */
@Service("com.korail.yz.yr.aa.YRAA006SVC")
public class YRAA006SVC {

	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public  final Logger logger = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
	
	/**
	 * @author "Changki.woo"
	 * @date 2014. 4. 9. 오후 4:40:00
	 * Method description : 일별 운행실적 조회
	 * @param param
	 * @return
	 */
	public Map<String, ? > selectListDatePrRunAcvm(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> getParamSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");
		
		ArrayList<Map<String, Object>> resultList = null;
		
		resultList = (ArrayList) dao.list("com.korail.yz.yr.aa.YRAA006QMDAO.selectListDatePrRunAcvmQry", getParamSet);
		if(resultList.size() < 1){
			result.put("dsList", resultList);
			XframeControllerUtils.setMessage("IZZ000010", result);
			return result;
		}
		
		result.put("dsList", resultList);
		XframeControllerUtils.setMessage("IZZ000009", result);
		return result;	
	}
	
	/**
	 * @author "Changki.woo"
	 * @date 2014. 4. 9. 오후 4:51:08
	 * Method description : 일별 운행구간별 운행실적 조회
	 * @param param
	 * @return
	 */
	public Map<String, ? > selectListDatePrRunSegPrAcvm(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> getParamSet = XframeControllerUtils	.getParamDataSet(param, "dsCond2");
		
		ArrayList<Map<String, Object>> resultList = null;
		
		resultList = (ArrayList) dao.list("com.korail.yz.yr.aa.YRAA006QMDAO.selectListDatePrRunSegPrAcvmQry", getParamSet);
		if(resultList.size() < 1){
			result.put("dsListByRunSeg", resultList);
			XframeControllerUtils.setMessage("IZZ000010", result);
			return result;
		}
		
		result.put("dsListByRunSeg", resultList);
		XframeControllerUtils.setMessage("IZZ000009", result);
		return result;	
	}
	
}

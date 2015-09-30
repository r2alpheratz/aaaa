/**
 * project : KORAIL_YZ
 * package : com.korail.yz.yb.co
 * date : 2014. 3. 11.오후 3:32:36
 */
package com.korail.yz.yr.ad;

import java.util.HashMap;
import java.util.List;
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
 * @date 2014. 6. 03. 오전 10:12:40
 *  * Class description : 시간대별 실적조회SVC - YRAD002_S01
 */
@Service("com.korail.yz.yr.ad.YRAD002SVC")
public class YRAD002SVC {

	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public  final Logger logger = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
	
	/**
	 * @author "Changki.woo"
	 * @date 2014. 6. 03. 오전 10:12:40
	 * Method description : 시간대별 실적조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ? > selectListTimePrAcvm(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> getParamSetStd  = XframeControllerUtils	.getParamDataSet(param, "dsCond");
		Map<String, String> getParamSetComp = XframeControllerUtils	.getParamDataSet(param, "dsCond2");		
		
		List<Map<String, Object>> resultListStd = null;
		List<Map<String, Object>> resultListComp = null;
		
		String svcUrl = "com.korail.yz.yr.ad.YRAD002QMDAO.selectListTimePrAcvmQry";
		
		resultListStd  = (List<Map<String, Object>>) dao.list(svcUrl, getParamSetStd);
		resultListComp = (List<Map<String, Object>>) dao.list(svcUrl, getParamSetComp);
		
		result.put("dsListStd", resultListStd);
		result.put("dsListComp", resultListComp);		
		
		if(resultListStd.isEmpty() || resultListComp.isEmpty())
		{
			XframeControllerUtils.setMessage("IZZ000004", result); //해당 조건의 자료가 존재하지 않습니다.
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result);
		}
		
		return result;
		
	}
}

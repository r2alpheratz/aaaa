/**
 * project : KORAIL_YZ
 * package : com.korail.yz.yb.co
 * date : 2014. 3. 11.오후 3:32:36
 */
package com.korail.yz.yr.ba;

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
 * @date 2014. 7. 1. 오후 5:15:48
 * Class description : 열차별 반복실적 비교
 */
@Service("com.korail.yz.yr.ba.YRBA004SVC")
public class YRBA004SVC {

	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public  final Logger logger = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
	
	/**
	 * @author "Changki.woo"
	 * @date 2014. 7. 1. 오후 5:28:45
	 * Method description : 열차별 반복실적 비교
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ? > selectListTrnPrRptAcvmComp(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		Map<String, String> getParamSet  = XframeControllerUtils.getParamDataSet(param, "dsCond");
		Map<String, String> getParamSet2  = XframeControllerUtils.getParamDataSet(param, "dsCond2");
		
		List<Map<String, Object>> resultList = null;
		List<Map<String, Object>> resultList2 = null;		
		
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		getParamSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		getParamSet2.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		
		String svcUrl = "com.korail.yz.yr.ba.YRBA004QMDAO.selectListTrnPrRptAcvmCompQry";
		
		resultList  = (List<Map<String, Object>>) dao.list(svcUrl, getParamSet);
		resultList2 = (List<Map<String, Object>>) dao.list(svcUrl, getParamSet2);		
		
		result.put("dsList",  resultList);		
		result.put("dsList2", resultList2);
		
		if(resultList.isEmpty() && resultList2.isEmpty())
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
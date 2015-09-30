/**
 * project : KORAIL_YZ
 * package : com.korail.yz.yb.co
 * date : 2014. 3. 11.오후 3:32:36
 */
package com.korail.yz.yr.aa;

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
 * @date 2014. 4. 17. 오후 3:24:07
 * Class description : 구간통과율운행일별조회SVC
 */
@Service("com.korail.yz.yr.aa.YRAA010SVC")
public class YRAA010SVC {

	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public  final Logger logger = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
	
	/**
	 * @author "Changki.woo"
	 * @date 2014. 4. 17. 오후 3:24:21
	 * Method description : 
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ? > selectListSegPassRtRunTrmPr(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> getParamSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");
		/* 열차운영사업자구분코드 추가 */
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		getParamSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		List<Map<String, Object>> resultList = null;
		List<Map<String, Object>> resultListForCht = null;
		
		resultList = (List<Map<String, Object>>) dao.list("com.korail.yz.yr.aa.YRAA010QMDAO.selectListSegPassRtRunTrmPrQry", getParamSet);
		result.put("dsList", resultList);
		
		resultListForCht = (List<Map<String, Object>>) dao.list("com.korail.yz.yr.aa.YRAA010QMDAO.selectListSegPassRtRunTrmPrForChtQry", getParamSet);
		result.put("dsCht", resultListForCht);
		
		if(resultList.isEmpty())
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

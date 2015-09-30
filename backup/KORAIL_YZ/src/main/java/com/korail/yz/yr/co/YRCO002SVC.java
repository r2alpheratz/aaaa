/**
 * project : KORAIL_YZ
 * package : com.korail.yz.yb.co
 * date : 2014. 3. 11.오후 3:32:36
 */
package com.korail.yz.yr.co;

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
 * @date 2014. 5. 12. 오후 7:16:14
 * Class description : 실적관리 공통 SVC 모음
 */
@Service("com.korail.yz.yr.co.YRCO002SVC")
public class YRCO002SVC {

	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public  final Logger logger = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
	
	/**
	 * @author "Changki.woo"
	 * @date 2014. 5. 12. 오후 7:16:30
	 * Method description : 구역구간그룹 정보 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ? > selectListSegGpInf(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Object isDsCondGrd =  param.get("dsCondGrd");
		Object isDsCondGrd2 =  param.get("dsCondGrd2");
		Object isDsCondGrd3 =  param.get("dsCondGrd3");			

		ArrayList<Map<String, Object>> resultList = null;
		String url ="com.korail.yz.yr.co.YRCO002QMDAO.selectListSegGpInfQry";
		/* 열차운영사업자구분코드 추가 */
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		
		if(isDsCondGrd != null)
		{
			Map<String, String> getParamSet = XframeControllerUtils.getParamDataSet(param, "dsCondGrd");
			getParamSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
			resultList = (ArrayList<Map<String, Object>>) dao.list(url, getParamSet);
			result.put("dsSegGpInf", resultList);
		}
		
		if(isDsCondGrd2 != null)
		{
			Map<String, String> getParamSet = XframeControllerUtils.getParamDataSet(param, "dsCondGrd2");
			getParamSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
			resultList = (ArrayList<Map<String, Object>>) dao.list(url, getParamSet);
			result.put("dsSegGpInf2", resultList);
		}
		
		if(isDsCondGrd3 != null)
		{
			Map<String, String> getParamSet = XframeControllerUtils.getParamDataSet(param, "dsCondGrd3");
			getParamSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
			resultList = (ArrayList<Map<String, Object>>) dao.list(url, getParamSet);
			result.put("dsSegGpInf3", resultList);
		}
		
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
	
	
	/**
	 * @author "Changki.woo"
	 * @date 2014. 5. 12. 오후 7:20:44
	 * Method description : 정차역별구역 정보 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ? > selectListStgpSegInf(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Object isDsCondGrd =  param.get("dsCondGrd");
		Object isDsCondGrd2 =  param.get("dsCondGrd2");
		Object isDsCondGrd3 =  param.get("dsCondGrd3");		

		ArrayList<Map<String, Object>> resultList = null;
		String url = "com.korail.yz.yr.co.YRCO002QMDAO.selectListStgpSegInfQry";
		
		/* 열차운영사업자구분코드 추가 */
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		if(isDsCondGrd != null)
		{
			Map<String, String> getParamSet = XframeControllerUtils.getParamDataSet(param, "dsCondGrd");
			getParamSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
			resultList = (ArrayList<Map<String, Object>>) dao.list(url, getParamSet);
			result.put("dsStgpSegInf", resultList);
		}
		
		if(isDsCondGrd2 != null)
		{
			Map<String, String> getParamSet = XframeControllerUtils.getParamDataSet(param, "dsCondGrd2");
			getParamSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
			resultList = (ArrayList<Map<String, Object>>) dao.list(url, getParamSet);
			result.put("dsStgpSegInf2", resultList);
		}
		
		if(isDsCondGrd3 != null)
		{
			Map<String, String> getParamSet = XframeControllerUtils.getParamDataSet(param, "dsCondGrd3");
			getParamSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
			resultList = (ArrayList<Map<String, Object>>) dao.list(url, getParamSet);
			result.put("dsStgpSegInf3", resultList);
			
		}
		return result;
		
	}
}

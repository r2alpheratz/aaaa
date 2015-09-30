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
 * @date 2014. 4. 1. 오후 5:32:04
 * Class description : 운행일별 운행실적 SERVICE
 */
@Service("com.korail.yz.yr.aa.YRAA003SVC")
public class YRAA003SVC {

	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public  final Logger logger = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
	
	//객실등급FLG 컬럼명 Final처리
	private static String psrmGrdFlgColNm = "PSRM_GRD_FLG";
	
	  
	/**
	 * @author "Changki.woo"
	 * @date 2014. 4. 1. 오후 5:32:09
	 * Method description : 운행일별 운행실적 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ? > selectListAcvm(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> getParamSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");
		/* 열차운영사업자구분코드 추가 */
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		getParamSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		List<Map<String, Object>> resultList = null;
		
		String PsrmGrdFlg = getParamSet.get( psrmGrdFlgColNm );
		
		
		if("Y".equals(PsrmGrdFlg ))
		{
			resultList = (List<Map<String, Object>>) dao.list("com.korail.yz.yr.aa.YRAA003QMDAO.selectListAcvmPsrnGrdQry", getParamSet);
			result.put("dsListByPsrmGrd", resultList);
			result.put("dsListByPsrmGrdCht", resultList);
		}
		else
		{
			resultList = (List<Map<String, Object>>) dao.list("com.korail.yz.yr.aa.YRAA003QMDAO.selectListAcvmQry", getParamSet);
			result.put("dsList", resultList);
			result.put("dsListCht", resultList);
		}
		
		if(resultList.size() < 1)
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

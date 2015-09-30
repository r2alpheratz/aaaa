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
	private final String PsrmGrdFlgColNm = "PSRM_GRD_FLG";
	
	  
	/**
	 * @author "Changki.woo"
	 * @date 2014. 4. 1. 오후 5:32:09
	 * Method description : 운행일별 운행실적 조회
	 * @param param
	 * @return
	 */
	public Map<String, ? > selectListAcvm(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> getParamSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");
		
		ArrayList<Map<String, Object>> resultList = null;
		
		String PsrmGrdFlg = getParamSet.get( PsrmGrdFlgColNm );
		
		
		if("Y".equals(PsrmGrdFlg ))
		{
			resultList = (ArrayList) dao.list("com.korail.yz.yr.aa.YRAA003QMDAO.selectListAcvmPsrnGrdQry", getParamSet);
			result.put("dsListByPsrmGrd", resultList);
			result.put("dsListByPsrmGrdCht", resultList);
		}
		else
		{
			resultList = (ArrayList) dao.list("com.korail.yz.yr.aa.YRAA003QMDAO.selectListAcvmQry", getParamSet);
			result.put("dsList", resultList);
			result.put("dsListCht", resultList);
		}
		
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

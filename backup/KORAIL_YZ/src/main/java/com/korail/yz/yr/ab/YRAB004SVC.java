
/**
 * project : KORAIL_YZ
 * package : com.korail.yz.yb.co
 * date : 2014. 3. 11.오후 3:32:36
 */
package com.korail.yz.yr.ab;

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
 * @date 2014. 5. 7. 오전 11:44:04
 * Class description : 운행일별예측수요조회SVC
 */
@Service("com.korail.yz.yr.ab.YRAB004SVC")
public class YRAB004SVC {

	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public  final Logger logger = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
	
	/**
	 * @author "Changki.woo"
	 * @date 2014. 5. 7. 오전 11:44:20
	 * Method description : 운행일별예측수요실적조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ? > selectListFcstDmdFearAcvmRunDtPr(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> getParamSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");
		
		List<Map<String, Object>> resultList = null;
		
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		getParamSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		
		resultList = (List<Map<String, Object>>) dao.list("com.korail.yz.yr.ab.YRAB004QMDAO.selectListFcstDmdFearAcvmRunDtPrQry", getParamSet);
		result.put("dsList", resultList);
		
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
	 * @date 2014. 5. 7. 오전 11:44:20
	 * Method description : 운행일별예측수요실적(객실/할인등급포함) 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ? > selectListFcstDmdFearAcvmRunDtPrPsrmBkcl(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> getParamSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");
		
		List<Map<String, Object>> resultList = null;
		
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		getParamSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		
		resultList = (List<Map<String, Object>>) dao.list("com.korail.yz.yr.ab.YRAB004QMDAO.selectListFcstDmdFearAcvmRunDtPrPsrmBkclQry", getParamSet);
		result.put("dsList", resultList);
		
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
	 * @date 2014. 5. 7. 오전 11:44:20
	 * Method description : 운행일별예측수요실적(객실/할인등급포함) 차트조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ? > selectListFcstDmdFearAcvmRunDtPrCht(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> getParamSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");
		
		List<Map<String, Object>> resultList = null;
		
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		getParamSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		
		String url = "com.korail.yz.yr.ab.YRAB004QMDAO.selectListFcstDmdFearAcvmRunDtPrChtQry";
		if("true".equals(getParamSet.get("useSEG_GP_NO")))
		{
			url = "com.korail.yz.yr.ab.YRAB004QMDAO.selectListFcstDmdFearAcvmRunDtPrChtSegGpNoQry";
		}
		
		resultList = (List<Map<String, Object>>) dao.list(url, getParamSet);		
		result.put("dsCht", resultList);
		
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
	 * @date 2014. 5. 7. 오전 11:44:20
	 * Method description : 운행일별예측수요실적(객실/할인등급포함) 차트조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ? > selectListFcstDmdFearAcvmRunDtPrPsrmBkclCht(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> getParamSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");
		
		List<Map<String, Object>> resultList = null;
		
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		getParamSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		
		resultList = (List<Map<String, Object>>) dao.list("com.korail.yz.yr.ab.YRAB004QMDAO.selectListFcstDmdFearAcvmRunDtPrPsrmBkclChtQry", getParamSet);		
		result.put("dsCht", resultList);
		
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

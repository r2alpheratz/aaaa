/**
 * project : KORAIL_YZ
 * package : com.korail.yz.yb.co
 * date : 2014. 3. 11.오후 3:32:36
 */
package com.korail.yz.yr.ab;

import java.util.List;
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
 * @date 2014. 4. 23. 오후 2:31:03
 * Class description : 열차별예측수요실적(운임포함)조회SVC - YRAB001_S01
 */
@Service("com.korail.yz.yr.ab.YRAB002SVC")
public class YRAB002SVC {

	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public  final Logger logger = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
	
	/**
	 * @author "Changki.woo"
	 * @date 2014. 4. 23. 오후 2:31:25
	 * Method description : 열차별예측수요실적(운임포함)조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ? > selectListFcstDmdFearAcvm(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> getParamSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");
		
		List<Map<String, Object>> resultList = null;
		
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		getParamSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		
		resultList = (List<Map<String, Object>>) dao.list("com.korail.yz.yr.ab.YRAB002QMDAO.selectListFcstDmdFearAcvmQry", getParamSet);
		result.put("dsListFear", resultList);
		
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
	 * @date 2014. 4. 23. 오후 8:07:05
	 * Method description : 열차별예측수요실적(운임포함)조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ? > selectListFcstDmdFearAcvmPsrmBkcl(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> getParamSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");
		
		List<Map<String, Object>> resultList = null;
		
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		getParamSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		
		resultList = (List<Map<String, Object>>) dao.list("com.korail.yz.yr.ab.YRAB002QMDAO.selectListFcstDmdFearAcvmWithPsrmBkclQry", getParamSet);
		result.put("dsListFear", resultList);
		
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
	 * @date 2014. 4. 28. 오후 8:07:05
	 * Method description : 열차별예측수요실적 열차목록 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ? > selectListFcstDmdFearAcvmPsrmBkclTrnList(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> getParamSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");
		
		List<Map<String, Object>> resultList = null;
		
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		getParamSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		
		resultList = (List<Map<String, Object>>) dao.list("com.korail.yz.yr.ab.YRAB002QMDAO.selectListFcstDmdFearAcvmWithPsrmBkclTrnListQry", getParamSet);
		result.put("dsTrnList", resultList);
		
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
	 * @date 2014. 4. 28. 오후 8:07:05
	 * Method description : 열차별예측수요실적(운임포함) 차트조회 
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ? > selectListFcstDmdFearAcvmCht(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> getParamSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");
		
		List<Map<String, Object>> resultList = null;
		
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		getParamSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		
		resultList = (List<Map<String, Object>>) dao.list("com.korail.yz.yr.ab.YRAB002QMDAO.selectListFcstDmdFearAcvmChtQry", getParamSet);
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
	 * @date 2014. 4. 28. 오후 8:07:05
	 * Method description : 열차별예측수요실적(운임포함) 차트조회 - 객실/할인등급조회 
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ? > selectListFcstDmdFearAcvmPsrmBkclCht(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> getParamSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");
		
		List<Map<String, Object>> resultList = null;
		
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		getParamSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		
		resultList = (List<Map<String, Object>>) dao.list("com.korail.yz.yr.ab.YRAB002QMDAO.selectListFcstDmdFearAcvmWithPsrmBkclChtQry", getParamSet);
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

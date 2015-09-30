/**
 * project : KORAIL_YZ
 * package : com.korail.yz.yb.co
 * date : 2014. 3. 11.오후 3:32:36
 */
package com.korail.yz.yr.cb;

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
 * @date 2014. 7. 30. 오후 2:21:39
 * Class description : 실적 비교 평가
 */
@Service("com.korail.yz.yr.cb.YRCB001SVC")
public class YRCB001SVC {

	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public  final Logger logger = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
	
	/**
	 * @author "Changki.woo"
	 * @date 2014. 7. 30. 오후 2:21:52
	 * Method description : 실적 비교 평가 - 운행일별
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ? > selectListRunDtPrAcvmComp(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> getParamStdSet = null;
		Map<String, String> getParamCompSet = null;
		
		List<Map<String, Object>> resultListStd = null;
		List<Map<String, Object>> resultListComp = null;		
		
		//열차운영사업자구분코드 추가
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		
		String svcUrl = "com.korail.yz.yr.cb.YRCB001QMDAO.selectListRunDtPrAcvmCompQry";
		
		if( param.containsKey("dsCondStd") )
		{
			getParamStdSet  = XframeControllerUtils.getParamDataSet(param, "dsCondStd");
			getParamStdSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
			resultListStd = (List<Map<String, Object>>) dao.list(svcUrl, getParamStdSet);
			result.put("dsListStd", resultListStd);
			
			if( resultListStd.isEmpty())
			{
				XframeControllerUtils.setMessage("IZZ000004", result); //해당 조건의 자료가 존재하지 않습니다.
			}
			else
			{
				XframeControllerUtils.setMessage("IZZ000009", result);
			}
		}
		
		if( param.containsKey("dsCondComp") )
		{
			getParamCompSet  = XframeControllerUtils.getParamDataSet(param, "dsCondComp");
			getParamCompSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
			resultListComp = (List<Map<String, Object>>) dao.list(svcUrl, getParamCompSet);
			result.put("dsListComp", resultListComp);
			
			if( resultListComp.isEmpty())
			{
				XframeControllerUtils.setMessage("IZZ000004", result); //해당 조건의 자료가 존재하지 않습니다.
			}
			else
			{
				XframeControllerUtils.setMessage("IZZ000009", result);
			}
		}		
		
		return result;	
	}
	
	
	/**
	 * @author "Changki.woo"
	 * @date 2014. 7. 30. 오후 2:21:52
	 * Method description : 실적 비교 평가 - 요일별
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ? > selectListDayPrAcvmComp(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> getParamStdSet = null;
		Map<String, String> getParamCompSet = null;
		
		List<Map<String, Object>> resultListStd = null;
		List<Map<String, Object>> resultListComp = null;		
		
		//열차운영사업자구분코드 추가
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
				
		String svcUrl = "com.korail.yz.yr.cb.YRCB001QMDAO.selectListDayPrAcvmCompQry";
		
		if( param.containsKey("dsCondStd") )
		{
			getParamStdSet  = XframeControllerUtils.getParamDataSet(param, "dsCondStd");
			getParamStdSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
			resultListStd = (List<Map<String, Object>>) dao.list(svcUrl, getParamStdSet);
			result.put("dsListStd", resultListStd);
			
			if( resultListStd.isEmpty())
			{
				XframeControllerUtils.setMessage("IZZ000004", result); //해당 조건의 자료가 존재하지 않습니다.
			}
			else
			{
				XframeControllerUtils.setMessage("IZZ000009", result);
			}
		}
		
		if( param.containsKey("dsCondComp") )
		{
			getParamCompSet  = XframeControllerUtils.getParamDataSet(param, "dsCondComp");
			getParamCompSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
			resultListComp = (List<Map<String, Object>>) dao.list(svcUrl, getParamCompSet);
			result.put("dsListComp", resultListComp);
			
			if( resultListComp.isEmpty() )
			{
				XframeControllerUtils.setMessage("IZZ000004", result); //해당 조건의 자료가 존재하지 않습니다.
			}
			else
			{
				XframeControllerUtils.setMessage("IZZ000009", result);
			}
		}		
		
		return result;	
	}
	
	/**
	 * @author "Changki.woo"
	 * @date 2014. 7. 30. 오후 2:21:52
	 * Method description : 실적 비교 평가 - 열차별
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ? > selectListTrnNoPrAcvmComp(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> getParamStdSet = null;
		Map<String, String> getParamCompSet = null;
		
		List<Map<String, Object>> resultListStd = null;
		List<Map<String, Object>> resultListComp = null;		
		
		//열차운영사업자구분코드 추가
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		
		String svcUrl = "com.korail.yz.yr.cb.YRCB001QMDAO.selectListTrnNoPrAcvmCompQry";
		
		if( param.containsKey("dsCondStd") )
		{
			getParamStdSet  = XframeControllerUtils.getParamDataSet(param, "dsCondStd");
			getParamStdSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
			resultListStd = (List<Map<String, Object>>) dao.list(svcUrl, getParamStdSet);
			result.put("dsListStd", resultListStd);
			
			if( resultListStd.isEmpty())
			{
				XframeControllerUtils.setMessage("IZZ000004", result); //해당 조건의 자료가 존재하지 않습니다.
			}
			else
			{
				XframeControllerUtils.setMessage("IZZ000009", result);
			}
		}
		
		if( param.containsKey("dsCondComp") )
		{
			getParamCompSet  = XframeControllerUtils.getParamDataSet(param, "dsCondComp");
			getParamCompSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
			resultListComp = (List<Map<String, Object>>) dao.list(svcUrl, getParamCompSet);
			result.put("dsListComp", resultListComp);
			
			if( resultListComp.isEmpty() )
			{
				XframeControllerUtils.setMessage("IZZ000004", result); //해당 조건의 자료가 존재하지 않습니다.
			}
			else
			{
				XframeControllerUtils.setMessage("IZZ000009", result);
			}
		}		
		
		return result;	
	}
	
	/**
	 * @author "Changki.woo"
	 * @date 2014. 7. 30. 오후 2:21:52
	 * Method description : 실적 비교 평가 - 시간대별
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ? > selectListDptTmPrAcvmComp(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> getParamStdSet = null;
		Map<String, String> getParamCompSet = null;
		
		List<Map<String, Object>> resultListStd = null;
		List<Map<String, Object>> resultListComp = null;		
		
		//열차운영사업자구분코드 추가
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
				
		String svcUrl = "com.korail.yz.yr.cb.YRCB001QMDAO.selectListDptTmPrAcvmCompQry";
		
		if( param.containsKey("dsCondStd") )
		{
			getParamStdSet  = XframeControllerUtils.getParamDataSet(param, "dsCondStd");
			getParamStdSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
			resultListStd = (List<Map<String, Object>>) dao.list(svcUrl, getParamStdSet);
			result.put("dsListStd", resultListStd);
			
			if( resultListStd.isEmpty() )
			{
				XframeControllerUtils.setMessage("IZZ000004", result); //해당 조건의 자료가 존재하지 않습니다.
			}
			else
			{
				XframeControllerUtils.setMessage("IZZ000009", result);
			}
		}
		
		if( param.containsKey("dsCondComp") )
		{
			getParamCompSet  = XframeControllerUtils.getParamDataSet(param, "dsCondComp");
			getParamCompSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
			resultListComp = (List<Map<String, Object>>) dao.list(svcUrl, getParamCompSet);
			result.put("dsListComp", resultListComp);
			
			if( resultListComp.isEmpty() )
			{
				XframeControllerUtils.setMessage("IZZ000004", result); //해당 조건의 자료가 존재하지 않습니다.
			}
			else
			{
				XframeControllerUtils.setMessage("IZZ000009", result);
			}
		}		
		
		return result;	
	}
	
	/**
	 * @author "Changki.woo"
	 * @date 2014. 7. 30. 오후 2:21:52
	 * Method description : 실적 비교 평가 - 총량
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ? > selectListAmountPrAcvmComp(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> getParamStdSet = null;
		Map<String, String> getParamCompSet = null;
		
		List<Map<String, Object>> resultListStd = null;
		List<Map<String, Object>> resultListComp = null;		
		
		String svcUrl = "com.korail.yz.yr.cb.YRCB001QMDAO.selectListAmountPrAcvmCompQry";
		//열차운영사업자구분코드 추가
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		
		if( param.containsKey("dsCondStd") )
		{
			getParamStdSet  = XframeControllerUtils.getParamDataSet(param, "dsCondStd");
			getParamStdSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
			resultListStd = (List<Map<String, Object>>) dao.list(svcUrl, getParamStdSet);
			result.put("dsListStd", resultListStd);
			
			if( resultListStd.isEmpty() )
			{
				XframeControllerUtils.setMessage("IZZ000004", result); //해당 조건의 자료가 존재하지 않습니다.
			}
			else
			{
				XframeControllerUtils.setMessage("IZZ000009", result);
			}
		}
		
		if( param.containsKey("dsCondComp") )
		{
			getParamCompSet  = XframeControllerUtils.getParamDataSet(param, "dsCondComp");
			getParamCompSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
			resultListComp = (List<Map<String, Object>>) dao.list(svcUrl, getParamCompSet);
			result.put("dsListComp", resultListComp);
			
			if( resultListComp.isEmpty() )
			{
				XframeControllerUtils.setMessage("IZZ000004", result); //해당 조건의 자료가 존재하지 않습니다.
			}
			else
			{
				XframeControllerUtils.setMessage("IZZ000009", result);
			}
		}		
		
		return result;	
	}
	
	
}
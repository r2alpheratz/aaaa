/**
 * project : KORAIL_YZ
 * package : com.korail.yz.yb.co
 * date : 2014. 3. 11.오후 3:32:36
 */
package com.korail.yz.yr.ca;

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
 * @date 2014. 7. 18. 오후 1:33:44
 * Class description : 열차, 운행일별 승차유형별 발매실적
 */
@Service("com.korail.yz.yr.ca.YRCA003SVC")
public class YRCA003SVC {

	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public  final Logger logger = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
	
	/**
	 * @author "Changki.woo"
	 * @date 2014. 7. 18. 오후 1:33:44
	 * Method description : 열차별 승차유형별 발매실적조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ? > selectListTrnPrAbrdSaleAcvm(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> getParamSet = null;
		
		if(param.containsKey("dsCond2"))
		{
			getParamSet  = XframeControllerUtils.getParamDataSet(param, "dsCond2");
		}
		if(param.containsKey("dsCond"))
		{
			getParamSet  = XframeControllerUtils.getParamDataSet(param, "dsCond");
		}
		
		List<Map<String, Object>> resultList = null;
		
		String svcUrl = "com.korail.yz.yr.ca.YRCA003QMDAO.selectListTrnPrAbrdSaleAcvmQry";
		
		resultList = (List<Map<String, Object>>) dao.list(svcUrl, getParamSet);
		
		if(param.containsKey("dsCond2"))
		{
			result.put("dsList2", resultList);
		}
		if(param.containsKey("dsCond"))
		{
			result.put("dsList", resultList);
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
	 * @date 2014. 7. 16. 오전 10:14:31
	 * Method description : 열차별 승차유형별(객실등급,할인등급 포함) 발매실적조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ? > selectListTrnPrAbrdSalePsrmBkclAcvm(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> getParamSet = null;
		
		if(param.containsKey("dsCond2"))
		{
			getParamSet  = XframeControllerUtils.getParamDataSet(param, "dsCond2");
		}
		if(param.containsKey("dsCond"))
		{
			getParamSet  = XframeControllerUtils.getParamDataSet(param, "dsCond");
		}
		
		List<Map<String, Object>> resultList = null;
		
		String svcUrl = "com.korail.yz.yr.ca.YRCA003QMDAO.selectListTrnPrAbrdSalePsrmBkclAcvmQry";
		
		resultList = (List<Map<String, Object>>) dao.list(svcUrl, getParamSet);
		
		if(param.containsKey("dsCond2"))
		{
			result.put("dsList2Psrm", resultList);
		}	
		/*YRCA003_P01차트 그릴떄 사용*/
		if(param.containsKey("dsCond"))
		{
			result.put("dsList", resultList);
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
	 * @date 2014. 7. 18. 오후 1:43:15
	 * Method description : 운행일별 승차유형별 발매실적 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ? > selectListRunDtPrAbrdSaleAcvm(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> getParamSet = null;
		
		if(param.containsKey("dsCondCht"))
		{
			getParamSet  = XframeControllerUtils.getParamDataSet(param, "dsCondCht");
		}
		if(param.containsKey("dsCond"))
		{
			getParamSet  = XframeControllerUtils.getParamDataSet(param, "dsCond");
		}
		
		List<Map<String, Object>> resultList = null;
		
		String svcUrl = "com.korail.yz.yr.ca.YRCA003QMDAO.selectListRunDtPrAbrdSaleAcvmQry";
		
		resultList = (List<Map<String, Object>>) dao.list(svcUrl, getParamSet);
		
		//2014.07.22 우창기 추가. 차트용
		if(param.containsKey("dsCondCht"))
		{
			result.put("dsListCht", resultList);
		}
		if(param.containsKey("dsCond"))
		{
			result.put("dsList", resultList);
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
	 * @date 2014. 7. 18. 오후 1:43:15
	 * Method description : 운행일별 승차유형별(객실등급 할인등급 포함) 발매실적 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ? > selectListRunDtPrAbrdSalePsrmBkclAcvm(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> getParamSet = null;
		
		if(param.containsKey("dsCondCht"))
		{
			getParamSet  = XframeControllerUtils.getParamDataSet(param, "dsCondCht");
		}
		if(param.containsKey("dsCond"))
		{
			getParamSet  = XframeControllerUtils.getParamDataSet(param, "dsCond");	
		}
		
		List<Map<String, Object>> resultList = null;
		
		String svcUrl = "com.korail.yz.yr.ca.YRCA003QMDAO.selectListRunDtPrAbrdSalePsrmBkclAcvmQry";
		
		resultList = (List<Map<String, Object>>) dao.list(svcUrl, getParamSet);
		
		//2014.07.22 우창기 추가. 차트용
		if(param.containsKey("dsCondCht"))
		{
			result.put("dsListCht", resultList);
		}
		if(param.containsKey("dsCond"))
		{
			result.put("dsListPsrm", resultList);
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
	 * @date 2014. 7. 21. 오후 5:01:50
	 * Method description : 열차번호목록 조회(차트)
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ? > selectListTrnNoInfoCht(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> getParamSet  = XframeControllerUtils.getParamDataSet(param, "dsCond");
		
		List<Map<String, Object>> resultList = null;
		
		String svcUrl = "com.korail.yz.yr.ca.YRCA003QMDAO.selectListTrnNoInfoCht";
		
		resultList = (List<Map<String, Object>>) dao.list(svcUrl, getParamSet);
		
		result.put("dsTrnNoInfo", resultList);
		
		
		return result;	
	}
	
	/**
	 * @author "Changki.woo"
	 * @date 2014. 7. 21. 오후 5:01:50
	 * Method description : 운행구간목록 조회(차트)
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ? > selectListRunInfoCht(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> getParamSet  = XframeControllerUtils.getParamDataSet(param, "dsCondCht");
		
		List<Map<String, Object>> resultList = null;
		
		String svcUrl = "com.korail.yz.yr.ca.YRCA003QMDAO.selectListRunInfoCht";
		
		resultList = (List<Map<String, Object>>) dao.list(svcUrl, getParamSet);
		result.put("dsRunInfoList", resultList);
		
		
		return result;	
	}
	
	/**
	 * @author "Changki.woo"
	 * @date 2014. 7. 21. 오후 5:01:50
	 * Method description : 구역구간목록 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ? > selectListSegGpCht(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> getParamSet  = XframeControllerUtils.getParamDataSet(param, "dsCondCht");
		
		List<Map<String, Object>> resultList = null;
		
		String svcUrl = "com.korail.yz.yr.ca.YRCA003QMDAO.selectListSegGpCht";
		
		resultList = (List<Map<String, Object>>) dao.list(svcUrl, getParamSet);
		result.put("dsSegGpNoList", resultList);
		
		
		return result;	
	}
	
	
	/**
	 * @author "Changki.woo"
	 * @date 2014. 7. 21. 오후 5:01:50
	 * Method description : 운행일별 평균값조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ? > selectListRunDtPrAvgAcvmCht(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> getParamSet  = XframeControllerUtils.getParamDataSet(param, "dsCondCht");
		
		List<Map<String, Object>> resultList = null;
		
		String svcUrl = "com.korail.yz.yr.ca.YRCA003QMDAO.selectListRunDtPrAvgAcvmCht";
		
		resultList = (List<Map<String, Object>>) dao.list(svcUrl, getParamSet);
		result.put("dsListCht", resultList);
		
		
		return result;	
	}
	

	/**
	 * @author "Changki.woo"
	 * @date 2014. 7. 21. 오후 5:01:50
	 * Method description : 운행일별(객실등급) 평균값조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ? > selectListRunDtPrPsrmAvgAcvmCht(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> getParamSet  = XframeControllerUtils.getParamDataSet(param, "dsCondCht");
		
		List<Map<String, Object>> resultList = null;
		
		String svcUrl = "com.korail.yz.yr.ca.YRCA003QMDAO.selectListRunDtPrPsrmAvgAcvmCht";
		
		resultList = (List<Map<String, Object>>) dao.list(svcUrl, getParamSet);
		result.put("dsListCht", resultList);
		
		
		return result;	
	}
	
	/**
	 * @author "Changki.woo"
	 * @date 2014. 7. 21. 오후 5:01:50
	 * Method description : 운행일별 구역구간별 평균값조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ? > selectListRunDtPrSegGpPrAvgAcvmCht(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> getParamSet  = XframeControllerUtils.getParamDataSet(param, "dsCondCht");
		
		List<Map<String, Object>> resultList = null;
		
		String svcUrl = "com.korail.yz.yr.ca.YRCA003QMDAO.selectListRunDtPrSegGpPrAvgAcvmCht";
		
		resultList = (List<Map<String, Object>>) dao.list(svcUrl, getParamSet);
		result.put("dsListCht", resultList);
		
		
		return result;	
	}
	
	/**
	 * @author "Changki.woo"
	 * @date 2014. 7. 21. 오후 5:01:50
	 * Method description : 운행일별 구역구간별(객실등급) 평균값조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ? > selectListRunDtPrSegGpPrPsrmAvgAcvmCht(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> getParamSet  = XframeControllerUtils.getParamDataSet(param, "dsCondCht");
		
		List<Map<String, Object>> resultList = null;
		
		String svcUrl = "com.korail.yz.yr.ca.YRCA003QMDAO.selectListRunDtPrSegGpPrPsrmAvgAcvmCht";
		
		resultList = (List<Map<String, Object>>) dao.list(svcUrl, getParamSet);
		result.put("dsListCht", resultList);
		
		
		return result;	
	}
	
	
	/**
	 * @author "Changki.woo"
	 * @date 2014. 7. 21. 오후 5:01:50
	 * Method description : 운행구간 운행일별 전체합계 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ? > selectListRunDtPrRunInfoPrAvgAcvmCht(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> getParamSet  = XframeControllerUtils.getParamDataSet(param, "dsCondCht");
		
		List<Map<String, Object>> resultList = null;
		
		String svcUrl = "com.korail.yz.yr.ca.YRCA003QMDAO.selectListRunDtPrRunInfoPrAvgAcvmCht";
		
		resultList = (List<Map<String, Object>>) dao.list(svcUrl, getParamSet);
		result.put("dsListCht", resultList);
		
		
		return result;	
	}
	
	/**
	 * @author "Changki.woo"
	 * @date 2014. 7. 21. 오후 5:01:50
	 * Method description : 운행구간 운행일별(객실등급) 전체합계 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ? > selectListRunDtPrRunInfoPrPsrmAvgAcvmCht(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> getParamSet  = XframeControllerUtils.getParamDataSet(param, "dsCondCht");
		
		List<Map<String, Object>> resultList = null;
		
		String svcUrl = "com.korail.yz.yr.ca.YRCA003QMDAO.selectListRunDtPrRunInfoPrPsrmAvgAcvmCht";
		
		resultList = (List<Map<String, Object>>) dao.list(svcUrl, getParamSet);
		result.put("dsListCht", resultList);
		
		
		return result;	
	}
}
/**
 * project : KORAIL_YZ
 * package : com.korail.yz.yb.co
 * date : 2014. 3. 11.오후 3:32:36
 */
package com.korail.yz.yr.co;

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
 * @date 2014. 4. 13. 오후 4:32:42
 * Class description : 실적관리 공통 SVC 모음
 */
@Service("com.korail.yz.yr.co.YRCO001SVC")
public class YRCO001SVC {

	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public static final Logger LOGGER = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
	
	/**
	 * @author "Changki.woo"
	 * @date 2014. 3. 27. 오후 4:09:25
	 * Method description : 열차운영 정보 조회 Method
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ? > selectTrnRunInfo(Map<String, ?> param){
		LOGGER.debug("param =>"+param);
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> getParamSet = null;
		
		if(param.containsKey("dsCond"))
		{
			getParamSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");
		}
		
		if(param.containsKey("dsCondGrd"))
		{
			getParamSet = XframeControllerUtils	.getParamDataSet(param, "dsCondGrd");
		}
		
		List<Map<String, Object>> resultList = null;
		
		resultList = (List<Map<String, Object>>) dao.list("com.korail.yz.yr.co.YRCO001QMDAO.selectTrnRunInfoQry", getParamSet);
		result.put("dsTrnRunInfo", resultList);
		
		return result;
		
	}
	
	
	/**
	 * @author "Changki.woo"
	 * @date 2014. 3. 27. 오후 7:52:14
	 * Method description : 열차기본 정보 조회 Method
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ? > selectTrnBsInfo(Map<String, ?> param){
		LOGGER.debug("param =>"+param);
		Map<String, Object> result = new HashMap<String, Object>();

		List<Map<String, Object>> resultList = null;
		//열차운영사업자구분코드 추가
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		if(param.containsKey("dsCond"))
		{
			Map<String, String> getParamSet = XframeControllerUtils.getParamDataSet(param, "dsCond");
			getParamSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
			LOGGER.debug("getParamSet(dsCond) ==>  " + getParamSet);
			resultList = (List<Map<String, Object>>) dao.list("com.korail.yz.yr.co.YRCO001QMDAO.selectTrnBaseInfoQry", getParamSet);
			result.put("dsTrnBsInfo", resultList);
		}
		
		if(param.containsKey("dsCond2"))
		{
			Map<String, String> getParamSet = XframeControllerUtils.getParamDataSet(param, "dsCond2");
			getParamSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
			LOGGER.debug("getParamSet(dsCond2) ==>  " + getParamSet);
			resultList = (List<Map<String, Object>>) dao.list("com.korail.yz.yr.co.YRCO001QMDAO.selectTrnBaseInfoQry", getParamSet);
			result.put("dsTrnBsInfo2", resultList);
			
		}
		
		if(param.containsKey("dsCondGrd"))
		{
			Map<String, String> getParamSet = XframeControllerUtils.getParamDataSet(param, "dsCondGrd");
			getParamSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
			LOGGER.debug("getParamSet(dsCondGrd) ==>  " + getParamSet);
			resultList = (List<Map<String, Object>>) dao.list("com.korail.yz.yr.co.YRCO001QMDAO.selectTrnBaseInfoQry", getParamSet);
			result.put("dsTrnBsInfo", resultList);
			
		}
		
		if(param.containsKey("dsCondGrd2"))
		{
			Map<String, String> getParamSet = XframeControllerUtils.getParamDataSet(param, "dsCondGrd2");
			getParamSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
			LOGGER.debug("getParamSet(dsCondGrd2) ==>  " + getParamSet);
			resultList = (List<Map<String, Object>>) dao.list("com.korail.yz.yr.co.YRCO001QMDAO.selectTrnBaseInfoQry", getParamSet);
			result.put("dsTrnBsInfo2", resultList);
			
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
	 * @date 2014. 5. 26. 오전 10:38:59
	 * Method description : 열차별 할당결과 차트조회 구역구간 그룹별 출발,도착역 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ? > selectListSegGpDptArvStn(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();

		List<Map<String, Object>> resultList = null;
		
		if(param.containsKey("dsCond"))
		{
			Map<String, String> getParamSet = XframeControllerUtils.getParamDataSet(param, "dsCond");
			String svcUrl = "com.korail.yz.yr.co.YRCO001QMDAO.selectListSegGpDptArvStnQry";
			resultList = (List<Map<String, Object>>) dao.list(svcUrl, getParamSet);
			result.put("dsListSegGp", resultList);
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
	 * @date 2014. 5. 28. 오후 3:08:35
	 * Method description : 구역구간 그룹 번호 조회 
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ? > selectListSegGpNo(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();

		List<Map<String, Object>> resultList = null;
		
		if(param.containsKey("dsGrdSelCond"))
		{
			Map<String, String> getParamSet = XframeControllerUtils.getParamDataSet(param, "dsGrdSelCond");
			
			//조회조건중에 RUN_DT, RUN_TRM_DT가 섞여서 들어온다.
			//이중에 하나는 ""(emptyStr)일거니까 empty인 애는 getParamSet에서 지워서
			//dynamic쿼리를 태우자.
			
			String runDtStr = getParamSet.get("RUN_DT");
			String runTrmStDtStr = getParamSet.get("RUN_TRM_ST_DT");			
			if("".equals(runDtStr))
			{
				getParamSet.remove("RUN_DT");
			}
			if("".equals(runTrmStDtStr))
			{
				getParamSet.remove("RUN_TRM_ST_DT");
				getParamSet.remove("RUN_TRM_CLS_DT");				
			}
			
			String svcUrl = "com.korail.yz.co.YZCO001QMDAO.selectListSegGpNo";
			resultList = (List<Map<String, Object>>) dao.list(svcUrl, getParamSet);
			result.put("dsSegGpNoList", resultList);
		}
		
		
		if(param.containsKey("dsCond"))
		{
			Map<String, String> getParamSet = XframeControllerUtils.getParamDataSet(param, "dsCond");
			String svcUrl = "com.korail.yz.co.YZCO001QMDAO.selectListSegGpNo";
			resultList = (List<Map<String, Object>>) dao.list(svcUrl, getParamSet);
			result.put("dsListSegGp", resultList);
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
}

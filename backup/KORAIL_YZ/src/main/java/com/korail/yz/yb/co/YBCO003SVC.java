package com.korail.yz.yb.co;

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

@Service("com.korail.yz.yb.co.YBCO003SVC")
public class YBCO003SVC {

	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public  static final Logger LOGGER = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
	
	/**
	 * 주운행선 조회
	 * @author 김응규
	 * @date 2014. 3. 25. 오후 3:17:38
	 * Method description : 주운행선 정보 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map<String, ?> selectListMrnt(Map<String, ?> param) {		
		LOGGER.debug("param ==>"+param);
		Map<String, Object> result = new HashMap<String, Object>();
		// search input column dataset
		Map<String, String> inputDataSet = new HashMap<String, String>();
		//열차운영사업자구분코드 추가
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		inputDataSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		ArrayList<Map<String, Object>> resultList = (ArrayList) dao.list("com.korail.yz.yb.co.YBCO003QMDAO.selectListMrnt", inputDataSet);

		if(resultList.isEmpty()){
			XframeControllerUtils.setMessage("IZZ000004", result); //해당 조건의 자료가 존재하지 않습니다.
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result); //정상적으로 조회 되었습니다.
		}
		result.put("dsMrntList", resultList);

		return result;

	}
	
	/**
	 * 노선 조회
	 * @author 김응규
	 * @date 2014. 3. 25. 오후 3:17:38
	 * Method description : 노선 정보 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map<String, ?> selectListRout(Map<String, ?> param) {		
		LOGGER.debug("param ==>"+param);
		Map<String, Object> result = new HashMap<String, Object>();

		// search input column dataset
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");	
		//열차운영사업자구분코드 추가
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		inputDataSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		// search input column data
		ArrayList<Map<String, Object>> resultList = (ArrayList) dao.list("com.korail.yz.yb.co.YBCO003QMDAO.selectListRout", inputDataSet);
		
		if(resultList.isEmpty()){
			XframeControllerUtils.setMessage("IZZ000004", result); //해당 조건의 자료가 존재하지 않습니다.
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result); //정상적으로 조회 되었습니다.
		}
		result.put("dsRoutList", resultList);

		return result;

	}
	/**
	 * 공통 오브젝트 셋팅
	 * @author 김응규
	 * @date 2014. 4. 2. 오후 3:17:38
	 * Method description : 조회조건에 필요한 공통콤보박스 중 DB에서 값을 가져와 셋팅해야 하는 콤보들에 값을 셋팅하여 넘겨줌.
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map<String, ?> selectListObject(Map<String, ?> param) {		

		Map<String, Object> result = new HashMap<String, Object>();
		LOGGER.debug("param ==> "+param);
		
		// search input column dataset
		Map<String, String> inputDataSet = XframeControllerUtils.getParamDataSet(param, "dsObjCond");
		
		/* 데이터셋을 넘겨주지 않은경우 에러발생하여 null 처리- 김응규(2014.04.12) */
		Map<String, String> inputDataSetCond = new HashMap<String, String>();
		if(param.get( "dsCond") != null )  //화면에서 조회조건을 받아와서 공통코드를 다시 조회하는경우
		{
			inputDataSetCond	 = XframeControllerUtils.getParamDataSet(param, "dsCond");
		}
		
		Map<String, String> inpRunSegCondDataSet = new HashMap<String, String>();
		if(param.get( "dsObjRunSegCond") != null)
		{
			inpRunSegCondDataSet = XframeControllerUtils.getParamDataSet(param, "dsObjRunSegCond");
		}
		//열차운영사업자구분코드 추가
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		inputDataSetCond.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		
		LOGGER.debug("inputDataSet ==>  " + inputDataSet);
		//logger.debug("inputDataSet ==>  " + inputDataSetCond);
		
		ArrayList<Map<String, Object>> ymgtCgPsList = new ArrayList<Map<String,Object>>();  /*수익관리담당자*/
		ArrayList<Map<String, Object>> mrntList = new ArrayList<Map<String,Object>>(); /*주운행선*/
		ArrayList<Map<String, Object>> routList = new ArrayList<Map<String,Object>>(); /*노선*/
		ArrayList<Map<String, Object>> bkclCdList = new ArrayList<Map<String,Object>>(); /*부킹클래스*/
		ArrayList<Map<String, Object>> runSegFromList = new ArrayList<Map<String,Object>>(); /*운행구간FROM*/
		ArrayList<Map<String, Object>> runSegToList = new ArrayList<Map<String,Object>>(); /*운행구간TO*/
		ArrayList<Map<String, Object>> dptArvStgpList = new ArrayList<Map<String,Object>>(); /*출발-도착역그룹코드*/
		ArrayList<Map<String, Object>> nonNmlTrnFlgList = new ArrayList<Map<String,Object>>(); /*출발-도착역그룹코드*/
		ArrayList<Map<String, Object>> rsStnCdList = new ArrayList<Map<String,Object>>(); /*예발역코드*/
		ArrayList<Map<String, Object>> zoneSegGpNoList = new ArrayList<Map<String,Object>>(); /*구역구간그룹번호*/
		ArrayList<Map<String, Object>> tmwdList = new ArrayList<Map<String,Object>>(); /*시간대 구분코드*/
		ArrayList<Map<String, Object>> ttrnSrtCdList = new ArrayList<Map<String,Object>>(); /*임시열차 분류코드*//* 김응규 추가 2014.06.26 */
		
		Map<String, Object> mrntMap = new HashMap<String, Object>();
		Map<String, Object> routMap = new HashMap<String, Object>();
		Map<String, Object> ymgtCgPsMap = new HashMap<String, Object>();
		Map<String, Object> bkclCdMap = new HashMap<String, Object>();
		Map<String, Object> runSegMap = new HashMap<String, Object>();
		Map<String, Object> dptArvStgpMap = new HashMap<String, Object>();
		Map<String, Object> ttrnSrtCdMap = new HashMap<String, Object>();
		
		mrntMap.put("MRNT_CD", "");
		mrntMap.put("MRNT_NM", "전체");
		routMap.put("ROUT_CD", "");
		routMap.put("ROUT_NM", "전체노선");
		ymgtCgPsMap.put("TRVL_USR_ID", "");
		ymgtCgPsMap.put("TRVL_USR_NM", "전체");
		bkclCdMap.put("BKCL_CD", "");
		bkclCdMap.put("BKCL_NM", "전체");
		runSegMap.put("STN_CD", "");
		runSegMap.put("STN_NM", "전체");
		dptArvStgpMap.put("DPT_ARV_STGP_CD", "");
		dptArvStgpMap.put("DPT_ARV_STGP_CD_NM", "전    체");
		ttrnSrtCdMap.put("TTRN_SRT_CD", "%");
		ttrnSrtCdMap.put("TTRN_SRT_DSC", "일반열차");
		
		if("1".equals(inputDataSet.get("YMGT_CG_PS")))  /*수익관리담당자*/
		{
			ymgtCgPsList = (ArrayList)dao.list("com.korail.yz.comm.COMMQMDAO.selectListYmgtCgPs", null);
			ymgtCgPsList.add(0, ymgtCgPsMap);
			result.put("dsYmgtCgPsList", ymgtCgPsList);
		}
		
		if("1".equals(inputDataSet.get("MRNT"))) /*주운행선*/
		{
			mrntList = (ArrayList) dao.list("com.korail.yz.yb.co.YBCO003QMDAO.selectListMrnt", inputDataSetCond);
			mrntList.add(0, mrntMap);
			result.put("dsMrntList", mrntList);
		}
		
		if("1".equals(inputDataSet.get("ROUT"))) /*노선*/
		{
			routList = (ArrayList) dao.list("com.korail.yz.yb.co.YBCO003QMDAO.selectListRout", inputDataSetCond);
			routList.add(0, routMap);
			result.put("dsRoutList", routList);
		}
		
		if("1".equals(inputDataSet.get("BKCL"))) /*부킹클래스*/
		{	
			bkclCdList = (ArrayList) dao.list("com.korail.yz.yb.co.YBCO003QMDAO.selectListBkclCd", inputDataSetCond);
			bkclCdList.add(0, bkclCdMap);
			result.put("dsBkclCdList", bkclCdList);
		}else if("2".equals(inputDataSet.get("BKCL"))) /*부킹클래스*/
		{
			bkclCdList = (ArrayList) dao.list("com.korail.yz.yb.co.YBCO003QMDAO.selectListBkclCd2", inputDataSetCond);
			bkclCdList.add(0, bkclCdMap);
			result.put("dsBkclCdList", bkclCdList);
		}
		
		
		if("0".equals(inpRunSegCondDataSet.get("RUNSEG"))) /*운행구간*/
		{
			runSegFromList = (ArrayList) dao.list("com.korail.yz.yb.co.YBCO003QMDAO.selectListRunSeg", runSegMap);
			runSegFromList.add(0, runSegMap);
			runSegToList = (ArrayList) dao.list("com.korail.yz.yb.co.YBCO003QMDAO.selectListRunSeg", runSegMap);
			runSegToList.add(0, runSegMap);
			result.put("dsRunSegFromList", runSegFromList);
			result.put("dsRunSegToList", runSegToList);
		}
		
		if("1".equals(inpRunSegCondDataSet.get("RUNSEG"))) /*운행구간 ( 조회조건(dsCond)를 사용할때 )*/
		{
			String fromStnCode = inpRunSegCondDataSet.get("STN_CONS_ORDR_FROM");
			String toStnCode = inpRunSegCondDataSet.get("STN_CONS_ORDR_TO");
			
			/* 날짜처리 로직 추가 2014.06.11.우창기 RUN_TRM_ST_DT ~ RUN_TRM_CLS_DT 와 RUN_DT 둘다 사용가능*/
			// 운행일자( RUN_DT ) 가 empty가 아닌경우 RUN_DT를 사용하기 떄문에 RUN_TRM 키값을 삭제 
			// 운행일자( RUN_DT ) 가 empty일 경우 RUN_TRM이기 떄문에 RUN_DT 키값을 삭제.
			
			if(inpRunSegCondDataSet.get("RUN_DT").isEmpty())
			{
				inpRunSegCondDataSet.remove("RUN_DT");
			}
			
			else
			{
				inpRunSegCondDataSet.remove("RUN_TRM_ST_DT");
				inpRunSegCondDataSet.remove("RUN_TRM_CLS_DT");				
			}
			
			
			inpRunSegCondDataSet.put("STN_CONS_ORDR", fromStnCode);
			runSegFromList = (ArrayList) dao.list("com.korail.yz.yb.co.YBCO003QMDAO.selectListRunSegWithPram", inpRunSegCondDataSet);
			
			runSegFromList.add(0, runSegMap);
			result.put("dsRunSegFromList", runSegFromList);
			
			inpRunSegCondDataSet.put("STN_CONS_ORDR", toStnCode);
			runSegToList = (ArrayList) dao.list("com.korail.yz.yb.co.YBCO003QMDAO.selectListRunSegWithPram", inpRunSegCondDataSet);
			runSegToList.add(0, runSegMap);
			result.put("dsRunSegToList", runSegToList);
		}
		if("1".equals(inputDataSet.get("DPT_ARV_STGP"))) /*출발-도착역그룹명 조회*/
		{
			/*1. 역그룹차수 조회*/
			LOGGER.debug("1. 역그룹차수 조회 시작 ::::::::::Start::::::::::::");
			ArrayList<Map<String, Object>> stgpDegrList = (ArrayList) dao.list("com.korail.yz.comm.COMMQMDAO.selectStgpDegr", null);
			inputDataSetCond.put("STGP_DEGR", stgpDegrList.get(0).get("STGP_DEGR").toString());
			/*2.출발-도착역그룹명 조회*/
			dptArvStgpList = (ArrayList) dao.list("com.korail.yz.yb.co.YBCO003QMDAO.selectListDptArvStgp", inputDataSetCond);
			dptArvStgpList.add(0, dptArvStgpMap);
			result.put("dsDptArvStgpList", dptArvStgpList);
		}
		if("1".equals(inputDataSet.get("NON_NML_TRN_FLG"))) /*단기보정여부(비정상열차여부)*/
		{
			LOGGER.debug("단기보정여부(비정상열차여부) 조회 시작 ::::::::::Start::::::::::::");
			nonNmlTrnFlgList = (ArrayList) dao.list("com.korail.yz.comm.COMMQMDAO.selectNonNmlTrnFlg", inputDataSetCond);
			result.put("dsNonNmlTrnFlg", nonNmlTrnFlgList);
		}
		if("1".equals(inputDataSet.get("RS_STN_CD")))  /* 예발역코드조회 */
		{
			LOGGER.debug("예발역코드 조회 시작 ::::::::::Start::::::::::::");
			rsStnCdList = (ArrayList) dao.list("com.korail.yz.yb.co.YBCO003QMDAO.selectListRsStnCd", inputDataSetCond);
			for(int i = 0; i < rsStnCdList.size(); i++)
			{
				LOGGER.debug(rsStnCdList.get(i).toString());
			}
			result.put("dsRsStnCdList", rsStnCdList);
			
		}
		
		if("1".equals(inputDataSet.get("ZONE_SEG_GP_NO")))  /* 구역구간그룹번호 */
		{
			LOGGER.debug("구역구간그룹번호 조회 시작 ::::::::::Start::::::::::::");
			zoneSegGpNoList = (ArrayList) dao.list("com.korail.yz.yb.co.YBCO003QMDAO.selectListZoneSegGpNo", inputDataSetCond);
			result.put("dsZoneSegGpNoList", zoneSegGpNoList);
			
		}

		if("1".equals(inputDataSet.get("TMWD_DV_CD")))  /* 시간대 구분코드 */
		{
			LOGGER.debug("시간대 구분코드 조회 시작 ::::::::::Start::::::::::::");
			tmwdList = (ArrayList) dao.list("com.korail.yz.yb.co.YBCO003QMDAO.selectTmwd", inputDataSetCond);
			result.put("dsTmwd", tmwdList);
			
		}

		if("0".equals(inputDataSet.get("TMWD_DV_CD")))  /* 시간대 구분코드2 */
		{
			LOGGER.debug("시간대 구분코드 조회 시작 ::::::::::Start::::::::::::" + inputDataSetCond.get("DAY_DV_CD"));
			tmwdList = (ArrayList) dao.list("com.korail.yz.yb.co.YBCO003QMDAO.selectTmwd2", inputDataSetCond);
			result.put("dsTmwd", tmwdList);
			
		}
		/* 임시열차분류코드 김응규 추가 2014.06.26 */
		if("1".equals(inputDataSet.get("TTRN_SRT_CD")))  /* 임시열차분류코드 */
		{
			LOGGER.debug("임시열차분류코드 조회 시작 ::::::::::Start::::::::::::");
			ttrnSrtCdList = (ArrayList) dao.list("com.korail.yz.yb.co.YBCO003QMDAO.selectListTtrnSrtCd", null);
			ttrnSrtCdList.add(0, ttrnSrtCdMap);
			result.put("dsTtrnSrtCdList", ttrnSrtCdList);
			
		}
		
		XframeControllerUtils.setMessage("IZZ000014", result); //화면이 로딩되었습니다.
		return result;
	}
}
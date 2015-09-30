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
	
	public  final Logger logger = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
	
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

		Map<String, Object> result = new HashMap<String, Object>();
		ArrayList<Map<String, Object>> resultList = (ArrayList) dao.list("com.korail.yz.yb.co.YBCO003QMDAO.selectListMrnt", null);

		for(int i=0;i<resultList.size();i++)
		{
			logger.debug(resultList.get(i).toString());
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

		Map<String, Object> result = new HashMap<String, Object>();

		logger.debug("param ==> "+param);
		// search input column dataset
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");	
		logger.debug("inputDataSet ==>  " + inputDataSet);

		// search input column data
		logger.debug("inputData ==>  " + inputDataSet.get("MRNT_CD")); //주운행선코드
		ArrayList<Map<String, Object>> resultList = (ArrayList) dao.list("com.korail.yz.yb.co.YBCO003QMDAO.selectListRout", inputDataSet);
		
		for(int i=0;i<resultList.size();i++)
		{
			logger.debug(resultList.get(i).toString());
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
		logger.debug("param ==> "+param);
		
		// search input column dataset
		Map<String, String> inputDataSet  		 = XframeControllerUtils	.getParamDataSet(param, "dsObjCond");
		
		/* 데이터셋을 넘겨주지 않은경우 에러발생하여 null 처리- 김응규(2014.04.12) */
		Map<String, String> inputDataSetCond = new HashMap<String, String>();
		if(param.get( "dsCond") != null )  //화면에서 조회조건을 받아와서 공통코드를 다시 조회하는경우
		{
			inputDataSetCond	 = XframeControllerUtils	.getParamDataSet(param, "dsCond");
		}
		
		Map<String, String> inpRunSegCondDataSet = new HashMap<String, String>();
		if(param.get( "dsObjRunSegCond") != null)
		{
			inpRunSegCondDataSet = XframeControllerUtils	.getParamDataSet(param, "dsObjRunSegCond");
		}
		
		
		logger.debug("inputDataSet ==>  " + inputDataSet);
		//logger.debug("inputDataSet ==>  " + inputDataSetCond);
		
		ArrayList<Map<String, Object>> ymgtCgPsList = new ArrayList<Map<String,Object>>();  /*수익관리담당자*/
		ArrayList<Map<String, Object>> mrntList = new ArrayList<Map<String,Object>>(); /*주운행선*/
		ArrayList<Map<String, Object>> routList = new ArrayList<Map<String,Object>>(); /*노선*/
		ArrayList<Map<String, Object>> bkclCdList = new ArrayList<Map<String,Object>>(); /*부킹클래스*/
		ArrayList<Map<String, Object>> runSegFromList = new ArrayList<Map<String,Object>>(); /*운행구간FROM*/
		ArrayList<Map<String, Object>> runSegToList = new ArrayList<Map<String,Object>>(); /*운행구간TO*/
		ArrayList<Map<String, Object>> dptArvStgpList = new ArrayList<Map<String,Object>>(); /*출발-도착역그룹코드*/
		ArrayList<Map<String, Object>> nonNmlTrnFlgList = new ArrayList<Map<String,Object>>(); /*출발-도착역그룹코드*/
		
		Map<String, Object> mrntMap = new HashMap<String, Object>();
		Map<String, Object> routMap = new HashMap<String, Object>();
		Map<String, Object> ymgtCgPsMap = new HashMap<String, Object>();
		Map<String, Object> bkclCdMap = new HashMap<String, Object>();
		Map<String, Object> runSegMap = new HashMap<String, Object>();
		Map<String, Object> dptArvStgpMap = new HashMap<String, Object>();
		
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
		
		if("1".equals(inputDataSet.get("YMGT_CG_PS")))  /*수익관리담당자*/
		{
			ymgtCgPsList = (ArrayList)dao.list("com.korail.yz.comm.COMMQMDAO.selectListYmgtCgPs", null);
			ymgtCgPsList.add(0, ymgtCgPsMap);
			result.put("dsYmgtCgPsList", ymgtCgPsList);
		}
		
		if("1".equals(inputDataSet.get("MRNT"))) /*주운행선*/
		{
			mrntList = (ArrayList) dao.list("com.korail.yz.yb.co.YBCO003QMDAO.selectListMrnt", null);
			mrntList.add(0, mrntMap);
			result.put("dsMrntList", mrntList);
			for(int i=0;i<mrntList.size();i++)
			{
				logger.debug(mrntList.get(i).toString());
			}
		}
		
		if("1".equals(inputDataSet.get("ROUT"))) /*노선*/
		{
			routList = (ArrayList) dao.list("com.korail.yz.yb.co.YBCO003QMDAO.selectListRout", mrntMap);
			routList.add(0, routMap);
			result.put("dsRoutList", routList);
			for(int i=0;i<routList.size();i++)
			{
				logger.debug(routList.get(i).toString());
			}
		}
		
		
		if("1".equals(inputDataSet.get("BKCL"))) /*부킹클래스*/
		{
			bkclCdList = (ArrayList) dao.list("com.korail.yz.yb.co.YBCO003QMDAO.selectListBkclCd", bkclCdMap);
			bkclCdList.add(0, bkclCdMap);
			result.put("dsBkclCdList", bkclCdList);
			for(int i=0;i<bkclCdList.size();i++)
			{
				logger.debug(bkclCdList.get(i).toString());
			}
		}
		
		if("1".equals(inputDataSet.get("BKCL"))) /*부킹클래스*/
		{
			bkclCdList = (ArrayList) dao.list("com.korail.yz.yb.co.YBCO003QMDAO.selectListBkclCd", bkclCdMap);
			bkclCdList.add(0, bkclCdMap);
			result.put("dsBkclCdList", bkclCdList);
			for(int i=0;i<bkclCdList.size();i++)
			{
				logger.debug(bkclCdList.get(i).toString());
			}
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
		
		if("1".equals(inpRunSegCondDataSet.get("RUNSEG"))) /*운행구간*/
		{
			String fromStnCode = inpRunSegCondDataSet.get("STN_CONS_ORDR_FROM");
			String toStnCode = inpRunSegCondDataSet.get("STN_CONS_ORDR_TO");
			
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
			logger.debug("1. 역그룹차수 조회 시작 ::::::::::Start::::::::::::");
			ArrayList<Map<String, Object>> stgpDegrList = (ArrayList) dao.list("com.korail.yz.comm.COMMQMDAO.selectStgpDegr", null);
			inputDataSetCond.put("STGP_DEGR", stgpDegrList.get(0).get("STGP_DEGR").toString());
			logger.debug("역그룹차수(STPG_DEGR)::::"+stgpDegrList.get(0).get("STGP_DEGR").toString());
			logger.debug("1. 역그룹차수 조회 끝 ::::::::::End::::::::::::");
			/*2.출발-도착역그룹명 조회*/
			dptArvStgpList = (ArrayList) dao.list("com.korail.yz.yb.co.YBCO003QMDAO.selectListDptArvStgp", inputDataSetCond);
			dptArvStgpList.add(0, dptArvStgpMap);
			result.put("dsDptArvStgpList", dptArvStgpList);
			for(int i = 0; i < dptArvStgpList.size(); i++)
			{
				logger.debug(dptArvStgpList.get(i).toString());
			}
		}
		if("1".equals(inputDataSet.get("NON_NML_TRN_FLG"))) /*단기보정여부(비정상열차여부)*/
		{
			logger.debug("단기보정여부(비정상열차여부) 조회 시작 ::::::::::Start::::::::::::");
			nonNmlTrnFlgList = (ArrayList) dao.list("com.korail.yz.comm.COMMQMDAO.selectNonNmlTrnFlg", inputDataSetCond);
			logger.debug("단기보정여부(비정상열차여부)(NON_NML_TRN_FLG) ::::"+nonNmlTrnFlgList.get(0).get("NON_NML_TRN_FLG").toString());
			logger.debug("단기보정여부(비정상열차여부) 조회 끝 ::::::::::End::::::::::::");
			result.put("dsNonNmlTrnFlg", nonNmlTrnFlgList);
		}
		return result;
	}
}
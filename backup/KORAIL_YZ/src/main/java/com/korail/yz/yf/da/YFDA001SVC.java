/**
 * project : KORAIL_YZ
 * package : com.korail.yz.yf.da
 * date : 2014. 7. 14.오후 7:36:11
 */
package com.korail.yz.yf.da;

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
import cosmos.comm.exception.CosmosRuntimeException;

/**
 * @author 나윤채
 * @date 2014. 7. 14. 오후 7:36:11
 * Class description : 수요예측 분석 및 조정
 */

@Service("com.korail.yz.yf.da.YFDA001SVC")
public class YFDA001SVC {
	
	
	@Resource(name="commDAO")
	private transient CommDAO dao;

	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public static final Logger LOGGER = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
	
	/**
	 * @author 나윤채
	 * @date 2015. 1. 31. 오후 2:53:18
	 * Method description : 열차별 총량정보 조회조건 (요일)
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListAllTrnDayInfo(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> condMap = XframeControllerUtils.getParamDataSet(param, "dsPssrCond1");
		ArrayList<Map<String, Object>> runDtArr = new ArrayList<Map<String,Object>>();

		LOGGER.debug("param ==> "+param);
		
		/*	운행기간 */
		condMap.put("RUN_DT_DV_CD", "0");
		
		chkPeriod (condMap, runDtArr);
		
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		if("".equals(trnOprBzDvCd) || trnOprBzDvCd == null){
			trnOprBzDvCd = "000";
		}
		condMap.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		
		ArrayList<Map<String, Object>> resultList = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.yf.da.YFDA001QMDAO.selectListAllTrnDayInfo",condMap);			
		result.put("dsTrnPssr1", resultList);
			
		result = sendMessage(resultList, resultList, result, 0);		//메시지 처리
		
		return result;
	}
	
	/**
	 * @author SDS
	 * @date 2015. 1. 31. 오후 2:53:54
	 * Method description : 열차별 총량정보 조회조건 (열차번호)
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListAllTrnNoInfo(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> condMap = XframeControllerUtils.getParamDataSet(param, "dsPssrCond1");
		ArrayList<Map<String, Object>> runDtArr = new ArrayList<Map<String,Object>>();
		
		LOGGER.debug("param ==> "+param);
		
		/*	운행기간 */
		condMap.put("RUN_DT_DV_CD", "0");
		chkPeriod (condMap, runDtArr);
		
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		if("".equals(trnOprBzDvCd) || trnOprBzDvCd == null){
			trnOprBzDvCd = "000";
		}
		condMap.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		
		ArrayList<Map<String, Object>> resultList = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.yf.da.YFDA001QMDAO.selectListAllTrnNoInfo",condMap);			
		result.put("dsTrnPssr2", resultList);
		
		result = sendMessage(resultList, resultList, result, 0);		//메시지 처리
		
		return result;
	}
	
	/**
	 * @author 나윤채
	 * @date 2015. 1. 31. 오후 2:54:35
	 * Method description : 구간별 상세정보 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListSGMPInfo(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> condMap = XframeControllerUtils.getParamDataSet(param, "dsPssrCond2");
		ArrayList<Map<String, Object>> runDtArr = new ArrayList<Map<String,Object>>();
		
		LOGGER.debug("param ==> "+param);
		
		/*	운행기간 */
		condMap.put("RUN_DT_DV_CD", "1");
		chkPeriod (condMap, runDtArr);
		
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		if("".equals(trnOprBzDvCd) || trnOprBzDvCd == null){
			trnOprBzDvCd = "000";
		}
		condMap.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		
		ArrayList<Map<String, Object>> resultList = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.yf.da.YFDA001QMDAO.selectListSGMPInfo",condMap);			
		result.put("dsTrnPssr3", resultList);
		
		result = sendMessage(resultList, resultList, result, 0);		//메시지 처리
		
		return result;
	}

	/**
	 * @author 나윤채
	 * @date 2015. 1. 31. 오후 2:55:27
	 * Method description : 일자(기간) 총량정보 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListDtAllInfo(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> condMap = XframeControllerUtils.getParamDataSet(param, "dsPssrCond3");
		ArrayList<Map<String, Object>> runDtArr = new ArrayList<Map<String,Object>>();
		
		LOGGER.debug("param ==> "+param);
		
		/*	운행기간 */
		condMap.put("RUN_DT_DV_CD", "0");
		chkPeriod (condMap, runDtArr);
		
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		if("".equals(trnOprBzDvCd) || trnOprBzDvCd == null){
			trnOprBzDvCd = "000";
		}
		condMap.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		
		ArrayList<Map<String, Object>> resultList = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.yf.da.YFDA001QMDAO.selectListDtAllInfo",condMap);			
		result.put("dsTrnPssr4", resultList);
		
		result = sendMessage(resultList, resultList, result, 0);		//메시지 처리
		
		return result;
	}
	
	/**
	 * @author 나윤채
	 * @date 2015. 1. 31. 오후 2:55:52
	 * Method description : 이벤트 캘린더 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListEvntCldr(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> condMap = XframeControllerUtils.getParamDataSet(param, "dsEvntCldrCond");
		
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		if("".equals(trnOprBzDvCd) || trnOprBzDvCd == null){
			trnOprBzDvCd = "000";
		}
		condMap.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		
		ArrayList<Map<String, Object>> resultList1 = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.yf.da.YFDA001QMDAO.selectListEvntCldr",condMap);
		
		result.put("dsEvntCldr", resultList1);
		result = sendMessage(resultList1, resultList1, result, 0);		//메시지 처리
		
		return result;
	}

	/**
	 * @author 나윤채
	 * @date 2015. 1. 31. 오후 2:58:19
	 * Method description : 이벤트목록 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListEvnt(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> condMap = XframeControllerUtils.getParamDataSet(param, "dsEvntCond");
		
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		if("".equals(trnOprBzDvCd) || trnOprBzDvCd == null){
			trnOprBzDvCd = "000";
		}
		condMap.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		
		ArrayList<Map<String, Object>> resultList1 = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.yf.da.YFDA001QMDAO.selectListEvnt",condMap);
		
		result.put("dsListEvnt", resultList1);
		result = sendMessage(resultList1, resultList1, result, 0);		//메시지 처리
		
		return result;
	}

	/**
	 * @author 나윤채
	 * @date 2015. 1. 31. 오후 2:59:02
	 * Method description : 조정대상 (수요조정)
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListDmdAjstTgt(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> condMap = XframeControllerUtils.getParamDataSet(param, "dsPssrCond1");
		
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		if("".equals(trnOprBzDvCd) || trnOprBzDvCd == null){
			trnOprBzDvCd = "000";
		}
		condMap.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		
		ArrayList<Map<String, Object>> resultList1 = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.yf.da.YFDA001QMDAO.selectListDmdAjstTgt",condMap);
		
		result.put("dsTrnTgt", resultList1);
		result = sendMessage(resultList1, resultList1, result, 0);		//메시지 처리
		
		return result;
	}

	/**
	 * @author 나윤채
	 * @date 2015. 1. 31. 오후 3:00:10
	 * Method description : 업데이트 (다중선택)
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> updateSlctedList(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> condMap = XframeControllerUtils.getParamDataSet(param, "dsCond1");
		ArrayList<Map<String, String>> condDay = (ArrayList<Map<String,String>>) param.get("dsCond2");
		ArrayList<Map<String, String>> condList = (ArrayList<Map<String,String>>) param.get("dsTrnTgt");
		
		String item = "";
		
		if ("1".equals(condDay.get(0).get("ALL")))
		{
			item = "'1','2','3','4','5','6','7'";
		}else
		{
			if ("1".equals(condDay.get(0).get("SUN")))
			{
				item = item.concat("'1',");
			}
			
			if ("1".equals(condDay.get(0).get("MON")))
			{
				item = item.concat("'2',");				
			}
			
			if ("1".equals(condDay.get(0).get("TUE")))
			{
				item = item.concat("'3',");				
			}
			
			if ("1".equals(condDay.get(0).get("WED")))
			{
				item = item.concat("'4',");				
			}
			
			if ("1".equals(condDay.get(0).get("THU")))
			{
				item = item.concat("'5',");				
			}
			
			if ("1".equals(condDay.get(0).get("FRI")))
			{
				item = item.concat("'6',");				
			}
			
			if ("1".equals(condDay.get(0).get("SAT")))
			{
				item = item.concat("'7',");					
			}
		}				
		item = rTrim(item).concat("'");
		
		condMap.put("DAY_DV_LIST", item);
		
		ArrayList<Map<String, Object>> resultList = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.yf.da.YFDA001QMDAO.selectListRunDt",condMap);
		
		String item2 = "'";
		for (Map<String, Object> map : resultList) {
			item2 = item2.concat(map.get("RUN_DT").toString()+"','");
		}
		item2 = rTrim(item2).concat("'");
		
		int insertCnt = 0;
		for (int i = 0; i < condList.size(); i++) {
			
			condList.get(i).put("RUN_DT_LIST", item2);
			
		 dao.update("com.korail.yz.yf.da.YFDA001QMDAO.updateSlctedList", condList.get(i));
		 insertCnt++;
		}
		
		if (insertCnt < 1)
		{
			throw new CosmosRuntimeException("WZZ000012", null);  //등록 작업이 실패하였습니다 - 입력값을 확인하십시오.			
		}else{
			LOGGER.debug("다중선택 ["+insertCnt+"] 건 적용되었습니다.");
			XframeControllerUtils.setMessage("IZZ000013", result); //정상적으로 저장 되었습니다.
		}
		return result;
	}
	
	
	/*	수요예측 분석 및 조정(과거패턴) - 실적 조회	*/
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListACVMPtrn(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> condMap = XframeControllerUtils.getParamDataSet(param, "dsPssrCond1");
		
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		if("".equals(trnOprBzDvCd) || trnOprBzDvCd == null){
			trnOprBzDvCd = "000";
		}
		condMap.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		
		ArrayList<Map<String, Object>> resultList1 = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.yf.da.YFDA001QMDAO.selectListACVMPtrn",condMap);
		
		result.put("dsACVMList", resultList1);
		result = sendMessage(resultList1, resultList1, result, 0);		//메시지 처리
		
		return result;
	}

	/*	메시지 처리 메서드*/
	private Map<String, Object> sendMessage(ArrayList<Map<String, Object>> resultList,ArrayList<Map<String, Object>> resultList2, Map<String, Object> result, int num)
	{
		if (num == 0)
		{
			if(resultList.isEmpty()){
				XframeControllerUtils.setMessage("IZZ000004", result); //해당 조건의 자료가 존재하지 않습니다.
			}
			else
			{
				XframeControllerUtils.setMessage("IZZ000009", result); //정상적으로 조회 되었습니다.
			}
		} else if (num == 1)
		{
			if(resultList.isEmpty() && resultList2.isEmpty()){
				XframeControllerUtils.setMessage("IZZ000004", result); //해당 조건의 자료가 존재하지 않습니다.
			}
			else
			{
				XframeControllerUtils.setMessage("IZZ000009", result); //정상적으로 조회 되었습니다.
			}	
		}
		return result;
	}
	
	/*	rTRIM	*/
	private String rTrim (String s)
	{
		char[] val = s.toCharArray();
		int st = 0;
		int len = s.length();
		
		while (st < len && val[len-1] <= ',')
		{
			len--;
		}
		return s.substring(0, len);
	}
	
	/*	날짜 체크박스 확인 여부	*/
	@SuppressWarnings("unchecked")
	private void chkPeriod (Map<String, String> condMap, ArrayList<Map<String, Object>> runDtArr)
	{
		/*	1주전 여부	*/
		if ("1".equals(condMap.get("WK_1")))
		{
			ArrayList<Map<String, Object>> wk1 = (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.yf.da.YFDA001QMDAO.selectListWK_1", condMap);
			for (Map<String, Object> map : wk1) {
				runDtArr.add(map);
			}
		}
		
		/*	2주전 여부	*/		
		if ("1".equals(condMap.get("WK_2")))
		{
			ArrayList<Map<String, Object>> wk2 = (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.yf.da.YFDA001QMDAO.selectListWK_2", condMap);
			for (Map<String, Object> map : wk2) {
				runDtArr.add(map);
			}			
		}		
		
		/*	3주전 여부	*/		
		if ("1".equals(condMap.get("WK_3")))
		{
			ArrayList<Map<String, Object>> wk3 = (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.yf.da.YFDA001QMDAO.selectListWK_3", condMap);
			for (Map<String, Object> map : wk3) {
				runDtArr.add(map);
			}			
		}
		
		/*	4주전 여부	*/		
		if ("1".equals(condMap.get("WK_4")))
		{
			ArrayList<Map<String, Object>> wk4 = (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.yf.da.YFDA001QMDAO.selectListWK_4", condMap);
			for (Map<String, Object> map : wk4) {
				runDtArr.add(map);
			}			
		}
		
		/*	전년동월(요일/일) 여부	*/
		if ("1".equals(condMap.get("WK_DAY")))
		{
			ArrayList<Map<String, Object>> wkDay = (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.yf.da.YFDA001QMDAO.selectListWK_DAY", condMap);
			for (Map<String, Object> map : wkDay) {
				runDtArr.add(map);
			}			
		}
		
		/*	전년동월(+주-/일) 여부	*/		
		if ("1".equals(condMap.get("WK_WK")))
		{
			ArrayList<Map<String, Object>> wkWk = (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.yf.da.YFDA001QMDAO.selectListWK_WK", condMap);
			for (Map<String, Object> map : wkWk) {
				runDtArr.add(map);
			}			
		}
		
		String item = "'";
		if (runDtArr.size() > 1)
		{
		int i = 0;
			while(i < runDtArr.size())
			{
				item = item.concat(runDtArr.get(i).get("RUN_DT").toString() + "','");
				if(i == runDtArr.size()-2)
				{
					item = item.concat(runDtArr.get(i+1).get("RUN_DT").toString());
					break;
				}		
				i++;			
			}
		}else if (runDtArr.size() == 1)
		{
			item = item.concat(runDtArr.get(0).get("RUN_DT").toString());
		}
		condMap.put("RUN_DT_ARR", item.concat("'"));
	}
}

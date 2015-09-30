/**
 * project : KORAIL_YZ
 * package : com.korail.yz.yf.ca
 * date : 2014. 6. 11.오후 6:27:41
 */
package com.korail.yz.yf.ca;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
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
 * @date 2014. 6. 11. 오후 6:27:41
 * Class description : 기간별 예측승차인원 조회
 */

@Service("com.korail.yz.yf.ca.YFCA001SVC")
public class YFCA001SVC {

	@Resource(name="commDAO")
	private transient CommDAO dao;

	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public static final Logger LOGGER = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
	
	/**
	 * @author 나윤채
	 * @date 2015. 1. 31. 오후 2:30:43
	 * Method description : 기간별 예측승차인원 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListPeriExpPssr(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> condMap = XframeControllerUtils.getParamDataSet(param, "dsPssrCond1");
		ArrayList<Map<String, String>> dptArvList = (ArrayList<Map<String,String>>) param.get("dsGrdSelLst");	

			dptArvList(condMap, dptArvList ,"DPT_STGP_CD", "ARV_STGP_CD", "DPT_STGP_LIST", false);
			dptArvList(condMap, dptArvList ,"ARV_STGP_CD", "DPT_STGP_CD", "ARV_STGP_LIST", false);
			dptArvList(condMap, dptArvList ,"DPT_STGP_CD", "ARV_STGP_CD", "DPT_ARV_STGP_LIST",true);
		
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		if("".equals(trnOprBzDvCd)){
			trnOprBzDvCd = "000";
		}
		condMap.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		
		ArrayList<Map<String, Object>> resultList = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.yf.ca.YFCA001QMDAO.selectListPeriExpPssr",condMap);

		result.put("dsGrdTrnPssr", resultList);
		
		result = sendMessage(resultList, resultList, result, 0);		//메시지 처리
		return result;
	}
	
	/**
	 * @author 나윤채
	 * @date 2015. 1. 31. 오후 2:31:05
	 * Method description : 부킹클래스 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListBkcl(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> condMap = XframeControllerUtils.getParamDataSet(param, "dsPssrCond2");
		
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		condMap.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		
		ArrayList<Map<String, Object>> resultList = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.yf.ca.YFCA001QMDAO.selectListBkcl",condMap);
		
		result.put("dsBkcl", resultList);
		
		result = sendMessage(resultList, resultList, result, 0);		//메시지 처리
		return result;
	}

	/**
	 * @author 나윤채
	 * @date 2015. 1. 31. 오후 2:31:44
	 * Method description : OD별 예측 승차인원 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListODExpPssr(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> condMap = XframeControllerUtils.getParamDataSet(param, "dsCond");
		
		ArrayList<Map<String, Object>> resultList = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.yf.ca.YFCA001QMDAO.selectListODExpPssr",condMap);
		
		result.put("dsGrdTrnPssr", resultList);
		
		result = sendMessage(resultList, resultList, result, 0);		//메시지 처리
		return result;
	}

	/**
	 * @author 나윤채
	 * @date 2015. 1. 31. 오후 2:33:30
	 * Method description : OD/구간별 예측 승차인원 차트
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListExpPssrChart(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> condMap = XframeControllerUtils.getParamDataSet(param, "dsCond");
		
		/*	OD별 예측 승차인원 차트	*/
		ArrayList<Map<String, Object>> resultList1 = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.yf.ca.YFCA001QMDAO.selectListODExpPssrChart",condMap);
		/*	구간별 예측 승차인원 차트	*/
		ArrayList<Map<String, Object>> resultList2 = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.yf.ca.YFCA001QMDAO.selectListStExpPssrChart",condMap);
		
		result.put("dsChart1", resultList1);
		result.put("dsChart2", resultList2);
		
		result = sendMessage(resultList1, resultList2, result, 0);		//메시지 처리
		return result;
	}
	
	/**
	 * @author SDS
	 * @date 2015. 1. 31. 오후 2:35:17
	 * Method description : 객실/할인등급 별 예측 승차인원 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListBkclPssr(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> condMap = XframeControllerUtils.getParamDataSet(param, "dsCond2");
		
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		
		if("".equals(trnOprBzDvCd)){
			trnOprBzDvCd = "000";
		}
		
		condMap.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		
		ArrayList<Map<String, Object>> resultList = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.yf.ca.YFCA001QMDAO.selectListBkclPssr",condMap);
		
		result.put("dsGrdBkclPssr", resultList);
		
		result = sendMessage(resultList, resultList, result, 0);		//메시지 처리
		return result;
	}
	
	/**
	 * @author SDS
	 * @date 2015. 1. 31. 오후 2:37:44
	 * Method description : 업데이트 및 최적화 작업
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> updateListBkclPssr(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> condMap = XframeControllerUtils.getParamDataSet(param, "dsCond");
		ArrayList<Map<String, String>> condList = (ArrayList<Map<String,String>>) param.get("dsGrdBkclPssr");	
		
		/*	최적화 작업(1) */
		condMap.put("CHG_USR_ID", param.get("USER_ID").toString());
		ArrayList<Map<String, Object>> resultList = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.yf.ca.YFCA001QMDAO.selectOpt1YgmtJobId",condMap);
//		Object oldYgmtJobId = String.valueOf(resultList.get(0).get("MAX_YMGT_JOB_ID"));
		
		Date chgDttm = new Date();
		SimpleDateFormat sdf8 = new SimpleDateFormat("yyyyMMdd", Locale.KOREA);
		SimpleDateFormat sdf14 = new SimpleDateFormat("yyyyMMddHHmmss", Locale.KOREA);
		
		String maxYgmtJobId;
		if ("".equals(resultList.get(0).get("MAX_YMGT_JOB_ID")))
		{
			maxYgmtJobId = "YZFB210_BA_U1" + sdf8.format(chgDttm) + "001";
		}else
		{
			String oldYgmtJobId = String.valueOf(resultList.get(0).get("MAX_YMGT_JOB_ID"));
			maxYgmtJobId = oldYgmtJobId.substring(0, 21) + String.format("%03d", Integer.parseInt(oldYgmtJobId.substring(22, 24))+1);
		}
		
		/*	 최적화 작업 (2) - 작업자 아이디 저장 - MAX_YMGT_JOB_ID/CHG_DTTM/CHG_USR_ID	*/
		condMap.put("MAX_YMGT_JOB_ID", maxYgmtJobId);
		condMap.put("CHG_DTTM", sdf14.format(chgDttm));
		int insertCnt = 0;
		
		insertCnt = dao.insert("com.korail.yz.yf.ca.YFCA001QMDAO.insertOpt2YmgtJobId", condMap);
		
		if (insertCnt < 1)
		{
			throw new CosmosRuntimeException("WZZ000012", null);  //등록 작업이 실패하였습니다 - 입력값을 확인하십시오.			
		}else{
			LOGGER.debug("2번째 최적화 작업 ["+insertCnt+"] 건 등록되었습니다.");
			XframeControllerUtils.setMessage("IZZ000013", result); //정상적으로 저장 되었습니다.
		}

		/*	 최적화 작업 (3) - 작업자 아이디 저장 - MAX_YMGT_JOB_ID/RUN_DT/TRN_NO/CHG_DTTM/CHG_USR_ID*/
		insertCnt = 0;
		insertCnt = dao.insert("com.korail.yz.yf.ca.YFCA001QMDAO.insertOpt3YgmtJobId", condMap);
		
		if (insertCnt < 1)
		{
			throw new CosmosRuntimeException("WZZ000012", null);  //등록 작업이 실패하였습니다 - 입력값을 확인하십시오.			
		}else{
			LOGGER.debug("3번째 최적화 작업 ["+insertCnt+"] 건 등록되었습니다.");
			XframeControllerUtils.setMessage("IZZ000013", result); //정상적으로 저장 되었습니다.
		}
		
		/*	 최적화 작업 (4) - 작업자 아이디 저장 - MAX_YMGT_JOB_ID/CHG_DTTM/CHG_USR_ID	*/
		insertCnt = 0;
		insertCnt = dao.insert("com.korail.yz.yf.ca.YFCA001QMDAO.insertOpt4YgmtJobId", condMap);
		
		if (insertCnt < 1)
		{
			throw new CosmosRuntimeException("WZZ000012", null);  //등록 작업이 실패하였습니다 - 입력값을 확인하십시오.			
		}else{
			LOGGER.debug("4번째 최적화 작업 ["+insertCnt+"] 건 등록되었습니다.");
			XframeControllerUtils.setMessage("IZZ000013", result); //정상적으로 저장 되었습니다.
		}
		
		/*	 최적화 작업 (5) - 관련 정보 호출	*/	
		ArrayList<ArrayList<Map<String, Object>>> resultSet = new ArrayList<ArrayList<Map<String,Object>>>();
		ArrayList<Map<String, Object>> resultOptList = new ArrayList<Map<String,Object>>();
		ArrayList<Integer> prnb = new ArrayList<Integer>();
		ArrayList<Integer> divPrnb = new ArrayList<Integer>();
		ArrayList<Integer> sumPrnb = new ArrayList<Integer>();
		ArrayList<Map<String, String>> resultOptList2 = new ArrayList<Map<String,String>>();	//승차인원 저장		
		Map<String, String> mapCondList = new HashMap<String, String>();
		
		int sumPsno = 0;
		int divPsno = 0;
		int rCnt = 0;

		for (int i = 0; i < condList.size(); i++) 
		{			
			if ("U".equals(condList.get(i).get("DMN_PRS_DV_CD")))
			{
				condMap.put("DPT_STN_CONS_ORDR", condList.get(i).get("DPT_STN_CONS_ORDR"));
				condMap.put("ARV_STN_CONS_ORDR", condList.get(i).get("ARV_STN_CONS_ORDR"));
				condMap.put("PSRM_CL_CD", condList.get(i).get("PSRM_CL_CD"));
				condMap.put("BKCL_CD", condList.get(i).get("BKCL_CD"));
			
				resultOptList = (ArrayList<Map<String,Object>>) dao.list("com.korail.yz.yf.ca.YFCA001QMDAO.selectListOpt5Cond", condMap);
				
				divPsno = Integer.parseInt(String.valueOf(resultOptList.get(0).get("RATIO")))
						  *Integer.parseInt(condList.get(i).get("USR_CTL_EXPN_DMD_NUM"));
				sumPsno += divPsno;
				
				prnb.add(Integer.parseInt(condList.get(i).get("USR_CTL_EXPN_DMD_NUM")));
				divPrnb.add(divPsno);
				sumPrnb.add(sumPsno);
				
				
				resultSet.add(resultOptList);
				if (resultOptList.isEmpty())
				{
					throw new CosmosRuntimeException("5번 호출", null);  //등록 작업이 실패하였습니다 - 입력값을 확인하십시오.			
				}else{

					XframeControllerUtils.setMessage("5번째 최적화 작업 ["+rCnt+"] 건 호출되었습니다.", result); //정상적으로 저장 되었습니다.
				}

				Map<String, String> mapCondList2 = new HashMap<String, String>();

				mapCondList2.put("RUN_DT", condMap.get("RUN_DT"));
				mapCondList2.put("TRN_NO", condMap.get("TRN_NO"));
//				mapCondList2.put("PSRM_CL_CD", String.valueOf(resultSet.get(rCnt).get(0).get("PSRM_CL_CD")));
//				mapCondList2.put("BKCL_CD", String.valueOf(resultSet.get(rCnt).get(0).get("BKCL_CD")));
//				mapCondList2.put("DPT_STN_CONS_ORDR", String.valueOf(resultSet.get(rCnt).get(0).get("DPT_STN_CONS_ORDR")));
//				mapCondList2.put("ARV_STN_CONS_ORDR", String.valueOf(resultSet.get(rCnt).get(0).get("ARV_STN_CONS_ORDR")));
//				mapCondList2.put("FCST_ACHV_DT", condMap.get("CHG_DTTM").substring(0, 8));
				mapCondList2.put("PSRM_CL_CD", condList.get(i).get("PSRM_CL_CD"));
				mapCondList2.put("BKCL_CD", condList.get(i).get("BKCL_CD"));
				mapCondList2.put("DPT_STN_CONS_ORDR", condList.get(i).get("DPT_STN_CONS_ORDR"));
				mapCondList2.put("ARV_STN_CONS_ORDR", condList.get(i).get("ARV_STN_CONS_ORDR"));
				mapCondList2.put("FCST_ACHV_DT", condList.get(i).get("FCST_ACHV_DT"));
				mapCondList2.put("YMGT_JOB_ID", condList.get(i).get("YMGT_JOB_ID"));
				mapCondList2.put("PRNB", condList.get(i).get("USR_CTL_EXPN_DMD_NUM"));
				mapCondList2.put("MAX_YMGT_JOB_ID", condMap.get("MAX_YMGT_JOB_ID"));
				mapCondList2.put("CHG_USR_ID", condMap.get("CHG_USR_ID"));
				mapCondList2.put("CHG_DTTM", condMap.get("CHG_DTTM"));

				resultOptList2.add(mapCondList2);
				rCnt++;	
			}
		}
		
		int max = -1;
		int fIdx = 0;
		int diffCnt; 
		
		for (int j = 0; j < rCnt; j++) 
		{
			if ( max < divPrnb.get(j))
			{
				max = divPrnb.get(j);
				fIdx = j;
			}
			
			diffCnt = prnb.get(j) - sumPrnb.get(j);
			
			if (fIdx > 0)
			{
				mapCondList.put("divPsno", String.valueOf(max + diffCnt));
				condList.set(fIdx, mapCondList);
			}
		}
		
		/*	 최적화 작업 (6) 승차인원 저장	*/
		
		int updateCnt =	dao.insert("com.korail.yz.yf.ca.YFCA001QMDAO.insertOpt6YgmtjobId", resultOptList2.get(0));
		if (updateCnt < 1)
		{
			throw new CosmosRuntimeException("WZZ000012", null);  //등록 작업이 실패하였습니다 - 입력값을 확인하십시오.			
		}else{
			LOGGER.debug("6번째 최적화 사전 작업 ["+updateCnt+"] 건 등록되었습니다.");
			XframeControllerUtils.setMessage("IZZ000013", result); //정상적으로 저장 되었습니다.
		}
		
		
		for (int j = 0; j < resultOptList2.size(); j++) 
		{	
			insertCnt = 1; 
			dao.update("com.korail.yz.yf.ca.YFCA001QMDAO.updateOpt6Pssr", resultOptList2.get(j));
			
			if (insertCnt < 1)
			{
				/*	 실패시 업데이트  - 조건(WHERE) MAX_YMGT_JOB_ID	*/
				dao.update("com.korail.yz.yf.ca.YFCA001QMDAO.updateOpt6YgmtFailResult", condMap);
				LOGGER.debug("6번째 최적화 작업 ["+insertCnt+"] 건 실패 하였습니다.");
				
				throw new CosmosRuntimeException("WZZ000012", null);  //등록 작업이 실패하였습니다 - 입력값을 확인하십시오.			
			}else{
				dao.update("com.korail.yz.yf.ca.YFCA001QMDAO.updateOpt6YgmtSucResult", condMap);
				LOGGER.debug("6번째 최적화 작업 ["+insertCnt+"] 건 등록되었습니다.");
				XframeControllerUtils.setMessage("IZZ000013", result); //정상적으로 저장 되었습니다.
			}
		}

//		/*	 최적화 작업 (7) - 출발/도착역별 승차인원 합계 계산	- 현재 쓰이지 않음	*/
//
//		boolean find = false;
//		
//		ArrayList<Map<String, Object>> resultSum = (ArrayList<Map<String,Object>>) dao.list("com.korail.yz.yf.ca.YFCA001QMDAO.listOpt7resultSum", condMap);
//		ArrayList<Map<String, Object>> sumCondList = new ArrayList<Map<String,Object>>();
//		int sumRCnt = resultSum.size();
//		
//		for (int i = 0; i < rCnt; i++) 
//		{
//			
//			for (int j = 0; j < sumRCnt; j++) 
//			{  
//				find = false;
//				
//				if (resultOptList2.get(i).get("DPT_STN_CONS_ORDR").equals(resultSum.get(j).get("DPT_STN_CONS_ORDR"))
//				 && resultOptList2.get(i).get("ARV_STN_CONS_ORDR").equals(resultSum.get(j).get("ARV_STN_CONS_ORDR")))
//				{
//					
//					Map<String, Object>	sumCond = new HashMap<String, Object>();
//					sumCond.putAll(resultSum.get(j));
//					Object USR_CTL_ABRD_PRNB = Integer.parseInt(String.valueOf(resultSum.get(j).get("USR_CTL_ABRD_PRNB"))) 
//												+ Integer.parseInt(String.valueOf(resultOptList2.get(i).get("PRNB")));
//					sumCond.put("USR_CTL_ABRD_PRNB", USR_CTL_ABRD_PRNB);
//					sumCondList.add(sumCond);
//					find = true;
//				}	
//			}
//				if (!find)
//				{
//					Map<String, Object>	sumCond = new HashMap<String, Object>();
//					sumCond.put("RUN_DT", condMap.get("RUN_DT"));
//					sumCond.put("TRN_NO", condMap.get("TRN_NO"));
//					sumCond.put("DPT_STN_CONS_ORDR", resultOptList2.get(i).get("DPT_STN_CONS_ORDR"));
//					sumCond.put("ARV_STN_CONS_ORDR", resultOptList2.get(i).get("ARV_STN_CONS_ORDR"));
//					sumCond.put("FCST_ACHV_DT", condMap.get("CHG_DTTM").substring(0, 8));
//					sumCond.put("YMGT_JOB_ID", condMap.get("MAX_YMGT_JOB_ID"));
//					sumCond.put("USR_CTL_ABRD_PRNB", resultOptList2.get(i).get("PRNB"));
//					sumCond.put("CHG_USR_ID", condMap.get("CHG_USR_ID"));
//					sumCond.put("CHG_DTTM", condMap.get("CHG_DTTM"));
//
//					sumCondList.add(sumCond);		
//				}
//		}

		/*	 최적화 작업 (8) - 작업자 아이디 저장 - MAX_YMGT_JOB_ID/CHG_DTTM/CHG_USR_ID	*/
		insertCnt = 0;
		insertCnt = dao.update("com.korail.yz.yf.ca.YFCA001QMDAO.insertOpt8YgmtJobId", condMap);
		
		if (insertCnt < 1)
		{
			throw new CosmosRuntimeException("WZZ000012", null);  //등록 작업이 실패하였습니다 - 입력값을 확인하십시오.			
		}else{
			LOGGER.debug("8번째 최적화 작업 ["+insertCnt+"] 건 등록되었습니다.");
			XframeControllerUtils.setMessage("IZZ000013", result); //정상적으로 저장 되었습니다.
		}

		/*	 최적화 작업 (9) - 최종탑승예측표준편차내역 업데이트 - MAX_YMGT_JOB_ID/TRN_NO/RUN_DT/YMGT_JOB_ID (TB_YYFD410, TB_YYFD411 통합)	*/
//		insertCnt = 0;
//		insertCnt = dao.update("com.korail.yz.yf.ca.YFCA001QMDAO.insertOpt9YgmtjobId", resultOptList2.get(0));
//
//		if (insertCnt < 1)
//		{
//			/*	 실패시 업데이트  - 조건(WHERE) MAX_YMGT_JOB_ID	*/
//			insertCnt = dao.update("com.korail.yz.yf.ca.YFCA001QMDAO.updateOpt9YgmtFailResult", condMap);
//			if (insertCnt < 1)
//			{
//				throw new CosmosRuntimeException("WZZ000012", null);  //등록 작업이 실패하였습니다 - 입력값을 확인하십시오.			
//			}else{
//				LOGGER.debug("9번째 최적화 후처리 N 작업 ["+insertCnt+"] 건 등록되었습니다.");
//				XframeControllerUtils.setMessage("IZZ000013", result); //정상적으로 저장 되었습니다.
//			}		
//		}else{
//			insertCnt = dao.update("com.korail.yz.yf.ca.YFCA001QMDAO.updateOpt9YgmtSucResult", condMap);
//			if (insertCnt < 1)
//			{
//				throw new CosmosRuntimeException("WZZ000012", null);  //등록 작업이 실패하였습니다 - 입력값을 확인하십시오.			
//			}else{
//				LOGGER.debug("9번째 최적화 후처리 Y 작업 ["+insertCnt+"] 건 등록되었습니다.");
//				XframeControllerUtils.setMessage("IZZ000013", result); //정상적으로 저장 되었습니다.
//			}	
//		}
		return result;
	}	
		
	/*	메시지 처리 메서드*/
	private Map<String, Object> sendMessage(ArrayList<Map<String, Object>> resultList,ArrayList<Map<String, Object>> resultList2, Map<String, Object> result, int num)
	{
		if ("0".equals(String.valueOf(num)))
		{
			if(resultList.isEmpty()){
				XframeControllerUtils.setMessage("IZZ000004", result); //해당 조건의 자료가 존재하지 않습니다.
			}
			else
			{
				XframeControllerUtils.setMessage("IZZ000009", result); //정상적으로 조회 되었습니다.
			}
		} else if ("1".equals(String.valueOf(num)))
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
	
	/*	출발-도착역그룹 List 생성 메서드 */
	private void dptArvList(Map<String, String> Cond, ArrayList<Map<String, String>> dptArvList, String stgpCd1, String stgpCd2, String StgpList, boolean bln){
		
		int i = 0;
		
		if (bln)
		{
			String item = "('";
			while(i < dptArvList.size())
			{
				String j = String.valueOf(i);
				
				item = item.concat(dptArvList.get(i).get(stgpCd1) + "','" + dptArvList.get(i).get(stgpCd2) + "'),('");

				if("1".equals(String.valueOf(dptArvList.size())))
				{
					item = item.substring(0 , item.length()-5);
					break;
				}else if(j.equals(String.valueOf(dptArvList.size()-2)))
				{
					item = item.concat(dptArvList.get(i+1).get(stgpCd1) + "','" + dptArvList.get(i+1).get(stgpCd2));
					break;
				}
				i++;			
			}
			if("('".equals(item))
			{
				item = item.concat("','");
			}
			
			Cond.put(StgpList, item.concat("')"));
		}else
		{
			String item = "'";
			while(i < dptArvList.size())
			{
				String j = String.valueOf(i);
				
				item = item.concat(dptArvList.get(i).get(stgpCd1) + "','");
				if("1".equals(String.valueOf(dptArvList.size())))
				{
					item = item.substring(0 , item.length()-3);
					break;
				}else if(j.equals(String.valueOf(dptArvList.size()-2)))
				{
					item = item.concat(dptArvList.get(i+1).get(stgpCd1));
					break;
				}
				i++;
			}
			Cond.put(StgpList, item.concat("'"));			
		}
	}
}

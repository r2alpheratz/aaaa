/**
 * project : KORAIL_YZ
 * package : com.korail.yz.ys.ee
 * date : 2014. 8. 22.오전 9:02:03
 */
package com.korail.yz.ys.ee;

import java.util.ArrayList;
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
import cosmos.comm.exception.CosmosRuntimeException;

/**
 * @author EQ
 * @date 2014. 8. 22. 오전 9:02:03
 * Class description : 특정할인시뮬레이션SVC
 * 열차를 선정하여 할인등급과 좌석수를 설정하는 시뮬레이션 기능을 위한 Service 클래스
 */

@Service("com.korail.yz.ys.ee.YSEE001SVC")
public class YSEE001SVC {
	
	@Resource(name="commDAO")
	private transient CommDAO dao;

	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public static final Logger LOGGER = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
	
	
	/**
	 * 특정할인 시뮬레이션 예상수요 조회
	 * @author 김응규
	 * @date 2014. 8. 22. 오후 7:02:00
	 * Method description : 특정할인 시뮬레이션 예상수요를 조회한다. 
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map<String, ?> selectListExpnDmd(Map<String, ?> param) {		

		Map<String, Object> result = new HashMap<String, Object>();

		LOGGER.debug("param ==> "+param);
		// search input column dataset
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");
		//열차운영사업자구분코드 추가
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		inputDataSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		LOGGER.debug("inputDataSet ==>  " + inputDataSet);
		
		//체크한 실적선택일자 string으로 변경하여 리턴
		String sAcvmRunDt = getAcvmRunDtToString(inputDataSet);
		//체크한 적용기간일자 string으로 변경하여 리턴
		String sAplTrmRunDt = getAplTrmToString(inputDataSet); 
		
		inputDataSet.put("RUN_DT_ARR", sAcvmRunDt);
		inputDataSet.put("RUN_DT_ARR2", sAplTrmRunDt);
		
		//수요예측 최적화할당 정보조회
		ArrayList<Map<String, Object>> resultList = (ArrayList) dao.list("com.korail.yz.ys.ee.YSEE001QMDAO.selectListExpnDmd", inputDataSet);
		
		//메시지 처리
		if(resultList.isEmpty())
		{
			XframeControllerUtils.setMessage("IZZ000004", result); //해당 조건의 자료가 존재하지 않습니다.
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result); //정상적으로 조회 되었습니다.
		}
		result.put("dsList", resultList);
		
		return result;

	}
	
	
	/**
	 * 특정할인 시뮬레이션 예상수요 상세조회
	 * @author 김응규
	 * @date 2014. 8. 25. 오후 5:02:00
	 * Method description : 특정할인 시뮬레이션 예상수요를 상세조회한다. 
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map<String, ?> selectListExpnDmdDtl(Map<String, ?> param) {		

		Map<String, Object> result = new HashMap<String, Object>();

		LOGGER.debug("param ==> "+param);
		// search input column dataset
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCondDtl");
		//열차운영사업자구분코드 추가
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		inputDataSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		LOGGER.debug("inputDataSet ==>  " + inputDataSet);
		
		//체크한 적용기간일자 string으로 변경하여 리턴
		String sAplTrmRunDt = getAplTrmToString(inputDataSet); 
		inputDataSet.put("RUN_DT_ARR", sAplTrmRunDt);
		
		
		//예상수요 상세조회
		ArrayList<Map<String, Object>> resultList = (ArrayList) dao.list("com.korail.yz.ys.ee.YSEE001QMDAO.selectListExpnDmdDtl", inputDataSet);
		
		//메시지 처리
		if(resultList.isEmpty())
		{
			XframeControllerUtils.setMessage("IZZ000004", result); //해당 조건의 자료가 존재하지 않습니다.
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result); //정상적으로 조회 되었습니다.
		}
		result.put("dsListDtl", resultList);
		
		return result;

	}
	
	/**
	 * 특정할인 시뮬레이션 실행
	 * @author 김응규
	 * @date 2014. 8. 22. 오후 7:02:00
	 * Method description : 특정할인 시뮬레이션을 실행한다.
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "unchecked" })
	public Map<String, ?> selectListSimlExc(Map<String, ?> param) {		

		Map<String, Object> result = new HashMap<String, Object>();
		
		//시뮬레이션 그리드에 출력할 List
		ArrayList<Map<String, String>> simlList = new ArrayList<Map<String,String>>();
		Map<String, String> simlMap = new HashMap<String, String>();

		LOGGER.debug("param ==> "+param);
		// search input column dataset (Map)
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");
		//사용자계정 전역데이터셋
		Map<String, String> gdsUserInfoMap = XframeControllerUtils	.getParamDataSet(param, "GDS_USER_INFO");
		
		String sTrnOprBzDvCd = gdsUserInfoMap.get("TRN_OPR_BZ_DV_CD"); //열차운영사업자구분코드
		String userId = String.valueOf(param.get("USER_ID"));
		inputDataSet.put("TRN_OPR_BZ_DV_CD", sTrnOprBzDvCd);
		inputDataSet.put("USER_ID", userId);
		
		LOGGER.debug("inputDataSet ==>  " + inputDataSet);
		
		//데이터셋 받아오기(List)
		//dsList에서 체크한 row만 뽑아온 Dataset
		ArrayList<Map<String, String>> inputCheckList = (ArrayList<Map<String, String>>) param.get("dsListCopy");
		//할인적용 수요
		ArrayList<Map<String, String>> inputDcntAplList = (ArrayList<Map<String, String>>) param.get("dsList2");
		
		
		
		
		String sPsrmClCd = "";
		String sRunDt = "";
		String sTrnNo = "";
		String sTrnNoWeek = "";
		double dFcstAbrdRtDeviation = 0; //예상승차율 편차
		double dAbrdRt = 0; //수요증감율, 수입증감율
		//double dSaleRt = 0;
		
		//int iCurRow;
		
		int iSaleCnt = 0;
		int iAllSaleCnt = 0;
		String sTrnNoTmp = "";
		
		sPsrmClCd = inputDataSet.get("PSRM_CL_CD");
		
		
		//체크한 적용기간일자 string으로 변경하여 리턴
		String sAplTrmRunDt = getAplTrmToString(inputDataSet); 
		inputDataSet.put("RUN_DT_ARR", sAplTrmRunDt);
		
		
		//열차번호, 운행일자는 예상승차율이 평균에 가장 가까운 것을 선택한다. -- 편차가 가장 적은것.
		
		dFcstAbrdRtDeviation = calculateFcstAbrdRtDeviation(inputCheckList, 0); //0번째 row의 편차
		sRunDt = inputCheckList.get(0).get("RUN_DT_MIN");
		sTrnNo = inputCheckList.get(0).get("TRN_NO");
		for (int i = 1; i < inputCheckList.size(); i++)
		{
			if(dFcstAbrdRtDeviation > calculateFcstAbrdRtDeviation(inputCheckList, i))
			{
				sRunDt = inputCheckList.get(i).get("RUN_DT_MIN");
				sTrnNo = inputCheckList.get(i).get("TRN_NO");
				dFcstAbrdRtDeviation = calculateFcstAbrdRtDeviation(inputCheckList, i); //i번째 row의 편차(평균과의 차이)
				//iCurRow = i;
			}
		}
		
		//평균승차율
		double dAbrdRtOri = Math.round(calculateFcstAbrdRtAverage(inputCheckList));
		LOGGER.debug("평균승차율 :::["+dAbrdRtOri+"]");
		
		if(!inputDcntAplList.isEmpty()) //할인적용수요 그리드에 값이 있는경우(할인실적 참조를 한경우)
		{
			LOGGER.debug("할인적용수요 그리드에 값이 있는경우(할인실적 참조를 한경우)!!!!!!!!!!!");
			dAbrdRt = Double.parseDouble(inputDcntAplList.get(0).get("SALE_RT")); //수요증감율
			//dSaleRt = Double.parseDouble(inputDcntAplList.get(0).get("AMT_RT"));  //수입증감율
		}
		else //할인적용수요 그리드에 값이 없는 경우(할인실적 참조를 하지 않은경우)
		{
			LOGGER.debug("할인적용수요 그리드에 값이 없는 경우(할인실적 참조를 하지 않은경우)");
			Map<String, String> paramMap = new HashMap<String, String>();
			paramMap.put("TRN_NO", sTrnNo);
			paramMap.put("RUN_DT_ARR", sAplTrmRunDt);
			
			//4주평균 특정할인 건수 조회
			LOGGER.debug("4주평균 특정할인 건수 조회!!!!!!!!!!!");
			Map<String, Object> bkclAplCntMap = (Map<String, Object>) dao.select("com.korail.yz.ys.ee.YSEE001QMDAO.selectBkclAplCnt", paramMap);
			
			
			// 4주 평균 특정할인 적용이 있으면 할인증가율이 0이다.
			// 4주 평균 특정할인 적용이 안되어 있으면 출발시각으로 가장 가까운것 열차중에서 특정할인 실적값을 가져온다
			// 할인증가율 =  (특정할인 승차인원 / 총차인원 ) * 100
			if(Integer.parseInt(String.valueOf(bkclAplCntMap.get("CNT"))) > 0) //특정할인 적용을 하고있는경우
			{
				dAbrdRt = 0; //수요증감율
				//dSaleRt = 0; //수입증감율
			}
			else
			{
				LOGGER.debug("일주일 전일자 조회!!!!!!!!!!!!!!!!!!!!");
				Map<String, String> oneWkBfRunDtMap = (Map<String, String>) dao.select("com.korail.yz.ys.ee.YSEE001QMDAO.selectOneWkBfRunDt", inputDataSet);
				
				sTrnNoWeek = sTrnNo;
				
				LOGGER.debug("특정할인적용열차 건수 조회!!!!!!!!!!!!!!!!!!!");
				Map<String, Object> saplTrnCntMap = (Map<String, Object>) dao.select("com.korail.yz.ys.ee.YSEE001QMDAO.selectSaplTrnCnt", oneWkBfRunDtMap);
				
				
				for(int i = 0; i < Integer.parseInt(String.valueOf(saplTrnCntMap.get("TRN_CNT"))); i++)
				{
					Map<String, String> weekParamMap = new HashMap<String, String>();
					weekParamMap.put("WEEK_RUN_DT", oneWkBfRunDtMap.get("WEEK_RUN_DT"));
					weekParamMap.put("TRN_NO_WEEK", sTrnNoWeek);
					LOGGER.debug("weekParamMap :::=>"+weekParamMap.toString());
					Map<String, Object> saleCntMap = new HashMap<String, Object>();
					saleCntMap = (Map<String, Object>) dao.select("com.korail.yz.ys.ee.YSEE001QMDAO.selectSaleCnt", weekParamMap);
					
					iSaleCnt = Integer.parseInt(String.valueOf(saleCntMap.get("S_SALE_CNT")));
					iAllSaleCnt = Integer.parseInt(String.valueOf(saleCntMap.get("ALL_SALE_CNT")));
					sTrnNoTmp = String.valueOf(saleCntMap.get("TRN_NO_TMP"));
					// ?? as-is에 주석이 이렇게 달려있다 :  찾을경우? 
					if(iSaleCnt != 0 && iAllSaleCnt != 0) 
					{
						break;
					}
					
					// ?? as-is에 주석이 이렇게 달려있다 : 반복수행을 했어도 찾지 못했을경우
					if("0".equals(sTrnNoTmp))
					{
						break;
					}
					sTrnNoWeek = sTrnNoTmp;
					
				} //END for
				
				
				//출발시각 기준으로 특정할인이 있는 가장 낮은 열차를 찾는다.
				if(sTrnNoTmp.isEmpty())
				{
					sTrnNoWeek = sTrnNo;
					for (int i = 0; i < Integer.parseInt(String.valueOf(saplTrnCntMap.get("TRN_CNT"))); i++)
					{
						Map<String, String> weekParamMap2 = new HashMap<String, String>();
						weekParamMap2.put("WEEK_RUN_DT", oneWkBfRunDtMap.get("WEEK_RUN_DT"));
						weekParamMap2.put("TRN_NO_WEEK", sTrnNoWeek);
						
						Map<String, String> saleCntMap2 = new HashMap<String, String>();
						saleCntMap2 = (Map<String, String>) dao.select("com.korail.yz.ys.ee.YSEE001QMDAO.selectSaplTrnCnt2", weekParamMap2);
						iSaleCnt = Integer.parseInt(saleCntMap2.get("S_SALE_CNT"));
						iAllSaleCnt = Integer.parseInt(saleCntMap2.get("ALL_SALE_CNT"));
						sTrnNoTmp = saleCntMap2.get("TRN_NO_TMP");
						//?? 찾을경우
						if(iSaleCnt != 0 && iAllSaleCnt != 0)
						{
							break;
						}
						
						sTrnNoWeek = sTrnNoTmp;
					}
				} //END if(sTrnNoTmp.isEmpty())
				
				if(iAllSaleCnt <= 0)
				{
					dAbrdRt = 0;
					iSaleCnt = 0;
				}
				else
				{
					dAbrdRt = round((double) (iSaleCnt / iAllSaleCnt), 3); //수요증감율
					//dSaleRt = round((double) (iSaleCnt / iAllSaleCnt), 3); //수입증감율
				}
				
			} //END  else
		} //END  else
		
		
		
		/**
		 * 적용전 승차율 66% 이상 => 할인율 : 0% , 공급좌석수 : 0 석 , 적용일수 : D-60 , D-1
		 * 
		 * 적용전 승차율 66% 미만 => 할인율 max(0.4 , 100 * (( 66 - 적용전 승차율 ) / 66) )
		 *                        => 공급좌석수 : 일반석 * max(0, 1- 적용후 구간통과율 - 0.1)
		 * */
		
		
		/**
		 * 적용후 승차율 = 적용전 승차율 * ( 1 + (추가승차인원 / 총승차인원)) 
		 * 
		 * 추가승차인원 / 총승차인원 = 수요증감율
		 * */ 
		
		
		if (dAbrdRtOri >= 66)
		{
			simlMap.put("BKCL_DT", sRunDt); //적용일자~8주
			simlMap.put("APL_AFT_FCST_ABRD_RT", String.valueOf(dAbrdRtOri)); //적용전예상승차율
			simlMap.put("APL_BF_FCST_ABRD_RT", String.valueOf(dAbrdRtOri));  //적용후예상승차율
			simlMap.put("DCNT_RT", "0"); //할인율
			simlMap.put("SPL_SEAT_NUM", "0"); //공급좌석수
			simlMap.put("APL_CLS_DT_DNO", "60"); //개폐시점 개시(D)
			simlMap.put("APL_ST_DT_DNO", "0"); //개폐시점 종료(D)
		}
		else
		{
			Map<String, String> paramMap = new HashMap<String, String>();
			paramMap.put("RUN_DT", sRunDt);
			paramMap.put("TRN_NO", sTrnNo);
			paramMap.put("PSRM_CL_CD", sPsrmClCd);
			//구간 최고 승차인원 구하기(일반좌석)
			LOGGER.debug("구간 최고 승차인원 구하기(일반좌석)!!!!!!!!!!!!");
			Map<String, Object> maxPrnbMap = (Map<String, Object>) dao.select("com.korail.yz.ys.ee.YSEE001QMDAO.selectSegMaxPrnb", paramMap);
			int iMaxPrnb = Integer.parseInt(String.valueOf(maxPrnbMap.get("MAX_PRNB")));
			LOGGER.debug("MAX_PRNB ::::::"+iMaxPrnb);
			//총 좌석수 구하기
			LOGGER.debug("총 좌석수 구하기!!!!!!!!!!!!");
			Map<String, Object> bsSeatNumMap = (Map<String, Object>) dao.select("com.korail.yz.ys.ee.YSEE001QMDAO.selectBsSeatNum", paramMap);
			int iBsSeatNum = Integer.parseInt(String.valueOf(bsSeatNumMap.get("BS_SEAT_NUM")));
			LOGGER.debug("BS_SEAT_NUM ::::::"+iBsSeatNum);
			
			//적용후 구간통과율구하기
			double dMaxPrnbAft = (iMaxPrnb == 0) ? 0 : truncate((iMaxPrnb * (dAbrdRt + 1)) / iSaleCnt, 1);
			LOGGER.debug("적용후 구간통과율 dMaxPrnbAft ::: "+ dMaxPrnbAft);
			
			simlMap.put("BKCL_DT", sRunDt); //적용일자~8주
			simlMap.put("APL_AFT_FCST_ABRD_RT", String.valueOf(dAbrdRtOri)); //적용전예상승차율
			
			String sAplBfFcstAbrdRt = String.valueOf(round(Math.min((1+ dAbrdRt) * (dAbrdRtOri * 0.01), 0.66) * 100 , 1));
			LOGGER.debug("적용후예상승차율 sAplBfFcstAbrdRt ::: "+ sAplBfFcstAbrdRt);
			simlMap.put("APL_BF_FCST_ABRD_RT", sAplBfFcstAbrdRt);  //적용후예상승차율
			
			String sDcntRt = String.valueOf(round(Math.min(Math.max(67 - dAbrdRtOri, 0) / 67, 0.4) * 100, 1));
			LOGGER.debug("할인율 sDcntRt ::: "+ sDcntRt);
			simlMap.put("DCNT_RT", sDcntRt); //할인율
			
			double dDcntRtAft = Double.parseDouble(sDcntRt);
			String sSplSeatNum = String.valueOf(round(Math.min(iBsSeatNum * Math.max(0, (1 - dMaxPrnbAft - 0.1)), 100), 0));
			LOGGER.debug("공급좌석수 sSplSeatNum ::: "+ sSplSeatNum);
			simlMap.put("SPL_SEAT_NUM", sSplSeatNum); //공급좌석수
			
			simlMap.put("APL_CLS_DT_DNO", "60"); //개폐시점 개시(D)
			
			String sAplStDtDno = "";
			if(dDcntRtAft > 30)
			{
				sAplStDtDno = "3";
			}
			else if(dDcntRtAft > 20)
			{
				sAplStDtDno = "2";
			}
			else
			{
				sAplStDtDno = "1";
			}
			simlMap.put("APL_ST_DT_DNO", sAplStDtDno); //개폐시점 종료(D)
			
		}
		LOGGER.debug("simlMap ==========>"+simlMap);
		simlList.add(simlMap);
		
		//메시지 처리
		if(simlList.isEmpty())
		{
			throw new CosmosRuntimeException("EYP000002", null); //시뮬레이션수행중 오류가 발생하였습니다.
		}
		else
		{
			XframeControllerUtils.setMessage("IYR000001", result); //시뮬레이션이 수행되었습니다.
		}
		result.put("dsList3", simlList);
		
		return result;

	}
	
	/**
	 * 특정할인 시뮬레이션 할인적용대상열차 조회
	 * @author 김응규
	 * @date 2014. 9. 1. 오후 4:56:16
	 * Method description : 특정할인 시뮬레이션 할인적용대상열차를 조회한다. 
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map<String, ?> selectListDcntAplTgtTrn(Map<String, ?> param) {		

		Map<String, Object> result = new HashMap<String, Object>();

		LOGGER.debug("param ==> "+param);
		// search input column dataset
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");
		//열차운영사업자구분코드 추가
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		inputDataSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		LOGGER.debug("inputDataSet ==>  " + inputDataSet);
		
		
		//수요예측 최적화할당 정보조회
		ArrayList<Map<String, Object>> resultList = (ArrayList) dao.list("com.korail.yz.ys.ee.YSEE001QMDAO.selectListDcntAplTgtTrn", inputDataSet);
		
		//메시지 처리
		if(resultList.isEmpty())
		{
			XframeControllerUtils.setMessage("IZZ000004", result); //해당 조건의 자료가 존재하지 않습니다.
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result); //정상적으로 조회 되었습니다.
		}
		result.put("dsList", resultList);
		
		return result;

	}

	/**
	 * 특정할인 적용내역 데이터 건수 조회
	 * @author 김응규
	 * @date 2014. 9. 2. 오후 4:42:00
	 * Method description : 특정할인 적용내역에 데이터가 존재하는지 확인한다.
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "unchecked" })
	public Map<String, ?> selectExistSaplCnt(Map<String, ?> param) {		

		Map<String, Object> result = new HashMap<String, Object>();
		LOGGER.debug("param ==> "+param);
		// search input column dataset
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");
		//사용자계정 전역데이터셋
		Map<String, String> gdsUserInfoMap = XframeControllerUtils	.getParamDataSet(param, "GDS_USER_INFO");
		
		String sTrnOprBzDvCd = gdsUserInfoMap.get("TRN_OPR_BZ_DV_CD"); //열차운영사업자구분코드
		String userId = String.valueOf(param.get("USER_ID"));
		inputDataSet.put("TRN_OPR_BZ_DV_CD", sTrnOprBzDvCd);
		inputDataSet.put("USER_ID", userId);
		LOGGER.debug("inputDataSet ==>  " + inputDataSet);
		
		//데이터셋 받아오기(List)
		//dsList에서 체크한 row만 뽑아온 Dataset
		ArrayList<Map<String, String>> inputCheckList = (ArrayList<Map<String, String>>) param.get("dsListCopy");
		
		ArrayList<Map<String, Object>> resultList = new ArrayList<Map<String,Object>>();
		Map<String, Object> resultMap = new HashMap<String, Object>();
		for (int i = 0; i < inputCheckList.size(); i++)
		{
			Map<String, String> item = inputCheckList.get(i);
			item.put("RUN_TRM_ST_DT", inputDataSet.get("RUN_TRM_ST_DT"));
			item.put("RUN_TRM_CLS_DT", inputDataSet.get("RUN_TRM_CLS_DT"));
			item.put("DAY_DV_CD", inputDataSet.get("DAY_DV_CD"));
			item.put("PSRM_CL_CD", inputDataSet.get("PSRM_CL_CD"));
			LOGGER.debug("할인적용내역 존재여부 확인!!!! ["+i+"]");
			Map<String, Object> saplMap = (Map<String, Object>) dao.select("com.korail.yz.ys.ee.YSEE001QMDAO.selectSaplCnt", item);
			if(Integer.parseInt(String.valueOf(saplMap.get("CNT"))) > 0)
			{
				LOGGER.debug("할인적용 건수가 있어서 삭제 후 작업해야 합니다.");
				resultMap.put("DEL_FLG", "Y");
				break;
			}
		}
		resultList.add(resultMap);
		result.put("dsExist", resultList);
		
		return result;

	}
	//deleteDcntApl
	/**
	 * 특정할인 할인적용내역 삭제
	 * @author 김응규
	 * @date 2014. 9. 2. 오후 4:42:00
	 * Method description : 기존에 등록되어있는 특정할인적용내역을 삭제한다.
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "unchecked" })
	public Map<String, ?> deleteDcntApl(Map<String, ?> param) {		

		Map<String, Object> result = new HashMap<String, Object>();
		LOGGER.debug("param ==> "+param);
		// search input column dataset
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");	
		//사용자계정 전역데이터셋
		Map<String, String> gdsUserInfoMap = XframeControllerUtils	.getParamDataSet(param, "GDS_USER_INFO");
		
		String sTrnOprBzDvCd = gdsUserInfoMap.get("TRN_OPR_BZ_DV_CD"); //열차운영사업자구분코드
		String userId = String.valueOf(param.get("USER_ID"));
		inputDataSet.put("TRN_OPR_BZ_DV_CD", sTrnOprBzDvCd);
		inputDataSet.put("USER_ID", userId);
		
		LOGGER.debug("inputDataSet ==>  " + inputDataSet);
		
		
		//데이터셋 받아오기(List)
		//dsList에서 체크한 row만 뽑아온 Dataset
		ArrayList<Map<String, String>> inputCheckList = (ArrayList<Map<String, String>>) param.get("dsListCopy");
		int deleteCnt = 0;
		for (int i = 0; i < inputCheckList.size(); i++)
		{
			Map<String, String> item = inputCheckList.get(i);
			item.put("RUN_TRM_ST_DT", inputDataSet.get("RUN_TRM_ST_DT"));
			item.put("RUN_TRM_CLS_DT", inputDataSet.get("RUN_TRM_CLS_DT"));
			item.put("DAY_DV_CD", inputDataSet.get("DAY_DV_CD"));
			item.put("PSRM_CL_CD", inputDataSet.get("PSRM_CL_CD"));
			deleteCnt += dao.delete("com.korail.yz.ys.ee.YSEE001QMDAO.deleteSaplSpec", item);
		}
		LOGGER.debug("총 ["+deleteCnt+"] 건 삭제되었습니다.");
		
		return result;
	}
	
	
	/**
	 * 특정할인 할인적용내역 저장
	 * @author 김응규
	 * @date 2014. 9. 2. 오후 4:42:00
	 * Method description : 시뮬레이션 수행한 특정할인 할인적용내역을 저장한다.
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "unchecked" })
	public Map<String, ?> insertDcntApl(Map<String, ?> param) {		

		Map<String, Object> result = new HashMap<String, Object>();
		LOGGER.debug("param ==> "+param);
		// search input column dataset
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");	
		//사용자계정 전역데이터셋
		Map<String, String> gdsUserInfoMap = XframeControllerUtils	.getParamDataSet(param, "GDS_USER_INFO");
		
		String sTrnOprBzDvCd = gdsUserInfoMap.get("TRN_OPR_BZ_DV_CD"); //열차운영사업자구분코드
		String userId = String.valueOf(param.get("USER_ID"));
		inputDataSet.put("TRN_OPR_BZ_DV_CD", sTrnOprBzDvCd);
		inputDataSet.put("USER_ID", userId);
		
		LOGGER.debug("inputDataSet ==>  " + inputDataSet);
		
		ArrayList<Map<String, Object>> resultList = new ArrayList<Map<String,Object>>();
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		//데이터셋 받아오기(List)
		//dsList에서 체크한 row만 뽑아온 Dataset
		ArrayList<Map<String, String>> inputCheckList = (ArrayList<Map<String, String>>) param.get("dsListCopy");
		
		ArrayList<Map<String, String>> segGpNoList = new ArrayList<Map<String,String>>();
		
		if("1".equals(inputDataSet.get("CHK_ALL")))
		{
			Map<String, String> segGpNoMap = new HashMap<String, String>();
			segGpNoMap.put("SEG_GP_NO", "%");
			segGpNoList.add(segGpNoMap);
		}
		if("1".equals("CHK_SEG1"))
		{
			Map<String, String> segGpNoMap = new HashMap<String, String>();
			segGpNoMap.put("SEG_GP_NO", "1");
			segGpNoList.add(segGpNoMap);
		}
		if("1".equals("CHK_SEG2"))
		{
			Map<String, String> segGpNoMap = new HashMap<String, String>();
			segGpNoMap.put("SEG_GP_NO", "2");
			segGpNoList.add(segGpNoMap);
		}
		if("1".equals("CHK_SEG3"))
		{
			Map<String, String> segGpNoMap = new HashMap<String, String>();
			segGpNoMap.put("SEG_GP_NO", "3");
			segGpNoList.add(segGpNoMap);
		}
		if("1".equals("CHK_SEG4"))
		{
			Map<String, String> segGpNoMap = new HashMap<String, String>();
			segGpNoMap.put("SEG_GP_NO", "4");
			segGpNoList.add(segGpNoMap);
		}
		
		int insertCnt = 0;
		for (int i = 0; i < inputCheckList.size(); i++)
		{
			Map<String, String> item = inputCheckList.get(i);
			item.put("RUN_TRM_ST_DT", inputDataSet.get("RUN_TRM_ST_DT"));
			item.put("RUN_TRM_CLS_DT", inputDataSet.get("RUN_TRM_CLS_DT"));
			item.put("DAY_DV_CD", inputDataSet.get("DAY_DV_CD"));
			item.put("PSRM_CL_CD", inputDataSet.get("PSRM_CL_CD"));
			
			item.put("STAT_DNO", inputDataSet.get("STAT_DNO"));
			item.put("CLS_DNO", inputDataSet.get("CLS_DNO"));
			item.put("BKCL_CD", inputDataSet.get("BKCL_CD"));
			item.put("DCNT_SPL_SEAT_NUM", inputDataSet.get("DCNT_SPL_SEAT_NUM"));
			item.put("PRC_DCNT_RT", inputDataSet.get("PRC_DCNT_RT"));
			item.put("USER_ID", inputDataSet.get("USER_ID"));
			for (int j = 0; j < segGpNoList.size(); j++)
			{
				Map<String, String> itemParam = segGpNoList.get(j);
				itemParam.putAll(item);
				
				insertCnt += dao.insert("com.korail.yz.ys.ee.YSEE001QMDAO.insertTB_YYSD014", itemParam);
			}
			
		}
		
		//메시지 처리
  		if(insertCnt < 1){
  			throw new CosmosRuntimeException("EZZ000018", null);  ////저장 중 오류가 발생하였습니다.
  		}
  		else
  		{
  			resultMap.put("RESULT", "SUCCESS");
  			resultList.add(resultMap);
  			XframeControllerUtils.setMessage("IZZ000013", result); //정상적으로 저장 되었습니다.
  		}
  		result.put("dsResult", resultList);
		return result;

	}
	
	/**
	 * 소숫점 이하 x째 자리까지만 표시(버림)
	 * @author 김응규
	 * @date 2014. 8. 28. 오전 10:02:03
	 * Method description : 소숫점이하 자릿수만큼 버린 값을 리턴한다.
	 * @param  double d : 소숫점 아래를 버릴 실수
	 *         int n    : 소숫점 버릴 자릿수
	 * @return double : d를 소숫점 이하 n번째 자리에서 버린 값. 
	 */
	static double truncate(double d, int n)
	{
		return Math.floor(d*Math.pow(10, n)) / Math.pow(10, n);
	}
	
	/**
	 * 소숫점 이하 x째 자리까지 반올림.
	 * @author 김응규
	 * @date 2014. 8. 28. 오전 10:02:03
	 * Method description : 소숫점이하 자릿수만큼 반올림한 값을 리턴한다.
	 * @param  double d : 반올림할 실수
	 *         int n    : 소숫점 이하 반올림할 자릿수
	 * @return double : d를 소숫점 이하 n번째 자리까지 반올림한 값
	 */
	static double round(double d, int n)
	{
		return Math.round(d*Math.pow(10, n)) / Math.pow(10, n);
	}
	
	
	/**
	 * 예상승차율 평균 구하기
	 * @author 김응규
	 * @date 2014. 8. 27. 오전 10:02:03
	 * Method description : 
	 * @param  ArrayList<Map<String, String>> inputCheckList : dsListCopy(체크한row를 복사한 Dataset)
	 * @return String dFcstAbrdRtDeviation : 체크한 row의 표준편차 값 
	 */
	private double calculateFcstAbrdRtAverage(ArrayList<Map<String, String>> inputCheckList)
	{
		double dFcstAbrdRtAverage = 0.0; //예상승차율 평균값
		double dTotFcstAbrdRt = 0.0; //예상승차율 합계
		int iRowCnt = inputCheckList.size();
		
		//예상승차율 합계구하기
		for (int i = 0; i < iRowCnt; i++)
		{
			dTotFcstAbrdRt += Double.parseDouble(inputCheckList.get(i).get("FCST_ABRD_RT"));
		}
		
		dFcstAbrdRtAverage = dTotFcstAbrdRt / (double) iRowCnt;
		LOGGER.debug("예상승차율 평균 :::: ["+dFcstAbrdRtAverage+"]");
		return dFcstAbrdRtAverage;
	}

	/**
	 * 예상승차율 편차구하기
	 * @author 김응규
	 * @date 2014. 8. 27. 오전 10:02:03
	 * Method description : 
	 * @param  ArrayList<Map<String, String>> inputCheckList : dsListCopy(체크한row를 복사한 Dataset) 
	 *         int iRow : i번째 row 
	 * @return String dFcstAbrdRtDeviation : 체크한 row의 표준편차 값 
	 */
	private double calculateFcstAbrdRtDeviation(ArrayList<Map<String, String>> inputCheckList, int iRow)
	{
		double dFcstAbrdRtDeviation = 0.0; //예상승차율 편차
		
		//예상승차율 편차구하기((평균 - 현재값) 의 절대값)
		dFcstAbrdRtDeviation = Math.abs(calculateFcstAbrdRtAverage(inputCheckList)
				               - Double.parseDouble(inputCheckList.get(iRow).get("FCST_ABRD_RT")));
		LOGGER.debug("예상승차율 편차 ::::["+iRow+"] 번째 값 === ["+dFcstAbrdRtDeviation+"]");
		return dFcstAbrdRtDeviation;
	}
	/**
	 * 체크한 실적선택 일자 문자열로 가져오기(1주전~4주전)
	 * @author 김응규
	 * @date 2014. 8. 26. 오후 9:02:03
	 * Method description : 체크한 실적선택 x주전 일자를 String형태로 합쳐서 리턴한다.
	 * @param  Map<String, String> inputDataSet : dsCond(조회조건) 
	 * @return String sConcatRunDt : 체크한 실적선택 x주전 일자를 문자열로 합친 값. 
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	private String getAcvmRunDtToString(Map<String, String> inputDataSet)
	{
		List<String> runDtArrayList = new ArrayList<String>();
		if("1".equals(inputDataSet.get("ACVM_WK_BF1"))) //실적선택 1주전
		{
			ArrayList<Map<String, Object>> runDtList = (ArrayList) dao.list("com.korail.yz.ys.ee.YSEE001QMDAO.selectPastAcvm1WkBf", inputDataSet);
			runDtArrayList.add(String.valueOf(runDtList.get(0).get("RUN_DT")));
			LOGGER.debug("실적선택 1주전 RUN_DT:::::"+runDtList.get(0).get("RUN_DT") );
		}
		if("1".equals(inputDataSet.get("ACVM_WK_BF2"))) //실적선택 2주전
		{
			ArrayList<Map<String, Object>> runDtList = (ArrayList) dao.list("com.korail.yz.ys.ee.YSEE001QMDAO.selectPastAcvm2WkBf", inputDataSet);
			runDtArrayList.add(String.valueOf(runDtList.get(0).get("RUN_DT")));
			LOGGER.debug("실적선택 2주전 RUN_DT:::::"+runDtList.get(0).get("RUN_DT") );
		}
		if("1".equals(inputDataSet.get("ACVM_WK_BF3"))) //실적선택 3주전
		{
			ArrayList<Map<String, Object>> runDtList = (ArrayList) dao.list("com.korail.yz.ys.ee.YSEE001QMDAO.selectPastAcvm3WkBf", inputDataSet);
			runDtArrayList.add(String.valueOf(runDtList.get(0).get("RUN_DT")));
			LOGGER.debug("실적선택 3주전 RUN_DT:::::"+runDtList.get(0).get("RUN_DT") );
		}
		if("1".equals(inputDataSet.get("ACVM_WK_BF4"))) //실적선택 4주전
		{
			ArrayList<Map<String, Object>> runDtList = (ArrayList) dao.list("com.korail.yz.ys.ee.YSEE001QMDAO.selectPastAcvm4WkBf", inputDataSet);
			runDtArrayList.add(String.valueOf(runDtList.get(0).get("RUN_DT")));
			LOGGER.debug("실적선택 4주전 RUN_DT:::::"+runDtList.get(0).get("RUN_DT") );
		}
		
		//실적선택 x주전 RUN_DT 배열 CONCAT한 String으로 리턴
		int dayCnt = runDtArrayList.size();
		String sConcatRunDt = "";
		for (int i = 0; i < dayCnt; i++)
		{
			if(i == 0)
			{
				sConcatRunDt = "'".concat(runDtArrayList.get(i)).concat("'");
			}
			else
			{
				sConcatRunDt = sConcatRunDt.concat( ",'").concat(runDtArrayList.get(i)).concat("'");
			}
			
		}
		LOGGER.debug("sConcatRunDt(실적선택x주전):::::"+sConcatRunDt );
		
		return sConcatRunDt;
	}
	
	/**
	 * 체크한 적용기간 문자열로 가져오기(1주~8주)
	 * @author 김응규
	 * @date 2014. 8. 26. 오후 9:02:03
	 * Method description : 체크한 적용기간을 String형태로 합쳐서 리턴한다.
	 * @param  Map<String, String> inputDataSet : dsCond(조회조건) 
	 * @return String sConcatRunDt : 체크한 적용기간을 문자열로 합친 값. 
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	private String getAplTrmToString(Map<String, String> inputDataSet)
	{
		List<String> runDtArrayList = new ArrayList<String>();
		if("1".equals(inputDataSet.get("APL_TRM1"))) // 적용기간 1주 체크시
		{
			ArrayList<Map<String, Object>> runDtList = (ArrayList) dao.list("com.korail.yz.ys.ee.YSEE001QMDAO.selectAplTrm1Wk", inputDataSet);
			runDtArrayList.add(String.valueOf(runDtList.get(0).get("RUN_DT")));
			LOGGER.debug("적용기간 1주 RUN_DT:::::"+runDtList.get(0).get("RUN_DT") );
		}
		if("1".equals(inputDataSet.get("APL_TRM2"))) // 적용기간 2주 체크시
		{
			ArrayList<Map<String, Object>> runDtList = (ArrayList) dao.list("com.korail.yz.ys.ee.YSEE001QMDAO.selectAplTrm2Wk", inputDataSet);
			runDtArrayList.add(String.valueOf(runDtList.get(0).get("RUN_DT")));
			LOGGER.debug("적용기간 2주 RUN_DT:::::"+runDtList.get(0).get("RUN_DT") );
		}
		if("1".equals(inputDataSet.get("APL_TRM3"))) // 적용기간 3주 체크시
		{
			ArrayList<Map<String, Object>> runDtList = (ArrayList) dao.list("com.korail.yz.ys.ee.YSEE001QMDAO.selectAplTrm3Wk", inputDataSet);
			runDtArrayList.add(String.valueOf(runDtList.get(0).get("RUN_DT")));
			LOGGER.debug("적용기간 3주 RUN_DT:::::"+runDtList.get(0).get("RUN_DT") );
		}
		if("1".equals(inputDataSet.get("APL_TRM4"))) // 적용기간 4주 체크시
		{
			ArrayList<Map<String, Object>> runDtList = (ArrayList) dao.list("com.korail.yz.ys.ee.YSEE001QMDAO.selectAplTrm4Wk", inputDataSet);
			runDtArrayList.add(String.valueOf(runDtList.get(0).get("RUN_DT")));
			LOGGER.debug("적용기간 4주 RUN_DT:::::"+runDtList.get(0).get("RUN_DT") );
		}
		if("1".equals(inputDataSet.get("APL_TRM5"))) // 적용기간 5주 체크시
		{
			ArrayList<Map<String, Object>> runDtList = (ArrayList) dao.list("com.korail.yz.ys.ee.YSEE001QMDAO.selectAplTrm5Wk", inputDataSet);
			runDtArrayList.add(String.valueOf(runDtList.get(0).get("RUN_DT")));
			LOGGER.debug("적용기간 5주 RUN_DT:::::"+runDtList.get(0).get("RUN_DT") );
		}
		if("1".equals(inputDataSet.get("APL_TRM6"))) // 적용기간 6주 체크시
		{
			ArrayList<Map<String, Object>> runDtList = (ArrayList) dao.list("com.korail.yz.ys.ee.YSEE001QMDAO.selectAplTrm6Wk", inputDataSet);
			runDtArrayList.add(String.valueOf(runDtList.get(0).get("RUN_DT")));
			LOGGER.debug("적용기간 6주 RUN_DT:::::"+runDtList.get(0).get("RUN_DT") );
		}
		if("1".equals(inputDataSet.get("APL_TRM7"))) // 적용기간 7주 체크시
		{
			ArrayList<Map<String, Object>> runDtList = (ArrayList) dao.list("com.korail.yz.ys.ee.YSEE001QMDAO.selectAplTrm7Wk", inputDataSet);
			runDtArrayList.add(String.valueOf(runDtList.get(0).get("RUN_DT")));
			LOGGER.debug("적용기간 7주 RUN_DT:::::"+runDtList.get(0).get("RUN_DT") );
		}
		if("1".equals(inputDataSet.get("APL_TRM8"))) // 적용기간 8주 체크시
		{
			ArrayList<Map<String, Object>> runDtList = (ArrayList) dao.list("com.korail.yz.ys.ee.YSEE001QMDAO.selectAplTrm7Wk", inputDataSet);
			runDtArrayList.add(String.valueOf(runDtList.get(0).get("RUN_DT")));
			LOGGER.debug("적용기간 8주 RUN_DT:::::"+runDtList.get(0).get("RUN_DT") );
		}
		
		//적용기간 x주전 RUN_DT 배열 CONCAT한 String으로 리턴 
		int dayCnt = runDtArrayList.size();
		String sConcatRunDt = "";
		for (int i = 0; i < dayCnt; i++)
		{
			if(i == 0)
			{
				sConcatRunDt = "'".concat(runDtArrayList.get(i)).concat("'");
			}
			else
			{
				sConcatRunDt = sConcatRunDt.concat( ",'").concat(runDtArrayList.get(i)).concat("'");
			}
			
		}
		LOGGER.debug("sConcatRunDt(적용기간x주전):::::"+sConcatRunDt );
		
		return sConcatRunDt;
	}
	/**
	 * 할인실적참조 조회
	 * @author 나윤채
	 * @date 2014. 8. 22. 오전 9:02:03
	 * Method description : 할인실적참조내역을 조회한다.
	 * @param param
	 * @return result
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListDcntAcvmComp(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> condMap = XframeControllerUtils.getParamDataSet(param, "dsCond");

		if ("DCNT".equals(condMap.get("DV_CD"))) // 할인처리 시점에서 운행 날짜 셋
		{
			condMap.put("RUN_DT_ST", condMap.get("RUN_DT_ST2"));					
			condMap.put("RUN_DT_CLS", condMap.get("RUN_DT_CLS2"));						
		}
		
		ArrayList<Map<String, Object>> resultList = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.ys.ee.YSEE001QMDAO.selectListDcntAcvmComp",condMap);
		
		if ("COMP".equals(condMap.get("DV_CD")))	// 비교기간
		{
			result.put("dsList1", resultList);			
		}else if ("DCNT".equals(condMap.get("DV_CD"))) // 할인처리
		{
			result.put("dsList2", resultList);						
		}
		result = sendMessage(resultList, resultList, result, 0);		//메시지 처리
		
		return result;
	}

	/**
	 * 메시지 처리 메서드
	 * @author 나윤채
	 * @date 2014. 8. 22. 오전 9:02:03
	 * Method description : 메시지 처리를 위한 메서드
	 * @param ArrayList<Map<String, Object>> resultList,
	 *        ArrayList<Map<String, Object>> resultList2, 
	 *        Map<String, Object> result, 
	 *        int num
	 * @return result
	 */
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
}

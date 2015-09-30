/**
 * project : KORAIL_YZ
 * package : com.korail.yz.ys.aa
 * date : 2014. 4. 5.오후 3:02:30
 */
package com.korail.yz.ys.aa;

import java.util.*;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Service;

import com.korail.tz.sa.ISA0001SVC;
import com.korail.tz.sa.XframeControllerUtils;

import cosmos.comm.dao.CommDAO;

/**
 * @author 김응규
 * @date 2014. 4. 10. 오후 2:50:30
 * Class description :  수익관리대상열차일별분석SVC
 * 작업일자별, 운행일자별 수익관리 대상열차 일별분석 및 상태변경을 위한 Service 클래스
 */
@Service("com.korail.yz.ys.aa.YSAA003SVC")
public class YSAA003SVC {
	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public static final Logger LOGGER = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
	
	/**
	 * 수익관리대상열차일별분석작업일자별조회
	 * @author 김응규
	 * @date 2014. 4. 10. 오후 2:50:30
	 * Method description : 수익관리대상열차 일별분석 작업일자별 조회를 실행한다. 
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map<String, ?> selectListYmgtTgtTrnDdprAnalJobDt(Map<String, ?> param) {		

		Map<String, Object> result = new HashMap<String, Object>();

		LOGGER.debug("param ==> "+param);
		// search input column dataset
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCondJobDt");
		//열차운영사업자구분코드 추가
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		inputDataSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		LOGGER.debug("inputDataSet ==>  " + inputDataSet);

		
		ArrayList<Map<String, Object>> resultList = (ArrayList) dao.list("com.korail.yz.ys.aa.YSAA003QMDAO.selectListYmgtTgtTrnDdprAnalJobDt", inputDataSet);

		
		//메시지 처리
		if(resultList.isEmpty()){
			XframeControllerUtils.setMessage("IZZ000004", result); //해당 조건의 자료가 존재하지 않습니다.
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result); //정상적으로 조회 되었습니다.
		}
		
		result.put("dsListJobDt", resultList);

		return result;

	}
	
	/**
	 * 수익관리대상열차일별분석운행일자별조회
	 * @author 김응규
	 * @date 2014. 4. 10. 오후 2:50:30
	 * Method description : 수익관리대상열차 일별분석 운행일자별 조회를 실행한다. 
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map<String, ?> selectListYmgtTgtTrnDdprAnalRunDt(Map<String, ?> param) {		

		Map<String, Object> result = new HashMap<String, Object>();

		LOGGER.debug("param ==> "+param);
		// search input column dataset
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCondRunDt");
		//열차운영사업자구분코드 추가
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		inputDataSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		LOGGER.debug("inputDataSet ==>  " + inputDataSet);
		
		ArrayList<Map<String, Object>> resultList = (ArrayList) dao.list("com.korail.yz.ys.aa.YSAA003QMDAO.selectListYmgtTgtTrnDdprAnalRunDt", inputDataSet);

		
		//메시지 처리
		if(resultList.isEmpty()){
			XframeControllerUtils.setMessage("IZZ000004", result); //해당 조건의 자료가 존재하지 않습니다.
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result); //정상적으로 조회 되었습니다.
		}
		
		result.put("dsListRunDt", resultList);

		return result;

	}	
	
	/**
	 * 열차별 예측실적 승차인원 조회
	 * @author 김응규
	 * @date 2014. 4. 10. 오후 2:50:30
	 * Method description : 열차별 예측실적 승차인원 차트조회에 필요한 데이터를 조회한다.
	 * @param param
	 * @remarks //출발전 일수가 연속이 아닌 경우 보정..
				//EX)출발전 일수 10일에 승차인원 100, 출발전 일수 8일에 승차인원 120 이라면(실데이터)
				//   출발전 일수 9일은 승차인원은 110으로 설정..(빠진 출발전 일수에 보정 데이터 설정..)
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map<String, ?> selectListTrnPrFcstAcvmAbrdPrnb(Map<String, ?> param) {		

		Map<String, Object> result = new HashMap<String, Object>();
		LOGGER.debug("param ==> "+param);
		// search input column dataset
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");
		//열차운영사업자구분코드 추가
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		inputDataSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		LOGGER.debug("inputDataSet ==>  " + inputDataSet);
		ArrayList<Map<String, Object>> resultList = new ArrayList<Map<String,Object>>();
		LOGGER.debug("-------------------------------------------------");
		LOGGER.debug("00.역그룹차수 조회 시작 :::: START:::::::");
		Map<String, Object> stgpDegrMap = (Map<String, Object>) dao.select("com.korail.yz.comm.COMMQMDAO.selectStgpDegr", null);
		inputDataSet.put("STGP_DEGR", String.valueOf(stgpDegrMap.get("STGP_DEGR")));
		LOGGER.debug("00.역그룹차수 조회 끝 :::: END:::::::");
		LOGGER.debug("-------------------------------------------------");
		LOGGER.debug("[03].예약발매실적 조회 시작 :::: START:::::::");
		ArrayList<Map<String, Object>> rsvSaleAcvmList = (ArrayList) dao.list("com.korail.yz.ys.aa.YSAA003QMDAO.selectListRsvSaleAcvm", inputDataSet); /*03.예약발매실적*/
		for(int i=0;i<rsvSaleAcvmList.size();i++)
		{
			LOGGER.debug("예약발매실적:::::"+rsvSaleAcvmList.get(i));
		}
		LOGGER.debug("[03].예약발매실적 조회 끝 :::: END:::::::");
		LOGGER.debug("-------------------------------------------------");
		LOGGER.debug("운행일자, 열차번호로 모든 GOD 얻기:::::::");
		ArrayList<Map<String, Object>> godList = (ArrayList) dao.list("com.korail.yz.ys.aa.YSAA003QMDAO.selectListGod", inputDataSet);
		LOGGER.debug("운행일자, 열차번호로 모든 GOD 얻기::::::: 끝!");
		LOGGER.debug("-------------------------------------------------");
		LOGGER.debug("[01].장기예측승차인원 조회 시작 :::: START:::::::");
		
		//ArrayList<Map<String, Object>> lgtmFcstPrnbList = new ArrayList<Map<String,Object>>(); /*03.장기예측인원*/
		ArrayList<Map<String, Object>> daspPrRsvCncPrnbList = new ArrayList<Map<String,Object>>(); /*03.장기예측인원데이터 가공전 DSP별 예발-취소 승차인원목록*/
		LOGGER.debug("01-1) 장기예측 구분 ");
		ArrayList<Map<String, Object>> lgtmFcstDvList = (ArrayList) dao.list("com.korail.yz.ys.aa.YSAA003QMDAO.selectLgtmFcstDv", inputDataSet); 
		for(int i=0;i<lgtmFcstDvList.size();i++)
		{
			LOGGER.debug("장기예측 구분 내역:::::"+lgtmFcstDvList.get(i));
		}
		
		/****
		 * 1. IF ( RUN_DV_CD == "3"  && YMS_APL_FLG =="Y"  이면  임시.. (참고 RUN_DV_CD====>  1:정기 2:부정기 3:임시 9:현시각)

		*			- LRG_CRG_DV_CD(대수송구분코드) 가 NOT NULL 이고 "03" 이면  하계 (d_yf35100_graph_temp_summer)     ================= ⑥
		*			- LRG_CRG_DV_CD(대수송구분코드) 가 NOT NULL 이고 "04" 이면  연말연시 (d_yf35100_graph_temp_winter) ================= ⑦
		*			- HLDY_BF_AFT_DV_CD(공휴일전후구분코드) 가 NOT NULL 이면 공휴일 (d_yf35100_graph_temp_holi)        ================= ⑧
		*			- ELSE면  임시일반(d_yf35100_graph_temp)														   ================= ⑤
		*	ELSE IF (운행구분코드가 3아님    )
	     *				그냥 대수송구분코드가 03 이면 하계 (d_yf35100_graph_summer)                                    ================= ②
		 *				대수송구분코드가 04 이면  연말연시 (d_yf35100_graph_winter)                                    ================= ③
		 *	HLDY_BF_AFT_DV_CD(공휴일전후구분코드)가 NOT NULL 이면 공휴일 (d_yf35100_graph_holi)                        ================= ④
		 *
		 *	ELSE 노말 (d_yf35100_graph_normal)                                                                         ================= ①
		 * 
		 *     
		 *   
		 * ***/
		/**
		 * TODO 장기예측조회 쿼리가 AS-IS부터 현격한 성능의 문제가 있음
		 * 쿼리 튜닝 등 문제해결이 필요함
		 * 문제 해결 시까지 임시로 주석으로 막아 장기예측조회결과값은 일단 0으로 나오도록 처리함.   
		 * */
		if("3".equals(lgtmFcstDvList.get(0).get("RUN_DV_CD")) && "Y".equals(lgtmFcstDvList.get(0).get("YMS_APL_FLG")))
		{
			if("03".equals(lgtmFcstDvList.get(0).get("LRG_CRG_DV_CD")))  /*대수송구분코드가 03이면 임시하계  (d_yf35100_graph_temp_summer) ================= ⑥*/
			{
				LOGGER.debug("임시하계 장기예측 조회!");
				daspPrRsvCncPrnbList =  (ArrayList) dao.list("com.korail.yz.ys.aa.YSAA003QMDAO.selectListLgtmFcstPrnbTmpSmer", inputDataSet);
			}
			else if("04".equals(lgtmFcstDvList.get(0).get("LRG_CRG_DV_CD"))) /*대수송구분코드가 03이면 임시연말연시 (d_yf35100_graph_temp_winter) ================= ⑦*/
			{
				LOGGER.debug("임시연말연시 장기예측 조회!");
				daspPrRsvCncPrnbList =  (ArrayList) dao.list("com.korail.yz.ys.aa.YSAA003QMDAO.selectListLgtmFcstPrnbTmpWntr", inputDataSet);
			}
			else if(lgtmFcstDvList.get(0).get("HLDY_BF_AFT_DV_CD") != null) /*공휴일전후구분코드가 NOT NULL 이면 임시공휴일 (d_yf35100_graph_temp_holi) ================= ⑧*/
			{
				LOGGER.debug("임시공휴일 장기예측 조회!");
				daspPrRsvCncPrnbList =  (ArrayList) dao.list("com.korail.yz.ys.aa.YSAA003QMDAO.selectListLgtmFcstPrnbTmpLghd", inputDataSet);
			}
			else /*ELSE면  임시일반(d_yf35100_graph_temp)	================= ⑤*/
			{
				LOGGER.debug("임시노말 장기예측 조회!");
				daspPrRsvCncPrnbList =  (ArrayList) dao.list("com.korail.yz.ys.aa.YSAA003QMDAO.selectListLgtmFcstPrnbTmpNml", inputDataSet);
			}
		}
		else if("03".equals(lgtmFcstDvList.get(0).get("LRG_CRG_DV_CD"))) /*하계 (d_yf35100_graph_summer)  ===================== ②*/
		{
			LOGGER.debug("(일반)하계 장기예측 조회!");
			daspPrRsvCncPrnbList =  (ArrayList) dao.list("com.korail.yz.ys.aa.YSAA003QMDAO.selectListLgtmFcstPrnbSmer", inputDataSet);
		}
		else if("04".equals(lgtmFcstDvList.get(0).get("LRG_CRG_DV_CD")))   /*연말연시 (d_yf35100_graph_winter)  ================= ③*/
		{
			LOGGER.debug("(일반)연말연시 장기예측 조회!");
			daspPrRsvCncPrnbList =  (ArrayList) dao.list("com.korail.yz.ys.aa.YSAA003QMDAO.selectListLgtmFcstPrnbWntr", inputDataSet);
		}
		else if(lgtmFcstDvList.get(0).get("HLDY_BF_AFT_DV_CD") != null) /*공휴일 (d_yf35100_graph_holi) ================= ④*/
		{
			LOGGER.debug("(일반)공휴일 장기예측 조회!");
			daspPrRsvCncPrnbList =  (ArrayList) dao.list("com.korail.yz.ys.aa.YSAA003QMDAO.selectListLgtmFcstPrnbLghd", inputDataSet);
		}
		else /*노말 (d_yf35100_graph_normal)    ======================= ①*/
		{
			LOGGER.debug("(일반)노말 장기예측 조회!");
			daspPrRsvCncPrnbList =  (ArrayList) dao.list("com.korail.yz.ys.aa.YSAA003QMDAO.selectListLgtmFcstPrnbNml", inputDataSet);
		}
	
		
		/**TODO
		 * ※  위는 DSP별 예발인원 / 취소인원 조회내역임 아래에서 데이터가공이 필요함  
		 *   -- 출발전일수별  예측승차인원
		 *    -- >  예약발매인원 - 취소인원 값으로 처리... 
		 *  */
		LOGGER.debug("01.장기예측승차인원 조회 끝 :::: END:::::::");		
		
		
		/* AS-IS에서 아래와 같이 선언했던 배열을 하나의 List<Map<String, long>> 으로 처리 D-0 ~ D-32까지
		 * long ll_rsv_val[61]
		 * long ll_cnc_val[61]
		 * String ls_day[61]
		 * long ll_total_rsv_val[61]
		 * long ll_total_cnc_val[61]
		 * */
		//장기예측 List
		List<Map<String, String>> lgtmFcstList = new ArrayList<Map<String,String>>();
		
		for (int i = 0; i < 33; i++)
		{
			Map<String, String> lgtmFcstMap = new HashMap<String, String>();
			lgtmFcstMap.put("DAY", String.valueOf(i));
			lgtmFcstMap.put("RSV_VAL", "0");
			lgtmFcstMap.put("CNC_VAL", "0");
			lgtmFcstMap.put("TOT_RSV_VAL", "0");
			lgtmFcstMap.put("TOT_CNC_VAL", "0");
			lgtmFcstList.add(lgtmFcstMap);
		}
		
		//daspPrRsvCncPrnbList = dw_main
		//rsvSaleAcvmList      = dw_result
		String sDptStgpCd = "";
		String sArvStgpCd = "";
		int nDptBfDno = 0;
		for(int i = 0; i < godList.size(); i++)
		{
			sDptStgpCd = String.valueOf(godList.get(i).get("DPT_STGP_CD"));
			sArvStgpCd = String.valueOf(godList.get(i).get("ARV_STGP_CD"));
			LOGGER.debug("for i["+i+"] 번째 sDptStgpCd ::"+sDptStgpCd+", sArvStgpCd ::"+sArvStgpCd);
			for(int j = 0; j < daspPrRsvCncPrnbList.size(); j++) // daspPrRsvCncPrnbList.size() = as is ll_row_cnt
			{
				//LOGGER.debug("for j["+j+"] DPT_STGP_CD:: "+daspPrRsvCncPrnbList.get(j).get("DPT_STGP_CD")+ ", ARV_STGP_CD ::"+daspPrRsvCncPrnbList.get(j).get("ARV_STGP_CD"));
				//GOD가 동일하지 않으면 continue
				if(!sDptStgpCd.equals(String.valueOf(daspPrRsvCncPrnbList.get(j).get("DPT_STGP_CD")))
					|| 	!sArvStgpCd.equals(String.valueOf(daspPrRsvCncPrnbList.get(j).get("ARV_STGP_CD"))))
				{
					continue;
				}
				nDptBfDno = Integer.parseInt(String.valueOf(daspPrRsvCncPrnbList.get(j).get("RSV_DPT_BF_DNO"))) + 1;
				//예매 출발 전 일수가 32일이 넘으면 자른다(AS-IS 60일)
				if(nDptBfDno > 32)
				{
					nDptBfDno = 32;
					daspPrRsvCncPrnbList.get(j).put("RSV_DPT_BF_DNO", nDptBfDno);
					LOGGER.debug("예매 출발 전 일수가 32일이 넘으면 자른다(AS-IS 60일) ::::i["+i+"], j["+j+"]");
				}
				lgtmFcstList.get(nDptBfDno).put("RSV_VAL", String.valueOf(daspPrRsvCncPrnbList.get(j).get("RSV_SALE_FCST_PRNB")));
				//LOGGER.debug("예약 출발 전일 ["+nDptBfDno+"], 예약발매예측인원 :: ["+lgtmFcstList.get(nDptBfDno).get("RSV_VAL")+"]");
				
				nDptBfDno = Integer.parseInt(String.valueOf(daspPrRsvCncPrnbList.get(j).get("CNC_DPT_BF_DNO"))) + 1;
				//취소 출발 전 일수가 32일이 넘으면 자른다(AS-IS 60일)
				if(nDptBfDno > 32)
				{
					nDptBfDno = 32;
					daspPrRsvCncPrnbList.get(j).put("CNC_DPT_BF_DNO", nDptBfDno);
					LOGGER.debug("예매 출발 전 일수가 32일이 넘으면 자른다(AS-IS 60일) ::::i["+i+"], j["+j+"]");
				}
				lgtmFcstList.get(nDptBfDno).put("CNC_VAL", String.valueOf(daspPrRsvCncPrnbList.get(j).get("CNC_RET_FCST_PRNB")));
				//LOGGER.debug("취소 출발 전일 ["+nDptBfDno+"], 취소반환예측인원 :: ["+lgtmFcstList.get(nDptBfDno).get("CNC_VAL")+"]");	
			} //END for j
//			LOGGER.debug("lgtmFcstList 출력~!!!!!!!!!!!!!!!!");
//			for (int ii = 0; ii < lgtmFcstList.size(); ii++)
//			{
//				LOGGER.debug(lgtmFcstList.get(ii));
//			}
			LOGGER.debug("GOD별로 출발 전 일수 데이터를 32일로 전개(AS-IS 60일)");
			int x = 0;
			int y = 0;
			
			
			int start = 0;
			int end = 0;
			
			for(int k = lgtmFcstList.size()-1; k > -1; k--)
			{
				//LOGGER.debug("for k["+k+"]");
				if(!"0".equals(lgtmFcstList.get(k).get("RSV_VAL")))
				{
					if(start == 0)
					{
						start = k;
					}
					else
					{
						end = k;
						
						if(start - end >= 2)
						{
							x = Integer.parseInt(lgtmFcstList.get(start).get("DAY")) - Integer.parseInt(lgtmFcstList.get(end).get("DAY"));
							y = Integer.parseInt(lgtmFcstList.get(end).get("RSV_VAL")) - Integer.parseInt(lgtmFcstList.get(start).get("RSV_VAL"));
//							LOGGER.debug("["+k+"]번째 x ::::"+x);
//							LOGGER.debug("["+k+"]번째 y ::::"+y);
							
							for(int l = start - 1; l >= end + 1; l--)
							{
								//LOGGER.debug("for l["+l+"]");
								lgtmFcstList.get(l).put("RSV_VAL",
										String.valueOf(
										((Integer.parseInt(lgtmFcstList.get(start).get("DAY")) 
												- Integer.parseInt(lgtmFcstList.get(l).get("DAY"))) * y / x ) 
												+ Integer.parseInt(lgtmFcstList.get(start).get("RSV_VAL"))
												));
//								LOGGER.debug("llll["+l+"] RSV_VAL :::"+lgtmFcstList.get(l).get("RSV_VAL"));
							} //END for l
						}
					}
					start = k;
					
				}
			} //END for k
			
//			LOGGER.debug("lgtmFcstList 출력~!!!!!!!!!!!!!!!!(RSV_VAL보정후)");
//			for (int ii = 0; ii < lgtmFcstList.size(); ii++)
//			{
//				LOGGER.debug(lgtmFcstList.get(ii));
//			}
			for(int m = lgtmFcstList.size()-1; m > -1; m--)
			{
//				LOGGER.debug("for m["+m+"]");
				int mRsvVal = Integer.parseInt(lgtmFcstList.get(m).get("RSV_VAL"));
				if(mRsvVal == 0 && m < lgtmFcstList.size()-1)
				{
					lgtmFcstList.get(m).put("RSV_VAL", String.valueOf(lgtmFcstList.get(m+1).get("RSV_VAL")));	
				}
			} //END for m
			
			for(int n = lgtmFcstList.size()-1; n > -1; n--)
			{
				//LOGGER.debug("for n["+n+"]");
				int nCncVal = Integer.parseInt(lgtmFcstList.get(n).get("CNC_VAL"));
				if(nCncVal != 0)
				{
					if(start == 0)
					{
						start = n;
					}
					else
					{
						end = n;
						if(start - end >= 2)
						{
							x = Integer.parseInt(lgtmFcstList.get(start).get("DAY")) - Integer.parseInt(lgtmFcstList.get(end).get("DAY"));
							y = Integer.parseInt(lgtmFcstList.get(end).get("CNC_VAL")) - Integer.parseInt(lgtmFcstList.get(start).get("CNC_VAL"));
//							LOGGER.debug("["+n+"]번째 x ::::"+x);
//							LOGGER.debug("["+n+"]번째 y ::::"+y);
							
							for(int o = start - 1; o >= end + 1; o--)
							{
								//LOGGER.debug("for o["+o+"]");
								lgtmFcstList.get(o).put("CNC_VAL",
										String.valueOf(
										((Integer.parseInt(lgtmFcstList.get(start).get("DAY")) 
												- Integer.parseInt(lgtmFcstList.get(o).get("DAY"))) * y / x ) 
												+ Integer.parseInt(lgtmFcstList.get(start).get("CNC_VAL"))
												));
								//LOGGER.debug("llll["+o+"] CNC_VAL :::"+lgtmFcstList.get(o).get("CNC_VAL"));
							} //END for o
							
						} //END if(start - end >= 2)
						start = n;
					}//END if(start == 0) else
				}//END if(nCncVal != 0)
			} //END for n
			
			for(int p = lgtmFcstList.size()-1; p > -1; p--)
			{
				//LOGGER.debug("for p["+p+"]");
				int mCncVal = Integer.parseInt(lgtmFcstList.get(p).get("CNC_VAL"));
				if(mCncVal == 0 && p < lgtmFcstList.size()-1)
				{
					lgtmFcstList.get(p).put("CNC_VAL", String.valueOf(lgtmFcstList.get(p+1).get("CNC_VAL")));	
				}
				
			} //END for p
			
			LOGGER.debug("32일로 전개된 출발 전 일수별로 승차인원 합계 구하기!!!");
			
			int totRsvVal = 0;
			int totCncVal = 0;
			int rsvVal = 0;
			int cncVal = 0;
			for(int q = lgtmFcstList.size() - 1 ; q > -1 ; q--)
			{
				rsvVal = Integer.parseInt(lgtmFcstList.get(q).get("RSV_VAL"));
				cncVal = Integer.parseInt(lgtmFcstList.get(q).get("CNC_VAL"));
//				totRsvVal += rsvVal;
//				totCncVal += cncVal;
				totRsvVal = rsvVal;
				totCncVal = cncVal;
				lgtmFcstList.get(q).put("TOT_RSV_VAL", String.valueOf(totRsvVal));
				lgtmFcstList.get(q).put("TOT_CNC_VAL", String.valueOf(totCncVal));
				//LOGGER.debug("q["+q+"]번째"+"rsvVal["+rsvVal+"]"+"cncVal["+cncVal+"]"+"totRsvVal["+totRsvVal+"]"+"totCncVal["+totCncVal+"]");				
			}
			
		}//END for i
		LOGGER.debug("lgtmFcstList 출력~!!!!!!!!!!!!!!!!(합계계산후)");
		for (int ii = 0; ii < lgtmFcstList.size(); ii++)
		{
			LOGGER.debug(lgtmFcstList.get(ii));
		}
		
		LOGGER.debug("[02].최종예측인원 조회 시작 :::: START:::::::");
		ArrayList<Map<String, Object>> lastFcstPrnbList = (ArrayList) dao.list("com.korail.yz.ys.aa.YSAA003QMDAO.selectListLastFcstPrnb", inputDataSet); /*02.최종예측인원*/
		LOGGER.debug("최종예측인원:::::"+lastFcstPrnbList.get(0));
		LOGGER.debug("[02].최종예측인원 조회 끝 :::: END:::::::");

		int lgtmFcstPrnb = 0; //장기예측인원
		int lgtmFcstRsv = 0; //장기예측 예약발매
		int lgtmFcstCnc = 0; //장기예측 취소반환
		for (int i = 0; i < 33; i++)
		{
			Map<String, Object> resultMap = new HashMap<String, Object>();
			resultMap.put("DPT_BF_DT_NUM", i); /*출발이전일자수*/
			
			if(lgtmFcstList.size() > i) /*01.장기예측인원*/
			{
				//LOGGER.debug("장기예측인원 있음"+i);
				lgtmFcstRsv = Integer.parseInt(lgtmFcstList.get(i).get("TOT_RSV_VAL"));
				lgtmFcstCnc = Integer.parseInt(lgtmFcstList.get(i).get("TOT_CNC_VAL"));
				lgtmFcstPrnb = lgtmFcstRsv - lgtmFcstCnc;

				//LOGGER.debug("lgtmFcstRsv :::["+lgtmFcstRsv+"], lgtmFcstCnc :::["+lgtmFcstCnc+"]");
				//LOGGER.debug("lgtmFcstPrnb :::"+lgtmFcstPrnb);
				resultMap.put("LGTM_FCST_PRNB", lgtmFcstPrnb);
			}
			else
			{
				//LOGGER.debug("장기예측인원 없음"+i);
				resultMap.put("LGTM_FCST_PRNB", "");
			}
			
			if(lastFcstPrnbList.size() > i) /*02.최종예측인원*/
			{
				resultMap.put("LAST_FCST_PRNB", lastFcstPrnbList.get(i).get("LAST_FCST_PRNB"));
			}
			else
			{
				//LOGGER.debug("최종예측인원 없음"+i);
				resultMap.put("LAST_FCST_PRNB", "");
			}
			
			if(rsvSaleAcvmList.size() > i)  /*03.예약발매실적*/
			{
				resultMap.put("RSV_SALE_ACVM_PRNB", rsvSaleAcvmList.get(i).get("RSV_SALE_ACVM_PRNB"));
			}
			else
			{
				//LOGGER.debug("예약발매실적 없음"+i);
				resultMap.put("RSV_SALE_ACVM_PRNB", "");
			}
			
			resultList.add(i, resultMap);
			
			
		}
		
/*		for(int i=0;i<resultList.size();i++)
		{
			LOGGER.debug("결과LIST:::::"+resultList.get(i));
		}*/
		//메시지 처리
		if(resultList.isEmpty()){
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
	 * @author 한현섭
	 * @date 2014. 4. 14. 오전 10:12:11
	 * Method description : 최적화구간별할당결과조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map<String, ?> selectListQtmzSgmpAlcCnqe(Map<String, ?> param) {
		Map<String, Object> result = new HashMap<String, Object>();

		LOGGER.debug("param ==> "+param);
		// search input column dataset
		Map<String, String> inputDataSet = XframeControllerUtils.getParamDataSet(param, "dsOptSeqCondition");
		//열차운영사업자구분코드 추가
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		inputDataSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		LOGGER.debug("inputDataSet ==>  " + inputDataSet);
		
		ArrayList<Map<String, Object>> resultList = (ArrayList) dao.list("com.korail.yz.ys.aa.YSAA003QMDAO.selectListQtmzSgmpAlcCnqe", inputDataSet);

		//error 메시지 날리기
		if(resultList.isEmpty()){
			XframeControllerUtils.setMessage("IZZ000004", result);
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result);
		}
		result.put("dsOptSeqResult", resultList);

		return result;
	}
	
	
	
	/**
	 * @author 한현섭
	 * @date 2014. 4. 14. 오전 10:11:08
	 * Method description : 최적화구간별할당결과선택구간조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListQtmzSelectedSgmp(Map<String, ?> param) {
		Map<String, Object> result = new HashMap<String, Object>();
		
		LOGGER.debug("param ==> "+param);
		// search input column dataset
		Map<String, String> inputDataSet = XframeControllerUtils.getParamDataSet(param, "dsGrdSelCond");
		//열차운영사업자구분코드 추가
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		inputDataSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		LOGGER.debug("inputDataSet ==>  " + inputDataSet);

		
		String nPattern = inputDataSet.get("PATTERN_NUM");
		
		ArrayList<Map<String, Object>> resultList = null;
		
		if("2".equals(nPattern)){
			resultList = (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.ys.aa.YSAA003QMDAO.selectListQtmzSelectedSgmpWithMrntCd", inputDataSet);	
		}else
		{
			resultList = (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.ys.aa.YSAA003QMDAO.selectListQtmzSelectedSgmp", inputDataSet);
		}
		
		//error 메시지 날리기
		if(resultList.isEmpty()){
			XframeControllerUtils.setMessage("IZZ000004", result);
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000014", result);//화면이로딩되었습니다.
		}

		result.put("dsGrdSelLst", resultList);

		return result;
	}
	
	
	/**
	 * @author 한현섭
	 * @date 2014. 5. 1. 오후 1:49:29
	 * Method description : 열차분석상태를 업데이트 하는 함수
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> updateListYmgtTgtTrnAnalDcCd(Map<String, ?> param) {
		Map<String, Object> result = new HashMap<String, Object>();
		
		LOGGER.debug("param ==> "+param);
		// search input column dataset
		ArrayList<Map<String, String>> inputDataList = (ArrayList<Map<String, String>>) param.get("dsUpdateTrnAnalDvCdCond");
		ArrayList<Map<String, String>> aCallBackValueList = new ArrayList<Map<String,String>>(); 
		LOGGER.debug("inputDataSet ==>  " + inputDataList);
		
		Map<String, String> sCallBackValue = new HashMap<String, String>();
				
		for (Map<String, String> inputDataSet : inputDataList)
		{
			try{
				dao.list("com.korail.yz.ys.aa.YSAA003QMDAO.updateListYmgtTgtTrnAnalDcCd", inputDataSet);
			}catch(Exception e)
			{
				XframeControllerUtils.setMessage("EYS000005", result);
				
				sCallBackValue.put("MSG", "O");
				aCallBackValueList.add(sCallBackValue);
				result.put("dsCallBackValueTrnAnal", aCallBackValueList);
				return result;
			}
		}
		
		XframeControllerUtils.setMessage("IYS000002", result);
		sCallBackValue.put("MSG", "S");
		aCallBackValueList.add(sCallBackValue);
		result.put("dsCallBackValueTrnAnal", aCallBackValueList);
		return result;
	}
	
	
	
}
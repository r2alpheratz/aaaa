/**
 * project : KORAIL_YZ
 * package : com.korail.yz.ys.ea
 * date : 2014. 5. 20.오전 8:55:48
 */
package com.korail.yz.ys.ea;

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

/**
 * @author 한현섭
 * @date 2014. 5. 20. 오전 8:55:48
 * Class description : 
 */
@Service("com.korail.yz.ys.ea.YSEA001SVC")
public class YSEA001SVC {

	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public  final Logger LOGGER = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
 
	/**
	 * @author 김응규
	 * @date 2015. 2. 13. 오전 9:00:53
	 * Method description : 특별관리단체요청시간대별 조회(상단그리드)
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map<String, ?>  selectListSpcMgGrpDmnTmwdPr(Map<String, ?> param){
		Map<String, Object> result = new HashMap<String, Object>();
		LOGGER.debug("param1 ==> "+param);
		LOGGER.debug("param2 ==> "+param);
		// search input column dataset
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");	
		LOGGER.debug("inputDataSet ==>  " + inputDataSet);
		//열차운영사업자구분코드 추가
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		inputDataSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		
		//고객승급관리 조회
		ArrayList<Map<String, Object>> resultList = (ArrayList) dao.list("com.korail.yz.ys.ea.YSEA001QMDAO.selectListRmnTrnl", inputDataSet);

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
	 * @author 김응규
	 * @date 2015. 2. 13. 오전 9:00:53
	 * Method description : 특별관리단체요청열차별 조회(상단그리드)
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map<String, ?>  selectListSpcMgGrpDmnTrnPr(Map<String, ?> param){
		Map<String, Object> result = new HashMap<String, Object>();
		
		LOGGER.debug("param ==> "+param);
		// search input column dataset
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCond2");	
		LOGGER.debug("inputDataSet ==>  " + inputDataSet);
		//열차운영사업자구분코드 추가
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		inputDataSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		
		//고객승급관리 조회
		ArrayList<Map<String, Object>> resultList = (ArrayList) dao.list("com.korail.yz.ys.ea.YSEA001QMDAO.selectListRmnTrnLstByTrn", inputDataSet);

		//메시지 처리
		if(resultList.isEmpty())
		{
			XframeControllerUtils.setMessage("IZZ000004", result); //해당 조건의 자료가 존재하지 않습니다.
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result); //정상적으로 조회 되었습니다.
		}
		result.put("dsList2", resultList);
		
		return result;
	}
		
	/**
	 * @author 한현섭
	 * @date 2014. 5. 20. 오전 9:00:53
	 * Method description : 상단그리드 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?>  selectListRmnTrnl(Map<String, ?> param){
		
 		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();

		/* 입력 오브젝트 */
		String [] condKey = { "dsCondRmnTrnList1", "dsCondRmnTrnList2"};
		String resultListNo;
		StringBuilder resultListNoBuilder = new StringBuilder();
		Map<String, String> inputDataSet = null;
		for (int i = 0 ; i < condKey.length ; i++)
		{
			if(param.containsKey(condKey[i]))
			{
				inputDataSet = XframeControllerUtils.getParamDataSet(param, condKey[i]);
				resultListNoBuilder.append((i + 1));
				break;
			}
			
		}
		resultListNo = String.valueOf(resultListNoBuilder);
		
		LOGGER.debug("inputDateSet--->"+inputDataSet);

		/* DAO - 쿼리 실행 후 결과 획득*/
		ArrayList<Map<String, Object>> resultList;
		if("1".equals(resultListNo))
		{
			resultList = (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.ys.ea.YSEA001QMDAO.selectListRmnTrnl", inputDataSet);
		}
		else
		{
			resultList = (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.ys.ea.YSEA001QMDAO.selectListRmnTrnLstByTrn", inputDataSet);
		}

		//결과 메시지 날리기
		if(resultList.isEmpty()){
			XframeControllerUtils.setMessage("IZZ000004", result);
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result);
		}
		LOGGER.debug("dsGrdRmnTrnList" + resultListNo+":::::");
		result.put("dsGrdRmnTrnList" + resultListNo, resultList);
		return result;
	}
	
	
	/**
	 * @author 한현섭
	 * @date 2014. 5. 20. 오전 9:00:55
	 * Method description : 하단의 4주간 열차내역을 가져온다.
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?>  selectListRmnTrnlDtl(Map<String, ?> param){
		
		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		
		/* 입력 오브젝트 */
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCondDtl");
		//열차운영사업자구분코드 추가
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		inputDataSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		LOGGER.debug("inputDateSet--->"+inputDataSet);
		
		/* DAO - 쿼리 실행 후 결과 획득*/
		ArrayList<Map<String, Object>> resultList
		= (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.ys.ea.YSEA001QMDAO.selectListRmnTrnlDtl", inputDataSet);
		
		//error 메시지 날리기
		if(resultList.isEmpty()){
			XframeControllerUtils.setMessage("IZZ000004", result);
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result);
		}
		result.put("dsListDtl", resultList);
		return result;
	}
	
	
	/**
	 * @author 한현섭
	 * @date 2014. 5. 20. 오전 9:01:01
	 * Method description : 
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?>  selectListDptArvStnNm(Map<String, ?> param){
		
		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		
		/* DAO - 쿼리 실행 후 결과 획득*/
		ArrayList<Map<String, Object>> resultList
		= (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.yb.co.YBCO002QMDAO.selectListHtnStopStn", null);
		
		//error 메시지 날리기
		if(resultList.isEmpty()){
			XframeControllerUtils.setMessage("IZZ000004", result);
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result);
		}
		
		result.put("dsDptArvStnNm", resultList);
		return result;
	}
	
	
	/**
	 * @author 한현섭
	 * @date 2014. 8. 21. 오후 1:41:33
	 * Method description : 시뮬레이션_할인율조견표적용
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?>  selectListSimlExcWithDcntRt(Map<String, ?> param){
		
		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		
		ArrayList<Map<String,String>> inputDataList = (ArrayList<Map<String, String>>) param.get("dsSim");
		Map<String,String> inputCommonDataSet = XframeControllerUtils.getParamDataSet(param, "dsSimComm");
		boolean isTotalSuc = false;
		
		//1. 할인율 조견표에서 MAX 승차율, MIN 승차율 조회해오기.
		Map<String,String> abrdRtMinMaxMap = (Map<String, String>) dao.select("com.korail.yz.ys.ea.YSEA001QMDAO.selectMaxMinAbrdRt", null);
		double dMaxAbrdRt = Double.parseDouble(abrdRtMinMaxMap.get("MAX_ABRD_RT"));
		double dMinAbrdRt = Double.parseDouble(abrdRtMinMaxMap.get("MIN_ABRD_RT"));
		String sDst = inputDataList.get(0).get("OD_DST");
		for(Map<String, String> inputDataSet : inputDataList)
		{
			inputDataSet.putAll(inputCommonDataSet);
			
			double dDiscountRate = 0.0; //적정할인율
			
			LOGGER.debug("출발-도착역 거리 (DST) :::"+inputDataSet.get("OD_DST"));
			LOGGER.debug("ABRD_RT(예측승차율) :::"+inputDataSet.get("EXPCT_RT"));
			double dAbrdRt = 0.0;
			
			if(inputDataSet.get("EXPCT_RT").isEmpty())
			{
				//예측치가 존재하지 않는경우 최소할인율 10%(예측승차율이 없는경우)
				dDiscountRate = 10;
			}
			else
			{
				dAbrdRt = Double.parseDouble(inputDataSet.get("EXPCT_RT")); //예측승차율
				if(dAbrdRt >= dMaxAbrdRt){
					LOGGER.debug("조견표 최대 승차율("+dMaxAbrdRt+") 보다 예측승차율("+dAbrdRt+")이 높거나 같은 경우");
					
					Map<String, String> discRtMap = new HashMap<String, String>();
					discRtMap.put("ABRD_RT", String.valueOf(dMaxAbrdRt));
					discRtMap.put("DST", sDst);
					ArrayList<Map<String, String>> discRtList = (ArrayList<Map<String, String>>) dao.list("com.korail.yz.ys.ea.YSEA001QMDAO.selectListDcntRtEqual", discRtMap);
					dDiscountRate = Double.parseDouble(discRtList.get(0).get("PRC_DCNT_RT"));
				}else if(dAbrdRt <= dMinAbrdRt){
					LOGGER.debug("조견표 최소 승차율("+dMinAbrdRt+") 보다 예측승차율("+dAbrdRt+")이 낮거나 같은 경우");
					
					Map<String, String> discRtMap = new HashMap<String, String>();
					discRtMap.put("ABRD_RT", String.valueOf(dMinAbrdRt));
					discRtMap.put("DST", sDst);
					ArrayList<Map<String, String>> discRtList = (ArrayList<Map<String, String>>) dao.list("com.korail.yz.ys.ea.YSEA001QMDAO.selectListDcntRtEqual", discRtMap);
					dDiscountRate = Double.parseDouble(discRtList.get(0).get("PRC_DCNT_RT"));
				}else{
					LOGGER.debug("조견표 승차율 범위("+dMinAbrdRt+"~"+dMaxAbrdRt+") 내에 있는경우  ABRD_RT :: "+ dAbrdRt);
					
					Map<String, String> discRtMap = new HashMap<String, String>();
					Map<String, String> discRtMap2 = new HashMap<String, String>();
					discRtMap.put("DST", sDst);
					discRtMap.put("ABRD_RT", String.valueOf(dAbrdRt));
					discRtMap2.put("DST", sDst);
					discRtMap2.put("ABRD_RT", String.valueOf(dAbrdRt));
					ArrayList<Map<String, String>> discRtList = (ArrayList<Map<String, String>>) dao.list("com.korail.yz.ys.ea.YSEA001QMDAO.selectListDcntRtAbv", discRtMap);
					ArrayList<Map<String, String>> discRtList2 = (ArrayList<Map<String, String>>) dao.list("com.korail.yz.ys.ea.YSEA001QMDAO.selectListDcntRtBlow", discRtMap2);
					
					double dRt = Double.parseDouble(discRtList.get(0).get("ABRD_RT"));
					double dRt2 = Double.parseDouble(discRtList2.get(0).get("ABRD_RT"));
					LOGGER.debug("조견표기준(이상)승차율 (dRt)::::"+dRt);
					LOGGER.debug("조견표기준(이하)승차율 (dRt2)::::"+dRt2);
					double dPrcDcntRt = Double.parseDouble(discRtList.get(0).get("PRC_DCNT_RT"));
					double dPrcDcntRt2 = Double.parseDouble(discRtList2.get(0).get("PRC_DCNT_RT"));
					LOGGER.debug("조견표기준(이상)할인율(dPrcDcntRt)::::"+dPrcDcntRt);
					LOGGER.debug("조견표기준(이하)할인율(dPrcDcntRt2)::::"+dPrcDcntRt2);
					if(dPrcDcntRt == dPrcDcntRt2){
						dDiscountRate = dPrcDcntRt;
					}else{
						dDiscountRate = dPrcDcntRt + ((dRt - dAbrdRt) * ((dPrcDcntRt2 - dPrcDcntRt)/(dRt - dRt2))); 
					}
					LOGGER.debug("적정할인율(dDiscountRate)::::"+dDiscountRate);
				}
			}
			
			
			
			//출발역순서, 도착역순서 조회
			ArrayList<Map<String,String>> dptStnList = (ArrayList<Map<String, String>>) dao.list("com.korail.yz.ys.ea.YSEA001QMDAO.selectListDptStn", inputDataSet);
			ArrayList<Map<String,String>> arvStnList = (ArrayList<Map<String, String>>) dao.list("com.korail.yz.ys.ea.YSEA001QMDAO.selectListArvStn", inputDataSet);
			if(!dptStnList.isEmpty())
			{
				LOGGER.debug("출발역순서 ::: "+ dptStnList.get(0).get("DPT_ORDR"));
				inputDataSet.put("DPT_ORDR", dptStnList.get(0).get("DPT_ORDR"));
			}
			if(!arvStnList.isEmpty())
			{
				LOGGER.debug("도착역순서 ::: "+ arvStnList.get(0).get("ARV_ORDR"));
				inputDataSet.put("ARV_ORDR", arvStnList.get(0).get("ARV_ORDR"));
			}
		
			ArrayList<Map<String,String>> simResult = (ArrayList<Map<String, String>>) dao.list("com.korail.yz.ys.ea.YSEA001QMDAO.selectListSimlExc", inputDataSet);
			
			String seatNum = inputDataSet.get("NORMAL_SEAT_CNT");
			String maxPrnb = simResult.get(0).get("MAX_PRNB");
			String yul = ((Integer.parseInt(seatNum) - Integer.parseInt(maxPrnb)) > 0) ? String.valueOf(Integer.parseInt(seatNum) - Integer.parseInt(maxPrnb)) : "0";
			inputDataSet.put("YUL", yul);
			
			int restSeat = Integer.parseInt(yul);
			int reqPrnb = Integer.parseInt(inputDataSet.get("REQ_PRNB"));
			LOGGER.debug("요청구간 예상잔여석 ::: "+ restSeat);
			inputDataSet.put("DISCOUNT_RATE", String.valueOf(dDiscountRate)); //적정할인율
			
			double exctRate = Double.parseDouble(inputDataSet.get("EXPCT_RT")); //예측승차율
			if((restSeat - reqPrnb) < 0 || (exctRate >= 67))
			{
				inputDataSet.put("DISCOUNT_RATE", "0");
				inputDataSet.put("APPROVAL_YN", "예약거부");
			}else
			{
				inputDataSet.put("APPROVAL_YN", "예약승인");
				isTotalSuc = true;
			}
		}
		/*메시지 처리*/

		if(isTotalSuc)
		{
			XframeControllerUtils.setMessage("IYS000007", result);	
		}
		else
		{
			XframeControllerUtils.setMessage("IYS000008", result);	
		}
		
		result.put("dsSim", inputDataList);
		return result;
	}
	
	
	/**
	 * @author 한현섭
	 * @date 2014. 8. 25. 오전 11:40:19
	 * Method description : 시뮬레이션_할인율조견표미적용
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?>  selectListSimlExcWithOutDcntRt(Map<String, ?> param){
		
		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		
		ArrayList<Map<String,String>> inputDataList = (ArrayList<Map<String, String>>) param.get("dsSim");
		Map<String,String> inputCommonDataSet = XframeControllerUtils.getParamDataSet(param, "dsSimComm");
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		
		boolean isTotalSuc = true;
		
		for(Map<String, String> inputDataSet : inputDataList)
		{
			boolean isSimSuc = true;
			inputDataSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
			inputDataSet.putAll(inputCommonDataSet);
			
			//예상수입(exptPrice) = 정상운임(f1Price) * 요청인원수(reqPrnb);
			LOGGER.debug("열차번호::"+inputDataSet.get("TRN_NO")+":::: 예상수입(exptPrice) = 정상운임(f1Price) * 요청인원수(reqPrnb)");
			LOGGER.debug("F1운임 조회");
			ArrayList<Map<String,String>> f1FareList = (ArrayList<Map<String, String>>) dao.list("com.korail.yz.ys.ea.YSEA001QMDAO.selectListF1FareLst", inputDataSet);
			if(!f1FareList.isEmpty())
			{
				String f1Price = f1FareList.get(0).get("F1_PRC");
				String reqPrnb = inputDataSet.get("REQ_PRNB");
				String exptPrice = String.valueOf((Integer.parseInt(f1Price) * Integer.parseInt(reqPrnb)));
				LOGGER.debug("F1운임(f1Price)::"+f1Price);
				LOGGER.debug("요청인원수(reqPrnb)::"+reqPrnb);
				LOGGER.debug("열차번호::"+inputDataSet.get("TRN_NO")+":::: 예상수입(exptPrice) ="+exptPrice);
				inputDataSet.put("F1_PRC", f1Price);
				inputDataSet.put("EXPT_PRICE", exptPrice);
			}else
			{
				isSimSuc = false;
			}
			
			
			LOGGER.debug("출발순서 조회");
			ArrayList<Map<String,String>> dptStnList = (ArrayList<Map<String, String>>) dao.list("com.korail.yz.ys.ea.YSEA001QMDAO.selectListDptStn", inputDataSet);
			LOGGER.debug("도착순서 조회");
			ArrayList<Map<String,String>> arvStnList = (ArrayList<Map<String, String>>) dao.list("com.korail.yz.ys.ea.YSEA001QMDAO.selectListArvStn", inputDataSet);
			
			//출발순서
			if(!dptStnList.isEmpty())
			{
				LOGGER.debug("출발순서DPT_ORDR::"+dptStnList.get(0).get("DPT_ORDR"));
				inputDataSet.put("DPT_ORDR", dptStnList.get(0).get("DPT_ORDR"));
			}else
			{
				isSimSuc = false;
			}
			//도착순서
			if(!arvStnList.isEmpty())
			{
				LOGGER.debug("도착순서ARV_ORDR::"+arvStnList.get(0).get("ARV_ORDR"));
				inputDataSet.put("ARV_ORDR", arvStnList.get(0).get("ARV_ORDR"));
			}else
			{
				isSimSuc = false;
			}
			
			
			
			//구간 최고 승차인원구하기(일반좌석)
			LOGGER.debug("구간 최고 승차인원구하기(일반좌석)");
			ArrayList<Map<String,String>> segMaxPrnb = (ArrayList<Map<String, String>>) dao.list("com.korail.yz.ys.ea.YSEA001QMDAO.selectListSegMaxPrnbLst", inputDataSet);
			if(!segMaxPrnb.isEmpty())
			{
				inputDataSet.put("MAX_PRNB", segMaxPrnb.get(0).get("MAX_PRNB"));
			}else
			{
				isSimSuc = false;
			}
			
			//풀구간(해당 열차 시-종착역)
			LOGGER.debug("풀구간(해당 열차 시-종착역)(DPT_STN_CD_MIN - ARV_STN_CD_MAX)구하기");
			ArrayList<Map<String,String>> maxStnCdList = (ArrayList<Map<String, String>>) dao.list("com.korail.yz.ys.ea.YSEA001QMDAO.selectListMaxStnCdLst", inputDataSet);
			if(!maxStnCdList.isEmpty())
			{
				inputDataSet.put("DPT_STN_CD_MIN", maxStnCdList.get(0).get("DPT_STN_CD_MIN"));
				inputDataSet.put("ARV_STN_CD_MAX", maxStnCdList.get(0).get("ARV_STN_CD_MAX"));
			}else
			{
				isSimSuc = false;
			}
			
			//풀구간 정상(F1)운임
			ArrayList<Map<String,String>> maxFareList = (ArrayList<Map<String, String>>) dao.list("com.korail.yz.ys.ea.YSEA001QMDAO.selectListMaxFareLst", inputDataSet);
			if(!maxFareList.isEmpty())
			{
				inputDataSet.put("MAX_FARE", maxFareList.get(0).get("MAX_FARE"));
			}else
			{
				isSimSuc = false;
			}
			//구간예상잔여석 = 좌석수 - 구간 최고 승차인원
			LOGGER.debug("구간예상잔여석 = 좌석수 - 구간 최고 승차인원");
			LOGGER.debug("좌석수:::"+inputDataSet.get("SEAT_NUM"));
			LOGGER.debug("구간 최고 승차인원:::"+inputDataSet.get("MAX_PRNB"));
			int leftYul = (Integer.parseInt(inputDataSet.get("SEAT_NUM")) - Integer.parseInt(inputDataSet.get("MAX_PRNB")));
			LOGGER.debug("구간예상잔여석:::"+leftYul);
			if (leftYul <= 0)
			{
				leftYul = 0;
			}
			//할인율 및 통과율오차 조회
			//LWST_DCNT_RT : 최저할인율
			//HGST_DCNT_RT : 최고할인율
			//LDFC_ERRO_RT : 통과율 오차
			if(isSimSuc)
			{
				LOGGER.debug("할인율 및 통과율오차 조회");
				ArrayList<Map<String,String>> nstpList = (ArrayList<Map<String, String>>) dao.list("com.korail.yz.ys.ea.YSEA001QMDAO.selectListDcntRtLst", inputCommonDataSet);
				
				if(nstpList.isEmpty())
				{
					ArrayList<Map<String, Object>> msgList = new ArrayList<Map<String,Object>>();
					Map<String, Object> msgSet = new HashMap<String, Object>();
					msgSet.put("MSG_CONT", "해당 노선의 할인율 기준정보가 존재하지 않습니다. \n\n하단 '할인율 기준관리' 버튼을 통해 \n\n해당 노선의 할인율 기준 정보를 입력해주시기 바랍니다.");
					msgList.add(msgSet);
					result.put("dsMsg", msgList);
					XframeControllerUtils.setMessage("IYS000008", result);
					return result;
				}
				
				// 기회비용 = ( 요청인원 - 잔여석  + 통과율 오차 * 구간공급좌석수) * 풀구간F1운임	* min (1, 0.4 +  예상 수입 / 풀구간F1운임 )
				//ldc_cost = ( ll_ps_cnt - ldc_yul  + ldc_nstp_rt_err * ll_bs_seat_cnt ) * ldc_full_price  * min ( 1, 0.4 +  ldc_f1_price / ldc_full_price)
				
				
				Double f1Price = Double.parseDouble(inputDataSet.get("F1_PRC")); 
				Double reqPrnb = Double.parseDouble(inputDataSet.get("REQ_PRNB")); 		    //ll_ps_cnt
				Double maxFare = Double.parseDouble(inputDataSet.get("MAX_FARE"));
				Double normalSeatCnt = Double.parseDouble(inputDataSet.get("NORMAL_SEAT_CNT")); // ll_bs_seat_cnt
				Double nstpRtErr = Double.parseDouble(nstpList.get(0).get("LDFC_ERRO_RT"));
				LOGGER.debug("예상수입(f1Price)::::"+f1Price);
				LOGGER.debug("요청인원(reqPrnb)::::"+reqPrnb);
				LOGGER.debug("풀구간F1운임(maxFare)::::"+maxFare);
				LOGGER.debug("구간공급좌석수(normalSeatCnt)::::"+normalSeatCnt);
				LOGGER.debug("통과율오차(nstpRtErr)::::"+nstpRtErr);
				LOGGER.debug("잔여석(leftYul)::::"+leftYul);
				double cost = (reqPrnb - leftYul + nstpRtErr * normalSeatCnt) * maxFare;
				LOGGER.debug("기회비용 = ( 요청인원 - 잔여석  + 통과율 오차 * 구간공급좌석수) * 풀구간F1운임	* min (1, 0.4 +  예상 수입 / 풀구간F1운임 )");
				LOGGER.debug("기회비용(cost)::::"+cost);
				double temp = 0.4 + (f1Price / maxFare);
				LOGGER.debug("temp::::"+temp);
				if( temp < 1 )
				{
					cost = cost * temp;
				}
				LOGGER.debug("cost 두번째::"+cost);
				double exptPrice = Double.parseDouble(inputDataSet.get("EXPT_PRICE"));
				LOGGER.debug("exptPrice::"+exptPrice);
				double rate = 1 - (cost / exptPrice);
				double minDiscRt = Double.parseDouble(nstpList.get(0).get("LWST_DCNT_RT"));
				double maxDiscRt = Double.parseDouble(nstpList.get(0).get("HGST_DCNT_RT"));
				double exctRate;
				try
				{
					exctRate = Double.parseDouble(inputDataSet.get("EXPCT_RT"));
				}catch(NumberFormatException e)
				{
					exctRate = 0;
				}
				LOGGER.debug("rate:::::"+rate);
				LOGGER.debug("minDiscRt:::::"+minDiscRt);
				LOGGER.debug("exctRate:::::"+exctRate);
				if((rate < minDiscRt) || (exctRate >= 67) || normalSeatCnt < reqPrnb) 
				{
					LOGGER.debug("rate::::"+rate);
					LOGGER.debug("minDiscRt::::"+minDiscRt);
					LOGGER.debug("exctRate::::"+exctRate);
					inputDataSet.put("DISCOUNT_RATE", "0");
					inputDataSet.put("YUL", String.valueOf(leftYul));
					inputDataSet.put("APPROVAL_YN", "예약거부");
					
				}else
				{
					double discountRate = (rate < maxDiscRt) ? rate : maxDiscRt;
					inputDataSet.put("DISCOUNT_RATE", String.valueOf((discountRate * 100)));
					inputDataSet.put("YUL", String.valueOf(leftYul));
					inputDataSet.put("APPROVAL_YN", "예약승인");
				}
			}
			else
			{
				inputDataSet.put("DISCOUNT_RATE", "0");
				inputDataSet.put("YUL", "0");
				inputDataSet.put("APPROVAL_YN", "시뮬레이션불가");
				isTotalSuc = false;
			}
			
		}
		
		if(isTotalSuc)
		{
			XframeControllerUtils.setMessage("IYS000007", result);	
		}
		else
		{
			XframeControllerUtils.setMessage("IYS000008", result);	
		}
		
		result.put("dsSim", inputDataList);
		return result;
	}
	
	

	/**
	 * @author 한현섭
	 * @date 2014. 5. 20. 오전 9:00:57
	 * Method description : 
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?>  selectListDcntRtLst(Map<String, ?> param){
		
		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		
		/* 입력 오브젝트 */
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCondition");
		//열차운영사업자구분코드 추가
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		inputDataSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		LOGGER.debug("inputDateSet--->"+inputDataSet);
		
		/* DAO - 쿼리 실행 후 결과 획득*/
		ArrayList<Map<String, Object>> resultList
		= (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.yb.aa.YBAA001QMDAO.", inputDataSet);
		
		for(int i=0;i<resultList.size() ;i++)
		{
			LOGGER.debug(resultList.get(i).toString());
		}
		//error 메시지 날리기
		if(resultList.isEmpty()){
			XframeControllerUtils.setMessage("IZZ000004", result);
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result);
		}
		result.put("dsGrdRoutInfo", resultList);
		return result;
	}
	
	

	/**
	 * @author 한현섭
	 * @date 2014. 5. 20. 오전 9:00:57
	 * Method description : 시뮬레이션시 할인율 조견표 적용을 할 경우 필요한 할인율 조견표 원본테이블 값들을 모두 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?>  selectListDcntRtTbLst(Map<String, ?> param){
		
		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		
		/* 입력 오브젝트 */
		
		/* 할인율 조견표 조회 */
		ArrayList<Map<String, Object>> resultList
		= (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.ys.ea.YSEA001QMDAO.selectListDcntRtTbLst", null);
		
		//error 메시지 날리기
		if(resultList.isEmpty()){
			XframeControllerUtils.setMessage("IZZ000004", result);
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result);
		}
		result.put("dsDcntRtTb", resultList);
		return result;
	}
	
	
}

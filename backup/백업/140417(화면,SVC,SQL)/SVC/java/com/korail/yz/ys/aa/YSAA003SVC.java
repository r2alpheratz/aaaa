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
	
	public  final Logger logger = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
	
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

		logger.debug("param ==> "+param);
		// search input column dataset
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCondJobDt");	
		logger.debug("inputDataSet ==>  " + inputDataSet);

		// search input column data
		logger.debug("inputData ==>  " + inputDataSet.toString());
		
		ArrayList<Map<String, Object>> resultList = (ArrayList) dao.list("com.korail.yz.ys.aa.YSAA003QMDAO.selectListYmgtTgtTrnDdprAnalJobDt", inputDataSet);

		
		for(int i=0;i<resultList.size();i++)
		{
			logger.debug(resultList.get(i).toString());
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

		logger.debug("param ==> "+param);
		// search input column dataset
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCondRunDt");	
		logger.debug("inputDataSet ==>  " + inputDataSet);

		// search input column data
		logger.debug("inputData ==>  " + inputDataSet.toString());
		
		ArrayList<Map<String, Object>> resultList = (ArrayList) dao.list("com.korail.yz.ys.aa.YSAA003QMDAO.selectListYmgtTgtTrnDdprAnalRunDt", inputDataSet);

		
		for(int i=0;i<resultList.size();i++)
		{
			logger.debug(resultList.get(i).toString());
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
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map<String, ?> selectListTrnPrFcstAcvmAbrdPrnb(Map<String, ?> param) {		

		Map<String, Object> result = new HashMap<String, Object>();
		logger.debug("param ==> "+param);
		// search input column dataset
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");	
		logger.debug("inputDataSet ==>  " + inputDataSet);
		ArrayList<Map<String, Object>> resultList = new ArrayList<Map<String,Object>>();
		
		logger.debug("01.장기예측승차인원 조회 시작 :::: START:::::::");
		
		ArrayList<Map<String, Object>> lgtmFcstPrnbList = new ArrayList<Map<String,Object>>(); /*01.장기예측인원*/
		ArrayList<Map<String, Object>> daspPrRsvCncPrnbList = new ArrayList<Map<String,Object>>(); /*01.장기예측인원데이터 가공전 DSP별 예발-취소 승차인원목록*/
		logger.debug("01-1) 장기예측 구분 ");
		ArrayList<Map<String, Object>> lgtmFcstDvList = (ArrayList) dao.list("com.korail.yz.ys.aa.YSAA003QMDAO.selectLgtmFcstDv", inputDataSet); 
		for(int i=0;i<lgtmFcstDvList.size();i++)
		{
			logger.debug("장기예측 구분 내역:::::"+lgtmFcstDvList.get(i));
		}
		
		/****
		 * 1. IF ( RUN_DV_CD == "3"  && YMS_APL_FLG =="Y"  이면  임시.. (참고 RUN_DV_CD====>  1:정기 2:부정기 3:임시 9:현시각)

		*			- LRG_CRG_DV_CD(대수송구분코드) 가 NOT NULL 이고 "03" 이면  하계 (d_yf35100_graph_temp_summer) ================= ⑥
		*			- LRG_CRG_DV_CD(대수송구분코드) 가 NOT NULL 이고 "04" 이면  연말연시 (d_yf35100_graph_temp_winter) ================= ⑦
		*			- HLDY_BF_AFT_DV_CD(공휴일전후구분코드) 가 NOT NULL 이면 공휴일 (d_yf35100_graph_temp_holi) ================= ⑧
		*			- ELSE면  임시일반(d_yf35100_graph_temp)	================= ⑤
		*	ELSE IF (운행구분코드가 3아님    )
	     *				그냥 대수송구분코드가 03 이면 하계 (d_yf35100_graph_summer)  ===================== ②
		 *				대수송구분코드가 04 이면  연말연시 (d_yf35100_graph_winter)  ================= ③
		 *	HLDY_BF_AFT_DV_CD(공휴일전후구분코드)가 NOT NULL 이면 공휴일 (d_yf35100_graph_holi) ================= ④
		 *
		 *	ELSE 노말 (d_yf35100_graph_normal)    ======================= ①
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
				logger.debug("임시하계 장기예측 조회!");
				//daspPrRsvCncPrnbList =  (ArrayList) dao.list("com.korail.yz.ys.aa.YSAA003QMDAO.selectListLgtmFcstPrnbTmpSmer", inputDataSet);
			}
			else if("04".equals(lgtmFcstDvList.get(0).get("LRG_CRG_DV_CD"))) /*대수송구분코드가 03이면 임시연말연시 (d_yf35100_graph_temp_winter) ================= ⑦*/
			{
				logger.debug("임시연말연시 장기예측 조회!");
				//daspPrRsvCncPrnbList =  (ArrayList) dao.list("com.korail.yz.ys.aa.YSAA003QMDAO.selectListLgtmFcstPrnbTmpWntr", inputDataSet);
			}
			else if(lgtmFcstDvList.get(0).get("HLDY_BF_AFT_DV_CD") != null) /*공휴일전후구분코드가 NOT NULL 이면 임시공휴일 (d_yf35100_graph_temp_holi) ================= ⑧*/
			{
				logger.debug("임시공휴일 장기예측 조회!");
				//daspPrRsvCncPrnbList =  (ArrayList) dao.list("com.korail.yz.ys.aa.YSAA003QMDAO.selectListLgtmFcstPrnbTmpLghd", inputDataSet);
			}
			else /*ELSE면  임시일반(d_yf35100_graph_temp)	================= ⑤*/
			{
				logger.debug("임시노말 장기예측 조회!");
				//daspPrRsvCncPrnbList =  (ArrayList) dao.list("com.korail.yz.ys.aa.YSAA003QMDAO.selectListLgtmFcstPrnbTmpNml", inputDataSet);
			}
		}
		else if("03".equals(lgtmFcstDvList.get(0).get("LRG_CRG_DV_CD"))) /*하계 (d_yf35100_graph_summer)  ===================== ②*/
		{
			logger.debug("(일반)하계 장기예측 조회!");
			//daspPrRsvCncPrnbList =  (ArrayList) dao.list("com.korail.yz.ys.aa.YSAA003QMDAO.selectListLgtmFcstPrnbSmer", inputDataSet);
		}
		else if("04".equals(lgtmFcstDvList.get(0).get("LRG_CRG_DV_CD")))   /*연말연시 (d_yf35100_graph_winter)  ================= ③*/
		{
			logger.debug("(일반)연말연시 장기예측 조회!");
			//daspPrRsvCncPrnbList =  (ArrayList) dao.list("com.korail.yz.ys.aa.YSAA003QMDAO.selectListLgtmFcstPrnbWntr", inputDataSet);
		}
		else if(lgtmFcstDvList.get(0).get("HLDY_BF_AFT_DV_CD") != null) /*공휴일 (d_yf35100_graph_holi) ================= ④*/
		{
			logger.debug("(일반)공휴일 장기예측 조회!");
			//daspPrRsvCncPrnbList =  (ArrayList) dao.list("com.korail.yz.ys.aa.YSAA003QMDAO.selectListLgtmFcstPrnbLghd", inputDataSet);
		}
		else /*노말 (d_yf35100_graph_normal)    ======================= ①*/
		{
			logger.debug("(일반)노말 장기예측 조회!");
			//daspPrRsvCncPrnbList =  (ArrayList) dao.list("com.korail.yz.ys.aa.YSAA003QMDAO.selectListLgtmFcstPrnbNml", inputDataSet);
		}
	
		/*for(int i=0;i<daspPrRsvCncPrnbList.size();i++)
		{
			logger.debug("예약발매실적:::::"+daspPrRsvCncPrnbList.get(i));
		}*/
		
		/**TODO
		 * ※  위는 DSP별 예발인원 / 취소인원 조회내역임 아래에서 데이터가공이 필요함  
		 *   -- 출발전일수별  예측승차인원
		 *    -- >  예약발매인원 - 취소인원 값으로 처리... 
		 *  */
		
		
		logger.debug("01.장기예측승차인원 조회 끝 :::: END:::::::");		
		
		
		logger.debug("02.최종예측인원 조회 시작 :::: START:::::::");
		ArrayList<Map<String, Object>> lastFcstPrnbList = (ArrayList) dao.list("com.korail.yz.ys.aa.YSAA003QMDAO.selectListLastFcstPrnb", inputDataSet); /*02.최종예측인원*/
		logger.debug("최종예측인원:::::"+lastFcstPrnbList.get(0));
		logger.debug("02.최종예측인원 조회 끝 :::: END:::::::");

		
		logger.debug("03.예약발매실적 조회 시작 :::: START:::::::");
		ArrayList<Map<String, Object>> rsvSaleAcvmList = (ArrayList) dao.list("com.korail.yz.ys.aa.YSAA003QMDAO.selectListRsvSaleAcvm", inputDataSet); /*03.예약발매실적*/
		for(int i=0;i<rsvSaleAcvmList.size();i++)
		{
			logger.debug("예약발매실적:::::"+rsvSaleAcvmList.get(i));
		}
		logger.debug("03.예약발매실적 조회 끝 :::: END:::::::");
		
		

		for (int i = 0; i < 32; i++)
		{
			Map<String, Object> resultMap = new HashMap<String, Object>();
			resultMap.put("DPT_BF_DT_NUM", i); /*출발이전일자수*/
			
			if(lgtmFcstPrnbList.size() > i) /*01.장기예측인원*/
			{
				//resultMap.put("LGTM_FCST_PRNB", lgtmFcstPrnbList.get(i).get("LGTM_FCST_PRNB"));
			}
			else
			{
				resultMap.put("LGTM_FCST_PRNB", "");
			}
			
			if(lastFcstPrnbList.size() > i) /*02.최종예측인원*/
			{
				resultMap.put("LAST_FCST_PRNB", lastFcstPrnbList.get(i).get("LAST_FCST_PRNB"));
			}
			else
			{
				resultMap.put("LAST_FCST_PRNB", "");
			}
			
			if(rsvSaleAcvmList.size() > i)  /*03.예약발매실적*/
			{
				resultMap.put("RSV_SALE_ACVM_PRNB", rsvSaleAcvmList.get(i).get("RSV_SALE_ACVM_PRNB"));
			}
			else
			{
				resultMap.put("RSV_SALE_ACVM_PRNB", "");
			}
			
			resultList.add(i, resultMap);
			
			
		}
		
		for(int i=0;i<resultList.size();i++)
		{
			logger.debug("결과LIST:::::"+resultList.get(i));
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

		logger.debug("param ==> "+param);
		// search input column dataset
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsOptSeqCondition");	
		logger.debug("inputDataSet ==>  " + inputDataSet);

		// search input column data
		logger.debug("inputData ==>  " + inputDataSet.toString());
		
		ArrayList<Map<String, Object>> resultList = (ArrayList) dao.list("com.korail.yz.ys.aa.YSAA003QMDAO.selectListQtmzSgmpAlcCnqe", inputDataSet);

		
		for(int i=0;i<resultList.size();i++)
		{
			logger.debug(resultList.get(i).toString());
		}
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
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map<String, ?> selectListQtmzSelectedSgmp(Map<String, ?> param) {
		Map<String, Object> result = new HashMap<String, Object>();

		logger.debug("param ==> "+param);
		// search input column dataset
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsGrdSelCond");	
		logger.debug("inputDataSet ==>  " + inputDataSet);

		// search input column data
		logger.debug("inputData ==>  " + inputDataSet.toString());
		
		ArrayList<Map<String, Object>> resultList = (ArrayList) dao.list("com.korail.yz.ys.aa.YSAA003QMDAO.selectListQtmzSelectedSgmp", inputDataSet);

		
		for(int i=0;i<resultList.size();i++)
		{
			logger.debug(resultList.get(i).toString());
		}
		//error 메시지 날리기
		if(resultList.isEmpty()){
			XframeControllerUtils.setMessage("IZZ000004", result);
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result);
		}
		result.put("dsGrdSelLst", resultList);

		return result;
	}
}
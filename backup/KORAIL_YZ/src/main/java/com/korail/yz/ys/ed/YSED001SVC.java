/**
 * project : KORAIL_YZ
 * package : com.korail.yz.ys.ed
 * date : 2014. 6. 27.오후 1:35:51
 */
package com.korail.yz.ys.ed;

import java.math.BigDecimal;
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
 * @author EQ
 * @date 2014. 6. 27. 오후 1:35:51
 * Class description : 임시열차시뮬레이션SVC
 * 과거 임시열차 운행 실적을 기준으로 그 이전 운행실적이 없는 기간과의 승차인원, 수입 등의 
 * 증감을 비교하여 임시열차 운행을 시뮬레이션 하는 기능의 Service 클래스
 */
@Service("com.korail.yz.ys.ed.YSED001SVC")
public class YSED001SVC {
	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public  static final Logger  LOGGER = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
	
	/**
	 * 임시열차 실적조회
	 * @author 김응규
	 * @date 2014. 6. 12. 오후 1:36:00
	 * Method description : 참조기간 실적과 임시열차 수입실적을 조회한다.
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map<String, ?> selectListTtrnAcvm(Map<String, ?> param) {		

		Map<String, Object> result = new HashMap<String, Object>();

		LOGGER.debug("param ==> "+param);
		// search input column dataset
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");	
		//열차운영사업자구분코드 추가
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		inputDataSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		LOGGER.debug("inputDataSet ==>  " + inputDataSet);
		
		
		double ddAbrdPrnb[] = new double[3];
		double ddAmt[] = new double[3];
		double ddAmtPerCnt[] = new double[3];
		
		
		double idRt[] = new double[3];
		double idAmt[] = new double[3];
		double idAbrdPrnb[] = new double[3];
		double idAmtPerCnt[] = new double[3];
		
		double ldRt[] = new double[3];
		
		//임시열차투입실적 조회
		ArrayList<Map<String, Object>> ttrnIvstAcvmList = (ArrayList) dao.list("com.korail.yz.ys.ed.YSED001QMDAO.selectListTtrnIvstAcvm", inputDataSet);
		ArrayList<Map<String, Object>> refTrmAcvmList = new ArrayList<Map<String,Object>>();
		ArrayList<Map<String, Object>> arrList = new ArrayList<Map<String,Object>>();
		
		if(ttrnIvstAcvmList.size() == 3)
		{
			inputDataSet.put("TRN_NO1", String.valueOf(ttrnIvstAcvmList.get(0).get("TRN_NO")));
			inputDataSet.put("TRN_NO2", String.valueOf(ttrnIvstAcvmList.get(2).get("TRN_NO")));
			LOGGER.debug("첫번째 열차번호::::"+inputDataSet.get("TRN_NO1"));
			LOGGER.debug("두번째 열차번호::::"+inputDataSet.get("TRN_NO2"));
			
			//참조기간실적 조회
			refTrmAcvmList = (ArrayList) dao.list("com.korail.yz.ys.ed.YSED001QMDAO.selectListRefTrmAcvm", inputDataSet);
			
			/* 각 열차의 승차인원, 승차율, 승차수입 비율 계산 */
			LOGGER.debug("::::::::::::::::각 열차의 승차인원, 승차율, 승차수입 비율 계산:::::::::::::");
			if(refTrmAcvmList.size() == 2)
			{
				for (int i = 0; i < refTrmAcvmList.size(); i++)
				{
					if(i == 0)
					{
						ddAbrdPrnb[0] = Double.parseDouble(String.valueOf(ttrnIvstAcvmList.get(i).get("ABRD_PRNB")));
						LOGGER.debug("["+i+"]번째 ddAbrdPrnb[0]::::"+ddAbrdPrnb[0]);
					}
					else
					{
						ddAbrdPrnb[0] = Double.parseDouble(String.valueOf(ttrnIvstAcvmList.get(i+1).get("ABRD_PRNB")));
						LOGGER.debug("["+i+"]번째 ddAbrdPrnb[0]::::"+ddAbrdPrnb[0]);
					}
					ddAbrdPrnb[1] = Double.parseDouble(String.valueOf(refTrmAcvmList.get(i).get("ABRD_PRNB")));
					LOGGER.debug("["+i+"]번째 ddAbrdPrnb[1]::::"+ddAbrdPrnb[1]);
					
					
					if(ddAbrdPrnb[1] <= 0)
					{
						idAbrdPrnb[i] = (double) 0;
						LOGGER.debug("["+i+"]번째 idAbrdPrnb[i]::::"+idAbrdPrnb[i]);
					}
					else
					{
						idAbrdPrnb[i] = (double) (ddAbrdPrnb[0] / ddAbrdPrnb[1]);
						LOGGER.debug("["+i+"]번째 idAbrdPrnb[i]::::"+idAbrdPrnb[i]);
					}
					
					if(i == 0)
					{
						LOGGER.debug("["+i+"]번째 RATE1::::"+BigDecimal.valueOf(idAbrdPrnb[i]*100));
						ttrnIvstAcvmList.get(i).put("RATE1", BigDecimal.valueOf(idAbrdPrnb[i]*100));
					}
					else
					{
						LOGGER.debug("["+i+"]번째 RATE1::::"+BigDecimal.valueOf(idAbrdPrnb[i]*100));
						ttrnIvstAcvmList.get(i+1).put("RATE1", BigDecimal.valueOf(idAbrdPrnb[i]*100));
					}
					
					if(i == 0)
					{
						ldRt[0] = Double.parseDouble(String.valueOf(ttrnIvstAcvmList.get(i).get("ABRD_RT")));
						
					}
					else
					{
						ldRt[0] =  Double.parseDouble(String.valueOf(ttrnIvstAcvmList.get(i+1).get("ABRD_RT")));
					}
					ldRt[1] =  Double.parseDouble(String.valueOf(refTrmAcvmList.get(i).get("ABRD_RT")));
					if(ldRt[1] <= 0)
					{
						idRt[i] = 0;
					}
					else
					{
						LOGGER.debug("ldRt[0]::::"+ldRt[0] + "  ldRt[1]::::"+ldRt[1] );
						idRt[i] = ldRt[0] / ldRt[1];
						LOGGER.debug("ldRt[0]/ldRt[1]::::"+idRt[i] );
					}
					
					if(i == 0)
					{
						LOGGER.debug("["+i+"]번째 RATE2::::"+BigDecimal.valueOf(idRt[i]*100));
						ttrnIvstAcvmList.get(i).put("RATE2", BigDecimal.valueOf(idRt[i]*100));
					}
					else
					{
						LOGGER.debug("["+i+"]번째 RATE2::::"+BigDecimal.valueOf(idRt[i]*100));
						ttrnIvstAcvmList.get(i+1).put("RATE2", BigDecimal.valueOf(idRt[i]*100));
					}
					
					if(i == 0)
					{
						ddAmt[0] = Double.parseDouble(String.valueOf(ttrnIvstAcvmList.get(i).get("BIZ_RVN_AMT")));
					}
					else
					{
						ddAmt[0] = Double.parseDouble(String.valueOf(ttrnIvstAcvmList.get(i+1).get("BIZ_RVN_AMT")));
					}
					ddAmt[1] = Double.parseDouble(String.valueOf(refTrmAcvmList.get(i).get("BIZ_RVN_AMT")));
					if(ddAmt[1] <= 0)
					{
						idAmt[i] = 0;
					}
					else
					{
						idAmt[i] = ddAmt[0] / ddAmt[1];
					}
					
					if(i == 0)
					{
						ttrnIvstAcvmList.get(i).put("RATE3", BigDecimal.valueOf(idAmt[i]*100));
					}
					else
					{
						ttrnIvstAcvmList.get(i+1).put("RATE3", BigDecimal.valueOf(idAmt[i]*100));
					}
					
					if(i == 0)
					{
						ddAmtPerCnt[0] = Double.parseDouble(String.valueOf(ttrnIvstAcvmList.get(i).get("BIZ_RVN_AMT_PER_BS_SEAT_CNT")));
					}
					else
					{
						ddAmtPerCnt[0] = Double.parseDouble(String.valueOf(ttrnIvstAcvmList.get(i+1).get("BIZ_RVN_AMT_PER_BS_SEAT_CNT")));
					}
					ddAmtPerCnt[1] = Double.parseDouble(String.valueOf(refTrmAcvmList.get(i).get("BIZ_RVN_AMT_PER_BS_SEAT_CNT")));
					
					if(ddAmtPerCnt[1] <= 0)
					{
						idAmtPerCnt[i] = 0;
					}
					else
					{
						idAmtPerCnt[i] = ddAmtPerCnt[0] / ddAmtPerCnt[1];
					}
					
					if(i == 0)
					{
						ttrnIvstAcvmList.get(i).put("RATE4", BigDecimal.valueOf(idAmtPerCnt[i]*100));
					}
					else
					{
						ttrnIvstAcvmList.get(i+1).put("RATE4", BigDecimal.valueOf(idAmtPerCnt[i]*100));
					}
					
				} //END for
				/* 운행일에 해당하는 열차의 승차인원, 승차율, 승차수입 비율 계산 */
				LOGGER.debug("::::::::::운행일에 해당하는 열차의 승차인원, 승차율, 승차수입 비율 계산::::::::::");
				if((Double.parseDouble(String.valueOf(refTrmAcvmList.get(0).get("ABRD_PRNB"))) 
						+ Double.parseDouble(String.valueOf(refTrmAcvmList.get(1).get("ABRD_PRNB")))) / 2 <= 0)
				{
					idAbrdPrnb[2] = 0;
				}
				else
				{
					idAbrdPrnb[2] =  Double.parseDouble(String.valueOf(ttrnIvstAcvmList.get(1).get("ABRD_PRNB"))) 
							/ ((Double.parseDouble(String.valueOf(refTrmAcvmList.get(0).get("ABRD_PRNB")))
									+  Double.parseDouble(String.valueOf(refTrmAcvmList.get(1).get("ABRD_PRNB")))) / 2);
					
				}
				if(( Double.parseDouble(String.valueOf(refTrmAcvmList.get(0).get("ABRD_RT"))) 
						+  Double.parseDouble(String.valueOf(refTrmAcvmList.get(1).get("ABRD_RT")))) / 2 <= 0)
				{
					idRt[2] = 0;
				}
				else
				{
					idRt[2] =  Double.parseDouble(String.valueOf(ttrnIvstAcvmList.get(1).get("ABRD_RT"))) 
								/ (( Double.parseDouble(String.valueOf(refTrmAcvmList.get(0).get("ABRD_RT"))) 
										+  Double.parseDouble(String.valueOf(refTrmAcvmList.get(1).get("ABRD_RT")))) / 2);
				}
				
				if(( Double.parseDouble(String.valueOf(refTrmAcvmList.get(0).get("BIZ_RVN_AMT"))) 
						+  Double.parseDouble(String.valueOf(refTrmAcvmList.get(1).get("BIZ_RVN_AMT")))) / 2 <= 0)
				{
					idAmt[2] = 0;
				}
				else
				{
					idAmt[2] =  Double.parseDouble(String.valueOf(ttrnIvstAcvmList.get(1).get("BIZ_RVN_AMT"))) 
								/ (( Double.parseDouble(String.valueOf(refTrmAcvmList.get(0).get("BIZ_RVN_AMT"))) 
										+  Double.parseDouble(String.valueOf(refTrmAcvmList.get(1).get("BIZ_RVN_AMT")))) / 2);
				}
				
				if(( Double.parseDouble(String.valueOf(refTrmAcvmList.get(0).get("BIZ_RVN_AMT_PER_BS_SEAT_CNT"))) 
						+  Double.parseDouble(String.valueOf(refTrmAcvmList.get(1).get("BIZ_RVN_AMT_PER_BS_SEAT_CNT")))) / 2 <= 0)
				{
					idAmtPerCnt[2] = 0;
				}
				else
				{
					idAmtPerCnt[2] =  Double.parseDouble(String.valueOf(ttrnIvstAcvmList.get(1).get("BIZ_RVN_AMT_PER_BS_SEAT_CNT"))) 
									/ (( Double.parseDouble(String.valueOf(refTrmAcvmList.get(0).get("BIZ_RVN_AMT_PER_BS_SEAT_CNT"))) 
											+  Double.parseDouble(String.valueOf(refTrmAcvmList.get(1).get("BIZ_RVN_AMT_PER_BS_SEAT_CNT")))) / 2);
				}
				
				ttrnIvstAcvmList.get(1).put("RATE1", BigDecimal.valueOf(idAbrdPrnb[2]*100));
				ttrnIvstAcvmList.get(1).put("RATE2", BigDecimal.valueOf(idRt[2]*100));
				ttrnIvstAcvmList.get(1).put("RATE3", BigDecimal.valueOf((idAmt[2]*100)));
				ttrnIvstAcvmList.get(1).put("RATE4", BigDecimal.valueOf((idAmtPerCnt[2]*100)));
				
				
			} //END if(refTrmAcvmList.size() == 2)
			else
			{
				throw new CosmosRuntimeException("EYS000006", null);  //선택하신 운행일자 전일부터 2주간 동일요일의 실적 조회 결과가 2건이 아닙니다.
			}
		} //END if(ttrnIvstAcvmList.size() == 3)
		else
		{
			throw new CosmosRuntimeException("EYS000005", null);  //선택하신 운행일자의 실적 조회 결과가 3건이 아닙니다.
		}
		
		
		
		//메시지 처리
		if(ttrnIvstAcvmList.isEmpty())
		{
			XframeControllerUtils.setMessage("IZZ000004", result); //해당 조건의 자료가 존재하지 않습니다.
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result); //정상적으로 조회 되었습니다.
		}
		for(int i = 0; i < ttrnIvstAcvmList.size(); i++)
		{
			LOGGER.debug("::::::::::ttrnIvstAcvmList ::::::::: SIZE = "+ttrnIvstAcvmList.size()+"\n"+ttrnIvstAcvmList.get(i));
		}
		for(int i = 0; i < refTrmAcvmList.size(); i++)
		{
			LOGGER.debug("::::::::::refTrmAcvmList ::::::::: SIZE = "+refTrmAcvmList.size()+"\n"+refTrmAcvmList.get(i));
		}
		
		result.put("dsList", ttrnIvstAcvmList);
		result.put("dsList2", refTrmAcvmList);
		
		
		/*
		 * 계산 결과값으로 사용된 idXXX 배열이 시뮬레이션 시에도 사용되어 화면단으로 return 해줌
		 */
		for (int i = 0; i < 3; i++)
		{
			Map<String, Object> arrMap = new HashMap<String, Object>();
			arrMap.put("idRt", idRt[i]);
			arrMap.put("idAmt", idAmt[i]);
			arrMap.put("idAbrdPrnb", idAbrdPrnb[i]);
			arrMap.put("idAmtPerCnt", idAmtPerCnt[i]);
			arrList.add(arrMap);	
		}
		
		
		result.put("dsArr", arrList);
		
		return result;

	}
	
	/**
	 * 임시열차 시뮬레이션 실행
	 * @author 김응규
	 * @date 2014. 7. 1. 오후 1:49:00
	 * Method description : 임시열차 투입 전/후 예상실적을 조회하여 비교한다.
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map<String, ?> selectListTtrnSiml(Map<String, ?> param) {		

		Map<String, Object> result = new HashMap<String, Object>();

		LOGGER.debug("param ==> "+param);
		// search input column dataset
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");	
		//열차운영사업자구분코드 추가
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		inputDataSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		LOGGER.debug("inputDataSet ==>  " + inputDataSet);
		
		ArrayList<Map<String, String>> arrList = (ArrayList<Map<String, String>>) param.get("dsArr");
		for (int i = 0; i < arrList.size(); i++)
		{
			LOGGER.debug("arrList ===> index::["+i+"]::>"+arrList.get(i));
		}
		double ddAbrdPrnb[] = new double[3];
		double ddRt[] = new double[3];
		double ddAmt[] = new double[3];
		double ddAmtPerCnt[] = new double[3];
		
		double idAbrdPrnb[] = new double[3];
		double idRt[] = new double[3];
		double idAmt[] = new double[3];
		double idAmtPerCnt[] = new double[3];
		
		/* 배열에 값넣기 */
		for (int i = 0; i < arrList.size(); i++)
		{
			idAbrdPrnb[i] = Double.parseDouble(String.valueOf(arrList.get(i).get("idAbrdPrnb")));
			idRt[i] = Double.parseDouble(String.valueOf(arrList.get(i).get("idRt")));
			idAmt[i] = Double.parseDouble(String.valueOf(arrList.get(i).get("idAmt")));
			idAmtPerCnt[i] = Double.parseDouble(String.valueOf(arrList.get(i).get("idAmtPerCnt")));
		}
		
		
		/* main DataSet(임시열차투입실적) 가져와서 배열에 값 넣기 */
		ArrayList<Map<String, String>> mainList = (ArrayList<Map<String, String>>) param.get("dsList");
		for (int i = 0; i < mainList.size(); i++)
		{
			LOGGER.debug("mainList ===> index::["+i+"]::>"+mainList.get(i));
		}
		
		double mdAbrdPrnb[] = new double[3];
		double mdRt[] = new double[3];
		double mdAmt[] = new double[3];
		double mdAmtPerCnt[] = new double[3];
		
		/* 배열에 값넣기 */
		for (int i = 0; i < mainList.size(); i++)
		{
			mdAbrdPrnb[i] = Double.parseDouble(String.valueOf(mainList.get(i).get("ABRD_PRNB")));
			mdRt[i] = Double.parseDouble(String.valueOf(mainList.get(i).get("ABRD_RT")));
			mdAmt[i] = Double.parseDouble(String.valueOf(mainList.get(i).get("BIZ_RVN_AMT")));
			mdAmtPerCnt[i] = Double.parseDouble(String.valueOf(mainList.get(i).get("BIZ_RVN_AMT_PER_BS_SEAT_CNT")));
		}
		
		
		//임시열차 투입 전 예상조회
		LOGGER.debug("임시열차 투입 전 예상조회 START!!!!");
		ArrayList<Map<String, Object>> ttrnIvstBfFcstAcvmList = (ArrayList) dao.list("com.korail.yz.ys.ed.YSED001QMDAO.selectListTtrnIvstBfFcst", inputDataSet);
		ArrayList<Map<String, Object>> ttrnIvstAftFcstAcvmList = new ArrayList<Map<String,Object>>();
		Map<String, Object> ttrnMap = new HashMap<String, Object>();  
		Map<String, Object> ttrnMap2 = new HashMap<String, Object>();
		Map<String, Object> ttrnMap3 = new HashMap<String, Object>();
		
		if(ttrnIvstBfFcstAcvmList.size() == 2)
		{
			
			for (int i = 0; i < ttrnIvstBfFcstAcvmList.size(); i++)
			{
				if(i == 0)
				{
					ttrnMap.put("TRN_NO", ttrnIvstBfFcstAcvmList.get(i).get("TRN_NO"));
					ttrnMap.put("DPT_TM", ttrnIvstBfFcstAcvmList.get(i).get("DPT_TM"));
					ttrnMap.put("DPT_TM_EXPR", ttrnIvstBfFcstAcvmList.get(i).get("DPT_TM_EXPR"));
					
					ddAbrdPrnb[0] = Double.parseDouble(String.valueOf(ttrnIvstBfFcstAcvmList.get(i).get("ABRD_PRNB")));
					
					ttrnMap.put("ABRD_PRNB", Math.round(ddAbrdPrnb[0] * idAbrdPrnb[i])); 
					ttrnMap.put("RATE1", idAbrdPrnb[i] * 100);
					
					ddRt[0] = Double.parseDouble(String.valueOf(ttrnIvstBfFcstAcvmList.get(i).get("ABRD_RT")));
					
					ttrnMap.put("ABRD_RT", ddRt[0] * idRt[i]);
					ttrnMap.put("RATE2", idRt[i] * 100);
					
					ddAmt[0] = Double.parseDouble(String.valueOf(ttrnIvstBfFcstAcvmList.get(i).get("BIZ_RVN_AMT")));
					LOGGER.debug("첫번째 ddAmt[0]"+ddAmt[0]);
					LOGGER.debug("첫번째 idAmt[i]"+idAmt[i]);
					ttrnMap.put("BIZ_RVN_AMT", Math.round((ddAmt[0] * idAmt[i])));
					LOGGER.debug("첫번째 BIZ_RVN_AMT"+ttrnMap.get("BIZ_RVN_AMT"));
					ttrnMap.put("RATE3", idAmt[i] * 100);
					
					ddAmtPerCnt[0] = Double.parseDouble(String.valueOf(ttrnIvstBfFcstAcvmList.get(i).get("BIZ_RVN_AMT_PER_BS_SEAT_CNT")));
					
					ttrnMap.put("BIZ_RVN_AMT_PER_BS_SEAT_CNT", Math.round(ddAmtPerCnt[0] * idAmtPerCnt[i]));
					ttrnMap.put("RATE4", idAmtPerCnt[i] * 100);	
				}
				else
				{
					ttrnMap3.put("TRN_NO", ttrnIvstBfFcstAcvmList.get(i).get("TRN_NO"));
					ttrnMap3.put("DPT_TM", ttrnIvstBfFcstAcvmList.get(i).get("DPT_TM"));
					ttrnMap3.put("DPT_TM_EXPR", ttrnIvstBfFcstAcvmList.get(i).get("DPT_TM_EXPR"));
					
					ddAbrdPrnb[0] = Double.parseDouble(String.valueOf(ttrnIvstBfFcstAcvmList.get(i).get("ABRD_PRNB")));
					
					ttrnMap3.put("ABRD_PRNB", Math.round(ddAbrdPrnb[0] * idAbrdPrnb[i])); 
					ttrnMap3.put("RATE1", idAbrdPrnb[i] * 100);
					
					ddRt[0] = Double.parseDouble(String.valueOf(ttrnIvstBfFcstAcvmList.get(i).get("ABRD_RT")));
					
					ttrnMap3.put("ABRD_RT", ddRt[0] * idRt[i]);
					ttrnMap3.put("RATE2", idRt[i] * 100);
					
					ddAmt[0] = Double.parseDouble(String.valueOf(ttrnIvstBfFcstAcvmList.get(i).get("BIZ_RVN_AMT")));
					LOGGER.debug("두번째 ddAmt[0]"+ddAmt[0]);
					LOGGER.debug("두번째 idAmt[i]"+idAmt[i]);
					ttrnMap3.put("BIZ_RVN_AMT", Math.round(ddAmt[0] * idAmt[i]));
					LOGGER.debug("두번째 BIZ_RVN_AMT"+ttrnMap3.get("BIZ_RVN_AMT"));
					ttrnMap3.put("RATE3", idAmt[i] * 100);
					
					ddAmtPerCnt[0] = Double.parseDouble(String.valueOf(ttrnIvstBfFcstAcvmList.get(i).get("BIZ_RVN_AMT_PER_BS_SEAT_CNT")));
					
					ttrnMap3.put("BIZ_RVN_AMT_PER_BS_SEAT_CNT", Math.round(ddAmtPerCnt[0] * idAmtPerCnt[i]));
					ttrnMap3.put("RATE4", idAmtPerCnt[i] * 100);
				}
			} //END for
			LOGGER.debug(":::::::::ttrnIvstAftFcstAcvmList::::::"+ttrnIvstAftFcstAcvmList);
			LOGGER.debug(":::::::::임시열차 승차인원, 승차율, 승차수입 계산::::::");
			
			ttrnMap2.put("TRN_NO", "임시");
			ttrnMap2.put("DPT_TM", inputDataSet.get("DPT_TM"));
			ttrnMap2.put("DPT_TM_EXPR", String.valueOf(inputDataSet.get("DPT_TM")).substring(0, 2).concat(":").concat(String.valueOf(inputDataSet.get("DPT_TM")).substring(2, 4)));
			
			ddAbrdPrnb[0] = Double.parseDouble(String.valueOf(ttrnIvstBfFcstAcvmList.get(0).get("ABRD_PRNB")))
								+Double.parseDouble(String.valueOf(ttrnIvstBfFcstAcvmList.get(1).get("ABRD_PRNB")));
			
			if(mdAbrdPrnb[0] + mdAbrdPrnb[2] <= 0)
			{
				ttrnMap2.put("ABRD_PRNB", 0);
			}
			else
			{
				ttrnMap2.put("ABRD_PRNB", Math.round((ddAbrdPrnb[0] * mdAbrdPrnb[1]) / (mdAbrdPrnb[0] + mdAbrdPrnb[2])));
			}
			
			ttrnMap2.put("RATE1", idAbrdPrnb[2] * 100);
			
			
			
			ddRt[0] = Double.parseDouble(String.valueOf(ttrnIvstBfFcstAcvmList.get(0).get("ABRD_RT")))
					+Double.parseDouble(String.valueOf(ttrnIvstBfFcstAcvmList.get(1).get("ABRD_RT")));

			if(mdRt[0] + mdRt[2] <= 0)
			{
				ttrnMap2.put("ABRD_RT", 0);
			}
			else
			{
				ttrnMap2.put("ABRD_RT", Math.round((ddRt[0] * mdRt[1]) / (mdRt[0] + mdRt[2])));
			}
			
			ttrnMap2.put("RATE2", idRt[2] * 100);

			
			ddAmt[0] = Double.parseDouble(String.valueOf(ttrnIvstBfFcstAcvmList.get(0).get("BIZ_RVN_AMT")))
					+Double.parseDouble(String.valueOf(ttrnIvstBfFcstAcvmList.get(1).get("BIZ_RVN_AMT")));

			if(mdRt[0] + mdRt[2] <= 0)
			{
				ttrnMap2.put("BIZ_RVN_AMT", 0);
			}
			else
			{
				ttrnMap2.put("BIZ_RVN_AMT", Math.round((ddAmt[0] * mdAmt[1]) / (mdAmt[0] + mdAmt[2])));
			}
			
			ttrnMap2.put("RATE3", idAmt[2] * 100);			

			
			ddAmtPerCnt[0] = Double.parseDouble(String.valueOf(ttrnIvstBfFcstAcvmList.get(0).get("BIZ_RVN_AMT_PER_BS_SEAT_CNT")))
					+Double.parseDouble(String.valueOf(ttrnIvstBfFcstAcvmList.get(1).get("BIZ_RVN_AMT_PER_BS_SEAT_CNT")));

			if(mdAmtPerCnt[0] + mdAmtPerCnt[2] <= 0)
			{
				ttrnMap2.put("BIZ_RVN_AMT_PER_BS_SEAT_CNT", 0);
			}
			else
			{
				ttrnMap2.put("BIZ_RVN_AMT_PER_BS_SEAT_CNT", Math.round((ddAmtPerCnt[0] * mdAmtPerCnt[1]) / (mdAmtPerCnt[0] + mdAmtPerCnt[2])));
			}
			
			ttrnMap2.put("RATE4", idAmtPerCnt[2] * 100);
			
		} //END if(ttrnIvstBfFcstAcvmList.size() == 2)
		else
		{
			throw new CosmosRuntimeException("EYS000006", null);  //선택하신 운행일자 전일부터 2주간 동일요일의 실적 조회 결과가 2건이 아닙니다.
		}
		
		
		//메시지 처리
		if(ttrnIvstBfFcstAcvmList.isEmpty())
		{
			XframeControllerUtils.setMessage("IZZ000004", result); //해당 조건의 자료가 존재하지 않습니다.
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result); //정상적으로 조회 되었습니다.
		}
		
		ttrnIvstAftFcstAcvmList.add(ttrnMap);
		ttrnIvstAftFcstAcvmList.add(ttrnMap2);
		ttrnIvstAftFcstAcvmList.add(ttrnMap3);
		
		for(int i = 0; i < ttrnIvstBfFcstAcvmList.size(); i++)
		{
			LOGGER.debug("::::::::::투입전:::::::::"+ttrnIvstBfFcstAcvmList.get(i));
		}
		for(int i = 0; i < ttrnIvstAftFcstAcvmList.size(); i++)
		{
			LOGGER.debug("::::::::::투입후:::::::::"+ttrnIvstAftFcstAcvmList.get(i));
		}
		
		
		result.put("dsList3", ttrnIvstBfFcstAcvmList);
		result.put("dsList4", ttrnIvstAftFcstAcvmList);
		return result;

	}
	
	
	/**
	 * 임시열차 시뮬레이션 재실행
	 * @author 김응규
	 * @date 2014. 7. 1. 오후 1:49:00
	 * Method description : 임시열차 투입 후 예상결과 비율을 수정한 후 시뮬레이션을 재실행 한다.
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "unchecked" })
	public Map<String, ?> selectListTtrnSimlRe(Map<String, ?> param) {		

		Map<String, Object> result = new HashMap<String, Object>();

		LOGGER.debug("param ==> "+param);
		
		double ddAbrdPrnb[] = new double[3];
		double ddRt[] = new double[3];
		double ddAmt[] = new double[3];
		double ddAmtPerCnt[] = new double[3];
		
		/* 임시열차 투입 전/후 예상 실적 DATASET 가져오기 */
		LOGGER.debug("::::::::::임시열차 투입 전/후 예상 실적 DATASET 가져오기::::::::::::::");
		ArrayList<Map<String, Object>> mainList3 = (ArrayList<Map<String, Object>>) param.get("dsList3");
		ArrayList<Map<String, Object>> mainList4 = (ArrayList<Map<String, Object>>) param.get("dsList4");
		
		for (int i = 0; i < mainList3.size(); i++)
		{
			LOGGER.debug("mainList ===> index::["+i+"]::>"+mainList3.get(i));
		}
		for (int i = 0; i < mainList4.size(); i++)
		{
			LOGGER.debug("mainList ===> index::["+i+"]::>"+mainList4.get(i));
		}
		
		int nRow;
		for (int i = 0; i < 2; i++)
		{
			if (i == 2)
			{
				nRow = i+1;
			}
			else
			{
				nRow = i;
			}
			ddAbrdPrnb[0] = Double.parseDouble(String.valueOf(mainList3.get(i).get("ABRD_PRNB")));
			mainList4.get(nRow).put("ABRD_PRNB", 
					ddAbrdPrnb[0] * (Double.parseDouble(String.valueOf(mainList4.get(nRow).get("RATE1"))) / 100));
			
			ddRt[0] = Double.parseDouble(String.valueOf(mainList3.get(i).get("ABRD_RT")));
			mainList4.get(nRow).put("ABRD_RT", 
					ddAbrdPrnb[0] * (Double.parseDouble(String.valueOf(mainList4.get(nRow).get("RATE2"))) / 100));
			
			ddAmt[0] = Double.parseDouble(String.valueOf(mainList3.get(i).get("BIZ_RVN_AMT")));
			mainList4.get(nRow).put("BIZ_RVN_AMT", 
					ddAbrdPrnb[0] * (Double.parseDouble(String.valueOf(mainList4.get(nRow).get("RATE3"))) / 100));
			
			ddAmtPerCnt[0] = Double.parseDouble(String.valueOf(mainList3.get(i).get("BIZ_RVN_AMT_PER_BS_SEAT_CNT")));
			mainList4.get(nRow).put("BIZ_RVN_AMT_PER_BS_SEAT_CNT", 
					ddAbrdPrnb[0] * (Double.parseDouble(String.valueOf(mainList4.get(nRow).get("RATE4"))) / 100));
		} //END for
		
		nRow = 1;
		
		ddAbrdPrnb[0] = Double.parseDouble(String.valueOf(mainList3.get(0).get("ABRD_PRNB")))
				+ Double.parseDouble(String.valueOf(mainList3.get(1).get("ABRD_PRNB")));
		
		mainList4.get(nRow).put("ABRD_PRNB", (ddAbrdPrnb[0] / 2) * (Double.parseDouble(String.valueOf(mainList4.get(nRow).get("RATE1"))) / 100));
		
		ddRt[0] = Double.parseDouble(String.valueOf(mainList3.get(0).get("ABRD_RT")))
				+ Double.parseDouble(String.valueOf(mainList3.get(1).get("ABRD_RT")));
		
		mainList4.get(nRow).put("ABRD_RT", (ddRt[0] / 2) * (Double.parseDouble(String.valueOf(mainList4.get(nRow).get("RATE2"))) / 100));
		
		ddAmt[0] = Double.parseDouble(String.valueOf(mainList3.get(0).get("BIZ_RVN_AMT")))
				+ Double.parseDouble(String.valueOf(mainList3.get(1).get("BIZ_RVN_AMT")));
		
		mainList4.get(nRow).put("BIZ_RVN_AMT", (ddAmt[0] / 2) * (Double.parseDouble(String.valueOf(mainList4.get(nRow).get("RATE3"))) / 100));
		
		ddAmtPerCnt[0] = Double.parseDouble(String.valueOf(mainList3.get(0).get("BIZ_RVN_AMT_PER_BS_SEAT_CNT")))
				+ Double.parseDouble(String.valueOf(mainList3.get(1).get("BIZ_RVN_AMT_PER_BS_SEAT_CNT")));
		
		mainList4.get(nRow).put("BIZ_RVN_AMT_PER_BS_SEAT_CNT", (ddAmtPerCnt[0] / 2) * (Double.parseDouble(String.valueOf(mainList4.get(nRow).get("RATE4"))) / 100));
		
		
		
		//메시지 처리
		if(mainList3.isEmpty() && mainList4.isEmpty())
		{
			XframeControllerUtils.setMessage("IZZ000004", result); //해당 조건의 자료가 존재하지 않습니다.
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result); //정상적으로 조회 되었습니다.
		}
		
		
		result.put("dsList4", mainList4);
		return result;

	}
	
	
	/**
	 * 임시열차 조회(임시열차등록 화면에서 사용)
	 * @author 김응규
	 * @date 2014. 7. 8. 오후 5:36:00
	 * Method description : 임시열차의 등록을 위해 기존 등록된 임시열차 목록을 조회한다.
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map<String, ?> selectListTtrnForInsert(Map<String, ?> param) {		

		Map<String, Object> result = new HashMap<String, Object>();

		LOGGER.debug("param ==> "+param);
		// search input column dataset
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");
		//열차운영사업자구분코드 추가
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		inputDataSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		LOGGER.debug("inputDataSet ==>  " + inputDataSet);
		
		//임시열차유형관리 조회
		ArrayList<Map<String, Object>> resultList = (ArrayList) dao.list("com.korail.yz.ys.ed.YSED001QMDAO.selectListTtrnForInsert", inputDataSet);

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
	 * 임시열차 저장 전 열차번호 유효성 check
	 * @author 김응규
	 * @date 2014. 7. 8. 오후 5:36:00
	 * Method description : 임시열차의 등록시 열차번호가 유효한지 점검한다.
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map<String, ?> selectTrnNoCheck(Map<String, ?> param) {		

		Map<String, Object> result = new HashMap<String, Object>();
		LOGGER.debug("param ==> "+param);
		ArrayList<Map<String, Object>> resultList = new ArrayList<Map<String,Object>>();
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		ArrayList<Map<String, String>> checkTrnNoList = (ArrayList<Map<String, String>>) param.get("dsList");
		
		LOGGER.debug("dcntRgulList 사이즈:::::::::::::::"+checkTrnNoList.size());
	    for( int i = 0; i < checkTrnNoList.size() ; i++ )
	    {
	    	Map<String, String> item = checkTrnNoList.get(i);
	    	
	    	LOGGER.debug("dsList["+i+"]번째 ROW =====>"+item);
	    	
	        if(item.get("DMN_PRS_DV_CD").equals("U") || item.get("DMN_PRS_DV_CD").equals("I"))  //요청처리구분코드가 U : update 또는 I : insert 인경우에만
	        {
	        	//열차번호목록조회
	    		resultList = (ArrayList) dao.list("com.korail.yz.yb.co.YBCO001QMDAO.selectListBsTrnCheck", item);
	    		
	    		if(resultList.isEmpty())
	    		{
	    			LOGGER.debug("여기탄거 맞냐");
	    			resultMap.put("INDEX", i+1);
	    			resultMap.put("RESULT", "FAIL");
	    			resultList.add(resultMap);
	    			result.put("dsResult", resultList);
	    			return result;
	    		}
	        }
	    }
	    
		resultMap.put("RESULT", "SUCCESS");
		resultList.add(resultMap);
  		
  		result.put("dsResult", resultList);
		return result;

	}
	/**
	 * 임시열차 등록/수정/삭제
	 * @author 김응규
	 * @date 2014. 7. 7. 오후 5:36:00
	 * Method description : 임시열차를 등록/수정/삭제 처리한다.
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "unchecked" })
	public Map<String, ?> updateTtrn(Map<String, ?> param) {		

		Map<String, Object> result = new HashMap<String, Object>();

		LOGGER.debug("param ==> "+param);
		
		ArrayList<Map<String, String>> ttrnList = (ArrayList<Map<String, String>>) param.get("dsList");
		ArrayList<Map<String, String>> prevList = (ArrayList<Map<String, String>>) param.get("dsPrevList");
		String userId = String.valueOf(param.get("USER_ID"));
		
		int insertCnt = 0;
		int updateCnt = 0;
		int deleteCnt = 0;
		
		LOGGER.debug("ttrnTpList 사이즈:::::::::::::::"+ttrnList.size());
	    for( int i = 0; i < ttrnList.size() ; i++ )
	    {
	    	Map<String, String> item = ttrnList.get(i);
	    	
	    	LOGGER.debug("dsAbvCausList["+i+"]번째 ROW =====>"+item);
	    	item.put("USER_ID", userId);	    	
	    	
	    	
	        if(item.get("DMN_PRS_DV_CD").equals("I"))  /*요청처리구분코드가 I : insert*/
	        {
	        	/* [SQL] 기존 등록된 임시열차내역이 있는지 확인. */
	        	HashMap<String, BigDecimal> ttrnCntMap = (HashMap<String, BigDecimal>) dao.select("com.korail.yz.ys.ed.YSED001QMDAO.selectTtrnCnt", item);
	        	if(ttrnCntMap.get("QRY_CNT").intValue() > 0)
		    	{
	        		throw new CosmosRuntimeException("WZZ000013", null); 
					//이미 등록된 내역이 존재합니다.  입력값을 확인하십시오. 
		    	}
	        	insertCnt += dao.insert("com.korail.yz.ys.ed.YSED001QMDAO.insertTtrn", item);
	        }
	        else if(item.get("DMN_PRS_DV_CD").equals("U"))  /*요청처리구분코드가 U : update*/
	        {
	        	item.putAll(prevList.get(i));
	        	updateCnt += dao.update("com.korail.yz.ys.ed.YSED001QMDAO.updateTtrn", item);	
	        }
	        else if(item.get("DMN_PRS_DV_CD").equals("D"))  /*요청처리구분코드가 D : delete*/
	        {
	        	item.putAll(prevList.get(i));
	        	deleteCnt += dao.delete("com.korail.yz.ys.ed.YSED001QMDAO.deleteTtrn", item);
	        }
	    }
	    LOGGER.debug("입력 ["+insertCnt+"] 건, 수정 ["+updateCnt+"] 건, 삭제 ["+deleteCnt+"] 건 수행하였습니다.");
	    
		//메시지 처리
  		if(insertCnt < 1 && updateCnt < 1 && deleteCnt < 1){
  			XframeControllerUtils.setMessage("WYZ000007", result); //해당 자료를 수정할수 없습니다.	수정자료를 확인하여 주십시오.
  		}
  		else
  		{
  			XframeControllerUtils.setMessage("IZZ000013", result); //정상적으로 저장 되었습니다.
  		}
  		
		return result;

	}
	
	/**
	 * 임시열차 조회(임시열차등록 화면에서 사용)
	 * @author 김응규
	 * @date 2014. 7. 8. 오후 5:36:00
	 * Method description : 임시열차의 등록을 위해 기존 등록된 임시열차 목록을 조회한다.
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map<String, ?> selectListTtrn(Map<String, ?> param) {		

		Map<String, Object> result = new HashMap<String, Object>();

		LOGGER.debug("param ==> "+param);
		// search input column dataset
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");
		//열차운영사업자구분코드 추가
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		inputDataSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		LOGGER.debug("inputDataSet ==>  " + inputDataSet);
		
		//임시열차유형관리 조회
		ArrayList<Map<String, Object>> resultList = (ArrayList) dao.list("com.korail.yz.ys.ed.YSED001QMDAO.selectListTtrn", inputDataSet);

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
}

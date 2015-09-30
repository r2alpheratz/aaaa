/**
 * project : KORAIL_YZ
 * package : com.korail.yz.yb.co
 * date : 2014. 3. 11.오후 3:32:36
 */
package com.korail.yz.yr.ac;

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

/**
 * @author "Changki.woo"
 * @date 2014. 5. 14. 오전 9:30:31
 * Class description : 열차별 할당결과 조회 - YRAC001_S01 
 */
@Service("com.korail.yz.yr.ac.YRAC001SVC")
public class YRAC001SVC {

	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public  final Logger LOGGER = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
	
	/**
	 * @author "김응규"
	 * @date 2014. 5. 14. 오전 9:36:11
	 * Method description : 열차별 할당결과 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map<String, ? > selectListAlcRst(Map<String, ?> param) throws Exception{
		
		LOGGER.debug("param ==> "+param);
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, String>> resultList = new ArrayList<Map<String,String>>();
		Map<String, String> userInfoMap = XframeControllerUtils	.getParamDataSet(param, "GDS_USER_INFO");
		Map<String, String> getParamSet = XframeControllerUtils	.getParamDataSet(param, "dsCond3");
		
		String trnOprBzDvCd = userInfoMap.get("TRN_OPR_BZ_DV_CD");
		String url = "com.korail.yz.yr.ac.YRAC001QMDAO.selectListTrnPrAlcCnqe";
		
		getParamSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		resultList = (ArrayList) dao.list(url, getParamSet); 
		
		result.put("dsList3", resultList);
		
		if(resultList.isEmpty())
		{
			XframeControllerUtils.setMessage("IZZ000004", result); //해당 조건의 자료가 존재하지 않습니다.
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result); //정상적으로 조회되었습니다.
		}
		
		
		return result;
	}
	
	
	
	
	/**
	 * @author "Changki.woo"
	 * @date 2014. 5. 14. 오전 9:36:11
	 * Method description : 열차별 할당결과 조회
	 * @param param
	 * @return
	 */
	/*@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map<String, ? > selectListAlcRst(Map<String, ?> param) throws Exception{
		
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, String>> resultList = new ArrayList<Map<String,String>>();
		
		Map<String, String> getParamSet = XframeControllerUtils	.getParamDataSet(param, "dsCond3");
		
		YZCOMM yzComm = new YZCOMM();
		
		ArrayList<Map<String, Object>> resultBaseList = null;
		ArrayList<Map<String, Object>> resultExtList  = null;		
		ArrayList<Map<String, Object>> bkclList       = null;
		
		String urlBaseAlc = "com.korail.yz.yr.ac.YRAC001QMDAO.selectListAlcRstBaseQry"; //부킹클래스 F1의 정보들. TB_YYDK328
		String urlExtAlc  = "com.korail.yz.yr.ac.YRAC001QMDAO.selectListAlcRstExtQry";//부킹클래스 F1이외의 정보들. TB_YYDD513\
		
		String urlBkclList = "com.korail.yz.co.YZCO001QMDAO.selectListBkclInf";
		
		resultBaseList = (ArrayList) dao.list(urlBaseAlc, getParamSet);    //F1의 좌석 할당결과를 가져온다.
		resultExtList  = (ArrayList) dao.list(urlExtAlc, getParamSet);     //F1이외의 좌석 할당결과를 가져온다.
		
		
		// 1. 확장열차그룹잔여석 내역(TB_YYDK328)
		//    YMS할당잔여석 내역(TB_YYDD513)
		//    을 조회해서 같은 기준으로 풀어낸다.
		Map<String, ArrayList<YYDK328>> nRowMap = new HashMap<String, ArrayList<YYDK328>>();
		
		for(int i =0; i< resultBaseList.size(); i++)
		{
			YYDK328 nRow = new YYDK328();
			Map<String, Object> bsListRow = resultBaseList.get(i);
			
			//pk값 세팅
			nRow.setRunDt(bsListRow.get("RUN_DT").toString());
			nRow.setRunDtTxt(bsListRow.get("RUN_DT_TXT").toString());
			nRow.setTrnNo(bsListRow.get("TRN_NO").toString());
			nRow.setRestSeatMgId(bsListRow.get("REST_SEAT_MG_ID").toString());
			nRow.setSegGpNo(Integer.valueOf(bsListRow.get("SEG_GP_NO").toString()));
			nRow.setPsrmClCd(bsListRow.get("PSRM_CL_CD").toString());
			nRow.setPsrmCl(bsListRow.get("PSRM_CL").toString());
			nRow.setSeatAttCd(bsListRow.get("SEAT_ATT_CD").toString());
			nRow.setBkclCd(bsListRow.get("BKCL_CD").toString());
			nRow.setBkclOrdr(Integer.valueOf(bsListRow.get("BKCL_ORDR").toString()));
			nRow.setDealDt(bsListRow.get("RUN_DT").toString());
			nRow.setRunDvCd(bsListRow.get("RUN_DV_CD").toString());
			nRow.setShtmExcsRsvAllwFlg(bsListRow.get("SHTM_EXCS_RSV_ALLW_FLG").toString());
			nRow.setBkcls(bsListRow.get("BKCLS").toString());
			
			//value 세팅
			
			nRow.setFirstAlcNum(Integer.valueOf(bsListRow.get("FIRST_ALC_NUM").toString()));
			nRow.setGpFstAlcSeatNum(Integer.valueOf(bsListRow.get("GP_FST_ALC_SEAT_NUM").toString()));
			nRow.setGpActMrkSeatNum(Integer.valueOf(bsListRow.get("GP_ABRD_PRNB").toString()));
			nRow.setGpMrkSeatNum(Integer.valueOf(bsListRow.get("GP_MRK_SEAT_NUM").toString()));

			String mKey = nRow.getRestSeatMgId() +"|#|"+ nRow.getRunDt() +"|#|"+ nRow.getTrnNo();
			
			if(!nRowMap.containsKey(mKey))
			{
				nRowMap.put(mKey, new ArrayList<YYDK328>());
			}
			
			//nTable.add(nRow);
			List arrList = nRowMap.get(mKey);
			arrList.add(nRow);
		}
		
		
		for(int j =0; j< resultExtList.size(); j++)
		{
		
			Map<String,Object> extListRow = resultExtList.get(j);
			
			
			String runDt = extListRow.get("RUN_DT").toString();
			String runDtTxt = extListRow.get("RUN_DT_TXT").toString();
			String trnNo = extListRow.get("TRN_NO").toString();
			String restSeatMgId = extListRow.get("REST_SEAT_MG_ID").toString();
			String psrmClCd = extListRow.get("PSRM_CL_CD").toString();
			String psrmCl = extListRow.get("PSRM_CL").toString();
			String seatAttCd = extListRow.get("SEAT_ATT_CD").toString();
			String bkclCd = extListRow.get("BKCL_CD").toString();
			String bkcls  = extListRow.get("BKCLS").toString();
			String dealDt = extListRow.get("DEAL_DT").toString();
			String runDvCd = extListRow.get("RUN_DV_CD").toString();
			int   bkclOrdr = Integer.valueOf(extListRow.get("BKCL_ORDR").toString());
			String shtmExcsRsvAllwFlg = extListRow.get("SHTM_EXCS_RSV_ALLW_FLG").toString();

			List<Integer> firstAlcNumContArr = yzComm.fnYzcommStr64ToInt( extListRow.get("FIRST_ALC_NUM_CONT").toString() ); // 최초할당수
			List<Integer> fstAlcSeatNumContArr = yzComm.fnYzcommStr64ToInt( extListRow.get("FST_ALC_SEAT_NUM_CONT").toString() ); // 최초할당수
			List<Integer> mrkSeatNumContArr    = yzComm.fnYzcommStr64ToInt( extListRow.get("MRK_SEAT_NUM_CONT").toString() );     // 풀구간
			List<Integer> actMrkSeatNumContArr = yzComm.fnYzcommStr64ToInt( extListRow.get("ACT_MRK_SEAT_NUM_CONT").toString() ); // 실제판매수
			
			for(int k=0; k< fstAlcSeatNumContArr.size(); k ++)
			{
				YYDK328 nnRow = new YYDK328();
				
				//pk값 세팅
				nnRow.setRunDt(runDt);
				nnRow.setRunDtTxt(runDtTxt);
				nnRow.setTrnNo(trnNo);
				nnRow.setDealDt(dealDt);
				nnRow.setRestSeatMgId(restSeatMgId);
				nnRow.setBkclCd(bkclCd);
				nnRow.setBkcls(bkcls);
				nnRow.setPsrmClCd(psrmClCd);
				nnRow.setPsrmCl(psrmCl);
				nnRow.setSeatAttCd(seatAttCd);
				nnRow.setBkclOrdr(bkclOrdr);
				nnRow.setRunDvCd(runDvCd);
				nnRow.setShtmExcsRsvAllwFlg(shtmExcsRsvAllwFlg);
				
				nnRow.setSegGpNo( k + 1 );  //구역구간은 /부터 시작한다. k와 구역구간은 일치한다.
				nnRow.setFirstAlcNum( firstAlcNumContArr.get(k) );
				nnRow.setGpFstAlcSeatNum( fstAlcSeatNumContArr.get(k) );
				nnRow.setGpMrkSeatNum( mrkSeatNumContArr.get(k) );
				nnRow.setGpActMrkSeatNum( actMrkSeatNumContArr.get(k) );
				
				String mmKey = nnRow.getRestSeatMgId() +"|#|"+ nnRow.getRunDt() +"|#|"+ nnRow.getTrnNo();
				
				if(!nRowMap.containsKey(mmKey))
				{
					nRowMap.put(mmKey, new ArrayList<YYDK328>());
				}
				
				List arrList = nRowMap.get(mmKey);
				arrList.add(nnRow);
				
				//nTable.add(nnRow);
			}
			
		}
		
		//넣은애들을 정렬한다. -- 정렬을 맨 내중에 하는걸로 바꿨다..
		
			
		// 풀기 끝;
		
		// 2. 연산부 
		//그룹별 할당수(계산), 부킹클래스할당수(계산), 그룹판매허용수(계산), 부킹클래스판매허용수, 미할당수	
		//할당잔여석, 기본좌석수
		
		int alcSum    = 0;
		int fstAlcSum = 0;
		int noAlcSum    = 0; //미할당수 전역변수
		int fstNoAlcSum = 0; //최초 미할당수 전역변수
		
		//부킹클래스 정보를 담는 MAP
		Map<String, ArrayList<Integer>> bkclInfo = new HashMap<String, ArrayList<Integer>>();
		
		// 2.1
		//F1의 그룹 할당수, F1이외의 그룹 할당수
		//F1의 BC 할당수,   F1이외의 BC 할당수.
		
		Object[] keyArr =  nRowMap.keySet().toArray();
		Arrays.sort(keyArr);
		
		for(int i=0; i < keyArr.length; i++)
		{
			String mKey = keyArr[i].toString();
			
			ArrayList<YYDK328> rowList = nRowMap.get(mKey);
			
			// 2.1 그룹할당수 계산
			// 2.1.1 그룹별할당수 합
			Map<Integer, Integer> sumGpMrkSeatnum = new HashMap<Integer, Integer>();
			for(YYDK328 nRow : rowList)
			{
				int segGpNo = nRow.getSegGpNo();
				if(!sumGpMrkSeatnum.containsKey(segGpNo))
				{
					sumGpMrkSeatnum.put(segGpNo, 0);
				}
				sumGpMrkSeatnum.put(segGpNo, sumGpMrkSeatnum.get(segGpNo) + nRow.getGpMrkSeatNum());
				
			}
			
			
			for(YYDK328 nRow : rowList)
			{
				String bkclCd = nRow.getBkclCd();

				//F1 (정상) 일때 그룹별 할당수 계산
				//부킹클래스 고민...(DB에서 가져와서 ??)
				if("F1".equals(bkclCd))
				{
					int segGpNo = nRow.getSegGpNo();
					int gpAlcNum = nRow.getGpFstAlcSeatNum() - sumGpMrkSeatnum.get(segGpNo);  //해당그룹 F1 최초할당수 - SUM(해당그룹 모든 BC의 풀구간판매수) 
					
					nRow.setGpAlcNum(gpAlcNum);
					
					alcSum    += gpAlcNum; 					//미할당 계산용. 풀구간할당 SUM
					fstAlcSum += nRow.getGpFstAlcSeatNum(); //최초 할당수 보호용 풀구간??(최초할당수) //쫌이상함.. .체크
				}
				//F1 아닐때의 BC 할당수 계산
				else
				{
					int gpAlcNum= nRow.getGpFstAlcSeatNum() - nRow.getGpActMrkSeatNum();  //해당그룹 BC의 최초할당수 - 해당그룹 BC의 실제 판매수 
					nRow.setGpAlcNum(gpAlcNum);
				}
			}
			
//		    ---- 2. 그룹판매허용수, BC판매허용수, 할당잔여석 계산 ----
//		    ------- 2.1 미할당수 계산 ---------------------------------------------
//		     미할당수 = 미발매수 - SUM(모든그룹 F1의 그룹할당수)                   
//		     최초 미할당수 = 기본좌석수 - SUM(모든그룹 F1의 그룹할당수)            
//		    -----------------------------------------------------------------------
			
			int intNSaleSeatCnt = rowList.get(0).getNotySaleSeatNum();//미발매좌석수
			int intBsSeatCnt    = rowList.get(0).getBsSeatNum();
			
			noAlcSum = intNSaleSeatCnt - alcSum ;
			fstNoAlcSum = intBsSeatCnt - fstAlcSum ;
			
		    if ( noAlcSum < 0 )
		    {
		    	noAlcSum = 0;
		    }    	
		    
		    if ( fstNoAlcSum < 0 )
		    {
		    	fstNoAlcSum = 0;
		    }   
			
		    
//		    ------ 2.2 그룹판매허용수/BC판매허용수 계산 --------------------------
//		     그룹판매허용수 =  SUM(자신을 포함한 하위그룹 F1의 그룹할당수) +      
//		                           미할당수                                       
//		     BC판매허용수 = 해당그룹BC의 할당수 +                                 
//		                          (해당그룹의 네스팅관계인 BC의 할당수)           
//		    ----------------------------------------------------------------------	
//		    
//		    ------- 2.3 (최종)할당잔여석 계산 ------------------------------------
//		     Full 구간(F1) 일 경우 = MIN(미발매수, 그룹판매허용수)                
//		     하위 BC일 경우 = 미발매수와 비교하지 않고 BC판매허용수 사용          
//		    ----------------------------------------------------------------------	
//			
//		    -- BC판매허용수 계산시의 BC간 네스팅을 위한 BC Mask(구성정보) 준비 --- 
		    
		    
		    Map<String, String> bkclCond = new HashMap<String, String>();
		    
		    //조회조건으로 RUN_DT만 사용한다. IO부하를 줄일라고 // <--- ???? io 부하 줄이는 것 보다 쿼리 결과값 줄이는게 다 낫지않나
		    bkclCond.put("RUN_DT", rowList.get(0).getRunDt());
		    
		    //부킹클래스 비트패턴 조회 및 맵구성
			for(YYDK328 nRow : rowList)
			{
				//rowKey
				String bkclMKey = nRow.getRunDt() + "|#|" + nRow.getTrnNo() + "|#|" + nRow.getPsrmClCd() + "|#|" + nRow.getBkclCd();
				
				if(!bkclInfo.containsKey(bkclMKey))
				{
					bkclCond.put("TRN_NO", nRow.getTrnNo());
				    bkclCond.put("PSRM_CL_CD", nRow.getPsrmClCd());
				    bkclCond.put("BKCL_CD", nRow.getBkclCd());
					bkclList = (ArrayList) dao.list(urlBkclList, bkclCond);    //F1의 좌석 할당결과를 가져온다.
				    
				    if(bkclList.size() < 1)
				    {
				    	return null; ///에러처리
				    }
				    
					
				    for (int j = 0 ; j < bkclList.size(); j++ )
				    {
				   	   	*//*** BC 구성정보 길이 ***//*
				    	String strBcInfo = bkclList.get(j).get("BKCL_CONS_BIT_PTRN_CONT").toString();
				    	String bkclMmKey = bkclList.get(j).get("RUN_DT") + "|#|" + bkclList.get(j).get("TRN_NO") + "|#|" + bkclList.get(j).get("PSRM_CL_CD") + "|#|" + bkclList.get(j).get("BKCL_CD");
				    	ArrayList<Integer> bitArr = new ArrayList<Integer>();
				    	
				    			
				    	for( int k = 0 ; k <strBcInfo.length(); k+=2)
				    	{
				    		int bit = Integer.valueOf( strBcInfo.substring(k, k+2).toString() );
				    		bitArr.add(bit);
				    	}
				    	
				    	bkclInfo.put(bkclMmKey, bitArr);
				    }
				}
			}
			int iGrupAlcSum = 0;
			int iGrupFstAlcSum = 0;
			
			Map<Integer,Integer> gpAlcSum    = new HashMap<Integer, Integer>();
			Map<Integer,Integer> gpFstAlcSum = new HashMap<Integer, Integer>();
			
			//F1의 그룹판매허용수, 그룹최초할당수의 합
			for(YYDK328 nRow : rowList)
			{
				String bkclCd  = nRow.getBkclCd();
				int segGpNo = nRow.getSegGpNo();
				
				if("F1".equals(bkclCd))
				{
					
					iGrupAlcSum += nRow.getGpAlcNum();
					iGrupFstAlcSum += nRow.getGpFstAlcSeatNum();
					
					gpAlcSum.put(segGpNo, iGrupAlcSum);
					gpFstAlcSum.put(segGpNo, iGrupFstAlcSum);
				}
				
			}
			
			int posF1   = 0;
			for(int j =0 ;j < rowList.size() ; j++)
			{
				YYDK328 nRow = rowList.get(j);
				String bkclCd  = nRow.getBkclCd();
				int segGpNo = nRow.getSegGpNo();
				
				
				if("F1".equals(bkclCd))
				{
					posF1 = j;
					//그룹판매허용수 계산
					nRow.setGpMrkAllwNum(gpAlcSum.get(segGpNo) + noAlcSum);
					//최초할당수 백업
					nRow.setGpFstAlcSeatNumBak(gpFstAlcSum.get(segGpNo) + fstNoAlcSum);
					
					if(nRow.getGpMrkAllwNum() > intNSaleSeatCnt)
					{
						nRow.setRestSeatNum( intNSaleSeatCnt );
					}
					else
					{
						nRow.setRestSeatNum( nRow.getGpMrkAllwNum() );
					}
					
					if(nRow.getRestSeatNum() > nRow.getGpFstAlcSeatNumBak())
					{
						nRow.setRestSeatNum(nRow.getGpFstAlcSeatNumBak());
					}
				}
				
				else
//					 판매허용수, 할당잔여석 
				{
					String runDt = nRow.getRunDt();
					String trnNo = nRow.getTrnNo();
					String psrmClCd = nRow.getPsrmClCd();
					
					String bkclMkey = runDt + "|#|" + trnNo + "|#|" + psrmClCd + "|#|" + bkclCd;
					ArrayList<Integer> bkclBitList = bkclInfo.get(bkclMkey);
					
					int iBcAlcSum =0;
					
					for(int k = 0; k < bkclBitList.size(); k++)
					{
						int iMask = bkclBitList.get(k) - 1;
						
						if(iMask >= 0)
						{
							iBcAlcSum += rowList.get(iMask + posF1).getGpAlcNum(); 
						}
					}
					//판매허용수
					nRow.setGpMrkAllwNum(iBcAlcSum);
					//(최종)할당잔여석
					nRow.setRestSeatNum(iBcAlcSum);					
					
				}
			}
		}
		
		
		Object keySets[] =  nRowMap.keySet().toArray();
		
		Arrays.sort(keySets);
		
		for(int i = 0; i< keySets.length; i++)
		{
			ArrayList<YYDK328> rowList = nRowMap.get(keySets[i].toString());
			
			for(YYDK328 nRow : rowList)
			{
				//검색조건 필터링
				//객실등급 조회조건에 맞게 필터링
				String bkclCdCond  = getParamSet.get("BKCL_CD").toString();
				String segGpNoCond = getParamSet.get("SEG_GP_NO").toString();
				if(!nRow.getBkclCd().equals( bkclCdCond ) && !"".equals( bkclCdCond ))
				{
					continue;
				}
				
				if(!"".equals(segGpNoCond))
				{
					if(nRow.getSegGpNo() != Integer.valueOf(segGpNoCond))
					{
						continue;
					}
				}
				Map<String, String> nRowToMap = new HashMap<String, String>();
				nRowToMap.put("RUN_DT", nRow.getRunDt());
				nRowToMap.put("RUN_DT_TXT", nRow.getRunDtTxt());
				nRowToMap.put("TRN_NO", nRow.getTrnNo());
				nRowToMap.put("REST_SEAT_MG_ID", nRow.getRestSeatMgId());
				nRowToMap.put("SHTM_EXCS_RSV_ALLW_FLG", nRow.getShtmExcsRsvAllwFlg());
				nRowToMap.put("SEG_GP_NO", String.valueOf(nRow.getSegGpNo()));
				nRowToMap.put("RUN_DV_CD", nRow.getRunDvCd());
				nRowToMap.put("BKCL_CD", nRow.getBkclCd());
				nRowToMap.put("BKCLS", nRow.getBkcls());
				nRowToMap.put("DEAL_DT", nRow.getDealDt());
				nRowToMap.put("PSRM_CL_CD", nRow.getPsrmClCd());
				nRowToMap.put("PSRM_CL", nRow.getPsrmCl());
				nRowToMap.put("SEAT_ATT_CD", nRow.getSeatAttCd());
				nRowToMap.put("GP_FST_ALC_SEAT_NUM", String.valueOf( nRow.getGpFstAlcSeatNum()) );
				nRowToMap.put("FIRST_ALC_NUM", String.valueOf( nRow.getFirstAlcNum()));
				nRowToMap.put("GP_MRK_SEAT_NUM", String.valueOf(nRow.getGpMrkSeatNum()));
				nRowToMap.put("GP_ACT_MRK_SEAT_NUM", String.valueOf(nRow.getGpMrkSeatNum()));
				nRowToMap.put("GP_ALC_NUM", String.valueOf(nRow.getGpAlcNum()));
				nRowToMap.put("GP_MRK_ALLW_NUM", String.valueOf(nRow.getGpMrkAllwNum()));
				nRowToMap.put("BKCL_MRK_ALLW_NUM", String.valueOf(nRow.getBkclMrkAllwNum()));
				nRowToMap.put("NOTY_ALC_NUM", String.valueOf(nRow.getNotyAlcNum()));
				nRowToMap.put("REST_SEAT_NUM", String.valueOf(nRow.getRestSeatNum()));
				nRowToMap.put("BS_SEAT_NUM", String.valueOf(nRow.getBsSeatNum()));
				nRowToMap.put("NOTY_SALE_SEAT_NUM", String.valueOf(nRow.getNotySaleSeatNum()));
				nRowToMap.put("BKCL_ORDR", String.valueOf(nRow.getBkclOrdr()));
				resultList.add(nRowToMap);
			}
		}
		for(int i = 0; i < resultList.size(); i++)
		{
			LOGGER.debug(resultList.get(i));
		}
		
		///////////////////////////////////////////////////////////////////////////
		LOGGER.debug("정렬시작!!!");
		ComparatorChain chain = new ComparatorChain();
		chain.addComparator(comparatorRunDt); 		//운행일자순 정렬
		chain.addComparator(comparatorTrnNo); 		//열차번호순 정렬
		chain.addComparator(comparatorSegGpNo); 	//구역구간그룹번호순 정렬
		chain.addComparator(comparatorPsrmClCd); 	//객실등급코드순 정렬
		chain.addComparator(comparatorBkclOrdr); 	//부킹클래스순서별 정렬
		
		Collections.sort(resultList, chain);
		//정렬 종료
		result.put("dsList3", resultList);
		LOGGER.debug("dsList3 출력!!!");
		for(int i = 0; i < resultList.size(); i++)
		{
			LOGGER.debug(resultList.get(i));
		}
		
		if(resultList.size() < 1)
		{
			XframeControllerUtils.setMessage("IZZ000004", result); //해당 조건의 자료가 존재하지 않습니다.
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result);
		}
		 
		
		return result;
	}*/
	
	/**
	 * 운행일자별로 정렬한다.
	 * */
	/*public static Comparator<Map<String,String>> comparatorRunDt = new Comparator<Map<String,String>>() {

		@Override
		public int compare(Map<String, String> std, Map<String, String> comp) {
			return std.get("RUN_DT").compareTo(comp.get("RUN_DT"));
		}
		
	};*/
	
	/**
	 * 열차번호별로 정렬한다.
	 * */
	/*public static Comparator<Map<String,String>> comparatorTrnNo = new Comparator<Map<String,String>>() {

		@Override
		public int compare(Map<String,String> std, Map<String,String> comp) {
			return std.get("TRN_NO").compareTo(comp.get("TRN_NO"));
		}
		
	};*/
	
	/**
	 * 구역구간그룹번호별로 정렬한다.
	 * */
	/*public static Comparator<Map<String,String>> comparatorSegGpNo = new Comparator<Map<String,String>>() {

		@Override
		public int compare(Map<String,String> std, Map<String,String> comp) {
			int stdSegGpNo = Integer.parseInt(std.get("SEG_GP_NO"));
			int compSegGpNo = Integer.parseInt(comp.get("SEG_GP_NO"));
			if(stdSegGpNo == compSegGpNo)
			{
				return 0;
			}else if(stdSegGpNo > compSegGpNo)
			{
				return 1;
			}else{
				return -1;
			}
				
		}
		
	};*/
	
	/**
	 * 객실등급별로 정렬한다.
	 * */
	/*public static Comparator<Map<String,String>> comparatorPsrmClCd = new Comparator<Map<String,String>>() {

		@Override
		public int compare(Map<String,String> std, Map<String,String> comp) {
			return std.get("PSRM_CL_CD").compareTo(comp.get("PSRM_CL_CD"));
		}
		
	};*/
	
	/**
	 * 할인등급(order순)별로 정렬한다.
	 * */
	/*public static Comparator<Map<String,String>> comparatorBkclOrdr = new Comparator<Map<String,String>>() {

		@Override
		public int compare(Map<String,String> std, Map<String,String> comp) {
			int stdBkclOrdr = Integer.parseInt(std.get("BKCL_ORDR"));
			int compBkclOrdr = Integer.parseInt(comp.get("BKCL_ORDR"));
			if(stdBkclOrdr == compBkclOrdr)
			{
				return 0;
			}else if(stdBkclOrdr > compBkclOrdr)
			{
				return 1;
			}else{
				return -1;
			}
				
		}
		
	};*/
}

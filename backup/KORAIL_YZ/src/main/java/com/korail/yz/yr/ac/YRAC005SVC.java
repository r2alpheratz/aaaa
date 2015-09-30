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
 * Class description : 운행일자별 할당결과 조회 YRCA002_S01 
 * 
 */
@Service("com.korail.yz.yr.ac.YRAC005SVC")
public class YRAC005SVC {

	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public  final Logger LOGGER = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
	
	/**
	 * @author "김응규"
	 * @date 2015. 1. 13. 오후 5:36:11
	 * Method description : 운행일자별 할당결과 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map<String, ? > selectListRunDtPrAlcRst(Map<String, ?> param) throws Exception{
		
		LOGGER.debug("param ==> "+param);
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, String>> resultList = new ArrayList<Map<String,String>>();
		Map<String, String> userInfoMap = XframeControllerUtils	.getParamDataSet(param, "GDS_USER_INFO");
		Map<String, String> getParamSet = XframeControllerUtils	.getParamDataSet(param, "dsCond2");
		
		String trnOprBzDvCd = userInfoMap.get("TRN_OPR_BZ_DV_CD");
		String url = "com.korail.yz.yr.ac.YRAC005QMDAO.selectListRunDtPrAlcCnqe";
		
		getParamSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		resultList = (ArrayList) dao.list(url, getParamSet); 
		
		result.put("dsList2", resultList);
		
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
	 * @date 2014. 5. 28. 오후 5:53:05
	 * Method description : 운행일자별 할당결과 조회 
	 * @param param
	 * @return
	 */
	/*@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map<String, ? > selectListRunDtPrAlcRst(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String, String>> resultList = new ArrayList<Map<String,String>>();
		
		Map<String, String> getParamSet = XframeControllerUtils	.getParamDataSet(param, "dsCond2");
		
		YZCOMM yzComm = new YZCOMM();
		
		ArrayList<Map<String, Object>> resultBaseList = null;
		ArrayList<Map<String, Object>> resultExtList  = null;		
		ArrayList<Map<String, Object>> bkclList       = null;
		
		
		
		String urlBaseAlc = "com.korail.yz.yr.ac.YRAC005QMDAO.selectListRunDtPrAlcRstBaseQry"; //부킹클래스 F1의 정보들. TB_YYDK328
		String urlExtAlc  = "com.korail.yz.yr.ac.YRAC005QMDAO.selectListRunDtPrAlcRstExtQry";//부킹클래스 F1이외의 정보들. TB_YYDD513\
		
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
			
			Object[] keySet  = bsListRow.keySet().toArray();
			
			 2014.07.09 EMPTY DATA일 경우 BIZEXCEPTION 발생로직 추가. 우창기
			for(int j=0; j < keySet.length; j++)
			{
				if(bsListRow.get(String.valueOf(keySet[j])) == null)
				{
					throw new CosmosRuntimeException("DB데이터를 점검해야합니다. 관리자에게 문의바랍니다.(TB_YYDK328)", null);
				}
			}			
			
			//pk값 세팅
			nRow.setRunDt(String.valueOf(bsListRow.get("RUN_DT")));
			nRow.setRunDtTxt(String.valueOf(bsListRow.get("RUN_DT_TXT")));
			nRow.setTrnNo(String.valueOf(bsListRow.get("TRN_NO")));
			nRow.setSegGpNo(Integer.valueOf(String.valueOf(bsListRow.get("SEG_GP_NO"))));
			nRow.setPsrmClCd(String.valueOf(bsListRow.get("PSRM_CL_CD")));
			nRow.setPsrmCl(String.valueOf(bsListRow.get("PSRM_CL")));
			nRow.setBkclCd(String.valueOf(bsListRow.get("BKCL_CD")));
			nRow.setBkcls(String.valueOf(bsListRow.get("BKCLS")));
			nRow.setBkclOrdr(Integer.valueOf(String.valueOf(bsListRow.get("BKCL_ORDR"))));
			
			//value 세팅
			
			nRow.setFirstAlcNum(Integer.valueOf(String.valueOf(bsListRow.get("FIRST_ALC_NUM"))));
			nRow.setGpFstAlcSeatNum(Integer.valueOf(String.valueOf(bsListRow.get("GP_FST_ALC_SEAT_NUM"))));
			nRow.setGpActMrkSeatNum(Integer.valueOf(String.valueOf(bsListRow.get("GP_ABRD_PRNB"))));
			nRow.setGpMrkSeatNum(Integer.valueOf(String.valueOf(bsListRow.get("GP_MRK_SEAT_NUM"))));

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
		
			Object[] keySet  = extListRow.keySet().toArray();
			
			 2014.07.09 EMPTY DATA일 경우 BIZEXCEPTION 발생로직 추가. 우창기
			for(int k=0; k < keySet.length; k++)
			{
				if(extListRow.get(String.valueOf(keySet[k])) == null)
				{
					throw new CosmosRuntimeException("DB데이터를 점검해야합니다. 관리자에게 문의바랍니다.(TB_YYDK328)", null);
				}
			}
			
			String runDt = String.valueOf(extListRow.get("RUN_DT"));
			String runDtTxt = String.valueOf(extListRow.get("RUN_DT_TXT"));
			String trnNo = String.valueOf(extListRow.get("TRN_NO"));
			String psrmClCd = String.valueOf(extListRow.get("PSRM_CL_CD"));
			String psrmCl = String.valueOf(extListRow.get("PSRM_CL"));
			String bkclCd = String.valueOf(extListRow.get("BKCL_CD"));
			String bkcls  = String.valueOf(extListRow.get("BKCLS"));
			int   bkclOrdr = Integer.valueOf(String.valueOf(extListRow.get("BKCL_ORDR")));

			List<Integer> firstAlcNumContArr = yzComm.fnYzcommStr64ToInt( String.valueOf(extListRow.get("FIRST_ALC_NUM_CONT")) ); // 최초할당수
			List<Integer> fstAlcSeatNumContArr = yzComm.fnYzcommStr64ToInt( String.valueOf(extListRow.get("FST_ALC_SEAT_NUM_CONT")) ); // 최초할당수
			List<Integer> mrkSeatNumContArr    = yzComm.fnYzcommStr64ToInt( String.valueOf(extListRow.get("MRK_SEAT_NUM_CONT")) );     // 풀구간
			List<Integer> actMrkSeatNumContArr = yzComm.fnYzcommStr64ToInt( String.valueOf(extListRow.get("ACT_MRK_SEAT_NUM_CONT")) ); // 실제판매수
			
			for(int k=0; k< fstAlcSeatNumContArr.size(); k ++)
			{
				YYDK328 nnRow = new YYDK328();
				
				//pk값 세팅
				nnRow.setRunDt(runDt);
				nnRow.setRunDtTxt(runDtTxt);
				nnRow.setTrnNo(trnNo);
				nnRow.setBkclCd(bkclCd);
				nnRow.setBkcls(bkcls);
				nnRow.setPsrmClCd(psrmClCd);
				nnRow.setPsrmCl(psrmCl);
				nnRow.setBkclOrdr(bkclOrdr);
				
				nnRow.setSegGpNo( k + 1 );  구역구간은 1부터 시작한다. k와 구역구간은 일치한다.
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
		
		
		Object keySet[] = nRowMap.keySet().toArray();
		
		for(int i = 0; i< keySet.length; i++)
		{
			ArrayList<YYDK328> rowList = nRowMap.get(String.valueOf(keySet[i]));
		    
			
			Collections.sort(rowList, new Comparator<YYDK328>() 
			{
				
				public int compare(YYDK328 std, YYDK328 comp){
				
					int stdSegGpNo = std.getSegGpNo();
					int compSegGpNo = comp.getSegGpNo();
					
					if(stdSegGpNo < compSegGpNo)
					{
						return -1;
					}
					else if(stdSegGpNo == compSegGpNo)
					{
						int stdBkclOrdr = std.getBkclOrdr();
						int compBkclOrdr = comp.getBkclOrdr();
						if( stdBkclOrdr < compBkclOrdr)
						{
							return -1;
						}else
						{
							return 1;
						}
						
					}else
					{
						return 1;
					}
				}

			});
		}
		
		
		
		//넣은애들을 정렬한다.
		
			
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
			String mKey = String.valueOf(keyArr[i]);
			
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
					int gpAlcNum = nRow.getGpFstAlcSeatNum() - sumGpMrkSeatnum.get(segGpNo);  해당그룹 F1 최초할당수 - SUM(해당그룹 모든 BC의 풀구간판매수) 
					
					nRow.setGpAlcNum(gpAlcNum);
					
					alcSum    += gpAlcNum; 					//미할당 계산용. 풀구간할당 SUM
					fstAlcSum += nRow.getGpFstAlcSeatNum(); //최초 할당수 보호용 풀구간??(최초할당수) //쫌이상함.. .체크
				}
				//F1 아닐때의 BC 할당수 계산
				else
				{
					int gpAlcNum= nRow.getGpFstAlcSeatNum() - nRow.getGpActMrkSeatNum();  해당그룹 BC의 최초할당수 - 해당그룹 BC의 실제 판매수 
					nRow.setGpAlcNum(gpAlcNum);
				}
			}
			
		    ---- 2. 그룹판매허용수, BC판매허용수, 할당잔여석 계산 ----
		    ------- 2.1 미할당수 계산 ---------------------------------------------
		     미할당수 = 미발매수 - SUM(모든그룹 F1의 그룹할당수)                   
		     최초 미할당수 = 기본좌석수 - SUM(모든그룹 F1의 그룹할당수)            
		    -----------------------------------------------------------------------
			
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
			
		    
		    ------ 2.2 그룹판매허용수/BC판매허용수 계산 --------------------------
		     그룹판매허용수 =  SUM(자신을 포함한 하위그룹 F1의 그룹할당수) +      
		                           미할당수                                       
		     BC판매허용수 = 해당그룹BC의 할당수 +                                 
		                          (해당그룹의 네스팅관계인 BC의 할당수)           
		    ----------------------------------------------------------------------	
		    
		    ------- 2.3 (최종)할당잔여석 계산 ------------------------------------
		     Full 구간(F1) 일 경우 = MIN(미발매수, 그룹판매허용수)                
		     하위 BC일 경우 = 미발매수와 비교하지 않고 BC판매허용수 사용          
		    ----------------------------------------------------------------------	
			
		    -- BC판매허용수 계산시의 BC간 네스팅을 위한 BC Mask(구성정보) 준비 --- 
		    
		    
		    Map<String, String> bkclCond = new HashMap<String, String>();
		    
		    //조회조건으로 RUN_DT만 사용한다. IO부하를 줄일라고
		    bkclCond.put("RUN_DT", rowList.get(0).getRunDt());
		    //bkclCond.put("TRN_NO", rowList.get(0).getTrnNo());
		    //bkclCond.put("PSRM_CL_CD", rowList.get(0).getPsrmClCd());
		    
		    //부킹클래스 비트패턴 조회 및 맵구성
			for(YYDK328 nRow : rowList)
			{
				//rowKey
				String bkclMKey = nRow.getRunDt() + "|#|" + nRow.getTrnNo() + "|#|" + nRow.getPsrmClCd() + "|#|" + nRow.getBkclCd();
				
				if(!bkclInfo.containsKey(bkclMKey))
				{
					bkclList = (ArrayList) dao.list(urlBkclList, bkclCond);    //F1의 좌석 할당결과를 가져온다.
				    
				    if(bkclList.size() < 1)
				    {
				    	return null; ///에러처리
				    }
				    
					
				    for (int j = 0 ; j < bkclList.size(); j++ )
				    {
				   	   	*//*** BC 구성정보 길이 ***//*
				    	String strBcInfo = String.valueOf(bkclList.get(j).get("BKCL_CONS_BIT_PTRN_CONT"));
				    	String bkclMmKey = bkclList.get(j).get("RUN_DT") + "|#|" + bkclList.get(j).get("TRN_NO") + "|#|" + bkclList.get(j).get("PSRM_CL_CD") + "|#|" + bkclList.get(j).get("BKCL_CD");
				    	ArrayList<Integer> bitArr = new ArrayList<Integer>();
				    	
				    			
				    	for( int k = 0 ; k <strBcInfo.length(); k+=2)
				    	{
				    		int bit = Integer.valueOf( String.valueOf(strBcInfo.substring(k, k+2)) );
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
			ArrayList<YYDK328> rowList = nRowMap.get(String.valueOf(keySets[i]));
			
			for(YYDK328 nRow : rowList)
			{
				//검색조건 필터링
				//객실등급 조회조건에 맞게 필터링
				String bkclCdCond  = String.valueOf(getParamSet.get("BKCL_CD"));
				String segGpNoCond = String.valueOf(getParamSet.get("SEG_GP_NO"));
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
				nRowToMap.put("GP_ACT_MRK_SEAT_NUM", String.valueOf(nRow.getGpActMrkSeatNum()));
				nRowToMap.put("GP_ALC_NUM", String.valueOf(nRow.getGpAlcNum()));
				nRowToMap.put("GP_MRK_ALLW_NUM", String.valueOf(nRow.getGpMrkAllwNum()));
				nRowToMap.put("BKCL_MRK_ALLW_NUM", String.valueOf(nRow.getBkclMrkAllwNum()));
				nRowToMap.put("NOTY_ALC_NUM", String.valueOf(nRow.getNotyAlcNum()));
				nRowToMap.put("REST_SEAT_NUM", String.valueOf(nRow.getRestSeatNum()));
				nRowToMap.put("BS_SEAT_NUM", String.valueOf(nRow.getBsSeatNum()));
				nRowToMap.put("NOTY_SALE_SEAT_NUM", String.valueOf(nRow.getNotySaleSeatNum()));
				
				resultList.add(nRowToMap);
			}
		}
		
		result.put("dsList2", resultList);
		
		if(resultList.isEmpty())
		{
			XframeControllerUtils.setMessage("IZZ000004", result); //해당 조건의 자료가 존재하지 않습니다.
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result);
		}
		
		
		return result;
	}*/
}

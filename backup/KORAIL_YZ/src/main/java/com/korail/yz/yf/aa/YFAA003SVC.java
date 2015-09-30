package com.korail.yz.yf.aa;

import java.math.BigDecimal;

import java.text.SimpleDateFormat;
import java.util.*;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Service;

import com.korail.tz.sa.ISA0001SVC;
import com.korail.tz.sa.XframeControllerUtils;


import cosmos.comm.dao.CommDAO;
import cosmos.comm.exception.CosmosRuntimeException;

/**
 * @author 김응규
 * @date 2014. 3. 4. 오후 3:02:30
 * Class description :  이상원인 및 이상열차 관리 SVC
 */
@Service("com.korail.yz.yf.aa.YFAA003SVC")
public class YFAA003SVC {

	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public  static final Logger LOGGER = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
	
	/**
	 * 이상원인목록 조회
	 * @author 김응규
	 * @date 2014. 3. 4. 오후 3:17:38
	 * Method description : 이상원인목록을 조회한다. 
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map<String, ?> selectListAbvCaus(Map<String, ?> param) {		

		Map<String, Object> result = new HashMap<String, Object>();

		LOGGER.debug("param ==> "+param);
		// search input column dataset
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");	
		LOGGER.debug("inputDataSet ==>  " + inputDataSet);

		// search input column data
		LOGGER.debug("inputData ==>  " + inputDataSet.get("RUN_TRM_ST_DT"));
		LOGGER.debug("inputData ==>  " + inputDataSet.get("RUN_TRM_CLS_DT"));
		LOGGER.debug("inputData ==>  " + inputDataSet.get("TRN_NO"));
				
		//spring MVC Locale�뺤씤
		/*
		Locale locale1 = Locale.ENGLISH;
		Locale locale2 = Locale.KOREA;
		System.out.println(messageSource.getMessage("errors.sql.notexists", new Object[]{"TEST"}, locale1));
		System.out.println(messageSource.getMessage("errors.sql.notexists", new Object[]{"TEST"}, locale2));
		*/
		
		ArrayList<Map<String, Object>> resultList = (ArrayList) dao.list("com.korail.yz.yf.aa.YFAA003QMDAO.selectListAbvCaus", inputDataSet);

		//return Query Result
		
/*		if(resultList.size() == Integer.parseInt(inputDataSet.get("PG_PR_CNT")))
		{
			inputDataSet.put("QRY_NUM_NEXT", String.valueOf(resultList.get(resultList.size()-1).get("QRY_NUM")));
		}else
		{
			inputDataSet.put("QRY_NUM_NEXT", "0");
		}*/
		
		for(int i=0;i<resultList.size();i++)
		{
			LOGGER.debug(resultList.get(i).toString());
		}
		
		ArrayList<Map<String, String>> condList = new ArrayList<Map<String, String>>();
		condList.add(inputDataSet);
		result.put("dsCond", condList);
		
		result.put("dsAbvCausList", resultList);
		//메시지 처리
		if(resultList.isEmpty()){
			XframeControllerUtils.setMessage("IZZ000004", result); //해당 조건의 자료가 존재하지 않습니다.
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result); //정상적으로 조회 되었습니다.
		}
		return result;

	}
	
	/**
	 * 이상열차목록 조회
	 * @author 김응규
	 * @date 2014. 3. 4. 오후 5:17:38
	 * Method description : 이상열차 목록을 조회한다. 
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map<String, ?> selectListAbvTrn(Map<String, ?> param) {		

		Map<String, Object> result = new HashMap<String, Object>();

		LOGGER.debug("param ==> "+param);
		// search input column dataset
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");	
		LOGGER.debug("inputDataSet ==>  " + inputDataSet);

		// search input column data
		LOGGER.debug("inputData ==>  " + inputDataSet.get("RUN_TRM_ST_DT")); //운행기간 시작일자
		LOGGER.debug("inputData ==>  " + inputDataSet.get("RUN_TRM_CLS_DT"));//운행기간 종료일자
		LOGGER.debug("inputData ==>  " + inputDataSet.get("TRN_NO"));
		LOGGER.debug("inputData ==>  " + inputDataSet.get("ABV_TRN_SRT_CD")); //이상원인코드
				
		//spring MVC Locale�뺤씤
		/*
		Locale locale1 = Locale.ENGLISH;
		Locale locale2 = Locale.KOREA;
		System.out.println(messageSource.getMessage("errors.sql.notexists", new Object[]{"TEST"}, locale1));
		System.out.println(messageSource.getMessage("errors.sql.notexists", new Object[]{"TEST"}, locale2));
		*/
		
		ArrayList<Map<String, Object>> resultList = (ArrayList) dao.list("com.korail.yz.yf.aa.YFAA003QMDAO.selectListAbvTrn", inputDataSet);
		
		//return Query Result
		
/*		if(resultList.size() == Integer.parseInt(inputDataSet.get("PG_PR_CNT")))
		{
			inputDataSet.put("QRY_NUM_NEXT", String.valueOf(resultList.get(resultList.size()-1).get("QRY_NUM")));
		}else
		{
			inputDataSet.put("QRY_NUM_NEXT", "0");
		}*/
		
		for(int i=0;i<resultList.size();i++)
		{
			LOGGER.debug(resultList.get(i).toString());
		}
		
		ArrayList<Map<String, String>> condList = new ArrayList<Map<String, String>>();
		condList.add(inputDataSet);
		result.put("dsCond", condList);
		
		result.put("dsAbvTrnList", resultList);
		//메시지 처리
		if(resultList.isEmpty()){
			XframeControllerUtils.setMessage("IZZ000004", result); //해당 조건의 자료가 존재하지 않습니다.
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result); //정상적으로 조회 되었습니다.
		}
		return result;

	}
	
	/**
	 * @author 김응규
	 * @date 2014. 3. 6. 오전 9:17:38
	 * Method description : 등록/수정/삭제 대상 이상원인 목록을 입력받아 수정처리한다.
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> updateAbvCausList(Map<String, ?> param) {		

		Map<String, Object> result = new HashMap<String, Object>();

		LOGGER.debug("param ==> "+param);

		ArrayList<Map<String, String>> abvCausList = (ArrayList<Map<String, String>>) param.get("dsAbvCausList");
		String userId = String.valueOf(param.get("USER_ID"));
		
		int insertCnt = 0;
		int updateCnt = 0;
		int deleteCnt = 0;
	    LOGGER.debug("abvCausList 사이즈:::::::::::::::"+abvCausList.size());
	    for( int i = 0; i < abvCausList.size() ; i++ )
	    {
	    	Map<String, String> item = abvCausList.get(i);
	    	LOGGER.debug("dsAbvCausList["+i+"]번째 ROW =====>"+item);
	    	item.put("USER_ID", userId);	    	
	    	
	    	
	        if(item.get("DMN_PRS_DV_CD").equals("I"))  /*요청처리구분코드가 I : insert*/
	        {
	        	/* [SQL] 기존 등록된 이상원인코드가 있는지 확인. */
	        	HashMap<String, BigDecimal> abvCausCntMap = (HashMap<String, BigDecimal>) dao.select("com.korail.yz.yf.aa.YFAA003QMDAO.selectAbvCausCnt", item);

		    	if(abvCausCntMap.get("QRY_CNT").intValue() > 0)
		    	{
		    		throw new CosmosRuntimeException("EYF000210", null); 
					//이미 등록된 이상원인코드입니다. / 입력한 코드로 등록된 이상원인이 있는지 확인한다.
		    	}
		    	
		    	insertCnt += dao.insert("com.korail.yz.yf.aa.YFAA003QMDAO.insertAbvCaus", item);
		    	
	        }else if(item.get("DMN_PRS_DV_CD").equals("U")) /*요청처리구분코드가 U : update*/
	        {
		    	updateCnt += dao.update("com.korail.yz.yf.aa.YFAA003QMDAO.updateAbvCaus", item);
		    	
	        }else if(item.get("DMN_PRS_DV_CD").equals("D")) /*요청처리구분코드가 D : delete*/
	        {
	        	/* [SQL] 선택한 이상원인코드에 해당하는 이상열차내역이 있는지 확인. */
	        	HashMap<String, BigDecimal> abvTrnCntMap = (HashMap<String, BigDecimal>) dao.select("com.korail.yz.yf.aa.YFAA003QMDAO.selectAbvTrnCnt", item);
	        	LOGGER.debug("이상열차 카운트:::::::::: " + abvTrnCntMap.get("QRY_CNT").intValue());
	        	
	        	if(abvTrnCntMap.get("QRY_CNT").intValue() > 0)
		    	{
	        		throw new CosmosRuntimeException("EYF000211", null); 
					//해당 이상원인 항목에 대한 상세 정보가 있습니다. / 이상열차 정보를 확인한다.
		    	}
	        	
	        	deleteCnt += dao.delete("com.korail.yz.yf.aa.YFAA003QMDAO.deleteAbvCaus", item);
		    	
	        }
	    }
	    LOGGER.debug("등록 ["+insertCnt+"수정 ["+updateCnt+"]건, 삭제 ["+deleteCnt+"]건 수행되었습니다.");
	    
	    //메시지 처리
  		if(insertCnt > 0 || updateCnt > 0 || deleteCnt > 0){
  			XframeControllerUtils.setMessage("IZZ000013", result); //정상적으로 저장 되었습니다.
  		}
  		else{
  			throw new CosmosRuntimeException("EZZ000018", null);  //저장 중 오류가 발생하였습니다.
  		}
		return result;

	}	
	
	
	/**
	 * @author 김응규
	 * @date 2014. 3. 13. 오후 5:17:38
	 * Method description : 차트조회를 위해 이상열차와 비교대상열차의 승차인원수를 조회한다.
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map<String, ?> selectAbvTrnCompQry(Map<String, ?> param) {		

		Map<String, Object> result = new HashMap<String, Object>();

		LOGGER.debug("param ==> "+param);
		// search input column dataset
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");	
		LOGGER.debug("inputDataSet ==>  " + inputDataSet);

		// search input column data
		LOGGER.debug("inputData ==>  " + inputDataSet.get("RUN_DT")); //운행일자
		LOGGER.debug("inputData ==>  " + inputDataSet.get("TRN_NO"));//열차번호
		LOGGER.debug("inputData ==>  " + inputDataSet.get("RUN_TRM_ST_DT"));//운행기간시작일자
		LOGGER.debug("inputData ==>  " + inputDataSet.get("RUN_TRM_CLS_DT"));//운행기간종료일자
		LOGGER.debug("inputData ==>  " + inputDataSet.get("COMP_TGT_TRN_NO"));//비교대상열차번호
		
		ArrayList<Map<String, Object>> abvTrnAbrdPrnbList = (ArrayList) dao.list("com.korail.yz.yf.aa.YFAA003QMDAO.selectAbvTrnAbrdPrnb", inputDataSet);
		LOGGER.debug("abvTrnAbrdPrnList ::::::>>>"+abvTrnAbrdPrnbList.toString());
		ArrayList<Map<String, Object>> compTrnAbrdPrnbList = (ArrayList) dao.list("com.korail.yz.yf.aa.YFAA003QMDAO.selectCompTrnAbrdPrnb", inputDataSet);
		LOGGER.debug("compTrnAbrdPrnbList ::::::>>>"+compTrnAbrdPrnbList.toString());
		ArrayList<Map<String, Object>> compTrnAbrdPrnbPrDtList = (ArrayList) dao.list("com.korail.yz.yf.aa.YFAA003QMDAO.selectCompTrnAbrdPrnbPrDt", inputDataSet);
		LOGGER.debug("compTrnAbrdPrnbPrDtList ::::::>>>"+compTrnAbrdPrnbPrDtList.toString());
		
		ArrayList<Map<String, String>> condList = new ArrayList<Map<String, String>>();
		condList.add(inputDataSet);
		result.put("dsCond", condList);
		
		
		result.put("dsAbvTrnAbrdPrnb", abvTrnAbrdPrnbList);
		result.put("dsCompTrnAbrdPrnb", compTrnAbrdPrnbList);
		result.put("dsCompTrnAbrdPrnbPrDt", compTrnAbrdPrnbPrDtList);
		//메시지 처리
		if(abvTrnAbrdPrnbList.isEmpty() && compTrnAbrdPrnbList.isEmpty() && compTrnAbrdPrnbPrDtList.isEmpty()){
			XframeControllerUtils.setMessage("IZZ000004", result); //해당 조건의 자료가 존재하지 않습니다.
		}
		else if(abvTrnAbrdPrnbList.isEmpty() || abvTrnAbrdPrnbList.get(0).get("ABRD_PRNB").equals("0"))
		{
			XframeControllerUtils.setMessage("IYF000001", result); //이상열차의 승차인원 정보가 존재하지 않습니다.
		}
		else if(compTrnAbrdPrnbList.isEmpty() || compTrnAbrdPrnbList.get(0).get("ABRD_PRNB").equals("0"))
		{
			XframeControllerUtils.setMessage("IYF000002", result); //비교대상열차의 승차인원 정보가 존재하지 않습니다.
		}
		else if(compTrnAbrdPrnbPrDtList.isEmpty() )
		{
			XframeControllerUtils.setMessage("IYF000002", result); //비교대상열차의 승차인원 정보가 존재하지 않습니다.
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result); //정상적으로 조회 되었습니다.
		}
		return result;
	}
	
	/**
	 * 정상열차목록 조회
	 * @author 김응규
	 * @date 2014. 3. 18. 오후 8:39:10
	 * Method description : 이상열차로 등록이 가능한 정상열차를 조회한다. 
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map<String, ?> selectListNmlTrn(Map<String, ?> param) {		

		Map<String, Object> result = new HashMap<String, Object>();

		LOGGER.debug("param ==> "+param);
		// search input column dataset
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");	
		LOGGER.debug("inputDataSet ==>  " + inputDataSet);

		// search input column data
		LOGGER.debug("inputData ==>  " + inputDataSet.get("RUN_TRM_ST_DT")); //운행기간 시작일자
		LOGGER.debug("inputData ==>  " + inputDataSet.get("RUN_TRM_CLS_DT"));//운행기간 종료일자
		LOGGER.debug("inputData ==>  " + inputDataSet.get("TRN_NO"));
		LOGGER.debug("inputData ==>  " + inputDataSet.get("ABV_TRN_SRT_CD")); //이상원인코드
		
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		if("".equals(trnOprBzDvCd) || trnOprBzDvCd == null){
			trnOprBzDvCd = "000";
		}
		inputDataSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		
		ArrayList<Map<String, Object>> resultList = (ArrayList) dao.list("com.korail.yz.yf.aa.YFAA003QMDAO.selectListNmlTrn", inputDataSet);

		ArrayList<Map<String, String>> condList = new ArrayList<Map<String, String>>();
		condList.add(inputDataSet);
		result.put("dsCond", condList);
		
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
	 * @date 2014. 3. 19. 오후 3:17:38
	 * Method description : 이상열차를 등록한다.
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "unchecked" })
	public Map<String, ?> insertAbvTrn(Map<String, ?> param) {		

		Map<String, Object> result = new HashMap<String, Object>();
		ArrayList<Map<String, String>> messageList = new ArrayList<Map<String, String>>();
		HashMap<String, String> msgMap = new HashMap<String, String>();

		LOGGER.debug("param ==> "+param);

		ArrayList<Map<String, String>> abvTrnList = (ArrayList<Map<String, String>>) param.get("dsList");
		ArrayList<Map<String, String>> abvTrnCondList = (ArrayList<Map<String, String>>) param.get("dsCond");
		SimpleDateFormat sdf, sdf2;
		sdf = new java.text.SimpleDateFormat("yyyyMMdd");
		sdf2 = new java.text.SimpleDateFormat("yyyy-MM-dd");
		String userId = String.valueOf(param.get("USER_ID"));
		
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		if("".equals(trnOprBzDvCd) || trnOprBzDvCd == null){
			trnOprBzDvCd = "000";
		}
		
		String sRunTrmStDt = abvTrnCondList.get(0).get("RUN_TRM_ST_DT");
		
		int runYear = Integer.parseInt(sRunTrmStDt.substring(0, 4));
		int runMonth = Integer.parseInt(sRunTrmStDt.substring(4, 6));
		int runDate = Integer.parseInt(sRunTrmStDt.substring(6, 8));
		int nRunTrmDno = Integer.parseInt(abvTrnCondList.get(0).get("RUN_TRM_DNO"));
		LOGGER.debug("운행년도:::::"+runYear);
		LOGGER.debug("운행월:::::"+runMonth);
		LOGGER.debug("운행일:::::"+runDate);
		LOGGER.debug("운행일간격:::::"+nRunTrmDno);
	    
		
		int   i, j;
		
		String ecptTrn = "";
	    Calendar runTrmStDt = Calendar.getInstance(); //운행기간시작일자
	    
	    runTrmStDt.set(runYear, runMonth-1, runDate);
	    
	    
	    LOGGER.debug("abvTrnList 사이즈:::::::::::::::"+abvTrnList.size());
	    //체크한 열차번호 수만큼 insert
	    for( i = 0; i < abvTrnList.size() ; i++ )
	    {
	    	Map<String, String> item = abvTrnList.get(i);
	    	item.put("USER_ID", userId);
	    	item.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
	    	item.put("ABV_TRN_SRT_CD",  abvTrnCondList.get(0).get("ABV_TRN_SRT_CD"));
	    	item.put("ABV_OCUR_CAUS_CONT",  abvTrnCondList.get(0).get("ABV_OCUR_CAUS_CONT"));
	    	
	    	//선택한 운행기간만큼 테이블에 insert
	    	for( j=0; j < nRunTrmDno+1; j++)
	    	{
	    		
	    		String sRunDt = sdf.format(runTrmStDt.getTime());
	    		String sRunDtExpr = sdf2.format(runTrmStDt.getTime());
	    		item.put("RUN_DT", sRunDt);
	    		LOGGER.debug("체크한 abvTrnList["+i+"]번째 열차번호["+item.get("TRN_NO")+"] 를 날짜["+item.get("RUN_DT")+"] 에 이상열차로 등록!!!!!");
	    		// [SQL] 일일열차 정보가 있는지 유무 파악
	    		//일일열차정보에 등록되어있지 않은 경우는 삽입하지 않는다.
	    		//이는 해당 열차가 그 운행일자에 서비스 하지 않을 수 있기 때문 
	    		HashMap<String, BigDecimal> dlyTrnInfoCntMap = (HashMap<String, BigDecimal>) dao.select("com.korail.yz.yf.aa.YFAA003QMDAO.selectDlyTrnInfoCnt", item);
	    		LOGGER.debug("일일열차정보 카운트:::::::::: " + dlyTrnInfoCntMap.get("QRY_CNT").intValue());
	        	
	        	if(dlyTrnInfoCntMap.get("QRY_CNT").intValue() < 1)
		    	{
	        		ecptTrn = item.get("TRN_NO")+"("+sRunDtExpr+")";
	        		LOGGER.debug("다음 메시지 입력::::::::"+ecptTrn);
	        		msgMap.put("MSG_CONT",ecptTrn);
			    	messageList.add(msgMap);
			    	
	        		
	        		runTrmStDt.add(Calendar.DATE, 1);
	        		continue;
		    	}
	    		
	    		//TODO : 기존 등록된 이상열차가 있는지 확인(이 필요한지 여부도 조사) 
        		Map<String, BigDecimal> abvTrnExistMap = (Map<String, BigDecimal>) dao.select("com.korail.yz.yf.aa.YFAA003QMDAO.selectAbvTrnExist", item);
	        	
	        	if(abvTrnExistMap.get("QRY_CNT").intValue() > 0)
	        	{
	        		throw new CosmosRuntimeException("WZZ000013", null); 
					//이미 등록된 내역이 존재합니다.  입력값을 확인하십시오. 
	        	}
	    		dao.insert("com.korail.yz.yf.aa.YFAA003QMDAO.insertAbvTrn", item);
	    		runTrmStDt.add(Calendar.DATE, 1);
	    		
	    	}
	    	//운행기간 시작일자로 초기화
	    	runTrmStDt.add(Calendar.DATE, -j);
	    }

		result.put("dsMessage", messageList);

		return result;

	}	
	
	/**
	 * @author 김응규
	 * @date 2014. 3. 20. 오후 5:04:38
	 * Method description : 이상열차를 삭제한다.
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "unused" })
	public Map<String, ?> deleteAbvTrn(Map<String, ?> param) {		

		Map<String, Object> result = new HashMap<String, Object>();
		ArrayList<Map<String, String>> messageList = new ArrayList<Map<String, String>>();
		HashMap<String, String> msgMap = new HashMap<String, String>();

		LOGGER.debug("param ==> "+param);

		ArrayList<Map<String, String>> abvTrnList = (ArrayList<Map<String, String>>) param.get("dsAbvTrnList");
		int i;
		LOGGER.debug("abvTrnList 사이즈:::::::::::::::"+abvTrnList.size());
	    //선택한 이상열차를 삭제
	    for( i = 0; i < abvTrnList.size() ; i++ )
	    {
	    	Map<String, String> item = abvTrnList.get(i);
	    	
	    	dao.delete("com.korail.yz.yf.aa.YFAA003QMDAO.deleteAbvTrn", item);
	    	
	    }

		result.put("dsMessage", messageList);

		return result;

	}	
	
	/**
	 * @author 김응규
	 * @date 2014. 3. 20. 오후 8:32:38
	 * Method description : 이상열차 정보를 수정한다.
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> updateAbvTrnList(Map<String, ?> param) {		

		Map<String, Object> result = new HashMap<String, Object>();
		//HashMap<String, String> msgMap = new HashMap<String, String>();

		LOGGER.debug("param ==> "+param);

		ArrayList<Map<String, String>> abvTrnList = (ArrayList<Map<String, String>>) param.get("dsAbvTrnList");
		ArrayList<Map<String, String>> abvTrnPrevList = (ArrayList<Map<String, String>>) param.get("dsAbvTrnPrevList");
		String userId = String.valueOf(param.get("USER_ID"));
		
		int updateCnt = 0;
		int deleteCnt = 0;
	    LOGGER.debug("abvTrnList 사이즈:::::::::::::::"+abvTrnList.size());
	    for(int  i = 0; i < abvTrnList.size() ; i++ )
	    {
	    	Map<String, String> item = abvTrnList.get(i);
	    	item.putAll(abvTrnPrevList.get(i));
	    	LOGGER.debug("dsAbvTrnList["+i+"]번째 ROW =====>"+item);
	    	item.put("USER_ID", userId);	    	
	    	
	    	
	        if(item.get("DMN_PRS_DV_CD").equals("U")) /*요청처리구분코드가 U : Update*/
	        {
	        	if(!item.get("RUN_DT").equals(item.get("PREV_RUN_DT")) || !item.get("TRN_NO").equals(item.get("PREV_TRN_NO")))
	        	{
	        		Map<String, BigDecimal> abvTrnExistMap = (Map<String, BigDecimal>) dao.select("com.korail.yz.yf.aa.YFAA003QMDAO.selectAbvTrnExist", item);
		        	
		        	if(abvTrnExistMap.get("QRY_CNT").intValue() > 0)
		        	{
		        		throw new CosmosRuntimeException("WZZ000013", null); 
						//이미 등록된 내역이 존재합니다.  입력값을 확인하십시오. 
		        	}	
	        	}
		    	updateCnt += dao.update("com.korail.yz.yf.aa.YFAA003QMDAO.updateAbvTrn", item);
	        }
	        
	        if(item.get("DMN_PRS_DV_CD").equals("D")) /*요청처리구분코드가 D : Delete*/
	        {
	        	deleteCnt += dao.delete("com.korail.yz.yf.aa.YFAA003QMDAO.deleteAbvTrn", item);
	        }
	    }
	    
	    LOGGER.debug("수정 ["+updateCnt+"]건, 삭제 ["+deleteCnt+"]건 수행되었습니다.");

		return result;

	}	
}
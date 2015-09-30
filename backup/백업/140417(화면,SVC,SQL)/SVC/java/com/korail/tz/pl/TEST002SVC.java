/**
 * project : KORAIL_YZ
 * package : com.korail.tz.pl
 * date : 2014. 3. 5.오전 6:09:06
 */

package com.korail.tz.pl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
//import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Service;

import com.korail.tz.sa.ISA0001SVC;
import com.korail.tz.sa.XframeControllerUtils;

import cosmos.comm.dao.CommDAO;

/**
 * @author 민지홍
 * @date 2014. 3. 5. 오전 6:09:06
 * Class description : 코드 목록 및 코드 상세 목록을 조회하는 서비스.
 */
@Service("com.korail.tz.pl.TEST002SVC")
public class TEST002SVC {

	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public  final Logger logger = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);

	/**
	 * @author 민지홍
	 * @date 2014. 3. 5. 오전 6:17:38
	 * Method description : (페이징) 프로그램 목록을 조회한다.
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectProgramList(Map<String, ?> param) {		

		Map<String, Object> result = new HashMap<String, Object>();

		logger.debug("param ==> "+param);
		// search input column dataset
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");	
		logger.debug("inputDataSet ==>  " + inputDataSet);

		// search input column data
		logger.debug("inputData ==>  " + inputDataSet.get("QRY_NUM_NEXT"));		
		logger.debug("inputData ==>  " + inputDataSet.get("PG_PR_CNT"));
				
		//spring MVC Locale�뺤씤
		/*
		Locale locale1 = Locale.ENGLISH;
		Locale locale2 = Locale.KOREA;
		System.out.println(messageSource.getMessage("errors.sql.notexists", new Object[]{"TEST"}, locale1));
		System.out.println(messageSource.getMessage("errors.sql.notexists", new Object[]{"TEST"}, locale2));
		*/
		
		ArrayList<Map<String, Object>> resultList = (ArrayList<Map<String, Object>>) dao.list("com.korail.tz.pl.YZPL002QMDAO.selectProgramList", inputDataSet);

		
		//return Query Result
		
		if(resultList.size() == Integer.parseInt(inputDataSet.get("PG_PR_CNT")))
		{
			inputDataSet.put("QRY_NUM_NEXT", String.valueOf(resultList.get(resultList.size()-1).get("QRY_NUM")));
		}else
		{
			inputDataSet.put("QRY_NUM_NEXT", "0");
		}
		
		ArrayList<Map<String, String>> condList = new ArrayList<Map<String, String>>();
		condList.add(inputDataSet);
		
		result.put("dsCond", condList);
		result.put("dsProgramList", resultList);

		return result;

	}	
	
	/**
	 * @author 민지홍
	 * @date 2014. 3. 5. 오전 6:17:38
	 * Method description : 등록/수정/삭제 대상 프로그램의 목록을 입력받아 수정처리한다.
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> updateProgramList(Map<String, ?> param) {		

		Map<String, Object> result = new HashMap<String, Object>();
		ArrayList<Map<String, String>> messageList = new ArrayList<Map<String, String>>();
		HashMap<String, String> msgMap = new HashMap<String, String>();

		logger.debug("param ==> "+param);

		ArrayList<Map<String, String>> programList = (ArrayList<Map<String, String>>) param.get("dsProgramList");
		
		String userId = "DEV";

	    /*  BIZ Logic ... (Biz Logic은 개발로직으로 변경되어야 한다.) */
	    int   i;

	    for( i = 0; i < programList.size() ; i++ )
	    {
	    	Map<String, String> item = programList.get(i);
	    	logger.debug(item);
	    	item.put("USER_ID", userId);	    	
	    	
	        if(item.get("DMN_PRS_DV_CD").equals("I"))
	        {
	        	/* [SQL] 기존 등록된 프로그램ID가 있는지 확인. */
	        	HashMap<String, BigDecimal> programCountMap = (HashMap<String, BigDecimal>) dao.select("com.korail.tz.pl.YZPL002QMDAO.selectProgramCount", item);

		    	if(programCountMap.get("QRY_CNT").intValue() > 0)
		    	{
		    		msgMap.put("MSG_CONT", "이미 등록된 프로그램ID입니다.");
		    		messageList.add(msgMap);

		    		break;
		    	}
		    	
		    	dao.insert("com.korail.tz.pl.PL002QMDAO.insertProgram", item);
		    	
		    	/* 프로그램 이력 처리 */
		    	updateProgramHistory(item);
		    	
	        }else if(item.get("DMN_PRS_DV_CD").equals("U"))
	        {
		    	dao.update("com.korail.tz.pl.PL002QMDAO.updateProgram", item);
		    	
		    	/* 프로그램 이력 처리 */
		    	updateProgramHistory(item);
		    	
	        }else if(item.get("DMN_PRS_DV_CD").equals("D"))
	        {
		    	dao.update("com.korail.tz.pl.PL002QMDAO.deleteProgram", item);
		    	
		    	/* 프로그램 이력 처리 */
		    	updateProgramHistory(item);
	        }
	    }

		result.put("dsMessage", messageList);

		return result;

	}	

	/**
	 * @author 민지홍
	 * @date 2014. 3. 5. 오전 6:17:38
	 * Method description : 프로그램에 대한 변경 발생 시 이력테이블에 이력을 삽입한다.
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	private void updateProgramHistory(Map<String, String> item) 
	{
		/* [SQL] 시작일자가 오늘인 이력이 존재하는지 확인 */
    	HashMap<String, BigDecimal> programHistoryCountMap = (HashMap<String, BigDecimal>) dao.select("com.korail.tz.pl.YZPL002QMDAO.selectProgramHistoryCount", item);

    	if(programHistoryCountMap.get("QRY_CNT").intValue() > 0)
    	{
    		/* 오늘 이력이 존재하면 update. */
        	dao.update("com.korail.tz.pl.PL002QMDAO.updateProgramHistory", item);
    	}
        /* 오늘 이력이 없으면 insert. */
        else
        {
        	dao.update("com.korail.tz.pl.PL002QMDAO.updateProgramHistoryDate", item);
        	dao.insert("com.korail.tz.pl.PL002QMDAO.insertProgramHistory", item);
        }
    	
		
	}
}

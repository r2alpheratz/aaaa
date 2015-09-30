/**
 * project : KORAIL_YZ
 * package : com.korail.tz.pl
 * date : 2014. 3. 5.오전 6:09:06
 */

package com.korail.tz.pl;

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

/**
 * @author 민지홍
 * @date 2014. 3. 5. 오전 6:09:06
 * Class description : 페이징처리 샘플 서비스
 */
@Service("com.korail.tz.pl.TEST004SVC")
public class TEST004SVC {
	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public  final Logger logger = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);

	/**
	 * @author 민지홍
	 * @date 2014. 3. 5. 오전 6:22:45
	 * Method description : page 방식의 페이징처리 예제이다
	 *  ※ 가급적 page방식은 사용하지 않도록 합니다. (부분범위처리방식이 불리)
     *  - page 방식은 화면의 페이징 처리 방식이 page navigation 방식일 때 사용합니다.
     *  - 현재 페이지번호와 페이지별 건수 정보를 화면으로부터 받아와 페이지 구성계산하는 로직이
     *    추가됩니다.
     *  - 총 건수가 변경될 수 있으므로 count(*) 조회는 페이지를 누를때마다 수행합니다.
     *  - 쿼리에서 rownum 보다는 오라클 분석함수인 ROW_NUMBER() over (order by ) 문을 이용하는 것이
     *    성능 상 유리합니다. 상세내역은 예제쿼리를 참조해주시기 바랍니다.
     *    ROW_NUMBER() 함수를 이용하여 UNIQUE INDEX에 따른 정렬처리를 하는 경우
     *    WINDOW NOSORT STOPKEY방식으로 부분조회되므로 빠른 성능을 유지할 수 있습니다.
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectPageList(Map<String, ?> param) {		

		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		
		/* 입력 오브젝트 */
		Map<String, String> inputDataSet = XframeControllerUtils.getParamDataSet(param, "dsCondition");	
		Map<String, String> inputPageSet = XframeControllerUtils.getParamDataSet(param, "dsPage");	
		logger.debug("inputDataSet ==>  " + inputDataSet);
		logger.debug("inputPageSet ==>  " + inputPageSet);
		
		/* 출력 오브젝트 */
		ArrayList<Map<String, String>> msgList = new ArrayList<Map<String, String>>();
		HashMap<String, String> msgItem = new HashMap<String, String>();
		
	    /* 입력데이터 설정 */
        inputDataSet.put("NOW_PG_NO", inputPageSet.get("NOW_PG_NO"));
        inputDataSet.put("PG_PR_CNT", inputPageSet.get("PG_PR_CNT"));		        
		
        /* 총 건수 조회 */
		ArrayList<Map<String, BigDecimal>> countList = (ArrayList<Map<String, BigDecimal>>) dao.list("com.korail.tz.pl.PL004QMDAO.selectPageListCount", inputDataSet);
		
		int recordCnt = countList.get(0).get("QRY_CNT").intValue();
		
		if(recordCnt == 0)
		{
			msgItem.put("MSG_CONT", "조회할 자료가 없습니다.");
			msgList.add(msgItem);

			result.put("dsMessage", msgList);
			
			return result;
		}
		
	    /* 페이지 카운트 설정 : 총건수와 페이지당건수로 페이지갯수를 계산 */

	    /* 페이지당건수 설정. */
	    int pagePerCnt = Integer.parseInt(inputPageSet.get("PG_PR_CNT"));

	    /* 총건수 설정. */
	    inputPageSet.put("QRY_CNT", String.valueOf(recordCnt));

	    /* 페이지갯수 설정. */
	    inputPageSet.put("PG_CNT", String.valueOf((recordCnt%pagePerCnt == 0) ? recordCnt/pagePerCnt : recordCnt/pagePerCnt+1));
	    
	    /* 메인 쿼리 */
		ArrayList<Map<String, Object>> resultList = (ArrayList<Map<String, Object>>) dao.list("com.korail.tz.pl.PL004QMDAO.selectPageList", inputDataSet);
	    
	    		
		for(int i=0;i<resultList.size();i++)
		{
			logger.debug(resultList.get(i).toString());
		}
				
		
		msgItem.put("MSG_CONT", "정상적으로 조회되었습니다.");
		msgList.add(msgItem);
		result.put("dsMessage", msgList);

		ArrayList<Map<String, String>> pgList = new ArrayList<Map<String, String>>();
		pgList.add(inputPageSet);
		result.put("dsPage", pgList);
		
		result.put("dsRoadList", resultList);

		return result;

	}

	/**
	 * @author 민지홍
	 * @date 2014. 3. 5. 오전 6:22:45
	 * Method description : next key 방식의 페이징처리 예제이다
	 *  - next key 방식은 화면의 페이징 처리 방식이 스크롤 또는 자동스크롤 방식일 때 사용합니다.	 
	 *  - 주로 쿼리실행계획이 고정되어 있고 인덱스를 사용할 수 있는 경우에 사용됩니다.	 
	 *  - next row 방식은 조회조건이 다양하여 인덱스 고정이 어렵거나, unique key를 구성하는 키의 갯수가
	 *    많은 경우에 rownum을 사용합니다.	 
	 *  - 자동 스크롤 처리하는 경우에는 fllw_qry_flg 변수에 "Y" 값을 담아 총건수 조회 로직을 skip하도록
	 *    처리합니다.
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectPageNextKeyList(Map<String, ?> param) {		

		int recordCnt = 0;
		
		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		
		/* 입력 오브젝트 */
		Map<String, String> inputDataSet = XframeControllerUtils.getParamDataSet(param, "dsCondition");	
		Map<String, String> inputPageSet = XframeControllerUtils.getParamDataSet(param, "dsPageNextKey");	
		logger.debug("inputDataSet ==>  " + inputDataSet);
		logger.debug("inputPageSet ==>  " + inputPageSet);
		
		/* 출력 오브젝트 */
		ArrayList<Map<String, String>> msgList = new ArrayList<Map<String, String>>();
		HashMap<String, String> msgItem = new HashMap<String, String>();
		
	    /* 입력데이터 설정 */
        inputDataSet.put("NEXT_KEY",  inputPageSet.get("NEXT_KEY"));	//다음 조회키
        inputDataSet.put("PG_PR_CNT", inputPageSet.get("PG_PR_CNT"));	//페이지당 건수
		
        if(!"Y".equals(inputPageSet.get("FLLW_QRY_FLG")))
        {
            /* 총 건수 조회 */
    		ArrayList<Map<String, BigDecimal>> countList = (ArrayList<Map<String, BigDecimal>>) dao.list("com.korail.tz.pl.PL004QMDAO.selectPageListCount", inputDataSet);
    		recordCnt = countList.get(0).get("QRY_CNT").intValue();
    		
    		if(recordCnt == 0)
    		{
    			msgItem.put("MSG_CONT", "조회할 자료가 없습니다.");
    			msgList.add(msgItem);

    			result.put("dsMessage", msgList);
    			
    			return result;
    		}else
    		{
    			inputPageSet.put("QRY_CNT", String.valueOf(recordCnt));
    		}
        } 	
	    
	    /* 메인 쿼리 */
		ArrayList<Map<String, Object>> resultList = (ArrayList<Map<String, Object>>) dao.list("com.korail.tz.pl.PL004QMDAO.selectPageNextKeyList", inputDataSet);
	    
	    	
		/* 출력 로그(개발용) */
		for(int i=0;i<resultList.size();i++)
		{
			logger.debug(resultList.get(i).toString());
		}
		
		/* NEXT_KEY가 없고 조회결과가 0이면 자료가 없는경우이다. */
		if("".equals(inputPageSet.get("NEXT_KEY")) && resultList.isEmpty())
		{
			msgItem.put("MSG_CONT", "조회할 자료가 없습니다.");
			msgList.add(msgItem);

			result.put("dsMessage", msgList);
			
			return result;			
		}
				
		/* 페이지당 건수를 채우지 못한 경우는 다음페이지 조회하지 않도록 NEXT_KEY를 비워준다 */
		if(resultList.size() < Integer.parseInt(inputPageSet.get("PG_PR_CNT")))
		{
			inputPageSet.put("NEXT_KEY", "");	//다음 조회키			
		}else
		{
			inputPageSet.put("NEXT_KEY", String.valueOf(resultList.get(resultList.size()-1).get("BLDN_MG_NO")));	//다음 조회키
		}
		
		
		msgItem.put("MSG_CONT", "정상적으로 조회되었습니다.");
		msgList.add(msgItem);
		result.put("dsMessage", msgList);

		ArrayList<Map<String, String>> pgList = new ArrayList<Map<String, String>>();
		pgList.add(inputPageSet);
		result.put("dsPageNextKey", pgList);
		
		result.put("dsRoadList", resultList);

		return result;

	}
	
	/**
	 * @author 민지홍
	 * @date 2014. 3. 5. 오전 6:22:45
	 * Method description : next row 방식의 페이징처리 예제이다
	 *  - next row 방식은 화면의 페이징 처리 방식이 스크롤 또는 자동스크롤 방식일 때 사용합니다.
	 *  - 조회조건이 다양하여 인덱스 고정이 어렵거나, unique key를 구성하는 키의 갯수가
	 *    많은 경우에 rownum을 사용합니다.	 
	 *  - 자동 스크롤 처리하는 경우에는 fllw_qry_flg 변수에 "Y" 값을 담아 총건수 조회 로직을 skip하도록
	 *    처리합니다.
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectPageNextRowList(Map<String, ?> param) {		

		int recordCnt = 0;
		
		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		
		/* 입력 오브젝트 */
		Map<String, String> inputDataSet = XframeControllerUtils.getParamDataSet(param, "dsCondition");	
		Map<String, String> inputPageSet = XframeControllerUtils.getParamDataSet(param, "dsPageNextRow");	
		logger.debug("inputDataSet ==>  " + inputDataSet);
		logger.debug("inputPageSet ==>  " + inputPageSet);
		
		/* 출력 오브젝트 */
		ArrayList<Map<String, String>> msgList = new ArrayList<Map<String, String>>();
		HashMap<String, String> msgItem = new HashMap<String, String>();
		
	    /* 입력데이터 설정 */
        inputDataSet.put("NEXT_ROW",  inputPageSet.get("NEXT_ROW"));	//다음 조회키
        inputDataSet.put("PG_PR_CNT", inputPageSet.get("PG_PR_CNT"));	//페이지당 건수
		
        if(!"Y".equals(inputPageSet.get("FLLW_QRY_FLG")))
        {
            /* 총 건수 조회 */
    		ArrayList<Map<String, BigDecimal>> countList = (ArrayList<Map<String, BigDecimal>>) dao.list("com.korail.tz.pl.PL004QMDAO.selectPageListCount", inputDataSet);
    		recordCnt = countList.get(0).get("QRY_CNT").intValue();
    		
    		if(recordCnt == 0)
    		{
    			msgItem.put("MSG_CONT", "조회할 자료가 없습니다.");
    			msgList.add(msgItem);

    			result.put("dsMessage", msgList);
    			
    			return result;
    		}else
    		{
    			inputPageSet.put("QRY_CNT", String.valueOf(recordCnt));
    		}
        } 	
	    
	    /* 메인 쿼리 */
		ArrayList<Map<String, Object>> resultList = (ArrayList<Map<String, Object>>) dao.list("com.korail.tz.pl.PL004QMDAO.selectPageNextRowList", inputDataSet);
	    
	    	
		/* 출력 로그(개발용) */
		for(int i=0;i<resultList.size();i++)
		{
			logger.debug(resultList.get(i).toString());
		}
		
		/* NEXT_KEY가 없고 조회결과가 0이면 자료가 없는경우이다. */
		if("0".equals(inputPageSet.get("NEXT_ROW")) && resultList.isEmpty())
		{
			msgItem.put("MSG_CONT", "조회할 자료가 없습니다.");
			msgList.add(msgItem);

			result.put("dsMessage", msgList);
			
			return result;			
		}
				
		/* 페이지당 건수를 채우지 못한 경우는 다음페이지 조회하지 않도록 NEXT_KEY를 초기화한다 */
		if(resultList.size() < Integer.parseInt(inputPageSet.get("PG_PR_CNT")))
		{
			inputPageSet.put("NEXT_ROW", "0");	//다음 조회키			
		}else
		{
			inputPageSet.put("NEXT_ROW", String.valueOf(resultList.get(resultList.size()-1).get("QRY_NUM")));	//다음 조회 ROW
		}
		
		
		msgItem.put("MSG_CONT", "정상적으로 조회되었습니다.");
		msgList.add(msgItem);
		result.put("dsMessage", msgList);

		ArrayList<Map<String, String>> pgList = new ArrayList<Map<String, String>>();
		pgList.add(inputPageSet);
		result.put("dsPageNextRow", pgList);
		
		result.put("dsRoadList", resultList);

		return result;

	}
}

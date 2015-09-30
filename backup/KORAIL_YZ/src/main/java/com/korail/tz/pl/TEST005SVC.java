/**
 * project : KORAIL_YZ
 * package : com.korail.tz.pl
 * date : 2014. 3. 12.오전 7:35:29
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
 * @author Jihong
 * @date 2014. 3. 12. 오전 7:35:29
 * Class description : 팝업템플릿에서 사용하는 ACTION CLASS
 */
@Service("com.korail.tz.pl.TEST005SVC")
public class TEST005SVC {

	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public final Logger logger = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
	

	/**
	 * @author 민지홍
	 * @date 2014. 3. 5. 오전 6:09:51
	 * Method description : (페이징) 화면 목록을 조회한다.
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectScnList(Map<String, ?> param) {		

		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		
		/* 입력 오브젝트 */
		Map<String, String> inputDataSet = XframeControllerUtils.getParamDataSet(param, "dsCondition");	
		Map<String, String> inputPageSet = XframeControllerUtils.getParamDataSet(param, "dsPage");	
		
	    /* 입력데이터 설정 */
        inputDataSet.put("NEXT_KEY",  inputPageSet.get("TRVL_SCN_ID_NEXT"));	//다음 조회키
        inputDataSet.put("PG_PR_CNT", inputPageSet.get("PG_PR_CNT"));	//페이지당 건수
		
	    /* 메인 쿼리 */
		ArrayList<Map<String, Object>> resultList = (ArrayList<Map<String, Object>>) dao.list("com.korail.tz.pl.YZPL005QMDAO.selectScnList", inputDataSet);
	    
		
		/* NEXT_KEY가 없고 조회결과가 0이면 자료가 없는경우이다. */
		if("".equals(inputDataSet.get("NEXT_KEY")) && resultList.isEmpty())
		{
			XframeControllerUtils.setMessage("조회할 자료가 없습니다.", result);
			
			return result;			
		}
				
		/* 페이지당 건수를 채우지 못한 경우는 다음페이지 조회하지 않도록 NEXT_KEY를 초기화한다 */
		if(resultList.size() < Integer.parseInt(inputDataSet.get("PG_PR_CNT")))
		{
			inputPageSet.put("TRVL_SCN_ID_NEXT", "");	//다음 조회키			
		}else
		{
			inputPageSet.put("TRVL_SCN_ID_NEXT", String.valueOf(resultList.get(resultList.size()-1).get("TRVL_SCN_ID")));	//다음 조회 ROW
		}
		

		XframeControllerUtils.setMessage("정상적으로 조회되었습니다.", result);

		ArrayList<Map<String, String>> pgList = new ArrayList<Map<String, String>>();
		pgList.add(inputPageSet);
		result.put("dsPage", pgList);
		
		result.put("dsScnList", resultList);

		return result;

	}


	/**
	 * @author 민지홍
	 * @date 2014. 3. 5. 오전 6:09:51
	 * Method description : (페이징) 담당자 목록을 조회한다.
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectCgPsList(Map<String, ?> param) {		

		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		
		/* 입력 오브젝트 */
		Map<String, String> inputDataSet = XframeControllerUtils.getParamDataSet(param, "dsCondition");	
		Map<String, String> inputPageSet = XframeControllerUtils.getParamDataSet(param, "dsPage");	
		
	    /* 입력데이터 설정 */
        inputDataSet.put("NEXT_ROW",  inputPageSet.get("NEXT_ROW"));	//다음 조회키
        inputDataSet.put("PG_PR_CNT", inputPageSet.get("PG_PR_CNT"));	//페이지당 건수
		
	    /* 메인 쿼리 */
		ArrayList<Map<String, Object>> resultList = (ArrayList<Map<String, Object>>) dao.list("com.korail.tz.pl.YZPL005QMDAO.selectCgPsList", inputDataSet);
	    
		
		/* NEXT_KEY가 없고 조회결과가 0이면 자료가 없는경우이다. */
		if("0".equals(inputDataSet.get("NEXT_ROW")) && resultList.isEmpty())
		{
			XframeControllerUtils.setMessage("조회할 자료가 없습니다.", result);
			
			return result;			
		}
				
		/* 페이지당 건수를 채우지 못한 경우는 다음페이지 조회하지 않도록 NEXT_KEY를 초기화한다 */
		if(resultList.size() < Integer.parseInt(inputDataSet.get("PG_PR_CNT")))
		{
			inputPageSet.put("NEXT_ROW", "0");	//다음 조회키			
		}else
		{
			inputPageSet.put("NEXT_ROW", String.valueOf(resultList.get(resultList.size()-1).get("RN")));	//다음 조회 ROW
		}
		

		XframeControllerUtils.setMessage("정상적으로 조회되었습니다.", result);

		ArrayList<Map<String, String>> pgList = new ArrayList<Map<String, String>>();
		pgList.add(inputPageSet);
		result.put("dsPage", pgList);
		
		result.put("dsCgPsList", resultList);

		return result;

	}
	
	/**
	 * @author 민지홍
	 * @date 2014. 3. 5. 오전 6:09:51
	 * Method description : (페이징) 노선코드 목록을 조회한다.
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectRoutCdList(Map<String, ?> param) {		

		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		
		/* 입력 오브젝트 */
		Map<String, String> inputDataSet = XframeControllerUtils.getParamDataSet(param, "dsCondition");	
		Map<String, String> inputPageSet = XframeControllerUtils.getParamDataSet(param, "dsPage");	
		
	    /* 입력데이터 설정 */
        inputDataSet.put("NEXT_ROW",  inputPageSet.get("NEXT_ROW"));	//다음 조회키
        inputDataSet.put("PG_PR_CNT", inputPageSet.get("PG_PR_CNT"));	//페이지당 건수
		
	    /* 메인 쿼리 */
		ArrayList<Map<String, Object>> resultList = (ArrayList<Map<String, Object>>) dao.list("com.korail.tz.pl.YZPL005QMDAO.selectRoutCdList", inputDataSet);
	    
		
		/* NEXT_KEY가 없고 조회결과가 0이면 자료가 없는경우이다. */
		if("0".equals(inputDataSet.get("NEXT_ROW")) && resultList.isEmpty())
		{
			XframeControllerUtils.setMessage("조회할 자료가 없습니다.", result);
			
			return result;			
		}
				
		/* 페이지당 건수를 채우지 못한 경우는 다음페이지 조회하지 않도록 NEXT_KEY를 초기화한다 */
		if(resultList.size() < Integer.parseInt(inputDataSet.get("PG_PR_CNT")))
		{
			inputPageSet.put("NEXT_ROW", "0");	//다음 조회키			
		}else
		{
			inputPageSet.put("NEXT_ROW", String.valueOf(resultList.get(resultList.size()-1).get("RN")));	//다음 조회 ROW
		}
		

		XframeControllerUtils.setMessage("정상적으로 조회되었습니다.", result);

		ArrayList<Map<String, String>> pgList = new ArrayList<Map<String, String>>();
		pgList.add(inputPageSet);
		result.put("dsPage", pgList);
		
		result.put("dsRoutCdList", resultList);

		return result;

	}

	/**
	 * @author 민지홍
	 * @date 2014. 3. 5. 오전 6:09:51
	 * Method description : (페이징) 공통코드 목록을 조회한다.
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectCmmnCdList(Map<String, ?> param) {		

		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		
		/* 입력 오브젝트 */
		Map<String, String> inputDataSet = XframeControllerUtils.getParamDataSet(param, "dsCondition");	
		Map<String, String> inputPageSet = XframeControllerUtils.getParamDataSet(param, "dsPage");	
		
	    /* 입력데이터 설정 */
        inputDataSet.put("NEXT_ROW",  inputPageSet.get("NEXT_ROW"));	//다음 조회키
        inputDataSet.put("PG_PR_CNT", inputPageSet.get("PG_PR_CNT"));	//페이지당 건수
		
	    /* 메인 쿼리 */
		ArrayList<Map<String, Object>> resultList = (ArrayList<Map<String, Object>>) dao.list("com.korail.tz.pl.YZPL005QMDAO.selectCmmnCdList", inputDataSet);
	    
		
		/* NEXT_KEY가 없고 조회결과가 0이면 자료가 없는경우이다. */
		if("0".equals(inputDataSet.get("NEXT_ROW")) && resultList.isEmpty())
		{
			XframeControllerUtils.setMessage("조회할 자료가 없습니다.", result);
			
			return result;			
		}
				
		/* 페이지당 건수를 채우지 못한 경우는 다음페이지 조회하지 않도록 NEXT_KEY를 초기화한다 */
		if(resultList.size() < Integer.parseInt(inputDataSet.get("PG_PR_CNT")))
		{
			inputPageSet.put("NEXT_ROW", "0");	//다음 조회키			
		}else
		{
			inputPageSet.put("NEXT_ROW", String.valueOf(resultList.get(resultList.size()-1).get("RN")));	//다음 조회 ROW
		}
		

		XframeControllerUtils.setMessage("정상적으로 조회되었습니다.", result);

		ArrayList<Map<String, String>> pgList = new ArrayList<Map<String, String>>();
		pgList.add(inputPageSet);
		result.put("dsPage", pgList);
		
		result.put("dsCmmnCdList", resultList);

		return result;

	}
	
	
	/**
	 * @author 민지홍
	 * @date 2014. 3. 5. 오전 6:09:51
	 * Method description : 예발역코드 목록을 조회한다.
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectRsStnCdList(Map<String, ?> param) throws Exception{		

		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		
		try{
			ArrayList<Map<String, Object>> outRsStnList = new ArrayList<Map<String, Object>>();
			ArrayList<Map<String, Object>> outImpStnList = new ArrayList<Map<String, Object>>();
			
			/* 입력 오브젝트 */
			Map<String, String> inputDataSet = XframeControllerUtils.getParamDataSet(param, "dsCondition");	
					
		    /* 예발역코드목록 조회 */
			ArrayList<Map<String, Object>> rsStnList = (ArrayList<Map<String, Object>>) dao.list("com.korail.tz.pl.YZPL005QMDAO.selectRsStnCdList", inputDataSet);
	
			outRsStnList = makeOutStnCdList(rsStnList);
			
			/* 주요역코드 조회 */
			inputDataSet.put("IMP_RS_STN_FLG", "Y");
			inputDataSet.put("KOR_STN_NM_FROM", "");
			inputDataSet.put("KOR_STN_NM_TO", "");
			ArrayList<Map<String, Object>> impStnList = (ArrayList<Map<String, Object>>) dao.list("com.korail.tz.pl.YZPL005QMDAO.selectRsStnCdList", inputDataSet);
	
			outImpStnList = makeOutStnCdList(impStnList);
			
			result.put("dsRsStnCdList", outRsStnList);
			result.put("dsImpStnCdList", outImpStnList);
	
			XframeControllerUtils.setMessage("정상적으로 조회되었습니다.", result);
		}catch(Exception e)
		{
			e.printStackTrace();
			XframeControllerUtils.setMessage("조회 중 오류가 발생하였습니다.", result);
			throw(e);
		}

		return result;

	}	

	/**
	 * @author 민지홍
	 * @date 2014. 3. 5. 오전 6:09:51
	 * Method description : 선코드 목록을 조회한다.
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectLnList(Map<String, ?> param) throws Exception{		

		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		
		try{			
			/* 입력 오브젝트 */
			//Map<String, String> inputDataSet = XframeControllerUtils.getParamDataSet(param, "dsCondition");	
					
		    /* 예발역코드목록 조회 */
			ArrayList<Map<String, Object>> resultList = (ArrayList<Map<String, Object>>) dao.list("com.korail.tz.pl.YZPL005QMDAO.selectLnList", null);
	
			
			result.put("dsLnList", resultList);
	
		}catch(Exception e)
		{
			e.printStackTrace();
			XframeControllerUtils.setMessage("조회 중 오류가 발생하였습니다.", result);
			throw(e);
		}

		return result;

	}	
	
	/**
	 * @author 민지홍
	 * @date 2014. 3. 5. 오전 6:09:51
	 * Method description : 환승역코드 목록을 조회한다.
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectChgStnCdList(Map<String, ?> param) throws Exception{		

		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		
		try{			
			/* 입력 오브젝트 */
			Map<String, String> inputDataSet = XframeControllerUtils.getParamDataSet(param, "dsCondition");	
					
		    /* 예발역코드목록 조회 */
			ArrayList<Map<String, Object>> rsStnList = (ArrayList<Map<String, Object>>) dao.list("com.korail.tz.pl.YZPL005QMDAO.selectChgStnCdList", inputDataSet);
							
			result.put("dsChgRsStnList", rsStnList);
	
			XframeControllerUtils.setMessage("정상적으로 조회되었습니다.", result);
		}catch(Exception e)
		{
			e.printStackTrace();
			XframeControllerUtils.setMessage("조회 중 오류가 발생하였습니다.", result);
			throw(e);
		}

		return result;

	}	
	
	private ArrayList<Map<String, Object>> makeOutStnCdList(ArrayList<Map<String, Object>> stnList)
	{
		int i;
		ArrayList<Map<String, Object>> outList = new ArrayList<Map<String, Object>>();

		/* 예발역코드 출력목록 생성 */
	    for (i = 0; i < stnList.size()+7; i+=7)
	    {
	        if(i < stnList.size())
	        {
		        Map<String, Object> item = new HashMap<String, Object>();
	        	item.put("STN_CD1", stnList.get(i).get("RS_STN_CD"));
	        	item.put("STN_NM1", stnList.get(i).get("KOR_STN_NM"));
	        	outList.add(item);

	        }
	        if(i+1 < stnList.size())
	        {
		        Map<String, Object> item = new HashMap<String, Object>();
	        	item.put("STN_CD2", stnList.get(i+1).get("RS_STN_CD"));
	        	item.put("STN_NM2", stnList.get(i+1).get("KOR_STN_NM"));
	        	outList.add(item);
	        }
	        if(i+2 < stnList.size())
	        {
		        Map<String, Object> item = new HashMap<String, Object>();
	        	item.put("STN_CD3", stnList.get(i+2).get("RS_STN_CD"));
	        	item.put("STN_NM3", stnList.get(i+2).get("KOR_STN_NM"));
	        	outList.add(item);
	        }
	        if(i+3 < stnList.size())
	        {
		        Map<String, Object> item = new HashMap<String, Object>();
	        	item.put("STN_CD4", stnList.get(i+3).get("RS_STN_CD"));
	        	item.put("STN_NM4", stnList.get(i+3).get("KOR_STN_NM"));
	        	outList.add(item);
	        }
	        if(i+4 < stnList.size())
	        {
		        Map<String, Object> item = new HashMap<String, Object>();
	        	item.put("STN_CD5", stnList.get(i+4).get("RS_STN_CD"));
	        	item.put("STN_NM5", stnList.get(i+4).get("KOR_STN_NM"));
	        	outList.add(item);
	        }
	        if(i+5 < stnList.size())
	        {
		        Map<String, Object> item = new HashMap<String, Object>();
	        	item.put("STN_CD6", stnList.get(i+5).get("RS_STN_CD"));
	        	item.put("STN_NM6", stnList.get(i+5).get("KOR_STN_NM"));
	        	outList.add(item);
	        }
	        if(i+6 < stnList.size())
	        {
		        Map<String, Object> item = new HashMap<String, Object>();
	        	item.put("STN_CD7", stnList.get(i+6).get("RS_STN_CD"));
	        	item.put("STN_NM7", stnList.get(i+6).get("KOR_STN_NM"));
	        	outList.add(item);
	        }
	    }
		
		return outList;
	}
}

/**
 * project : KORAIL_YZ
 * package : com.korail.yz.yb.co
 * date : 2014. 3. 28.오후 1:55:36
 */
package com.korail.yz.yb.co;

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
 * @author "한현섭"
 * @date 2014. 3. 28. 오후 1:55:36
 * Class description : 예약발매역 조회 서비스
 */
@Service("com.korail.yz.yb.co.YBCO002SVC")
public class YBCO002SVC {
	
	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public  final Logger logger = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);

	/**
	 * @author 한현섭
	 * @date 2014. 3. 28. 오후 1:56:03
	 * Method description : 예약발매역을 조회한다.
	 * @param param
	 * @return Map
	 */	

	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListRsvSaleStn(Map<String, ?> param)
	{
		/* resultList 구성에 필요한 변수들 */
		String colNm = "STN_NM";
		int colCount = 5; //컬럼수. default = 5
				
		
		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		
		ArrayList<Map<String, String>> messageList = new ArrayList<Map<String, String>>();
		HashMap<String, String> msgMap = new HashMap<String, String>();
		
		ArrayList<Map<String, String>> resultList = new ArrayList<Map<String, String>>();
		Map<String, String> stnNmMap = new HashMap<String, String>();
		
		
		/* 입력 오브젝트 */
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsStnCondition");
		logger.debug("inputDateSet--->"+inputDataSet.toString());
		

		/* 메인 SQL */ 
		ArrayList<Map<String, Object>> stnNmList
		= (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.yb.co.YBCO002QMDAO.selectListRsvSaleStn", inputDataSet);
		
		int stnNmListSize = stnNmList.size();
		
		
		/*
		 * 5개의 컬럼에 나눠서 그리드로 표시하기 위해서 STN_NM의 값들이 담긴 ArrayList를
		 * STN_NM_1 ~ STN_NM_5의 키값을 가진 MAP으로 만들어 size() = 5가 될 때마다
		 * ArrayList인 resultList에 담는다
		 */
		String value = null;
		String keyColNm = null;
		int keyIdx = 0;
		
		for(int i = 0 ; i < stnNmList.size(); i++)
		{
			value = stnNmList.get(i).get("KOR_STN_NM").toString();
			keyIdx = (i % colCount)+1;
			keyColNm = colNm+"_"+ keyIdx;
			
			stnNmMap.put(keyColNm, value);
			
			if(keyIdx == 5 || i == stnNmList.size()-1)
			{
				resultList.add(stnNmMap);
				stnNmMap = new HashMap<String, String>();
			}
		}
		result.put("dsGrdStnList", resultList);
		
		/*
		 * 메시지처리
		 */
		msgMap.put("MSG_CONT", "총"+stnNmListSize+"개의 역이 검색되었습니다.");
		messageList.add(msgMap);
		result.put("dsMessage", messageList);
		return result;
	}

	/**
	 * @author 한현섭
	 * @date 2014. 3. 28. 오후 2:08:55
	 * Method description : 고속열차 정차역을 조회한다
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListHtnStopStn(Map<String, ?> param)
	{
		/* resultList 구성에 필요한 변수들 */
		String colNm = "STOP_STN_NM";
		int colCount = 5; //컬럼수. default = 5
				
		
		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		
		ArrayList<Map<String, String>> resultList = new ArrayList<Map<String, String>>();
		Map<String, String> stnNmMap = new HashMap<String, String>();

		/* 메인 SQL */ 
		ArrayList<Map<String, Object>> stnNmList
		= (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.yb.co.YBCO002QMDAO.selectListHtnStopStn", null);
		
		String value = null;
		String keyColNm = null;
		int keyIdx = 0;
		
		/*
		 * 5개의 컬럼에 나눠서 그리드로 표시하기 위해서 STN_NM의 값들이 담긴 ArrayList를
		 * STN_NM_1 ~ STN_NM_5의 키값을 가진 MAP으로 만들어 size() = 5가 될 때마다
		 * ArrayList인 resultList에 담는다
		 */
		for(int i = 0 ; i < stnNmList.size(); i++)
		{
			value = stnNmList.get(i).get("KOR_STN_NM").toString();
			keyIdx = (i % colCount)+1;
			keyColNm = colNm+"_"+ keyIdx;
			
			stnNmMap.put(keyColNm, value);
			
			if(keyIdx == 5 || i == stnNmList.size()-1)
			{
				resultList.add(stnNmMap);
				stnNmMap = new HashMap<String, String>();
			}
		}
		result.put("dsGrdMainStnList", resultList);

		return result;
	}

	public Map<String, ?> test(Map<String, ?> param)
	{
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCondition");
		logger.debug("inputDateSet--->"+inputDataSet.toString());

		
		return null;
	}
	
}
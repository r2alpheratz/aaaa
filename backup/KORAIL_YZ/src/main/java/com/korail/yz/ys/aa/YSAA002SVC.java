/**
 * project : KORAIL_YZ
 * package : com.korail.yz.ys.aa
 * date : 2014. 4. 7. 오후 10:32:30
 */
package com.korail.yz.ys.aa;

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
 * @author 김응규
 * @date 2014. 4. 7. 오후 10:32:30
 * Class description :  작업일별수익관리대상열차조회SVC
 * 작업일별 수익관리 대상 열차조회를 위한 Service 클래스
 */
@Service("com.korail.yz.ys.aa.YSAA002SVC")
public class YSAA002SVC {
	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public  static final Logger LOGGER = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
	

	/**
	 * @author 나윤채
	 * @date 2015. 2. 19. 오후 6:40:17
	 * Method description : 대수송구분 여부를 판단한다.
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map<String, ?> selectListLrgCrgJgmt(Map<String, ?> param) {		
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		LOGGER.debug("param ==> "+param);
		// search input column dataset
		Map<String, String> inputDataSet = XframeControllerUtils.getParamDataSet(param, "dsCond2");
		
		ArrayList<Map<String, Object>> resultList = (ArrayList) dao.list("com.korail.yz.ys.aa.YSAA002QMDAO.selectListLrgCrgJgmt", inputDataSet);
		
		
		//메시지 처리
		if(resultList.isEmpty()){
			XframeControllerUtils.setMessage("IZZ000004", result); //해당 조건의 자료가 존재하지 않습니다.
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result); //정상적으로 조회 되었습니다.
		}
		
		result.put("dsLrgCrgJgmt", resultList);
		
		return result;
		
	}
	
	/**
	 * @author 나윤채
	 * @date 2015. 2. 19. 오후 7:30:31
	 * Method description : 열차별예측실적 차트 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map<String, ?> selectListCht(Map<String, ?> param) {		
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		LOGGER.debug("param ==> "+param);
		// search input column dataset
		Map<String, String> inputDataSet = XframeControllerUtils.getParamDataSet(param, "dsCond");
		ArrayList<Map<String, Object>> resultList = new ArrayList<Map<String,Object>>();
		ArrayList<Map<String, Object>> resultList2 = new ArrayList<Map<String,Object>>();
		ArrayList<Map<String, Object>> resultList3 = new ArrayList<Map<String,Object>>();
		ArrayList<Map<String, Object>> resultList6 = new ArrayList<Map<String,Object>>();
		
		String dvCd = inputDataSet.get("DV_CD");
		
		if("".equals(inputDataSet.get("DPT_STGP_CD")) || "".equals(inputDataSet.get("ARV_STGP_CD"))) // 장기예측인원 조회
		{
			resultList.clear();
			
			for( int i = 0; i < 31; i ++)
			{
				Map<String, Object> empty = new HashMap<String, Object>();
				empty.put("RSV_DPT_BF_DNO", i);
				empty.put("RSV_SALE_FCST_PRNB", 0);
				empty.put("CNC_DPT_BF_DNO", i);
				empty.put("CNC_RET_FCST_PRNB", 0);
				
				resultList.add(empty);
			}
		}else // 구역구간 검색 조건이 전체일 경우 건너 뛴다. (  if 문에서 0으로 채워넣는다. )
		{			
			if(Integer.valueOf(dvCd) > 4) //정상
			{
				if("5".equals(dvCd)) //정상 하계
				{
					resultList = (ArrayList) dao.list("com.korail.yz.ys.aa.YSAA002QMDAO.selectListSmerCht", inputDataSet);
				}else if("6".equals(dvCd)) //정상 연말연시
				{
					resultList = (ArrayList) dao.list("com.korail.yz.ys.aa.YSAA002QMDAO.selectListEyCht", inputDataSet);	
				}else if("7".equals(dvCd)) //정상 공휴일
				{
					resultList = (ArrayList) dao.list("com.korail.yz.ys.aa.YSAA002QMDAO.selectListHoliCht", inputDataSet);				
				}else if("8".equals(dvCd)) //정상 기본
				{
					resultList = (ArrayList) dao.list("com.korail.yz.ys.aa.YSAA002QMDAO.selectListNmCht", inputDataSet);		
				}
			}else // 임시
			{
				if("1".equals(dvCd)) //임시 하계
				{
					resultList = (ArrayList) dao.list("com.korail.yz.ys.aa.YSAA002QMDAO.selectListTempSmerCht", inputDataSet);			
				}else if("2".equals(dvCd)) //임시 연말연시
				{
					resultList = (ArrayList) dao.list("com.korail.yz.ys.aa.YSAA002QMDAO.selectListTempEyCht", inputDataSet);
				}else if("3".equals(dvCd)) //임시 공휴일
				{
					resultList = (ArrayList) dao.list("com.korail.yz.ys.aa.YSAA002QMDAO.selectListTempHoliCht", inputDataSet);
				}else if("4".equals(dvCd)) //임시 기본
				{
					resultList = (ArrayList) dao.list("com.korail.yz.ys.aa.YSAA002QMDAO.selectListTempNmCht", inputDataSet);
				}
			}
		}

		ArrayList<Map<String, Object>> resultList4 = (ArrayList) dao.list("com.korail.yz.ys.aa.YSAA002QMDAO.selectListFinalExpnPrnb", inputDataSet); //최종예측인원
		ArrayList<Map<String, Object>> resultList5 = (ArrayList) dao.list("com.korail.yz.ys.aa.YSAA002QMDAO.selectListRsvSalePrnb", inputDataSet); // 예약발매실적
		
		//메시지 처리
		if(resultList.isEmpty() && resultList4.isEmpty() && resultList5.isEmpty()){
			XframeControllerUtils.setMessage("IZZ000004", result); //해당 조건의 자료가 존재하지 않습니다.
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result); //정상적으로 조회 되었습니다.
		}
		
		if(resultList.isEmpty()) // 장기예측인원 결과가 없을 경우 보정
		{
			resultList.clear();
			
			for( int i = 0; i < 31; i ++)
			{
				Map<String, Object> empty = new HashMap<String, Object>();
				empty.put("RSV_DPT_BF_DNO", i);
				empty.put("RSV_SALE_FCST_PRNB", 0);
				empty.put("CNC_DPT_BF_DNO", i);
				empty.put("CNC_RET_FCST_PRNB", 0);
				
				resultList.add(empty);
			}
		}
		
		resultList2 = (ArrayList<Map<String, Object>>) resultList.clone(); // 장기예측 예약발매예측 기준 정렬 및 보정 대상
		resultList3 = (ArrayList<Map<String, Object>>) resultList.clone(); // 장기예측 취소반환예측 기준 정렬 및 보정 대상
		resultList6 = (ArrayList<Map<String, Object>>) resultList5.clone(); // 예약발매실적 기준 보정대상
		
		
		
		for (int i = 0; i < resultList3.size() - 1; i ++) // 장기예측 취소반환실적 기준 정렬 ( QUERY 에서는 예약발매실적 기준 ORDER BY 조회)
		{
			for (int j = i+1 ; j < resultList3.size(); j ++)
			{
				int left = Integer.valueOf(String.valueOf(resultList3.get(i).get("CNC_DPT_BF_DNO")));
				int right = Integer.valueOf(String.valueOf(resultList3.get(j).get("CNC_DPT_BF_DNO")));

				if(left > right)
				{
					Map<String, Object> temp = new HashMap<String, Object>();

					temp = resultList3.get(j);
					resultList3.set(j, resultList3.get(i));
					resultList3.set(i, temp);				
					left = Integer.valueOf(String.valueOf(resultList.get(i).get("CNC_DPT_BF_DNO")));
				}
			}
		}
		
		resultList2 = sortingChart( "RSV_DPT_BF_DNO", "RSV_SALE_FCST_PRNB", resultList2 ); // 차트 조회를 위해 정렬 및 보정
		resultList3 = sortingChart( "CNC_DPT_BF_DNO", "CNC_RET_FCST_PRNB", resultList3 ); // 차트 조회를 위해 정렬 및 보정
		if ( !"0".equals(String.valueOf(resultList6.get(0).get("DPT_BF_DT_NUM"))))	// 첫 행의 순서가 0부터 시작하지 않을 경우, 0 행을 삽입
		{
			resultList6.add(0, resultList.get(0));
			resultList6.get(0).put("DPT_BF_DT_NUM", 0);
		}
	
		resultList6 = sortingChart( "DPT_BF_DT_NUM", "SUM_NUM", resultList6 ); // 차트 조회를 위해 정렬 및 보정

		resultList.clear();
		
		for (int i = 0; i < 31; i ++) // 차트 데이터로 가공 
		{
			Map<String, Object> sumOfResult = new HashMap<String, Object>();
//			sumOfResult.put("DPT_STGP_CD", inputDataSet.get("DPT_STGP_CD"));
//			sumOfResult.put("ARV_STGP_CD", inputDataSet.get("ARV_STGP_CD"));
//			sumOfResult.put("DASP_DV_NO", 30 - i);
			
			
			if ( i < 10)
			{
				sumOfResult.put("RSV_DPT_BF_DNO", "D-0".concat(String.valueOf(i)));
			}else
			{
				sumOfResult.put("RSV_DPT_BF_DNO", "D-" +i);
			}
			
			sumOfResult.put("RSV_SALE_FCST_PRNB", resultList2.get(i).get("RSV_SALE_FCST_PRNB"));
			sumOfResult.put("CNC_DPT_BF_DNO", i);
			sumOfResult.put("CNC_RET_FCST_PRNB", resultList3.get(i).get("CNC_RET_FCST_PRNB"));
			sumOfResult.put("RSV_CNC_FCST_PRNB", Integer.valueOf(String.valueOf(resultList2.get(i).get("RSV_SALE_FCST_PRNB"))) 
										  - Integer.valueOf(String.valueOf(resultList3.get(i).get("CNC_RET_FCST_PRNB")))); // 장기예측인원 ( 예약발매 예측인원 - 취소반환 예측인원)
			if(i == 0)
			{
				sumOfResult.put("SUM_NUM_FINAL", resultList4.get(i).get("SUM_NUM_FINAL")); //D-00 에는 최종예측인원 삽입
			}else{
				sumOfResult.put("SUM_NUM", resultList6.get(i).get("SUM_NUM")); // D-01부터 예약발매실적 삽입(하려 했으나 REXPERT의 한계상 D-00에도 0으로 삽입됨)
			}
			
			resultList.add(sumOfResult);
		}
		
		result.put("dsCht", resultList);
		
		return result;
	}
	
	/**
	 * 수익관리대상열차 일별처리 작업일자별 조회
	 * @author 김응규
	 * @date 2014. 4. 6. 오전 11:53:00
	 * Method description : 수익관리대상열차 일별처리 작업일자별 조회를 실행한다. 
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map<String, ?> selectListJobDdprYmgtTgtTrn(Map<String, ?> param) {		

		Map<String, Object> result = new HashMap<String, Object>();

		LOGGER.debug("param ==> "+param);
		// search input column dataset
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");
		
		ArrayList<Map<String, Object>> resultList = (ArrayList) dao.list("com.korail.yz.ys.aa.YSAA002QMDAO.selectListJobDdprYmgtTgtTrn", inputDataSet);

		//메시지 처리
		if(resultList.isEmpty()){
			XframeControllerUtils.setMessage("IZZ000004", result); //해당 조건의 자료가 존재하지 않습니다.
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result); //정상적으로 조회 되었습니다.
		}
		result.put("dsList", resultList);
		return result;
	}

	/*	예약-취소 리스트 re-sorting */
	private ArrayList<Map<String, Object>> sortingChart( String sortingNo, String sortingData, ArrayList<Map<String, Object>> resultList ){
		
		for (int i = 0; i < resultList.size()-1; i++) 
		{
			
			if (resultList.get(i).get(sortingNo).equals(resultList.get(i+1).get(sortingNo))) // 출발이전일수가 중복될 경우, 하나만 남기고 삭제한다.
			{
				resultList.remove(i+1);

			    if(i == 0)
			    {
			    	i = -1;
			    }else
			    {	
			    	i--;
			    }
			}//end if
		}//end for
				
		if( resultList.size() > 1 && !"30".equals(resultList.get(resultList.size()-1).get(sortingNo))) // 출발이전일수가 30이 없을 경우 '0'으로 입력해준다. (출발이전일수 : 0 ~ 30 필요)
		{
			resultList.get(resultList.size()-1).put(sortingNo, 30);
			resultList.get(resultList.size()-1).put(sortingData, 0);
		} else if( resultList.size() == 1 && !"30".equals(resultList.get(resultList.size()-1).get(sortingNo))) // 출발이전일수가 30이 없을 경우 '0'으로 입력해준다. (출발이전일수 : 0 ~ 30 필요)
		{
			resultList.add(resultList.get(resultList.size()-1));
			resultList.get(resultList.size()-1).put(sortingNo, 30);
			resultList.get(resultList.size()-1).put(sortingData, 0);
		} else if( resultList.size() == 1 && !"0".equals(resultList.get(resultList.size()-1).get(sortingNo))) // 출발이전일수가 30이 없을 경우 '0'으로 입력해준다. (출발이전일수 : 0 ~ 30 필요)
		{
			resultList.add(resultList.get(resultList.size()-1));
			resultList.get(resultList.size()-1).put(sortingNo, 0);
//			resultList.get(resultList.size()-1).put(sortingData, 0);
		}
		
		for (int j = 0; j < resultList.size()-1; j++)	// 출발이전일수 0 ~ 30 사이에 값이 비어있을 경우, 양 끝 값의 평균으로 보정한다.
		{
			Map<String, Object> order = new HashMap<String, Object>();
			
			int start1 = Integer.parseInt(String.valueOf(resultList.get(j).get(sortingNo)))+1;
			String start2 = String.valueOf(start1);
			int next1 = Integer.parseInt(String.valueOf(resultList.get(j+1).get(sortingNo)));
			String next2 = String.valueOf(next1);
			
			if(!start2.equals(next2))
			{
				double sData = Double.parseDouble(String.valueOf(resultList.get(j).get(sortingData)));
				double nData = Double.parseDouble(String.valueOf(resultList.get(j+1).get(sortingData)));
				int num = (int) Math.round(sData - Math.ceil((sData - nData) / (next1 - start1 + 1)));

				order.put(sortingNo, j+1);
				order.put(sortingData, num);
				resultList.add(j+1, order);
			}//end if
		}//end for	
		
		
//		if(resultList.size() < 30) // 30일 까지 추가 보정
//		{
//			
//			for (int i = resultList.size(); i < 31; i++) 
//			{
//				Map<String, Object> add = new HashMap<String, Object>();
//				add.put(sortingNo, i);
//				add.put(sortingData, 0);
//				resultList.add(i, add);
//			}
//		}
		
	return resultList;	
	}
}
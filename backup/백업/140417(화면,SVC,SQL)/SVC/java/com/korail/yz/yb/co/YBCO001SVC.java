/**
 * project : KORAIL_YZ
 * package : com.korail.yz.yb.co
 * date : 2014. 3. 11.오후 3:32:36
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
 * @author "Changki.woo"
 * @date 2014. 3. 11. 오후 3:32:10
 * Class description : 
 */

/**
 * @author SDS
 *
 */
@Service("com.korail.yz.yb.co.YBCO001SVC")
public class YBCO001SVC {

	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public  final Logger logger = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
	
	
	  public static boolean isEmpty(String str) {
	      return str == null || str.length() == 0;
	  }
	
	
	/**
	 * @author "Changki.woo"
	 * @date 2014. 3. 11. 오후 3:50:55
	 * Method description : 열차번호선택(기본) SVC
	 * @param param
	 * @return Map
	 */
	public Map<String, ? > selectListBsTrnNo(Map<String, ?> param){
		
		final int trnNoColSiz = 5;
		String trnNoColNm 	= "TRN_NO";
		String callTypePram = "TRN_NO_CALL_TYPE";
		String dsNoCallType = "dsTrnNoCallTyp";
		
		//화면의 DATASET으로 return을 위한 변수
		Map<String, Object> result = new HashMap<String, Object>();
		
		// 1. 화면에서 DATASET을 들고온다.
		//
		// 해당데이터셋에 화면에서 검색용으로 들고온 열차번호 파라미터가 있으면
		// 쿼리의 where절이 동작한다.
		Map<String, String> getDataSet = XframeControllerUtils	.getParamDataSet(param, dsNoCallType);
		
		//분기에 기준의 되는 변수들
		//null,"" 일 경우 아무 조건없는 열차번호를 조회하는 쿼리를 수행
		//1,2,3,4,5의 경우 특정 쿼리를 수행하도록함.
		String callType  = getDataSet.get(callTypePram);
		
		// 쿼리 조회후 결과를 담을 List
		ArrayList<Map<String, Object>> qryList = null;
		// 열차번호에 해당하는 ROUT_CD, LN_CD,ROUT_NM,LN_NM, 상하행구분코드, YMS적용여부를 조회조건에 자동세팅용
		ArrayList<Map<String, Object>> getStatusList = null;
		
		/* *
		 * 열차번호선택(기본)팝업의 쿼리를 선택하는 분기문.
		 * */
		if("YMS".equals(callType))
		{
			if("Y".equals(callType))
			{
				qryList = (ArrayList) dao.list("com.korail.yz.yb.co.YBCO001QMDAO.selectListBsTrnNoYmsY", getDataSet);
				
			}
			else if("N".equals(callType))
			{
				qryList = (ArrayList) dao.list("com.korail.yz.yb.co.YBCO001QMDAO.selectListBsTrnNoYmsN", getDataSet);
			}
			else
			{
				qryList = (ArrayList) dao.list("com.korail.yz.yb.co.YBCO001QMDAO.selectListBsTrnNoYmsAll", getDataSet);
			}
			
			getStatusList =  (ArrayList) dao.list("com.korail.yz.yb.co.YBCO001QMDAO.selectListBsTrnNoYmsAutoSetCondData", getDataSet);
		}
		
		else if("YRAA003".equals(callType))
		{
			qryList = (ArrayList) dao.list("com.korail.yz.yb.co.YBCO001QMDAO.selectListBsTrnNoYRAA003", getDataSet);
			if(qryList.size() > 0)
			{
				getStatusList =  (ArrayList) dao.list("com.korail.yz.yb.co.YBCO001QMDAO.selectListBsTrnNoYRAA003AutoSetCondData", getDataSet);
			}
		}
		
		else if("YRAA004".equals(callType))
		{
			qryList = (ArrayList) dao.list("com.korail.yz.yb.co.YBCO001QMDAO.selectListBsTrnNoYRAA004", getDataSet);
			if(qryList.size() > 0)
			{
				getStatusList =  (ArrayList) dao.list("com.korail.yz.yb.co.YBCO001QMDAO.selectListBsTrnNoYRAA004AutoSetCondData", getDataSet);
			}
		}
		
		else if("YSAA001".equals(callType))  
		{
			/**
			 *  description :  의사결정지원-수익관리대상열차일별처리화면에서 사용하는 열차번호조회
			 *  						운행일자, 열차종별, 주운행선, 상하행구분, 담당자 값에 따른 조회를 함. 
			 *  						김응규(2014.04.02)
			 **/
			qryList = (ArrayList) dao.list("com.korail.yz.yb.co.YBCO001QMDAO.seletListBsTrnNoYSAA001", getDataSet);
			getStatusList =  (ArrayList) dao.list("com.korail.yz.yb.co.YBCO001QMDAO.seletListBsTrnNoYSAA001AutoSetCondData", getDataSet);
		}
		else if("YRAA005".equals(callType))  
		{
			qryList = (ArrayList) dao.list("com.korail.yz.yb.co.YBCO001QMDAO.seletListBsTrnNoYRAA005", getDataSet);
			/* 이화면의 열차번호 만큼은 조회조건 autoSet이 없다 ㅋㅋ*/
			//getStatusList =  (ArrayList) dao.list("com.korail.yz.yb.co.YBCO001QMDAO.seletListBsTrnNoYSAA001AutoSetCondData", getDataSet);
		}
		
		
		else 
		{
			qryList = (ArrayList) dao.list("com.korail.yz.yb.co.YBCO001QMDAO.selectListBsTrnNo", getDataSet);
			getStatusList =  (ArrayList) dao.list("com.korail.yz.yb.co.YBCO001QMDAO.selectListBsTrnNoAutoSetCondData", getDataSet);
		}
		
	

	    // 조회결과를 쪼개서 담기
		ArrayList<Map<String, Object>> resultList = divColSizeForGrd(qryList, trnNoColSiz, trnNoColNm);
		
		// 화면에 뿌릴 DATASET의 이름으로 put한다.
		result.put("dsTrnNoList", resultList);
		result.put("dsTrnCondAutoSet", getStatusList);
		
		//리턴하며 종료
		return result;
		
	}

	
	// 조회해온 결과를 그리드 컬럼크기에 맞게 정리하는 함수
	// params
	// qryList     조회해온 쿼리
	// trnNoColSiz 컬럼사이즈
	// trnNoColNm  컬럼이름 
	// ex) TRN_NO 라면 포문을 돌며 TRN_NO_1, TRN_NO_2, TRN_NO_3...으로 return할 LIST에 넣어준다.    
	public ArrayList<Map<String, Object>> divColSizeForGrd(
															 ArrayList<Map<String, Object>> qryList,
																					int trnNoColSiz,
																					String trnNoColNm )
	{
		ArrayList<Map<String, Object>> resultList = new ArrayList<Map<String,Object>>();
		
		// 5칸 가로 뿌리기 시작
		Map<String, Object> tmpMap = null;
		
		for(int i = 0; i < qryList.size() ; i++)
		{	
			int modTrnNoColSiz = i % trnNoColSiz;
			
			// 1번쨰 컬럼일때 hash 공간할당
			if(modTrnNoColSiz == 0)
			{
				
				//마지막인경우 tmpMap을 resultList에 add한다.
				if(tmpMap != null)
				{
					resultList.add(tmpMap);
				}
				
				tmpMap = new HashMap<String, Object>();
			}
			
			// 컬럼 이름 조립
			// TRN_NO + _ + 숫자
			String num = String.valueOf( modTrnNoColSiz  + 1 );
			String trnNoColNmForGrid  = trnNoColNm + "_" + num;
			
			// 맵에 put
			tmpMap.put( trnNoColNmForGrid, qryList.get(i).get(trnNoColNm));
			
		}
		
		//null이 아닐떄만 add해준다
		if(tmpMap != null)
		{
			resultList.add(tmpMap);
		}
		
		return resultList;
	}
	
	
	/**
	 * @author "Changki.woo"
	 * @date 2014. 3. 11. 오후 3:50:55
	 * Method description : 열차번호선택(일반) SVC
	 * @param param
	 * @return Map
	 */
	public Map<String, ? > selectListGenTrnNo(Map<String, ?> param) {
		return param;
		
	}
}

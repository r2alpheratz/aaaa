/**
 * project : KORAIL_YZ
 * package : com.korail.yz.yf.ba
 * date : 2014. 4. 3.오후 1:53:25
 */
package com.korail.yz.yf.ba;

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
 * @author 나윤채
 * @date 2014. 4. 3. 오후 1:53:25
 * Class description : 기본 월별 요일별 실적-예측 승차인원 조회 / 차트 조회/ 저장
 */

@Service("com.korail.yz.yf.ba.YFBA001SVC")
public class YFBA001SVC {
	
	@Resource(name="commDAO")
	private CommDAO dao;

	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public  final Logger logger = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
	
	/*	YFBA001_M01 기본 월별 요일별 실적-예측 승차인원 조회	*/
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListMthSTGP(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> condMap = XframeControllerUtils.getParamDataSet(param, "dsCond");	
		ArrayList<Map<String, String>> dptArvList = (ArrayList<Map<String,String>>) param.get("dsStgpGp");	
		
		ArrayList<Map<String, Object>> resultList = new ArrayList<Map<String,Object>>();
		
		for (int i = 0; i < dptArvList.size(); i++) {
			Map<String, String> item =	dptArvList.get(i);
			item.put("TRN_CLSF_CD", condMap.get("TRN_CLSF_CD"));
			item.put("RUN_YMFrom", condMap.get("RUN_YMFrom"));
			item.put("RUN_YMTo", condMap.get("RUN_YMTo"));
			
			ArrayList<Map<String, Object>> dataSet = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.yf.ba.YFBA001QMDAO.selectListMthSTGP", item);
			for (Map<String, Object> map : dataSet) {
				resultList.add(map);
			}	
		}
		result.put("dsSrchPssr", resultList);	
	
		return result;
	}
	
	/*	기본 월별 요일별 모형 정보 조회	*/
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectExpModel(Map<String, ?>param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> condMap = XframeControllerUtils.getParamDataSet(param, "dsCond");
		
		Map<String, String> item = condMap;
		
		ArrayList<Map<String, Object>> resultList = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.yf.ba.YFBA001QMDAO.selectExpModel", item);
		
		result.put("dsSrchMd", resultList);
		return result;
	}
	
	/*	기본 월별 요일별 차트 조회	*/
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectExpChart(Map<String, ?>param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> condMap = XframeControllerUtils.getParamDataSet(param, "dsCond");
		
		Map<String, String> item = condMap;
		
		ArrayList<Map<String, Object>> resultList = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.yf.ba.YFBA001QMDAO.selectExpChart", item);
		
		ArrayList<Object> nYear = new ArrayList<Object>();
		ArrayList<Map<String, Object>> newList = new ArrayList<Map<String,Object>>();
		
		
		try {
			for (int i = 0; i < resultList.size(); i++) 
			{
				if( ! nYear.contains(resultList.get(i).get("FCST_YM")))
				{
					Object fcstYm = resultList.get(i).get("FCST_YM");
					nYear.add(fcstYm);
				}
			}//end for

			for (int j = 0; j < nYear.size(); j++) {
				Map<String, Object> inputData = new HashMap<String, Object>();
				inputData.put("FCST_YM", nYear.get(j));
				logger.debug(inputData.get("FCST_YM"));
				newList.add(j, inputData);
			}
			
			
			for (int j = 0; j < resultList.size(); j++) {

				for (int k = 0; k < nYear.size(); k++) {
					
					if(resultList.get(j).get("FCST_YM").equals(nYear.get(k)))
					{
						if (resultList.get(j).get("MDL_KOR_NM").equals("실적"))
						{
							newList.get(k).put("RECORD", resultList.get(j).get("WEIT_AVG_FCST_ABRD_PRNB"));
						}
						else if (resultList.get(j).get("MDL_KOR_NM").equals("ARIMA모형"))
						{
							newList.get(k).put("ARIMA", resultList.get(j).get("WEIT_AVG_FCST_ABRD_PRNB"));
						}
						else if (resultList.get(j).get("MDL_KOR_NM").equals("WINTERS 가법계절모형"))
						{
							newList.get(k).put("ADDITIVE", resultList.get(j).get("WEIT_AVG_FCST_ABRD_PRNB"));
						}
						else if (resultList.get(j).get("MDL_KOR_NM").equals("WINTERS 승법계절모형"))
						{
							newList.get(k).put("MULTIPLY", resultList.get(j).get("WEIT_AVG_FCST_ABRD_PRNB"));
						}
						else if (resultList.get(j).get("MDL_KOR_NM").equals("계절가변수를 이용한 회귀모형"))
						{
							newList.get(k).put("REGRESSION", resultList.get(j).get("WEIT_AVG_FCST_ABRD_PRNB"));
						}
						else if (resultList.get(j).get("MDL_KOR_NM").equals("전년동월대비 증가율모형"))
						{
							newList.get(k).put("INCREASE", resultList.get(j).get("WEIT_AVG_FCST_ABRD_PRNB"));
						}
					}
					
				}
			}
		} catch (Exception e) {
		
		}
			
		result.put("dsExpChart", newList);
		return result;
	}
	
	/*	기본 월별 요일별 모델정보 수정	*/
	@SuppressWarnings("unchecked")
	public Map<String, ?> updateMdDv(Map<String,?> param){

		Map<String, Object> result = new HashMap<String, Object>();
		ArrayList<Map<String, String>> messageList = new ArrayList<Map<String, String>>();

		/*	기본 그리드 (그리드 항목)	*/
		ArrayList<Map<String, String>> daspList = (ArrayList<Map<String, String>>) param.get("dsSrchMd");
		Map<String, String> condMap = XframeControllerUtils.getParamDataSet(param, "dsCond");	
		
		String userId = "Na";
		String TRN_CLSF_CD = condMap.get("TRN_CLSF_CD"); 
		
	    /*	기본 그리드에 표시된 요청처리 표시에 따라 Row 별로 검색하여 수정	*/
	    for (int i = 0; i < daspList.size(); i += 1)
	    {
	    	Map<String, String> item = daspList.get(i);				/*	기본 그리드의 모든 Row					*/
	    	
	    	item.put("CHG_USR_ID", userId);							/*	수정하는 사용자ID						*/
	    	item.put("TRN_CLSF_CD", TRN_CLSF_CD);					/*	열차 코드								*/
	       
		    dao.update("com.korail.yz.yf.ba.YFBA001QMDAO.updateMdDv", item);
	    }
	    
//		result.put("dsMessage", messageList);
		return result;
	}
}

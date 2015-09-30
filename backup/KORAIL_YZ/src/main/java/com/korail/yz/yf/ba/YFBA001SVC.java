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
	private transient CommDAO dao;

	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public static final Logger LOGGER = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
	
	/*	YFBA001_M01 기본 월별 요일별 실적-예측 승차인원 조회	*/
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListMthSTGP(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> condMap = XframeControllerUtils.getParamDataSet(param, "dsCond");	
		ArrayList<Map<String, String>> dptArvList = (ArrayList<Map<String,String>>) param.get("dsStgpGp");	

		
		dptArvList(condMap, dptArvList ,"DPT_STGP_CD", "ARV_STGP_CD", "DPT_STGP_LIST", false);
		dptArvList(condMap, dptArvList ,"ARV_STGP_CD", "DPT_STGP_CD", "ARV_STGP_LIST", false);
		dptArvList(condMap, dptArvList ,"DPT_STGP_CD", "ARV_STGP_CD", "DPT_ARV_STGP_LIST",true);
			
		ArrayList<Map<String, Object>> resultList = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.yf.ba.YFBA001QMDAO.selectListMthSTGP", condMap);
		result.put("dsSrchPssr", resultList);	

		result = sendMessage(resultList, result);//메시지 처리	
		return result;
	}
	
	/*	기본 월별 요일별 모형 정보 조회	*/
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectExpModel(Map<String, ?>param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> condMap = XframeControllerUtils.getParamDataSet(param, "dsCond");
		
		ArrayList<Map<String, Object>> resultList = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.yf.ba.YFBA001QMDAO.selectExpModel", condMap);
		result.put("dsSrchMd", resultList);
		
		result = sendMessage(resultList, result);//메시지 처리		
		return result;
	}
	
	/*	기본 월별 요일별 차트 조회	*/
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectExpChart(Map<String, ?>param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> condMap = XframeControllerUtils.getParamDataSet(param, "dsCond");
		
		ArrayList<Map<String, Object>> resultList = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.yf.ba.YFBA001QMDAO.selectExpChart", condMap);
			
		result.put("dsExpChart", resultList);
		
		result = sendMessage(resultList, result);		//메시지 처리
		return result;
	}
	
	/*	기본 월별 요일별 모델정보 수정	*/
	@SuppressWarnings("unchecked")
	public Map<String, ?> updateMdDv(Map<String,?> param){

		Map<String, Object> result = new HashMap<String, Object>();

		/*	기본 그리드 (그리드 항목)	*/
		ArrayList<Map<String, String>> daspList = (ArrayList<Map<String, String>>) param.get("dsSrchMd");
		Map<String, String> condMap = XframeControllerUtils.getParamDataSet(param, "dsCond");	
		
		String userId = param.get("USER_ID").toString();
		String TRN_CLSF_CD = condMap.get("TRN_CLSF_CD"); 
		
	    /*	기본 그리드에 표시된 요청처리 표시에 따라 Row 별로 검색하여 수정	*/
	    for (int i = 0; i < daspList.size(); i += 1)
	    {
	    	Map<String, String> item = daspList.get(i);				/*	기본 그리드의 모든 Row					*/
	    	
	    	item.put("CHG_USR_ID", userId);							/*	수정하는 사용자ID						*/
	    	item.put("TRN_CLSF_CD", TRN_CLSF_CD);					/*	열차 코드								*/
	       
		    dao.update("com.korail.yz.yf.ba.YFBA001QMDAO.updateMdDv", item);
	    }
	    
		return result;
	}
	
	/*	출발-도착역그룹 List 생성 메서드 */
	private void dptArvList(Map<String, String> Cond, ArrayList<Map<String, String>> dptArvList, String stgpCd1, String stgpCd2, String StgpList, boolean bln){
		
		int i = 0;
		
		if (bln)
		{
			String item = "('";
			while(i < dptArvList.size())
			{
				String j = String.valueOf(i);
				
				item = item.concat(dptArvList.get(i).get(stgpCd1) + "','" + dptArvList.get(i).get(stgpCd2) + "'),('");

				if("1".equals(String.valueOf(dptArvList.size())))
				{
					item = item.substring(0 , item.length()-5);
					break;
				}else if(j.equals(String.valueOf(dptArvList.size()-2)))
				{
					item = item.concat(dptArvList.get(i+1).get(stgpCd1) + "','" + dptArvList.get(i+1).get(stgpCd2));
					break;
				}
				i++;			
			}
			if("('".equals(item))
			{
				item = item.concat("','");
			}
			
			Cond.put(StgpList, item.concat("')"));
		}else
		{
			String item = "'";
			while(i < dptArvList.size())
			{
				String j = String.valueOf(i);
				
				item = item.concat(dptArvList.get(i).get(stgpCd1) + "','");
				if("1".equals(String.valueOf(dptArvList.size())))
				{
					item = item.substring(0 , item.length()-3);
					break;
				}else if(j.equals(String.valueOf(dptArvList.size()-2)))
				{
					item = item.concat(dptArvList.get(i+1).get(stgpCd1));
					break;
				}
				i++;
			}
			Cond.put(StgpList, item.concat("'"));			
		}
	}
	
	/*	메시지 처리 메서드*/
	private Map<String, Object> sendMessage(ArrayList<Map<String, Object>> resultList, Map<String, Object> result)
	{
		if(resultList.isEmpty()){
			XframeControllerUtils.setMessage("IZZ000004", result); //해당 조건의 자료가 존재하지 않습니다.
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result); //정상적으로 조회 되었습니다.
		}
		
		return result;
	}
}

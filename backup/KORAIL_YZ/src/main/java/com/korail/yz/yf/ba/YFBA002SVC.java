/**
 * project : KORAIL_YZ
 * package : com.korail.yz.yf.ba
 * date : 2014. 4. 22.오전 11:37:19
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
 * @date 2014. 4. 22. 오전 11:37:19
 * Class description : 기본 시간대별 실적-예측 승차인원 조회
 */

@Service("com.korail.yz.yf.ba.YFBA002SVC")
public class YFBA002SVC {
	
	@Resource(name="commDAO")
	private transient CommDAO dao;

	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public static final Logger LOGGER = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
	
	/*	YFBA002_S01 기본 월별 요일별 실적-예측 승차인원 조회	*/
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListTmSTGP(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> condMap = XframeControllerUtils.getParamDataSet(param, "dsCond");	
		ArrayList<Map<String, String>> dptArvList = (ArrayList<Map<String,String>>) param.get("dsStgpGp");	
		
		dptArvList(condMap, dptArvList ,"DPT_STGP_CD", "ARV_STGP_CD", "DPT_STGP_LIST", false);
		dptArvList(condMap, dptArvList ,"ARV_STGP_CD", "DPT_STGP_CD", "ARV_STGP_LIST", false);
		dptArvList(condMap, dptArvList ,"DPT_STGP_CD", "ARV_STGP_CD", "DPT_ARV_STGP_LIST",true);
			
		ArrayList<Map<String, Object>> resultList = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.yf.ba.YFBA002QMDAO.selectListTmSTGP", condMap);
		result.put("dsSrchPssr", resultList);	
		
		result = sendMessage(resultList, result);		//메시지 처리

		return result;
	}
	
	/*	시간지수 조회	*/
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListHrIdx(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> condMap = XframeControllerUtils.getParamDataSet(param, "dsCond");	
		
		ArrayList<Map<String, Object>> resultList = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.yf.ba.YFBA002QMDAO.selectListHrIdx", condMap);
		result.put("dsHrIdx", resultList);
		
		result = sendMessage(resultList, result);		//메시지 처리
		return result;
	}

	/*	기본 시간대별 승차인원 차트 - 요일별 조회	*/
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectOneDaySTGP(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> condMap = XframeControllerUtils.getParamDataSet(param, "dsDayCond");	
		
		ArrayList<Map<String, Object>>	resultList = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.yf.ba.YFBA002QMDAO.selectOneDaySTGP", condMap);

		result.put("dsDayCht", resultList);
		
		result = sendMessage(resultList, result);		//메시지 처리
		
		return result;
	}
	
	/*	기본 시간대별 승차인원 차트 - 시간대별 조회	*/
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectOneTmSTGP(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> condMap = XframeControllerUtils.getParamDataSet(param, "dsTimeCond");	
		
		
		ArrayList<Map<String, Object>>	resultList = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.yf.ba.YFBA002QMDAO.selectOneAllTmSTGP", condMap);
		
		result.put("dsTimeCht", resultList);
		
		result = sendMessage(resultList, result);		//메시지 처리
		
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

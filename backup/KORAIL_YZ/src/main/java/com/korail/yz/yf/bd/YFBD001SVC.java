/**
 * project : KORAIL_YZ
 * package : com.korail.yz.yf.bd
 * date : 2014. 6. 9.오전 10:22:17
 */
package com.korail.yz.yf.bd;

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
 * @date 2014. 6. 9. 오전 10:22:17
 * Class description : 연말연시 실적-예측 승차인원 조회
 */

@Service("com.korail.yz.yf.bd.YFBD001SVC")
public class YFBD001SVC {
	
	@Resource(name="commDAO")
	private transient CommDAO dao;

	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public static final Logger LOGGER = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
	
	/**
	 * @author 나윤채
	 * @date 2015. 1. 31. 오후 12:15:29
	 * Method description : 연말연시 요일별 예측 승차인원 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListEyDayPssr(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> condMap = new HashMap<String, String>();	
		ArrayList<Map<String, String>> dptArvList = (ArrayList<Map<String,String>>) param.get("dsStgpGp");	
		
		dptArvList(condMap, dptArvList ,"DPT_STGP_CD", "ARV_STGP_CD", "DPT_STGP_LIST", false);
		dptArvList(condMap, dptArvList ,"ARV_STGP_CD", "DPT_STGP_CD", "ARV_STGP_LIST", false);
		dptArvList(condMap, dptArvList ,"DPT_STGP_CD", "ARV_STGP_CD", "DPT_ARV_STGP_LIST",true);

		LOGGER.debug("itemDay : " +condMap.get("DPT_STGP_LIST"));

		ArrayList<Map<String, Object>> resultList = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.yf.bd.YFBD001QMDAO.selectListEyDayPssr",condMap);

		result.put("dsSrchPssr", resultList);
		
		result = sendMessage(resultList, resultList, result, 0);		//메시지 처리
		return result;
	}

	/**
	 * @author 나윤채
	 * @date 2015. 1. 31. 오후 12:19:57
	 * Method description : 연말연시 요일별 실적 승차인원 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListEyDayRst(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> condMap = new HashMap<String, String>();	
		ArrayList<Map<String, String>> dptArvList = (ArrayList<Map<String,String>>) param.get("dsStgpGp");	
		
		
		dptArvList(condMap, dptArvList ,"DPT_STGP_CD", "ARV_STGP_CD", "DPT_STGP_LIST", false);
		dptArvList(condMap, dptArvList ,"ARV_STGP_CD", "DPT_STGP_CD", "ARV_STGP_LIST", false);
		dptArvList(condMap, dptArvList ,"DPT_STGP_CD", "ARV_STGP_CD", "DPT_ARV_STGP_LIST",true);

		ArrayList<Map<String, Object>> resultList = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.yf.bd.YFBD001QMDAO.selectListEyDayRst",condMap);
		
		result.put("dsSrchPssr", resultList);
		
		result = sendMessage(resultList, resultList, result, 0);		//메시지 처리
		return result;
	}

	/**
	 * @author SDS
	 * @date 2015. 1. 31. 오후 12:20:19
	 * Method description : 연말연시 요일별 실적 차트 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListEyDayChart1(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();	
		Map<String, String> condMap = XframeControllerUtils.getParamDataSet(param, "dsCond");
		
		ArrayList<Map<String, Object>> resultList = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.yf.bd.YFBD001QMDAO.selectListEyDayChart1",condMap);
		
		result.put("dsDayCht", resultList);
		
		result = sendMessage(resultList, resultList, result, 0);		//메시지 처리
		return result;
	}
	
	/**
	 * @author SDS
	 * @date 2015. 1. 31. 오후 12:27:04
	 * Method description : 연말연시 요일별 예측 차트 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListEyDayChart2(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();	
		Map<String, String> condMap = XframeControllerUtils.getParamDataSet(param, "dsCond");
		
		ArrayList<Map<String, Object>> resultList = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.yf.bd.YFBD001QMDAO.selectListEyDayChart2",condMap);
		
		result.put("dsDayCht", resultList);
		
		result = sendMessage(resultList, resultList, result, 0);		//메시지 처리
		return result;
	}
	
	/**
	 * @author 나윤채
	 * @date 2015. 1. 31. 오후 12:27:21
	 * Method description : 연말연시 요일별 실적/예측 차트 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListEyDayChart3(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();	
		Map<String, String> condMap = XframeControllerUtils.getParamDataSet(param, "dsCond");
		
		ArrayList<Map<String, Object>> resultList = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.yf.bd.YFBD001QMDAO.selectListEyDayChart3",condMap);
		
		result.put("dsDayCht", resultList);
		
		result = sendMessage(resultList, resultList, result, 0);		//메시지 처리
		return result;
	}

	/*	메시지 처리 메서드*/
	private Map<String, Object> sendMessage(ArrayList<Map<String, Object>> resultList,ArrayList<Map<String, Object>> resultList2, Map<String, Object> result, int num)
	{
		if ("0".equals(String.valueOf(num)))
		{
			if(resultList.isEmpty()){
				XframeControllerUtils.setMessage("IZZ000004", result); //해당 조건의 자료가 존재하지 않습니다.
			}
			else
			{
				XframeControllerUtils.setMessage("IZZ000009", result); //정상적으로 조회 되었습니다.
			}
		} else if ("1".equals(String.valueOf(num)))
		{
			if(resultList.isEmpty() && resultList2.isEmpty()){
				XframeControllerUtils.setMessage("IZZ000004", result); //해당 조건의 자료가 존재하지 않습니다.
			}
			else
			{
				XframeControllerUtils.setMessage("IZZ000009", result); //정상적으로 조회 되었습니다.
			}
		
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
}

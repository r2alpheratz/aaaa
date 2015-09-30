/**
 * project : KORAIL_YZ
 * package : com.korail.yz.yf.bc
 * date : 2014. 5. 28.오후 5:28:03
 */
package com.korail.yz.yf.bc;

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
 * @date 2014. 5. 28. 오후 5:28:03
 * Class description : 하계 시간대별 실적-예측 승차인원 조회
 */

/**
 * @author SDS
 * @date 2015. 1. 31. 오후 12:21:00
 * 
 * Class description : 
 */
@Service("com.korail.yz.yf.bc.YFBC002SVC")
public class YFBC002SVC {
	
	@Resource(name="commDAO")
	private transient CommDAO dao;

	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public static final Logger LOGGER = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
	
	/**
	 * @author 나윤채
	 * @date 2015. 1. 31. 오후 12:04:34
	 * Method description : 하계 시간대별 승차인원 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListSmTime(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> condMap = XframeControllerUtils.getParamDataSet(param, "dsCond");
		ArrayList<Map<String, String>> dptArvList = (ArrayList<Map<String,String>>) param.get("dsStgpGp");	

		dptArvList(condMap, dptArvList ,"DPT_STGP_CD", "ARV_STGP_CD", "DPT_STGP_LIST", false);
		dptArvList(condMap, dptArvList ,"ARV_STGP_CD", "DPT_STGP_CD", "ARV_STGP_LIST", false);
		dptArvList(condMap, dptArvList ,"DPT_STGP_CD", "ARV_STGP_CD", "DPT_ARV_STGP_LIST",true);

		LOGGER.debug("itemDay : " +condMap.get("DAY_DV_CD"));

		ArrayList<Map<String, Object>> resultList = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.yf.bc.YFBC002QMDAO.selectListSmTime",condMap);

		result.put("dsSrchPssr", resultList);
		
		result = sendMessage(resultList, resultList, result, 0);		//메시지 처리
		return result;
	}
	
	/**
	 * @author 나윤채
	 * @date 2015. 1. 31. 오후 12:04:49
	 * Method description : 하계 시간대별 시간지수 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListSmHrIdx(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> condMap = XframeControllerUtils.getParamDataSet(param, "dsCond");
		
		ArrayList<Map<String, Object>> resultList = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.yf.bc.YFBC002QMDAO.selectListSmHrIdx",condMap);
		
		result.put("dsHrIdx", resultList);
		
		result = sendMessage(resultList, resultList, result, 0);		//메시지 처리
		return result;
	}

	
	/**
	 * @author 나윤채
	 * @date 2015. 1. 31. 오후 12:05:36
	 * Method description : 하계 시간대별 승차인원 실적 차트 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectSmTmRst(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> condMap = XframeControllerUtils.getParamDataSet(param, "dsCond");
		ArrayList<Map<String, Object>> resultList = new ArrayList<Map<String,Object>>();
		
		if("WK_DAY".equals(condMap.get("FLAG")))
		{
			resultList = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.yf.bc.YFBC002QMDAO.selectSmWkRst",condMap);
		}else if("TIME".equals(condMap.get("FLAG")))
		{
			resultList = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.yf.bc.YFBC002QMDAO.selectSmTmRst",condMap);			
		}
		result.put("dsRstCht", resultList);
		
		result = sendMessage(resultList, resultList, result, 0);		//메시지 처리
		return result;
	}

	
	/**
	 * @author 나윤채
	 * @date 2015. 1. 31. 오후 12:05:51
	 * Method description : 하계 시간대별 승차인원 예측 차트 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectSmTmExp(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> condMap = XframeControllerUtils.getParamDataSet(param, "dsCond");
		ArrayList<Map<String, Object>> resultList = new ArrayList<Map<String,Object>>();
		
		if("WK_DAY".equals(condMap.get("FLAG")))
		{
			resultList = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.yf.bc.YFBC002QMDAO.selectSmWkExp",condMap);
		}else if("TIME".equals(condMap.get("FLAG")))
		{
			resultList = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.yf.bc.YFBC002QMDAO.selectSmTmExp",condMap);			
		}
		
		result.put("dsExpCht", resultList);
		
		result = sendMessage(resultList, resultList, result, 0);		//메시지 처리
		return result;
	}


	/**
	 * @author 나윤채
	 * @date 2015. 1. 31. 오후 12:21:02
	 * Method description : 하계 시간대별 승차인원 실적-예측 차트 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectSmTmExpRst(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> condMap = XframeControllerUtils.getParamDataSet(param, "dsCond");
		ArrayList<Map<String, Object>> resultList = new ArrayList<Map<String,Object>>();
		
		if("WK_DAY".equals(condMap.get("FLAG")))
		{
			resultList = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.yf.bc.YFBC002QMDAO.selectSmWkExpRst",condMap);
		}else if("TIME".equals(condMap.get("FLAG")))
		{
			resultList = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.yf.bc.YFBC002QMDAO.selectSmTmExpRst",condMap);			
		}
		
		result.put("dsRstExpCht", resultList);
		
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


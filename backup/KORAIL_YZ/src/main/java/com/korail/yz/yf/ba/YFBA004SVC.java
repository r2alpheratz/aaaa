/**
 * project : KORAIL_YZ
 * package : com.korail.yz.yf.ba
 * date : 2014. 5. 6.오후 4:43:43
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
 * @date 2014. 5. 6. 오후 4:43:43
 * Class description : 기본 DSP별 예약-취소 예측인원 조회
 */

@Service("com.korail.yz.yf.ba.YFBA004SVC")
public class YFBA004SVC {

	@Resource(name="commDAO")
	private transient CommDAO dao;

	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public static final Logger LOGGER = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
	
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListDspPssr(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> condMap = XframeControllerUtils.getParamDataSet(param, "dsPssrCond1");	
		ArrayList<Map<String, String>> dptArvList = (ArrayList<Map<String,String>>) param.get("dsGrdSelLst");	
		
		ArrayList<Map<String, Object>> resultList = new ArrayList<Map<String,Object>>();
		
		dptArvList(condMap, dptArvList ,"DPT_STGP_CD", "ARV_STGP_CD", "DPT_STGP_LIST", false);
		dptArvList(condMap, dptArvList ,"ARV_STGP_CD", "DPT_STGP_CD", "ARV_STGP_LIST", false);
		dptArvList(condMap, dptArvList ,"DPT_STGP_CD", "ARV_STGP_CD", "DPT_ARV_STGP_LIST",true);
		
		int runYmSt = Integer.valueOf(condMap.get("RUN_YM_ST"));
		int runYmCls = Integer.valueOf(condMap.get("RUN_YM_CLS"));
		
		for(int i = runYmCls; i>=runYmSt; i--)
		{
			condMap.put("RUN_YM", String.valueOf(i));
			ArrayList<Map<String, Object>> resultList1 = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.yf.ba.YFBA004QMDAO.selectListDspFcstAchvDt",condMap);
						
			if( !(resultList1.isEmpty() || "".equals(resultList1.get(0).get("FCST_ACHV_DT"))))
			{
				condMap.put("FCST_ACHV_DT", String.valueOf(resultList1.get(0).get("FCST_ACHV_DT")));	
				resultList = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.yf.ba.YFBA004QMDAO.selectListDspPssr",condMap);
				break;
			}
			
			if("01".equals(String.valueOf(i).substring(4, 6)))
			{
				i = i - 100 + 12;
			}
		}
		
		result.put("dsGrdTrnPssr", resultList);		
		result = sendMessage(resultList, resultList, result, 0);		//메시지 처리
		
		return result;
	}
	
	/* 일자별 실적 예약-취소 차트 목록 조회 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListDayChart(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> condMap = XframeControllerUtils.getParamDataSet(param, "dsDayCond");	
		
		ArrayList<Map<String, Object>> resultList = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.yf.ba.YFBA004QMDAO.selectListDspRcdRsv",condMap);
		ArrayList<Map<String, Object>> resultList2 = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.yf.ba.YFBA004QMDAO.selectListDspRcdCnc",condMap);
		
		resultList = sortingChart( "RSV_DPT_BF_DNO", "RSV_PRNB", resultList );
		resultList2 = sortingChart( "CNC_DPT_BF_DNO", "CNC_PRNB", resultList2 );
		
		result.put("dsDayChart1", resultList);
		result.put("dsDayChart2", resultList2);
		
		result = sendMessage(resultList, resultList2, result, 1);		//메시지 처리
		
		return result;
	}
	
	/* 일자별 예측 예약-취소 차트 목록 조회 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListFcstDayChart(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> condMap = XframeControllerUtils.getParamDataSet(param, "dsDayCond");	
		
		ArrayList<Map<String, Object>> resultList = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.yf.ba.YFBA004QMDAO.selectListDspFcstRsv",condMap);
		ArrayList<Map<String, Object>> resultList2 = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.yf.ba.YFBA004QMDAO.selectListDspFcstCnc",condMap);
		
		resultList = sortingChart( "RSV_DPT_BF_DNO", "RSV_PRNB", resultList );
		resultList2 = sortingChart( "CNC_DPT_BF_DNO", "CNC_PRNB", resultList2 );
		
		result.put("dsDayChart1", resultList);
		result.put("dsDayChart2", resultList2);
		
		result = sendMessage(resultList, resultList2, result, 1);		//메시지 처리
		
		return result;
	}
	
	/*	기본 DSP별 예약-취소 실적인원 조회	*/
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListDspRcd(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> condMap = XframeControllerUtils.getParamDataSet(param, "dsPssrCond1");	
		
		ArrayList<Map<String, Object>> resultList = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.yf.ba.YFBA004QMDAO.selectListDspRcd", condMap);
		result.put("dsGrdTrnRcd", resultList);
		
		result = sendMessage(resultList, resultList, result, 0);		//메시지 처리
		
		return result;
	}

	/*	기본 DSP별 예약-취소 실적인원 조회	*/
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListDspRate(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> condMap = XframeControllerUtils.getParamDataSet(param, "dsPssrCond1");	
		
		ArrayList<Map<String, Object>> resultList = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.yf.ba.YFBA004QMDAO.selectListDspRate", condMap);
		ArrayList<Map<String, Object>> resultRSVList = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.yf.ba.YFBA004QMDAO.selectListDspRSVRate", condMap);
		ArrayList<Map<String, Object>> resultCNCList = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.yf.ba.YFBA004QMDAO.selectListDspCNCRate", condMap);
		
		resultRSVList= sortingChart( "RSV_DPT_BF_DNO", "RSV_IDX_SMTH_ACM_PCT", resultRSVList );
		resultCNCList = sortingChart( "CNC_DPT_BF_DNO", "CNC_IDX_SMTH_ACM_PCT", resultCNCList );
		
		result.put("dsGrdTrnRate", resultList);
		result.put("dsDayChart1", resultRSVList);
		result.put("dsDayChart2", resultCNCList);
		
		result = sendMessage(resultList, resultList, result, 0);		//메시지 처리
		
		return result;
	}
	
	/*	예약-취소 리스트 re-sorting */
	private ArrayList<Map<String, Object>> sortingChart( String sortingNo, String sortingData, ArrayList<Map<String, Object>> resultList ){
		for (int i = 0; i < resultList.size()-1; i++) 
		{
			if (resultList.get(i).get(sortingNo).equals(resultList.get(i+1).get(sortingNo)))
			{
				resultList.remove(i+1);
			    if("0".equals(String.valueOf(i)))
			    {
			    	i = -1;
			    }else
			    {	
			    	i--;
			    }
			}//end if
		}//end for	
		
		for (int j = 0; j < resultList.size()-1; j++)
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
				double num = sData - Math.ceil((sData - nData) / (next1 - start1 + 1));
				order.put(sortingNo, j+1);
				order.put(sortingData, num);
				resultList.add(j+1, order);
			}//end if
		}//end for		
	return resultList;	
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

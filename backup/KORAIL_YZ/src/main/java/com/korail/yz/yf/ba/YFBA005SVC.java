/**
 * project : KORAIL_YZ
 * package : com.korail.yz.yf.ba
 * date : 2014. 5. 12.오후 7:54:00
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
 * @date 2014. 5. 12. 오후 7:54:00
 * Class description :  임시열차 DSP별 예약-취소 예측인원 조회 화면 및 차트
 */

@Service("com.korail.yz.yf.ba.YFBA005SVC")
public class YFBA005SVC {
	
	@Resource(name="commDAO")
	private transient CommDAO dao;

	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public static final Logger LOGGER = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
	
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListTempDsp(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> condMap = XframeControllerUtils.getParamDataSet(param, "dsPssrCond1");	
		ArrayList<Map<String, String>> dptArvList = (ArrayList<Map<String,String>>) param.get("dsGrdSelLst");	
		
		dptArvList(condMap, dptArvList ,"DPT_STGP_CD", "ARV_STGP_CD", "DPT_STGP_LIST", false);
		dptArvList(condMap, dptArvList ,"ARV_STGP_CD", "DPT_STGP_CD", "ARV_STGP_LIST", false);
		dptArvList(condMap, dptArvList ,"DPT_STGP_CD", "ARV_STGP_CD", "DPT_ARV_STGP_LIST",true);
		//condMap.put("FLAG", "");
		    
//		ArrayList<Map<String, Object>> resultList1 = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.yf.ba.YFBA005QMDAO.selectListTempDspFcstAchvDt",condMap);
//
//		운행일자 관계없이 가장 최근 수행일자만 조회되도록 설정되어 있음
//		String fcstDt = "'";
//		
//		for (int i = 0; i < resultList1.size() - 1; i ++)
//		{	
//			fcstDt = fcstDt.concat(String.valueOf(resultList1.get(i).get("FCST_ACHV_DT"))).concat("','");	
//		}
//		
//			fcstDt = fcstDt.concat(String.valueOf(resultList1.get(resultList1.size()-1).get("FCST_ACHV_DT"))).concat("'");
//			
//		
//		condMap.put("FCST_ACHV_DT", String.valueOf(resultList1.get(0).get("FCST_ACHV_DT")));
//		
//		if (!resultList1.isEmpty())
//		{
//		}

		ArrayList<Map<String, Object>> resultList = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.yf.ba.YFBA005QMDAO.selectListTempDsp",condMap);
		result.put("dsGrdTmpDsp", resultList);

		//메시지 처리
		if(resultList.isEmpty()){
			XframeControllerUtils.setMessage("IZZ000004", result); //해당 조건의 자료가 존재하지 않습니다.
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result); //정상적으로 조회 되었습니다.
		}

		return result;
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListTempDayChart(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> condMap = XframeControllerUtils.getParamDataSet(param, "dsDayCond");	

		ArrayList<Map<String, Object>> resultList = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.yf.ba.YFBA005QMDAO.selectListTempRsvChart",condMap);
		ArrayList<Map<String, Object>> resultList2 = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.yf.ba.YFBA005QMDAO.selectListTempCncChart",condMap);
		
		resultList = sortingChart( "RSV_DPT_BF_DNO", "RSV_PSNO", resultList );
		resultList2 = sortingChart( "CNC_DPT_BF_DNO", "CNC_PSNO", resultList2 );
		
		result.put("dsDayChart1", resultList);
		result.put("dsDayChart2", resultList2);
		
		
		//메시지 처리
		if(resultList.isEmpty()){
			XframeControllerUtils.setMessage("IZZ000004", result); //해당 조건의 자료가 존재하지 않습니다.
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result); //정상적으로 조회 되었습니다.
		}
		
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

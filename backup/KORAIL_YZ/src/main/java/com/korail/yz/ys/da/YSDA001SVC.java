/**
 * project : KORAIL_YZ
 * package : com.korail.yz.ys.da
 * date : 2014. 5. 27.오전 9:13:07
 */
package com.korail.yz.ys.da;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Service;

import com.korail.tz.sa.ISA0001SVC;
import com.korail.tz.sa.XframeControllerUtils;

import cosmos.comm.dao.CommDAO;

/**
 * @author 한현섭
 * @date 2014. 5. 27. 오전 9:13:07
 * Class description : 할인율 조견표 관리를 위한 Service 클래스
 */
@Service("com.korail.yz.ys.da.YSDA001SVC")
public class YSDA001SVC {


	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public  final Logger LOGGER = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
 
	
	/**
	 * @author 한현섭
	 * @date 2014. 5. 27. 오전 9:14:38
	 * Method description : 할인율 조견표를 조회한다.
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?>  selectListDcntRtLst (Map<String, ?> param){
	
 		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();

		/* DAO - 쿼리 실행 후 결과 획득*/
		List<Map<String, Object>> resultList
		= (List<Map<String, Object>>) dao.list("com.korail.yz.ys.da.YSDA001QMDAO.selectListDcntRtLst", null);

		//error 메시지 날리기
		if(resultList.isEmpty()){
			XframeControllerUtils.setMessage("IZZ000004", result);
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result);
		}
		result.put("dsGrdListResult", resultList);
		return result;
	}
	
	
	/**
	 * @author 한현섭
	 * @date 2014. 6. 5. 오후 3:24:39
	 * Method description : 입력/수정/삭제된 할인율 조견표 항목들을 처리한다.
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?>  updateListDcntRtLst(Map<String, ?> param){
		
 		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();

		/* 입력 오브젝트 */
		List<Map<String, String>> inputDataArray = (List<Map<String, String>>) param.get("dsCudCond");
		LOGGER.debug("inputDateSet--->"+inputDataArray.toString());
		
		String userId = XframeControllerUtils.getUserId(param);		
		
		/* 입력/수정/삭제에 따라 SQL 파라미터로 입력될 수 있게끔 변환된 Map을 저장하는 Array들을 생성한다. */
		List<Map<String, String>> insertSqlParamArray = new ArrayList<Map<String,String>>();
		List<Map<String, String>> updateSqlParamArray = new ArrayList<Map<String,String>>();
		List<Map<String, String>> deleteSqlParamArray = new ArrayList<Map<String,String>>();
				
		/* 들어온 inputDataArray의 원소들을 DB에 입력될 수 있는 형태로 변환한다.*/
		for (Map<String, ?> inputDataSet : inputDataArray)
		{
			String stat = (String) inputDataSet.get("STAT");
			if("I".equals(stat)){
				
				Object[] keyArray =   inputDataSet.keySet().toArray();
				String sAbrdRt = (String) inputDataSet.get("ABRD_RT");
				
				for(int i = 0 ; i < keyArray.length ; i++)
				{
					String key = (String) keyArray[i];
										
					if (key.indexOf("AB_") != -1)
					{
						Map<String, String> insertDataSet = new HashMap<String, String>();
						
						float stUtlDst = Float.parseFloat(key.replace("AB_", ""));
						float clsUtlDst = (float) ((stUtlDst < 400) ? stUtlDst + 99.9 : 999.9);
						String value = (String) inputDataSet.get(key);
						
						insertDataSet.put("ABRD_RT", sAbrdRt);
						insertDataSet.put("ST_UTL_DST", String.valueOf((int)stUtlDst));
						insertDataSet.put("CLS_UTL_DST", String.valueOf(clsUtlDst));
						insertDataSet.put("PRC_DCNT_RT", value);
						insertDataSet.put("REG_USR_ID", userId);
						
						insertSqlParamArray.add(insertDataSet);
					}
					
				}
			}else if("U".equals(stat)){
				Object[] keyArray =   inputDataSet.keySet().toArray();
				String sAbrdRt = (String) inputDataSet.get("ABRD_RT");
				String sOrgAbrdRt = (String) inputDataSet.get("ORG_ABRD_RT");
				for(int i = 0 ; i < keyArray.length ; i++)
				{
					String key = (String) keyArray[i];
										
					if (key.indexOf("AB_") != -1)
					{
						Map<String, String> updateDataSet = new HashMap<String, String>();
						
						float stUtlDst = Float.parseFloat(key.replace("AB_", ""));
						float clsUtlDst = (float) ((stUtlDst < 400) ? stUtlDst + 99.9 : 999.9);
						String value = (String) inputDataSet.get(key);
						
						updateDataSet.put("ABRD_RT", sAbrdRt);
						updateDataSet.put("ORG_ABRD_RT", sOrgAbrdRt);
						updateDataSet.put("ST_UTL_DST", String.valueOf((int)stUtlDst));
						updateDataSet.put("CLS_UTL_DST", String.valueOf(clsUtlDst));
						updateDataSet.put("PRC_DCNT_RT", value);
						updateDataSet.put("CHG_USR_ID", userId);
						
						updateSqlParamArray.add(updateDataSet);
					}
				}
			}else if("D".equals(stat)){
				String sAbrdRt = (String) inputDataSet.get("ABRD_RT");
				Map<String, String> deleteDataSet = new HashMap<String, String>();				
				deleteDataSet.put("ABRD_RT", sAbrdRt);
				deleteSqlParamArray.add(deleteDataSet);
			}
		}
				
		/* DAO - For Loop으로 각 행을 입력/수정/ 삭제 처리하는 쿼리 실행- PK문제로 수정과 삭제를 먼저 실행하고 입력을 실행*/
		String errSite = "";
		try{
			
			//삭제
			for (Map<String, ?> paramSet : deleteSqlParamArray)
			{
				errSite = "delete";
				dao.delete("com.korail.yz.ys.da.YSDA001QMDAO.deleteDcntRt", paramSet);
			}
			//수정
			for (Map<String, ?> paramSet : updateSqlParamArray)
			{
				errSite = "modify";
				dao.update("com.korail.yz.ys.da.YSDA001QMDAO.updateDcntRt", paramSet);
			}
			//입력
			for (Map<String, ?> paramSet : insertSqlParamArray)
			{
				errSite = "insert";
				dao.insert("com.korail.yz.ys.da.YSDA001QMDAO.insertDcntRt", paramSet);
			}
		}
		catch(Exception e)
		{
			List<Map<String, String>> errList = new ArrayList<Map<String, String>>();
			Map<String, String> errMap = new HashMap<String, String>();
			errMap.put("ERR_MSG", errSite);
			errList.add(errMap);
			result.put("dsError", errList);
			LOGGER.debug("Error Process : "+errSite);
			XframeControllerUtils.setMessage("EZZ000018", result);
			return result;
		}
		
		XframeControllerUtils.setMessage("IZZ000013", result);
		return result;
	}
	

}

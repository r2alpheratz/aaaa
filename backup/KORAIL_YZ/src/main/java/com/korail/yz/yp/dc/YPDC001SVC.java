/**
 * project : KORAIL_YZ
 * package : com.korail.yz.yp.dc
 * date : 2014. 8. 10.오후 8:21:02
 */
package com.korail.yz.yp.dc;

import java.math.BigDecimal;
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
import cosmos.comm.exception.CosmosRuntimeException;

/**
 * @author 나윤채
 * @date 2014. 8. 10. 오후 8:21:02
 * Class description : 최저할당정보 관리
 */

@Service("com.korail.yz.yp.dc.YPDC001SVC")
public class YPDC001SVC {
	@Resource(name="commDAO")
	private transient CommDAO dao;

	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public static final Logger LOGGER = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);

	/**
	 * @author SDS
	 * @date 2015. 1. 31. 오후 5:01:26
	 * Method description : 최저할당정보 관리목록 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListLwstAlcInfo(Map<String, ?>param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> condMap = XframeControllerUtils.getParamDataSet(param, "dsCond");

		ArrayList<Map<String, Object>> resultList = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.yp.dc.YPDC001QMDAO.selectListLwstAlcInfo", condMap);
		result.put("dsListLwstAlcInfo", resultList);
		
		result = sendMessage(resultList, result);//메시지 처리		
		return result;
	}
	
	/**
	 * @author 나윤채
	 * @date 2015. 1. 31. 오후 5:02:28
	 * Method description : 저장, 수정, 삭제
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "unchecked" })
	public Map<String, ?> updateLwstAlcInfo(Map<String, ?> param) {		

		Map<String, Object> result = new HashMap<String, Object>();

		LOGGER.debug("param ==> "+param);
		
		ArrayList<Map<String, String>> bsList = (ArrayList<Map<String, String>>) param.get("dsAfterList");
		ArrayList<Map<String, String>> prevList = (ArrayList<Map<String, String>>) param.get("dsPrevList");
		String userId = String.valueOf(param.get("USER_ID"));
		
		int insertCnt = 0;
		int updateCnt = 0;
		int deleteCnt = 0;
		
		LOGGER.debug("bsList 사이즈:::::::::::::::"+bsList.size());
	    for( int i = 0; i < bsList.size() ; i++ )
	    {
	    	Map<String, String> item = bsList.get(i);
	    	
	    	LOGGER.debug("bsList["+i+"]번째 ROW =====>"+item);
	    	item.put("USER_ID", userId);
	    	
	        if(item.get("DMN_PRS_DV_CD").equals("I"))  /*요청처리구분코드가 I : insert*/
	        {
	        	/* [SQL] 기존 등록된 고객승급 기본정보예외 내역이 있는지 확인. */
	        	HashMap<String, BigDecimal> ttrnCntMap = (HashMap<String, BigDecimal>) dao.select("com.korail.yz.yp.dc.YPDC001QMDAO.selectLwstAlcInfoExctCnt", item);
	        	if(ttrnCntMap.get("QRY_CNT").intValue() > 0)
		    	{
	        		throw new CosmosRuntimeException("WZZ000013", null); 
					//이미 등록된 내역이 존재합니다.  입력값을 확인하십시오. 
		    	}
	        	insertCnt += dao.insert("com.korail.yz.yp.dc.YPDC001QMDAO.insertLwstAlcInfo", item);
	        }
	        else if(item.get("DMN_PRS_DV_CD").equals("U"))  /*요청처리구분코드가 U : update*/
	        {
	        	/* [SQL] 기존 등록된 고객승급 기본정보예외 내역이 있는지 확인. */
	        	HashMap<String, BigDecimal> ttrnCntMap = (HashMap<String, BigDecimal>) dao.select("com.korail.yz.yp.dc.YPDC001QMDAO.selectLwstAlcInfoExctCnt", item);
	        	if(ttrnCntMap.get("QRY_CNT").intValue() > 0)
		    	{
	        		throw new CosmosRuntimeException("WZZ000013", null); 
					//이미 등록된 내역이 존재합니다.  입력값을 확인하십시오. 
		    	}
	        	item.putAll(prevList.get(i));
	        	updateCnt += dao.update("com.korail.yz.yp.dc.YPDC001QMDAO.updateLwstAlcInfo", item);	
	        }
	        else if(item.get("DMN_PRS_DV_CD").equals("D"))  /*요청처리구분코드가 D : delete*/
	        {
	        	item.putAll(prevList.get(i));
	        	deleteCnt += dao.delete("com.korail.yz.yp.dc.YPDC001QMDAO.deleteLwstAlcInfo", item);
	        }
	    }
	    LOGGER.debug("입력 ["+insertCnt+"] 건, 수정 ["+updateCnt+"] 건, 삭제 ["+deleteCnt+"] 건 수행하였습니다.");
	    
		//메시지 처리
  		if(insertCnt < 1 && updateCnt < 1 && deleteCnt < 1){
  			XframeControllerUtils.setMessage("WYZ000007", result); //해당 자료를 수정할수 없습니다.	수정자료를 확인하여 주십시오.
  		}
  		else
  		{
  			XframeControllerUtils.setMessage("IZZ000013", result); //정상적으로 저장 되었습니다.
  		}
  		
		return result;
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

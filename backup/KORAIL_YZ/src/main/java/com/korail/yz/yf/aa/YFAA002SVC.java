/**
 * project : KORAIL_YZ
 * package : com.korail.yf.aa
 * date : 2014. 3. 25.오후 1:22:20
 */
package com.korail.yz.yf.aa;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Service;

import com.korail.tz.sa.ISA0001SVC;

import cosmos.comm.dao.CommDAO;
/**
 * @author 나윤채
 * @date 2014. 3. 25. 오후 1:22:20
 * Class description : DSP별로 기준값과 긴급, 주의, 보통별 비정상 열차 판단 비율 조회를 위한 
 *                     DSP별비정상판단비율조회 서비스클래스
 */

@Service("com.korail.yz.yf.aa.YFAA002SVC")
public class YFAA002SVC {
	
	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;

	public  static final Logger LOGGER = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
	
	
	/**
	 * @author 나윤채
	 * @date 2015. 1. 31. 오후 3:10:14
	 * Method description : DSP별 비정상판단비율 목록
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String,?> selectListNonNmlPct(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		/*	DSP 목록(list) sql 실행	*/
		ArrayList<Map<String,Object>> resultList = (ArrayList<Map<String,Object>>) dao.list("com.korail.yz.yf.aa.YFAA002QMDAO.selectListNonNmlPct", null);
		
		result.put("dsList", resultList);
		return result;
	}
	
	/**
	 * @author 나윤채
	 * @date 2015. 1. 31. 오후 3:10:27
	 * Method description : DSP별 비정상판단 비율 수정 (update)
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> updateNonNmlPct(Map<String,?> param){

		Map<String, Object> result = new HashMap<String, Object>();
		ArrayList<Map<String, String>> messageList = new ArrayList<Map<String, String>>();
	//	HashMap<String, String> msgMap = new HashMap<String, String>();

		LOGGER.debug("param ==> "+param);
		
		/*	기본 그리드 (그리드 항목)	*/
		ArrayList<Map<String, String>> daspList = (ArrayList<Map<String, String>>) param.get("dsList");
		
		String userId = param.get("USER_ID").toString();
		
		LOGGER.debug("daspList 사이즈:::::::::::::::"+daspList.size());
	    
	    /*	기본 그리드에 표시된 요청처리 표시에 따라 Row 별로 검색하여 수정	*/
	    for (int i = 0; i < daspList.size(); i += 1)
	    {
	    	Map<String, String> item = daspList.get(i);				/*	기본 그리드의 모든 Row					*/
	    	
	    	item.put("USER_ID", userId);							/*	수정하는 사용자ID						*/
	    	LOGGER.debug("daspList["+i+"]번째 ROW =====>"+item);
	    	
	        if (item.get("DMN_PRS_DV_CD").equals("U"))				/*요청처리구분코드가 U(update)인지 판별		*/
	        {
	        	/* DSP 목록 업데이트 sql 실행	*/
		    	dao.update("com.korail.yz.yf.aa.YFAA002QMDAO.updateNonNmlPct", item);
	        }
	        else
	        {	
	        	/*	update 대상이 아닌 경우 수정 없이 for문 지속*/
	        	continue;
	        }
	    }
	    
		result.put("dsMessage", messageList);
		return result;
	}
}

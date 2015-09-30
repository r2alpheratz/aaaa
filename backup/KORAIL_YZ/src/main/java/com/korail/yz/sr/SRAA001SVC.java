/**
 * project : KORAIL_YZ
 * package : com.korail.yz.sr
 * date : 2015. 1. 14.오후 3:45:51
 */
package com.korail.yz.sr;

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
 * @date 2015. 1. 14. 오후 3:45:51
 * Class description : SR목록조회
 */

@Service("com.korail.yz.sr.SRAA001SVC")
public class SRAA001SVC {
	
	@Resource(name="commDAO")
	private transient CommDAO dao;

	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public static final Logger LOGGER = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
	

	/**
	 * @author 나윤채
	 * @date 2015. 1. 16. 오후 3:35:58
	 * Method description : SR 업무구분코드 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListDutyDvCd(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();

		LOGGER.debug("param ==> "+param);

		ArrayList<Map<String, Object>> resultList = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.sr.SRAA001QMDAO.selectListDutyDvCd", null);			
		
		result.put("dsDutyDvCd", resultList);
		result = sendMessage(resultList, resultList, result, 0);		//메시지 처리
		
		return result;
	}
	

	/**
	 * @author 나윤채
	 * @date 2015. 1. 16. 오후 3:37:32
	 * Method description : SR 목록 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListSR(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> condMap = XframeControllerUtils.getParamDataSet(param, "dsCond");
		
		LOGGER.debug("param ==> "+param);
		ArrayList<Map<String, Object>> resultList = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.sr.SRAA001QMDAO.selectListSR", condMap);			
		
		result.put("dsListAppend", resultList);
		result = sendMessage(resultList, resultList, result, 0);		//메시지 처리
		
		return result;
	}
	
	/**
	 * @author 나윤채
	 * @date 2015. 1. 16. 오후 3:37:32
	 * Method description : SR 목록 총건수 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListCntSR(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> condMap = XframeControllerUtils.getParamDataSet(param, "dsCond");
		
		LOGGER.debug("param ==> "+param);
		ArrayList<Map<String, Object>> resultList = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.sr.SRAA001QMDAO.selectListCntSR", condMap);			
		
		result.put("dsTot", resultList);
		result = sendMessage(resultList, resultList, result, 0);		//메시지 처리
		
		return result;
	}

	/*	메시지 처리 메서드*/
	private Map<String, Object> sendMessage(ArrayList<Map<String, Object>> resultList,ArrayList<Map<String, Object>> resultList2, Map<String, Object> result, int num)
	{
		if (num == 0)
		{
			if(resultList.isEmpty()){
				XframeControllerUtils.setMessage("IZZ000004", result); //해당 조건의 자료가 존재하지 않습니다.
			}
			else
			{
				XframeControllerUtils.setMessage("IZZ000009", result); //정상적으로 조회 되었습니다.
			}
		} else if (num == 1)
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

}

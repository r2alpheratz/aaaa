/**
 * project : KORAIL_YZ
 * package : com.korail.yz.yp.ab
 * date : 2014. 7. 28.오전 10:18:29
 */
package com.korail.yz.yp.ab;

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
 * @date 2014. 7. 28. 오전 10:18:29
 * Class description :  OD별 할당결과 DCP별 조회
 */

@Service("com.korail.yz.yp.ab.YPAB003SVC")
public class YPAB003SVC {
	
	@Resource(name="commDAO")
	private transient CommDAO dao;

	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public static final Logger LOGGER = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
	
	/**
	 * @author SDS
	 * @date 2015. 1. 31. 오후 4:37:22
	 * Method description : 출발역 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListDptTrnNo(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> condMap = XframeControllerUtils.getParamDataSet(param, "dsCond");

		LOGGER.debug("param ==> "+param);

		ArrayList<Map<String, Object>> resultList = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.yp.ab.YPAB003QMDAO.selectListDptTrnNo",condMap);			
		
		result.put("dsDptStnList", resultList);
		result = sendMessage(resultList, resultList, result, 0);		//메시지 처리
		
		return result;
	}

	/**
	 * @author 나윤채
	 * @date 2015. 1. 31. 오후 4:38:00
	 * Method description : OD별 할당결과 DCP별 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListODAlcDCP(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> condMap = XframeControllerUtils.getParamDataSet(param, "dsCond");

		LOGGER.debug("param ==> "+param);

		ArrayList<Map<String, Object>> resultList = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.yp.ab.YPAB003QMDAO.selectListODAlcDCP",condMap);			
		
		result.put("dsListODAlcDCP", resultList);
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


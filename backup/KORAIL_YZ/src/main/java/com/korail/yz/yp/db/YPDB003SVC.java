/**
 * project : KORAIL_YZ
 * package : com.korail.yz.yp.db
 * date : 2014. 8. 19.오전 11:32:40
 */
package com.korail.yz.yp.db;

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
 * @date 2014. 8. 19. 오전 11:32:40
 * Class description : 최적화 시뮬레이션 결과 조회
 */

@Service("com.korail.yz.yp.db.YPDB003SVC")
public class YPDB003SVC {
	
	@Resource(name="commDAO")
	private transient CommDAO dao;

	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public static final Logger LOGGER = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
	
	/*	 최적화 시뮬레이션 결과 조회 (수행이력) 	*/
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListSimlAchvStt(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> condMap = XframeControllerUtils.getParamDataSet(param, "dsCond");

		LOGGER.debug("param ==> "+param);

		ArrayList<Map<String, Object>> resultList = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.yp.db.YPDB003QMDAO.selectListSimlAchvStt",condMap);			
		
		result.put("dsList1", resultList);
		result = sendMessage(resultList, resultList, result, 0);		//메시지 처리
		
		return result;
	}

	/**
	 * @author 나윤채
	 * @date 2015. 1. 31. 오후 4:59:39
	 * Method description : 최적화 시뮬레이션 결과 조회 (해지시점) 
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListSimlAbdnPotmPr(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> condMap = XframeControllerUtils.getParamDataSet(param, "dsCond2");
		
		LOGGER.debug("param ==> "+param);
		
		ArrayList<Map<String, Object>> resultList = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.yp.db.YPDB003QMDAO.selectListSimlAbdnPotmPr",condMap);			
		
		result.put("dsList2", resultList);
		result = sendMessage(resultList, resultList, result, 0);		//메시지 처리
		
		return result;
	}

	/**
	 * @author 나윤채
	 * @date 2015. 1. 31. 오후 5:00:03
	 * Method description : 구역구간별상세조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListSimlSegPrDtl(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> condMap = XframeControllerUtils.getParamDataSet(param, "dsCond3");
		
		LOGGER.debug("param ==> "+param);
		
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		if("".equals(trnOprBzDvCd) || trnOprBzDvCd == null){
			trnOprBzDvCd = "000";
		}
		condMap.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		
		ArrayList<Map<String, Object>> resultList = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.yp.db.YPDB003QMDAO.selectListSimlSegPrDtl",condMap);			
		
		result.put("dsList3", resultList);
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

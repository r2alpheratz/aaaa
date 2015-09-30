/**
 * project : KORAIL_YZ
 * package : com.korail.yz.sr
 * date : 2015. 1. 18.오후 5:43:26
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
import cosmos.comm.exception.CosmosRuntimeException;

/**
 * @author 나윤채
 * @date 2015. 1. 18. 오후 5:43:26
 * Class description : SR 등록
 */
@Service("com.korail.yz.sr.SRAA002SVC")
public class SRAA002SVC {
	
	@Resource(name="commDAO")
	private transient CommDAO dao;

	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public static final Logger LOGGER = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
	

	
	/**
	 * @author 나윤채
	 * @date 2015. 1. 18. 오후 5:44:19
	 * Method description : SR 등록하는 사용자 정보 조회 
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListRegInfo(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> condMap = XframeControllerUtils.getParamDataSet(param, "dsCond");
		
		LOGGER.debug("param ==> "+param);

		ArrayList<Map<String, Object>> resultList1 = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.sr.SRAA002QMDAO.selectListRegInfo1", condMap);			
		ArrayList<Map<String, Object>> resultList2 = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.sr.SRAA002QMDAO.selectListRegInfo2", condMap);			

		result.put("dsUsrInfo1", resultList1);
		result.put("dsUsrInfo2", resultList2);
		result = sendMessage(resultList2, resultList2, result, 0);		//메시지 처리
		
		return result;
	}

	/**
	 * @author 나윤채
	 * @date 2015. 1. 19. 오후 2:56:46
	 * Method description : SR_ID 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListSrId(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> condMap = XframeControllerUtils.getParamDataSet(param, "dsCond");
		
		LOGGER.debug("param ==> "+param);
		
		ArrayList<Map<String, Object>> resultList = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.sr.SRAA002QMDAO.selectListSrId", condMap);		
		
		result.put("dsSrID", resultList);
		result = sendMessage(resultList, resultList, result, 0);		//메시지 처리
		
		return result;
	}
	
	
	/**
	 * @author 나윤채
	 * @date 2015. 1. 19. 오후 3:10:36
	 * Method description : SR 등록
	 * @param param
	 * @return
	 */
	public Map<String, ?> insertSr(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> condMap = XframeControllerUtils.getParamDataSet(param, "dsCond2");
		
		LOGGER.debug("param ==> "+param);
		
		int insertCnt1 = dao.insert("com.korail.yz.sr.SRAA002QMDAO.insertSr1", condMap);		
		
		if (insertCnt1 < 1)
		{
			throw new CosmosRuntimeException("WZZ000012", null);  //등록 작업이 실패하였습니다 - 입력값을 확인하십시오.			
		}else{
			LOGGER.debug("SR등록1 ["+insertCnt1+"] 건 적용되었습니다.");
			XframeControllerUtils.setMessage("IZZ000013", result); //정상적으로 저장 되었습니다.
		}
		
		int insertCnt2 = dao.insert("com.korail.yz.sr.SRAA002QMDAO.insertSr2", condMap);		
		
		if (insertCnt2 < 1)
		{
			throw new CosmosRuntimeException("WZZ000012", null);  //등록 작업이 실패하였습니다 - 입력값을 확인하십시오.			
		}else{
			LOGGER.debug("SR등록2 ["+insertCnt2+"] 건 적용되었습니다.");
			XframeControllerUtils.setMessage("IZZ000013", result); //정상적으로 저장 되었습니다.
		}
		
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

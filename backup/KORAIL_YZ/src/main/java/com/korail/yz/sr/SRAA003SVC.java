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
import cosmos.comm.exception.CosmosRuntimeException;

/**
 * @author 나윤채
 * @date 2015. 1. 15. 오후 2:15:51
 * Class description : SR 수정
 */

@Service("com.korail.yz.sr.SRAA003SVC")
public class SRAA003SVC {
	
	@Resource(name="commDAO")
	private transient CommDAO dao;

	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public static final Logger LOGGER = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
	

	/**
	 * @author 나윤채
	 * @date 2015. 1. 17. 오후 2:18:11
	 * Method description : SR 등록정보 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListRegInfoSR(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> condMap = XframeControllerUtils.getParamDataSet(param, "dsCond1");
		
		LOGGER.debug("param ==> "+param);

		ArrayList<Map<String, Object>> resultList1 = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.sr.SRAA003QMDAO.selectListRegInfoSR", condMap);			
		ArrayList<Map<String, Object>> resultList2 = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.sr.SRAA003QMDAO.selectListCnt", condMap);			

		result.put("dsRegInfoSR", resultList1);
		result.put("dsCnt", resultList2);
		
		result = sendMessage(resultList1, resultList1, result, 0);		//메시지 처리
		
		return result;
	}
	
	
	/**
	 * @author 나윤채
	 * @date 2015. 1. 17. 오후 5:21:53
	 * Method description : 이전단계(TF검토) 조회 / 
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListPreStg(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> condMap1 = XframeControllerUtils.getParamDataSet(param, "dsCond1");
		Map<String, String> condMap2 = XframeControllerUtils.getParamDataSet(param, "dsRegInfoSR");
		
		ArrayList<Map<String, Object>> resultList1 = new ArrayList<Map<String,Object>>();
		ArrayList<Map<String, Object>> resultList2 = new ArrayList<Map<String,Object>>();
		ArrayList<Map<String, Object>> resultList3 = new ArrayList<Map<String,Object>>();
		
		
		LOGGER.debug("param ==> "+param);
				
		String sttCd = condMap2.get("SR_PRS_STT_CD");
		String preSttCd = condMap2.get("SR_PRS_STT_CD_PREV");
				
		if( sttCd.equals(preSttCd) )
		{
			resultList1 = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.sr.SRAA003QMDAO.selectListPreStg", condMap1);			
			resultList2 = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.sr.SRAA003QMDAO.selectListNewStg1", condMap1);
			
			result.put("dsPreStg", resultList1);
			result.put("dsNewStg", resultList2);
			result = sendMessage(resultList2, resultList2, result, 0);		//메시지 처리
		}else
		{
			resultList3 = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.sr.SRAA003QMDAO.selectListNewStg2", condMap1);
			
			result.put("dsPreStg", resultList3);
			result = sendMessage(resultList3, resultList3, result, 0);		//메시지 처리
		}
		
		return result;
	}
	
	/**
	 * @author 나윤채
	 * @date 2015. 1. 19. 오후 9:34:16
	 * Method description : 다음 담당자 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListExistCgPs(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> condMap1 = XframeControllerUtils.getParamDataSet(param, "dsCond1");
		Map<String, String> condMap2 = XframeControllerUtils.getParamDataSet(param, "dsUpdateSr");

		LOGGER.debug("param ==> "+param);
		
		ArrayList<Map<String, Object>> resultList = new ArrayList<Map<String,Object>>();
		
		condMap1.put("SR_PRS_STT_CD_NEXT", condMap2.get("SR_PRS_STT_CD_NEXT"));
		
		resultList = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.sr.SRAA003QMDAO.selectListExistCgPs1", condMap1);			
		
		if(resultList.isEmpty())
		{
			resultList = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.sr.SRAA003QMDAO.selectListExistCgPs2", condMap1);				
		}
		
		result.put("ExistCgPs", resultList);
		result = sendMessage(resultList, resultList, result, 0);		//메시지 처리
		
		return result;
	}
	
	/**
	 * @author 나윤채
	 * @date 2015. 1. 19. 오후 11:23:25
	 * Method description : SR 수정
	 * @param param
	 * @return
	 */
	public Map<String, ?> updateSr(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> condMap1 = XframeControllerUtils.getParamDataSet(param, "dsCond1");
		Map<String, String> condMap2 = XframeControllerUtils.getParamDataSet(param, "dsUpdateSr");
		Map<String, String> condMap3 = XframeControllerUtils.getParamDataSet(param, "dsRegInfoSR");
//		Map<String, String> condMap4 = XframeControllerUtils.getParamDataSet(param, "dsPreStg");
		
		LOGGER.debug("param ==> "+param);
		
		condMap2.put("SR_ID", condMap1.get("SR_ID"));
		condMap2.put("SR_PRS_SQNO", condMap3.get("SR_PRS_SQNO"));
		condMap2.put("SR_PRS_STT_CD", condMap3.get("SR_PRS_STT_CD"));
		condMap2.put("SR_PRS_STT_CD_PREV", condMap3.get("SR_PRS_STT_CD_PREV"));
		
		String srPrsSttCd1 = condMap2.get("SR_PRS_STT_CD_PREV");
		String srPrsSttCd2 = condMap2.get("SR_PRS_STT_CD");
		
		int insertCnt;
		int updateCnt;
		
		if (srPrsSttCd1.equals(srPrsSttCd2))
		{
			LOGGER.debug(" ::::::::::::::::::  "  + condMap2.get("DMN_PRS_DV_CD_DEV"));
			
			if("A".equals(condMap2.get("DMN_PRS_DV_CD"))||"D".equals(condMap2.get("DMN_PRS_DV_CD")))
			{
				insertCnt = dao.update("com.korail.yz.sr.SRAA003QMDAO.updateSr1", condMap2);			
			}else
			{
				insertCnt = dao.update("com.korail.yz.sr.SRAA003QMDAO.updateSr2", condMap2);				
			}
			
		}else
		{
			if("A".equals(condMap2.get("DMN_PRS_DV_CD"))||"D".equals(condMap2.get("DMN_PRS_DV_CD")))
			{
				insertCnt = dao.insert("com.korail.yz.sr.SRAA003QMDAO.updateSr3", condMap2);			
			}else
			{
				insertCnt = dao.insert("com.korail.yz.sr.SRAA003QMDAO.updateSr4", condMap2);				
			}
		}
		
		LOGGER.debug("##################: " +condMap2.entrySet());
		
		
		if ("05".equals(condMap2.get("SR_PRS_STT_CD_NEXT")) || "06".equals(condMap2.get("SR_PRS_STT_CD_NEXT")) )
		{
			updateCnt = dao.update("com.korail.yz.sr.SRAA003QMDAO.updateSr5", condMap2);
			
			if (updateCnt < 1)
			{
				throw new CosmosRuntimeException("WZZ000012", null);  //등록 작업이 실패하였습니다 - 입력값을 확인하십시오.			
			}else{
				LOGGER.debug("SR수정 2단계 ["+updateCnt+"] 건 적용되었습니다.");
				updateCnt = dao.update("com.korail.yz.sr.SRAA003QMDAO.updateSr6", condMap2);
			}
		}else
		{
			updateCnt = dao.update("com.korail.yz.sr.SRAA003QMDAO.updateSr7", condMap2);
		}
		
		if (insertCnt<1 || updateCnt < 1)
		{
			throw new CosmosRuntimeException("WZZ000012", null);  //등록 작업이 실패하였습니다 - 입력값을 확인하십시오.			
		}else{
			LOGGER.debug("SR수정 ["+updateCnt+"] 건 적용되었습니다.");
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

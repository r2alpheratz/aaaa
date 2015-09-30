/**
 * project : KORAIL_YZ
 * package : com.korail.yz.yp.db
 * date : 2014. 8. 18.오후 7:38:45
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
import cosmos.comm.exception.CosmosRuntimeException;

/**
 * @author EQ
 * @date 2014. 8. 18. 오후 7:38:45
 * Class description : 최적화시뮬레이션실행SVC
 * 예약/취소 시뮬레이션 실행하고 이전 실행내역 조회 기능을 제공하는 Service 클래스
 */
@Service("com.korail.yz.yp.db.YPDB002SVC")
public class YPDB002SVC {
	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public  static final Logger  LOGGER = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
	

	
	/**
	 * 시뮬레이션 실행
	 * @author 김응규
	 * @date 2014. 8. 18. 오후 7:39:00
	 * Method description : 시뮬레이션을 수행한다.
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map<String, ?> insertExcSiml(Map<String, ?> param) {		

		Map<String, Object> result = new HashMap<String, Object>();
		LOGGER.debug("param ==> "+param);
		// search input column dataset
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");	
		LOGGER.debug("inputDataSet ==>  " + inputDataSet);
		ArrayList<Map<String, Object>> resultList = new ArrayList<Map<String,Object>>();
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		String userId = String.valueOf(param.get("USER_ID"));
		
		//시뮬레이션 실행여부(실행진행율) 조회
		LOGGER.debug("시뮬레이션 실행여부(실행진행율) 조회!!!!!!!!!!!!!!!!!!!!!!!!");
		ArrayList<Map<String, Object>> excPrgRtList = (ArrayList) dao.list("com.korail.yz.yp.db.YPDB002QMDAO.selectExcPrgRt", inputDataSet);
		LOGGER.debug("실행진행율 ::::: ["+excPrgRtList.get(0).get("EXC_PRG_RT")+"]");
		
		if(Double.parseDouble(String.valueOf(excPrgRtList.get(0).get("EXC_PRG_RT"))) > -1)
		{
			throw new CosmosRuntimeException("EYZ000006", null);  ////이미 시뮬레이션을 실행했습니다!
		}
		
		//출발시각 조회
		LOGGER.debug("출발시각 조회!!!!!!!!!!!!!!!!!!!!!!!!");
		Map<String, Object> dptDttmMap = (Map<String, Object>) dao.select("com.korail.yz.yp.db.YPDB002QMDAO.selectDptDttm", inputDataSet);
		LOGGER.debug("출발시각 ::::: ["+dptDttmMap.get("DPT_DTTM")+"]");
		// 할당 해지지점 조회
		/**
		 * @remarks AS-IS 에서 할당적용여부[적용], [미적용] 라디오 버튼이 있고, 
		 * [적용]에 체크하면 15분전, 45분전, 2시간전, 1일전, 2일전으로 체크할 수 있도록 하는 로직이 들어있었음. 
		 * [미적용]에 체크하면 60일 전으로 할인해지일시를 조회했음.
		 * 
		 * 그런데 추후에 버튼은 hidden 처리 하고 *****무조건 [적용] - [15분전]********* 에 체크되어 처리를 하도록 변경됨.
		 * 
		 * 그래서 [적용]-[15분전]로직으로 그대로 감. ㄱㄱ 
		 * ※ 할인해제시각조회 45분전, 2시간전, 1일전, 2일전, 60일전 쿼리는 저장해놓음.
		 * 
		 * @author 김응규
		 * @date   2014. 8. 8 
		 * */
		//할인적용여부
		String dcntAplFlg = "Y"; //할인적용여부
		
		//할인해지일시 조회
		inputDataSet.put("DPT_DTTM", String.valueOf(dptDttmMap.get("DPT_DTTM")));
		LOGGER.debug("할인해지일시 조회!!!!!!!!!!!!!!!!!!!!!!!!");
		Map<String, Object> dcntAbdnDttmMap = (Map<String, Object>) dao.select("com.korail.yz.yp.db.YPDB002QMDAO.selectDcntAbdnDttm", inputDataSet);
		
		LOGGER.debug("할인해지일시(15분전) ::::: ["+dcntAbdnDttmMap.get("DCNT_ABDN_DTTM")+"]");
		
		String dcntAbdnDttm =  String.valueOf(dcntAbdnDttmMap.get("DCNT_ABDN_DTTM")); //할인해지일시
		
		LOGGER.debug("시뮬레이션작업ID 채번!!!!!!!!!!!!!!!!!!!!!!!!!");
		Map<String, Object> newSimlJobIdMap = (Map<String, Object>) dao.select("com.korail.yz.yp.db.YPDB002QMDAO.selectNewSimlJobId", null);
		LOGGER.debug("New SIML_JOB_ID  ::::: ["+newSimlJobIdMap.get("SIML_JOB_ID")+"]");
		
		inputDataSet.put("SIML_JOB_ID", String.valueOf(newSimlJobIdMap.get("SIML_JOB_ID"))); //시뮬레이션 작업ID
		inputDataSet.put("DCNT_APL_FLG", dcntAplFlg); //할인적용여부
		inputDataSet.put("DCNT_ABDN_DTTM", dcntAbdnDttm); //할인해지일시
		inputDataSet.put("USER_ID", userId);
		//공급좌석수(SPL_SEAT_NUM) = 0, 시뮬레이션실행횟수(SIML_EXC_TNO) = 1, 실행진행율(EXC_PRG_RT) = 0 으로 insert함
		int insertCnt = 0;
		LOGGER.debug("객실등급확인!!!!!!"+inputDataSet.get("PSRM_CL_CD"));
		/*if(inputDataSet.get("PSRM_CL_CD").length() < 1)
		{
			for(int i = 0; i < 2; i++)
			{
				Map<String, String> paramMap = new HashMap<String, String>();
				paramMap.put("RUN_DT", inputDataSet.get("RUN_DT"));
				paramMap.put("TRN_NO", inputDataSet.get("TRN_NO"));
				paramMap.put("SIML_EXC_RMK_CONT", inputDataSet.get("SIML_EXC_RMK_CONT"));
				paramMap.put("DCNT_APL_FLG", dcntAplFlg); //할인적용여부
				paramMap.put("DCNT_ABDN_DTTM", dcntAbdnDttm); //할인해지일시
				paramMap.put("USER_ID", userId);
				if(i == 0)
				{
					paramMap.put("SIML_JOB_ID", String.valueOf(newSimlJobIdMap.get("SIML_JOB_ID")));
					paramMap.put("PSRM_CL_CD", "1"); //객실등급 : 일반실
					insertCnt = dao.insert("com.korail.yz.yp.db.YPDB003QMDAO.insertTB_YYST008", paramMap);
				}
				else
				{
					LOGGER.debug("시뮬레이션작업ID 채번222222!!!!!!!!!!!!!!!!!!!!!!!!!");
					Map<String, Object> newSimlJobIdMap2 = (Map<String, Object>) dao.select("com.korail.yz.yp.db.YPDB002QMDAO.selectNewSimlJobId", null);
					LOGGER.debug("New SIML_JOB_ID  ::::: ["+newSimlJobIdMap2.get("SIML_JOB_ID")+"]");
					paramMap.put("SIML_JOB_ID", String.valueOf(newSimlJobIdMap2.get("SIML_JOB_ID")));
					paramMap.put("PSRM_CL_CD", "2"); //객실등급 : 특실
					insertCnt += dao.insert("com.korail.yz.yp.db.YPDB003QMDAO.insertTB_YYST008", paramMap);
				}
			}
		} //END if(inputDataSet.get("PSRM_CL_CD").length() < 1)
		else
		{
			insertCnt = dao.insert("com.korail.yz.yp.db.YPDB003QMDAO.insertTB_YYST008", inputDataSet);
		}*/
		
		insertCnt = dao.insert("com.korail.yz.yp.db.YPDB002QMDAO.insertTB_YYST008", inputDataSet);
		
		//메시지 처리
  		if(insertCnt < 1){
  			throw new CosmosRuntimeException("EYP000002", null);  ////시뮬레이션 수행 중 오류가 발생하였습니다.
  		}
  		else
  		{
  			resultMap.put("RESULT", "SUCCESS");
  			resultList.add(resultMap);
  			XframeControllerUtils.setMessage("IYR000001", result); //시뮬레이션이 수행되었습니다.
  		}
  		result.put("dsResult", resultList);
		return result;

	}
	
	/**
	 * 이전실행목록 조회
	 * @author 김응규
	 * @date 2014. 8. 20. 오전 11:19:00
	 * Method description : 시뮬레이션 실행이력을 조회한다.
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map<String, ?> selectListBfExcLst(Map<String, ?> param) {		

		Map<String, Object> result = new HashMap<String, Object>();

		LOGGER.debug("param ==> "+param);
		// search input column dataset
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");	
		LOGGER.debug("inputDataSet ==>  " + inputDataSet);
		
		//수요예측 최적화할당 정보조회
		ArrayList<Map<String, Object>> resultList = (ArrayList) dao.list("com.korail.yz.yp.db.YPDB002QMDAO.selectListBfExcLst", inputDataSet);
		
		//메시지 처리
		if(resultList.isEmpty())
		{
			XframeControllerUtils.setMessage("IZZ000004", result); //해당 조건의 자료가 존재하지 않습니다.
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result); //정상적으로 조회 되었습니다.
		}
		result.put("dsList", resultList);
		
		return result;

	}
	
	/**
	 * 시뮬레이션 재실행
	 * @author 김응규
	 * @date 2014. 8. 20. 오후 8:59:00
	 * Method description : 시뮬레이션을 재실행한다.
	 * @param param
	 * @return
	 */
	public Map<String, ?> updateExcSimlRe(Map<String, ?> param) {		

		Map<String, Object> result = new HashMap<String, Object>();
		LOGGER.debug("param ==> "+param);
		// search input column dataset
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsListCopy");	
		LOGGER.debug("inputDataSet ==>  " + inputDataSet);
		ArrayList<Map<String, Object>> resultList = new ArrayList<Map<String,Object>>();
		Map<String, Object> resultMap = new HashMap<String, Object>();
		String userId = String.valueOf(param.get("USER_ID"));
		inputDataSet.put("USER_ID", userId);
		int updateCnt = dao.update("com.korail.yz.yp.db.YPDB002QMDAO.updateExcSimlRe", inputDataSet);
		
		//메시지 처리
  		if(updateCnt < 1){
  			throw new CosmosRuntimeException("EYP000002", null);  ////시뮬레이션 수행 중 오류가 발생하였습니다.
  		}
  		else
  		{
  			resultMap.put("RESULT", "SUCCESS");
  			resultList.add(resultMap);
  			XframeControllerUtils.setMessage("IYR000001", result); //시뮬레이션이 수행되었습니다.
  		}
  		result.put("dsResult", resultList);
		return result;

	}
}

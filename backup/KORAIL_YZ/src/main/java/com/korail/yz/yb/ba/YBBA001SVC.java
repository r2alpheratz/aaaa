/**
 * project : KORAIL_YZ
 * package : com.korail.yz.yb.ba
 * date : 2014. 6. 14.오후 3:28:48
 */
package com.korail.yz.yb.ba;


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
import cosmos.comm.exception.CosmosRuntimeException;

/**
 * @author 한현섭
 * @date 2014. 6. 14. 오후 3:28:48
 * Class description : 
 */
@Service("com.korail.yz.yb.ba.YBBA001SVC")
public class YBBA001SVC {

	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public  final Logger LOGGER = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
 
	
	/**
	 * @author 한현섭
	 * @date 2014. 6. 14. 오후 3:30:38
	 * Method description : : 예외열차할당 FLAG 등록건에 대한 목록을 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListExctTrnAlcFlgLst(Map<String, ?> param){
	
 		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();

		/* 입력 오브젝트 */
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsGrdCond");
		
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		if("".equals(trnOprBzDvCd) || trnOprBzDvCd == null){
			trnOprBzDvCd = "000";
		}
		inputDataSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		
		/* DAO - 쿼리 실행 후 결과 획득*/
		ArrayList<Map<String, Object>> resultList
		= (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.yb.ba.YBBA001QMDAO.selectListExctTrnAlcFlgLst", inputDataSet);

		//error 메시지 날리기
		if(resultList.isEmpty()){
			XframeControllerUtils.setMessage("IZZ000004", result);
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result);
		}
		result.put("dsGrdList", resultList);
		return result;
	}
	
	/**
	 * @author 한현섭
	 * @date 2014. 6. 14. 오후 3:30:40
	 * Method description : 예외열차할당 FLAG 등록을 위해 열차를 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListExctTrnAlcFlgRegQry(Map<String, ?> param){
		
		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		
		/* 입력 오브젝트 */
		Map<String, String> inputDataSet = XframeControllerUtils.getParamDataSet(param, "dsGrdCond");
		
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		if("".equals(trnOprBzDvCd) || trnOprBzDvCd == null){
			trnOprBzDvCd = "000";
		}
		inputDataSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		
		/* DAO - 쿼리 실행 후 결과 획득*/
		List<Map<String, Object>> resultList
		= (List<Map<String, Object>>) dao.list("com.korail.yz.yb.ba.YBBA001QMDAO.selectListExctTrnAlcFlgRegQry", inputDataSet);
		
		//error 메시지 날리기
		if(resultList.isEmpty()){
			XframeControllerUtils.setMessage("IZZ000004", result);
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result);
		}
		result.put("dsGrdList", resultList);
		return result;
	}
	
	/**
	 * @author 김응규
	 * @date 2015. 4. 3. 오후 1:30:38
	 * Method description : : 예외열차할당 FLAG 등록 전 유효성 체크(동일 등록값으로 등록된 내역이 있는지 확인)
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectExistExctTrnAlcFlg(Map<String, ?> param){
	
 		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, Object> resultMap = new HashMap<String, Object>();
		ArrayList<Map<String, Object>> resultList = new ArrayList<Map<String,Object>>();
		int resultCnt;
		/* 입력 오브젝트 */
		List<Map<String, String>> inputDataArray = (List<Map<String, String>>) param.get("dsInsertCond");
		
		for (Map<String, String> inputDataSet : inputDataArray){
			resultCnt = 0;
			resultCnt = dao.count("com.korail.yz.yb.ba.YBBA001QMDAO.selectExistExctTrnAlcFlg", inputDataSet);
			LOGGER.debug("resultCnt ::"+resultCnt);
			if(resultCnt > 0)
			{
				resultMap.put("RESULT", "EXIST");
				resultList.add(resultMap);
				result.put("dsResult", resultList);
				return result;
			}
		}
		

		resultMap.put("RESULT", "EMPTY");
		resultList.add(resultMap);
		result.put("dsResult", resultList);
		return result;
	}
	
	/**
	 * @author 한현섭
	 * @date 2014. 6. 14. 오후 3:30:41
	 * Method description : 예외열차로 할당값 FLAG 등록정보를 저장
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> insertExctTrnAlcFlgReq(Map<String, ?> param){
		
		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		List<Map<String,String>> isSuccessList = new ArrayList<Map<String,String>>();
		Map<String,String> isSuccessSet = new HashMap<String, String>();
		String userId = String.valueOf(param.get("USER_ID"));
		/* 입력 오브젝트 */
		List<Map<String, String>> inputDataArray = (List<Map<String, String>>) param.get("dsInsertCond");
		
		/* DAO - 쿼리 실행 후 결과 획득*/
		/*for (Map<String, String> inputDataSet : inputDataArray)
		{
			// 일일열차 정보에 등록되어있는지 여부 확인 - 제거 (고객요청사항-미생성열차등록건)
			List<Map<String, Object>> resultDayDvList = (List<Map<String, Object>>) dao.list("com.korail.yz.yb.ba.YBBA001QMDAO.selectDlyTrnInfoCfm", inputDataSet);
			String rCnt =  resultDayDvList.get(0).get("ROWCOUNT").toString();
			LOGGER.debug("rCnt--->"+rCnt);
			if("0".equals(rCnt) )
			{
				inputDataSet.put("IS_INSERT","F");			
			}else{
				inputDataSet.put("IS_INSERT","T");
				
			}
		}*/
		
		
		
		try{
			for (Map<String, String> inputDataSet : inputDataArray){
				/*if("T".equals(inputDataSet.get("IS_INSERT"))){
					dao.update("com.korail.yz.yb.ba.YBBA001QMDAO.insertExctTrnAlcFlgReq", inputDataSet);
				}*/
				inputDataSet.put("USR_ID", userId);
				dao.insert("com.korail.yz.yb.ba.YBBA001QMDAO.insertExctTrnAlcFlgReq", inputDataSet);
			}
		}catch(Exception e)
		{
			
			isSuccessSet.put("FLAG", "F");
			isSuccessList.add(isSuccessSet);
			result.put("dsSaveFlag", isSuccessList);
			
			throw new CosmosRuntimeException("WZZ000012", null);  //등록 작업이 실패하였습니다 - 입력값을 확인하십시오.
		}
		//메시지 처리
		XframeControllerUtils.setMessage("IZZ000013", result);

		
		isSuccessSet.put("FLAG", "T");
		isSuccessList.add(isSuccessSet);
		result.put("dsSaveFlag", isSuccessList);
		return result;
	}
		
	/**
	 * @author 한현섭
	 * @date 2014. 6. 14. 오후 3:30:42
	 * Method description : 기본열차 이외에 수익관리할당FLAG값을 별도로 설정 관리가 필요한 예외열차를 수정
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> updateExctTrnAlcFlgMdfy(Map<String, ?> param){
		
		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		
		/* 입력 오브젝트 */
		List<Map<String, String>> inputDataArray = (List<Map<String, String>>) param.get("dsGrdCond");
		
		/* DAO - 쿼리 실행 후 결과 획득*/
		try{
			for(Map<String, String> inputDataSet : inputDataArray)
			{
				dao.update("com.korail.yz.yb.ba.YBBA001QMDAO.updateExctTrnAlcFlgMdfy", inputDataSet);
			}
		}catch(Exception e)
		{
			XframeControllerUtils.setMessage("EZZ000018", result);
			return result;
		}
		//error 메시지 날리기
		XframeControllerUtils.setMessage("IZZ000013", result);
		//성공여부 설정
		List<Map<String,String>> isSuccessList = new ArrayList<Map<String,String>>();
		Map<String,String> isSuccessSet = new HashMap<String, String>();
		
		isSuccessSet.put("FLAG", "T");
		isSuccessList.add(isSuccessSet);
		result.put("dsSaveFlag", isSuccessList);
		return result;
	}
	
	
	
	
	
	
	/**
	 * @author 한현섭
	 * @date 2014. 6. 14. 오후 3:30:44
	 * Method description : 예외열차 할당 FLAG 등록 내역을 삭제
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> deleteExctTrnAlcFlgDel(Map<String, ?> param){
		
		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		
		/* 입력 오브젝트 */
		List<Map<String, String>> inputDataArray = (List<Map<String, String>>) param.get("dsCondForUD");
		
		/* DAO - 쿼리 실행 후 결과 획득*/
		try{
			for(Map<String, String> inputDataSet : inputDataArray)
			{
				dao.update("com.korail.yz.yb.ba.YBBA001QMDAO.deleteExctTrnAlcFlgDel", inputDataSet);
			}
		}catch(Exception e)
		{
			XframeControllerUtils.setMessage("EZZ000019", result);
			return result;
		}
		//error 메시지 날리기
		
			
			XframeControllerUtils.setMessage("IZZ000011", result);
		
		return result;
	}
}

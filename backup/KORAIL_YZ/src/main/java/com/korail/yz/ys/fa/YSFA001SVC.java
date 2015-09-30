/**
 * project : KORAIL_YZ
 * package : com.korail.yz.ys.ed
 * date : 2014. 7. 11.오후 5:55:51
 */
package com.korail.yz.ys.fa;

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
 * @author EQ
 * @date 2014. 7. 11. 오후 5:55:51
 * Class description : 고객승급관리SVC
 * 승급 기준에 속하는 대상 열차의 일괄작업에 의해 처리된 결과를 조회, 
 * 승급대상 기준정보 설정관리 및 승급실적조회를 위한 Service 클래스
 */
@Service("com.korail.yz.ys.fa.YSFA001SVC")
public class YSFA001SVC {
	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public  static final Logger  LOGGER = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
	
	
	/**
	 * 고객승급관리내역 조회
	 * @author 김응규
	 * @date 2014. 7. 8. 오후 5:36:00
	 * Method description : 고객승급대상이 되는 열차의 내역을 조회한다.
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map<String, ?> selectListPromTgtTrn(Map<String, ?> param) {		

		Map<String, Object> result = new HashMap<String, Object>();
		
		LOGGER.debug("param ==> "+param);
		// search input column dataset
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");	
		LOGGER.debug("inputDataSet ==>  " + inputDataSet);
		//열차운영사업자구분코드 추가
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		inputDataSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		
		//고객승급관리 조회
		ArrayList<Map<String, Object>> resultList = (ArrayList) dao.list("com.korail.yz.ys.fa.YSFA001QMDAO.selectListPromTgtTrn", inputDataSet);

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
	 * 승급좌석사용자조정 수정
	 * @author 김응규
	 * @date 2014. 7. 7. 오후 5:36:00
	 * Method description : 승급좌석의 사용자조정수를 수정 처리한다.
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "unchecked" })
	public Map<String, ?> updatePromSeatUsrCtl(Map<String, ?> param) {		

		Map<String, Object> result = new HashMap<String, Object>();

		LOGGER.debug("param ==> "+param);
		
		ArrayList<Map<String, String>> promSeatList = (ArrayList<Map<String, String>>) param.get("dsList");
		String userId = String.valueOf(param.get("USER_ID"));
		
		int updateCnt = 0;
		
		LOGGER.debug("promSeatList 사이즈:::::::::::::::"+promSeatList.size());
	    for( int i = 0; i < promSeatList.size() ; i++ )
	    {
	    	Map<String, String> item = promSeatList.get(i);
	    	
	    	LOGGER.debug("dsList["+i+"]번째 ROW =====>"+item);
	    	item.put("USER_ID", userId);	    	
	    	
	    	
	        if(item.get("DMN_PRS_DV_CD").equals("U"))  /*요청처리구분코드가 U : update*/
	        {
	        	updateCnt += dao.update("com.korail.yz.ys.fa.YSFA001QMDAO.updatePromSeatUsrCtl", item);	
	        }
	    }
	    LOGGER.debug("수정 ["+updateCnt+"] 건 수행하였습니다.");
	    
		//메시지 처리
  		if(updateCnt < 1){
  			throw new CosmosRuntimeException("WYZ000007", null);  ////해당 자료를 수정할수 없습니다.	수정자료를 확인하여 주십시오.
  		}
  		else
  		{
  			XframeControllerUtils.setMessage("IZZ000013", result); //정상적으로 저장 되었습니다.
  		}
  		
		return result;

	}
	
	/**
	 * 예측수요대비 발매현황 조회
	 * @author 김응규
	 * @date 2014. 7. 15. 오후 4:30:00
	 * Method description : 예측수요대비 발매현황을 조회한다.
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map<String, ?> selectListFcstDmdVsSalePstt(Map<String, ?> param) {		

		Map<String, Object> result = new HashMap<String, Object>();

		LOGGER.debug("param ==> "+param);
		
		// search input column dataset
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");	
		LOGGER.debug("inputDataSet ==>  " + inputDataSet);
		//열차운영사업자구분코드 추가
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		inputDataSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		//예측수요대비 발매현황 조회
		ArrayList<Map<String, Object>> resultList = (ArrayList) dao.list("com.korail.yz.ys.fa.YSFA001QMDAO.selectListFcstDmdVsSalePstt", inputDataSet);
		ArrayList<Map<String, Object>> resultList2 = (ArrayList) dao.list("com.korail.yz.ys.fa.YSFA001QMDAO.selectListFcstDmdVsSalePsttDistinct", inputDataSet);
		
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
		result.put("dsList2", resultList2);
		return result;

	}
	/**
	 * 승급실적 조회
	 * @author 김응규
	 * @date 2014. 7. 15. 오후 4:30:00
	 * Method description : 승급실적을 요일별/일자별/열차별/구역구간별로 조회한다.
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map<String, ?> selectListPromAcvm(Map<String, ?> param) {		

		Map<String, Object> result = new HashMap<String, Object>();

		LOGGER.debug("param ==> "+param);
		// search input column dataset
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");	
		//열차운영사업자구분코드 추가
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		inputDataSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		LOGGER.debug("inputDataSet ==>  " + inputDataSet);
		ArrayList<Map<String, Object>> resultList = new ArrayList<Map<String,Object>>();
		if("1".equals(inputDataSet.get("SRCH_DV")))
		{
			//요일별 승급실적 조회
			resultList = (ArrayList) dao.list("com.korail.yz.ys.fa.YSFA001QMDAO.selectListPromAcvmDayPr", inputDataSet);
		}
		else if("2".equals(inputDataSet.get("SRCH_DV")))
		{
			//일자별 승급실적 조회
			resultList = (ArrayList) dao.list("com.korail.yz.ys.fa.YSFA001QMDAO.selectListPromAcvmDtPr", inputDataSet);
		}
		else if("3".equals(inputDataSet.get("SRCH_DV")))
		{
			//열차별 승급실적 조회
			resultList = (ArrayList) dao.list("com.korail.yz.ys.fa.YSFA001QMDAO.selectListPromAcvmTrnPr", inputDataSet);
		}
		else if("4".equals(inputDataSet.get("SRCH_DV")))
		{
			//구역구간별 승급실적 조회
			resultList = (ArrayList) dao.list("com.korail.yz.ys.fa.YSFA001QMDAO.selectListPromAcvmSegGpPr", inputDataSet);
		}
		

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
	 * 고객승급 기본정보설정 적용기간 조회
	 * @author 김응규
	 * @date 2014. 7. 15. 오후 4:30:00
	 * Method description : 고객승급관리의 기본정보를 설정할 적용기간을 조회한다.
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map<String, ?> selectListBsInfoAplTrm(Map<String, ?> param) {		

		Map<String, Object> result = new HashMap<String, Object>();

		LOGGER.debug("param ==> "+param);
		
		//예측수요대비 발매현황 조회
		ArrayList<Map<String, Object>> resultList = (ArrayList) dao.list("com.korail.yz.ys.fa.YSFA001QMDAO.selectListBsInfoAplTrm", null);

		//메시지 처리
		if(resultList.isEmpty())
		{
			XframeControllerUtils.setMessage("IZZ000004", result); //해당 조건의 자료가 존재하지 않습니다.
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result); //정상적으로 조회 되었습니다.
		}
		result.put("dsAplTrm", resultList);
		
		return result;

	}
	
	/**
	 * 고객승급 기본정보 조회
	 * @author 김응규
	 * @date 2014. 7. 15. 오후 4:30:00
	 * Method description : 고객승급 기본정보를 조회한다.
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map<String, ?> selectListCustPromBsInfo(Map<String, ?> param) {		

		Map<String, Object> result = new HashMap<String, Object>();

		LOGGER.debug("param ==> "+param);
		// search input column dataset
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");	
		//열차운영사업자구분코드 추가
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		inputDataSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		LOGGER.debug("inputDataSet ==>  " + inputDataSet);
		
		//예측수요대비 발매현황 조회
		ArrayList<Map<String, Object>> resultList = (ArrayList) dao.list("com.korail.yz.ys.fa.YSFA001QMDAO.selectListCustPromBsInfo", inputDataSet);

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
	 * 고객승급 기본정보 리비젼
	 * @author 김응규
	 * @date 2014. 7. 7. 오후 5:36:00
	 * Method description : 고객승급파라미터기본 내역을 개정한다.
	 * @param param
	 * @return
	 */
	public Map<String, ?> updateBsInfoSetRvs(Map<String, ?> param) {		

		Map<String, Object> result = new HashMap<String, Object>();

		LOGGER.debug("param ==> "+param);
		ArrayList<Map<String, Object>> resultList = new ArrayList<Map<String,Object>>();
		Map<String, Object> resultMap = new HashMap<String, Object>();
		// search input column dataset
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");	
		LOGGER.debug("inputDataSet ==>  " + inputDataSet);
		String userId = String.valueOf(param.get("USER_ID"));
		inputDataSet.put("USER_ID", userId);
		int updateCnt = 0;
		int insertCnt = 0;
		/* 1. 현재 사용중인 기본정보를 임시코드(00000000)로 바꾼다. */
		LOGGER.debug(":::::::::::::::::::1. 현재 사용중인 기본정보를 임시코드(00000000)로 바꿉니다!:::::::::::::");
		try {
			updateCnt = dao.update("com.korail.yz.ys.fa.YSFA001QMDAO.updateCustPromTmpSet", null);	
		} catch (Exception e) {
			throw new CosmosRuntimeException("EYS000007", null);  //리비젼 중 오류가 발생하였습니다.
		}
			
		LOGGER.debug("임시코드로 변경한 기본정보내역 ==>  [" + updateCnt + "]건");
		//메시지 처리
  		if(updateCnt < 1)
  		{
  			throw new CosmosRuntimeException("EYS000007", null);  //리비젼 중 오류가 발생하였습니다.
  		}
  		updateCnt = 0;
		/* 2. 임시코드로 바꾼 기본정보를 새로운 리비젼 데이터로 신규 입력한다. */
  		LOGGER.debug(":::::::::::::::::::2. 임시코드로 바꾼 기본정보를 새로운 리비젼 데이터로 신규 입력!!! :::::::::::::");
  		try {
  			insertCnt = dao.insert("com.korail.yz.ys.fa.YSFA001QMDAO.insertCustPromBsInfo", inputDataSet);
		} catch (Exception e) {
			throw new CosmosRuntimeException("EYS000007", null);  //리비젼 중 오류가 발생하였습니다.
		}
	    if(insertCnt < 1)
  		{
	    	throw new CosmosRuntimeException("EYS000007", null);  //리비젼 중 오류가 발생하였습니다.
  		}
	    /* 3. 임시코드로 바꾼 기존의 최종기본정보는 새로운 리비젼 데이터 적용시작일 전일로 적용종료일자를 업데이트한다. */
	    LOGGER.debug(":::::::::::::::::::3. 기존의 최종기본정보 종료일자 업데이트!(적용시작일-1일) :::::::::::::");
	    updateCnt = dao.update("com.korail.yz.ys.fa.YSFA001QMDAO.updateCustPromExsBsInfo", inputDataSet);	
		LOGGER.debug("신규적용시작일자-1일로 기존기본정보 업데이트한 건수 ==>  [" + updateCnt + "]건");
		//메시지 처리
  		if(updateCnt < 1)
  		{
  			throw new CosmosRuntimeException("EYS000007", null);  //리비젼 중 오류가 발생하였습니다.
  		}
  		else
  		{
  			resultMap.put("RESULT", "SUCCESS");
  			resultList.add(resultMap);
  			XframeControllerUtils.setMessage("IYS000006", result); //리비젼이 완료되었습니다.
  		}
  		result.put("dsResult", resultList);
		return result;

	}
	
	/**
	 * 고객승급 기본정보 리비젼 복원
	 * @author 김응규
	 * @date 2014. 7. 7. 오후 5:36:00
	 * Method description : 개정한 고객승급 기본정보를 이전이력으로 복원한다.
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> updateRstrBsInfo(Map<String, ?> param) {		

		Map<String, Object> result = new HashMap<String, Object>();

		LOGGER.debug("param ==> "+param);
		ArrayList<Map<String, Object>> resultList = new ArrayList<Map<String,Object>>();
		Map<String, Object> resultMap = new HashMap<String, Object>();
		Map<String, String> paramMap = new HashMap<String, String>();
		
		ArrayList<Map<String, String>> aplTrmList = (ArrayList<Map<String, String>>) param.get("dsAplTrm");
		String aplClsDt = String.valueOf(aplTrmList.get(1).get("APL_CLS_DT"));
		paramMap.put("APL_CLS_DT", aplClsDt);
		String userId = String.valueOf(param.get("USER_ID"));
		paramMap.put("USER_ID", userId);
		int updateCnt = 0;
		int deleteCnt = 0;
		/* 1. 현재 사용중인 기본정보를 삭제한다 */
		LOGGER.debug(":::::::::::::::::::1. 현재 사용중인 기본정보 삭제!!:::::::::::::");
		deleteCnt = dao.delete("com.korail.yz.ys.fa.YSFA001QMDAO.deleteNewCustPromBsInfo", null);	
		LOGGER.debug("삭제한 기본정보내역 ==>  [" + deleteCnt + "]건");
		//메시지 처리
  		if(deleteCnt < 1)
  		{
  			throw new CosmosRuntimeException("EYS000007", null);  //리비젼 중 오류가 발생하였습니다.
  		}
  		deleteCnt = 0;
		/* 2. 이전 이력을 현재사용중(적용종료일자 => '99991231' )으로 변경한다.. */
  		LOGGER.debug(":::::::::::::::::::2. 이전이력을 새로운 리비젼 데이터 업데이트!!! :::::::::::::");
  		updateCnt = dao.update("com.korail.yz.ys.fa.YSFA001QMDAO.updateRstCustPromBsInfo", paramMap);
	    
  		if(updateCnt < 1)
  		{
  			throw new CosmosRuntimeException("EYS000007", null);  //리비젼 중 오류가 발생하였습니다.
  		}
  		else
  		{
  			resultMap.put("RESULT", "SUCCESS");
  			resultList.add(resultMap);
  			XframeControllerUtils.setMessage("IYS000006", result); //리비젼이 완료되었습니다.
  		}
  		result.put("dsResult", resultList);
		return result;

	}
	
	/**
	 * 주운행선조회(고객승급파라미터 - 기본정보 일괄설정에서 사용)
	 * @author 김응규
	 * @date 2014. 7. 15. 오후 4:30:00
	 * Method description : 고객승급파라미터 - 기본정보 일괄설정에서 사용할 주운행선 목록을 조회한다.
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map<String, ?> selectListMrntCd(Map<String, ?> param) {		

		Map<String, Object> result = new HashMap<String, Object>();

		
		//예측수요대비 발매현황 조회
		ArrayList<Map<String, Object>> resultList = (ArrayList) dao.list("com.korail.yz.ys.fa.YSFA001QMDAO.selectListMrntCd", null);

		//메시지 처리
		if(resultList.isEmpty())
		{
			XframeControllerUtils.setMessage("IZZ000004", result); //해당 조건의 자료가 존재하지 않습니다.
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result); //정상적으로 조회 되었습니다.
		}
		result.put("dsMrntList", resultList);
		
		return result;

	}
	
	/**
	 * 고객승급 기본정보 일괄설정
	 * @author 김응규
	 * @date 2014. 7. 7. 오후 5:36:00
	 * Method description : 고객승급 기본정보를 일괄 수정한다.
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> updateCustPromBsInfoLumpSet(Map<String, ?> param) {		

		Map<String, Object> result = new HashMap<String, Object>();

		LOGGER.debug("param ==> "+param);
		ArrayList<Map<String, Object>> resultList = new ArrayList<Map<String,Object>>();
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		String userId = String.valueOf(param.get("USER_ID"));
		ArrayList<Map<String, String>> inputList = (ArrayList<Map<String, String>>) param.get("dsList");
		
		int updateCnt = 0;
		
		for (int i = 0; i < inputList.size(); i++)
		{
			Map<String, String> paramMap = inputList.get(i);
			paramMap.put("USER_ID", userId);
			
			updateCnt+= dao.update("com.korail.yz.ys.fa.YSFA001QMDAO.updateCustPromBsInfoLumpSet", paramMap);
			
		}
		LOGGER.debug("업데이트 총 건수  ==>  [" + updateCnt + "]건");
		
		if(updateCnt < 1)
  		{
  			throw new CosmosRuntimeException("EZZ000021", null);  //저장된 정보가 없습니다
  		}
  		else
  		{
  			resultMap.put("RESULT", "SUCCESS");
  			resultList.add(resultMap);
  			XframeControllerUtils.setMessage("IZZ000012", result); //정상적으로 수정 되었습니다.
  		}
  		result.put("dsResult", resultList);
		return result;

	}
	
	
	/**
	 * 고객승급 기본정보 예외 조회
	 * @author 김응규
	 * @date 2014. 7. 15. 오후 4:30:00
	 * Method description : 기본정보 예외 목록을 조회한다.
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map<String, ?> selectListCustPromBsInfoExct(Map<String, ?> param) {		

		Map<String, Object> result = new HashMap<String, Object>();

		
		//예측수요대비 발매현황 조회
		ArrayList<Map<String, Object>> resultList = (ArrayList) dao.list("com.korail.yz.ys.fa.YSFA001QMDAO.selectListCustPromBsInfoExct", null);

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
	 * 고객승급 기본정보예외 등록/수정/삭제
	 * @author 김응규
	 * @date 2014. 7. 25. 오후 5:36:00
	 * Method description : 고객승급 기본정보예외 등록/수정/삭제 처리한다.
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "unchecked" })
	public Map<String, ?> updateCustPromBsInfoExct(Map<String, ?> param) {		

		Map<String, Object> result = new HashMap<String, Object>();

		LOGGER.debug("param ==> "+param);
		
		ArrayList<Map<String, String>> bsList = (ArrayList<Map<String, String>>) param.get("dsList");
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
	        	HashMap<String, BigDecimal> ttrnCntMap = (HashMap<String, BigDecimal>) dao.select("com.korail.yz.ys.fa.YSFA001QMDAO.selectCustPromBsInfoExctCnt", item);
	        	if(ttrnCntMap.get("QRY_CNT").intValue() > 0)
		    	{
	        		throw new CosmosRuntimeException("WZZ000013", null); 
					//이미 등록된 내역이 존재합니다.  입력값을 확인하십시오. 
		    	}
	        	try {
	        		insertCnt += dao.insert("com.korail.yz.ys.fa.YSFA001QMDAO.insertCustPromBsInfoExct", item);
				} catch (Exception e) {
					throw new CosmosRuntimeException("WZZ000012", null); 
					//등록 작업이 실패하였습니다.	입력값을 확인하십시오.
				}
	        }
	        else if(item.get("DMN_PRS_DV_CD").equals("U"))  /*요청처리구분코드가 U : update*/
	        {
	        	item.putAll(prevList.get(i));
	        	try {
	        		updateCnt += dao.update("com.korail.yz.ys.fa.YSFA001QMDAO.updateCustPromBsInfoExct", item);
				} catch (Exception e) {
					throw new CosmosRuntimeException("WYZ000007", null); 
					//해당 자료를 수정할수 없습니다.	수정자료를 확인하여 주십시오.
				}
	        		
	        }
	        else if(item.get("DMN_PRS_DV_CD").equals("D"))  /*요청처리구분코드가 D : delete*/
	        {
	        	item.putAll(prevList.get(i));
	        	try {
	        		deleteCnt += dao.delete("com.korail.yz.ys.fa.YSFA001QMDAO.deleteCustPromBsInfoExct", item);
				} catch (Exception e) {
					throw new CosmosRuntimeException("WYZ000009", null); 
					//해당 자료를 삭제할 수 없습니다.	삭제 자료를 확인하여 주십시오.
				}
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
}

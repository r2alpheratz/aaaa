/**
 * project : KORAIL_YZ
 * package : com.korail.yz.yb.eb
 * date : 2014. 6. 30.오전 10:17:51
 */
package com.korail.yz.yb.eb;

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
import com.korail.ws.schema.OUT_FORMAT;

import cosmos.comm.dao.CommDAO;
import cosmos.comm.exception.CosmosRuntimeException;



/**
 * @author 한현섭
 * @date 2014. 6. 30. 오전 10:17:51
 * Class description : BookingClass관리SVC
 */
@Service("com.korail.yz.yb.eb.YBEB003SVC")
public class YBEB003SVC {


	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public  final Logger LOGGER = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
 
	
	/**
	 * @author 한현섭
	 * @date 2014. 6. 30. 오전 10:46:51
	 * Method description : 부킹클래스 목록 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?>  selectListBkclLst (Map<String, ?> param){
	
 		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();

		/* 입력 오브젝트 */
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsGrdCond");
		
		
		/* DAO - 쿼리 실행 후 결과 획득*/
		List<Map<String, Object>> resultList
		= (List<Map<String, Object>>) dao.list("com.korail.yz.yb.eb.YBEB003QMDAO.selectListBkclLst", inputDataSet);

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
	 * @date 2014. 6. 30. 오전 10:46:52
	 * Method description : 부킹클래스 할인등급 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?>  selectListBkclDcntCl (Map<String, ?> param){
		
		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		
		/* 입력 오브젝트 */
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsGrdCond");
		
		/* DAO - 쿼리 실행 후 결과 획득*/
		List<Map<String, Object>> resultList
		= (List<Map<String, Object>>) dao.list("com.korail.yz.yb.eb.YBEB003QMistBkclRegQry", inputDataSet);
		
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
	 * @date 2014. 6. 30. 오전 10:46:54
	 * Method description : 부킹클래스 등록 화면 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?>  selectBkclRegQry (Map<String, ?> param){
		
		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		
		/* 입력 오브젝트 */
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsGrdCond");
		
		/* DAO - 쿼리 실행 후 결과 획득*/
		List<Map<String, Object>> resultList
		= (List<Map<String, Object>>) dao.list("com.korail.yz.yb.eb.YBEB003QMDAO.selectBkclRegQry", inputDataSet);
		
		//error 메시지 날리기
		if(resultList.isEmpty()){
			XframeControllerUtils.setMessage("IZZ000004", result);
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result);
		}
		result.put("dsGrdList", resultList);
		result.put("dsGrdListCopy", resultList);
		return result;
	}
	
	/**
	 * @author 한현섭
	 * @date 2014. 6. 30. 오전 10:46:55
	 * Method description : 신규 부킹클래스 코드를 등록
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?>  insertBkclReg (Map<String, ?> param){
		
		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		
		/* 입력 오브젝트 */
		List<Map<String, String>> inputDataArray = (List<Map<String, String>>) param.get("dsInsertCond");
		List<Map<String, String>> inputGrdArray = (List<Map<String, String>>) param.get("dsGrdListCopy");
		Map<String, String> inputAplSet = XframeControllerUtils.getParamDataSet(param, "dsInsertAplCond");
		String aplStDt = inputAplSet.get("APL_ST_DT");
		String preAplStDt = inputAplSet.get("PRE_APL_ST_DT");
		
		
		//입력일자가 다를경우 
		List<Map<String, String>> deleteList;
		List<Map<String, String>> updatedList;
		List<Map<String, String>> newInsertList;
		int updateCnt = 0;
		if(!aplStDt.equals(preAplStDt) && !preAplStDt.isEmpty()) //입력일자가 이전이력과 다른경우 && 이전이력이 존재
		{
			deleteList = (List<Map<String, String>>) dao.list("com.korail.yz.yb.eb.YBEB003QMDAO.selectListAplRows", inputAplSet);//초기 적용중인(APL_CLS_DT가 99991231인) 데이터
			try{
				LOGGER.debug("이전이력의 적용종료일자를 새로입력한 적용시작일자의 전일자로 수정!!!");
				updateCnt = dao.update("com.korail.yz.yb.eb.YBEB003QMDAO.updateHstAplDtMdfy", inputAplSet);
				updatedList = (List<Map<String, String>>) dao.list("com.korail.yz.yb.eb.YBEB003QMDAO.selectListUpdated", inputAplSet);
			}catch(Exception ex0){
				throw new CosmosRuntimeException("EYB000004", null); //이전이력의 적용종료일자를 새로 입력한 적용시작일자의 전일자로 변경 중 오류가 발생하였습니다.
			
			}
			LOGGER.debug("총 ["+updateCnt+"] 건 수정완료!!!");
			//입력한 부킹클래스를 신규이력으로 등록한다.
			int nBkclNewHstReg = insertBkclNewHstReg(inputDataArray, inputGrdArray, inputAplSet);
			if(nBkclNewHstReg < 0)
			{
				nBkclNewHstReg = Math.abs(nBkclNewHstReg);
				XframeControllerUtils.setMessage("EYB00000"+nBkclNewHstReg, result);
				return result;
			}
			//기본 부킹클래스를 가져와 나머지를 등록한다.
			int nBfHstNewRegResult = this.insertBfHstNewReg(inputAplSet);
			
				
			if(nBfHstNewRegResult < 0)
			{
				nBfHstNewRegResult = Math.abs(nBfHstNewRegResult);
				XframeControllerUtils.setMessage("EYB00000"+nBfHstNewRegResult, result);
				return result;
			}
			newInsertList = (List<Map<String, String>>) dao.list("com.korail.yz.yb.eb.YBEB003QMDAO.selectListAplRows", inputAplSet);//입력처리후 정리된 모든 데이터
			if(!deleteList.isEmpty()){
				insertIfTbBkclInfo(deleteList, "1", "D");
			}
			if(!updatedList.isEmpty()){
				insertIfTbBkclInfo(updatedList, "2", "I");
			}
			if(!newInsertList.isEmpty()){
				insertIfTbBkclInfo(newInsertList, "3", "I");
			}

			
		}else{  //입력한 날짜가 이전이력과 같은경우 || 이전이력이 없는경우
			
			deleteList = (List<Map<String, String>>) dao.list("com.korail.yz.yb.eb.YBEB003QMDAO.selectListAplRows", inputAplSet);//초기 적용중인(APL_CLS_DT가 99991231인) 데이터
			
			//입력한 부킹클래스를 신규이력으로 등록한다.
			int nBkclNewHstReg = insertBkclNewHstReg(inputDataArray, inputGrdArray, inputAplSet);
			//에러발생시 nBkclNewHstReg = -3 또는 -2 로 리턴함.
			if(nBkclNewHstReg < 0)
			{
				nBkclNewHstReg = Math.abs(nBkclNewHstReg);
				throw new CosmosRuntimeException("EYB00000"+nBkclNewHstReg, null);  ////해당 자료를 수정할수 없습니다.	수정자료를 확인하여 주십시오.
				
				//메시지코드 EYB000002 : 이미 등록되어 있는 항목입니다.
				//메시지코드 EYB000003 : 이전이력을 신규이력으로 등록하는 중에 오류가 발생하였습니다.
				//TODO : 메시지코드 수정 필요 => EYB000003 "부킹클래스 등록 중 오류가 발생하였습니다."  2015.01.01(김응규)
			}
			newInsertList = (List<Map<String, String>>) dao.list("com.korail.yz.yb.eb.YBEB003QMDAO.selectListAplRows", inputAplSet);//입력처리후 정리된 모든 데이터
			if(!deleteList.isEmpty()){
				insertIfTbBkclInfo(deleteList, "1", "D");
			}
			if(!newInsertList.isEmpty()){
				insertIfTbBkclInfo(newInsertList, "2", "I");
			}
		}
		//성공메시지 설정
		XframeControllerUtils.setMessage("IYB000008", result);
		
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
	 * @date 2014. 6. 30. 오전 10:46:56
	 * Method description : 이전이력의 B/C 코드 신규 이력으로 등록
	 * @param param
	 * @return
	 */
	public Integer insertBfHstNewReg (Map<String, String> inputDataSet){
		
		int result = 0;
		/* DAO - 쿼리 실행 후 결과 획득*/
		try{
			result = dao.insert("com.korail.yz.yb.eb.YBEB003QMDAO.insertBfHstNewReg", inputDataSet);	

		}catch(Exception e){
			result = -3;
			return result;
		}
		return result;
	}
	
	/**
	 * @author 한현섭
	 * @date 2014. 6. 30. 오전 10:46:58
	 * Method description : 입력한 부킹클래스 신규이력 등록
	 * @param param
	 * @return
	 */
	public Integer  insertBkclNewHstReg (List<Map<String, String>> inputDataArray, List<Map<String, String>> inputGrdArray, Map<String, String> inputAplSet){
		int result = 0;
		try{
			for(Map<String, String> inputDataSet : inputDataArray)
			{
				result += dao.insert("com.korail.yz.yb.eb.YBEB003QMDAO.insertBkclNewHstReg", inputDataSet);
				
			}
		}catch(Exception e){
			result = -3;
			return result;
		}
		LOGGER.debug("부킹클래스 신규입력 총 ["+result+"] 건 완료!");
		result = updateBkclCdOrdrApd (inputGrdArray, inputAplSet);
		return result;
	}
	
	/**
	 * @author 한현섭
	 * @date 2014. 6. 30. 오전 10:46:59
	 * Method description : 최상위 부킹클래스코드 순서 추가
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Integer updateBkclCdOrdrApd (List<Map<String, String>> inputGrdArray, Map<String, String> inputAplSet){
		
		 
				
		int result = 0;
		List<Map<String, Object>> resultBkclCdList;
		try{
			//최상위부킹클래스 조회 (BKCL_APL_ORDR = 1 인 부킹클래스)
			resultBkclCdList
			= (List<Map<String, Object>>) dao.list("com.korail.yz.yb.eb.YBEB003QMDAO.selectBkclCdOrdrApd", inputAplSet);
			
		}catch(Exception e){
			result = -2;
			return result;
		}
		
		try{
			for(Map<String, Object> inputDataSet : resultBkclCdList)
			{
				inputDataSet.putAll(inputAplSet);
				/*String sBkclCd = (String) inputDataSet.get("BKCL_CD");
				StringBuilder sBkclConsCont = new StringBuilder();
				sBkclConsCont.append(inputDataSet.get("BKCL_CONS_CONT"));
				
				if(sBkclCd.length() > 0)
				{
					for( int i = 0 ; i < inputGrdArray.size() ; i++)
					{
						String hBkclCd = inputGrdArray.get(i).get("HRNK_BKCL_CD");
						String stat = inputGrdArray.get(i).get("STAT");
						if( "I".equals(stat) && hBkclCd.equals(sBkclCd))
						{
							String sBkclAplOrdr = String.format("%02d", Integer.parseInt(inputGrdArray.get(i).get("BKCL_APL_ORDR")));
							sBkclConsCont.append(sBkclAplOrdr);
						}
						inputDataSet.put("BKCL_CONS_CONT", String.valueOf(sBkclConsCont));
					}
					
				}
				inputDataSet.put("BKCL_CONS_CONT", String.valueOf(sBkclConsCont));*/
				result = dao.update("com.korail.yz.yb.eb.YBEB003QMDAO.updateBkclCdOrdrApd", inputDataSet);	
			}
		}catch(Exception e){
			result = -2;
			return result;
		}
		return result;

	}
	
	/**
	 * @author 한현섭
	 * @date 2014. 6. 30. 오전 10:47:00
	 * Method description : 부킹클래스 수정화면 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?>  selectBkclMdfyQry (Map<String, ?> param){
		
		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		
		/* 입력 오브젝트 */
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsGrdCond");
		
		/* DAO - 쿼리 실행 후 결과 획득*/
		List<Map<String, Object>> resultList
		= (List<Map<String, Object>>) dao.list("com.korail.yz.yb.eb.YBEB003QMDAO.selectBkclMdfyQry", inputDataSet);
		
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
	 * @date 2014. 6. 30. 오전 10:47:01
	 * Method description : 부킹클래스 수정
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?>  updateBkclMdfy (Map<String, ?> param){
		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		
		/* 입력 오브젝트 */
		List<Map<String, String>> inputDataArray = (List<Map<String, String>>) param.get("dsUpdateCond");
		List<Map<String, String>> inputGrdArray = (List<Map<String, String>>) param.get("dsGrdListCopy");
		Map<String, String> inputAplSet = XframeControllerUtils.getParamDataSet(param, "dsUpdateAplCond");
		
		String aplStDt = inputAplSet.get("APL_ST_DT");
		String preAplStDt = inputAplSet.get("PRE_APL_ST_DT");
		
		List<Map<String, String>> deleteList;
		List<Map<String, String>> updatedList;
		List<Map<String, String>> updateRowList;
		
		
		if(!aplStDt.equals(preAplStDt))
		{
			deleteList = (List<Map<String, String>>) dao.list("com.korail.yz.yb.eb.YBEB003QMDAO.selectListAplRows", inputAplSet);//초기 적용중인(APL_CLS_DT가 99991231인) 데이터
			try{
				dao.update("com.korail.yz.yb.eb.YBEB003QMDAO.updateHstAplDtMdfy", inputAplSet);
				
			}catch(Exception ex0){
				XframeControllerUtils.setMessage("EYB000004", result);
				return result;
			}
			updatedList = (List<Map<String, String>>) dao.list("com.korail.yz.yb.eb.YBEB003QMDAO.selectListUpdated", inputAplSet);
			
			int nBkclNewHstReg = insertBkclNewHstReg(inputDataArray, inputGrdArray, inputAplSet);
			if(nBkclNewHstReg < 0)
			{
				nBkclNewHstReg = Math.abs(nBkclNewHstReg);
				XframeControllerUtils.setMessage("EYB00000"+nBkclNewHstReg, result);
				return result;
			}
			
			int nBfHstNewRegResult = this.insertBfHstNewReg(inputAplSet);
			
			if(nBfHstNewRegResult < 0)
			{
				nBfHstNewRegResult = Math.abs(nBfHstNewRegResult);
				XframeControllerUtils.setMessage("EYB00000"+nBfHstNewRegResult, result);
				return result;
			}
			updateRowList = (List<Map<String, String>>) dao.list("com.korail.yz.yb.eb.YBEB003QMDAO.selectListAplRows", inputAplSet);//입력처리후 정리된 모든 데이터
			if(!deleteList.isEmpty()){
				insertIfTbBkclInfo(deleteList, "1", "D");
			}
			if(!updatedList.isEmpty()){
				insertIfTbBkclInfo(updatedList, "2", "I");
			}
			if(!updateRowList.isEmpty()){
				insertIfTbBkclInfo(updateRowList, "3", "I");
			}
			
		}else if(!inputDataArray.isEmpty()) {
		
			//부킹클래스를 수정한다.
			Map<String, String> inputDataSet = inputDataArray.get(0);
			try{
				dao.update("com.korail.yz.yb.eb.YBEB003QMDAO.updateBkclHstMdfy", inputDataSet);
			}catch(Exception e){
				XframeControllerUtils.setMessage("EYB000004", result);
				return result;
			}
			updateRowList = (List<Map<String, String>>) dao.list("com.korail.yz.yb.eb.YBEB003QMDAO.selectListUpdRow", inputDataSet);//수정된 Row를 조회
			if(updateRowList.get(0).get("DCNT_KND_CD") == null)
			{
				updateRowList.get(0).put("DCNT_KND_CD", "");
			}
			LOGGER.debug("인터페이스 테이블이 insert 시작!!!!!!!!!!!!!!!!!!!");
			if(!updateRowList.isEmpty()){
				insertIfTbBkclInfo(updateRowList, "1", "U");
			}
			
		}else
		{
			XframeControllerUtils.setMessage("EYB000004", result);
			return result; 
		}
		
		//성공메시지 설정
		XframeControllerUtils.setMessage("IYB000009", result);
		
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
	 * @date 2014. 6. 30. 오전 10:47:03
	 * Method description : 상위할인비율 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?>  selectHrnkDcntPct (Map<String, ?> param){
		
		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		
		/* 입력 오브젝트 */
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsGrdCond");
		
		/* DAO - 쿼리 실행 후 결과 획득*/
		List<Map<String, Object>> resultList
		= (List<Map<String, Object>>) dao.list("com.korail.yz.yb.aa.YBAA001QMDAO.", inputDataSet);
		
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
	 * @date 2014. 6. 30. 오전 10:47:03
	 * Method description : 적용기간 Picklist조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?>  selectListAplTrm (Map<String, ?> param){
		
		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		
		Map<String, Object> inputDataSet = new HashMap<String, Object>();
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		inputDataSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		/* DAO - 쿼리 실행 후 결과 획득*/
		List<Map<String, Object>> resultList
		= (List<Map<String, Object>>) dao.list("com.korail.yz.yb.eb.YBEB003QMDAO.selectListAplTrm", inputDataSet);
		
		result.put("dsAplTrmPick", resultList);
		return result;
	}
	
	/**
	 * @author 김응규
	 * @date 2014. 12. 26. 오전 10:47:03
	 * Method description : 적용기간 Picklist조회2 (다중사업자 처리-사업자공통session으로 들어온경우) 
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?>  selectListAplTrm2 (Map<String, ?> param){
		
		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		
		Map<String, Object> inputDataSet = new HashMap<String, Object>();
		Map<String, Object> inputDataSet2 = new HashMap<String, Object>();
		inputDataSet.put("TRN_OPR_BZ_DV_CD", "001");
		inputDataSet2.put("TRN_OPR_BZ_DV_CD", "002");
		/* DAO - 쿼리 실행 후 결과 획득*/
		List<Map<String, Object>> resultList
		= (List<Map<String, Object>>) dao.list("com.korail.yz.yb.eb.YBEB003QMDAO.selectListAplTrm", inputDataSet);
		
		
		List<Map<String, Object>> resultList2
		= (List<Map<String, Object>>) dao.list("com.korail.yz.yb.eb.YBEB003QMDAO.selectListAplTrm", inputDataSet2);
		result.put("dsAplTrmPick", resultList);
		result.put("dsAplTrmPick2", resultList2);
		return result;
	}
	/**
	 * @author 한현섭
	 * @date 2014. 7. 5. 오후 5:35:10
	 * Method description : 해당일자 열차할당여부 확인
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?>  selectListTrnAlcYn (Map<String, ?> param){
		
		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		String dsName = "dsInsertAplCond";
		if(((List<Map<String, String>>) param.get(dsName)) == null)
		{
			dsName = "dsUpdateAplCond";
		}
		Map<String, String> inputDataSet =  XframeControllerUtils.getParamDataSet(param, dsName);
		LOGGER.debug("inputDateSet--->"+inputDataSet.toString());
		List<Map<String, Object>> resultList;
		
		/* DAO - 쿼리 실행 후 결과 획득*/
		try
		{
			resultList	= (List<Map<String, Object>>) dao.list("com.korail.yz.yb.eb.YBEB003QMDAO.selectListTrnAlcYn", inputDataSet);
		}
		
		catch(Exception e)
		{
			XframeControllerUtils.setMessage("EYB000008", result);//SQL에러메시지 출력
			return result;
		}
		
		
		result.put("dsListAlcTrn", resultList);
		return result;
	}
	
	/**
	 * @author 한현섭
	 * @date 2014. 7. 10. 오전 11:19:40
	 * Method description : 부킹클래스가 모두 적용되었는지 확인
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?>  selectListChkBlckCdApl (Map<String, ?> param){
		
		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> inputDataSet =  XframeControllerUtils.getParamDataSet(param, "dsGrdCond");
		LOGGER.debug("inputDateSet--->"+inputDataSet.toString());
		
		List<Map<String, Object>> chkList = new ArrayList<Map<String,Object>>();
		List<Map<String, Object>> resultBkclList;
		List<Map<String, Object>> resultBkclAplList;
		
		/* DAO - 쿼리 실행 후 결과 획득*/
		//공통코드 부킹클래스 조회
		try
		{
			resultBkclList	= (List<Map<String, Object>>) dao.list("com.korail.yz.yb.eb.YBEB003QMDAO.selectBkclCdQry", inputDataSet);
		}
		catch(Exception e)
		{
			XframeControllerUtils.setMessage("EYB000009", result);//SQL에러메시지 출력
			return result;
		}
		//적용중인 부킹클래스 조회
		try
		{
			resultBkclAplList	= (List<Map<String, Object>>) dao.list("com.korail.yz.yb.eb.YBEB003QMDAO.selectListBlckCdApl", inputDataSet);
		}
		catch(Exception e)
		{
			XframeControllerUtils.setMessage("EYB000009", result);//SQL에러메시지 출력
			return result;
		}
		Map<String, Object> resultSet = new HashMap<String, Object>();
		if(!resultBkclAplList.isEmpty())
		{
			if(resultBkclAplList.size() != resultBkclList.size())
			{
				resultSet.put("RESULT", "TRUE");				
				chkList.add(resultSet);
				result.put("dsChkAplBkclCd", chkList);
				return result;
			}
			
			for( int i = 0 ; i < resultBkclList.size(); i++)
			{
				
				boolean bResult = resultBkclList.get(i).get("BKCL_CD").equals(resultBkclAplList.get(i).get("BKCL_CD"));
				if(!bResult)
				{
					resultSet.put("RESULT", "TRUE");				
					chkList.add(resultSet);
					break;
				}
			}
		}
		else
		{
			resultSet.put("RESULT", "TRUE");				
			chkList.add(resultSet);
		}
		result.put("dsChkAplBkclCd", chkList);
		return result;
	}
	
	/**
	 * @author 한현섭
	 * @date 2014. 7. 23. 오후 3:35:50
	 * Method description : 부킹클래스 인터페이스 입력
	 */
	private Map<String, Object> insertIfTbBkclInfo(List<Map<String, String>> insertDataArray,String insfSqno, String insfDvCd) {
		LOGGER.debug("부킹클래스 인터페이스테이블 등록!!!!!!!!!!!!!!!");
		LOGGER.debug("param ::::  INSF_SQNO === ["+insfSqno+"], INSF_DV_CD === ["+insfDvCd+"]");
		/*for(Map<String, String> inputMap : insertDataArray)
		{
			LOGGER.debug("insertDataArray :::"+inputMap);
		}*/
		Map<String, Object> result = new HashMap<String, Object>();
		
		Map<String, String> ifInfo = new HashMap<String, String>();
		ifInfo.put("INSF_PRS_SQNO", insfSqno);
		ifInfo.put("INSF_DV_CD", insfDvCd);
		//ifInfo.put("INSF_CNQE_CONT", "");
		
		List<Map<String, Object>> resultList = new ArrayList<Map<String,Object>>();
		Map<String, Object> saveFlagMap = new HashMap<String, Object>();
		LOGGER.debug("인터페이스 테이블에 insert를 시작합니다.");
		int insertCnt = 0;
		
		for(Map<String, String> inputDataSet : insertDataArray)
		{
			inputDataSet.putAll(ifInfo);
			try {
				insertCnt += dao.insert("com.korail.yz.yb.eb.YBEB003QMDAO.insertIfTbBkclInfo", inputDataSet);
			} catch (Exception e) {
				LOGGER.debug("등록 에러 메시지 :::"+ e );
				saveFlagMap.put("FLAG", "F");
				throw new CosmosRuntimeException("WZZ000012", null);  //등록 작업이 실패하였습니다 - 입력값을 확인하십시오.
			}
			
			
		}
		LOGGER.debug("인터페이스 테이블 등록 ["+insertCnt+"] 건 수행 완료!!!!");
		if(insertCnt < 1){
			saveFlagMap.put("FLAG", "F");
			throw new CosmosRuntimeException("WZZ000012", null);  //등록 작업이 실패하였습니다 - 입력값을 확인하십시오.
			
		}else{
			saveFlagMap.put("FLAG", "T");
			
			//화면하단 메시지 처리
			XframeControllerUtils.setMessage("IZZ000013", result); //정상적으로 저장 되었습니다.
		}
		resultList.add(saveFlagMap);
		result.put("dsSaveFlag", resultList);
		return result;

		
	}

	/**
	 * @author 김응규
	 * @date 2014. 11. 17. 오전 9:35:50
	 * Method description : 부킹클래스 인터페이스 입력후 EAI 호출
	 */
	public Map<String, ?> callEaiBkclInfo(Map<String, ?> param) throws Exception
	{
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		LOGGER.debug("EAI CALL 시작TEST!!!!!!!!!!!!!!!!!");
		
		/*com.korail.ws.eai.EaiWSCall eai = new com.korail.ws.eai.EaiWSCall();*/
		/*WSURL*/
		com.korail.ws.eai.EaiWSCall eai = null;
		OUT_FORMAT out = null;
		try{
			eai = new com.korail.ws.eai.EaiWSCall();
			out = eai.eaiCall("I-R-RB-0027", null, null);
			LOGGER.debug("====================>>>>>> "+ out.getCODE());
		
		}catch (Exception e){
			LOGGER.debug(e);
		}
		/*com.korail.ws.eai.EaiWSCall eai = new com.korail.ws.eai.EaiWSCall();
		OUT_FORMAT out = eai.eaiCall("I-R-RB-0027", "");*/
		LOGGER.debug("메시지OUT ::: "+out.getMESSAGE());
		String rtnCode = out.getCODE();
		
		LOGGER.debug("Return Code:" + rtnCode);
		if(!"SYSEA0000".equals(rtnCode))            //리턴코드가 정상이 아니면 exception 발생 후 롤백
        {
            throw new Exception("EAI 에러 : " + rtnCode);
        }

		LOGGER.debug("EAI CALL 끝!!!!!!!!!!!!!!!!!");	
		
		//화면하단 메시지 처리
		XframeControllerUtils.setMessage("IZZ000013", result); //정상적으로 저장 되었습니다.
		
		return result;
	
		
	}
}



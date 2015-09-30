/**
 * project : KORAIL_YZ
 * package : com.korail.yz.yb.ca
 * date : 2014. 6. 21.오후 4:31:12
 */
package com.korail.yz.yb.ca;

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

/**
 * @author 한현섭
 * @date 2014. 6. 21. 오후 4:31:12
 * Class description : DCP기본관리 Service Class
 */
@Service("com.korail.yz.yb.ca.YBCA001SVC")
public class YBCA001SVC {


	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public  final Logger LOGGER = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
 
	
	/**
	 * @author 한현섭
	 * @date 2014. 6. 21. 오후 4:35:21
	 * Method description : 조회하고자 하는 적용기간, 주운행선, 영업일단계에 대한 DCP기본정보를 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?>  selectListYdcpLst(Map<String, ?> param){
	
 		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();

		/* 입력 오브젝트 */
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsGrdCond");

		/* DAO - 쿼리 실행 후 결과 획득*/
		List<Map<String, Object>> resultList
		= (List<Map<String, Object>>) dao.list("com.korail.yz.yb.ca.YBCA001QMDAO.selectListYdcpLst", inputDataSet);

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
	 * @date 2014. 6. 21. 오후 4:35:20
	 * Method description : DCP 기본값을 새로운 적용기간으로 생성
	 * @param param
	 * @return
	 */
	
	@SuppressWarnings({ "unchecked", "unused" })
	public Map<String, ?>  insertYdcpReg(Map<String, ?> param){
		
		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		
		/* 입력 오브젝트 */
		List<Map<String, String>> inputDataArray = (List<Map<String, String>>) param.get("dsInsertCond");
		Map<String, String> inputAplSet = XframeControllerUtils	.getParamDataSet(param, "dsInsertCondAplTrm");
		String aplStDt = inputAplSet.get("APL_ST_DT");
		String preAplStDt = inputAplSet.get("PRE_APL_ST_DT");
		/* DAO - 쿼리 실행 후 결과 획득*/
		int isSuc = 0;
		
		
		if(aplStDt.equals(preAplStDt))
		{
			try{
				for(Map<String, String> inputDataSet : inputDataArray)
				{
					isSuc = dao.insert("com.korail.yz.yb.ca.YBCA001QMDAO.insertYdcpReg", inputDataSet);	
				}
			}catch(Exception e){
				XframeControllerUtils.setMessage("EYB000002", result);
				return result;
			}
			
		}else
		{
			try{
				isSuc = dao.update("com.korail.yz.yb.ca.YBCA001QMDAO.updateHstAplDtMdfy", inputAplSet);
			}catch(Exception ex0){
				XframeControllerUtils.setMessage("EYB000004", result);
				return result;
			}
			
			
			try{
				for(Map<String, String> inputDataSet : inputDataArray)
				{
					dao.update("com.korail.yz.yb.ca.YBCA001QMDAO.insertYdcpReg", inputDataSet);
				}
			}catch(Exception ex1){
				XframeControllerUtils.setMessage("EYB000002", result);
				return result;
			}
						
			try{
				isSuc = dao.insert("com.korail.yz.yb.ca.YBCA001QMDAO.insertBfYdcpNewAlc", inputAplSet);
			}catch(Exception ex2){
				XframeControllerUtils.setMessage("EYB000003", result);
				return result;
			}

			
		}
		//성공메시지 설정
		XframeControllerUtils.setMessage("IYB000004", result);
		
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
	 * @date 2014. 6. 21. 오후 4:35:19
	 * Method description : DCP 수정을 위한 목록을 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?>  selectListYdcpMdfyLst(Map<String, ?> param){
		
		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		
		/* 입력 오브젝트 */
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsGrdCond");
		
		/* DAO - 쿼리 실행 후 결과 획득*/
		List<Map<String, Object>> resultList
		= (List<Map<String, Object>>) dao.list("com.korail.yz.yb.ca.YBCA001QMDAO.selectListYdcpMdfyLst", inputDataSet);
		
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
	 * @date 2014. 6. 21. 오후 4:35:17
	 * Method description : DCP 기본값을 변경하여 새로운 적용기간으로 생성
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?>  updateYdcpMdfy(Map<String, ?> param){
		
		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		
		/* 입력 오브젝트 */
		List<Map<String, String>> inputDataArray = (List<Map<String, String>>) param.get("dsInsertCond");
		Map<String, String> inputAplSet = XframeControllerUtils	.getParamDataSet(param, "dsInsertCondAplTrm");
		String aplStDt = inputAplSet.get("APL_ST_DT");
		String preAplStDt = inputAplSet.get("PRE_APL_ST_DT");
		/* DAO - 쿼리 실행 후 결과 획득*/
		
		
		if(aplStDt.equals(preAplStDt))
		{
			try{
				for(Map<String, String> inputDataSet : inputDataArray)
				{
					if(inputDataSet.get("DPT_BF_DT_NUM").isEmpty())
					{
						dao.update("com.korail.yz.yb.ca.YBCA001QMDAO.deleteYdcpDel", inputDataSet);
					}else
					{
						
						int isSuc = dao.update("com.korail.yz.yb.ca.YBCA001QMDAO.updateYdcpMdfy", inputDataSet);
						if(isSuc == 0)
						{
							dao.insert("com.korail.yz.yb.ca.YBCA001QMDAO.insertYdcpReg", inputDataSet);
						}
					}
						
				}
			}catch(Exception e){
				XframeControllerUtils.setMessage("EYB000002", result);
				return result;
			}
			
		}else
		{
			try{
				dao.update("com.korail.yz.yb.ca.YBCA001QMDAO.updateHstAplDtMdfy", inputAplSet);
			}catch(Exception ex0){
				XframeControllerUtils.setMessage("EYB000004", result);
				return result;
			}
			
			try{
				for(Map<String, String> inputDataSet : inputDataArray)
				{
					dao.update("com.korail.yz.yb.ca.YBCA001QMDAO.insertYdcpReg", inputDataSet);
				}
			}catch(Exception ex1){
				XframeControllerUtils.setMessage("EYB000002", result);
				return result;
			}
			
			
			try{
				dao.insert("com.korail.yz.yb.ca.YBCA001QMDAO.insertBfYdcpNewAlc", inputAplSet);
			}catch(Exception ex2){
				XframeControllerUtils.setMessage("EYB000003", result);
				return result;
			}
			

			
		}
		//성공메시지 설정
		XframeControllerUtils.setMessage("IYB000005", result);
		
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
	 * @date 2014. 6. 21. 오후 4:35:17
	 * Method description : DCP 등록 이력정보를 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?>  selectListYdcpHst(Map<String, ?> param){
		
		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		
		/* 입력 오브젝트 */
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsGrdCond");
		
		/* DAO - 쿼리 실행 후 결과 획득*/
		List<Map<String, Object>> resultList
		= (List<Map<String, Object>>) dao.list("com.korail.yz.yb.ca.YBCA001QMDAO.selectListYdcpHst", inputDataSet);
		
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
	 * @date 2014. 6. 21. 오후 5:28:18
	 * Method description : 적용기간 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?>  selectListAplTrm(Map<String, ?> param){
		
		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		
		
		
		/* DAO - 쿼리 실행 후 결과 획득*/
		List<Map<String, Object>> resultList
		= (List<Map<String, Object>>) dao.list("com.korail.yz.yb.ca.YBCA001QMDAO.selectListAplTrm", null);
		
		//error 메시지 날리기
		if(resultList.isEmpty()){
			XframeControllerUtils.setMessage("IZZ000004", result);
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result);
		}
		result.put("dsAplTrmPick", resultList);
		return result;
	}
}

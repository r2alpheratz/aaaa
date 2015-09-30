/**
 * project : KORAIL_YZ
 * package : com.korail.yz.yb.fa
 * date : 2014. 7. 8.오후 8:14:12
 */
package com.korail.yz.yb.fa;

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
 * @date 2014. 7. 8. 오후 8:14:12
 * Class description : 
 */
@Service("com.korail.yz.yb.fa.YBFA001SVC")
public class YBFA001SVC {

	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public  final Logger LOGGER = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
 
	
	/**
	 * @author 한현섭
	 * @date 2014. 7. 11. 오후 5:01:01
	 * Method description : 담당그룹 정보를 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?>  selectListCgGp(Map<String, ?> param){
	
 		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();

		/* 입력 오브젝트 */
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsGrdCondLeft");

		/* DAO - 쿼리 실행 후 결과 획득*/
		ArrayList<Map<String, Object>> resultList
		= (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.yb.fa.YBFA001QMDAO.selectListCgGp", inputDataSet);

		//error 메시지 날리기
		if(resultList.isEmpty()){
			XframeControllerUtils.setMessage("IZZ000004", result);
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result);
		}
		result.put("dsGrdListLeft", resultList);
		return result;
	}
	
	
	
	/**
	 * @author 한현섭
	 * @date 2014. 7. 11. 오후 5:01:04
	 * Method description : 담당그룹별 사용자 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?>  selectListCgGpUsr(Map<String, ?> param){
		
		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		
		/* 입력 오브젝트 */
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsGrdCondRight");
		
		/* DAO - 쿼리 실행 후 결과 획득*/
		ArrayList<Map<String, Object>> resultList
		= (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.yb.fa.YBFA001QMDAO.selectListCgGpUsr", inputDataSet);
		
		//error 메시지 날리기
		if(resultList.isEmpty()){
			XframeControllerUtils.setMessage("IZZ000004", result);
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result);
		}
		result.put("dsGrdListRight", resultList);
		return result;
	}
	

	
	/**
	 * @author 한현섭
	 * @date 2014. 7. 12. 오후 1:40:00
	 * Method description : 사용자 ID 존재여부 조회 
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?>  selectUsrChkQry(Map<String, ?> param){
		
		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		
		/* 입력 오브젝트 */
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsUsrChkCond");
		
		/* DAO - 쿼리 실행 후 결과 획득*/
		ArrayList<Map<String, Object>> resultList
		= (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.yb.fa.YBFA001QMDAO.selectUsrChkQry", inputDataSet);
		
		//error 메시지 날리기
		if(resultList.isEmpty()){
			XframeControllerUtils.setMessage("IZZ000004", result);
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result);
		}
		result.put("dsUsrChk", resultList);
		return result;
	}
	
	
	
	/**
	 * @author 한현섭
	 * @date 2014. 7. 11. 오후 5:01:05
	 * Method description : 사용자를 검색 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?>  selectListUsrQry(Map<String, ?> param){
		
		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		
		/* 입력 오브젝트 */
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsGrdCond");
		
		/* DAO - 쿼리 실행 후 결과 획득*/
		ArrayList<Map<String, Object>> resultList
		= (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.yb.fa.YBFA001QMDAO.selectListUsrQry", inputDataSet);
		
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
	 * @date 2014. 7. 12. 오후 1:40:00
	 * Method description : 그룹 ID 신규생성 
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?>  selectCgGpIdCre(Map<String, ?> param){
		
		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		
		/* DAO - 쿼리 실행 후 결과 획득*/
		ArrayList<Map<String, Object>> resultList
		= (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.yb.fa.YBFA001QMDAO.selectCgGpIdCre", null);
		
		result.put("dsGpId", resultList);
		return result;
	}
	
	/**
	 * @author 한현섭
	 * @date 2014. 7. 11. 오후 5:01:07
	 * Method description : 담당그룹등록
	 * @param param
	 * @return
	 */
	public Map<String, ?>  insertCgGpReg(Map<String, ?> param){
		
		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		
		/* 입력 오브젝트 */
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsGpIdCond");
		LOGGER.debug("inputDateSet--->"+inputDataSet.toString());
		
		/* DAO - 쿼리 실행 후 결과 획득*/
		try{
			dao.insert("com.korail.yz.yb.fa.YBFA001QMDAO.insertCgGpReg", inputDataSet);
		}catch(Exception e)
		{
			XframeControllerUtils.setMessage("EZZ000018", result);
			return result;
		}
		
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
	 * @date 2014. 7. 11. 오후 5:01:08
	 * Method description : 담당그룹수정
	 * @param param
	 * @return
	 */
	public Map<String, ?>  updateCgGpMdfy(Map<String, ?> param){
		
		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		
		/* 입력 오브젝트 */
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsGpIdCond");
		
		/* DAO - 쿼리 실행 후 결과 획득*/
		try{
			dao.insert("com.korail.yz.yb.fa.YBFA001QMDAO.updateCgGpMdfy", inputDataSet);
		}catch(Exception e)
		{
			XframeControllerUtils.setMessage("EZZ000020", result);
			return result;
		}
		XframeControllerUtils.setMessage("IZZ000012", result);
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
	 * @date 2014. 7. 11. 오후 5:01:10
	 * Method description : 담당그룹 삭제
	 * @param param
	 * @return
	 */
	public Map<String, ?>  deleteCgGpDel(Map<String, ?> param){
		
		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		
		/* 입력 오브젝트 */
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsGrdDeleteCond");
		try{
			dao.insert("com.korail.yz.yb.fa.YBFA001QMDAO.deleteCgGpDel", inputDataSet);
		}catch(Exception e)
		{
			XframeControllerUtils.setMessage("EZZ000019", result);
			return result;
		}
		XframeControllerUtils.setMessage("IZZ000011", result);
		
		return result;
	}
	
	
	
	
	/**
	 * @author 한현섭
	 * @date 2014. 7. 11. 오후 5:01:11
	 * Method description : 담당자 지정해제 시 담당자그룹사용자 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?>  selectListCgGpUsrAppQry(Map<String, ?> param){
		
		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		
		/* 입력 오브젝트 */
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsGrdCondGpUsr");
		
		/* DAO - 쿼리 실행 후 결과 획득*/
		ArrayList<Map<String, Object>> resultList
		= (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.yb.fa.YBFA001QMDAO.selectListCgGpUsrAppQry", inputDataSet);
		
		//error 메시지 날리기
		if(resultList.isEmpty()){
			XframeControllerUtils.setMessage("WYB000014", result);
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result);
		}
		result.put("dsGrdListGpUsr", resultList);
		return result;
	}
	
	
	/**
	 * @author 한현섭
	 * @date 2014. 7. 14. 오후 2:52:30
	 * Method description : 담당자 지정 / 해제 처리(삭제->입력)
	 * @param param
	 * @return
	 */
	
	@SuppressWarnings("unchecked")
	public Map<String, ?>  selectListCgGpUsrApp(Map<String, ?> param){
		
		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		
		/* 입력 오브젝트 */
		List<Map<String, String>> inputInsertDataArray = (List<Map<String, String>>) param.get("dsInsertCond");
		List<Map<String, String>> inputDeleteDataArray = (List<Map<String, String>>) param.get("dsDeleteCond");
		
		

		/* DAO - 쿼리 실행 후 결과 획득*/
		
		try{
			for(Map<String, String> inputDeleteDataSet : inputDeleteDataArray)
			{
				dao.delete("com.korail.yz.yb.fa.YBFA001QMDAO.deleteCgGpUsrAppDel", inputDeleteDataSet);
			}

		}catch(Exception e)
		{
			XframeControllerUtils.setMessage("EYB000010", result);
			return result;
		}
		try{

			for(Map<String, String> inputInsertDataSet : inputInsertDataArray)
			{
				dao.insert("com.korail.yz.yb.fa.YBFA001QMDAO.insertCgGpUsrAppReg", inputInsertDataSet);	
			}		
		}catch(Exception e)
		{
			XframeControllerUtils.setMessage("EYB000011", result);
			return result;
		}
		
		//성공메시지 설정
		XframeControllerUtils.setMessage("IYB000010", result);
		
		//성공여부 설정
		List<Map<String,String>> isSuccessList = new ArrayList<Map<String,String>>();
		Map<String,String> isSuccessSet = new HashMap<String, String>();
		
		isSuccessSet.put("FLAG", "T");
		isSuccessList.add(isSuccessSet);
		result.put("dsSaveFlag", isSuccessList);
		
		return result;
	}
	
	
	
}

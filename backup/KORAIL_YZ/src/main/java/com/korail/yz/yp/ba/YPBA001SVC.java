/**
 * project : KORAIL_YZ
 * package : com.korail.yz.yp.ba
 * date : 2014. 7. 22.오전 10:17:56
 */
package com.korail.yz.yp.ba;

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
 * @date 2014. 7. 22. 오전 10:17:56
 * Class description : 
 */
@Service("com.korail.yz.yp.ba.YPBA001SVC")
public class YPBA001SVC {

	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public  final Logger LOGGER = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
 
	
	/**
	 * @author 한현섭
	 * @date 2014. 7. 22. 오전 10:23:03
	 * Method description : 열차종, 운행기간, 열차번호별 사용자 최적화 실행정보를 조회한다.
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?>  selectListSpcTrnSpcOdQry(Map<String, ?> param){
	
 		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();

		/* 입력 오브젝트 */
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsGrdCond");
		LOGGER.debug("inputDateSet--->"+inputDataSet.toString());
		
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		if("".equals(trnOprBzDvCd) || trnOprBzDvCd == null){
			trnOprBzDvCd = "000";
		}
		inputDataSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		
		/* DAO - 쿼리 실행 후 결과 획득*/
		ArrayList<Map<String, Object>> resultList
		= (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.yp.ba.YPBA001QMDAO.selectListSpcTrnSpcOdQry", inputDataSet);

		for(int i=0;i<resultList.size() ;i++)
		{
			LOGGER.debug(resultList.get(i).toString());
		}
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
	 * @date 2014. 7. 22. 오전 10:23:14
	 * Method description : 사용자에 할당 최적화된 열차를 삭제한다.
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?>  deleteSpcTrnAlcRtAppl(Map<String, ?> param){
		
		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		
		/* 입력 오브젝트 */
		List<Map<String, String>> inputDataArray = (List<Map<String, String>>) param.get("dsDeleteCond");
		
		/* DAO - 쿼리 실행 후 결과 획득*/
		try
		{
			for(Map<String, String> inputDataSet : inputDataArray)
			{
				dao.delete("com.korail.yz.yp.ba.YPBA001QMDAO.deleteSpcTrnAlcRtAppl", inputDataSet);
			}
		}catch(Exception e)
		{
			XframeControllerUtils.setMessage("EZZ000019", result);
		}
		
		XframeControllerUtils.setMessage("IZZ000011", result);
		return result;
	}
	
	
	
	
	/**
	 * @author 한현섭
	 * @date 2014. 7. 30. 오후 2:55:55
	 * Method description : 특정열차할당비율적용입력저장
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?>  insertSpcTrnAlcRtAppl(Map<String, ?> param){
		
		String usrId = XframeControllerUtils.getUserId(param);
		
		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		
		/* 입력 오브젝트 */
		List<Map<String, String>> inputDataArray = (List<Map<String, String>>) param.get("dsInsertCond");
		
		/* DAO - 쿼리 실행 후 결과 획득*/
		try
		{
			for(Map<String, String> inputDataSet : inputDataArray)
			{
				inputDataSet.put("USR_ID", usrId);
				dao.insert("com.korail.yz.yp.ba.YPBA001QMDAO.insertSpcTrnAlcRtAppl", inputDataSet);
			}
		}catch(Exception e)
		{
			XframeControllerUtils.setMessage("EZZ000019", result);
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
	 * @date 2014. 7. 30. 오후 2:55:53
	 * Method description : 특정열차할당비율적용수정저장
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?>  updateSpcTrnAlcRtAppl(Map<String, ?> param){
		
		String usrId = XframeControllerUtils.getUserId(param);
		
		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		
		/* 입력 오브젝트 */
		List<Map<String, String>> inputDataArray = (List<Map<String, String>>) param.get("dsUpdateCond");
		
		/* DAO - 쿼리 실행 후 결과 획득*/
		try
		{
			for(Map<String, String> inputDataSet : inputDataArray)
			{
				inputDataSet.put("USR_ID", usrId);
				dao.update("com.korail.yz.yp.ba.YPBA001QMDAO.updateSpcTrnAlcRtAppl", inputDataSet);
			}
		}catch(Exception e)
		{
			XframeControllerUtils.setMessage("EZZ000019", result);
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
	 * @date 2014. 7. 30. 오후 2:55:49
	 * Method description : 특정 열차의 지정된 할당항목을 조회한다.
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?>  selectListTrnAlcRtAppl (Map<String, ?> param){
		
 		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();

		/* 입력 오브젝트 */
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");
		LOGGER.debug("inputDateSet--->"+inputDataSet.toString());

		/* DAO - 쿼리 실행 후 결과 획득*/
		ArrayList<Map<String, Object>> resultList
		= (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.yp.ba.YPBA001QMDAO.selectListTrnAlcRtAppl", inputDataSet);

		for(int i=0;i<resultList.size() ;i++)
		{
			LOGGER.debug(resultList.get(i).toString());
		}
		//error 메시지 날리기
		if(resultList.isEmpty()){
			XframeControllerUtils.setMessage("IZZ000004", result);
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result);
		}
		result.put("dsInsertList", resultList);
		return result;
	}
	
	
	/**
	 * @author 한현섭
	 * @date 2014. 7. 30. 오후 2:55:51
	 * Method description : 특정 열차의 지정되지 않은 할당항목을 조회한다.
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?>  selectListTrnNonAlcRtAppl(Map<String, ?> param){
		
 		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();

		/* 입력 오브젝트 */
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");
		LOGGER.debug("inputDateSet--->"+inputDataSet.toString());

		/* DAO - 쿼리 실행 후 결과 획득*/
		ArrayList<Map<String, Object>> resultList
		= (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.yp.ba.YPBA001QMDAO.selectListTrnNonAlcRtAppl", inputDataSet);

		for(int i=0;i<resultList.size() ;i++)
		{
			LOGGER.debug(resultList.get(i).toString());
		}
		//error 메시지 날리기
		if(resultList.isEmpty()){
			XframeControllerUtils.setMessage("IZZ000004", result);
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result);
		}
		result.put("dsLeftList", resultList);
		return result;
	}
	
	
	
}

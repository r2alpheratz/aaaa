/**
 * project : KORAIL_YZ
 * package : com.korail.yz.yb.fa
 * date : 2014. 7. 8.오후 9:50:36
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
 * @date 2014. 7. 8. 오후 9:50:36
 * Class description : 
 */
@Service("com.korail.yz.yb.fa.YBFA002SVC")
public class YBFA002SVC {


	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public  final Logger LOGGER = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
 
	
	/**
	 * @author 한현섭
	 * @date 2014. 7. 8. 오후 10:05:29
	 * Method description : 담당열차 그룹정보 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?>  selectListCgTrnGp(Map<String, ?> param){
	
 		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();

		/* 입력 오브젝트 */
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsGrdCond");

		/* DAO - 쿼리 실행 후 결과 획득*/
		ArrayList<Map<String, Object>> resultList
		= (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.yb.fa.YBFA002QMDAO.selectListCgTrnGp", inputDataSet);
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
	 * @date 2014. 7. 8. 오후 10:05:27
	 * Method description : 담당열차그룹등록조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?>  selectListCgTrnGpRegQry(Map<String, ?> param){
		
		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		
		/* 입력 오브젝트 */
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsGrdCond");
		
		/* DAO - 쿼리 실행 후 결과 획득*/
		ArrayList<Map<String, Object>> resultList
		= (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.yb.fa.YBFA002QMDAO.selectListCgTrnGpSvQry", inputDataSet);
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
	 * @date 2014. 7. 8. 오후 10:05:24
	 * Method description :  담당열차그룹 저장
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?>  insertCgTrnGpSv(Map<String, ?> param){
		
		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		
		/* 입력 오브젝트 */
		List<Map<String, String>> inputDataArray = (List<Map<String, String>>) param.get("dsSaveCond");
		String inputFlag = XframeControllerUtils.getParamData(param, "dsFlag", "FLAG");
		
		
		/* DAO - 쿼리 실행 후 결과 획득*/
		try
		{
			if("INSERT".equals(inputFlag))
			{
				
					for(Map<String, String> inputDataSet : inputDataArray)
					{
						dao.insert("com.korail.yz.yb.fa.YBFA002QMDAO.insertCgTrnGpReg", inputDataSet);
					}
		
			}
			else
			{
				for(Map<String, String> inputDataSet : inputDataArray)
				{
					dao.update("com.korail.yz.yb.fa.YBFA002QMDAO.updateCgTrnGpMdfy", inputDataSet);
				}


			}
		}catch (Exception e) {
			String sMsg = ("INSERT".equals(inputFlag)) ? "EZZ000018" : "EZZ000020";
			XframeControllerUtils.setMessage(sMsg, result);
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
	 * @date 2014. 7. 8. 오후 10:05:23
	 * Method description : 노선적용기간과 노선등록여부를 확인
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?>  selectRoutCfm(Map<String, ?> param){
		
		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		
		/* 입력 오브젝트 */
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsAplRegCond");
		
		//노선적용기간 확인
		ArrayList<Map<String, Object>> resultAplList
		= (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.yb.fa.YBFA002QMDAO.selectRoutAplTrmCfm", inputDataSet);
		//노선등록여부 확인
		ArrayList<Map<String, Object>> resultRegList
		= (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.yb.fa.YBFA002QMDAO.selectRoutRegFlgCfm", inputDataSet);
		
		ArrayList<Map<String, Object>> resultList = new ArrayList<Map<String,Object>>();
		Map<String, Object> resultSet = new HashMap<String, Object>();
		
		
		if(resultAplList.isEmpty())
		{
			resultSet.put("TYPE", "APL");
		}else if(!resultRegList.isEmpty())
		{
			resultSet.put("TYPE", "REG");			
		}else
		{
			resultSet.put("TYPE", "NON");			
		}
		
		resultList.add(resultSet);

		
		result.put("dsAplRegResult", resultList);
		return result;
	}
	
	
	
	/**
	 * @author 한현섭
	 * @date 2014. 7. 18. 오후 2:45:40
	 * Method description : 사용자그룹조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?>  selectListUsrGp(Map<String, ?> param){
		
		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		
		/* DAO - 쿼리 실행 후 결과 획득*/
		ArrayList<Map<String, Object>> resultList
		= (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.yb.fa.YBFA002QMDAO.selectListUsrGp", null);
		
		for(int i=0;i<resultList.size() ;i++)
		{
			LOGGER.debug(resultList.get(i).toString());
		}

		result.put("dsUsrGpPick", resultList);
		return result;
	}
}

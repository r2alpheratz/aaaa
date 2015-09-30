/**
 * project : KORAIL_YZ
 * package : com.korail.yz.yb.db
 * date : 2014. 5. 5.오후 12:28:04
 */
package com.korail.yz.yb.db;

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

/**
 * @author 한현섭
 * @date 2014. 5. 5. 오후 12:28:04
 * Class description : 
 */
@Service("com.korail.yz.yb.db.YBDB001SVC")
public class YBDB001SVC {
	@Resource(name = "commDAO")
	private CommDAO dao;
	
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public  final Logger logger = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
 

	/**
	 * @author 한현섭
	 * @date 2014. 5. 5. 오후 12:31:48
	 * Method description : 수송계획과 열차번호의 매핑정보를 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListTrnTmwdMppgLst(Map<String, ?> param){
		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		
		/* 입력 오브젝트 */
		Map<String, String> inputDataSet = XframeControllerUtils.getParamDataSet(param, "dsGrdListCond");

		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		if("".equals(trnOprBzDvCd) || trnOprBzDvCd == null){
			trnOprBzDvCd = "000";
		}
		inputDataSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		
		/* DAO - 쿼리 실행 후 결과 획득 */
		ArrayList<Map<String, Object>> resultList
		= (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.yb.db.YBDB001QMDAO.selectListTrnTmwdMppgLst", inputDataSet);

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
	 * @date 2014. 5. 5. 오후 12:31:50
	 * Method description : 열차시간대 매핑정보를 수정
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> updateListTrnTmwdMppgMdfy(Map<String, ?> param){
		/* 리턴 오브젝트 */
		Map<String, Object> result =new HashMap<String, Object>(); 
		
		/* 입력 오브젝트 */
		ArrayList<Map<String, String>> inputDataList =	(ArrayList<Map<String, String>>) param.get("dsSaveGrdListChgCond");
		
		logger.debug("inputDateSet--->"+inputDataList.toString());

		/* DAO - 쿼리 실행 후 결과 획득 */
		for(Map<String, String> inputDataSet : inputDataList){
			try
			{
				
				dao.update("com.korail.yz.yb.db.YBDB001QMDAO.updateListTrnTmwdMppgMdfy", inputDataSet);
			}
			catch (Exception e)
			{
				XframeControllerUtils.setMessage("EYB000001", result);
				return result;
			}
		}

		XframeControllerUtils.setMessage("IZZ000013", result);
		return result;
		
	}
	
	
	/**
	 * @author 한현섭
	 * @date 2014. 5. 5. 오후 3:51:11
	 * Method description : 수송계획번호 / 수송계획 변경차수 세팅
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> setListCgrPln(Map<String, ?> param){
		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		
		/* 입력 오브젝트 */
		Map<String, String> inputDataSetForCgrPlnChgDegr = new HashMap<String, String>(); // 수송계획변경차수 조회 조건
		String cgrPlnNo = XframeControllerUtils.getParamData(param, "dsCgrPlnNoCond", "CRG_PLN_NO");
		
		logger.debug("inputDateSet--->"+cgrPlnNo);
		ArrayList<Map<String, Object>> resultCgrPlnNoList = null;
		ArrayList<Map<String, Object>> resultListCgrPlnChgDegr = null;
		/* DAO - 쿼리 실행 후 결과 획득 */
		
		if ("".equals(cgrPlnNo))
		{	
			resultCgrPlnNoList
			= (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.yb.db.YBDB001QMDAO.selectListCgrPlnNo", null);
			
			cgrPlnNo = (String) resultCgrPlnNoList.get(0).get("CODE");
			result.put("dsCgrPlnNo", resultCgrPlnNoList);
		}
		
		inputDataSetForCgrPlnChgDegr.put("CRG_PLN_NO", cgrPlnNo);
		
		resultListCgrPlnChgDegr
		= (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.yb.db.YBDB001QMDAO.selectListCgrPlnChgDegr", inputDataSetForCgrPlnChgDegr);
		
		result.put("dsCgrPlnChgDegr", resultListCgrPlnChgDegr);
		return result;
		
	}
	
	
	/**
	 * @author 한현섭
	 * @date 2014. 5. 8. 오전 9:12:21
	 * Method description : 그리드 내에 전수송계획 콤보박스에 필요한 열차번호를 조회하는 메서드
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListTrnNo(Map<String, ?> param){
		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		
		/* 입력 오브젝트 */
		Map<String, String> inputDataSet = XframeControllerUtils.getParamDataSet(param, "dsGrdComboListCond");
		
		logger.debug("inputDateSet--->"+inputDataSet);
		
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		if("".equals(trnOprBzDvCd) || trnOprBzDvCd == null){
			trnOprBzDvCd = "000";
		}
		inputDataSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		
		/* DAO - 쿼리 실행 후 결과 획득 */
		 ArrayList<Map<String, Object>> resultList
			= (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.yb.db.YBDB001QMDAO.selectListTrnNo", inputDataSet);
		
		if( resultList.isEmpty()){
			Map<String, Object> resultSet = new HashMap<String, Object>();
			resultSet.put("TRN_NO", "00000");
			resultSet.put("TRN_NO_DESC", "00000");
			
		}
		 
		for(int i = 0 ; i < 10 ; i++)
		{
			if(resultList.size() > i)
			{
				logger.debug(resultList.get(i).toString());
			}
		}
		//error 메시지 날리기
		if(resultList.isEmpty()){
			XframeControllerUtils.setMessage("IZZ000004", result);
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result);
		}
		result.put("dsGrdComboList", resultList);
		return result;
		
	}
}

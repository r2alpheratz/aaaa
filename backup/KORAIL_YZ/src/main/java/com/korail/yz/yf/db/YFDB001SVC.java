/**
 * project : KORAIL_YZ
 * package : com.korail.yz.yf.db
 * date : 2014. 8. 20.오전 10:34:29
 */
package com.korail.yz.yf.db;

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
 * @date 2014. 8. 20. 오전 10:34:29
 * Class description : 공석할당예측 조회
 */

@Service("com.korail.yz.yf.db.YFDB001SVC")
public class YFDB001SVC {

	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public  final Logger LOGGER = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
 
	
	/**
	 * @author 한현섭
	 * @date 2014. 8. 20. 오전 10:35:20
	 * Method description : 상품할당공석예측 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListGdAlcEptsFcst(Map<String, ?> param){
	
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
		= (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.yf.db.YFDB001QMDAO.selectListGdAlcEptsFcst", inputDataSet);

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
	 * @date 2014. 9. 25. 오전 8:04:39
	 * Method description : 상품할당공석설정내역 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListGdAlcEptsFcstMng(Map<String, ?> param){
		
		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		
		/* 입력 오브젝트 */
		//Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsGrdCond");
		//LOGGER.debug("inputDateSet--->"+inputDataSet.toString());
		
		/* DAO - 쿼리 실행 후 결과 획득*/
		ArrayList<Map<String, Object>> resultList
		= (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.yf.db.YFDB001QMDAO.selectListGdAlcEptsFcstMng", null);
		
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
	 * @date 2014. 9. 25. 오전 8:04:15
	 * Method description : 상품할당공석설정값 저장
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> updateGdAlcEptsFcstMng(Map<String, ?> param){
		
		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
			//메시지 오브젝트
		ArrayList<Map<String, String>> msgList = new ArrayList<Map<String,String>>();
		Map<String, String> msgSet = new HashMap<String, String>();
		
		/* 입력 오브젝트 */
		Map<String, String> inputCommDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCommCond");
		ArrayList<Map<String, Object>> inputDataList = (ArrayList<Map<String, Object>>) param.get("dsGrdList");
		
		ArrayList<Map<String, Object>> insertDataList = new ArrayList<Map<String,Object>>();
		ArrayList<Map<String, Object>> updateDataList = new ArrayList<Map<String,Object>>();
		ArrayList<Map<String, Object>> deleteDataList = new ArrayList<Map<String,Object>>();
		
		String preAplStDt = inputCommDataSet.get("PRE_APL_ST_DT");
		String aplStDt = inputCommDataSet.get("APL_ST_DT");
		String userId = XframeControllerUtils.getUserId(param);
		
		inputCommDataSet.put("USR_ID", userId);
		
		//분류
		for(Map<String, Object> tempSet : inputDataList)
		{
			String sStat = (String) tempSet.get("DMD_PRS_DV_CD");
			if("I".equals(sStat))
			{
				tempSet.putAll(inputCommDataSet);
				insertDataList.add(tempSet);
			}else if("U".equals(sStat))
			{
				tempSet.putAll(inputCommDataSet);
				updateDataList.add(tempSet);
			}else if("D".equals(sStat))
			{
				tempSet.putAll(inputCommDataSet);
				deleteDataList.add(tempSet);
			}
		}
		try{
		/* DAO - 쿼리 실행 */
		//적용시작일자 동일			
			if(aplStDt.equals(preAplStDt))
			{	
				//삭제항목입력
				for(Map<String, Object> dataSet : deleteDataList)
				{
					dao.delete("com.korail.yz.yf.db.YFDB001QMDAO.deleteGdAlcEptsFcstMng", dataSet);
				}
				
				//수정항목입력
				for(Map<String, Object> dataSet : updateDataList)
				{
					dao.update("com.korail.yz.yf.db.YFDB001QMDAO.updateGdAlcEptsFcstMng", dataSet);
				}
				
				//등록항목입력
				for(Map<String, Object> dataSet : insertDataList)
				{
					dao.insert("com.korail.yz.yf.db.YFDB001QMDAO.insertGdAlcEptsFcstMng", dataSet);
				}
			}else
			{
				//삭제항목입력
				for(Map<String, Object> dataSet : deleteDataList)
				{
					dao.delete("com.korail.yz.yf.db.YFDB001QMDAO.deleteGdAlcEptsFcstMng", dataSet);
				}
				
				//기존항목의 적용종료일자를 신규 적용시작일 전일로 변경
				dao.update("com.korail.yz.yf.db.YFDB001QMDAO.updateFastGdAlcEpt", inputCommDataSet);
				
				
				//수정항목입력
				for(Map<String, Object> dataSet : updateDataList)
				{
					dao.update("com.korail.yz.yf.db.YFDB001QMDAO.insertGdAlcEptsFcstMng", dataSet);
				}
				
				//이전이력중 수정되지 않은 항목을 현재 이력으로 가져온다.
				dao.insert("com.korail.yz.yf.db.YFDB001QMDAO.insertFastGdAlcEpt", inputCommDataSet);			
				
				//등록항목입력
				for(Map<String, Object> dataSet : insertDataList)
				{
					dao.insert("com.korail.yz.yf.db.YFDB001QMDAO.insertGdAlcEptsFcstMng", dataSet);
				}
			}
		} catch ( Exception e)
		{
			//error 메시지 날리기
			LOGGER.debug(String.valueOf(e));
//			e.printStackTrace();
			msgSet.put("MSG_CONT", "저장 중 오류가 발생하였습니다.");
			msgSet.put("MSG_IS_SUC", "F");
			msgList.add(msgSet);
			result.put("dsMsg", msgList);
			return result;
		}
		
		msgSet.put("MSG_CONT", "성공적으로 저장되었습니다.");
		msgSet.put("MSG_IS_SUC", "T");
		msgList.add(msgSet);
		result.put("dsMsg", msgList);
		return result;
	}
	
	/**
	 * @author 나윤채
	 * @date 2014. 11. 2. 오후 8:36:02
	 * Method description : 상품할당공석기준 이력조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListGdAlcEptsPastMng(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> condMap = XframeControllerUtils.getParamDataSet(param, "dsCond");

		LOGGER.debug("param ==> "+param);

		ArrayList<Map<String, Object>> resultList = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.yf.db.YFDB001QMDAO.selectListGdAlcEptsPastMng",condMap);			
		
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
	 * @author 나윤채
	 * @date 2014. 12. 3. 오후 2:57:13
	 * Method description : 모든 상품할당공석기준 이력조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListGdAlcEptsAllPastMng(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> condMap = XframeControllerUtils.getParamDataSet(param, "dsCond");
		
		LOGGER.debug("param ==> "+param);
		
		ArrayList<Map<String, Object>> resultList = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.yf.db.YFDB001QMDAO.selectListGdAlcEptsAllPastMng",condMap);			
		
		//error 메시지 날리기
		if(resultList.isEmpty()){
			XframeControllerUtils.setMessage("IZZ000004", result);
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result);
		}
		result.put("dsGrdListCmpr", resultList);
		return result;
	}
	
	/**
	 * @author 나윤채
	 * @date 2014. 11. 4. 오전 9:12:12
	 * Method description : 상품할당공석기준 기간조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListGdAlcPeriod(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		ArrayList<Map<String, Object>> resultList = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.yf.db.YFDB001QMDAO.selectListGdAlcPeriod", result);			
		
		//error 메시지 날리기
		if(resultList.isEmpty()){
			XframeControllerUtils.setMessage("IZZ000004", result);
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result);
		}
		result.put("dsHst", resultList);
		return result;
	}

	/**
	 * @author 나윤채
	 * @date 2014. 11. 11. 오후 6:37:48
	 * Class description : 예외열차 상품할당공석기준 기간 조회
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListExctGdAlcPeriod(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		ArrayList<Map<String, Object>> resultList = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.yf.db.YFDB001QMDAO.selectListExctGdAlcPeriod", result);			
		
		//error 메시지 날리기
		if(resultList.isEmpty()){
			XframeControllerUtils.setMessage("IZZ000004", result);
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result);
		}
		result.put("dsHst", resultList);
		return result;
	}
	
	/**
	 * @author 나윤채
	 * @date 2014. 11. 11. 오후 6:38:46
	 * Method description : 모든 예외열차 상품할당공석기준 이력조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListExctGdAlcEptsPastMng(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> condMap = XframeControllerUtils.getParamDataSet(param, "dsCond");

		LOGGER.debug("param ==> "+param);

		ArrayList<Map<String, Object>> resultList = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.yf.db.YFDB001QMDAO.selectListExctGdAlcEptsPastMng",condMap);			
		
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
	 * @author 나윤채
	 * @date 2014. 12. 1. 오후 5:50:40
	 * Method description : 예외열차 상품할당공석기준 모든 이력조회 (비교용)
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListExctGdAlcEptsAllPastMng(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> condMap = XframeControllerUtils.getParamDataSet(param, "dsCond");
		
		LOGGER.debug("param ==> "+param);
		
		ArrayList<Map<String, Object>> resultList = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.yf.db.YFDB001QMDAO.selectListExctGdAlcEptsAllPastMng",condMap);			
		
		//error 메시지 날리기
		if(resultList.isEmpty()){
			XframeControllerUtils.setMessage("IZZ000004", result);
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result);
		}
		result.put("dsGrdListCmpr", resultList);
		return result;
	}

	/**
	 * @author 나윤채
	 * @date 2014. 12. 9. 오전 11:33:04
	 * Method description : 예외열차 상품할당 열차종별 검색
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListTrnClsfCd(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> condMap = XframeControllerUtils.getParamDataSet(param, "dsCommCond");
				
		LOGGER.debug("param ==> "+param);
		
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		if("".equals(trnOprBzDvCd) || trnOprBzDvCd == null){
			trnOprBzDvCd = "000";
		}
		condMap.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		
		boolean bln;
		ArrayList<Map<String, Object>> resultList = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.yf.db.YFDB001QMDAO.selectListTrnClsfCd1",condMap);			
		
		bln = resultList.isEmpty();
		if (!bln)
		{
			result.put("dsTrnClsfCd", resultList);
		}else
		{
			ArrayList<Map<String, Object>> resultList2 = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.yf.db.YFDB001QMDAO.selectListTrnClsfCd2",condMap);			
			
			bln = resultList2.isEmpty();
			
			if(!bln)
			{
				result.put("dsTrnClsfCd", resultList2);
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
		return result;
	}
	
	/**
	 * @author 나윤채
	 * @date 2014. 11. 17. 오후 6:03:33
	 * Method description : 예외열차 상품할당공석설정값 저장
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> updateExctGdAlcEptsFcstMng(Map<String, ?> param){
		
		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
			//메시지 오브젝트
		ArrayList<Map<String, String>> msgList = new ArrayList<Map<String,String>>();
		Map<String, String> msgSet = new HashMap<String, String>();
		
		/* 입력 오브젝트 */
		ArrayList<Map<String, Object>> inputDataList = (ArrayList<Map<String, Object>>) param.get("dsGrdList");
		
		ArrayList<Map<String, Object>> insertDataList = new ArrayList<Map<String,Object>>();
		ArrayList<Map<String, Object>> updateDataList = new ArrayList<Map<String,Object>>();
		ArrayList<Map<String, Object>> deleteDataList = new ArrayList<Map<String,Object>>();
		
		String userId = XframeControllerUtils.getUserId(param);
		
		//분류
		for(Map<String, Object> tempSet : inputDataList)
		{
			tempSet.put("USR_ID", userId);
			
			String sStat = (String) tempSet.get("DMD_PRS_DV_CD");
			if("I".equals(sStat))
			{
//				tempSet.putAll(inputCommDataSet);
				insertDataList.add(tempSet);
			}else if("U".equals(sStat))
			{
//				tempSet.putAll(inputCommDataSet);
				updateDataList.add(tempSet);
			}else if("D".equals(sStat))
			{
//				tempSet.putAll(inputCommDataSet);
				deleteDataList.add(tempSet);
			}
		}
		try{
		/* DAO - 쿼리 실행 */
		//적용시작일자 동일			
				//삭제항목입력
			
			if(!deleteDataList.isEmpty())
			{
				for(Map<String, Object> dataSet : deleteDataList)
				{
					dao.delete("com.korail.yz.yf.db.YFDB001QMDAO.deleteExctGdAlcEptsFcstMng", dataSet);
				}
			}
			
			if(!updateDataList.isEmpty())
			{
				//수정항목입력
				for(Map<String, Object> dataSet : updateDataList)
				{
					dao.update("com.korail.yz.yf.db.YFDB001QMDAO.updateExctGdAlcEptsFcstMng", dataSet);
				}
			}
			
			if(!insertDataList.isEmpty())
			{
				//등록항목입력
				for(Map<String, Object> dataSet : insertDataList)
				{
					dao.insert("com.korail.yz.yf.db.YFDB001QMDAO.insertExctGdAlcEptsFcstMng", dataSet);
				}
			}
		} catch ( Exception e)
		{
			//error 메시지 날리기
			LOGGER.debug(String.valueOf(e));
//			e.printStackTrace();
			msgSet.put("MSG_CONT", "저장 중 오류가 발생하였습니다.");
			msgSet.put("MSG_IS_SUC", "F");
			msgList.add(msgSet);
			result.put("dsMsg", msgList);
			return result;
		}
		
		msgSet.put("MSG_CONT", "성공적으로 저장되었습니다.");
		msgSet.put("MSG_IS_SUC", "T");
		msgList.add(msgSet);
		result.put("dsMsg", msgList);
		return result;
	}
}

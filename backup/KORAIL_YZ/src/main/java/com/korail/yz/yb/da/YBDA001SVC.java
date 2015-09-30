/**
 * project : KORAIL_YZ
 * package : com.korail.yz.yb.da
 * date : 2014. 4. 25.오후 6:19:38
 */
package com.korail.yz.yb.da;

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
 * @date 2014. 4. 25. 오후 6:19:38
 * Class description : 카렌다조회SVC, 카렌다 정보 조회 및 일별 상세정보 관리를 위한 Service 클래스
 */
@Service("com.korail.yz.yb.da.YBDA001SVC")
public class YBDA001SVC {


	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public  final Logger logger = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
 
	
	/**
	 * @author 한현섭
	 * @date 2014. 4. 25. 오후 6:25:08
	 * Method description : CALENDAR목록,  월별 카렌다 목록을 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?>  selectListCalLst (Map<String, ?> param){
 		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();

		/* 입력 오브젝트 */
		Map<String, String> inputDataSet = XframeControllerUtils.getParamDataSet(param, "dsCalendarCond");
		
		/* 사업자구분코드 삽입*/
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		if("".equals(trnOprBzDvCd) || trnOprBzDvCd == null){
			trnOprBzDvCd = "000";
		}
		inputDataSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		
		/* DAO - 쿼리 실행 후 결과 획득*/
		ArrayList<Map<String, Object>> resultList
		= (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.yb.da.YBDA001QMDAO.selectListCalLst", inputDataSet);

		//error 메시지 날리기
		if(resultList.isEmpty()){
			XframeControllerUtils.setMessage("IZZ000004", result);
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result);
		}
		result.put("dsCalendar", resultList);
		return result;
	
	}

	
	
	/**
	 * @author 한현섭
	 * @date 2014. 4. 25. 오후 6:25:10
	 * Method description : CALENDAR상세, 선택한 카렌다 일자의 상세 내용을 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?>  selectCalDtl (Map<String, ?> param){
		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		
		/* 입력 오브젝트 */
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCalDtlCond");
		
		/* 사업자구분코드 삽입*/
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		if("".equals(trnOprBzDvCd) || trnOprBzDvCd == null){
			trnOprBzDvCd = "000";
		}
		inputDataSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		
		/* DAO - 쿼리 실행 후 결과 획득*/
		ArrayList<Map<String, Object>> resultList
		= (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.yb.da.YBDA001QMDAO.selectCalDtl", inputDataSet);
		
		//error 메시지 날리기
		if(resultList.isEmpty()){
			XframeControllerUtils.setMessage("IZZ000004", result);
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result);
		}
		result.put("dsCalDtl", resultList);
		return result;
		
	}
	
	/**
	 * @author 한현섭
	 * @date 2014. 4. 25. 오후 6:25:11
	 * Method description : 사용자정보수정, 사용자 입력정보 항목을 등록
	 * @param param
	 * @return
	 */
	
	public Map<String, ?>  updateUsrInfoMdfy (Map<String, ?> param){
		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		
		/* 입력 오브젝트 */
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsUsrIptInfoCont");
		
		/* 사업자구분코드 삽입*/
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		if("".equals(trnOprBzDvCd) || trnOprBzDvCd == null){
			trnOprBzDvCd = "000";
		}
		inputDataSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
				
		/* DAO - 쿼리 실행 후 결과 획득*/
		
		try{
			dao.update("com.korail.yz.yb.da.YBDA001QMDAO.updateUsrInfoMdfy", inputDataSet);
			
		}catch(Exception e){
			XframeControllerUtils.setMessage("EZZ000017", result);
			return result;
		}
		
		XframeControllerUtils.setMessage("IZZ000012", result);
		return result;
	}
	
	/**
	 * @author 한현섭
	 * @date 2014. 5. 8. 오후 4:49:33
	 * Method description : 조회년월 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?>  selectMinMaxYrMm (Map<String, ?> param){
		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		
		/* DAO - 쿼리 실행 후 결과 획득*/
		ArrayList<Map<String, Object>> resultList
		= (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.yb.da.YBDA001QMDAO.selectMinMaxYrMm", null);
		
		for(int i=0;i<resultList.size() ;i++)
		{
			logger.debug(resultList.get(i).toString());
		}
		//error 메시지 날리기
		if(resultList.isEmpty()){
			XframeControllerUtils.setMessage("IZZ000004", result);
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result);
		}
		result.put("dsYyMmResult", resultList);
		return result;
		
	}
}

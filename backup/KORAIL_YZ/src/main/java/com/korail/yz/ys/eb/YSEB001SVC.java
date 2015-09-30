/**
 * project : KORAIL_YZ
 * package : com.korail.yz.ys.ca
 * date : 2014. 5. 19.오전 9:06:51
 */
package com.korail.yz.ys.eb;

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
 * @author EQ
 * @date 2014. 5. 27. 오후 4:06:51
 * Class description : 초과예약작업처리결과조회SVC
 * 초과예약 작업처리 결과조회를 위한 Service 클래스
 */
@Service("com.korail.yz.ys.eb.YSEB001SVC")
public class YSEB001SVC {
	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public  static final Logger  LOGGER = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
	
	
	
	/**
	 * 이탈전이 발매VS4주평균 조회
	 * @author 김응규
	 * @date 2014. 4. 6. 오전 11:53:00
	 * Method description : 이탈전이 발매 VS 4주평균 조회(속도 개선 후)
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map<String, ?> selectListSpllRecpSaleVs4Wk(Map<String, ?> param) {		

		Map<String, Object> result = new HashMap<String, Object>();

		LOGGER.debug("param ==> "+param);
		// search input column dataset
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");
		//열차운영사업자구분코드 추가
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		inputDataSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		LOGGER.debug("inputDataSet ==>  " + inputDataSet);
		
		//이탈전이 조회대상일자 검색 (List로 가져와서 String형으로 변환 -- sql IN 조건문에서 사용하기위함)
		ArrayList<Map<String, String>> runDtList = (ArrayList) dao.list("com.korail.yz.ys.eb.YSEB001QMDAO.selectListSpllRecpDt", inputDataSet);
		StringBuffer strRunDtList = new StringBuffer("('");
		for(int i = 0; i < runDtList.size(); i++)
		{
			if(i == runDtList.size() - 1)
			{
				strRunDtList.append(runDtList.get(i).get("RUN_DT")).append("')");
			}else{
				strRunDtList.append(runDtList.get(i).get("RUN_DT")).append("', '");
			}
		}
		inputDataSet.put("RUN_DT_LIST", String.valueOf(strRunDtList));
		
		//strRunDtList4Wk : (최근4주 + 오늘날짜)   
		StringBuffer strRunDtList4Wk = new StringBuffer("('");
		for(int i = 0; i < 5; i++)
		{
			if(i == 4)
			{
				strRunDtList4Wk.append(runDtList.get(i).get("RUN_DT")).append("')");
			}else{
				strRunDtList4Wk.append(runDtList.get(i).get("RUN_DT")).append("', '");
			}
			inputDataSet.put("RUN_DT_".concat(String.valueOf((i+1))), runDtList.get(i).get("RUN_DT"));
		}
		LOGGER.debug("오늘포함 4주 날짜 == "+strRunDtList4Wk);
		inputDataSet.put("RUN_DT_LIST_4WK", String.valueOf(strRunDtList4Wk));
				
		
		LOGGER.debug("inputDataSet ==>"+inputDataSet);
		//이탈전이 조회대상열차&출발역구성순서&도착역구성순서 조회
		ArrayList<Map<String, String>> trnList = (ArrayList) dao.list("com.korail.yz.ys.eb.YSEB001QMDAO.selectListSpllRecpTrn", inputDataSet);
		StringBuffer strTrnNoList = new StringBuffer("('");
		for(int i = 0; i < trnList.size(); i++)
		{
			if(i == trnList.size() - 1)
			{
				strTrnNoList.append(trnList.get(i).get("TRN_NO")).append("')");
			}else{
				strTrnNoList.append(trnList.get(i).get("TRN_NO")).append("', '");
			}
		}
		inputDataSet.put("TRN_NO_LIST", String.valueOf(strTrnNoList));
		ArrayList<Map<String, Object>> resultList = (ArrayList) dao.list("com.korail.yz.ys.eb.YSEB001QMDAO.selectListSpllRecpSaleVs4Wk2", inputDataSet);
		//메시지 처리
		if(resultList.isEmpty()){
			XframeControllerUtils.setMessage("IZZ000004", result); //해당 조건의 자료가 존재하지 않습니다.
		}
		else
		{
			inputDataSet.put("TRN_NO", String.valueOf(resultList.get(0).get("TRN_NO")));
			XframeControllerUtils.setMessage("IZZ000009", result); //정상적으로 조회 되었습니다.
		}
		
		result.put("dsList", resultList);

		return result;

	}
	
	/**
	 * 이탈전이 예측VS4주평균 조회
	 * @author 김응규
	 * @date 2015. 3. 2. 오전 11:53:00
	 * Method description : 이탈전이 예측 VS 4주평균 조회(속도 개선 후)
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map<String, ?> selectListSpllRecpFcstVs4Wk(Map<String, ?> param) {		

		Map<String, Object> result = new HashMap<String, Object>();

		LOGGER.debug("param ==> "+param);
		// search input column dataset
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");
		//열차운영사업자구분코드 추가
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		inputDataSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		LOGGER.debug("inputDataSet ==>  " + inputDataSet);
		
		//이탈전이 조회대상일자 검색 (List로 가져와서 String형으로 변환 -- sql IN 조건문에서 사용하기위함)
		ArrayList<Map<String, String>> runDtList = (ArrayList) dao.list("com.korail.yz.ys.eb.YSEB001QMDAO.selectListSpllRecpDt", inputDataSet);
		StringBuffer strRunDtList = new StringBuffer("('");
		for(int i = 0; i < runDtList.size(); i++)
		{
			if(i == runDtList.size() - 1)
			{
				strRunDtList.append(runDtList.get(i).get("RUN_DT")).append("')");
			}else{
				strRunDtList.append(runDtList.get(i).get("RUN_DT")).append("', '");
			}
		}
		inputDataSet.put("RUN_DT_LIST", String.valueOf(strRunDtList));
		
		//strRunDtList4Wk : (최근4주 + 오늘날짜)   
		StringBuffer strRunDtList4Wk = new StringBuffer("('");
		for(int i = 0; i < 5; i++)
		{
			if(i == 4)
			{
				strRunDtList4Wk.append(runDtList.get(i).get("RUN_DT")).append("')");
			}else{
				strRunDtList4Wk.append(runDtList.get(i).get("RUN_DT")).append("', '");
			}
			inputDataSet.put("RUN_DT_".concat(String.valueOf((i+1))), runDtList.get(i).get("RUN_DT"));
		}
		LOGGER.debug("오늘포함 4주 날짜 == "+strRunDtList4Wk);
		inputDataSet.put("RUN_DT_LIST_4WK", String.valueOf(strRunDtList4Wk));
				
		
		LOGGER.debug("inputDataSet ==>"+inputDataSet);
		//이탈전이 조회대상열차&출발역구성순서&도착역구성순서 조회
		ArrayList<Map<String, String>> trnList = (ArrayList) dao.list("com.korail.yz.ys.eb.YSEB001QMDAO.selectListSpllRecpTrn", inputDataSet);
		StringBuffer strTrnNoList = new StringBuffer("('");
		for(int i = 0; i < trnList.size(); i++)
		{
			if(i == trnList.size() - 1)
			{
				strTrnNoList.append(trnList.get(i).get("TRN_NO")).append("')");
			}else{
				strTrnNoList.append(trnList.get(i).get("TRN_NO")).append("', '");
			}
		}
		inputDataSet.put("TRN_NO_LIST", String.valueOf(strTrnNoList));
		ArrayList<Map<String, Object>> resultList = (ArrayList) dao.list("com.korail.yz.ys.eb.YSEB001QMDAO.selectListSpllRecpFcstVs4Wk2", inputDataSet);
		//메시지 처리
		if(resultList.isEmpty()){
			XframeControllerUtils.setMessage("IZZ000004", result); //해당 조건의 자료가 존재하지 않습니다.
		}
		else
		{
			inputDataSet.put("TRN_NO", String.valueOf(resultList.get(0).get("TRN_NO")));
			XframeControllerUtils.setMessage("IZZ000009", result); //정상적으로 조회 되었습니다.
		}
		
		result.put("dsList", resultList);

		return result;

	}
	
	/**
	 * 이탈전이 발매VS4주평균 조회
	 * @author 김응규
	 * @date 2014. 4. 6. 오전 11:53:00
	 * Method description : 이탈전이 발매 VS 4주평균 조회(속도 개선 전)
	 * @param param
	 * @return
	 */
	/*@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map<String, ?> selectListSpllRecpSaleVs4Wk(Map<String, ?> param) {		

		Map<String, Object> result = new HashMap<String, Object>();

		LOGGER.debug("param ==> "+param);
		// search input column dataset
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");
		//열차운영사업자구분코드 추가
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		inputDataSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		LOGGER.debug("inputDataSet ==>  " + inputDataSet);

		// search input column data
		LOGGER.debug("inputData ==>  " + inputDataSet.toString());
		
		
		//이탈전이 발매vs4주평균 조회
		ArrayList<Map<String, Object>> resultList = (ArrayList) dao.list("com.korail.yz.ys.eb.YSEB001QMDAO.selectListSpllRecpSaleVs4Wk", inputDataSet);
		
		
		//메시지 처리
		if(resultList.isEmpty()){
			XframeControllerUtils.setMessage("IZZ000004", result); //해당 조건의 자료가 존재하지 않습니다.
		}
		else
		{
			inputDataSet.put("TRN_NO", String.valueOf(resultList.get(0).get("TRN_NO")));
			//역간거리조회
//			ArrayList<Map<String, Object>> intvDstList = (ArrayList) dao.list("com.korail.yz.ys.eb.YSEB001QMDAO.selectStopStnIntvDst", inputDataSet);
//			result.put("dsIntvDstList", intvDstList);
			XframeControllerUtils.setMessage("IZZ000009", result); //정상적으로 조회 되었습니다.
		}
		
		result.put("dsList", resultList);

		return result;

	}*/
	

	
	
	/**
	 * 이탈전이 예측VS4주평균 조회
	 * @author 김응규
	 * @date 2014. 4. 6. 오전 11:53:00
	 * Method description : 이탈전이 예측 VS 4주평균 조회(속도 개선 전)
	 * @param param
	 * @return
	 */
	/*@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map<String, ?> selectListSpllRecpFcstVs4Wk(Map<String, ?> param) {		

		Map<String, Object> result = new HashMap<String, Object>();

		LOGGER.debug("param ==> "+param);
		// search input column dataset
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");	
		LOGGER.debug("inputDataSet ==>  " + inputDataSet);

		// search input column data
		LOGGER.debug("inputData ==>  " + inputDataSet.toString());
		
		
		//이탈전이 예측vs4주평균 조회
		ArrayList<Map<String, Object>> resultList = (ArrayList) dao.list("com.korail.yz.ys.eb.YSEB001QMDAO.selectListSpllRecpFcstVs4Wk", inputDataSet);
		
		
		//메시지 처리
		if(resultList.isEmpty()){
			XframeControllerUtils.setMessage("IZZ000004", result); //해당 조건의 자료가 존재하지 않습니다.
		}
		else
		{
			inputDataSet.put("TRN_NO", String.valueOf(resultList.get(0).get("TRN_NO")));
			//역간거리조회
//			ArrayList<Map<String, Object>> intvDstList = (ArrayList) dao.list("com.korail.yz.ys.eb.YSEB001QMDAO.selectStopStnIntvDst", inputDataSet);
//			result.put("dsIntvDstList", intvDstList);
			XframeControllerUtils.setMessage("IZZ000009", result); //정상적으로 조회 되었습니다.
		}
		
		result.put("dsList", resultList);

		return result;

	}*/
	
	/**
	 * 이탈전이-실적추이 발매VS4주평균 조회
	 * @author 김응규
	 * @date 2014. 4. 6. 오전 11:53:00
	 * Method description : 이탈전이-실적추이 발매VS4주평균 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map<String, ?> selectListAcvmTndSaleVs4Wk(Map<String, ?> param) {		

		Map<String, Object> result = new HashMap<String, Object>();

		LOGGER.debug("param ==> "+param);
		// search input column dataset
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");	
		LOGGER.debug("inputDataSet ==>  " + inputDataSet);

		// search input column data
		LOGGER.debug("inputData ==>  " + inputDataSet.toString());
		
		
		//이탈전이 예측vs4주평균 조회
		ArrayList<Map<String, Object>> resultList = (ArrayList) dao.list("com.korail.yz.ys.eb.YSEB001QMDAO.selectListAcvmTndSaleVs4Wk", inputDataSet);
		
		
		//메시지 처리
		if(resultList.isEmpty()){
			XframeControllerUtils.setMessage("IZZ000004", result); //해당 조건의 자료가 존재하지 않습니다.
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result); //정상적으로 조회 되었습니다.
			//운행실적 일자 조회
			ArrayList<Map<String, Object>> runDtList = (ArrayList) dao.list("com.korail.yz.ys.eb.YSEB001QMDAO.selectListAcvmTndDate", inputDataSet);
			result.put("dsRunDtList", runDtList);
			
		}
		
		result.put("dsList", resultList);

		return result;

	}
	/**
	 * 이탈전이-실적추이 예측VS4주평균 조회
	 * @author 김응규
	 * @date 2014. 4. 6. 오전 11:53:00
	 * Method description : 이탈전이-실적추이 예측VS4주평균 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map<String, ?> selectListAcvmTndFcstVs4Wk(Map<String, ?> param) {		

		Map<String, Object> result = new HashMap<String, Object>();

		LOGGER.debug("param ==> "+param);
		// search input column dataset
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");	
		LOGGER.debug("inputDataSet ==>  " + inputDataSet);

		// search input column data
		LOGGER.debug("inputData ==>  " + inputDataSet.toString());
		
		
		//이탈전이 예측vs4주평균 조회
		ArrayList<Map<String, Object>> resultList = (ArrayList) dao.list("com.korail.yz.ys.eb.YSEB001QMDAO.selectListAcvmTndFcstVs4Wk", inputDataSet);
		
		
		//메시지 처리
		if(resultList.isEmpty()){
			XframeControllerUtils.setMessage("IZZ000004", result); //해당 조건의 자료가 존재하지 않습니다.
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result); //정상적으로 조회 되었습니다.
			//운행실적 일자 조회
			ArrayList<Map<String, Object>> runDtList = (ArrayList) dao.list("com.korail.yz.ys.eb.YSEB001QMDAO.selectListAcvmTndDate", inputDataSet);
			result.put("dsRunDtList", runDtList);
		}
		
		result.put("dsList", resultList);

		return result;

	}
}

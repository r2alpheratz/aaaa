/**
 * project : KORAIL_YZ
 * package : com.korail.yz.ys.aa
 * date : 2014. 4. 5.오후 3:02:30
 */
package com.korail.yz.ys.aa;

import java.io.File;
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
import cosmos.comm.exception.CosmosRuntimeException;

/**
 * @author 김응규
 * @date 2014. 4. 5. 오후 3:02:30
 * Class description :  수익관리대상열차일별처리SVC
 * 일일처리된 수익관리작업 현황 파익 및 작업상태에 따라 비정상열차조치, 온라인 열차재작업처리 등을 수행하기 위한 Service 클래스
 */
@Service("com.korail.yz.ys.aa.YSAA001SVC")
public class YSAA001SVC {
	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public  static final Logger  LOGGER = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
	
	/**
	 * 수익관리대상열차 일별처리 작업일자별 조회
	 * @author 김응규
	 * @date 2014. 4. 6. 오전 11:53:00
	 * Method description : 수익관리대상열차 일별처리 작업일자별 조회를 실행한다. 
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map<String, ?> selectListYmgtTgtTrnJobDt(Map<String, ?> param) {		

		Map<String, Object> result = new HashMap<String, Object>();

		LOGGER.debug("param ==> "+param);
		// search input column dataset
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCondJobDt");
		//열차운영사업자구분코드 추가
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		inputDataSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		LOGGER.debug("inputDataSet ==>  " + inputDataSet);
		
		ArrayList<Map<String, Object>> resultList = (ArrayList) dao.list("com.korail.yz.ys.aa.YSAA001QMDAO.selectListYmgtTgtTrnJobDt", inputDataSet);
		
		//메시지 처리
		if(resultList.isEmpty()){
			XframeControllerUtils.setMessage("IZZ000004", result); //해당 조건의 자료가 존재하지 않습니다.
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result); //정상적으로 조회 되었습니다.
		}
		
		result.put("dsListJobDt", resultList);

		return result;

	}
	
	/**
	 * 수익관리대상열차 일별처리 운행일자별 조회
	 * @author 김응규
	 * @date 2014. 4. 6. 오전 11:53:00
	 * Method description : 수익관리대상열차 일별처리 작업일자별 조회를 실행한다. 
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map<String, ?> selectListYmgtTgtTrnRunDt(Map<String, ?> param) {		

		Map<String, Object> result = new HashMap<String, Object>();

		LOGGER.debug("param ==> "+param);
		// search input column dataset
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCondRunDt");
		//열차운영사업자구분코드 추가
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		inputDataSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		LOGGER.debug("inputDataSet ==>  " + inputDataSet);
		
		ArrayList<Map<String, Object>> resultList = (ArrayList) dao.list("com.korail.yz.ys.aa.YSAA001QMDAO.selectListYmgtTgtTrnRunDt", inputDataSet);

		
		//메시지 처리
		if(resultList.isEmpty()){
			XframeControllerUtils.setMessage("IZZ000004", result); //해당 조건의 자료가 존재하지 않습니다.
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result); //정상적으로 조회 되었습니다.
		}
		result.put("dsListRunDt", resultList);

		return result;

	}
	/**
	 * 수익관리대상열차 상세처리결과조회
	 * @author 김응규
	 * @date 2014. 4. 8. 오후 7:23:00
	 * Method description : 선택한 열차의 상세처리결과를 조회한다.
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map<String, ?> selectListDtlPrsCnqe(Map<String, ?> param) {		

		Map<String, Object> result = new HashMap<String, Object>();

		LOGGER.debug("param ==> "+param);
		// search input column dataset
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");
		//열차운영사업자구분코드 추가
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		inputDataSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		LOGGER.debug("inputDataSet ==>  " + inputDataSet);

		ArrayList<Map<String, Object>> resultList = (ArrayList) dao.list("com.korail.yz.ys.aa.YSAA001QMDAO.selectListDtlPrsCnqe", inputDataSet);

		
		//메시지 처리
		if(resultList.isEmpty()){
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
	 * @author 한현섭
	 * @date 2014. 4. 30. 오후 4:39:24
	 * Method description : 신규 작업아이디 채번
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map<String, ?> selectNewYmgtJobId(Map<String, ?> param) {		

		Map<String, Object> result = new HashMap<String, Object>();

		ArrayList<Map<String, Object>> resultList = (ArrayList) dao.list("com.korail.yz.ys.aa.YSAA001QMDAO.selectNewYmgtJobId", null);

		
		result.put("dsNewYmgtJobId", resultList);

		return result;

	}
	
	
	/**
	 * @author 한현섭
	 * @date 2014. 4. 30. 오후 4:39:25
	 * Method description : 열차별 재작업 실행
	 * @param param
	 * @return
	 * Remarks : 김응규 수정 2014.11.27 
	 */
	@SuppressWarnings({ "unchecked" })
	public Map<String, ?> insertNewYmgtJob(Map<String, ?> param) {		
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		LOGGER.debug("param ==> "+param);
		
		// search input column dataset
		ArrayList<Map<String, String>> inputDataList = (ArrayList<Map<String, String>>) param.get("dsListJobDtChecked");
		
		if(inputDataList.isEmpty())
		{
			inputDataList = (ArrayList<Map<String, String>>) param.get("dsListRunDtChecked");
		}
		
		LOGGER.debug("inputDataSet ==>  " + inputDataList);
		String usrId = XframeControllerUtils.getUserId(param);
		String stlbTrnClsfCd = String.valueOf(inputDataList.get(0).get("STLB_TRN_CLSF_CD"));
		String path = "";
		Map<String, String> newJobIdMap = new HashMap<String, String>();
		if("00".equals(stlbTrnClsfCd) || "07".equals(stlbTrnClsfCd) || "10".equals(stlbTrnClsfCd)){
			newJobIdMap.put("JOB_ID", "YZFB500_BA_U1"); //KTX
			path = "./yzfb500_sh_ad1";
		}else {
			newJobIdMap.put("JOB_ID", "YZFB510_BA_U1"); //새마을
			path = "./yzfb510_sh_ad1";
		}
		//NEW JOB ID 채번
		Map<String, Object> newYmgtJobIdMap = (Map<String, Object>) dao.select("com.korail.yz.ys.aa.YSAA001QMDAO.selectNewYmgtJobId", newJobIdMap);
		String sYmgtJobId = String.valueOf(newYmgtJobIdMap.get("YMGT_JOB_ID"));
		LOGGER.debug("YMGT_JOB_ID::::::"+sYmgtJobId);
		
		
		/*
		 * TODO : TB_YYFB009, YYFD011 테이블에 각각 INSERT하여야 한다.
		*/
		Map<String, Object> newYmgtJobMap = new HashMap<String, Object>();
		newYmgtJobMap.put("YMGT_JOB_ID", sYmgtJobId);
		newYmgtJobMap.put("USR_ID", usrId);
		int insertCnt = 0;
		try
		{
			insertCnt = dao.insert("com.korail.yz.ys.aa.YSAA001QMDAO.insertTB_YYFB009", newYmgtJobMap);	
		}catch(Exception e)
		{
			LOGGER.debug(e);
			throw new CosmosRuntimeException("EYS000002", null); //수익관리 작업ID 신규 등록 중 오류가 발생했습니다.
		}
		LOGGER.debug("insert into TB_YYFB009 count ::::::["+insertCnt+"]");
		if(insertCnt < 1)
		{
			throw new CosmosRuntimeException("EYS000002", null); //수익관리 작업ID 신규 등록 중 오류가 발생했습니다.
		}
		
		
		insertCnt = 0;
		for( Map<String, String> inputDataSet : inputDataList )
		{	
			inputDataSet.put("YMGT_JOB_ID", sYmgtJobId);
			inputDataSet.put("USR_ID", usrId);
			try
			{
				insertCnt += dao.insert("com.korail.yz.ys.aa.YSAA001QMDAO.insertTB_YYFD011", inputDataSet);
			}catch(Exception e)
			{	
				throw new CosmosRuntimeException("EYS000002", null); //수익관리 작업ID 신규 등록 중 오류가 발생했습니다.
			}
			LOGGER.debug("insert into TB_YYFD011 count ::::::["+insertCnt+"]");
			if(insertCnt < 1)
			{
				throw new CosmosRuntimeException("EYS000002", null); //수익관리 작업ID 신규 등록 중 오류가 발생했습니다.
			}
		}
		
		LOGGER.debug("PATH :::"+ path);
		LOGGER.debug("sYmgtJobId :::"+ sYmgtJobId);
		LOGGER.debug("usrId :::"+ usrId);
		try {
			LOGGER.debug("PROCESS 실행시작2222!!!");
			List<String> p = new ArrayList<String>();
			p.add(path);
			p.add(sYmgtJobId);
			p.add(usrId);
			
			
			ProcessBuilder process = new ProcessBuilder(p);
			process.directory(new File("/app/apyz/batch/bin"));
			Process B = process.start();
			LOGGER.debug("PROCESS 실행끝!!!"+B);
		} catch (Exception e) {
			XframeControllerUtils.setMessage("IYS000009", result); //최적화 배치 실행에 실패하였습니다.
		}
		
		LOGGER.debug("Running Batch........");
		XframeControllerUtils.setMessage("IYS000001", result); //수요예측/최적화 온라인작업이 시작되었습니다.
		
		return result;
	}
	
	
	/**
	 * @author 한현섭
	 * @date 2014. 4. 30. 오후 4:39:28
	 * Method description : 해당 열차를 재작업할 수 있는 권한소유 여부을 확인하는 메서드
	 * @param param
	 * @return
	 * remarks : 김응규 수정 2014.11.27
	 */
	@SuppressWarnings({ "unchecked" })
	public Map<String, ?> selectAuthChk(Map<String, ?> param) {		
		LOGGER.debug("param ==> "+param);
		Map<String, Object> result = new HashMap<String, Object>();
		
		// search input column dataset
		ArrayList<Map<String, String>> inputDataList = (ArrayList<Map<String, String>>) param.get("dsListJobDtChecked");
		
		if(inputDataList.isEmpty())
		{
			inputDataList = (ArrayList<Map<String, String>>) param.get("dsListRunDtChecked");
		}
		
		String usrId = XframeControllerUtils.getUserId(param);
		
		ArrayList<Map<String, Object>> resultList =  new ArrayList<Map<String,Object>>(); //권한CHECK용
		for(Map<String, String> inputDataSet : inputDataList)
		{
			inputDataSet.put("USR_ID", usrId);
			
			//권한체크
			ArrayList<Map<String, Object>> authList = (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.ys.aa.YSAA001QMDAO.selectAuthChkFlg", inputDataSet);
			Map<String, Object> authMap = null;
			if(authList.isEmpty())
			{
				authMap = new HashMap<String, Object>();
				authMap.put("AUTH_CHK_FLG", "N");
			}
			else
			{
				authMap = authList.get(0);
			}
			authMap.put("TRN_NO", inputDataSet.get("TRN_NO"));
			resultList.add(authMap);
		}
		result.put("dsAuthResult", resultList);
		return result;
		
	}
	
	
	/**
	 * @author 한현섭
	 * @date 2014. 4. 30. 오후 4:39:29
	 * Method description : DCP 열차인지 확인하는 메서드 (미사용 - 권한체크시 일괄 조회)
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map<String, ?> selectIsDcpTrn(Map<String, ?> param) {		
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		LOGGER.debug("param ==> "+param);
		// search input column dataset
		ArrayList<Map<String, String>> inputDataList = (ArrayList<Map<String, String>>) param.get("dsIsDcpCond");	
		ArrayList<Map<String, Object>> resultList = new ArrayList<Map<String,Object>>();
		
		for(Map<String, String> inputDataSet : inputDataList){
			ArrayList<Map<String, Object>> isDcpList = (ArrayList) dao.list("com.korail.yz.ys.aa.YSAA001QMDAO.selectIsDcpTrn", inputDataSet);
			
			Map<String, Object> isDcpSet = null;
			if(isDcpList.isEmpty())
			{
				isDcpSet = new HashMap<String, Object>();
				isDcpSet.put("IS_DCP_TRN", "N");
			}
			else
			{
				isDcpSet = isDcpList.get(0);
				
			}
			LOGGER.debug("isDcpSet ==>  " +isDcpSet.toString());
			isDcpSet.put("TRN_NO", inputDataSet.get("TRN_NO"));
			isDcpSet.put("RUN_DT", inputDataSet.get("RUN_DT"));
			resultList.add(isDcpSet);
		}
		
		result.put("dsIsDcpResult", resultList);
		return result;
		
	}
	
	
	/**
	 * @author 한현섭
	 * @date 2014. 4. 30. 오후 4:39:31
	 * Method description : 온라인 열차 DCP DV NO를 99로 업데이트 하는 메서드(미사용)
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "unchecked"})
	public Map<String, ?> updateOnlTrnDcpDvNo(Map<String, ?> param) {		
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		LOGGER.debug("param ==> "+param);
		// search input column dataset
		ArrayList<Map<String, String>> inputDataList = (ArrayList<Map<String, String>>) param.get("dsUpdateDcpDvNo");	
		LOGGER.debug("inputDataSet ==>  " + inputDataList);
		
		
		for(Map<String, String> inputDataSet : inputDataList)
		{
			
			try
			{
				dao.list("com.korail.yz.ys.aa.YSAA001QMDAO.updateOnlTrnDcpDvNo", inputDataSet);
				
			}
			catch(Exception e)
			{
				XframeControllerUtils.setMessage("EYS000003", result);
				return result;
			}
		}
		return result;
		
	}
	
}
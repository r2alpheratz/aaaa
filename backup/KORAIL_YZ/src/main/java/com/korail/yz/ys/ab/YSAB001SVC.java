/**
 * project : KORAIL_YZ
 * package : com.korail.yz.ys.ab
 * date : 2014. 4. 8.오후 4:17:31
 */
package com.korail.yz.ys.ab;


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
 * @author 한현섭
 * @date 2014. 4. 8. 오후 4:17:31
 * Class description : 
 */
 @Service("com.korail.yz.ys.ab.YSAB001SVC")
public class YSAB001SVC {


		@Resource(name = "commDAO")
		private CommDAO dao;
			
		@Resource(name="messageSource")
		MessageSource messageSource;
		
		public  static final Logger LOGGER = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
		
		/**
		 * @author 한현섭 --> 김응규 수정
		 * @date 2014. 4. 8. 오후 5:04:28
		 * Method description : 수익관리작업요청목록
		 * @param param
		 * @return
		 */
		@SuppressWarnings("unchecked")
		public Map<String, ?> selectListYmgtJobDmnLst(Map<String, ?> param){
			
			LOGGER.debug("param ==>"+param);
			/* 리턴 오브젝트 */
			Map<String, Object> result = new HashMap<String, Object>();
			
			/* 입력 오브젝트 */
			Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");
			//열차운영사업자구분코드 추가
			String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
			inputDataSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
			
			/* DAO - 쿼리 실행 후 결과 획득*/
			ArrayList<Map<String, Object>> resultList
			= (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.ys.ab.YSAB001QMDAO.selectListYmgtJobDmnLst", inputDataSet);

			
			//error 메시지 날리기
			if(resultList.isEmpty())
			{
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
		 * @date 2014. 4. 8. 오후 5:04:28
		 * Method description : (예약발매요청) 수익관리작업요청 목록 조회
		 * @param param
		 * @return
		 */
		@SuppressWarnings("unchecked")
		public Map<String, ?> selectListRsvSaleDmn(Map<String, ?> param){
			
			LOGGER.debug("param ==>"+param);
			/* 리턴 오브젝트 */
			Map<String, Object> result = new HashMap<String, Object>();
			
			/* 입력 오브젝트 */
			Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCond2");
			/* 사업자구분코드 삽입*/
			String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
			inputDataSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
			/* DAO - 쿼리 실행 후 결과 획득*/
			ArrayList<Map<String, Object>> resultList
			= (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.ys.ab.YSAB001QMDAO.selectListRsvSaleDmn", inputDataSet);

			
			//error 메시지 날리기
			if(resultList.isEmpty())
			{
				XframeControllerUtils.setMessage("IZZ000004", result); //해당 조건의 자료가 존재하지 않습니다.
			}
			else
			{
				XframeControllerUtils.setMessage("IZZ000009", result); //정상적으로 조회 되었습니다.
			}
			result.put("dsList2", resultList);
			return result;

		}
		/**
		 * @author 김응규
		 * @date 2014. 10. 29. 오후 5:04:28
		 * Method description : 수익관리작업요청목록(예약발매요청)(미사용)
		 * @param param
		 * @return
		 */
		@SuppressWarnings("unchecked")
		public Map<String, ?> selectListYmgtJobDmnRzLst(Map<String, ?> param){
			
			
			/* 리턴 오브젝트 */
			Map<String, Object> result = new HashMap<String, Object>();

			
			/* 입력 오브젝트 */
			Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsGrdYmgtCond");
			//열차운영사업자구분코드 추가
			String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
			inputDataSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
			LOGGER.debug("inputDateSet--->"+inputDataSet);

			
			/* DAO - 쿼리 실행 후 결과 획득*/
			ArrayList<Map<String, Object>> resultList
			= (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.ys.ab.YSAB001QMDAO.selectListYmgtJobDmnRzLst", inputDataSet);

			
			//error 메시지 날리기
			if(resultList.isEmpty())
			{
				XframeControllerUtils.setMessage("IZZ000004", result); //해당 조건의 자료가 존재하지 않습니다.
			}
			else
			{
				XframeControllerUtils.setMessage("IZZ000009", result); //정상적으로 조회 되었습니다.
			}
			result.put("dsGrdYmgtList", resultList);
			return result;

		}
		
		/**
		 * @author 한현섭
		 * @date 2014. 4. 9. 오전 10:51:28
		 * Method description : 수익관리작업요청상세목록
		 * @param param
		 * @return
		 */
		@SuppressWarnings("unchecked")
		public Map<String, ?> selectListYmgtJobDmnDtlLst(Map<String, ?> param){
			
			LOGGER.debug("param ==>"+param);
			/* 리턴 오브젝트 */
			Map<String, Object> result = new HashMap<String, Object>();

			/* 입력 오브젝트 */
			Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCondDtl");
			//열차운영사업자구분코드 추가
			String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
			inputDataSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
			
			/* DAO - 쿼리 실행 후 결과 획득*/
			ArrayList<Map<String, Object>> resultList
			= (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.ys.ab.YSAB001QMDAO.selectListYmgtJobDmnDtlLst", inputDataSet);
			
			
			//error 메시지 날리기
			if(resultList.isEmpty())
			{
				XframeControllerUtils.setMessage("IZZ000004", result); //해당 조건의 자료가 존재하지 않습니다.
			}
			else
			{
				XframeControllerUtils.setMessage("IZZ000009", result); //정상적으로 조회 되었습니다.
			}
			result.put("dsListDtl", resultList);
			return result;
			
		}
		
		/**
		 * @author 김응규
		 * @date 2014. 12. 14. 오후 4:39:25
		 * Method description : (장기/단기)열차 재작업 배치 실행
		 * @param param
		 * @return
		 */
		public Map<String, ?> processReJobBatch(Map<String, ?> param) {		
			
			Map<String, Object> result = new HashMap<String, Object>();
			
			LOGGER.debug("param ==> "+param);
			
			// search input column dataset
			Map<String, String> inputDataSet = XframeControllerUtils.getParamDataSet(param, "dsCondReJob");
			
			String usrId = XframeControllerUtils.getUserId(param);
			String sYmgtJobId = inputDataSet.get("YMGT_JOB_ID");
			
			String sBatchJobId = sYmgtJobId.substring(0, 13);
			LOGGER.debug("Batch Job ID :::: "+ sBatchJobId);
			
			String path = "";
			if("YZDB910_BA_U1".equals(sBatchJobId)) //KTX 예매초일 공석예측작업
			{
				path = "./yzdb910_sh_ad1";
			}else if("YZDB920_BA_U1".equals(sBatchJobId)) //새마을 예매초일 공석예측작업
			{
				path = "./yzdb920_sh_ad1";
			}else if("YZDB810_BA_U1".equals(sBatchJobId)) //상품할당 공석예측작업
			{
				path = "./yzdb810_sh_ad1";
			}else
			{
				throw new CosmosRuntimeException("IYS000009", null); 
				//최적화 배치 실행에 실패 하였습니다.
			}
			LOGGER.debug("PATH :::"+ path);
			LOGGER.debug("sYmgtJobId :::"+ sYmgtJobId);
			LOGGER.debug("usrId :::"+ usrId);
			try {
				LOGGER.debug("PROCESS 실행시작!!!");
				
				List<String> p = new ArrayList<String>();
				p.add(path);
				if(!"YZDB810_BA_U1".equals(sBatchJobId))
				{
					p.add("B"); // O:온라인, B:배치    O -> B로 변경 (2015-03-24)					
				}
				p.add(usrId);
				
				ProcessBuilder process = new ProcessBuilder(p);
				process.directory(new File("/app/apyz/batch/bin"));
				Process B = process.start();
				LOGGER.debug("PROCESS 실행끝!!!"+B);
			} catch (Exception e) {
				throw new CosmosRuntimeException("IYS000009", null); //최적화 배치 실행에 실패하였습니다.
			}
			
			LOGGER.debug("Running Batch........");
			XframeControllerUtils.setMessage("IYS000001", result); //수요예측/최적화 온라인작업이 시작되었습니다.
			
			return result;
		}
		/**
		 * @author 김응규
		 * @date 2014. 12. 18. 오후 4:39:25
		 * Method description : (예약발매요청) 최적화 재작업 배치 실행
		 * @param param
		 * @return
		 */
		public Map<String, ?> processRsvSaleDmnOtmzReJobBatch(Map<String, ?> param) {		
			
			Map<String, Object> result = new HashMap<String, Object>();
			
			LOGGER.debug("param ==> "+param);
			
			String usrId = XframeControllerUtils.getUserId(param);
			
			String path = "./yzdb960_sh_ad1";
			try {
				LOGGER.debug("PROCESS 실행시작!!!");
				
				List<String> p = new ArrayList<String>();
				p.add(path);
				p.add("1");
				p.add(usrId);
				
				ProcessBuilder process = new ProcessBuilder(p);
				process.directory(new File("/app/apyz/batch/bin"));
				Process B = process.start();
				LOGGER.debug("PROCESS 실행끝!!!"+B);
				LOGGER.debug("전송 List Log ::::"+p);
			} catch (Exception e) {
				XframeControllerUtils.setMessage("IYS000009", result); //최적화 배치 실행에 실패하였습니다.
			}
			
			LOGGER.debug("Running Batch........");
			XframeControllerUtils.setMessage("IYS000001", result); //수요예측/최적화 온라인작업이 시작되었습니다.
			
			return result;
		}
		
		/**
		 * @author 김응규
		 * @date 2014. 12. 18. 오후 4:39:25
		 * Method description : (예약발매요청) 임시열차 최적화 배치 실행
		 * @param param
		 * @return
		 */
		public Map<String, ?> processRsvSaleDmnTtrnOtmzBatch(Map<String, ?> param) {		
			
			Map<String, Object> result = new HashMap<String, Object>();
			
			LOGGER.debug("param ==> "+param);
			
			String usrId = XframeControllerUtils.getUserId(param);
			
			String path = "./yzdb960_sh_ad1";
			try {
				LOGGER.debug("PROCESS 실행시작!!!");
				
				List<String> p = new ArrayList<String>();
				p.add(path);
				p.add(usrId);
				LOGGER.debug("임시열차 최적화!!!!");
				ProcessBuilder process = new ProcessBuilder(p);
				process.directory(new File("/app/apyz/batch/bin"));
				Process B = process.start();
				LOGGER.debug("PROCESS 실행끝!!!"+B);
				LOGGER.debug("전송 List Log ::::"+p);
			} catch (Exception e) {
				XframeControllerUtils.setMessage("IYS000009", result); //최적화 배치 실행에 실패하였습니다.
			}
			
			LOGGER.debug("Running Batch........");
			XframeControllerUtils.setMessage("IYS000001", result); //수요예측/최적화 온라인작업이 시작되었습니다.
			
			return result;
		}
		
		/**
		 * @author 김응규
		 * @date 2015. 2. 23. 오후 5:04:28
		 * Method description : 재작업 실행 전 작업종료일시 체크
		 * @param param
		 * @return
		 */
		@SuppressWarnings("unchecked")
		public Map<String, ?> selectChkJobClsDttm(Map<String, ?> param){
			
			LOGGER.debug("param ==>"+param);
			/* 리턴 오브젝트 */
			Map<String, Object> result = new HashMap<String, Object>();
			
			/* 입력 오브젝트 */
			Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsChk");
			
			String strJobDv = inputDataSet.get("JOB_DV");
			StringBuffer strRegExpJobId = new StringBuffer("^");
			
			if("BOKG_FST_DD_KTX".equals(strJobDv)){
				//예매초일(KTX)      : YZDB910_BA_U1
				strRegExpJobId.append("YZDB910_BA_U1");
				
			}else if("BOKG_FST_DD_SML".equals(strJobDv)){
				//예매초일(새마을)   : YZDB920_BA_U1
				strRegExpJobId.append("YZDB920_BA_U1");
				
			}else if("GD_ALC".equals(strJobDv)){
				//상품할당 공석예측  : YZDB810_BA_U1
				strRegExpJobId.append("YZDB810_BA_U1");
				
			}else if("OTMZ_KTX".equals(strJobDv)){
				//최적화재작업(KTX)        : YZFB500_BA_U1, YZFB210_BA_U1
				strRegExpJobId.append("YZFB500_BA_U1|YZFB210_BA_U1");
				
			}else if("OTMZ_SML".equals(strJobDv)){
				//최적화재작업(새마을)     : YZFB510_BA_U1, YZFB230_BA_U1
				strRegExpJobId.append("YZFB510_BA_U1|YZFB230_BA_U1");
				
			}else if("TTRN_KTX".equals(strJobDv)){
				//임시열차(KTX)      : YZDB930_BA_U1, YZDB910_BA_U1
				strRegExpJobId.append("YZDB930_BA_U1|YZDB910_BA_U1");
				
			}else if("TTRN_SML".equals(strJobDv)){
				//임시열차(새마을)   : YZDB940_BA_U1, YZDB920_BA_U1
				strRegExpJobId.append("YZDB940_BA_U1|YZDB920_BA_U1");
				
			}else{
				//파라미터 안넘어왔을 시..
				
				LOGGER.debug("작업구분(JOB_DV) 에러 ::: JOB_DV = ("+strJobDv+")");
				inputDataSet.put("RESULT", "ERROR");
				result.put("dsChk", inputDataSet);
				return result;
			}
			inputDataSet.put("REGEXP_JOB_ID", String.valueOf(strRegExpJobId));
			/* DAO - 쿼리 실행 후 결과 획득*/
			Map<String, String> resultMap = (Map<String, String>) dao.select("com.korail.yz.ys.ab.YSAB001QMDAO.selectChkJobClsDttm", inputDataSet);

			
			int resultCnt = Integer.parseInt(resultMap.get("CNT"));
			
			//메시지처리
			if(resultCnt > 0)
			{
				LOGGER.debug("체크완료 비정상종료되었거나 실행중인 작업이 있음");
				inputDataSet.put("RESULT", "Y");
			}
			else
			{
				LOGGER.debug("체크완료 -> 정상");
				inputDataSet.put("RESULT", "N");
			}
			
			ArrayList<Map<String, String>> resultList = new ArrayList<Map<String,String>>();
			resultList.add(inputDataSet);
			result.put("dsChk", resultList);
			return result;
		}
		
		
		/**
		 * @author 한현섭
		 * @date 2014. 4. 8. 오후 5:04:35
		 * Method description : 최적화실행(미사용)
		 * @param param
		 * @return
		 */
		/*@SuppressWarnings("unchecked")
		public Map<String, ?> insertOtmzExc(Map<String, ?> param){
			
			//ProcessBuilder ktxBatch = new ProcessBuilder("/app/apyz/batch/bin/yzif001_ba_u1.sh");
			 리턴 오브젝트 
			Map<String, Object> result = new HashMap<String, Object>();
			ArrayList<Map<String, String>> messageList = new ArrayList<Map<String, String>>();
			HashMap<String, String> msgMap = new HashMap<String, String>();

			 입력 오브젝트 
			Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsRsvOptExc");
			LOGGER.debug("inputDateSet--->"+inputDataSet.toString());

			 DAO - 쿼리 검증 
			HashMap<String, String> queryKeyMap = new HashMap<String, String>();
			queryKeyMap.put("열차편성내역", "TB_YYDK303");
			queryKeyMap.put("열차기본", "TB_YYDK301");
			queryKeyMap.put("열차운행내역", "TB_YYDK302");
			queryKeyMap.put("잔여석기본", "TB_YYDK305");
			queryKeyMap.put("LEG잔여석내역", "TB_YYDK307");
			queryKeyMap.put("SEG잔여석내역", "TB_YYDK306");
			queryKeyMap.put("구역별구간그룹내역", "TB_YYDK308");
			queryKeyMap.put("YMS할당잔여석내역", "TB_YYDK328");
			queryKeyMap.put("부킹클래스적용내역", "TB_YYDK309");
			
			HashMap<String, String> queryMap = new HashMap<String, String>();
			queryMap.put("TB_YYDK303", "com.korail.yz.ys.ab.YSAB001QMDAO.selectRsvOptChk_TB_YYDK303");
			queryMap.put("TB_YYDK301", "com.korail.yz.ys.ab.YSAB001QMDAO.selectRsvOptChk_TB_YYDK301");
			queryMap.put("TB_YYDK302", "com.korail.yz.ys.ab.YSAB001QMDAO.selectRsvOptChk_TB_YYDK302");
			queryMap.put("TB_YYDK305", "com.korail.yz.ys.ab.YSAB001QMDAO.selectRsvOptChk_TB_YYDK305");
			queryMap.put("TB_YYDK307", "com.korail.yz.ys.ab.YSAB001QMDAO.selectRsvOptChk_TB_YYDK307");
			queryMap.put("TB_YYDK306", "com.korail.yz.ys.ab.YSAB001QMDAO.selectRsvOptChk_TB_YYDK306");
			queryMap.put("TB_YYDK308", "com.korail.yz.ys.ab.YSAB001QMDAO.selectRsvOptChk_TB_YYDK308");
			queryMap.put("TB_YYDK328", "com.korail.yz.ys.ab.YSAB001QMDAO.selectRsvOptChk_TB_YYDK328");
			queryMap.put("TB_YYDK309", "com.korail.yz.ys.ab.YSAB001QMDAO.selectRsvOptChk_TB_YYDK309");
			
			String tbNmKey = inputDataSet.get("TB_NM");
			
			String tbKey = queryKeyMap.get(tbNmKey);

			String chkQuery = queryMap.get(tbKey);

			//tbKey가 존재하면 쿼리검증단계, 없으면 배치 실행
			if( null != tbKey && !"".equals(tbKey))
			{
				ArrayList<Map<String, Object>> resultChkList
				= (ArrayList<Map<String, Object>>) dao.list(chkQuery, inputDataSet);
				
				if("N".equals(resultChkList.get(0).get("CHK_RST"))){
					msgMap.put("errorTable", tbKey);
					messageList.add(msgMap);
					result.put("dsRsvOptChkErrTb", messageList);
					LOGGER.debug("error--->"+result.get("dsRsvOptChkErrTb").toString());
				}
				return result;
			}
			
			//최적화 배치 실행 
			else
			{
				String sJobId = inputDataSet.get("YMGT_JOB_ID");
				String sJobTrnClstCd = sJobId.substring(0, 13).toLowerCase(); 
				String sUserId = XframeControllerUtils.getUserId(param);
				
				//신규 YMGT_JOB_ID채번
				ArrayList<Map<String, Object>> resultChkList
				= (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.ys.ab.YSAB001QMDAO.selectListBokgFstNewtYmgtJobId", inputDataSet);
				
				//신규 YMGT_JOB_ID입력
				if(!resultChkList.isEmpty())
				{
					inputDataSet.put("NEW_YMGT_JOB_ID", (String) resultChkList.get(0).get("NEW_YMGT_JOB_ID"));
					inputDataSet.put("REG_USR_ID", sUserId);
					dao.insert("com.korail.yz.ys.ab.YSAB001QMDAO.insertBokgFstNewtYmgtJobId", inputDataSet);
				}
				
				//배치실행 PATH 작성
				String[] path =  {"/app/apyz/batch/bin/" + sJobTrnClstCd, inputDataSet.get("IS_DT_FST"), "O", sJobId, sUserId}; 
				//String[] path =  {"/app/apyz/batch/bin/rmyzlog.sh"};
				//ProcessBuilder ktxBatch = new ProcessBuilder("/app/apyz/batch/bin/yzif001_ba_u1.sh");//로그파일생성
				ProcessBuilder reProcess = new ProcessBuilder(path);
				LOGGER.debug("PATH : "+path[0]);

			try {
					LOGGER.debug("2014-09-24까지 실행금지");
					//reProcess.start();
				} catch (Exception e) {
					LOGGER.debug(String.valueOf(e));
					msgMap.put("BATCH_RESULT", "최적화에 실패하였습니다.");
					messageList.add(msgMap);
					result.put("dsRsvOptResult", messageList);
					return result;
				}
				msgMap.put("BATCH_RESULT", "최적화배치가 실행되었습니다(테스트 메시지, 실제 실행 안됨)");
				messageList.add(msgMap);
				result.put("dsRsvOptResult", messageList);

			}
			return result;
		}
		*/
		/**
		 * @author 한현섭
		 * @date 2014. 4. 10. 오후 2:52:11
		 * Method description : 예약발매요청열차수신처리상태조회(미사용)
		 * @param param
		 * @return
		 */
		/*@SuppressWarnings("unchecked")
		public Map<String, ?> selectRsvSaleDmnTrnRcvPrsStt(Map<String, ?> param){
			 리턴 오브젝트 
			Map<String, Object> result = new HashMap<String, Object>();
			
			 입력 오브젝트 
			Map<String, String> inputDataSet = new HashMap<String, String>();
			LOGGER.debug("inputDateSet--->"+inputDataSet.toString());

			 DAO - 쿼리 실행 후 결과 획득 
			 예약발매요청열차수신처리상태조회  
			ArrayList<Map<String, Object>> resultList
			= (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.ys.ab.YSAB001QMDAO.selectRsvSaleDmnTrnRcvPrsStt", inputDataSet);

			for(int i = 0 ; i < 10 ; i++)
			{
				if(resultList.size() > i)
				{
					LOGGER.debug(resultList.get(i).toString());
				}

				

			}
			//error 메시지 날리기
			if(resultList.isEmpty())
			{
				XframeControllerUtils.setMessage("IZZ000004", result);
			}
			else
			{
				XframeControllerUtils.setMessage("IZZ000009", result);
			}
			result.put("dsGrdChkRecv", resultList);
			return result;
			
		}*/
	 
}

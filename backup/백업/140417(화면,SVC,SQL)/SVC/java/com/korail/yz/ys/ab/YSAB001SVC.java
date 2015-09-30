/**
 * project : KORAIL_YZ
 * package : com.korail.yz.ys.ab
 * date : 2014. 4. 8.오후 4:17:31
 */
package com.korail.yz.ys.ab;


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
 * @date 2014. 4. 8. 오후 4:17:31
 * Class description : 
 */
 @Service("com.korail.yz.ys.ab.YSAB001SVC")
public class YSAB001SVC {


		@Resource(name = "commDAO")
		private CommDAO dao;
			
		@Resource(name="messageSource")
		MessageSource messageSource;
		
		public  final Logger logger = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
		
		/**
		 * @author 한현섭
		 * @date 2014. 4. 8. 오후 5:04:28
		 * Method description : 수익관리작업요청목록
		 * @param param
		 * @return
		 */
		@SuppressWarnings("unchecked")
		public Map<String, ?> selectListYmgtJobDmnLst(Map<String, ?> param){
			
			
			/* 리턴 오브젝트 */
			Map<String, Object> result = new HashMap<String, Object>();

			
			/* 입력 오브젝트 */
			Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsGrdYmgtCond");
			logger.debug("inputDateSet--->"+inputDataSet.toString());

			
			/* DAO - 쿼리 실행 후 결과 획득*/
			ArrayList<Map<String, Object>> resultList
			= (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.ys.ab.YSAB001QMDAO.selectListYmgtJobDmnLst", inputDataSet);

			
			for(int i=0;i<10;i++)
			{
				if(resultList.size() > i)
				logger.debug(resultList.get(i).toString());
				
			}
			//error 메시지 날리기
			if(resultList.size() > 0){
				XframeControllerUtils.setMessage("IZZ000009", result);
			}
			else
			{
				XframeControllerUtils.setMessage("IZZ000004", result);
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
			
			
			/* 리턴 오브젝트 */
			Map<String, Object> result = new HashMap<String, Object>();

			/* 입력 오브젝트 */
			Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsGrdYmgtDtlCond");
			logger.debug("inputDateSet--->"+inputDataSet.toString());
			
			
			/* DAO - 쿼리 실행 후 결과 획득*/
			ArrayList<Map<String, Object>> resultList
			= (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.ys.ab.YSAB001QMDAO.selectListYmgtJobDmnDtlLst", inputDataSet);
			
			
			for(int i=0;i<10;i++)
			{
				if(resultList.size() > i)
					logger.debug(resultList.get(i).toString());
				
			}
			
			//error 메시지 날리기
			if(resultList.size() > 0){
				XframeControllerUtils.setMessage("IZZ000009", result);
			}
			else
			{
				XframeControllerUtils.setMessage("IZZ000004", result);
			}
			
			result.put("dsGrdYmgtDtlList", resultList);
			return result;
			
		}
		
		
		
		/**
		 * @author 한현섭
		 * @date 2014. 4. 8. 오후 5:04:30
		 * Method description : KTX예약발매요청열차수신확인
		 * @param param
		 * @return
		 */
		@SuppressWarnings("unchecked")
		public Map<String, ?> insertKtxRsvSaleDmnTrnRcvCfm(Map<String, ?> param){
			String trnDv = "KTX";
			
			
			/* 리턴 오브젝트 */
			Map<String, Object> result = new HashMap<String, Object>();
			
			ArrayList<Map<String, Object>> resultList = new ArrayList<Map<String,Object>>();
			HashMap<String, Object> resultMap = new HashMap<String, Object>();
			resultMap.put("TRN_FLAG", trnDv);
			
			
			/* 입력 오브젝트 */
			Map<String, String> inputDataSet = new HashMap<String, String>();
			logger.debug("inputDateSet--->"+inputDataSet.toString());

			
			/* DAO - 쿼리 실행 후 결과 획득 */
			/* 예약발매요청열차수신처리상태조회  */
			ArrayList<Map<String, Object>> rcvPrsSttResultList
			= (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.ys.ab.YSAB001QMDAO.selectRsvSaleDmnTrnRcvPrsStt", inputDataSet);
			
			
			/* 수신처리상태에 따라 분기  */
			
			
			if(rcvPrsSttResultList.size() != 0 && "1".equals((String) rcvPrsSttResultList.get(0).get("RCV_PRS_STT_CD")))
			{
				//처리중인 경우
				resultMap.put("RESULT_FLAG", "0");
				resultList.add(resultMap);
				result.put("dsRsvDmnTrnRcvCfm", resultList);
				return result;
			
			}else
			{
				//처리중이 아닐 때
				//sqno 최대값 구하기
				ArrayList<Map<String, Object>> rsvTrnSqnoResultList
				= (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.ys.ab.YSAB001QMDAO.selectRsvSaleDmnTrnSqnoMax", inputDataSet);	
				String maxSqno = (String) rsvTrnSqnoResultList.get(0).get("EXC_SQNO");
				
				//insert를 위한 inputDateSet설정
				inputDataSet.clear();
				inputDataSet.put("EXC_SQNO", maxSqno);
				inputDataSet.put("USER_ID", XframeControllerUtils.getUserId(param));
				
				//insert 실행
				try{
					dao.list("com.korail.yz.ys.ab.YSAB001QMDAO.insertRsvSaleDmnTrnData", inputDataSet);
				}catch(Exception e){
					//Insert실패 시
					resultMap.put("RESULT_FLAG", "1");
					resultList.add(resultMap);
					result.put("dsRsvDmnTrnRcvCfm", resultList);
					return result;
				}
			}
			//Insert성공시
			XframeControllerUtils.setMessage("IZZ000009", result);
			resultMap.put("RESULT_FLAG", "2");
			resultList.add(resultMap);
			result.put("dsRsvDmnTrnRcvCfm", resultList);			
			return result;
		}
		
		
		/**
		 * @author 한현섭
		 * @date 2014. 4. 8. 오후 5:04:33
		 * Method description : 새마을예약발매요청열차수신확인
		 * @param param
		 * @return
		 */
		@SuppressWarnings("unchecked")
		public Map<String, ?> insertSmlRsvSaleDmnTrnRcvCfm(Map<String, ?> param){
			String trnDv = "SML";
			
			
			/* 리턴 오브젝트 */
			Map<String, Object> result = new HashMap<String, Object>();
			
			ArrayList<Map<String, Object>> resultList = new ArrayList<Map<String,Object>>();
			HashMap<String, Object> resultMap = new HashMap<String, Object>();
			resultMap.put("TRN_FLAG", trnDv);
			
			
			/* 입력 오브젝트 */
			Map<String, String> inputDataSet = new HashMap<String, String>();
			logger.debug("inputDateSet--->"+inputDataSet.toString());

			
			/* DAO - 쿼리 실행 후 결과 획득 */
			/* 예약발매요청열차수신처리상태조회  */
			ArrayList<Map<String, Object>> rcvPrsSttResultList
			= (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.ys.ab.YSAB001QMDAO.selectRsvSaleDmnTrnRcvPrsStt", inputDataSet);
			
			
			/* 수신처리상태에 따라 분기  */
			
			
			if(rcvPrsSttResultList.size() != 0 && "1".equals((String) rcvPrsSttResultList.get(0).get("RCV_PRS_STT_CD")))
			{
				//처리중인 경우
				resultMap.put("RESULT_FLAG", "0");
				resultList.add(resultMap);
				result.put("dsRsvDmnTrnRcvCfm", resultList);
				return result;
			
			}else
			{
				//처리중이 아닐 때
				//sqno 최대값 구하기
				ArrayList<Map<String, Object>> rsvTrnSqnoResultList
				= (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.ys.ab.YSAB001QMDAO.selectRsvSaleDmnTrnSqnoMax", inputDataSet);	
				String maxSqno = (String) rsvTrnSqnoResultList.get(0).get("EXC_SQNO");
				
				//insert를 위한 inputDateSet설정
				inputDataSet.clear();
				inputDataSet.put("EXC_SQNO", maxSqno);
				inputDataSet.put("USER_ID", XframeControllerUtils.getUserId(param));
				
				//insert 실행
				try{
					dao.list("com.korail.yz.ys.ab.YSAB001QMDAO.insertRsvSaleDmnTrnData", inputDataSet);
				}catch(Exception e){
					//Insert실패 시
					resultMap.put("RESULT_FLAG", "1");
					resultList.add(resultMap);
					result.put("dsRsvDmnTrnRcvCfm", resultList);
					return result;
				}
			}
			//Insert성공시
			XframeControllerUtils.setMessage("IZZ000009", result);
			resultMap.put("RESULT_FLAG", "2");
			resultList.add(resultMap);
			result.put("dsRsvDmnTrnRcvCfm", resultList);			
			return result;
		}
		
		
		/**
		 * @author 한현섭
		 * @date 2014. 4. 8. 오후 5:04:35
		 * Method description : 최적화실행
		 * @param param
		 * @return
		 */
		@SuppressWarnings("unchecked")
		public Map<String, ?> insertOtmzExc(Map<String, ?> param){
			
			
			/* 리턴 오브젝트 */
			Map<String, Object> result = new HashMap<String, Object>();
			ArrayList<Map<String, String>> messageList = new ArrayList<Map<String, String>>();
			HashMap<String, String> msgMap = new HashMap<String, String>();

			/* 입력 오브젝트 */
			Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsRsvOptExc");
			logger.debug("inputDateSet--->"+inputDataSet.toString());

			/* DAO - 쿼리 검증 */
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
					logger.debug("error--->"+result.get("dsRsvOptChkErrTb").toString());
				}
				return result;
			}
			
			//최적화 배치 실행 
			else
			{
				ProcessBuilder ktxBatch = new ProcessBuilder("/app/apyz/batch/bin/yzdb910_ba_u1");//KTX
				ProcessBuilder smlBatch = new ProcessBuilder("/app/apyz/batch/bin/yzdb920_ba_u1");//새마을
				try {
					Process ktxProcess = ktxBatch.start();
					Process smlProcess = smlBatch.start();
				} catch (Exception e) {
					msgMap.put("BATCH_RESULT", "최적화에 실패하였습니다.");
					messageList.add(msgMap);
					result.put("dsRsvOptResult", messageList);
				}

			}
			

			return result;
			
		}
		
		/**
		 * @author 한현섭
		 * @date 2014. 4. 10. 오후 2:52:11
		 * Method description : 
		 * @param param
		 * @return
		 */
		@SuppressWarnings("unchecked")
		public Map<String, ?> selectRsvSaleDmnTrnRcvPrsStt(Map<String, ?> param){
			/* 리턴 오브젝트 */
			Map<String, Object> result = new HashMap<String, Object>();
			
			/* 입력 오브젝트 */
			Map<String, String> inputDataSet = new HashMap<String, String>();
			logger.debug("inputDateSet--->"+inputDataSet.toString());

			/* DAO - 쿼리 실행 후 결과 획득 */
			/* 예약발매요청열차수신처리상태조회  */
			ArrayList<Map<String, Object>> resultList
			= (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.ys.ab.YSAB001QMDAO.selectRsvSaleDmnTrnRcvPrsStt", inputDataSet);

			for(int i=0;i<10;i++)
			{
				if(resultList.size() > i)
				logger.debug(resultList.get(i).toString());
				
			}
			
			result.put("dsGrdChkRecv", resultList);
			return result;
			
		}
	 
}

/**
 * project : KORAIL_YZ
 * package : com.korail.yz.yb.ca
 * date : 2014. 6. 21.오후 4:31:19
 */
package com.korail.yz.yb.ca;

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
 * @date 2014. 6. 21. 오후 4:31:19
 * Class description : DCP 예외열차관리를 위한 Service Class
 */
@Service("com.korail.yz.yb.ca.YBCA002SVC")
public class YBCA002SVC {

		@Resource(name = "commDAO")
		private CommDAO dao;
			
		@Resource(name="messageSource")
		MessageSource messageSource;
		
		public  final Logger LOGGER = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
	 
		/**
		 * @author 한현섭
		 * @date 2014. 6. 24. 오후 10:28:12
		 * Method description : DCP예외열차이력조회
		 * @param param
		 * @return
		 */
		@SuppressWarnings("unchecked")
		public Map<String, ?>  selectListYdcpExctHst(Map<String, ?> param){
		
	 		/* 리턴 오브젝트 */
			Map<String, Object> result = new HashMap<String, Object>();

			/* 입력 오브젝트 */
			Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsGrdCond");

			/* DAO - 쿼리 실행 후 결과 획득*/
			List<Map<String, Object>> resultList
			= (List<Map<String, Object>>) dao.list("com.korail.yz.yb.ca.YBCA002QMDAO.selectListYdcpExctHst", inputDataSet);

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
		 * @date 2014. 6. 24. 오후 10:28:14
		 * Method description : DCP 예외열차 수정
		 * @param param
		 * @return
		 */
		@SuppressWarnings("unchecked")
		public Map<String, ?>  updateYdcpExctMdfy(Map<String, ?> param){
			
			/* 리턴 오브젝트 */
			Map<String, Object> result = new HashMap<String, Object>();
			
			/* 입력 오브젝트 */
			List<Map<String, String>> inputDataArray = (List<Map<String, String>>) param.get("dsModifyCond");
			Map<String, String> inputAplSet = XframeControllerUtils	.getParamDataSet(param, "dsModifyCondAplTrm");
			boolean aplFlag = (0 != Integer.parseInt(inputAplSet.get("APL_DPT_FLAG")));
			/* DAO - 쿼리 실행 후 결과 획득*/
			
			if(aplFlag)
			{
				List<Map<String, Object>> aplDayResultList
				= (List<Map<String, Object>>) dao.list("com.korail.yz.yb.ca.YBCA002QMDAO.selectYdcpExctDupCfm", inputAplSet);
				if(aplDayResultList.isEmpty())
				{
					try{
						dao.update("com.korail.yz.yb.ca.YBCA002QMDAO.updateYdcpExctTrmMdfy", inputAplSet);
						
					}catch(Exception ex1){
						XframeControllerUtils.setMessage("EYB000002", result);
						return result;
					}
				}
			}else
			{
				try{
					for(Map<String, String> inputDataSet : inputDataArray)
					{
						String dptBfVal = inputDataSet.get("DPT_BF_DT_NUM");
						
						if("".equals(dptBfVal))
						{
							dao.update("com.korail.yz.yb.ca.YBCA002QMDAO.deleteYdcpExctDel", inputDataSet);
						}else
						{
							int isSuc = dao.update("com.korail.yz.yb.ca.YBCA002QMDAO.updateYdcpExctMdfy", inputDataSet);
							if(isSuc == 0)
							{
								dao.insert("com.korail.yz.yb.ca.YBCA002QMDAO.insertYdcpExctReg", inputDataSet);
							}
							
						}
					}
				}catch(Exception ex1){
					XframeControllerUtils.setMessage("EYB000002", result);
					return result;
				}
			}

			//성공메시지 설정
			XframeControllerUtils.setMessage("IYB000007", result);
			
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
		 * @date 2014. 6. 24. 오후 10:28:15
		 * Method description : 선택한 DCP예외열차의 상세내용을 조회
		 * @param param
		 * @return
		 */
		@SuppressWarnings("unchecked")
		public Map<String, ?>  selectYdcpDtlList(Map<String, ?> param){
			
			/* 리턴 오브젝트 */
			Map<String, Object> result = new HashMap<String, Object>();
			
			/* 입력 오브젝트 */
			Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsGrdCondRight");
			
			/* DAO - 쿼리 실행 후 결과 획득*/
			List<Map<String, Object>> resultList
			= (List<Map<String, Object>>) dao.list("com.korail.yz.yb.ca.YBCA002QMDAO.selectYdcpDtlList", inputDataSet);
			
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
		 * @date 2014. 6. 24. 오후 10:28:16
		 * Method description : 신규 예외열차 DCP 값을 등록
		 * @param param
		 * @return
		 */
		@SuppressWarnings("unchecked")
		public Map<String, ?>  insertYdcpExctReg(Map<String, ?> param){
			
			/* 리턴 오브젝트 */
			Map<String, Object> result = new HashMap<String, Object>();
			
			/* 입력 오브젝트 */
			List<Map<String, String>> inputDataArray = (List<Map<String, String>>) param.get("dsInsertCond");
			Map<String, String> inputAplSet = XframeControllerUtils	.getParamDataSet(param, "dsInsertCondAplTrm");
			List<Map<String, String>> inputDayArray = (List<Map<String, String>>) param.get("dsInsertCondDayDvCd");
			
			/* DAO - 중복체크*/
			boolean bIsNotDup = false;
			try{
				for(Map<String, String> inputAplDaySet : inputDayArray)
				{
					inputAplDaySet.putAll(inputAplSet);
					List<Map<String, Object>> aplDayResultList
					= (List<Map<String, Object>>) dao.list("com.korail.yz.yb.ca.YBCA002QMDAO.selectYdcpExctDupCfm", inputAplDaySet);
					
					bIsNotDup = aplDayResultList.isEmpty();
						
					if(!bIsNotDup){
						XframeControllerUtils.setMessage("WYB000033", result);
						return result;
					}
				}
			}catch(Exception e)
			{
				XframeControllerUtils.setMessage("EYB000006", result);
				return result;
			}
			
			
			/* DAO - 입력*/
			try{
				for(Map<String, String> inputDataSet : inputDataArray)
				{
					dao.update("com.korail.yz.yb.ca.YBCA002QMDAO.insertYdcpExctReg", inputDataSet);
				}
			}catch(Exception e)
			{
				XframeControllerUtils.setMessage("EYB000007", result);
				return result;
			}
			//성공메시지 설정
			XframeControllerUtils.setMessage("IYB000006", result);
			
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
		 * @date 2014. 6. 24. 오후 10:28:18
		 * Method description : DCP예외열차삭제
		 * @param param
		 * @return
		 */
		@SuppressWarnings("unchecked")
		public Map<String, ?>  deleteYdcpExctDel(Map<String, ?> param){
			
			/* 리턴 오브젝트 */
			Map<String, Object> result = new HashMap<String, Object>();
			
			/* 입력 오브젝트 */
			List<Map<String, String>> inputDataArray = (List<Map<String, String>>) param.get("dsLoadCond");
			
			/* DAO - 쿼리 실행 후 결과 획득*/
			try{
				for(Map<String, String> inputDataSet : inputDataArray)
				{
					dao.update("com.korail.yz.yb.ca.YBCA002QMDAO.deleteYdcpExctDel", inputDataSet);
				}
			}catch(Exception e)
			{
				XframeControllerUtils.setMessage("EZZ000019", result);
				return result;
			}
			
			XframeControllerUtils.setMessage("IZZ000011", result);
			List<Map<String,String>> isSuccessList = new ArrayList<Map<String,String>>();
			Map<String,String> isSuccessSet = new HashMap<String, String>();
			
			isSuccessSet.put("FLAG", "T");
			isSuccessList.add(isSuccessSet);
			result.put("dsSaveFlag", isSuccessList);
			return result;
		}
		
		
		/**
		 * @author 한현섭
		 * @date 2014. 6. 24. 오후 10:28:19
		 * Method description : DCP 예외열차 정보 목록을 조회
		 * @param param
		 * @return
		 */
		@SuppressWarnings("unchecked")
		public Map<String, ?>  selectListTrnList(Map<String, ?> param){
			
			/* 리턴 오브젝트 */
			Map<String, Object> result = new HashMap<String, Object>();
			
			/* 입력 오브젝트 */
			Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsGrdCondLeft");
			
			String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
			if("".equals(trnOprBzDvCd) || trnOprBzDvCd == null){
				trnOprBzDvCd = "000";
			}
			inputDataSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
			
			/* DAO - 쿼리 실행 후 결과 획득*/
			List<Map<String, Object>> resultList
			= (List<Map<String, Object>>) dao.list("com.korail.yz.yb.ca.YBCA002QMDAO.selectListTrnList", inputDataSet);
			
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
		 * @date 2014. 6. 24. 오후 10:28:20
		 * Method description : DCP예외열차 등록 이력 확인
		 * @param param
		 * @return
		 */
		@SuppressWarnings("unchecked")
		public Map<String, ?>  selectYdcpExctDupCfm(Map<String, ?> param){
			
			/* 리턴 오브젝트 */
			Map<String, Object> result = new HashMap<String, Object>();
			
			/* 입력 오브젝트 */
			Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsGrdCond");
			
			/* DAO - 쿼리 실행 후 결과 획득*/
			List<Map<String, Object>> resultList
			= (List<Map<String, Object>>) dao.list("com.korail.yz.yb.ca.YBCA001QMDAO.selectListYdcpLst", inputDataSet);
			
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
		 * @date 2014. 6. 27. 오전 10:08:14
		 * Method description : DCP구분번호/출발전일수조회
		 * @param param
		 * @return
		 */
		@SuppressWarnings("unchecked")
		public Map<String, ?>  selectListDcpInfo(Map<String, ?> param){
			
			/* 리턴 오브젝트 */
			Map<String, Object> result = new HashMap<String, Object>();
			
			/* 입력 오브젝트 */
			Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsLoadCond");
			
			/* DAO - 쿼리 실행 후 결과 획득*/
			List<Map<String, Object>> resultList
			= (List<Map<String, Object>>) dao.list("com.korail.yz.yb.ca.YBCA002QMDAO.selectListDcpInfo", inputDataSet);
			
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
}

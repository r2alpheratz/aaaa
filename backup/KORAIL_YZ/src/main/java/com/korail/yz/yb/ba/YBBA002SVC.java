/**
 * project : KORAIL_YZ
 * package : com.korail.yz.yb.ba
 * date : 2014. 6. 7.오전 11:44:20
 */
package com.korail.yz.yb.ba;

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
 * @date 2014. 6. 7. 오전 11:44:20
 * Class description : 노선별 수익관리할당을 위한 FLAG설정 Service 클래스
 */

@Service("com.korail.yz.yb.ba.YBBA002SVC")
public class YBBA002SVC {


	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public  final Logger LOGGER = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
 
	
	/**
	 * @author 한현섭
	 * @date 2014. 6. 10. 오후 4:12:58
	 * Method description : 노선별 할당여부목록을 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListRoutAlcFlgLst(Map<String, ?> param){
	
 		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();

		/* 입력 오브젝트 */
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsGrdListCond");

		/* DAO - 쿼리 실행 후 결과 획득*/
		ArrayList<Map<String, Object>> resultList
		= (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.yb.ba.YBBA002QMDAO.selectListRoutAlcFlgLst", inputDataSet);

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
	 * @date 2014. 6. 10. 오후 4:12:55
	 * Method description : 노선별 할당값 여부 등록을 위해 노선 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListRoutAlcFlgRegQry(Map<String, ?> param){
		
		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		
		/* 입력 오브젝트 */
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCondition");
		
		/* DAO - 쿼리 실행 후 결과 획득*/
		ArrayList<Map<String, Object>> resultList
		= (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.yb.aa.YBAA001QMDAO.", inputDataSet);
		
		//error 메시지 날리기
		if(resultList.isEmpty()){
			XframeControllerUtils.setMessage("IZZ000004", result);
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result);
		}
		result.put("dsGrdRoutInfo", resultList);
		return result;
	}
	
	/**
	 * @author 한현섭
	 * @date 2014. 6. 10. 오후 4:13:32
	 * Method description : 노선별 할당값 FLAG 등록정보를 저장
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> insertRoutAlcFlgReq(Map<String, ?> param){
		
		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		
		/* 입력 오브젝트 */
		List<Map<String, String>> inputDataArray = (List<Map<String, String>>) param.get("dsGrdRoutRight");
		Map<String, String> pramDataSet = inputDataArray.get(0);
		
		/* 분기조건 변수 */
		String preAplStDt = inputDataArray.get(0).get("PRE_APL_ST_DT");
		String aplStDt = inputDataArray.get(0).get("APL_ST_DT");
		
		
		StringBuilder sDupRow = new StringBuilder();
		
		/* DAO - 쿼리 실행 및 에러 시 에러메세지 출력 */
		if(aplStDt.equals(preAplStDt))
		{
			long start = System.currentTimeMillis();
			ArrayList<Map<String, Object>> dupChkList			= (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.yb.ba.YBBA002QMDAO.selectListRoutAlcFlgRegQry", null);
			
			
			boolean isDup = false;
			Map<String, String> dupMap = new HashMap<String, String>();
			for(Map<String, String> inputDataSet : inputDataArray)
			{
				String routCd = inputDataSet.get("ROUT_CD");
				String upDnDvCd = inputDataSet.get("UP_DN_DV_CD"); 
				String bizDdStgCd = inputDataSet.get("BIZ_DD_STG_CD");
				String trnClsfCd =  inputDataSet.get("TRN_CLSF_CD");
				
				//ArrayList<Map<String, Object>> dupChkList				= (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.yb.ba.YBBA002QMDAO.selectTest", inputDataSet);
				
				for(Map<String, Object> dupChkSet : dupChkList)
				{
					String chkRoutCd = (String) dupChkSet.get("ROUT_CD");
					String chkUpDnDvCd = (String) dupChkSet.get("UP_DN_DV_CD"); 
					String chkBizDdStgCd = (String) dupChkSet.get("BIZ_DD_STG_CD");
					String chkTrnClsfCd = (String) dupChkSet.get("TRN_CLSF_CD");
					if(   chkRoutCd.equals(routCd) && chkUpDnDvCd.equals(upDnDvCd) 
					   && chkBizDdStgCd.equals(bizDdStgCd) && chkTrnClsfCd.equals(trnClsfCd))
					{
						isDup = true;
						if(!dupMap.containsKey(routCd))
						{
							dupMap.put(routCd, (String) dupChkSet.get("ROUT_NM"));
						}
					}
				}
				if(dupMap.size() > 5)
				{
					break;
				}
				
			}
			
			long end = System.currentTimeMillis();
			LOGGER.debug("실행시간 : "+ ((end - start)/1000.0));
			
			if(!isDup)
			{
				try{
					for(Map<String, String> inputDataSet : inputDataArray)
					{
						dao.insert("com.korail.yz.yb.ba.YBBA002QMDAO.insertRoutAlcFlgReq", inputDataSet);
					}	
				}catch(Exception e){
					XframeControllerUtils.setMessage("EYB000002", result);
					return result;	
				}
			}else
			{
				Object[] keyArray =  dupMap.keySet().toArray();
				for(int i = 0 ; i < 4 ; i++ )
				{
					sDupRow.append("노선명 : ");
					sDupRow.append(dupMap.get(keyArray[i].toString()));
					sDupRow.append("\n");
				}
				
				
				
				//성공메시지 설정
				XframeControllerUtils.setMessage("EYB000002", result);
				
				//성공여부 설정
				List<Map<String,String>> isSuccessList = new ArrayList<Map<String,String>>();
				Map<String,String> isSuccessSet = new HashMap<String, String>();
				
				isSuccessSet.put("DUP_MSG", sDupRow.toString());
				isSuccessList.add(isSuccessSet);
				result.put("dsSaveFlag", isSuccessList);
				
				return result;
			}
		}else
		{
			try{
				dao.update("com.korail.yz.yb.ba.YBBA002QMDAO.updateHstAplDtMdfy", pramDataSet);
			}catch(Exception ex0){
				XframeControllerUtils.setMessage("EYB000004", result);
				return result;
			}
			
			try{
				for(Map<String, String> inputDataSet : inputDataArray)
				{
					dao.insert("com.korail.yz.yb.ba.YBBA002QMDAO.insertRoutAlcFlgReq", inputDataSet);	
				}
			}catch(Exception ex1){
				XframeControllerUtils.setMessage("EYB000002", result);
				return result;
			}
			
			try{
				dao.insert("com.korail.yz.yb.ba.YBBA002QMDAO.insertBfRoutNewAlc", pramDataSet);
			}catch(Exception ex2){
				XframeControllerUtils.setMessage("EYB000003", result);
				return result;
			}
		}
		
		//성공메시지 설정
		XframeControllerUtils.setMessage("IYB000003", result);
		
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
	 * @date 2014. 6. 10. 오후 4:13:39
	 * Method description : 적용운행기간조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectAplRunTrm(Map<String, ?> param){
		
 		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();

		/* DAO - 쿼리 실행 후 결과 획득*/
		ArrayList<Map<String, Object>> resultList
		= (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.yb.ba.YBBA002QMDAO.selectAplRunTrm", null);

		//error 메시지 날리기
		if(resultList.isEmpty()){
			XframeControllerUtils.setMessage("IZZ000004", result);
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result);
		}
		result.put("dsAplRunTrm", resultList);
		return result;
	}
	
	/**
	 * @author 한현섭
	 * @date 2014. 6. 10. 오후 4:13:42
	 * Method description : 노선별 열차할당 FLAG 등록을 위한 노선조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListRoutQry(Map<String, ?> param){
		
		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		
		/* 입력 오브젝트 */
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsRoutCond");

		inputDataSet.put("FLAG", "FALSE");
		
		/* DAO - 쿼리 실행 후 결과 획득*/
		//우측그리드 노선 픽리스트 조회
		List<Map<String, Object>> resultList1
		= (List<Map<String, Object>>) dao.list("com.korail.yz.yb.ba.YBBA002QMDAO.selectListRoutQry", inputDataSet);
		
		//좌측그리드 노선 조회
		inputDataSet.put("FLAG", "TRUE");
		
		List<Map<String, Object>> resultList2
		= (List<Map<String, Object>>) dao.list("com.korail.yz.yb.ba.YBBA002QMDAO.selectListRoutQry", inputDataSet);
		
		//error 메시지 날리기
		if(resultList1.isEmpty() || resultList2.isEmpty() ){
			XframeControllerUtils.setMessage("IZZ000004", result);
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result);
		}
		
		result.put("dsGrdRoutComboPick", resultList1);
		result.put("dsGrdRoutLeft", resultList2);
		return result;
	}
	
	
	/**
	 * @author 한현섭
	 * @date 2014. 6. 10. 오후 4:13:36
	 * Method description : 노선별 수익관리할당FLAG값 설정 정보를 수정
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> updateRoutAlcFlgMdfy(Map<String, ?> param){
		
		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		
		/* 입력 오브젝트 */
		List<Map<String, String>> inputDataArray = (ArrayList<Map<String, String>>) param.get("dsUpdateCond");
		
		int isSuc = 0;
		
		/* DAO - 쿼리 실행 후 결과 획득*/
		try{
			for(Map<String, String> inputDataSet : inputDataArray)
			{
				isSuc = dao.update("com.korail.yz.yb.ba.YBBA002QMDAO.updateRoutAlcFlgMdfy", inputDataSet);
			}
		}catch(Exception e)
		{
			XframeControllerUtils.setMessage("EYB000005", result);
			return result;
		}
		
		
		if(isSuc > 0)
		{
			//성공메시지 설정
			XframeControllerUtils.setMessage("IZZ000013", result);
			//성공여부 설정
			List<Map<String,String>> isSuccessList = new ArrayList<Map<String,String>>();
			Map<String,String> isSuccessSet = new HashMap<String, String>();
			isSuccessSet.put("FLAG", "T");
			isSuccessList.add(isSuccessSet);
			result.put("dsSaveFlag", isSuccessList);
		}
		
		//error 메시지 날리기
		return result;
	}
	
	
	/**
	 * @author 한현섭
	 * @date 2014. 6. 11. 오후 2:48:49
	 * Method description : 수정시 필요한 노선별할당여부 목록을 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListRoutForUpdate(Map<String, ?> param){
		
		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		
		/* 입력 오브젝트 */
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsGrdListCond");
		
		/* DAO - 쿼리 실행 후 결과 획득*/
		List<Map<String, Object>> resultList
		= (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.yb.ba.YBBA002QMDAO.selectListRoutForUpdate", inputDataSet);
		
		//error 메시지 날리기
		if(resultList.isEmpty()){
			XframeControllerUtils.setMessage("IZZ000004", result);
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result);
		}
		result.put("dsGrdRout", resultList);
		return result;
	}
}

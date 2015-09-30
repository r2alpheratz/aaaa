/**
 * project : KORAIL_YZ
 * package : com.korail.yz.ys.ba
 * date : 2014. 4. 29.오후 1:30:24
 */
package com.korail.yz.ys.ba;

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
import cosmos.comm.exception.CosmosRuntimeException;
/**
 * @author EQ
 * @date 2014. 4. 29. 오후 1:30:24
 * Class description : 예외열차사용자조정수요예측SVC
 */
@Service("com.korail.yz.ys.ba.YSBA002SVC")
public class YSBA002SVC {
	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public  static final Logger LOGGER = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
	
	/**
	 * 사용자조정수요예측예외열차조회
	 * @author 김응규
	 * @date 2014. 4. 17. 오후 1:39:15
	 * Method description : 수요예측 사용자조정 이력이 있는 예외열차를 조회한다.  
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map<String, ?> selectListUsrCtlDmdFcstExctTrn(Map<String, ?> param) {		

		Map<String, Object> result = new HashMap<String, Object>();
		
		LOGGER.debug("param ==> "+param);
		// search input column dataset
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");
		//열차운영사업자구분코드 추가
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		inputDataSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		LOGGER.debug("inputDataSet ==>  " + inputDataSet);
		
		ArrayList<Map<String, Object>> resultList = (ArrayList) dao.list("com.korail.yz.ys.ba.YSBA002QMDAO.selectListUsrCtlDmdFcstExctTrn", inputDataSet);

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
	 * 사용자조정수요예측예외열차상세조회
	 * @author 김응규
	 * @date 2014. 4. 17. 오후 1:39:15
	 * Method description : 수요예측 사용자조정 이력이 있는 예외열차의 상세내역을 조회한다.  
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map<String, ?> selectListUsrCtlDmdFcstExctTrnDtl(Map<String, ?> param) {		

		Map<String, Object> result = new HashMap<String, Object>();

		LOGGER.debug("param ==> "+param);
		// search input column dataset
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCondDtl");
		//열차운영사업자구분코드 추가
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		inputDataSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		LOGGER.debug("inputDataSet ==>  " + inputDataSet);
		
		ArrayList<Map<String, Object>> resultList = (ArrayList) dao.list("com.korail.yz.ys.ba.YSBA002QMDAO.selectListUsrCtlDmdFcstExctTrnDtl", inputDataSet);

		//메시지 처리
		if(resultList.isEmpty()){
			XframeControllerUtils.setMessage("IZZ000004", result);  //해당 조건의 자료가 존재하지 않습니다.
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
	 * @date 2014. 5. 8. 오전 11:19:38
	 * Method description : 예외열차 사용자조정예상수요수 수정
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> updateUsrCtlExpnDmdNumExct(Map<String, ?> param) {		

		Map<String, Object> result = new HashMap<String, Object>();

		LOGGER.debug("param ==> "+param);

		ArrayList<Map<String, String>> usrCtlList = (ArrayList<Map<String, String>>) param.get("dsListDtl");
		
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCondDtl");
		//열차운영사업자구분코드 추가
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		inputDataSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		LOGGER.debug("inputDataSet ==>  " + inputDataSet);
		String userId = String.valueOf(param.get("USER_ID"));
		String runDt = inputDataSet.get("RUN_DT");
		int updateCnt = 0;
		int deleteCnt = 0;
	    LOGGER.debug("usrCtlList 사이즈:::::::::::::::"+usrCtlList.size());
	    for( int i = 0; i < usrCtlList.size() ; i++ )
	    {
	    	Map<String, String> item = usrCtlList.get(i);
	    	
	    	LOGGER.debug("usrCtlList["+i+"]번째 ROW =====>"+item);
	    	item.put("USER_ID", userId);
	    	item.put("RUN_DT", runDt);
	    	
	    	if(item.get("DMN_PRS_DV_CD").equals("U")) /*요청처리구분코드가 U : update*/
	    	{
	    		updateCnt += dao.update("com.korail.yz.ys.ba.YSBA002QMDAO.updateUsrCtlExpnDmdNumExct", item);	
	    	}
	    	else if(item.get("DMN_PRS_DV_CD").equals("D"))
	    	{
	    		deleteCnt += dao.delete("com.korail.yz.ys.ba.YSBA002QMDAO.deleteUsrCtlExpnDmdNumExct", item);
	    	}
	    }
	    LOGGER.debug("수정 ["+updateCnt+"] 건, 삭제 ["+deleteCnt+"] 건 수행하였습니다.");
	  //메시지 처리
  		if(updateCnt < 1 && deleteCnt < 1){
  			XframeControllerUtils.setMessage("WYZ000007", result); //해당 자료를 수정할수 없습니다.	수정자료를 확인하여 주십시오.
  		}
  		else
  		{
  			XframeControllerUtils.setMessage("IZZ000013", result); //정상적으로 저장 되었습니다.
  		}
  		
		return result;

	}
	
	/**
	 * @author 김응규
	 * @date 2014. 4. 21. 오전 9:17:38
	 * Method description : 사용자조정예상수요수 등록(예외)
	 * @param param
	 * @return
	 * @throws Exception e
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map<String, ?> insertUsrCtlExpnDmdNumExct(Map<String, ?> param) throws Exception {		

		Map<String, Object> result = new HashMap<String, Object>();
		ArrayList<Map<String, String>> resultList = new ArrayList<Map<String,String>>();
			
		LOGGER.debug("param ==> "+param);
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");
		//열차운영사업자구분코드 추가
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		inputDataSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		LOGGER.debug("inputDataSet ==>  " + inputDataSet);
		ArrayList<Map<String, String>> inputList = (ArrayList<Map<String, String>>) param.get("dsList");
		String userId = String.valueOf(param.get("USER_ID"));
		inputDataSet.put("USER_ID", userId);
		
		int insertCnt = 0; //등록건수
	
		/**===================================================================================================
		 * 이력생성 구분 별 정합성 및 중복체크
		 * */

		LOGGER.debug("예외열차 정합성 및 중복체크 시작 빡!!!!!!!!!!!!!!");
		//1. 정합성 및 중복체크
		
		for (int i = 0; i < inputList.size(); i++)
		{
			Map<String, String> item = inputList.get(i);
			item.putAll(inputDataSet);
			ArrayList<Map<String, Object>> hstCntList = (ArrayList) dao.list("com.korail.yz.ys.ba.YSBA002QMDAO.selectExctHstCnt", item);
			if(!hstCntList.isEmpty())
			{
				if(Integer.parseInt(hstCntList.get(0).get("CNT").toString()) > 0)
				{
					throw new CosmosRuntimeException("WZZ000013", null); 
					//이미 등록된 내역이 존재합니다.  입력값을 확인하십시오. 
				}
			}
			else //조회에러시
			{
				throw new CosmosRuntimeException("WZZ000012", null);  //등록 작업이 실패하였습니다 - 입력값을 확인하십시오.
			}
		}
		LOGGER.debug("예외열차  정합성 및 중복체크 끄읕!!!!!!!!!!!!!!");
		/**===================================================================================================
		 * 정합성 및 중복체크 종료
		 * */
		
		
		/**===================================================================================================
		 * 데이터 등록
		 * */
		
		LOGGER.debug("예외열차 데이터 등록 시작!!! ::");
		insertCnt = 0;
		for (int i = 0; i < inputList.size(); i++)
		{
			Map<String, String> item = inputList.get(i);
			item.putAll(inputDataSet);
			insertCnt += dao.insert("com.korail.yz.ys.ba.YSBA002QMDAO.insertUsrCtlExpnDmdNumExct", item);
		}
		if(insertCnt < 1)
		{
			throw new CosmosRuntimeException("WZZ000012", null);  //등록 작업이 실패하였습니다 - 입력값을 확인하십시오.
		}
		else
		{
			LOGGER.debug("예외열차사용자조정예상수요 ["+insertCnt+"] 건 등록되었습니다!!!");
			XframeControllerUtils.setMessage("IZZ000013", result); //정상적으로 저장 되었습니다.
			inputDataSet.put("INSERT_FLAG", "Y");
			resultList.add(inputDataSet);
		}
		/**===================================================================================================
		 * 이력생성 구분 별 데이터 등록 종료
		 * */
		LOGGER.debug("이력생성 구분 별 데이터 등록 종료!!!");
		result.put("dsCond", resultList);
		return result;
	}
}

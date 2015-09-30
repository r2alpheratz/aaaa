/**
 * project : KORAIL_YZ
 * package : com.korail.yz.ys.ba
 * date : 2014. 4. 17.오후 1:30:24
 */
package com.korail.yz.ys.ba;

import java.util.ArrayList;
import java.util.Calendar;
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
 * @date 2014. 4. 17. 오후 1:30:24
 * Class description : 기본열차사용자조정수요예측SVC
 */
@Service("com.korail.yz.ys.ba.YSBA001SVC")
public class YSBA001SVC {
	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public  static final Logger LOGGER = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
	
	/**
	 * 사용자조정수요예측기본열차조회
	 * @author 김응규
	 * @date 2014. 4. 17. 오후 1:39:15
	 * Method description : 수요예측 사용자조정 이력이 있는 기본열차를 조회한다.  
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map<String, ?> selectListUsrCtlDmdFcstBsTrn(Map<String, ?> param) {		

		Map<String, Object> result = new HashMap<String, Object>();
		
		LOGGER.debug("param ==> "+param);
		// search input column dataset
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");
		//열차운영사업자구분코드 추가
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		inputDataSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		LOGGER.debug("inputDataSet ==>  " + inputDataSet);
		
		ArrayList<Map<String, Object>> resultList = new ArrayList<Map<String,Object>>();
		if("Y".equals(inputDataSet.get("RUN_DT_STDR")))
		{
			resultList = (ArrayList) dao.list("com.korail.yz.ys.ba.YSBA001QMDAO.selectListUsrCtlDmdFcstBsTrn", inputDataSet);
		}
		else if("Y".equals(inputDataSet.get("TRN_NO_STDR")))
		{
			resultList = (ArrayList) dao.list("com.korail.yz.ys.ba.YSBA001QMDAO.selectListUsrCtlDmdFcstBsTrn2", inputDataSet);
		}

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
	 * 사용자조정수요예측기본열차상세조회
	 * @author 김응규
	 * @date 2014. 4. 17. 오후 1:39:15
	 * Method description : 수요예측 사용자조정 이력이 있는 기본열차의 상세내역을 조회한다.  
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map<String, ?> selectListUsrCtlDmdFcstBsTrnDtl(Map<String, ?> param) {		

		Map<String, Object> result = new HashMap<String, Object>();

		LOGGER.debug("param ==> "+param);
		// search input column dataset
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCondDtl");
		//열차운영사업자구분코드 추가
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		inputDataSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		LOGGER.debug("inputDataSet ==>  " + inputDataSet);
		
		ArrayList<Map<String, Object>> resultList = (ArrayList) dao.list("com.korail.yz.ys.ba.YSBA001QMDAO.selectListUsrCtlDmdFcstBsTrnDtl", inputDataSet);

		//메시지 처리
		if(resultList.isEmpty()){
			XframeControllerUtils.setMessage("IZZ000004", result);
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result);
		}
		result.put("dsListDtl", resultList);

		return result;

	}
	
	/**
	 * 사용자조정수요예측기본열차 적용기간조회(추가)
	 * @author 김응규
	 * @date 2014. 10. 10. 오후 1:39:15
	 * Method description : 열차번호기준 조회시 입력한 열차번호에 대한 사용자조정이력이 있는 기간을 조회해온다.   
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map<String, ?> selectListDmdFcstBsAplTrm(Map<String, ?> param) {		

		Map<String, Object> result = new HashMap<String, Object>();

		LOGGER.debug("param ==> "+param);
		// search input column dataset
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");
		//열차운영사업자구분코드 추가
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		inputDataSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		LOGGER.debug("inputDataSet ==>  " + inputDataSet);
		
		ArrayList<Map<String, Object>> resultList = (ArrayList) dao.list("com.korail.yz.ys.ba.YSBA001QMDAO.selectListDmdFcstBsAplTrm", inputDataSet);

		//메시지 처리
		if(resultList.isEmpty()){
			XframeControllerUtils.setMessage("IZZ000004", result);
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result);
		}
		result.put("dsAplTrm", resultList);

		return result;

	}
	/**
	 * 사용자조정예상수요 복사등록 복사대상열차조회
	 * @author 김응규
	 * @date 2014. 5. 12. 오후 4:20:15
	 * Method description : 사용자조정예상수요 복사등록할 복사대상열차를 조회한다.
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map<String, ?> selectListUsrCtlExpnDmdCpyTgtTrn(Map<String, ?> param) {		

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
		
		ArrayList<Map<String, Object>> resultList = (ArrayList) dao.list("com.korail.yz.ys.ba.YSBA001QMDAO.selectListUsrCtlExpnDmdCpyTgtTrn", inputDataSet);

		//메시지 처리
		if(resultList.isEmpty()){
			XframeControllerUtils.setMessage("IZZ000004", result);
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result);
		}
		result.put("dsList", resultList);

		return result;

	}
		
	/**
	 * @author 김응규
	 * @date 2014. 4. 21. 오전 9:17:38
	 * Method description : 사용자조정예상수요수 수정
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> updateUsrCtlExpnDmdNum(Map<String, ?> param) {		

		Map<String, Object> result = new HashMap<String, Object>();

		LOGGER.debug("param ==> "+param);

		ArrayList<Map<String, String>> usrCtlList = (ArrayList<Map<String, String>>) param.get("dsListDtl");
		
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCondDtl");
		//열차운영사업자구분코드 추가
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		inputDataSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		LOGGER.debug("inputDataSet ==>  " + inputDataSet);
		String userId = String.valueOf(param.get("USER_ID"));
		String aplStDt = inputDataSet.get("APL_ST_DT");
		String aplClsDt = inputDataSet.get("APL_CLS_DT");
		int updateCnt = 0;
		int deleteCnt = 0;
	    LOGGER.debug("usrCtlList 사이즈:::::::::::::::"+usrCtlList.size());
	    for( int i = 0; i < usrCtlList.size() ; i++ )
	    {
	    	Map<String, String> item = usrCtlList.get(i);
	    	
	    	LOGGER.debug("usrCtlList["+i+"]번째 ROW =====>"+item);
	    	item.put("USER_ID", userId);
	    	item.put("APL_ST_DT", aplStDt);
	    	item.put("APL_CLS_DT", aplClsDt);
	    	
	    	if(item.get("DMN_PRS_DV_CD").equals("U")) /*요청처리구분코드가 U : update*/
	    	{
	    		updateCnt += dao.update("com.korail.yz.ys.ba.YSBA001QMDAO.updateUsrCtlExpnDmdNum", item);	
	    	}
	    	else if(item.get("DMN_PRS_DV_CD").equals("D"))
	    	{
	    		deleteCnt += dao.delete("com.korail.yz.ys.ba.YSBA001QMDAO.deleteUsrCtlExpnDmdNum", item);
	    	}
	    }
	    LOGGER.debug("수정 ["+updateCnt+"] 건, 삭제 ["+deleteCnt+"] 건 수행하였습니다.");
	  //메시지 처리
  		if(updateCnt < 1 && deleteCnt < 1){
  			throw new CosmosRuntimeException("WYZ000007", null);  ////해당 자료를 수정할수 없습니다.	수정자료를 확인하여 주십시오.
  		}
  		else
  		{
  			XframeControllerUtils.setMessage("IZZ000013", result); //정상적으로 저장 되었습니다.
  		}
		return result;

	}

	/**
	 * @author 김응규
	 * @date 2014. 5. 13. 오전 9:17:38
	 * Method description : 사용자조정예상수요수 복사등록
	 * @param param
	 * @return
	 * @throws Exception e
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map<String, ?> insertUsrCtlExpnDmdNumCopy(Map<String, ?> param) throws Exception {		

		Map<String, Object> result = new HashMap<String, Object>();
		ArrayList<Map<String, String>> resultList = new ArrayList<Map<String,String>>();
			
		LOGGER.debug("param ==> "+param);
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsRegCond");
		//열차운영사업자구분코드 추가
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		inputDataSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		LOGGER.debug("inputDataSet ==>  " + inputDataSet);
		ArrayList<Map<String, String>> inputList = (ArrayList<Map<String, String>>) param.get("dsRegTgtTrnList");
		String userId = String.valueOf(param.get("USER_ID"));
 		String hstCreDv = inputDataSet.get("HST_CRE_DV");
		inputDataSet.put("USER_ID", userId);
		
		int insertCnt = 0; //등록건수
		int updateCnt = 0; //수정건수
		//조회해온 적용시작/종료 일자, 입력받은 적용시작/종료 일자(대소비교를 위해 int로 초기화)
		int aplStDt, aplClsDt, inputAplStDt, inputAplClsDt;
		if(!"NEW".equals(hstCreDv))  //신규인경우엔 조회해온적용일자를 숫자로 변환할 필요없음 ::: (조회하지 않고 입력할수도 있기 때문에 ""을 숫자로 변환하면 NumberFormatException 발생함) 
		{
			aplStDt = Integer.parseInt(inputDataSet.get("APL_ST_DT")); 							//조회해온 적용시작일자
			aplClsDt = Integer.parseInt(inputDataSet.get("APL_CLS_DT")); 							//조회해온 적용종료일자
		}
		else
		{
			aplStDt = 0;
			aplClsDt = 0;
		}
		inputAplStDt = Integer.parseInt(inputDataSet.get("INPUT_APL_ST_DT")); 	//입력받은 적용시작일자
		inputAplClsDt = Integer.parseInt(inputDataSet.get("INPUT_APL_CLS_DT")); 	//입력받은 적용시작일자
		
		int inputAplStYear = Integer.parseInt(inputDataSet.get("INPUT_APL_ST_DT").substring(0, 4));
		int inputAplStMonth = Integer.parseInt(inputDataSet.get("INPUT_APL_ST_DT").substring(4, 6));
		int inputAplStDate = Integer.parseInt(inputDataSet.get("INPUT_APL_ST_DT").substring(6, 8));
		LOGGER.debug("입력 적용시작년도:::::"+inputAplStYear);
		LOGGER.debug("입력 적용시작월:::::"+inputAplStMonth);
		LOGGER.debug("입력 적용시작일:::::"+inputAplStDate);
		
		int inputAplClsYear = Integer.parseInt(inputDataSet.get("INPUT_APL_CLS_DT").substring(0, 4));
		int inputAplClsMonth = Integer.parseInt(inputDataSet.get("INPUT_APL_CLS_DT").substring(4, 6));
		int inputAplClsDate = Integer.parseInt(inputDataSet.get("INPUT_APL_CLS_DT").substring(6, 8));
		LOGGER.debug("입력 적용종료년도:::::"+inputAplClsYear);
		LOGGER.debug("입력 적용종료월:::::"+inputAplClsMonth);
		LOGGER.debug("입력 적용종료일:::::"+inputAplClsDate);
		
	    Calendar calInputAplStDt = Calendar.getInstance(); //입력받은적용시작일자
	    Calendar calInputAplClsDt = Calendar.getInstance(); //입력받은적용종료일자
	    calInputAplStDt.set(inputAplStYear, inputAplStMonth-1, inputAplStDate);
	    calInputAplClsDt.set(inputAplClsYear, inputAplClsMonth-1, inputAplClsDate);
	    
		
		
		
		/**===================================================================================================
		 * 이력생성 구분 별 정합성 및 중복체크
		 * */
		if("ADD".equals(hstCreDv))  //분할생성(추가등록)
		{
				LOGGER.debug("분할생성 정합성 및 중복체크 시작 빡!!!!!!!!!!!!!!");
				//1. 정합성 및 중복체크
				
				ArrayList<Map<String, Object>> hstCntList = (ArrayList) dao.list("com.korail.yz.ys.ba.YSBA001QMDAO.selectHstCntAdd", inputDataSet);
				
				if(!hstCntList.isEmpty())
				{
					if("0".equals(String.valueOf(hstCntList.get(0).get("CNT"))))
					{
						throw new CosmosRuntimeException("WYF000004", null);
						//"이력생성구분이 분할인 경우 대상 이력이 존재하여야 합니다."
					}
				}
				else //조회에러시
				{
					throw new CosmosRuntimeException("WZZ000012", null);  //등록 작업이 실패하였습니다 - 입력값을 확인하십시오.
				}
				if(aplStDt > inputAplStDt  || aplClsDt < inputAplClsDt)
				{
					throw new CosmosRuntimeException("WYF000003", null);  //이력생성구분이 분할인 경우 적용기간은 대상 이력의 적용기간 범위를 벗어나게 입력할 수 없습니다.
				}
				else
				{
					ArrayList<Map<String, Object>> inputValidChkList = (ArrayList) dao.list("com.korail.yz.ys.ba.YSBA001QMDAO.selectListInputValidChk", inputDataSet);
					if(!inputValidChkList.isEmpty())
					{
						for (int i = 0; i < inputList.size(); i++)
						{
							for (int j = 0; j < inputValidChkList.size(); j++)
						                                       	{
								String sInputData = inputList.get(i).get("DAY_DV_CD") +  inputList.get(i).get("PSRM_CL_CD") 
										+ inputList.get(i).get("DPT_RS_STN_CD") + inputList.get(i).get("ARV_RS_STN_CD")  + inputList.get(i).get("BKCL_CD");
								String sCompData = (String) inputValidChkList.get(j).get("DAY_DV_CD")+inputValidChkList.get(j).get("PSRM_CL_CD")
										+ inputValidChkList.get(j).get("DPT_RS_STN_CD") + inputValidChkList.get(j).get("ARV_RS_STN_CD") + inputValidChkList.get(j).get("BKCL_CD");
								LOGGER.debug("비교시작!!!::: ["+i+" - "+j+"]");
								LOGGER.debug("입력받은데이터:::"+sInputData);
								LOGGER.debug("기존등록데이터:::"+sCompData);
								if(sInputData.equals(sCompData))
								{
									throw new CosmosRuntimeException("WZZ000014", null);  //이미 등록된 자료가 존재합니다.  입력한 자료를 확인하십시오.
								} //END  if(sInputData.equals(sCompData))
							}//END for (int j = 0; j < inputValidChkList.size(); j++)
						} //END for (int i = 0; i < inputList.size(); i++)
					} //END if(inputValidChkList.size() > 0)
				} //END  if(aplStDt > inputAplStDt  || aplClsDt < inputAplClsDt)  else
				LOGGER.debug("분할생성 정합성 및 중복체크 끄읕!!!!!!!!!!!!!!");
		}
		else if("NEW".equals(hstCreDv)) //신규생성
		{
			LOGGER.debug("신규생성 정합성 및 중복체크 시작 빡!!!!!!!!!!!!!!");
			//1. 정합성 및 중복체크
			ArrayList<Map<String, Object>> hstCntList = (ArrayList) dao.list("com.korail.yz.ys.ba.YSBA001QMDAO.selectHstCnt", inputDataSet);
			
			if(!hstCntList.isEmpty())
			{
				if(Integer.parseInt(String.valueOf(hstCntList.get(0).get("CNT"))) > 0)
				{
					throw new CosmosRuntimeException("WYF000002", null); 
					//이력생성구분이 신규의 경우 적용기간은 등록되어 있는 이력의 적용기간과 중첩되어 입력할 수 없습니다. -적용기간을 확인하여 주십시오.
				}
			}
			else //조회에러시
			{
				throw new CosmosRuntimeException("WZZ000012", null);  //등록 작업이 실패하였습니다 - 입력값을 확인하십시오.
			}
			LOGGER.debug("신규생성 정합성 및 중복체크 끄읕!!!!!!!!!!!!!!");
		}
		/**===================================================================================================
		 * 이력생성 구분 별 정합성 및 중복체크 종료
		 * */
		
		
		/**===================================================================================================
		 * 이력생성 구분 별 데이터 등록
		 * */
		LOGGER.debug("이력생성 구분 별 데이터 등록 START!!!!!!!!!!!!!!");
		insertCnt = 0;
		if ("ADD".equals(hstCreDv))  //분할생성(추가등록)
		{
			LOGGER.debug("이력생성 구분 :: 분할생성(추가등록) ::");
			//시작일자가 동일한경우 
			if (aplStDt == inputAplStDt )
			{
				LOGGER.debug("조회해온 적용시작일자와 입력받은 적용시작일자가 같으면서::::::::::::::::::::::::");
				//종료일자가 대상이력의 종료일자와 같은경우 입력받은 적용기간에 입력한 기본값 insert
				if (aplClsDt == inputAplClsDt)
				{
					LOGGER.debug("조회해온 적용종료일자가 입력받은 적용종료일자와 같은경우 입력받은 적용기간에 입력한 기본값 insert START!!!!!");
					for (int i = 0; i < inputList.size(); i++)
					{
						Map<String, String> item = inputList.get(i);
						item.putAll(inputDataSet);
						LOGGER.debug("분할생성 사용자조정예상수요 등록 빡!!!!!!!!!!!!!!");
						insertCnt += dao.insert("com.korail.yz.ys.ba.YSBA001QMDAO.insertUsrCtlExpnDmdNum", item);
					}
					if(insertCnt < 1)
					{
						throw new CosmosRuntimeException("WZZ000012", null);  //등록 작업이 실패하였습니다 - 입력값을 확인하십시오.
					}
					else
					{
						LOGGER.debug("분할 기간 ["+inputAplStDt+"~"+inputAplClsDt+"] 로 ["+insertCnt+"] 건 추가 등록되었습니다!!!");
						inputDataSet.put("INSERT_FLAG", "Y");
						inputDataSet.remove("APL_ST_DT");
						inputDataSet.put("APL_ST_DT", String.valueOf(inputAplStDt));
						inputDataSet.put("TRN_NO", inputDataSet.get("TRN_NO"));
						resultList.add(inputDataSet);
					}
				}//END if (aplClsDt == inputAplClsDt)
				 //입력받은 적용종료일자가 작은경우 기존값을 입력받은 일자로 update후 ( inputAplClsDt ~ aplClsDt )기간으로 insert
				else if (aplClsDt > inputAplClsDt) 
				{
					LOGGER.debug("조회해온 적용종료일자보다 입력받은 적용종료일자가 작은 경우에 대한 처리 START!!!!!");
					// 1. 조회한 적용기간의 종료일자를 입력받은 적용기간의 종료일자로 update
					LOGGER.debug("1. 조회한 적용기간의 종료일자를 입력받은 적용기간의 종료일자로 update");
					updateCnt = 0;
					
					updateCnt = dao.update("com.korail.yz.ys.ba.YSBA001QMDAO.updateAplClsDt", inputDataSet);
					
					if(updateCnt < 1)
					{
						throw new CosmosRuntimeException("WZZ000012", null);  //등록 작업이 실패하였습니다 - 입력값을 확인하십시오.
					}
					else
					{
						LOGGER.debug("1. 기존데이터의 분할 기간이 ["+aplStDt+"~"+inputAplClsDt+"] 로 ["+updateCnt+"] 건 수정되었습니다!!!");	
					}
					// 2. 입력받은 적용기간의 종료일자+1 ~ 조회한 적용기간의 종료일자까지 이전데이타 copy
					LOGGER.debug("2. 입력받은 적용기간의 종료일자+1 ~ 조회한 적용기간의 종료일자까지 이전데이타 copy START!!!!!");
					calInputAplClsDt.add(Calendar.DATE, 1); //입력받은 적용종료일자에 1일을 더한다.
					String newAplStDt = new java.text.SimpleDateFormat("yyyyMMdd").format(calInputAplClsDt.getTime());
					insertCnt = 0;
					
					inputDataSet.put("NEW_APL_ST_DT", newAplStDt);
					insertCnt = dao.insert("com.korail.yz.ys.ba.YSBA001QMDAO.insertUsrCtlExpnDmdAddCopy", inputDataSet);
				
					if(insertCnt < 1)
					{
						throw new CosmosRuntimeException("WZZ000012", null);  //등록 작업이 실패하였습니다 - 입력값을 확인하십시오.
					}
					else
					{
						LOGGER.debug("2. 분할 기간 ["+newAplStDt+"~"+aplClsDt+"] 로 ["+insertCnt+"] 건 복사등록되었습니다!!!");
					}
					calInputAplClsDt.add(Calendar.DATE, -1); //입력받은 적용종료일자에 1일을 다시 빼준다.
					//3. 입력받은 적용기간에 입력한 기본값 insert
					LOGGER.debug("3. 입력받은 적용기간에 입력한 기본값 insert START!!!!!");
					insertCnt = 0;
					for (int i = 0; i < inputList.size(); i++)
					{
						Map<String, String> item = inputList.get(i);
						item.putAll(inputDataSet);
						insertCnt += dao.insert("com.korail.yz.ys.ba.YSBA001QMDAO.insertUsrCtlExpnDmdNum", item);
					}
					if(insertCnt < 1)
					{
						throw new CosmosRuntimeException("WZZ000012", null);  //등록 작업이 실패하였습니다 - 입력값을 확인하십시오.
					}
					else
					{
						LOGGER.debug("3. 입력받은 적용기간 ["+inputAplStDt+"~"+inputAplClsDt+"] 로 ["+insertCnt+"] 건 추가등록되었습니다!!!");
						inputDataSet.put("INSERT_FLAG", "Y");
						inputDataSet.remove("APL_ST_DT");
						inputDataSet.put("APL_ST_DT", String.valueOf(inputAplStDt));
						inputDataSet.put("TRN_NO", inputDataSet.get("TRN_NO"));
						resultList.add(inputDataSet);
					}	
				} //END else if (aplClsDt > inputAplClsDt) 
			}//END if (aplStDt == inputAplStDt )
			else if (aplStDt < inputAplStDt)  //조회해온 적용시작일자가 입력받은적용시작일자보다 작은경우
			{
				LOGGER.debug("조회해온 적용시작일자가 입력받은적용시작일자보다 작으면서::::::::::::::::::::::::");
				if (aplClsDt == inputAplClsDt) //조회해온 적용종료일자와 입력받은 적용종료일자가 같은경우 
				{
					LOGGER.debug("조회해온 적용종료일자와 입력받은 적용종료일자가 같은경우에 대한 처리 START!!!!!");
					// 1. 조회한 적용기간의 종료일자를 입력받은 적용기간의 시작일자(INPUT_APL_ST_DT)-1로 update
					LOGGER.debug("1. 조회한 적용기간의 종료일자를 입력받은 적용기간의 시작일자(INPUT_APL_ST_DT)-1로 update!!!!!!!!!!!!!!");
					calInputAplStDt.add(Calendar.DATE, -1); //입력받은 적용시작일자에 1일을 뺀다.
					//새로운 적용종료일자 생성(입력받은적용시작일자-1)
					String newAplClsDt = new java.text.SimpleDateFormat("yyyyMMdd").format(calInputAplStDt.getTime());
					updateCnt = 0;
					
					inputDataSet.put("NEW_APL_CLS_DT", newAplClsDt);
					updateCnt = dao.update("com.korail.yz.ys.ba.YSBA001QMDAO.updateAplClsDt2", inputDataSet);
					
					if(updateCnt < 1)
					{
						throw new CosmosRuntimeException("WZZ000012", null);  //등록 작업이 실패하였습니다 - 입력값을 확인하십시오.
					}
					else
					{
						LOGGER.debug("1. 기존데이터의 분할 기간이 ["+aplStDt+"~"+newAplClsDt+"] 로 ["+updateCnt+"] 건 수정되었습니다!!!");	
						calInputAplStDt.add(Calendar.DATE, 1); //(-1일을 했던)입력받은 적용시작일자에 1일을 다시 더한다.
					}
					// 2. 입력받은 적용기간에 이전데이타 copy
					LOGGER.debug(" 2. 입력받은 적용기간에 이전데이타 copy   START!!!!!!!!!!!!!");
					insertCnt = 0;
					
					inputDataSet.put("NEW_APL_CLS_DT", newAplClsDt);  //이전데이터의 기간이 APL_ST_DT ~ NEW_APL_CLS_DT로 업데이트되었으므로 이기간에서 데이터를 복사함.
					insertCnt += dao.insert("com.korail.yz.ys.ba.YSBA001QMDAO.insertUsrCtlExpnDmdAddCopy2", inputDataSet);
					if(insertCnt < 1)
					{
						throw new CosmosRuntimeException("WZZ000012", null);  //등록 작업이 실패하였습니다 - 입력값을 확인하십시오.
					}
					else
					{
						LOGGER.debug("입력받은 적용기간["+inputAplStDt+"~"+inputAplClsDt+"]에 기존데이터 ["+insertCnt+"] 건이 복사 등록되었습니다!!!");
					}
					
					// 3. 입력받은 적용기간에 입력한 기본값 추가 insert
					LOGGER.debug("3. 입력받은 적용기간에 입력한 기본값 추가insert  START!!!!!!!!!!!!!");
					insertCnt = 0;
					for (int i = 0; i < inputList.size(); i++)
					{
						Map<String, String> item = inputList.get(i);
						item.putAll(inputDataSet);
						insertCnt += dao.insert("com.korail.yz.ys.ba.YSBA001QMDAO.insertUsrCtlExpnDmdNum", item);
					}
					if(insertCnt < 1)
					{
						throw new CosmosRuntimeException("WZZ000012", null);  //등록 작업이 실패하였습니다 - 입력값을 확인하십시오.
					}
					else
					{
						LOGGER.debug("입력받은 적용기간["+inputAplStDt+"~"+inputAplClsDt+"]에 입력한기본값이 ["+insertCnt+"] 건이 추가등록되었습니다!!!");
						inputDataSet.put("INSERT_FLAG", "Y");
						inputDataSet.remove("APL_ST_DT");
						inputDataSet.put("APL_ST_DT", String.valueOf(inputAplStDt));
						inputDataSet.put("TRN_NO", inputDataSet.get("TRN_NO"));
						resultList.add(inputDataSet);
					}	
				} //END if (aplClsDt == inputAplClsDt) //조회해온 적용종료일자와 입력받은 적용종료일자가 같은경우 
				else if (aplClsDt > inputAplClsDt)
				{
					LOGGER.debug("조회한 적용종료일자가 입력받은 적용종료일자보다 큰경우에 대한 처리  START!!!!!!!!!!!!!");
					// 1. 조회한 적용기간의 종료일자를 입력받은 적용기간의 시작일자-1로 update
					LOGGER.debug("1. 조회한 적용기간의 종료일자를 입력받은 적용기간의 시작일자-1로 update  START!!!!!!!!!!!!!");
					
					calInputAplStDt.add(Calendar.DATE, -1); //입력받은 적용시작일자에 1일을 뺀다.
					//새로운 적용종료일자 생성(입력받은적용시작일자-1)
					String newAplClsDt = new java.text.SimpleDateFormat("yyyyMMdd").format(calInputAplStDt.getTime());
					updateCnt = 0;
					
					inputDataSet.put("NEW_APL_CLS_DT", newAplClsDt);
					updateCnt = dao.update("com.korail.yz.ys.ba.YSBA001QMDAO.updateAplClsDt2", inputDataSet);
					
					if(updateCnt < 1)
					{
						throw new CosmosRuntimeException("WZZ000012", null);  //등록 작업이 실패하였습니다 - 입력값을 확인하십시오.
					}
					else
					{
						LOGGER.debug("1. 기존데이터의 분할 기간이 ["+aplStDt+"~"+newAplClsDt+"] 로 ["+updateCnt+"] 건 수정되었습니다!!!");	
						calInputAplStDt.add(Calendar.DATE, 1); //(-1일을 했던)입력받은 적용시작일자에 1일을 다시 더한다.
					}
					
					// 2. 입력받은 적용기간에 이전데이타 copy
					LOGGER.debug("2. 입력받은 적용기간에 이전데이타 copy  START!!!!!!!!!!!!!");
					insertCnt = 0;
				
					inputDataSet.put("NEW_APL_CLS_DT", newAplClsDt);  //이전데이터의 기간이 APL_ST_DT ~ NEW_APL_CLS_DT로 업데이트되었으므로 이기간에서 데이터를 복사함.
					insertCnt = dao.insert("com.korail.yz.ys.ba.YSBA001QMDAO.insertUsrCtlExpnDmdAddCopy2", inputDataSet);
					if(insertCnt < 1)
					{
						throw new CosmosRuntimeException("WZZ000012", null);  //등록 작업이 실패하였습니다 - 입력값을 확인하십시오.
					}
					else
					{
						LOGGER.debug("입력받은 적용기간["+inputAplStDt+"~"+inputAplClsDt+"]에 기존데이터 ["+insertCnt+"] 건이 복사 등록되었습니다!!!");
					}
					
					// 3. 입력받은 적용기간의 종료일자+1 ~ 조회한 적용기간의 종료일자까지 이전데이타 copy
					LOGGER.debug("3. 입력받은 적용기간의 종료일자+1 ~ 조회한 적용기간의 종료일자까지 이전데이타 copy  START!!!!!!!!!!!!!");
					//새로운 적용 시작일자 생성(입력받은적용시작일자-1)
					calInputAplClsDt.add(Calendar.DATE, 1); //입력받은 적용종료일자에 1일을 더한다.
					String newAplStDt = new java.text.SimpleDateFormat("yyyyMMdd").format(calInputAplClsDt.getTime());
					insertCnt = 0;
					
					inputDataSet.put("NEW_APL_ST_DT", newAplStDt);  //새로운 적용시작일자~조회해온 적용시작일자로 이전데이터를 복사할것임.
					insertCnt = dao.insert("com.korail.yz.ys.ba.YSBA001QMDAO.insertUsrCtlExpnDmdAddCopy3", inputDataSet);
				
					if(insertCnt < 1)
					{
						throw new CosmosRuntimeException("WZZ000012", null);  //등록 작업이 실패하였습니다 - 입력값을 확인하십시오.
					}
					else
					{
						LOGGER.debug("3. 적용기간["+newAplStDt+"~"+aplClsDt+"]에 기존데이터 ["+insertCnt+"] 건이 복사 등록되었습니다!!!");
						calInputAplClsDt.add(Calendar.DATE, -1); //(더했던)입력받은 적용종료일자에 1일을 다시 뺀다.
					}
					
					
					
					// 4. 입력받은 적용기간에 입력한 기본값 insert
					LOGGER.debug("4. 입력받은 적용기간에 입력한 기본값 추가 insert  START!!!!!!!!!!!!!");
					
					insertCnt = 0;
					for (int i = 0; i < inputList.size(); i++)
					{
						Map<String, String> item = inputList.get(i);
						item.putAll(inputDataSet);
						insertCnt += dao.insert("com.korail.yz.ys.ba.YSBA001QMDAO.insertUsrCtlExpnDmdNum", item);
					}
					if(insertCnt < 1)
					{
						throw new CosmosRuntimeException("WZZ000012", null);  //등록 작업이 실패하였습니다 - 입력값을 확인하십시오.
					}
					else
					{
						LOGGER.debug("4. 입력받은 적용기간["+inputAplStDt+"~"+inputAplClsDt+"]에 입력한기본값이 ["+insertCnt+"] 건이 추가등록되었습니다!!!");
						inputDataSet.put("INSERT_FLAG", "Y");
						inputDataSet.remove("APL_ST_DT");
						inputDataSet.put("APL_ST_DT", String.valueOf(inputAplStDt));
						inputDataSet.put("TRN_NO", inputDataSet.get("TRN_NO"));
						resultList.add(inputDataSet);
					}	
				} // END else if (aplClsDt > inputAplClsDt) //조회해온 적용종료일자가 입력받은적용종료일자보다 큰경우
			} //END else if (aplStDt < inputAplStDt)  //조회해온 적용시작일자가 입력받은적용시작일자보다 작은경우
		} //END if ("ADD".equals(hstCreDv))  //분할생성(추가등록)
		else if("NEW".equals(hstCreDv)) //신규생성
		{
			LOGGER.debug("이력생성 구분 :: 신규생성(얘는 그냥 INSERT만 하면 끝.) ::");
			insertCnt = 0;
			for (int i = 0; i < inputList.size(); i++)
			{
				Map<String, String> item = inputList.get(i);
				item.putAll(inputDataSet);
				insertCnt += dao.insert("com.korail.yz.ys.ba.YSBA001QMDAO.insertUsrCtlExpnDmdNum", item);
			}
			if(insertCnt < 1)
			{
				throw new CosmosRuntimeException("WZZ000012", null);  //등록 작업이 실패하였습니다 - 입력값을 확인하십시오.
			}
			else
			{
				LOGGER.debug("신규 적용기간 ["+inputAplStDt+"~"+inputAplClsDt+"] 로 ["+insertCnt+"] 건 등록되었습니다!!!");
				XframeControllerUtils.setMessage("IZZ000013", result); //정상적으로 저장 되었습니다.
				inputDataSet.put("INSERT_FLAG", "Y");
				inputDataSet.remove("APL_ST_DT");
				inputDataSet.put("APL_ST_DT", String.valueOf(inputAplStDt));
				inputDataSet.put("TRN_NO", inputDataSet.get("TRN_NO"));
				resultList.add(inputDataSet);
			}
		} //END else if("NEW".equals(hstCreDv)) //신규생성
		/**===================================================================================================
		 * 이력생성 구분 별 데이터 등록 종료
		 * */
		LOGGER.debug("이력생성 구분 별 데이터 등록 종료!!!");
		result.put("dsRegCond", resultList);
		return result;
	}
	
	/**
	 * @author 김응규
	 * @date 2014. 4. 21. 오전 9:17:38
	 * Method description : 사용자조정예상수요수 등록
	 * @param param
	 * @return
	 * @throws Exception e
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map<String, ?> insertUsrCtlExpnDmdNum(Map<String, ?> param) throws Exception {		

		Map<String, Object> result = new HashMap<String, Object>();
		ArrayList<Map<String, String>> resultList = new ArrayList<Map<String,String>>();
			
		LOGGER.debug("param ==> "+param);
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");	
		LOGGER.debug("inputDataSet ==>  " + inputDataSet);
		ArrayList<Map<String, String>> inputList = (ArrayList<Map<String, String>>) param.get("dsList");
		String userId = String.valueOf(param.get("USER_ID"));
		String hstCreDv = inputDataSet.get("HST_CRE_DV");
		inputDataSet.put("USER_ID", userId);
		
		int insertCnt = 0; //등록건수
		int updateCnt = 0; //수정건수
		//조회해온 적용시작/종료 일자, 입력받은 적용시작/종료 일자(대소비교를 위해 int로 초기화)
		int aplStDt, aplClsDt, inputAplStDt, inputAplClsDt;
		if(!"NEW".equals(hstCreDv))  //신규인경우엔 조회해온적용일자를 숫자로 변환할 필요없음 ::: (조회하지 않고 입력할수도 있기 때문에 ""을 숫자로 변환하면 NumberFormatException 발생함) 
		{
			aplStDt = Integer.parseInt(inputDataSet.get("APL_ST_DT")); 							//조회해온 적용시작일자
			aplClsDt = Integer.parseInt(inputDataSet.get("APL_CLS_DT")); 							//조회해온 적용종료일자
		}
		else
		{
			aplStDt = 0;
			aplClsDt = 0;
		}
		inputAplStDt = Integer.parseInt(inputDataSet.get("INPUT_APL_ST_DT")); 	//입력받은 적용시작일자
		inputAplClsDt = Integer.parseInt(inputDataSet.get("INPUT_APL_CLS_DT")); 	//입력받은 적용시작일자
		
		int inputAplStYear = Integer.parseInt(inputDataSet.get("INPUT_APL_ST_DT").substring(0, 4));
		int inputAplStMonth = Integer.parseInt(inputDataSet.get("INPUT_APL_ST_DT").substring(4, 6));
		int inputAplStDate = Integer.parseInt(inputDataSet.get("INPUT_APL_ST_DT").substring(6, 8));
		LOGGER.debug("입력 적용시작년도:::::"+inputAplStYear);
		LOGGER.debug("입력 적용시작월:::::"+inputAplStMonth);
		LOGGER.debug("입력 적용시작일:::::"+inputAplStDate);
		
		int inputAplClsYear = Integer.parseInt(inputDataSet.get("INPUT_APL_CLS_DT").substring(0, 4));
		int inputAplClsMonth = Integer.parseInt(inputDataSet.get("INPUT_APL_CLS_DT").substring(4, 6));
		int inputAplClsDate = Integer.parseInt(inputDataSet.get("INPUT_APL_CLS_DT").substring(6, 8));
		LOGGER.debug("입력 적용종료년도:::::"+inputAplClsYear);
		LOGGER.debug("입력 적용종료월:::::"+inputAplClsMonth);
		LOGGER.debug("입력 적용종료일:::::"+inputAplClsDate);
		
	    Calendar calInputAplStDt = Calendar.getInstance(); //입력받은적용시작일자
	    Calendar calInputAplClsDt = Calendar.getInstance(); //입력받은적용종료일자
	    calInputAplStDt.set(inputAplStYear, inputAplStMonth-1, inputAplStDate);
	    calInputAplClsDt.set(inputAplClsYear, inputAplClsMonth-1, inputAplClsDate);
	    
		
		
		
		/**===================================================================================================
		 * 이력생성 구분 별 정합성 및 중복체크
		 * */
		if("ADD".equals(hstCreDv))  //분할생성(추가등록)
		{
				LOGGER.debug("분할생성 정합성 및 중복체크 시작 빡!!!!!!!!!!!!!!");
				//1. 정합성 및 중복체크
				
				ArrayList<Map<String, Object>> hstCntList = (ArrayList) dao.list("com.korail.yz.ys.ba.YSBA001QMDAO.selectHstCntAdd", inputDataSet);
				
				if(!hstCntList.isEmpty())
				{
					if("0".equals(hstCntList.get(0).get("CNT").toString()))
					{
						throw new CosmosRuntimeException("WYF000004", null);
						//"이력생성구분이 분할인 경우 대상 이력이 존재하여야 합니다."
					}
				}
				else //조회에러시
				{
					throw new CosmosRuntimeException("WZZ000012", null);  //등록 작업이 실패하였습니다 - 입력값을 확인하십시오.
				}
				if(aplStDt > inputAplStDt  || aplClsDt < inputAplClsDt)
				{
					throw new CosmosRuntimeException("WYF000003", null);  //이력생성구분이 분할인 경우 적용기간은 대상 이력의 적용기간 범위를 벗어나게 입력할 수 없습니다.
				}
				else
				{
					ArrayList<Map<String, Object>> inputValidChkList = (ArrayList) dao.list("com.korail.yz.ys.ba.YSBA001QMDAO.selectListInputValidChk", inputDataSet);
					if(!inputValidChkList.isEmpty())
					{
						for (int i = 0; i < inputList.size(); i++)
						{
							for (int j = 0; j < inputValidChkList.size(); j++)
							{
								String sInputData = inputList.get(i).get("DAY_DV_CD") +  inputList.get(i).get("PSRM_CL_CD") 
										+ inputList.get(i).get("DPT_RS_STN_CD") + inputList.get(i).get("ARV_RS_STN_CD")  + inputList.get(i).get("BKCL_CD");
								String sCompData = (String) inputValidChkList.get(j).get("DAY_DV_CD")+inputValidChkList.get(j).get("PSRM_CL_CD")
										+ inputValidChkList.get(j).get("DPT_RS_STN_CD") + inputValidChkList.get(j).get("ARV_RS_STN_CD") + inputValidChkList.get(j).get("BKCL_CD");
								LOGGER.debug("비교시작!!!::: ["+i+" - "+j+"]");
								LOGGER.debug("입력받은데이터:::"+sInputData);
								LOGGER.debug("기존등록데이터:::"+sCompData);
								if(sInputData.equals(sCompData))
								{
									throw new CosmosRuntimeException("WZZ000014", null);  //이미 등록된 자료가 존재합니다.  입력한 자료를 확인하십시오.
								} //END  if(sInputData.equals(sCompData))
							}//END for (int j = 0; j < inputValidChkList.size(); j++)
						} //END for (int i = 0; i < inputList.size(); i++)
					} //END if(inputValidChkList.size() > 0)
				} //END  if(aplStDt > inputAplStDt  || aplClsDt < inputAplClsDt)  else
				LOGGER.debug("분할생성 정합성 및 중복체크 끄읕!!!!!!!!!!!!!!");
		}
		else if("NEW".equals(hstCreDv)) //신규생성
		{
			LOGGER.debug("신규생성 정합성 및 중복체크 시작 빡!!!!!!!!!!!!!!");
			//1. 정합성 및 중복체크
			ArrayList<Map<String, Object>> hstCntList = (ArrayList) dao.list("com.korail.yz.ys.ba.YSBA001QMDAO.selectHstCnt", inputDataSet);
			
			if(!hstCntList.isEmpty())
			{
				if(Integer.parseInt(hstCntList.get(0).get("CNT").toString()) > 0)
				{
					throw new CosmosRuntimeException("WYF000002", null); 
					//이력생성구분이 신규의 경우 적용기간은 등록되어 있는 이력의 적용기간과 중첩되어 입력할 수 없습니다. -적용기간을 확인하여 주십시오.
				}
			}
			else //조회에러시
			{
				throw new CosmosRuntimeException("WZZ000012", null);  //등록 작업이 실패하였습니다 - 입력값을 확인하십시오.
			}
			LOGGER.debug("신규생성 정합성 및 중복체크 끄읕!!!!!!!!!!!!!!");
		}
		/**===================================================================================================
		 * 이력생성 구분 별 정합성 및 중복체크 종료
		 * */
		
		
		/**===================================================================================================
		 * 이력생성 구분 별 데이터 등록
		 * */
		LOGGER.debug("이력생성 구분 별 데이터 등록 START!!!!!!!!!!!!!!");
		insertCnt = 0;
		if ("ADD".equals(hstCreDv))  //분할생성(추가등록)
		{
			LOGGER.debug("이력생성 구분 :: 분할생성(추가등록) ::");
			//시작일자가 동일한경우 
			if (aplStDt == inputAplStDt )
			{
				LOGGER.debug("조회해온 적용시작일자와 입력받은 적용시작일자가 같으면서::::::::::::::::::::::::");
				//종료일자가 대상이력의 종료일자와 같은경우 입력받은 적용기간에 입력한 기본값 insert
				if (aplClsDt == inputAplClsDt)
				{
					LOGGER.debug("조회해온 적용종료일자가 입력받은 적용종료일자와 같은경우 입력받은 적용기간에 입력한 기본값 insert START!!!!!");
					for (int i = 0; i < inputList.size(); i++)
					{
						Map<String, String> item = inputList.get(i);
						item.putAll(inputDataSet);
						LOGGER.debug("분할생성 사용자조정예상수요 등록 빡!!!!!!!!!!!!!!");
						insertCnt += dao.insert("com.korail.yz.ys.ba.YSBA001QMDAO.insertUsrCtlExpnDmdNum", item);
					}
					if(insertCnt < 1)
					{
						throw new CosmosRuntimeException("WZZ000012", null);  //등록 작업이 실패하였습니다 - 입력값을 확인하십시오.
					}
					else
					{
						LOGGER.debug("분할 기간 ["+inputAplStDt+"~"+inputAplClsDt+"] 로 ["+insertCnt+"] 건 추가 등록되었습니다!!!");
						inputDataSet.put("INSERT_FLAG", "Y");
						inputDataSet.remove("APL_ST_DT");
						inputDataSet.put("APL_ST_DT", String.valueOf(inputAplStDt));
						inputDataSet.put("TRN_NO", inputDataSet.get("TRN_NO"));
						resultList.add(inputDataSet);
					}
				}//END if (aplClsDt == inputAplClsDt)
				 //입력받은 적용종료일자가 작은경우 기존값을 입력받은 일자로 update후 ( inputAplClsDt ~ aplClsDt )기간으로 insert
				else if (aplClsDt > inputAplClsDt) 
				{
					LOGGER.debug("조회해온 적용종료일자보다 입력받은 적용종료일자가 작은 경우에 대한 처리 START!!!!!");
					// 1. 조회한 적용기간의 종료일자를 입력받은 적용기간의 종료일자로 update
					LOGGER.debug("1. 조회한 적용기간의 종료일자를 입력받은 적용기간의 종료일자로 update");
					updateCnt = 0;
					
					updateCnt = dao.update("com.korail.yz.ys.ba.YSBA001QMDAO.updateAplClsDt", inputDataSet);
					
					if(updateCnt < 1)
					{
						throw new CosmosRuntimeException("WZZ000012", null);  //등록 작업이 실패하였습니다 - 입력값을 확인하십시오.
					}
					else
					{
						LOGGER.debug("1. 기존데이터의 분할 기간이 ["+aplStDt+"~"+inputAplClsDt+"] 로 ["+updateCnt+"] 건 수정되었습니다!!!");	
					}
					// 2. 입력받은 적용기간의 종료일자+1 ~ 조회한 적용기간의 종료일자까지 이전데이타 copy
					LOGGER.debug("2. 입력받은 적용기간의 종료일자+1 ~ 조회한 적용기간의 종료일자까지 이전데이타 copy START!!!!!");
					calInputAplClsDt.add(Calendar.DATE, 1); //입력받은 적용종료일자에 1일을 더한다.
					String newAplStDt = new java.text.SimpleDateFormat("yyyyMMdd").format(calInputAplClsDt.getTime());
					insertCnt = 0;
					
					inputDataSet.put("NEW_APL_ST_DT", newAplStDt);
					insertCnt = dao.insert("com.korail.yz.ys.ba.YSBA001QMDAO.insertUsrCtlExpnDmdAddCopy", inputDataSet);
				
					if(insertCnt < 1)
					{
						throw new CosmosRuntimeException("WZZ000012", null);  //등록 작업이 실패하였습니다 - 입력값을 확인하십시오.
					}
					else
					{
						LOGGER.debug("2. 분할 기간 ["+newAplStDt+"~"+aplClsDt+"] 로 ["+insertCnt+"] 건 복사등록되었습니다!!!");
					}
					calInputAplClsDt.add(Calendar.DATE, -1); //입력받은 적용종료일자에 1일을 다시 빼준다.
					//3. 입력받은 적용기간에 입력한 기본값 insert
					LOGGER.debug("3. 입력받은 적용기간에 입력한 기본값 insert START!!!!!");
					insertCnt = 0;
					for (int i = 0; i < inputList.size(); i++)
					{
						Map<String, String> item = inputList.get(i);
						item.putAll(inputDataSet);
						insertCnt += dao.insert("com.korail.yz.ys.ba.YSBA001QMDAO.insertUsrCtlExpnDmdNum", item);
					}
					if(insertCnt < 1)
					{
						throw new CosmosRuntimeException("WZZ000012", null);  //등록 작업이 실패하였습니다 - 입력값을 확인하십시오.
					}
					else
					{
						LOGGER.debug("3. 입력받은 적용기간 ["+inputAplStDt+"~"+inputAplClsDt+"] 로 ["+insertCnt+"] 건 추가등록되었습니다!!!");
						inputDataSet.put("INSERT_FLAG", "Y");
						inputDataSet.remove("APL_ST_DT");
						inputDataSet.put("APL_ST_DT", String.valueOf(inputAplStDt));
						inputDataSet.put("TRN_NO", inputDataSet.get("TRN_NO"));
						resultList.add(inputDataSet);
					}	
				} //END else if (aplClsDt > inputAplClsDt) 
			}//END if (aplStDt == inputAplStDt )
			else if (aplStDt < inputAplStDt)  //조회해온 적용시작일자가 입력받은적용시작일자보다 작은경우
			{
				LOGGER.debug("조회해온 적용시작일자가 입력받은적용시작일자보다 작으면서::::::::::::::::::::::::");
				if (aplClsDt == inputAplClsDt) //조회해온 적용종료일자와 입력받은 적용종료일자가 같은경우 
				{
					LOGGER.debug("조회해온 적용종료일자와 입력받은 적용종료일자가 같은경우에 대한 처리 START!!!!!");
					// 1. 조회한 적용기간의 종료일자를 입력받은 적용기간의 시작일자(INPUT_APL_ST_DT)-1로 update
					LOGGER.debug("1. 조회한 적용기간의 종료일자를 입력받은 적용기간의 시작일자(INPUT_APL_ST_DT)-1로 update!!!!!!!!!!!!!!");
					calInputAplStDt.add(Calendar.DATE, -1); //입력받은 적용시작일자에 1일을 뺀다.
					//새로운 적용종료일자 생성(입력받은적용시작일자-1)
					String newAplClsDt = new java.text.SimpleDateFormat("yyyyMMdd").format(calInputAplStDt.getTime());
					updateCnt = 0;
					
					inputDataSet.put("NEW_APL_CLS_DT", newAplClsDt);
					updateCnt = dao.update("com.korail.yz.ys.ba.YSBA001QMDAO.updateAplClsDt2", inputDataSet);
					
					if(updateCnt < 1)
					{
						throw new CosmosRuntimeException("WZZ000012", null);  //등록 작업이 실패하였습니다 - 입력값을 확인하십시오.
					}
					else
					{
						LOGGER.debug("1. 기존데이터의 분할 기간이 ["+aplStDt+"~"+newAplClsDt+"] 로 ["+updateCnt+"] 건 수정되었습니다!!!");	
						calInputAplStDt.add(Calendar.DATE, 1); //(-1일을 했던)입력받은 적용시작일자에 1일을 다시 더한다.
					}
					// 2. 입력받은 적용기간에 이전데이타 copy
					LOGGER.debug(" 2. 입력받은 적용기간에 이전데이타 copy   START!!!!!!!!!!!!!");
					insertCnt = 0;
					
					inputDataSet.put("NEW_APL_CLS_DT", newAplClsDt);  //이전데이터의 기간이 APL_ST_DT ~ NEW_APL_CLS_DT로 업데이트되었으므로 이기간에서 데이터를 복사함.
					insertCnt += dao.insert("com.korail.yz.ys.ba.YSBA001QMDAO.insertUsrCtlExpnDmdAddCopy2", inputDataSet);
					if(insertCnt < 1)
					{
						throw new CosmosRuntimeException("WZZ000012", null);  //등록 작업이 실패하였습니다 - 입력값을 확인하십시오.
					}
					else
					{
						LOGGER.debug("입력받은 적용기간["+inputAplStDt+"~"+inputAplClsDt+"]에 기존데이터 ["+insertCnt+"] 건이 복사 등록되었습니다!!!");
					}
					
					// 3. 입력받은 적용기간에 입력한 기본값 추가 insert
					LOGGER.debug("3. 입력받은 적용기간에 입력한 기본값 추가insert  START!!!!!!!!!!!!!");
					insertCnt = 0;
					for (int i = 0; i < inputList.size(); i++)
					{
						Map<String, String> item = inputList.get(i);
						item.putAll(inputDataSet);
						insertCnt += dao.insert("com.korail.yz.ys.ba.YSBA001QMDAO.insertUsrCtlExpnDmdNum", item);
					}
					if(insertCnt < 1)
					{
						throw new CosmosRuntimeException("WZZ000012", null);  //등록 작업이 실패하였습니다 - 입력값을 확인하십시오.
					}
					else
					{
						LOGGER.debug("입력받은 적용기간["+inputAplStDt+"~"+inputAplClsDt+"]에 입력한기본값이 ["+insertCnt+"] 건이 추가등록되었습니다!!!");
						inputDataSet.put("INSERT_FLAG", "Y");
						inputDataSet.remove("APL_ST_DT");
						inputDataSet.put("APL_ST_DT", String.valueOf(inputAplStDt));
						inputDataSet.put("TRN_NO", inputDataSet.get("TRN_NO"));
						resultList.add(inputDataSet);
					}	
				} //END if (aplClsDt == inputAplClsDt) //조회해온 적용종료일자와 입력받은 적용종료일자가 같은경우 
				else if (aplClsDt > inputAplClsDt)
				{
					LOGGER.debug("조회한 적용종료일자가 입력받은 적용종료일자보다 큰경우에 대한 처리  START!!!!!!!!!!!!!");
					// 1. 조회한 적용기간의 종료일자를 입력받은 적용기간의 시작일자-1로 update
					LOGGER.debug("1. 조회한 적용기간의 종료일자를 입력받은 적용기간의 시작일자-1로 update  START!!!!!!!!!!!!!");
					
					calInputAplStDt.add(Calendar.DATE, -1); //입력받은 적용시작일자에 1일을 뺀다.
					//새로운 적용종료일자 생성(입력받은적용시작일자-1)
					String newAplClsDt = new java.text.SimpleDateFormat("yyyyMMdd").format(calInputAplStDt.getTime());
					updateCnt = 0;
					
					inputDataSet.put("NEW_APL_CLS_DT", newAplClsDt);
					updateCnt = dao.update("com.korail.yz.ys.ba.YSBA001QMDAO.updateAplClsDt2", inputDataSet);
					
					if(updateCnt < 1)
					{
						throw new CosmosRuntimeException("WZZ000012", null);  //등록 작업이 실패하였습니다 - 입력값을 확인하십시오.
					}
					else
					{
						LOGGER.debug("1. 기존데이터의 분할 기간이 ["+aplStDt+"~"+newAplClsDt+"] 로 ["+updateCnt+"] 건 수정되었습니다!!!");	
						calInputAplStDt.add(Calendar.DATE, 1); //(-1일을 했던)입력받은 적용시작일자에 1일을 다시 더한다.
					}
					
					// 2. 입력받은 적용기간에 이전데이타 copy
					LOGGER.debug("2. 입력받은 적용기간에 이전데이타 copy  START!!!!!!!!!!!!!");
					insertCnt = 0;
				
					inputDataSet.put("NEW_APL_CLS_DT", newAplClsDt);  //이전데이터의 기간이 APL_ST_DT ~ NEW_APL_CLS_DT로 업데이트되었으므로 이기간에서 데이터를 복사함.
					insertCnt = dao.insert("com.korail.yz.ys.ba.YSBA001QMDAO.insertUsrCtlExpnDmdAddCopy2", inputDataSet);
					if(insertCnt < 1)
					{
						throw new CosmosRuntimeException("WZZ000012", null);  //등록 작업이 실패하였습니다 - 입력값을 확인하십시오.
					}
					else
					{
						LOGGER.debug("입력받은 적용기간["+inputAplStDt+"~"+inputAplClsDt+"]에 기존데이터 ["+insertCnt+"] 건이 복사 등록되었습니다!!!");
					}
					
					// 3. 입력받은 적용기간의 종료일자+1 ~ 조회한 적용기간의 종료일자까지 이전데이타 copy
					LOGGER.debug("3. 입력받은 적용기간의 종료일자+1 ~ 조회한 적용기간의 종료일자까지 이전데이타 copy  START!!!!!!!!!!!!!");
					//새로운 적용 시작일자 생성(입력받은적용시작일자-1)
					calInputAplClsDt.add(Calendar.DATE, 1); //입력받은 적용종료일자에 1일을 더한다.
					String newAplStDt = new java.text.SimpleDateFormat("yyyyMMdd").format(calInputAplClsDt.getTime());
					insertCnt = 0;
					
					inputDataSet.put("NEW_APL_ST_DT", newAplStDt);  //새로운 적용시작일자~조회해온 적용시작일자로 이전데이터를 복사할것임.
					insertCnt = dao.insert("com.korail.yz.ys.ba.YSBA001QMDAO.insertUsrCtlExpnDmdAddCopy3", inputDataSet);
				
					if(insertCnt < 1)
					{
						throw new CosmosRuntimeException("WZZ000012", null);  //등록 작업이 실패하였습니다 - 입력값을 확인하십시오.
					}
					else
					{
						LOGGER.debug("3. 적용기간["+newAplStDt+"~"+aplClsDt+"]에 기존데이터 ["+insertCnt+"] 건이 복사 등록되었습니다!!!");
						calInputAplClsDt.add(Calendar.DATE, -1); //(더했던)입력받은 적용종료일자에 1일을 다시 뺀다.
					}
					
					
					
					// 4. 입력받은 적용기간에 입력한 기본값 insert
					LOGGER.debug("4. 입력받은 적용기간에 입력한 기본값 추가 insert  START!!!!!!!!!!!!!");
					
					insertCnt = 0;
					for (int i = 0; i < inputList.size(); i++)
					{
						Map<String, String> item = inputList.get(i);
						item.putAll(inputDataSet);
						insertCnt += dao.insert("com.korail.yz.ys.ba.YSBA001QMDAO.insertUsrCtlExpnDmdNum", item);
					}
					if(insertCnt < 1)
					{
						throw new CosmosRuntimeException("WZZ000012", null);  //등록 작업이 실패하였습니다 - 입력값을 확인하십시오.
					}
					else
					{
						LOGGER.debug("4. 입력받은 적용기간["+inputAplStDt+"~"+inputAplClsDt+"]에 입력한기본값이 ["+insertCnt+"] 건이 추가등록되었습니다!!!");
						inputDataSet.put("INSERT_FLAG", "Y");
						inputDataSet.remove("APL_ST_DT");
						inputDataSet.put("APL_ST_DT", String.valueOf(inputAplStDt));
						inputDataSet.put("TRN_NO", inputDataSet.get("TRN_NO"));
						resultList.add(inputDataSet);
					}	
				} // END else if (aplClsDt > inputAplClsDt) //조회해온 적용종료일자가 입력받은적용종료일자보다 큰경우
			} //END else if (aplStDt < inputAplStDt)  //조회해온 적용시작일자가 입력받은적용시작일자보다 작은경우
		} //END if ("ADD".equals(hstCreDv))  //분할생성(추가등록)
		else if("NEW".equals(hstCreDv)) //신규생성
		{
			LOGGER.debug("이력생성 구분 :: 신규생성(얘는 그냥 INSERT만 하면 끝.) ::");
			insertCnt = 0;
			for (int i = 0; i < inputList.size(); i++)
			{
				Map<String, String> item = inputList.get(i);
				item.putAll(inputDataSet);
				insertCnt += dao.insert("com.korail.yz.ys.ba.YSBA001QMDAO.insertUsrCtlExpnDmdNum", item);
			}
			if(insertCnt < 1)
			{
				throw new CosmosRuntimeException("WZZ000012", null);  //등록 작업이 실패하였습니다 - 입력값을 확인하십시오.
			}
			else
			{
				LOGGER.debug("신규 적용기간 ["+inputAplStDt+"~"+inputAplClsDt+"] 로 ["+insertCnt+"] 건 등록되었습니다!!!");
				XframeControllerUtils.setMessage("IZZ000013", result); //정상적으로 저장 되었습니다.
				inputDataSet.put("INSERT_FLAG", "Y");
				inputDataSet.remove("APL_ST_DT");
				inputDataSet.put("APL_ST_DT", String.valueOf(inputAplStDt));
				inputDataSet.put("TRN_NO", inputDataSet.get("TRN_NO"));
				resultList.add(inputDataSet);
			}
		} //END else if("NEW".equals(hstCreDv)) //신규생성
		/**===================================================================================================
		 * 이력생성 구분 별 데이터 등록 종료
		 * */
		LOGGER.debug("이력생성 구분 별 데이터 등록 종료!!!");
		result.put("dsCond", resultList);
		return result;
	}
}

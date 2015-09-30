/**
 * project : KORAIL_YZ
 * package : com.korail.yz.ys.ca
 * date : 2014. 6. 4.오후 4:46:51
 */
package com.korail.yz.ys.ec;

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
 * @author EQ
 * @date 2014. 5. 27. 오후 4:06:51
 * Class description : 수입시뮬레이션전월대비실적SVC
 * 임의 운행일자의 예측 승차인원에 대한 예상 수입을 시뮬레이션을 위한 Service 클래스
 */
@Service("com.korail.yz.ys.ec.YSEC001SVC")
public class YSEC001SVC {
	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public  static final Logger  LOGGER = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
	
	/**
	 * 수입시뮬레이션 전월대비실적 조회
	 * @author 김응규
	 * @date 2014. 6. 4. 오후 4:43:00
	 * Method description : 수입시뮬레이션 전월대비실적 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map<String, ?> selectListRvnSimlBfmmVsAcvm(Map<String, ?> param) {		

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
		List<String> runDtArrayList = new ArrayList<String>();
		
		if("1".equals(inputDataSet.get("WK_BF_1"))) //1주전 체크시
		{
			ArrayList<Map<String, Object>> runDtList = (ArrayList) dao.list("com.korail.yz.ys.ec.YSEC001QMDAO.selectRunDt1WkBf", inputDataSet);
			runDtArrayList.add(String.valueOf(runDtList.get(0).get("RUN_DT")));
			LOGGER.debug("1주전 RUN_DT:::::"+runDtList.get(0).get("RUN_DT") );
		}
		if("1".equals(inputDataSet.get("WK_BF_2"))) //2주전 체크시
		{
			ArrayList<Map<String, Object>> runDtList = (ArrayList) dao.list("com.korail.yz.ys.ec.YSEC001QMDAO.selectRunDt2WkBf", inputDataSet);
			runDtArrayList.add(String.valueOf(runDtList.get(0).get("RUN_DT"))); 
			LOGGER.debug("2주전 RUN_DT:::::"+runDtList.get(0).get("RUN_DT"));
		}
		if("1".equals(inputDataSet.get("WK_BF_3"))) //3주전 체크시
		{
			ArrayList<Map<String, Object>> runDtList = (ArrayList) dao.list("com.korail.yz.ys.ec.YSEC001QMDAO.selectRunDt3WkBf", inputDataSet);
			runDtArrayList.add(String.valueOf(runDtList.get(0).get("RUN_DT"))); 
			LOGGER.debug("3주전 RUN_DT:::::"+runDtList.get(0).get("RUN_DT"));
		}
		if("1".equals(inputDataSet.get("WK_BF_4"))) //4주전 체크시
		{
			ArrayList<Map<String, Object>> runDtList = (ArrayList) dao.list("com.korail.yz.ys.ec.YSEC001QMDAO.selectRunDt4WkBf", inputDataSet);
			runDtArrayList.add(String.valueOf(runDtList.get(0).get("RUN_DT"))); 
			LOGGER.debug("4주전 RUN_DT:::::"+runDtList.get(0).get("RUN_DT"));
		}
		if("1".equals(inputDataSet.get("RUN_DT_ACVM"))) // 체크시
		{
			runDtArrayList.add(inputDataSet.get("RUN_DT")); 
			LOGGER.debug("운행일자실적 현재RUN_DT:::::"+inputDataSet.get("RUN_DT"));
		}
		int dayCnt = runDtArrayList.size();
		String concatRunDt = "";
		for (int i = 0; i < dayCnt; i++)
		{
			if(i == 0)
			{
				concatRunDt = "'".concat(runDtArrayList.get(i)).concat("'");
				//concatRunDt = "'"+runDtArrayList.get(i)+"'";
			}
			else
			{
				concatRunDt = concatRunDt.concat( ",'").concat(runDtArrayList.get(i)).concat("'");
				//concatRunDt += ",'"+runDtArrayList.get(i)+"'";
			}
			
		}
		LOGGER.debug("concatRunDt:::::"+concatRunDt );
	
		inputDataSet.put("RUN_DT_ARR", concatRunDt);
		inputDataSet.put("DAY_CNT",  String.valueOf(dayCnt));
		//수입시뮬레이션 전월대비실적 조회
		ArrayList<Map<String, Object>> resultList = new ArrayList<Map<String,Object>>();
		if(inputDataSet.get("TRN_NO").isEmpty())  /* 전체조회 (열차번호 미입력 조회)*/
		{
			 resultList = (ArrayList) dao.list("com.korail.yz.ys.ec.YSEC001QMDAO.selectListRvnSimlBfmmVsAcvmWhl", inputDataSet);
		}
		else  /* 열차번호별 조회 */
		{
			resultList = (ArrayList) dao.list("com.korail.yz.ys.ec.YSEC001QMDAO.selectListRvnSimlBfmmVsAcvmTrn", inputDataSet);
		}
		
		
		//메시지 처리
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
}

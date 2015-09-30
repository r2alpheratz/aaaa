/**
 * project : KORAIL_YZ
 * package : com.korail.yz.ys.ca
 * date : 2014. 6. 12.오후 1:35:51
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
 * @date 2014. 6. 12. 오후 1:35:51
 * Class description : 수입시뮬레이션전월대비실적요일별SVC
 * 수입 시뮬레이션 전월 대비 실적에 대해 요일별로 조회 할 수 있는 Service 클래스
 */
@Service("com.korail.yz.ys.ec.YSEC002SVC")
public class YSEC002SVC {
	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public  static final Logger  LOGGER = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
	
	/**
	 * 수입시뮬레이션 전월대비실적 요일별 조회
	 * @author 김응규
	 * @date 2014. 6. 12. 오후 1:36:00
	 * Method description : 수입시뮬레이션 전월대비실적 요일별 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map<String, ?> selectListRvnSimlBfmmVsAcvmDay(Map<String, ?> param) {		

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
			ArrayList<Map<String, Object>> runDtList1 = (ArrayList) dao.list("com.korail.yz.ys.ec.YSEC002QMDAO.selectRunDt1WkBf", inputDataSet);
			for (Map<String, Object> runDtMap1 : runDtList1)
			{
				runDtArrayList.add(String.valueOf(runDtMap1.get("RUN_DT")));
				LOGGER.debug("1주전 RUN_DT:::::"+runDtMap1.get("RUN_DT"));
			}
		}
		if("1".equals(inputDataSet.get("WK_BF_2"))) //2주전 체크시
		{
			ArrayList<Map<String, Object>> runDtList2 = (ArrayList) dao.list("com.korail.yz.ys.ec.YSEC002QMDAO.selectRunDt2WkBf", inputDataSet);
			for (Map<String, Object> runDtMap2 : runDtList2)
			{
				runDtArrayList.add(String.valueOf(runDtMap2.get("RUN_DT")));
				LOGGER.debug("2주전 RUN_DT:::::"+runDtMap2.get("RUN_DT"));
			}
		}
		if("1".equals(inputDataSet.get("WK_BF_3"))) //3주전 체크시
		{
			ArrayList<Map<String, Object>> runDtList3 = (ArrayList) dao.list("com.korail.yz.ys.ec.YSEC002QMDAO.selectRunDt3WkBf", inputDataSet);
			for (Map<String, Object> runDtMap3 : runDtList3)
			{
				runDtArrayList.add(String.valueOf(runDtMap3.get("RUN_DT")));
				LOGGER.debug("3주전 RUN_DT:::::"+runDtMap3.get("RUN_DT"));
			}
		}
		if("1".equals(inputDataSet.get("WK_BF_4"))) //4주전 체크시
		{
			ArrayList<Map<String, Object>> runDtList4 = (ArrayList) dao.list("com.korail.yz.ys.ec.YSEC002QMDAO.selectRunDt4WkBf", inputDataSet);
			for (Map<String, Object> runDtMap4 : runDtList4)
			{
				runDtArrayList.add(String.valueOf(runDtMap4.get("RUN_DT")));
				LOGGER.debug("4주전 RUN_DT:::::"+runDtMap4.get("RUN_DT"));
			}
		}
		if("1".equals(inputDataSet.get("RUN_DT_ACVM"))) // 운행일자실적 체크시
		{
			ArrayList<Map<String, Object>> runDtList5 = (ArrayList) dao.list("com.korail.yz.ys.ec.YSEC002QMDAO.selectRunDtAcvm", inputDataSet);
			for (Map<String, Object> runDtMap5 : runDtList5)
			{
				runDtArrayList.add(String.valueOf(runDtMap5.get("RUN_DT")));
				LOGGER.debug("운행일자실적 RUN_DT:::::"+runDtMap5.get("RUN_DT"));
			}
			
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
				concatRunDt = concatRunDt.concat(",'").concat(runDtArrayList.get(i)).concat("'");
				//concatRunDt += ",'"+runDtArrayList.get(i)+"'";
			}
			
		}
		LOGGER.debug("concatRunDt:::::"+concatRunDt );
	
		inputDataSet.put("RUN_DT_ARR", concatRunDt);
		inputDataSet.put("DAY_CNT",  String.valueOf(dayCnt));
		//수입시뮬레이션 전월대비실적요일별 조회
		ArrayList<Map<String, Object>> resultList = (ArrayList) dao.list("com.korail.yz.ys.ec.YSEC002QMDAO.selectListRvnSimlBfmmVsAcvmDay", inputDataSet);
		
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

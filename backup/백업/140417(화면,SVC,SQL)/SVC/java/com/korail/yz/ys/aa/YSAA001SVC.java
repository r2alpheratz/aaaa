/**
 * project : KORAIL_YZ
 * package : com.korail.yz.ys.aa
 * date : 2014. 4. 5.오후 3:02:30
 */
package com.korail.yz.ys.aa;

import java.util.*;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Service;

import com.korail.tz.sa.ISA0001SVC;
import com.korail.tz.sa.XframeControllerUtils;

import cosmos.comm.dao.CommDAO;

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
	
	public  final Logger logger = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
	
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

		logger.debug("param ==> "+param);
		// search input column dataset
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCondJobDt");	
		logger.debug("inputDataSet ==>  " + inputDataSet);

		// search input column data
		logger.debug("inputData ==>  " + inputDataSet.toString());
		
		ArrayList<Map<String, Object>> resultList = (ArrayList) dao.list("com.korail.yz.ys.aa.YSAA001QMDAO.selectListYmgtTgtTrnJobDt", inputDataSet);

		
		for(int i=0;i<resultList.size();i++)
		{
			logger.debug(resultList.get(i).toString());
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

		logger.debug("param ==> "+param);
		// search input column dataset
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCondRunDt");	
		logger.debug("inputDataSet ==>  " + inputDataSet);

		// search input column data
		logger.debug("inputData ==>  " + inputDataSet.toString());
		
		ArrayList<Map<String, Object>> resultList = (ArrayList) dao.list("com.korail.yz.ys.aa.YSAA001QMDAO.selectListYmgtTgtTrnRunDt", inputDataSet);

		
		for(int i=0;i<resultList.size();i++)
		{
			logger.debug(resultList.get(i).toString());
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

		logger.debug("param ==> "+param);
		// search input column dataset
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");	
		logger.debug("inputDataSet ==>  " + inputDataSet);

		// search input column data
		logger.debug("inputData ==>  " + inputDataSet.toString());
		
		ArrayList<Map<String, Object>> resultList = (ArrayList) dao.list("com.korail.yz.ys.aa.YSAA001QMDAO.selectListDtlPrsCnqe", inputDataSet);

		
		for(int i=0;i<resultList.size();i++)
		{
			logger.debug(resultList.get(i).toString());
		}
		
		result.put("dsList", resultList);

		return result;

	}
}
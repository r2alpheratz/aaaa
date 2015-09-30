/**
 * project : KORAIL_YZ
 * package : com.korail.yz.ys.ca
 * date : 2014. 5. 19.오전 9:06:51
 */
package com.korail.yz.ys.ca;

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
 * @author EQ
 * @date 2014. 5. 19. 오전 9:06:51
 * Class description : 초과예약작업처리결과조회SVC
 * 초과예약 작업처리 결과조회를 위한 Service 클래스
 */
@Service("com.korail.yz.ys.ca.YSCA002SVC")
public class YSCA002SVC {
	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public  static final Logger  LOGGER = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
	
	/**
	 * 초과예약작업처리결과조회
	 * @author 김응규
	 * @date 2014. 4. 6. 오전 11:53:00
	 * Method description : 열차별 초과예약작업처리결과를 조회한다.
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map<String, ?> selectListExcsRsvJobPrsCnqe(Map<String, ?> param) {		

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
		
		ArrayList<Map<String, Object>> resultList = (ArrayList) dao.list("com.korail.yz.ys.ca.YSCA002QMDAO.selectListExcsRsvJobPrsCnqe", inputDataSet);
		
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
}

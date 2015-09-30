/**
 * project : KORAIL_YZ
 * package : com.korail.yz.yp.ca
 * date : 2014. 7. 11.오후 5:55:51
 */
package com.korail.yz.yp.ca;

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
 * @date 2014. 7. 29. 오후 5:10:51
 * Class description : 할인통제상세정보SVC
 * 열차/객실등급별로 할인등급과 예상 수입증가분을 상세조회 하기위한 Service 클래스
 */
@Service("com.korail.yz.yp.ca.YPCA002SVC")
public class YPCA002SVC {
	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public  static final Logger  LOGGER = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
	
	
	/**
	 * 할인통제관리 상세정보 조회
	 * @author 김응규
	 * @date 2014. 7. 28. 오전 11:19:00
	 * Method description : 할인통제관리 상세정보를 조회한다.
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map<String, ?> selectListDcntRgulDtlInfo(Map<String, ?> param) {		

		Map<String, Object> result = new HashMap<String, Object>();

		LOGGER.debug("param ==> "+param);
		// search input column dataset
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");
		//열차운영사업자구분코드 추가
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		inputDataSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		LOGGER.debug("inputDataSet ==>  " + inputDataSet);
		
		//고객승급관리 조회
		ArrayList<Map<String, Object>> resultList = (ArrayList) dao.list("com.korail.yz.yp.ca.YPCA002QMDAO.selectListDcntRgulDtlInfo", inputDataSet);

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

/**
 * project : KORAIL_YZ
 * package : com.korail.yz.ys.ec
 * date : 2014. 6. 15.오후 1:35:51
 */
package com.korail.yz.ys.ec;

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
 * @date 2014. 6. 15. 오후 1:35:51
 * Class description : 수입시뮬레이션전년도대비실적SVC
 * 수입 시뮬레이션 전년 대비 실적에 대해 조회 할 수 있는 Service 클래스
 */
@Service("com.korail.yz.ys.ec.YSEC003SVC")
public class YSEC003SVC {
	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public  static final Logger  LOGGER = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
	
	/**
	 * 수입시뮬레이션 전년도대비실적 기준/비교기간 조회
	 * @author 김응규
	 * @date 2014. 6. 12. 오후 1:36:00
	 * Method description : 수입시뮬레이션 전년도대비실적 기준/비교기간 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map<String, ?> selectListRvnSimlLsyrVsAcvmStdrCompTrm(Map<String, ?> param) {		

		Map<String, Object> result = new HashMap<String, Object>();

		LOGGER.debug("param ==> "+param);
		// search input column dataset
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");
		//열차운영사업자구분코드 추가
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		inputDataSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		LOGGER.debug("inputDataSet ==>  " + inputDataSet);
		
		//수입시뮬레이션 전월대비실적요일별 조회
		ArrayList<Map<String, Object>> resultList = (ArrayList) dao.list("com.korail.yz.ys.ec.YSEC003QMDAO.selectListRvnSimlLsyrVsAcvmStdrCompTrm", inputDataSet);
		
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
	
	/**
	 * 수입시뮬레이션 전년도대비실적 대상/예측 기간 조회(시뮬레이션실행)
	 * @author 김응규
	 * @date 2014. 6. 12. 오후 1:36:00
	 * Method description : 수입시뮬레이션 전년도대비실적 대상/예측기간 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map<String, ?> selectListRvnSimlLsyrVsAcvmTgtFcstTrm(Map<String, ?> param) {		

		Map<String, Object> result = new HashMap<String, Object>();

		LOGGER.debug("param ==> "+param);
		// search input column dataset
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");	
		LOGGER.debug("inputDataSet ==>  " + inputDataSet);
		
		//수입시뮬레이션 전월대비실적요일별 조회
		ArrayList<Map<String, Object>> resultList = (ArrayList) dao.list("com.korail.yz.ys.ec.YSEC003QMDAO.selectListRvnSimlLsyrVsAcvmTgtFcstTrm", inputDataSet);
		
		//메시지 처리
		if(resultList.isEmpty())
		{
			XframeControllerUtils.setMessage("IZZ000004", result); //해당 조건의 자료가 존재하지 않습니다.
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result); //정상적으로 조회 되었습니다.
		}
		
		result.put("dsList2", resultList);

		return result;

	}
}

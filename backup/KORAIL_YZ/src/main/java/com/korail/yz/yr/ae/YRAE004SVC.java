/**
 * project : KORAIL_YZ
 * package : com.korail.yz.yb.co
 * date : 2014. 3. 11.오후 3:32:36
 */
package com.korail.yz.yr.ae;

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
 * @author "Changki.woo"
 * @date 2014. 6. 23. 오후 2:04:28
 * Class description : 운행일별 예약/취소/미승차 운송종료후 취소 실적조회 -YRAE003_S01
 */
@Service("com.korail.yz.yr.ae.YRAE004SVC")
public class YRAE004SVC {

	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public  final Logger logger = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
	
	/**
	 * @author "Changki.woo"
	 * @date 2014. 6. 23. 오후 2:04:28
	 * Method description : 수송계획번호 변경차수정보 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ? > selectListTransPlnChgDeg(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> getParamSet  = XframeControllerUtils.getParamDataSet(param, "dsCond");
		
		List<Map<String, Object>> resultList = null;
		
		String svcUrl = "com.korail.yz.yr.ae.YRAE004QMDAO.selectListTransPlnChgDegQry";
		
		resultList = (List<Map<String, Object>>) dao.list(svcUrl, getParamSet);
		
		result.put("dsPlnChgDegList", resultList);
		
		if(resultList.isEmpty())
		{
			XframeControllerUtils.setMessage("IZZ000004", result); //해당 조건의 자료가 존재하지 않습니다.
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result);
		}
		
		return result;
	}
	
	/**
	 * @author "Changki.woo"
	 * @date 2014. 6. 23. 오후 2:04:28
	 * Method description : 운행일별 예약/취소/미승차 실적조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ? > selectListRunDtPrResvCncNotyAbrdAcvm(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> getParamSet  = XframeControllerUtils.getParamDataSet(param, "dsCond");
		
		List<Map<String, Object>> resultList = null;
		
		String svcUrl = "com.korail.yz.yr.ae.YRAE004QMDAO.selectListRunDtPrResvCncNotyAbrdAcvmQry";
		
		resultList = (List<Map<String, Object>>) dao.list(svcUrl, getParamSet);
		
		result.put("dsList", resultList);
		
		if(resultList.isEmpty())
		{
			XframeControllerUtils.setMessage("IZZ000004", result); //해당 조건의 자료가 존재하지 않습니다.
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result);
		}
		
		return result;
		
	}
	
	/**
	 * @author "Changki.woo"
	 * @date 2014. 6. 23. 오후 2:04:28
	 * Method description : 운행일별 예약/취소/미승차 실적조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ? > selectListRunDtPrResvCncNotyAbrdAcvmPsrmBkcl(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> getParamSet  = XframeControllerUtils.getParamDataSet(param, "dsCond");
		
		List<Map<String, Object>> resultList = null;
		
		String svcUrl = "com.korail.yz.yr.ae.YRAE004QMDAO.selectListRunDtPrResvCncNotyAbrdAcvmPsrmBkclQry";
		
		resultList = (List<Map<String, Object>>) dao.list(svcUrl, getParamSet);
		
		result.put("dsListPsrmBkcl", resultList);
		
		if(resultList.isEmpty())
		{
			XframeControllerUtils.setMessage("IZZ000004", result); //해당 조건의 자료가 존재하지 않습니다.
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result);
		}
		
		return result;
		
	}	
	
	/**
	 * @author "Changki.woo"
	 * @date 2014. 6. 24. 오후 4:51:56
	 * Method description : 차트용 운행구간 목록 조회 
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ? > selectListRunInfoCht(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> getParamSet  = XframeControllerUtils.getParamDataSet(param, "dsCond");
		
		List<Map<String, Object>> resultList = null;
		
		String svcUrl = "com.korail.yz.yr.ae.YRAE004QMDAO.selectListRunInfoChtQry";
		
		
		resultList = (List<Map<String, Object>>) dao.list(svcUrl, getParamSet);
		
		result.put("dsRunInfo", resultList);
		
		return result;
		
	}
	
	/**
	 * @author "Changki.woo"
	 * @date 2014. 6. 24. 오후 2:04:28
	 * Method description : 운행일별 예약/취소/미승차(객실,할인등급포함) 실적 차트조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ? > selectListRunDtPrResvCncNotyAbrdAcvmPsrmBkclCht(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> getParamSet  = XframeControllerUtils.getParamDataSet(param, "dsCond");
		
		List<Map<String, Object>> resultList = null;
		
		String svcUrl = "com.korail.yz.yr.ae.YRAE004QMDAO.selectListRunDtPrResvCncNotyAbrdAcvmPsrmBkclQry";
		
		resultList = (List<Map<String, Object>>) dao.list(svcUrl, getParamSet);
		
		result.put("dsList", resultList);
		
		if(resultList.isEmpty())
		{
			XframeControllerUtils.setMessage("IZZ000004", result); //해당 조건의 자료가 존재하지 않습니다.
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result);
		}
		
		return result;
		
	}	
	
}
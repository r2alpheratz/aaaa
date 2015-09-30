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
 * @date 2014. 6. 12. 오전 11:03:46
 * Class description : 예매일별 예약/취소/미승차 실적 - YRAE002_S01
 */
@Service("com.korail.yz.yr.ae.YRAE002SVC")
public class YRAE002SVC {

	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public  final Logger logger = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
	
	/**
	 * @author "Changki.woo"
	 * @date 2014. 6. 12. 오전 11:03:46
	 * Method description : 예매일별 예약/취소/미승차 실적조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ? > selectListResvDtPrResvCncAcvm(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> getParamSet  = XframeControllerUtils.getParamDataSet(param, "dsCond2");
		
		List<Map<String, Object>> resultList = null;
		
		String svcUrl = "com.korail.yz.yr.ae.YRAE002QMDAO.selectListResvDtPrResvCncAcvmQry";
		
		resultList = (List<Map<String, Object>>) dao.list(svcUrl, getParamSet);
		
		result.put("dsList2", resultList);
		//result.put("dsCht", resultList);		
		
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
	 * @date 2014. 6. 12. 오전 11:03:46
	 * Method description : 예매일별 예약/취소/미승차(객실등급,할인등급포함) 실적조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ? > selectListResvDtPrResvCncAcvmPsrmBkcl(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> getParamSet  = XframeControllerUtils.getParamDataSet(param, "dsCond2");
		
		List<Map<String, Object>> resultList = null;
		
		String svcUrl = "com.korail.yz.yr.ae.YRAE002QMDAO.selectListResvDtPrResvCncAcvmPsrmBkclQry";
		
		resultList = (List<Map<String, Object>>) dao.list(svcUrl, getParamSet);
		
		result.put("dsListPsrmBkcl2", resultList);
		result.put("dsChtPsrm", resultList);
		
		
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
	 * @date 2014. 6. 12. 오전 11:03:46
	 * Method description : 예매일별 예약/취소/미승차 열차별 실적조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ? > selectListResvDtPrResvCncAcvmTrnPr(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> getParamSet  = XframeControllerUtils.getParamDataSet(param, "dsCond");
		
		List<Map<String, Object>> resultList = null;
		
		String svcUrl = "com.korail.yz.yr.ae.YRAE002QMDAO.selectListResvDtPrResvCncAcvmTrnPrQry";
		
		resultList = (List<Map<String, Object>>) dao.list(svcUrl, getParamSet);
		
		result.put("dsList", resultList);
		result.put("dsCht", resultList);
		
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
	 * @date 2014. 6. 13. 오후 4:51:56
	 * Method description : 
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ? > selectListRunInfoCht(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> getParamSet  = XframeControllerUtils.getParamDataSet(param, "dsCond");
		
		List<Map<String, Object>> resultList = null;
		
		String svcUrl = "com.korail.yz.yr.ae.YRAE002QMDAO.selectListRunInfoChtQry";
		
		
		resultList = (List<Map<String, Object>>) dao.list(svcUrl, getParamSet);
		
		result.put("dsRunInfo", resultList);
	
		return result;
		
	}
	
	/**
	 * @author "Changki.woo"
	 * @date 2014. 6. 12. 오전 11:03:46
	 * Method description : 예매일별 예약/취소/미승차(객실등급,할인등급포함) 실적조회 차트용
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ? > selectListResvDtPrResvCncAcvmPsrmBkclCht(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> getParamSet  = XframeControllerUtils.getParamDataSet(param, "dsCond");
		
		List<Map<String, Object>> resultList = null;
		
		String svcUrl = "com.korail.yz.yr.ae.YRAE002QMDAO.selectListResvDtPrResvCncAcvmPsrmBkclQry";
		
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
	 * @date 2014. 6. 19. 오후 2:34:36
	 * Method description : 예매일별 예약/취소/미승차 열차별 실적 차트 열차목록조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ? > selectListTrnNoInfoCht(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> getParamSet  = XframeControllerUtils.getParamDataSet(param, "dsCond");
		
		List<Map<String, Object>> resultList = null;
		
		String svcUrl = "com.korail.yz.yr.ae.YRAE002QMDAO.selectListTrnNoInfoChtQry";
		
		resultList = (List<Map<String, Object>>) dao.list(svcUrl, getParamSet);
		
		result.put("dsTrnNoInfo", resultList);
		
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
/**
 * project : KORAIL_YZ
 * package : com.korail.yz.yb.dc
 * date : 2014. 4. 4.오전 11:25:19
 */
package com.korail.yz.yb.dc;

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
 * @author 한현섭
 * @date 2014. 4. 4. 오전 11:25:19
 * Class description : 
 */
@Service("com.korail.yz.yb.dc.YBDC003SVC")
public class YBDC003SVC {

	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public  final Logger logger = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
	
	/**
	 * @author 한현섭
	 * @date 2014. 4. 4. 오전 11:29:09
	 * Method description : 주운행선별 노선정보를 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListRoutInfo(Map<String, ?> param){
		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();

		
		/* 입력 오브젝트 */
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsRoutCond");
		
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		if("".equals(trnOprBzDvCd) || trnOprBzDvCd == null){
			trnOprBzDvCd = "000";
		}
		inputDataSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		
		ArrayList<Map<String, Object>> resultList 
		= (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.yb.dc.YBDC003QMDAO.selectListRoutInfo", inputDataSet);

		//error 메시지 날리기
		if(resultList.isEmpty()){
			XframeControllerUtils.setMessage("IZZ000004", result);
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result);
		}
		result.put("dsGrdRoutInfo", resultList);
		return result;
	}
	
	
	/**
	 * @author 한현섭
	 * @date 2014. 4. 4. 오전 11:29:11
	 * Method description : 선택한 노선코드에 대한 주행선 정보 조회를 처리
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListCvrLnInfo(Map<String, ?> param){
		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();

		
		/* 입력 오브젝트 */
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCrvCond");

		
		ArrayList<Map<String, Object>> resultList
		= (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.yb.dc.YBDC003QMDAO.selectListCvrLnInfo", inputDataSet);

		//error 메시지 날리기
		if(resultList.isEmpty())
		{
			XframeControllerUtils.setMessage("IZZ000004", result);
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result);
		}
		
		result.put("dsGrdRoutInfo", resultList);
		result.put("dsGrdCvrInfo", resultList);
		return result;
	}
	
	
	/**
	 * @author 한현섭
	 * @date 2014. 4. 4. 오전 11:29:14
	 * Method description : 노선별 노선 구성역 상세 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectRoutConsStn(Map<String, ?> param){
		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		
		/* 입력 오브젝트 */
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsConsCond");
	
		ArrayList<Map<String, Object>> resultList
		= (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.yb.dc.YBDC003QMDAO.selectRoutConsStn", inputDataSet);
		

		ArrayList<Map<String, Object>> stDtList
		= (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.yb.dc.YBDC003QMDAO.selectRoutStDt", inputDataSet);
		
		//error 메시지 날리기
		if(resultList.isEmpty()){
			XframeControllerUtils.setMessage("IZZ000004", result);
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result);
		}
		
		
		result.put("dsGrdConsList", resultList);
		result.put("dsCboStDtList", stDtList);
		
		return result;
	}
	
	 
	 
}

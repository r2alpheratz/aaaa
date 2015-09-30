/**
 * project : KORAIL_YZ
 * package : com.korail.yz.yp.da
 * date : 2014. 8. 9.오후 5:17:20
 */
package com.korail.yz.yp.da;

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
 * @author 나윤채
 * @date 2014. 8. 9. 오후 5:17:20
 * Class description : 구간별 최저가 산출 목록 조회
 */

@Service("com.korail.yz.yp.da.YPDA001SVC")
public class YPDA001SVC {
	
	@Resource(name="commDAO")
	private transient CommDAO dao;

	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public static final Logger LOGGER = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);

	/**
	 * @author 나윤채
	 * @date 2015. 1. 31. 오후 4:57:37
	 * Method description : 구간별 최저가 산출목록 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListODLwstPrce(Map<String, ?>param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> condMap = XframeControllerUtils.getParamDataSet(param, "dsCond");
		
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		if("".equals(trnOprBzDvCd) || trnOprBzDvCd == null){
			trnOprBzDvCd = "000";
		}
		condMap.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		
		ArrayList<Map<String, Object>> resultList = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.yp.da.YPDA001QMDAO.selectListODLwstPrce", condMap);
		result.put("dsListODLwstPrce", resultList);
		
		result = sendMessage(resultList, result);//메시지 처리		
		return result;
	}
	
	/*	메시지 처리 메서드*/
	private Map<String, Object> sendMessage(ArrayList<Map<String, Object>> resultList, Map<String, Object> result)
	{
		if(resultList.isEmpty()){
			XframeControllerUtils.setMessage("IZZ000004", result); //해당 조건의 자료가 존재하지 않습니다.
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result); //정상적으로 조회 되었습니다.
		}
		
		return result;
	}
}

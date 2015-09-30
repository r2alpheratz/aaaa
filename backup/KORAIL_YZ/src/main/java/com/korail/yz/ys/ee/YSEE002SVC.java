/**
 * project : KORAIL_YZ
 * package : com.korail.yz.ys.ee
 * date : 2014. 7. 4.오후 6:12:52
 */
package com.korail.yz.ys.ee;

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
 * @date 2014. 7. 4. 오후 6:12:52
 * Class description : 특정할인 실적 일자별 조회
 */

@Service("com.korail.yz.ys.ee.YSEE002SVC")
public class YSEE002SVC {
	
	@Resource(name="commDAO")
	private transient CommDAO dao;

	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public static final Logger LOGGER = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
	
	/*	특정할인 실적 일자별 조회	*/
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListSpRctDay(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> condMap = XframeControllerUtils.getParamDataSet(param, "dsPssrCond1");
		//열차운영사업자구분코드 추가
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		condMap.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		ArrayList<Map<String, Object>> resultList1 = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.ys.ee.YSEE002QMDAO.selectListSpRctDay",condMap);
		
		result.put("dsGrdTrnPssr", resultList1);
		result = sendMessage(resultList1, resultList1, result, 0);		//메시지 처리
		
		return result;
	}

	/*	열차번호 조회	*/
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListBsTrnNo(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> condMap = XframeControllerUtils.getParamDataSet(param, "dsPssrCond1");
		//열차운영사업자구분코드 추가
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		condMap.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		ArrayList<Map<String, Object>> resultList1 = (ArrayList<Map<String,Object>>)dao.list("com.korail.yz.ys.ee.YSEE002QMDAO.selectListBsTrnNo",condMap);
		
		result.put("dsTrnNoList", resultList1);
		result = sendMessage(resultList1, resultList1, result, 0);		//메시지 처리
		
		return result;
	}
	
	/*	메시지 처리 메서드*/
	private Map<String, Object> sendMessage(ArrayList<Map<String, Object>> resultList,ArrayList<Map<String, Object>> resultList2, Map<String, Object> result, int num)
	{
		if (num == 0)
		{
			if(resultList.isEmpty()){
				XframeControllerUtils.setMessage("IZZ000004", result); //해당 조건의 자료가 존재하지 않습니다.
			}
			else
			{
				XframeControllerUtils.setMessage("IZZ000009", result); //정상적으로 조회 되었습니다.
			}
		} else if (num == 1)
		{
			if(resultList.isEmpty() && resultList2.isEmpty()){
				XframeControllerUtils.setMessage("IZZ000004", result); //해당 조건의 자료가 존재하지 않습니다.
			}
			else
			{
				XframeControllerUtils.setMessage("IZZ000009", result); //정상적으로 조회 되었습니다.
			}	
		}
		return result;
	}
}

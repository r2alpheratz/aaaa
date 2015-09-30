/**
 * project : KORAIL_YZ
 * package : com.korail.yz.yb.co
 * date : 2014. 3. 28.오후 1:55:36
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
 * @author "한현섭"
 * @date 2014. 3. 28. 오후 1:55:36
 * Class description : 
 */
@Service("com.korail.yz.yb.dc.YBDC001SVC")
public class YBDC001SVC {
	
	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public  final Logger logger = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);

	/**
	 * @author 한현섭
	 * @date 2014. 3. 28. 오후 1:56:03
	 * Method description : 예약발매역정보를 조회한다.
	 * @param param
	 * @return Map
	 */	

	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListRsvSaleInfo(Map<String, ?> param)
	{
		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();

		/* 입력 오브젝트 */
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCondition");
		String stnNm = inputDataSet.get("KOR_STN_NM");
		inputDataSet.put("KOR_STN_NM", stnNm.trim());

		/* 메인 SQL */ 
		ArrayList<Map<String, Object>> resultList
		= (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.yb.dc.YBDC001QMDAO.selectListRsvSaleInfo", inputDataSet);
		
		//error 메시지 날리기
		if(resultList.isEmpty()){
			XframeControllerUtils.setMessage("IZZ000004", result);
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result);
		}
		result.put("dsGrdList", resultList);
		return result;
	}

}

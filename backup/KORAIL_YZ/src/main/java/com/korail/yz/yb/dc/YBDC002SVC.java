/**
 * project : KORAIL_YZ
 * package : com.korail.yz.yb.dc
 * date : 2014. 4. 2.오전 9:08:56
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
 * @date 2014. 4. 2. 오전 9:08:56
 * Class description : 운행역 정보 조회 서비스
 */
@Service("com.korail.yz.yb.dc.YBDC002SVC")
public class YBDC002SVC {


	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public  final Logger logger = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
	
	
	/**
	 * @author 한현섭
	 * @date 2014. 3. 28. 오후 1:56:03
	 * Method description : 운행 역정보 조회
	 * @param param
	 * @return Map
	 */	

	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListRunStnInfo(Map<String, ?> param){
		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();

		/* 입력 오브젝트 */
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsInfoCondition");
	
		ArrayList<Map<String, Object>> resultList
		= (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.yb.dc.YBDC002QMDAO.selectListRunStnInfo", inputDataSet);

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

	/**
	 * @author 한현섭
	 * @date 2014. 4. 3. 오후 1:56:03
	 * Method description : 운행 역정보 상세조회
	 * @param param
	 * @return Map
	 */	

	@SuppressWarnings("unchecked")
	public Map<String, ?> selectRunStnDtl(Map<String, ?> param){
		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		ArrayList<Map<String, String>> messageList = new ArrayList<Map<String, String>>();
		HashMap<String, String> msgMap = new HashMap<String, String>();
		
		/* 입력 오브젝트 */
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsDtlCondition");
	
		ArrayList<Map<String, Object>> resultList
		= (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.yb.dc.YBDC002QMDAO.selectRunStnDtl", inputDataSet);

		//error 메시지 날리기
		
		String msgCont = "정상조회 되었습니다.";
		msgMap.put("MSG_CONT", msgCont);
		messageList.add(msgMap);
		
		result.put("dsMessage", messageList);
		result.put("dsResultList", resultList);
		return result;
	}
}

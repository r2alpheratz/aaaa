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
		ArrayList<Map<String, String>> messageList = new ArrayList<Map<String, String>>();
		HashMap<String, String> msgMap = new HashMap<String, String>();
		
		/* 입력 오브젝트 */
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsRoutCond");
		logger.debug("inputDateSet--->"+inputDataSet.toString());
	
		ArrayList<Map<String, Object>> resultList 
		= (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.yb.dc.YBDC003QMDAO.selectListRoutInfo", inputDataSet);

		
		for(int i=0;i<10;i++)
		{
			if(resultList.size() > i)
			{
				logger.debug(resultList.get(i).toString());
			}
		}
		//error 메시지 날리기
		if(resultList.size() > 0){
			XframeControllerUtils.setMessage("IZZ000009", result);
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000004", result);
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
		ArrayList<Map<String, String>> messageList = new ArrayList<Map<String, String>>();
		HashMap<String, String> msgMap = new HashMap<String, String>();
		
		/* 입력 오브젝트 */
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCrvCond");
		logger.debug("inputDateSet--->"+inputDataSet.toString());

		
		ArrayList<Map<String, Object>> resultList
		= (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.yb.dc.YBDC003QMDAO.selectListCvrLnInfo", inputDataSet);

		
		for(int i=0;i<10;i++)
		{
			if(resultList.size() > i)
			logger.debug(resultList.get(i).toString());
			
		}
		//error 메시지 날리기
		if(resultList.size() > 0){
			XframeControllerUtils.setMessage("IZZ000009", result);
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000004", result);
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
		ArrayList<Map<String, String>> messageList = new ArrayList<Map<String, String>>();
		HashMap<String, String> msgMap = new HashMap<String, String>();
		
		/* 입력 오브젝트 */
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsConsCond");
		logger.debug("inputDateSet--->"+inputDataSet.toString());
	
		ArrayList<Map<String, Object>> resultList
		= (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.yb.dc.YBDC003QMDAO.selectRoutConsStn", inputDataSet);
		/**
		 * 현재 구현해야하는 부분 - > 별도의 쿼리를 통해 적용시작일리스트를 가져와야함
		 * db에 pk가 겹쳐서 매칭되는 데이터가 들어가지 않아, sql이 정확한 데이터를 가져올 수가 없음.
		 */
		
		for(int i=0;i<10;i++)
		{
			if(resultList.size() > i)
			{
				logger.debug(resultList.get(i).toString());
			}
		}
		//error 메시지 날리기
		if(resultList.size() > 0){
			String msgCont = "총 "+resultList.size()+"건이 조회되었습니다.";
			msgMap.put("MSG_CONT", msgCont);
		}
		else
		{
			String msgErr = "해당 조건의 데이터가 존재하지 않습니다.\n조회조건을 확인하여 주십시요";
			msgMap.put("MSG_ERR", msgErr);
		}
		messageList.add(msgMap);
		
		result.put("dsMessage", messageList);
		result.put("dsResultList", resultList);
		return result;
	}
	
	 
	 
}

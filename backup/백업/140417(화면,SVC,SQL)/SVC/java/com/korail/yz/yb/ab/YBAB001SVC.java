/**
 * project : KORAIL_YZ
 * package : com.korail.yz.yb.ab
 * date : 2014. 3. 26.오후 2:16:13
 */
package com.korail.yz.yb.ab;

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
 * @date 2014. 3. 26. 오후 2:16:13
 * Class description : 통합메시지코드 등록관리를 위한 서비스
 */
@Service("com.korail.yz.yb.ab.YBAB001SVC")
public class YBAB001SVC {

	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public  final Logger logger = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);

	
	
	@SuppressWarnings("unchecked")
	public Map<String, ?> insertMsgCdReg(Map<String, ?> param)
	{
		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		ArrayList<Map<String, String>> messageList = new ArrayList<Map<String, String>>();
		HashMap<String, String> msgMap = new HashMap<String, String>();

		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsMsgCdItem");
		

		String intgMsgCd = inputDataSet.get("MSG_TP_CD") + inputDataSet.get("DUTY_DV_NM");

		Map<String, String> inputPkSet = new HashMap<String, String>();
		inputPkSet.put("msgSrt", intgMsgCd);
		
		ArrayList<Map<String, Object>> resultMsg
		= (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.yb.ab.YBAB001QMDAO.selectCdMaxVal", inputPkSet);
		
		String maxCodeVal = (String) resultMsg.get(0).get("INTG_MSG_CD");

		inputDataSet.put("INTG_MSG_CD", maxCodeVal);
		inputDataSet.put("USR_ID", XframeControllerUtils.getUserId(param));
		logger.debug("maxCodeVal--->"+maxCodeVal);
		logger.debug("inputDateSet--->"+XframeControllerUtils.getUserId(param));
		logger.debug("inputDateSet--->"+inputDataSet.toString());
		
		try{
			dao.list("com.korail.yz.yb.ab.YBAB001QMDAO.insertMsgCdReg", inputDataSet);
			msgMap.put("MSG_CONT", "통합메시지코드를 저장하였습니다.");
		}catch(Exception e){
			msgMap.put("MSG_ERR", "통합메시지코드 입력에 실패했습니다.");
		}
		messageList.add(msgMap);
		result.put("dsMessage", messageList);
		logger.debug("resultSet--->"+result);
		return result;
	}

	public Map<String, ?> updateMsgCdMdfy(Map<String, ?> param)
	{
		Map<String, Object> result = new HashMap<String, Object>();
		ArrayList<Map<String, String>> messageList = new ArrayList<Map<String, String>>();
		HashMap<String, String> msgMap = new HashMap<String, String>();

		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsMsgCdItem");

		inputDataSet.put("USR_ID", XframeControllerUtils.getUserId(param));
		logger.debug("inputDateSet--->"+inputDataSet.toString());
		
		try{
			dao.list("com.korail.yz.yb.ab.YBAB001QMDAO.updateMsgCdMdfy", inputDataSet);
			msgMap.put("MSG_CONT", "통합메시지코드를 저장하였습니다.");
		}catch(Exception e){
			msgMap.put("MSG_ERR", "통합메시지코드 수정에 실패 하였습니다.");
		}
		messageList.add(msgMap);
		result.put("dsMessage", messageList);
		logger.debug("resultSet--->"+result);
		return result;
	}
	
	public Map<String, ?> deleteMsgCdDel(Map<String, ?> param)
	{
		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		ArrayList<Map<String, String>> messageList = new ArrayList<Map<String, String>>();
		HashMap<String, String> msgMap = new HashMap<String, String>();
		
		/* 입력 오브젝트 */
		Map<String, String> inputListSet = XframeControllerUtils	.getParamDataSet(param, "dsDeleteCondition");
		
		//선택된 row의 PK들을 Array형태로 분리.
		String[] pkList = inputListSet.get("INTG_MSG_CD_LIST").split(",");
		logger.debug("pkList"+pkList);
		
		//DB오류가 발생했을때 해당 PK를 기록할 ArrayList 생성
		ArrayList<String> errStr = new ArrayList<String>();
		
		//개별적으로 PK를 담을 Map을 생성
		Map<String, String> inputDataSet = new HashMap<String, String>();
		
		//For loop으로 개별 PK 삭제
		for(int i = 0 ; i < pkList.length ; i++){
			try
			{
				inputDataSet.put("INTG_MSG_CD", pkList[i]);
				dao.list("com.korail.yz.yb.ab.YBAB001QMDAO.deleteMsgCdDel", inputDataSet);
			}
			catch (Exception e) 
			{
				errStr.add(pkList[i]);
			}
		}

		//메시지를 담아 처리
		if(errStr.isEmpty()){
			XframeControllerUtils.setMessage("IZZ000011", result);
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result);
		}
		
		
		return result;
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListMsgCdQry(Map<String, ?> param)
	{
		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		
		/* 입력 오브젝트 */
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsSelectCondition");
		logger.debug("inputDateSet--->"+inputDataSet.toString());

		ArrayList<Map<String, Object>> resultList
		= (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.yb.ab.YBAB001QMDAO.selectMsgCdQry", inputDataSet);

		//error 메시지 날리기
		if(resultList.isEmpty()){
			XframeControllerUtils.setMessage("IZZ000004", result);			
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result);
		}
		result.put("dsMsgCdList", resultList);
		return result;
	}	
}
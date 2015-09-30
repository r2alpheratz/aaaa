/**
 * project : KORAIL_YZ
 * package : com.korail.yz.yb.aa
 * date : 2014. 3. 25. 오후 2:57:14
 */
package com.korail.yz.yb.aa;

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
 * @date 2014. 3. 25. 오후 2:59:06
 * Class description : 공통분류코드 조회 서비스
 */
@Service("com.korail.yz.yb.aa.YBAA001SVC")
public class YBAA001SVC {
	
	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public  final Logger logger = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);

	/**
	 * @author 한현섭
	 * @date 2014. 3. 25. 오후 2:01:31
	 * Method description : 분류코드를 조회한다.
	 * @param param
	 * @return Map
	 */	
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListSrtCd(Map<String, ?> param)
	{
		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		
		/* 입력 오브젝트 */
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCondition");
		logger.debug("inputDateSet--->"+inputDataSet.toString());
		String domnNm = inputDataSet.get("DOMN_NM").trim();
		inputDataSet.put("DOMN_NM", domnNm);
		
		/* 메인 SQL */
		ArrayList<Map<String, Object>> resultList
		= (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.yb.aa.YBAA001QMDAO.selectListSrtCd", inputDataSet);
		
		for(int i=0;i<resultList.size();i++)
		{
			logger.debug(resultList.get(i).toString());
			
		}

		//error 메시지 날리기
		if(resultList.isEmpty()){
			XframeControllerUtils.setMessage("IZZ000004", result);
			
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result);
		}
		result.put("dsSrtCdList", resultList);
		
		return result;
	}

	/**
	 * @author 한현섭
	 * @date 2014. 3. 25. 오후 2:11:31
	 * Method description : 상세코드를 조회한다.
	 * @param param
	 * @return Map
	 */	
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListDtlCd(Map<String, ?> param)
	{
		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();

		/* 입력 오브젝트 */
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCondition");
		logger.debug("inputDateSet--->"+inputDataSet.toString());
		
		/* 메인 SQL */
		ArrayList<Map<String, Object>> resultList
		= (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.yb.aa.YBAA001QMDAO.selectListDtlCd", inputDataSet);
		
		for(int i=0;i<resultList.size();i++)
		{
			logger.debug(resultList.get(i).toString());
			
		}
		
		//error 메시지 날리기
		if(resultList.isEmpty()){
			XframeControllerUtils.setMessage("IZZ000004", result);
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result);
			
		}
		result.put("dsDtlCdList", resultList);
		
		return result;
	}
}

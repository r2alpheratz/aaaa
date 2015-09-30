/**
 * project : KORAIL_YZ
 * package : com.korail.yz.yb.co
 * date : 2014. 4. 19.오후 5:20:03
 */
package com.korail.yz.yb.co;

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
 * @date 2014. 4. 19. 오후 5:20:03
 * Class description : 일일열차상세 정보를 조회하는 Service 클래스
 */
@Service("com.korail.yz.yb.co.YBCO004SVC")
public class YBCO004SVC {

	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public final Logger logger = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
 
	/**
	 * @author 한현섭
	 * @date 2014. 4. 19. 오후 5:28:49
	 * Method description : 열차기본정보
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?>  selectListTrnBsInfo (Map<String, ?> param){
		
	
 		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();

		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsGrdListBsInfoCond");
		logger.debug("inputDateSet--->"+inputDataSet.toString());


		/* DAO - 쿼리 실행 후 결과 획득*/
		ArrayList<Map<String, Object>> resultList
		= (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.yb.co.YBCO004QMDAO.selectListTrnBsInfo", inputDataSet);

		
		for(int i=0;i<resultList.size() ;i++)
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
		result.put("dsGrdListBsInfoResult", resultList);
		return result;

	}
	
	/**
	 * @author 한현섭
	 * @date 2014. 4. 19. 오후 5:28:51
	 * Method description : 열차편성정보
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?>  selectListTrnCpsInfo (Map<String, ?> param){
		
		
		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsGrdListTrnCpsInfoCond");
		logger.debug("inputDateSet--->"+inputDataSet.toString());
		
		
		/* DAO - 쿼리 실행 후 결과 획득*/
		ArrayList<Map<String, Object>> resultList
		= (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.yb.co.YBCO004QMDAO.selectListTrnCpsInfo", inputDataSet);
		
		
		for(int i=0;i<resultList.size() ;i++)
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
		result.put("dsGrdListTrnCpsInfoResult", resultList);
		return result;
		
	}
	
	/**
	 * @author 한현섭
	 * @date 2014. 4. 19. 오후 5:28:54
	 * Method description : 열차운행시각
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?>  selectListTrnRunTm (Map<String, ?> param){
		
		
		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsGrdListTrnRunTmCond");
		logger.debug("inputDateSet--->"+inputDataSet.toString());
		
		
		/* DAO - 쿼리 실행 후 결과 획득*/
		ArrayList<Map<String, Object>> resultList
		= (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.yb.co.YBCO004QMDAO.selectListTrnRunTm", inputDataSet);
		
		
		for(int i=0;i<resultList.size() ;i++)
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
		result.put("dsGrdListTrnRunTmResult", resultList);
		return result;
		
	}
	
}

/**
 * project : KORAIL_YZ
 * package : com.korail.yz.ys.ba
 * date : 2014. 4. 17.오후 1:30:24
 */
package com.korail.yz.ys.ba;

import java.util.*;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Service;

import com.korail.tz.sa.ISA0001SVC;
import com.korail.tz.sa.XframeControllerUtils;

import cosmos.comm.dao.CommDAO;
/**
 * @author EQ
 * @date 2014. 4. 17. 오후 1:30:24
 * Class description : 기본열차사용자조정수요예측SVC
 */
@Service("com.korail.yz.ys.ba.YSBA001SVC")
public class YSBA001SVC {
	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public  final Logger logger = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
	
	/**
	 * 사용자조정수요예측기본열차조회
	 * @author 김응규
	 * @date 2014. 4. 17. 오후 1:39:15
	 * Method description : 수요예측 사용자조정 이력이 있는 기본열차를 조회한다.  
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map<String, ?> selectListUsrCtlYmgtFcstBsTrn(Map<String, ?> param) {		

		Map<String, Object> result = new HashMap<String, Object>();

		logger.debug("param ==> "+param);
		// search input column dataset
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");	
		logger.debug("inputDataSet ==>  " + inputDataSet);

		// search input column data
		logger.debug("inputData ==>  " + inputDataSet.toString());
		
		ArrayList<Map<String, Object>> resultList = (ArrayList) dao.list("com.korail.yz.ys.ba.YSBA001QMDAO.selectListUsrCtlYmgtFcstBsTrn", inputDataSet);

		
		for(int i=0;i<resultList.size();i++)
		{
			logger.debug(resultList.get(i).toString());
		}
		
		result.put("dsList", resultList);

		return result;

	}
	
	
	
	/**
	 * @author 한현섭
	 * @date 2014. 4. 14. 오전 10:12:11
	 * Method description : 최적화구간별할당결과조회
	 * @param param
	 * @return
	 */
/*	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map<String, ?> selectListQtmzSgmpAlcCnqe(Map<String, ?> param) {
		Map<String, Object> result = new HashMap<String, Object>();

		logger.debug("param ==> "+param);
		// search input column dataset
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsOptSeqCondition");	
		logger.debug("inputDataSet ==>  " + inputDataSet);

		// search input column data
		logger.debug("inputData ==>  " + inputDataSet.toString());
		
		ArrayList<Map<String, Object>> resultList = (ArrayList) dao.list("com.korail.yz.ys.aa.YSAA003QMDAO.selectListQtmzSgmpAlcCnqe", inputDataSet);

		
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
		result.put("dsOptSeqResult", resultList);

		return result;
	}*/
	
}

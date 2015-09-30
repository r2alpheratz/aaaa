/**
 * project : KORAIL_YZ
 * package : com.korail.yz.yb.ea
 * date : 2014. 5. 10.오후 3:25:55
 */
package com.korail.yz.yb.ea;

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
 * @date 2014. 5. 10. 오후 3:25:55
 * Class description : 일일열차자유석잔여좌석조회SVC
 */
@Service("com.korail.yz.yb.ea.YBEA002SVC")
public class YBEA002SVC {

	
	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public  final Logger LOGGER = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
		
	/**
	 * @author 한현섭
	 * @date 2014. 5. 10. 오후 3:32:34
	 * Method description : 정차구간 자유석 잔여석 수 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListStopSegFresNum(Map<String, ?> param){
		
 		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();

		/* 입력 오브젝트 */
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");

		/* DAO - 쿼리 실행 후 결과 획득*/
		ArrayList<Map<String, Object>> resultList
		= (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.yb.ea.YBEA002QMDAO.selectListStopSegFresNum", inputDataSet);

		//error 메시지 날리기
		if(resultList.isEmpty()){
			XframeControllerUtils.setMessage("IZZ000004", result);
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result);
		}
		result.put("dsStopSegFresNum", resultList);
		return result;
	}
	
	
	
	/**
	 * @author 한현섭
	 * @date 2014. 5. 10. 오후 3:32:32
	 * Method description : 출발/도착역별 자유석 잔여석 수
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListDptArvStnFresNum (Map<String, ?> param){
		
 		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();

		/* 입력 오브젝트 */
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");

		/* DAO - 쿼리 실행 후 결과 획득*/
		ArrayList<Map<String, Object>> resultList
		= (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.yb.ea.YBEA002QMDAO.selectListDptArvStnFresNum", inputDataSet);

		//error 메시지 날리기
		if(resultList.isEmpty()){
			XframeControllerUtils.setMessage("IZZ000004", result);
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result);
		}
		result.put("dsDptArvStnFresNum", resultList);
		return result;
	}
	
	
}

/**
 * project : KORAIL_YZ
 * package : com.korail.yz.yb.ea
 * date : 2014. 5. 10.오후 3:25:23
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
 * @date 2014. 5. 10. 오후 3:25:23
 * Class description : 일일열차객실등급별좌석속성별잔여좌석조회SVC
 */
@Service("com.korail.yz.yb.ea.YBEA001SVC")
public class YBEA001SVC {
	
	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public  final Logger LOGGER = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);

	
	
	/**
	 * @author 한현섭
	 * @date 2014. 5. 10. 오후 3:32:34
	 * Method description : 객실등급별좌석수 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListPsrmClSeatNum(Map<String, ?> param){
		
 		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();

		/* 입력 오브젝트 */
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");

		/* DAO - 쿼리 실행 후 결과 획득*/
		ArrayList<Map<String, Object>> resultList
		= (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.yb.ea.YBEA001QMDAO.selectListPsrmClSeatNum", inputDataSet);

		ArrayList<Map<String, Object>> hasFresList
		= (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.yb.ea.YBEA001QMDAO.selectHasFres", inputDataSet);
		

		
		if(!hasFresList.isEmpty() )
		{
			if(!resultList.isEmpty())
			{
				resultList.get(0).put("HAS_FRES", "Y");
			}
			
		}
		//error 메시지 날리기
		if(resultList.isEmpty()){
			XframeControllerUtils.setMessage("IZZ000004", result);
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result);
		}
		result.put("dsPsrmClSeatNum", resultList);
		return result;
	}
	
	
	
	/**
	 * @author 한현섭
	 * @date 2014. 5. 10. 오후 3:32:32
	 * Method description : 일일열차운행시각 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?> selectListTrnRunTm(Map<String, ?> param){
		
 		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();

		/* 입력 오브젝트 */
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");

		/* DAO - 쿼리 실행 후 결과 획득*/
		ArrayList<Map<String, Object>> resultList
		= (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.yb.co.YBCO004QMDAO.selectListTrnRunTm", inputDataSet);

		//error 메시지 날리기
		if(resultList.isEmpty()){
			XframeControllerUtils.setMessage("IZZ000004", result);
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result);
		}
		result.put("dsResult", resultList);
		return result;
	}
	
}

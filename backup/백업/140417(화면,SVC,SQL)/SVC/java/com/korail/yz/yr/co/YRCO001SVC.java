/**
 * project : KORAIL_YZ
 * package : com.korail.yz.yb.co
 * date : 2014. 3. 11.오후 3:32:36
 */
package com.korail.yz.yr.co;

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
 * @author "Changki.woo"
 * @date 2014. 4. 13. 오후 4:32:42
 * Class description : 실적관리 공통 SVC 모음
 */
@Service("com.korail.yz.yr.co.YRCO001SVC")
public class YRCO001SVC {

	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public  final Logger logger = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
	
	
	/**
	 * @author "Changki.woo"
	 * @date 2014. 3. 27. 오후 4:09:25
	 * Method description : 열차운영 정보 조회 Method
	 * @param param
	 * @return
	 */
	public Map<String, ? > selectTrnRunInfo(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> getParamSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");
		
		ArrayList<Map<String, Object>> resultList = null;
		
		resultList = (ArrayList) dao.list("com.korail.yz.yr.co.YRCO001QMDAO.selectTrnRunInfoQry", getParamSet);
		result.put("dsTrnRunInfo", resultList);
		
		return result;
		
	}
	
	
	/**
	 * @author "Changki.woo"
	 * @date 2014. 3. 27. 오후 7:52:14
	 * Method description : 열차기본 정보 조회 Method
	 * @param param
	 * @return
	 */
	public Map<String, ? > selectTrnBsInfo(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> getParamSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");
		
		ArrayList<Map<String, Object>> resultList = null;
		
		resultList = (ArrayList) dao.list("com.korail.yz.yr.co.YRCO001QMDAO.selectTrnBaseInfoQry", getParamSet);
		result.put("dsTrnBsInfo", resultList);
		
		return result;
		
	}
}

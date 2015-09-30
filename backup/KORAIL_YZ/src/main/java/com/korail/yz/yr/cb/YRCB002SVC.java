/**
 * project : KORAIL_YZ
 * package : com.korail.yz.yb.co
 * date : 2014. 3. 11.오후 3:32:36
 */
package com.korail.yz.yr.cb;

import java.util.HashMap;
import java.util.List;
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
 * @date 2014. 8. 4. 오전 10:53:03
 * Class description : 이벤트 실적 평가
 */
@Service("com.korail.yz.yr.cb.YRCB002SVC")
public class YRCB002SVC {

	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public  final Logger logger = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
	
	/**
	 * @author "Changki.woo"
	 * @date 2014. 8. 4. 오전 10:53:26
	 * Method description : 이벤트 목록조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ? > selectListEvnt(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> getParamSet = null;
		List<Map<String, Object>> resultList = null;
		
		String svcUrl = "com.korail.yz.yr.cb.YRCB002QMDAO.selectListEvntQry";
		
		if( param.containsKey("dsCond") )
		{
			getParamSet  = XframeControllerUtils.getParamDataSet(param, "dsCond");
			resultList = (List<Map<String, Object>>) dao.list(svcUrl, getParamSet);
			result.put("dsList", resultList);
			
			if( resultList.isEmpty() )
			{
				XframeControllerUtils.setMessage("IZZ000004", result); //해당 조건의 자료가 존재하지 않습니다.
			}
			else
			{
				XframeControllerUtils.setMessage("IZZ000009", result);
			}
		}
		
		return result;	
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, ? > selectListEvntTrn(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> getParamStdSet = null;
		List<Map<String, Object>> resultList = null;
		
		String svcUrl = "com.korail.yz.yr.cb.YRCB002QMDAO.selectListEvntTrnQry";
		
		if( param.containsKey("dsCondGrd") )
		{
			getParamStdSet  = XframeControllerUtils.getParamDataSet(param, "dsCondGrd");
			resultList = (List<Map<String, Object>>) dao.list(svcUrl, getParamStdSet);
			result.put("dsListTrn", resultList);
			
			//팝업 E02에서 사용하는 DS
			result.put("dsPramTrn", resultList);
			
			
			if( resultList.isEmpty() )
			{
				XframeControllerUtils.setMessage("IZZ000004", result); //해당 조건의 자료가 존재하지 않습니다.
			}
			else
			{
				XframeControllerUtils.setMessage("IZZ000009", result);
			}
		}
		
		return result;	
	}
	
}
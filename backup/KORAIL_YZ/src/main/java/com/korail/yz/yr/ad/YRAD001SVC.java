/**
 * project : KORAIL_YZ
 * package : com.korail.yz.yb.co
 * date : 2014. 3. 11.오후 3:32:36
 */
package com.korail.yz.yr.ad;

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
 * @date 2014. 5. 30. 오전 10:12:40
 * Class description : 시각표 SVC - YRAD001_S01
 */
@Service("com.korail.yz.yr.ad.YRAD001SVC")
public class YRAD001SVC {

	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public  final Logger logger = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
	
	/**
	 * @author "Changki.woo"
	 * @date 2014. 6. 2. 오후 3:26:25
	 * Method description : 시각표 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ? > selectListTmTable(Map<String, ?> param){
		
		
		Map<String, Object> result 		  = new HashMap<String, Object>();
		Map<String, String> getParamSet  = XframeControllerUtils	.getParamDataSet(param, "dsCond");
		
		//List<Map<String, Object>> resultList 		 = null;
		List<Map<String, Object>> resultColData = null;	
		// 그리드 동적구성용 조회.
		// 둘이 ORDER BY만 다름.
		String urlCol = "com.korail.yz.yr.ad.YRAD001QMDAO.selectListTmTableColDataQry";
		//String url = "com.korail.yz.yr.ad.YRAD001QMDAO.selectListTmTableQry";
		
		
		
		resultColData = (List<Map<String, Object>>) dao.list(urlCol, getParamSet);
		//resultList 	  = (List<Map<String, Object>>) dao.list(url, getParamSet);
		
		//result.put("dsListData", resultColData);
		result.put("dsList", resultColData);
		
		
		
		if(resultColData.isEmpty())
		{
			XframeControllerUtils.setMessage("IZZ000004", result); //해당 조건의 자료가 존재하지 않습니다.
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result);
		}
		
		return result;
		
	}
}







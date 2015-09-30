/**
 * project : KORAIL_YZ
 * package : com.korail.yz.yb.co
 * date : 2014. 3. 11.오후 3:32:36
 */
package com.korail.yz.yr.cb;

import java.util.ArrayList;
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
import cosmos.comm.exception.CosmosBizException;


/**
 * @author "Changki.woo"
 * @date 2014. 8. 5. 오전 11:00:10
 * Class description : 이벤트 열차 관리
 */
@Service("com.korail.yz.yr.cb.YRCB004SVC")
public class YRCB004SVC {

	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public  final Logger logger = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
	
	/**
	 * @author "Changki.woo"
	 * @date 2014. 8. 5. 오전 11:00:34
	 * Method description : 이벤트 열차 전체 목록 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ? > selectListEvntTrnWhole(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> getParamSet  = null;
		List<Map<String, Object>> resultList = null;
		
		String svcUrl = "com.korail.yz.yr.cb.YRCB004QMDAO.selectListTrnNoWholeQry";
		
		if( param.containsKey("dsCond") )
		{
			getParamSet  = XframeControllerUtils.getParamDataSet(param, "dsCond");
			resultList = (List<Map<String, Object>>) dao.list(svcUrl, getParamSet);
			result.put("dsListTrn", resultList);
			
			if( resultList.isEmpty())
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
	
	/**
	 * @author "Changki.woo"
	 * @date 2014. 8. 4. 오후 7:16:38
	 * Method description : 이벤트 업데이트 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ? > updateEvntTrn(Map<String, ?> param) throws Exception{
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		List<Map<String, String>> updateList = (ArrayList<Map<String, String>>) param.get("dsPramTrn");
		String usrId = param.get("USER_ID").toString();
		
		
		// 1. 로그인 ID 세팅
		for(int i = 0; i< updateList.size(); i++)
		{
			Map<String,String> nRow = updateList.get(i);
			nRow.put("USR_ID", usrId);
			
			String dsStatus = nRow.get("DS_STATUS");
			
	        if("I".equals(dsStatus))
	        {
		    	int retVal = dao.insert("com.korail.yz.yr.cb.YRCB004QMDAO.insertEvntTrn", nRow);
		    	
		    	if(retVal < 0)
		    	{
		    		throw new CosmosBizException("DB 오류가 발생했습니다. 관리자에게 문의하세요");
		    	}
		    	
	        }	
	    
	        else if("U".equals(dsStatus))
	        {
	        	int retVal = dao.update("com.korail.yz.yr.cb.YRCB004QMDAO.updateEvntTrn", nRow);
		    	
		    	if(retVal < 0)
		    	{
		    		throw new CosmosBizException("DB 오류가 발생했습니다. 관리자에게 문의하세요");
		    	}		    	
	        }
	        else if("D".equals(dsStatus))
	        {
	        	int retVal = dao.update("com.korail.yz.yr.cb.YRCB004QMDAO.deleteEvntTrn", nRow);
		    	
		    	if(retVal < 0)
		    	{
		    		throw new CosmosBizException("DB 오류가 발생했습니다. 관리자에게 문의하세요");
		    	}	
	        }
		}
		
		return result;
		
	}
}
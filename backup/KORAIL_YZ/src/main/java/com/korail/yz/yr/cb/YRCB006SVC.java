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
import cosmos.comm.exception.CosmosBizException;


/**
 * @author "Changki.woo"
 * @date 2014. 8. 6. 오전 10:22:23
 * Class description : 수익성과평가 조회
 */
@Service("com.korail.yz.yr.cb.YRCB006SVC")
public class YRCB006SVC {

	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public  final Logger logger = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
	
	/**
	 * @author "Changki.woo"
	 * @date 2014. 8. 8. 오후 3:53:32
	 * Method description : 수익성과평가 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ? > selectListYmsRst(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> getParamSet  = null;
		List<Map<String, Object>> resultList = null;
		
		String svcUrl = "com.korail.yz.yr.cb.YRCB006QMDAO.selectListYmsRstQry";
		
		if( param.containsKey("dsCond2") )
		{
			getParamSet  = XframeControllerUtils.getParamDataSet(param, "dsCond2");
			resultList = (List<Map<String, Object>>) dao.list(svcUrl, getParamSet);
			result.put("dsList2", resultList);
			
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
	 * @date 2014. 8. 12. 오후 2:05:41
	 * Method description : 수익성과평가 차트조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ? > selectListYmsRstCht(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> getParamSet  = null;
		List<Map<String, Object>> resultList = null;
		
		String svcUrl = "com.korail.yz.yr.cb.YRCB006QMDAO.selectListYmsRstChtQry";
		
		if( param.containsKey("dsCondCht") )
		{
			getParamSet  = XframeControllerUtils.getParamDataSet(param, "dsCondCht");
			resultList = (List<Map<String, Object>>) dao.list(svcUrl, getParamSet);
			result.put("dsCht2", resultList);
			
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
	
	
	/**
	 * @author "Changki.woo"
	 * @date 2014. 8. 12. 오후 2:05:41
	 * Method description : 수익성과평가 차트조회 - 운행일자 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ? > selectListRunDt(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> getParamSet  = null;
		List<Map<String, Object>> resultList = null;
		
		String svcUrl = "com.korail.yz.yr.cb.YRCB006QMDAO.selectListRunDt";
		
		if( param.containsKey("dsCond2") )
		{
			getParamSet  = XframeControllerUtils.getParamDataSet(param, "dsCond2");
			resultList = (List<Map<String, Object>>) dao.list(svcUrl, getParamSet);
			result.put("dsRunDtList2", resultList);
			
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
	
	/**
	 * @author "Changki.woo"
	 * @date 2014. 8. 8. 오후 3:53:32
	 * Method description : 수익성과평가 조회(요일별)
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ? > selectListYmsRstDayPr(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> getParamSet  = null;
		List<Map<String, Object>> resultList = null;
		
		String svcUrl = "com.korail.yz.yr.cb.YRCB006QMDAO.selectListYmsRstDayPrQry";
		
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
	
	/**
	 * @author "Changki.woo"
	 * @date 2014. 8. 8. 오후 3:53:32
	 * Method description : 수익성과평가 조회
	 * @param param
	 * @return
	 * @throws CosmosBizException 
	 */
	public Map<String, ? > insertSimData(Map<String, ?> param) throws CosmosBizException{
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> getParamSet  = null;
		String usrId = param.get("USER_ID").toString();
		
		String svcUrl = "com.korail.yz.yr.cb.YRCB006QMDAO.insertSimData";
		
		if( param.containsKey("dsCond") )
		{
			getParamSet  = XframeControllerUtils.getParamDataSet(param, "dsCond");
			getParamSet.put("usrId", usrId);
			int retVal = dao.update(svcUrl, getParamSet);
			
		    	
	    	if(retVal < 0)
	    	{
	    		throw new CosmosBizException("DB 오류가 발생했습니다. 관리자에게 문의하세요");
	    	}
		    	
		}
		
		if( param.containsKey("dsCond2") )
		{
			getParamSet  = XframeControllerUtils.getParamDataSet(param, "dsCond2");
			getParamSet.put("usrId", usrId);
			int retVal = dao.update(svcUrl, getParamSet);
			
		    	
	    	if(retVal < 0)
	    	{
	    		throw new CosmosBizException("DB 오류가 발생했습니다. 관리자에게 문의하세요");
	    	}
		    	
		}
		XframeControllerUtils.setMessage("IYR000001"/*시뮬레이션이 수행되었습니다."*/, result);
		return result;
	}
	
	
	/**
	 * @author "Changki.woo"
	 * @date 2014. 8. 11. 오전 9:31:37
	 * Method description : 수익성과평가 시뮬레이션 삭제
	 * @param param
	 * @return
	 * @throws CosmosBizException
	 */
	public Map<String, ? > deleteSimData(Map<String, ?> param) throws CosmosBizException{
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		String svcUrl = "com.korail.yz.yr.cb.YRCB006QMDAO.deleteSimData";
		
		int retVal = dao.update(svcUrl, null);
			
		    	
	    if(retVal < 0)
	    {
	    	throw new CosmosBizException("DB 오류가 발생했습니다. 관리자에게 문의하세요");
		    	
		}
		
		return result;
	}
	
	/**
	 * @author "Changki.woo"
	 * @date 2014. 8. 8. 오후 3:53:32
	 * Method description : 수익성과평가 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ? > selectSimEndCond(Map<String, ?> param){
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> getParamSet  = null;
		List<Map<String, Object>> resultList = null;
		
		String svcUrl = "com.korail.yz.yr.cb.YRCB006QMDAO.selectSimEndCond";
		
		resultList = (List<Map<String, Object>>) dao.list(svcUrl, getParamSet);
		result.put("dsAutoCond", resultList);
			
		if( "100".equals( String.valueOf(resultList.get(0).get("PROGRESS_RT"))))
		{
			XframeControllerUtils.setMessage("IYR000003"/*수행된 시뮬레이션 결과가 있습니다."*/, result);
		}
		else if("0".equals( String.valueOf(resultList.get(0).get("PROGRESS_RT"))))
		{
			XframeControllerUtils.setMessage("IYR000004"/*시뮬레이션 결과를 기다리고 있습니다."*/, result);
		}
		else
		{
			XframeControllerUtils.setMessage("IYR000002"/*시뮬레이션 결과가 없습니다."*/, result);
		}
		return result;
	}
}
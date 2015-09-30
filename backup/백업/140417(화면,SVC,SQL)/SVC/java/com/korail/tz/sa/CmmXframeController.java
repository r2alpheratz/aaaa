package com.korail.tz.sa;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.context.MessageSource;
import org.springframework.util.ReflectionUtils;
import org.springframework.util.StringUtils;
import org.springframework.validation.Errors;
import org.springframework.validation.MapBindingResult;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;
import org.springframework.web.servlet.view.RedirectView;

import xdataset.XDataSet;
import cosmos.comm.cache.CacheItem;
import cosmos.comm.cache.CosmosCacheManager;
import cosmos.comm.context.CosmosContext;
import cosmos.comm.exception.CosmosRuntimeException;
import cosmos.comm.svc.ResultKeyExtractor;
import cosmos.comm.util.ActionMapKey;
import cosmos.comm.util.ActionMapUtil;
import cosmos.comm.util.MapUtil;
import cosmos.comm.validation.MapValidator;
import cosmos.comm.web.ExceptionHandler;

public class CmmXframeController implements ApplicationContextAware , Controller{
	
	public final Logger logger = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
	
	private ApplicationContext context;
	private ExceptionHandler exceptionHandler;// = null;
	private MapValidator mapValidator = null;
	private XframeCommSVC commSVC = null;
	
	@Resource(name = "messageSource")
	MessageSource messageSource;
	
	public void setApplicationContext(ApplicationContext context)
			throws BeansException {
		this.context = context;
	}
	public void setExceptionHandler(ExceptionHandler exceptionHandler){
		this.exceptionHandler = exceptionHandler;
	}
	public void setMapValidator(MapValidator mapValidator){
		this.mapValidator = mapValidator;
	}
	public void setResultKeyExtractor(ResultKeyExtractor keyExtractor){
		this.keyExtractor = keyExtractor;
	}
	public void setCommSVC(XframeCommSVC commSVC){
		this.commSVC = commSVC;
	}
	private ResultKeyExtractor keyExtractor = ResultKeyExtractor.DEFAULT_EXTRACTOR;
	
	public ModelAndView handleRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
			
		
		Map<String, String> actionInfo = CosmosContext.getActionInfo();
	
		logger.debug("actionInfo = " + actionInfo);
		
		//String actionId = actionInfo.get(ActionMapKey.ACTION_ID);
		String svcId = actionInfo.get(ActionMapKey.SERVICE_ID);
		String methodName = actionInfo.get( ActionMapKey.METHOD);
		String forwardOnlyYn = actionInfo.get( ActionMapKey.FORWARD_ONLY_FLAG);
		String forwardUrl = actionInfo.get(ActionMapKey.SCREEN_URL);
		String validationFormName = actionInfo.get(ActionMapKey.VALIDATION_FORM_NAME);
		
	
		XDataSet	xDataSet = new XDataSet(request, response);	
	
		
		List<String> inDsNames = new ArrayList<String>();
		List<String> outDsNames = new ArrayList<String>();

		for(String dsName : xDataSet.getDataSetNamesArray()){
			//System.out.println(" >>>> dsName 1111111 : "+dsName+ " xDataSet.getDataSetType(dsName) " +xDataSet.getDataSetType(dsName));
			if(XDataSet.XDATA_OUTPUT.equals(xDataSet.getDataSetType(dsName))){
				outDsNames.add(dsName);
			}else if(XDataSet.XDATA_INPUT.equals(xDataSet.getDataSetType(dsName))){
				inDsNames.add(dsName);
			}else if(XDataSet.XDATA_INOUT.equals(xDataSet.getDataSetType(dsName))){
				inDsNames.add(dsName);
				outDsNames.add(dsName);
			}
		}
//		Map<String, Object> tmpParam = XframeControllerUtils.convertDataSetListToHashMap(xDataSet);
		
		Map<String, Object> param = new HashMap<String, Object>();		

		for(String inDsName : inDsNames) {
			param.put(inDsName, XframeControllerUtils.convertXDataSetToList(xDataSet, inDsName));
		}
//		logger.debug(" >>>> CmmXframeController param : "+param);
		
		
		if(null != validationFormName && !"".equals(validationFormName)){
			Errors errors = new MapBindingResult(param, validationFormName);
			mapValidator.validate(validationFormName, param, errors);
			if(errors.hasErrors()){
				// back to caller with errors.
				throw new RuntimeException("Fail to validate"); //NOPMD
				// validation failed.
			}
		}
		Map<String, Object> contextMap = MapUtil.addKeyPrefix("context", "_",  CosmosContext.getContextInfo().toMap());
		param.putAll(contextMap);

//		if(logger.isDebugEnabled()){
//			logger.debug("Call Parameters");
//			for(String key : param.keySet()){
//				logger.debug("-- [{}] : [{}]", key, param.get(key));
//			}
//		}
		
		ModelAndView modelAndView;
		if(forwardUrl.endsWith(".do") || forwardUrl.contains(".do?") || forwardUrl.contains(".do;") || forwardUrl.contains(".do:")){
			RedirectView view = new RedirectView(forwardUrl);
			view.setAttributesMap(param);
			modelAndView = new ModelAndView(view);
		}else{
			modelAndView = new ModelAndView(forwardUrl);
		}
		/**
		 * 여기도 param 주의..
		 */
		modelAndView.addObject("param", param);
		modelAndView.addObject("context", contextMap);
		
		if("Y".equals(forwardOnlyYn)){
			return modelAndView;
		}
		
		Object result = null;
		
		try {
			// String inDsNm, String outDsNm
			if("commSVC".equals(svcId)){
				String sqlId = actionInfo.get(ActionMapKey.SQL_ID);
//				logger.debug("sqlId : "+sqlId);
//				logger.debug("param : "+param);
				Map<String, String> dsMap = XframeControllerUtils.getInOutDs(inDsNames, outDsNames);
				String inDsNm = dsMap.get("IN_DS");
				String outDsNm = dsMap.get("OUT_DS");
//				logger.debug("inDsNm : "+inDsNm+ " outDsNm  : "+outDsNm);
				if("list".equals(methodName)){
					String listSqlId = actionInfo.get( ActionMapKey.LIST_SQL_ID);
					String countSqlId = actionInfo.get(ActionMapKey.COUNT_SQL_ID);
					result = commSVC.list(countSqlId, listSqlId, param, inDsNm, outDsNm);
				}else if("listWithoutCount".equals(methodName)){
					result = commSVC.listWithoutCount(sqlId, param, inDsNm, outDsNm);
				}else if("select".equals(methodName)){
					result = commSVC.select(sqlId, param, inDsNm, outDsNm);
				}else if("create".equals(methodName)){
					result = commSVC.create(sqlId, param, inDsNm);
				}else if("delete".equals(methodName)){
					result = commSVC.delete(sqlId, param, inDsNm);
				}else if("update".equals(methodName)){
					result = commSVC.update(sqlId, param, inDsNm);
				}else if("multiList".equals(methodName)){
					String listSqlId = actionInfo.get( ActionMapKey.LIST_SQL_ID);
					String countSqlId = actionInfo.get(ActionMapKey.COUNT_SQL_ID);
					String[] listSqlIds = StringUtils.commaDelimitedListToStringArray(listSqlId);
					String[] countSqlIds = StringUtils.commaDelimitedListToStringArray(countSqlId);
					result = commSVC.multiList(countSqlIds, listSqlIds, param, keyExtractor);
				}
			}else{
				String methodId = String.format("%s.%s", svcId, methodName);
				
				//USER_ID
				param.put(ISA0001SVC.XDATASET_HEADER_USER_ID,request.getHeader(ISA0001SVC.XDATASET_HEADER_USER_ID));
				
				Object service = context.getBean(svcId);
				Method method = getMethod(methodId, service, methodName);
				result = ReflectionUtils.invokeMethod(method, service,
						new Object[] { param });
				if (null == result) {
					result = param;
				}
			}
					
		} catch(RuntimeException re){
			String reMessage = "";			
						
			//강제 Throw Exception 처리 (WARN)
			if(re instanceof CosmosRuntimeException){
				logger.debug("CosmosRuntimeException :  Business Exception");
				reMessage = re.getMessage();
				reMessage =  messageSource.getMessage("biz.000.error", new String[] {reMessage}, ISA0001SVC.WARN_MESSAGE_LOCALE).toString();
				
				modelAndView.addObject(ISA0001SVC.XDATASET_MESSAGE_LEVEL, ISA0001SVC.XDATASET_MESSAGE_LEVEL_WARN);
				modelAndView.addObject(ISA0001SVC.XDATASET_WARN_MESSAGE_KEY, reMessage);	
			}
			//Exception 처리 (ERROR)
			else{
				logger.debug("RuntimeException :  Syntex Exception");
				reMessage = re.initCause(re.getCause()).toString();				
				reMessage =  messageSource.getMessage("500.error", new String[] {reMessage}, ISA0001SVC.ERROR_MESSAGE_LOCALE).toString();
				modelAndView.addObject(ISA0001SVC.XDATASET_MESSAGE_LEVEL, ISA0001SVC.XDATASET_MESSAGE_LEVEL_ERROR);
				modelAndView.addObject(ISA0001SVC.XDATASET_ERROR_MESSAGE_KEY, reMessage);
			}					
		    							    
		}
		modelAndView.addObject("result", result);
		modelAndView.addObject("outDsNames", outDsNames);		
		//modelAndView.addObject("xDataSet", xDataSet); //add temp
		
		
		String screenUrl = ActionMapUtil.getOverloadedScreenUrl();
		if(!"".equals(screenUrl)){
			modelAndView.setViewName(screenUrl);
		}

		return modelAndView;
		
	}
	
	private Method getMethod(String methodId, Object instance, String methodName){
		CacheItem<Method> cache = CosmosCacheManager.getCache(CosmosCacheManager.ITEM_TYPE_METHOD);
		return cache.get(methodId);
	}
	
}

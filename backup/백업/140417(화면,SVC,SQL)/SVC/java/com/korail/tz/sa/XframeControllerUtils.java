package com.korail.tz.sa;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.slf4j.Logger;
import org.springframework.context.MessageSource;

import xdataset.XDataSet;
//import cosmos.log.CosmosLoggerFactory;

public class XframeControllerUtils {

	public static final String XFRAME_LIST_SUFFIX = "List";
	
	private static final String SQL_ACTION = "sqlAction";
	private static final String SQL_ACTION_CREATE = "C";
	private static final String SQL_ACTION_UPDATE = "U";
	private static final String SQL_ACTION_DELETE = "D";
	
	private static final String ROW_ID = "rowId";
	private static final String RECORD_KEY = "recordKey";
	
//	private static Logger getLogger(){
//		//return CosmosLoggerFactory.getLogger(XframeControllerUtils.class);
//	}

	public static List<Map<String, Object>> convertXDataSetToList(XDataSet xDataSet, String dsName) throws Exception{
		
		//Logger logger = null;//getLogger();
		ArrayList al = new ArrayList();
		Map dataMap = null;
		
		//System.out.println("############## dsName #############{}"+ dsName);
		
		int recordCount = xDataSet.getRecordCount(dsName);
		String[] colNms =  xDataSet.getColumnNamesArray(dsName);
		//System.out.println("##############recordCount #############{}"+ recordCount);
		
		for(String paramNm : colNms){
			//System.out.println("############## colNms #############{}"+ paramNm);
		}
		
		for(int i=0; i<recordCount; i++){
			dataMap = new HashMap();
			
			for(String paramNm : colNms){
				dataMap.put(paramNm, xDataSet.getData(dsName, paramNm, i));				
			}
			
			if(xDataSet.isInsertRecord(dsName, i)){
				dataMap.put(SQL_ACTION, SQL_ACTION_CREATE);
			}else if(xDataSet.isUpdateRecord(dsName, i)){
				dataMap.put(SQL_ACTION, SQL_ACTION_UPDATE);
			}else if(xDataSet.isDeleteRecord(dsName, i)){
				dataMap.put(SQL_ACTION, SQL_ACTION_DELETE);
			}else{
				;
			}
			
			dataMap.put(ROW_ID, i);
			dataMap.put(RECORD_KEY, xDataSet.getRecordKey(dsName, i));
			
			al.add(dataMap);
		}

	//	logger.debug("####CASE OUT #####");
		//logger.debug("%%%%%%%%%%%%%al%%%%%%%%%%% : {}", al);
		return al;
	}
	
	public static XDataSet setListToXDataSet(XDataSet xDataSet, String dsName, List result) throws Exception{
		
	//	Logger logger = null;//getLogger();
	//	logger.debug("%%%%  convertObjectToDataSetList result  %%%%% : {}", result);
		
		if(result == null) {
			return xDataSet;
		}
		
		for(int i=0; i<result.size(); i++) {
			Map record = (Map) result.get(i);
			
			for(String key : (Set<String>)record.keySet()) {
			
				if(RECORD_KEY.equals(key)) {
					xDataSet.setRecordKey(dsName, i, (String)record.get(key));
				}  else {
					String values =  String.valueOf(record.get(key));
					if(null == values || "null".equals(values)){
						values = "";
					}
					//xDataSet.setData(dsName, key, i, String.valueOf(record.get(key)));
					xDataSet.setData(dsName, key, i, values);
				}																
			}
		}
		
		//System.out.println(xDataSet);
		return xDataSet;
	}
	
	
	@SuppressWarnings("unchecked")
	public static Map<String, Object> makeDaoParam(Map<String, Object> param, String inDsNm) {
		Logger logger = null;//getLogger();
		Map<String, Object> returnMap = new HashMap<String, Object>();
		// (Map<String, Object>) ((List)param.get(inDsNm)).get(0);
		if("".equals(inDsNm)){
			return returnMap;	
		}
		Object tmpObj = param.get(inDsNm);
		if(tmpObj instanceof List){
			List<Map<String, Object>> tmpList = (List<Map<String, Object>>)param.get(inDsNm);
			if(!tmpList.isEmpty()){
				if(tmpList.size() > 0){
					returnMap = tmpList.get(0);
				}
			}else{
				return returnMap;	
			}
		}else{
		//	logger.debug("Param is not List.....");
			return returnMap;	
		}		
		return returnMap;		
	}
	
	public static Map<String, String> getInOutDs(List<String> inDsNames, List<String> outDsNames) {
		Logger logger = null;//getLogger();
		Map<String, String> returnMap = new HashMap<String, String>();
		String inDsNm;
		String outDsNm;
		returnMap.put("IN_DS", "");
		returnMap.put("OUT_DS", "");
		
		if(inDsNames.size() > 0){
			inDsNm = inDsNames.get(0);
			returnMap.put("IN_DS", inDsNm);
		}	
		if(outDsNames.size() > 0){
			outDsNm = outDsNames.get(0);
			returnMap.put("OUT_DS", outDsNm);
		}
	
		return returnMap;		
	}
	
	public static  Map<String, String> getParamDataSet(Map<String, ?> param, String dsName) {
		
		Map<String, String> returnMap = new HashMap<String, String>();				
		
		List inputDSList = (List) param.get(dsName);		
		
		if(inputDSList.size() == 0) return returnMap;
						
		returnMap = (Map) inputDSList.get(0);		
					
		return returnMap;
	}

	public static String getParamData(Map<String, ?> param, String dsName, String colNm) {
						
		String value = "";					
		
		List inputDSList = (List) param.get(dsName);		

		if(inputDSList.size() == 0) return value;

		Map inputDS = (Map) inputDSList.get(0);		
		
		if(!inputDS.containsKey(colNm)) return value;

		value = (String) inputDS.get(colNm);					
		return value;
	}
	
	public static void setMsgCdToXDataSet(Map<String, Object>result, String MessageCode){
		
	}

	/**
	 * @author     : hoony
	 * @date        : 2014. 3. 10. 오후 3:28:17
	 * Method Description: 메시지 코드 처리
	* @param code xframe message code 
	* @param result dataset
	*/
	public static void setMessage(String messageCode,Map<String, Object> result) {		
			result.put("xframeCommonMessageCode", messageCode);				
	}

	/**
	 * @author     : hoony
	 * @date        : 2014. 3. 11. 오후 6:13:24
	 * Method Description: 메소드설명
	* @param param 
	*/
	public static String getUserId(Map<String, ?> param) {
		return (String) param.get("USER_ID");		
	}

	/**
	 * 
	 * @author     : hoony
	 * @date        : 2014. 3. 21. 오후 2:07:37
	 * Method Description: message_xx_XX.properties 에 정의된 코드에 해당하는 메시지를 리턴한다.
	* @param messageSource
	* @param errorCode message_xx_XX.properties 에 정의된 코드 (default: message_ko_KR.properties), Locale 변경: ISA0001SVC.ERROR_MESSAGE_LOCALE
	* @param appendMessage .properties 파일에 정의된 기본메시지에 추가로 덧붙일 메시지
	* @return String message
	 */
	public static String getErrorMessage(MessageSource messageSource,
			String errorCode, String appendMessage) {
		
		if(null==appendMessage) {
			appendMessage = "";			
		}
		appendMessage = messageSource.getMessage(errorCode, new String[] {appendMessage}, ISA0001SVC.ERROR_MESSAGE_LOCALE).toString();
		
		return appendMessage;		
	}
	
}

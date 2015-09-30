package com.korail.tz.sa;

import java.util.HashMap;
import java.util.Map;


//import org.slf4j.logger;

import cosmos.comm.dao.CommDAO;
import cosmos.comm.svc.ResultKeyExtractor;
import cosmos.comm.util.ActionMapKey;
import cosmos.comm.util.DataIdUtil;
//import cosmos.log.Cosmos//loggerFactory;


public class XframeCommSVC {

	//private final //logger //logger = Cosmos//loggerFactory.get//logger(this.getClass());
	private CommDAO dao;
	public void setCommDAO(CommDAO commDAO){
		this.dao = commDAO;
	}
	
	public Map<String, Object> list(String countSqlId, String listSqlId, Map<String, Object> param, String inDsNm, String outDsNm) {
		
		//logger.debug("list  inDsNm: "+inDsNm);
		//logger.debug("list  outDsNm: "+outDsNm);
		Map<String, Object> result = new HashMap<String, Object>();	
		Map<String, Object> daoParam = XframeControllerUtils.makeDaoParam(param, inDsNm);
		//logger.debug("list  daoParam: "+daoParam);
		result.put(outDsNm, dao.list(listSqlId, daoParam));

		return result;
	}
	public Object select(String sqlId, Map<String, Object> param, String inDsNm, String outDsNm){
		Map<String, Object> result = new HashMap<String, Object>();	
		
		Map<String, Object> daoParam = XframeControllerUtils.makeDaoParam(param, inDsNm);
		result.put(outDsNm, dao.list(sqlId, daoParam));
		
		return result;
	}

	public int create(String sqlId, Map<String, Object> param, String inDsNm){
		
		Map<String, Object> daoParam = XframeControllerUtils.makeDaoParam(param, inDsNm);
		return dao.insert(sqlId, daoParam);
	}
	public int delete(String sqlId, Map<String, Object> param, String inDsNm){
		Map<String, Object> daoParam = XframeControllerUtils.makeDaoParam(param, inDsNm);
		return dao.delete(sqlId, daoParam);
	}
	public int update(String sqlId, Map<String, Object> param, String inDsNm){
		Map<String, Object> daoParam = XframeControllerUtils.makeDaoParam(param, inDsNm);
		return dao.update(sqlId, daoParam);
	}

	//dataId를 넣기 위하여 Return Type  변경
	public Object listWithoutCount(String sqlId, Map<String, Object> param, String inDsNm, String outDsNm){
		//logger.debug("listWithoutCount  inDsNm: "+inDsNm);
		//logger.debug("listWithoutCount  outDsNm: "+outDsNm);
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, Object> daoParam = XframeControllerUtils.makeDaoParam(param, inDsNm);
		//logger.debug("listWithoutCount : "+daoParam);
		
		result.put(outDsNm, dao.list(sqlId, daoParam));

		return result;
		//		return dao.list(sqlId, param);
	}

	public Map<String, Object> multiList(String countSqlId[] , String[] sqlId, Map<String, Object>[] param){
		Map<String, Object> result = new HashMap<String, Object>();

		int sqlCount = sqlId.length;
		for (int i = 0; i < sqlCount ; i++) {

			if (i < countSqlId.length && countSqlId[i] != null && ! "".equals(countSqlId[i]) ) {
				result.put(ActionMapKey.RESULT_COUNT_KEY + i , dao.count(countSqlId[i], param[i]));
				result.put(ActionMapKey.COUNT_DATA_ID + i , DataIdUtil.getDatatId(countSqlId[i]));
			}

			result.put(ActionMapKey.RESULT_LIST_KEY + i , dao.list(sqlId[i], param[i]));
			result.put(ActionMapKey.DATA_ID + i , DataIdUtil.getDatatId(sqlId[i]));
		}
		return result;
	}

	public Map<String, Object> multiList(String countSqlId[] , String[] sqlId, Map<String, Object> param){
		Map<String, Object> result = new HashMap<String, Object>();

		int sqlCount = sqlId.length;
		for (int i = 0; i < sqlCount ; i++) {

			if (i < countSqlId.length && countSqlId[i] != null && ! "".equals(countSqlId[i]) ) {
				result.put(ActionMapKey.RESULT_COUNT_KEY + i , dao.count(countSqlId[i], param));
				result.put(ActionMapKey.COUNT_DATA_ID + i , DataIdUtil.getDatatId(countSqlId[i]));
			}

			result.put(ActionMapKey.RESULT_LIST_KEY + i , dao.list(sqlId[i], param));
			result.put(ActionMapKey.DATA_ID + i , DataIdUtil.getDatatId(sqlId[i]));
		}
		return result;
	}
	
	public Map<String, Object> multiList(String countSqlId[] , String[] sqlId, Map<String, Object> param, ResultKeyExtractor keyExtractor){
		Map<String, Object> result = new HashMap<String, Object>();
		
		int sqlCount = sqlId.length;
		for (int i = 0; i < sqlCount ; i++) {
			if (i < countSqlId.length && countSqlId[i] != null && ! "".equals(countSqlId[i]) ) {
				result.put(keyExtractor.extract(countSqlId[i]).replace(".", "_") , dao.count(countSqlId[i], param));
			}
			
			result.put(keyExtractor.extract(sqlId[i]).replace(".", "_"), dao.list(sqlId[i], param));
		}
		return result;
	}
	

}

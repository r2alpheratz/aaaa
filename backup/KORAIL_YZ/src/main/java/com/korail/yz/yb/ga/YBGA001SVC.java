/**
 * project : KORAIL_YZ
 * package : com.korail.yz.yb.ga
 * date : 2014. 7. 9.오전 10:32:55
 */
package com.korail.yz.yb.ga;


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
 * @author 한현섭
 * @date 2014. 7. 9. 오전 10:32:55
 * Class description : 
 */
/**
 * @author 한현섭
 * @date 2014. 7. 9. 오전 10:33:47
 * Class description : 
 */
@Service("com.korail.yz.yb.ga.YBGA001SVC")
public class YBGA001SVC {

	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public  final Logger LOGGER = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
 
	
	/**
	 * @author 한현섭
	 * @date 2014. 7. 9. 오전 10:48:59
	 * Method description :  열차별 작업수행현황 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?>  selectListJobAchvPstt(Map<String, ?> param){
	
 		/* 리턴 오브젝트 */
		
		Map<String, Object> result = new HashMap<String, Object>();
		//List<Map<String, Object>> resultList;
		//Map<String, Map<String, Object>> resultMap = new HashMap<String, Map<String, Object>>();
		
		/* 입력 오브젝트 */
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsGrdCond");
		
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		if("".equals(trnOprBzDvCd) || trnOprBzDvCd == null){
			trnOprBzDvCd = "000";
		}
		inputDataSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		
		/* DAO - 쿼리 실행 후 결과 획득*/
		List<Map<String, Object>> qryResultList
		= (List<Map<String, Object>>) dao.list("com.korail.yz.yb.ga.YBGA001QMDAO.selectListJobAchvPstt", inputDataSet);

		//error 메시지 날리기
		if(qryResultList.isEmpty()){
			XframeControllerUtils.setMessage("IZZ000004", result);
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result);
		}
		
		
		/*Map<String, Object> tempMap;
		for(Map<String, Object> qryDataSet : qryResultList)
		{
			
			String trnNo = (String) qryDataSet.get("TRN_NO");
			String runInfo = (String) qryDataSet.get("RUN_INFO");
			String ymsAplFlg = (String) qryDataSet.get("YMS_APL_FLG");
			
			String rMapKey = trnNo + "|" +  runInfo + "|" + ymsAplFlg;
			
			tempMap = resultMap.get(rMapKey);
			
			if(tempMap == null)
			{
				tempMap = new HashMap<String, Object>();
				
			}
			tempMap.putAll(qryDataSet);
			resultMap.put(rMapKey, tempMap);
		}
		resultList = new ArrayList<Map<String,Object>>(resultMap.values());*/
		result.put("dsGrdList", qryResultList);
		return result;
	}

}

/**
 * project : KORAIL_YZ
 * package : com.korail.yz.yp.aa
 * date : 2014. 8. 4.오후 7:41:34
 */
package com.korail.yz.yp.aa;

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
 * @date 2014. 8. 4. 오후 7:41:34
 * Class description : 
 */
@Service("com.korail.yz.yp.aa.YPAA006SVC")
public class YPAA006SVC {
	
	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public  final Logger LOGGER = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
 
	/**
	 * @author 한현섭
	 * @date 2014. 8. 7. 오전 9:05:11
	 * Method description : 최적화 구역구간 할당결과 운행일자별 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?>  selectListAchvDtPrQry(Map<String, ?> param){
	
 		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();

		/* 입력 오브젝트 */
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsGrdCond");
		
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		if("".equals(trnOprBzDvCd) || trnOprBzDvCd == null){
			trnOprBzDvCd = "000";
		}
		inputDataSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		
		/* DAO - 쿼리 실행 후 결과 획득*/
		ArrayList<Map<String, Object>> resultList
		= (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.yp.aa.YPAA006QMDAO.selectListAchvDtPrQry", inputDataSet);

		//error 메시지 날리기
		if(resultList.isEmpty()){
			XframeControllerUtils.setMessage("IZZ000004", result);
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result);
		}
		result.put("dsGrdList", resultList);
		return result;
	}
}

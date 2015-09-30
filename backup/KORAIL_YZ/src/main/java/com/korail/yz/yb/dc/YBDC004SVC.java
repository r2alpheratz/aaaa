/**
 * project : KORAIL_YZ
 * package : com.korail.yz.yb.dc
 * date : 2014. 4. 19.오후 5:20:16
 */
package com.korail.yz.yb.dc;

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
 * @date 2014. 4. 19. 오후 5:20:16
 * Class description : 운행일시 또는 운행기간에 해당하는 열차정보 조회용 일일열차정보관리 Service 클래스
 */
@Service("com.korail.yz.yb.dc.YBDC004SVC")
public class YBDC004SVC {
	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public  final Logger logger = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
	
	@SuppressWarnings("unchecked")
	public Map<String, ?>  selectListDlyTrnInfo (Map<String, ?> param){
		
		
		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsDlyTrnLstCond");
		
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		if("".equals(trnOprBzDvCd) || trnOprBzDvCd == null){
			trnOprBzDvCd = "000";
		}
		inputDataSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		
		/* DAO - 쿼리 실행 후 결과 획득*/
		ArrayList<Map<String, Object>> resultList
		= (ArrayList<Map<String, Object>>) dao.list("com.korail.yz.yb.dc.YBDC004QMDAO.selectListDlyTrnInfo", inputDataSet);
		
		//error 메시지 날리기
		if(resultList.isEmpty()){
			XframeControllerUtils.setMessage("IZZ000004", result);
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result);
		}
		result.put("dsDlyTrnLstResult", resultList);
		return result;
	}
}
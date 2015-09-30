/**
 * project : KORAIL_YZ
 * package : com.korail.yz.yp.db
 * date : 2014. 8. 14.오전 10:55:51
 */
package com.korail.yz.yp.db;

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
 * @author EQ
 * @date 2014. 8. 14. 오전 11:17:51
 * Class description : 최적화시뮬레이션조회SVC
 * 예약/취소 시뮬레이션 결과를 검토하고, 예측 승차율에 따른 
 * 할당 해지시점 또는 미적용 여부를 판단 하는 기능을 제공하는 Service 클래스
 */
@Service("com.korail.yz.yp.db.YPDB001SVC")
public class YPDB001SVC {
	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public  static final Logger  LOGGER = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
	
	
	/**
	 * 수요예측/최적화 할당정보 조회
	 * @author 김응규
	 * @date 2014. 7. 28. 오전 11:19:00
	 * Method description : 수요예측/최적화 할당정보를 조회한다.
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map<String, ?> selectListDmdFcstOptAlcInfoQry(Map<String, ?> param) {		

		Map<String, Object> result = new HashMap<String, Object>();

		LOGGER.debug("param ==> "+param);
		// search input column dataset
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsCond");	
		LOGGER.debug("inputDataSet ==>  " + inputDataSet);
		
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		if("".equals(trnOprBzDvCd) || trnOprBzDvCd == null){
			trnOprBzDvCd = "000";
		}
		inputDataSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		
		//수요예측 최적화할당 정보조회
		ArrayList<Map<String, Object>> resultList = (ArrayList) dao.list("com.korail.yz.yp.db.YPDB001QMDAO.selectListDmdFcstOptAlcInfoQry", inputDataSet);
		
		//예약/취소 패턴 차트 조회
		ArrayList<Map<String, Object>> chtList = (ArrayList) dao.list("com.korail.yz.yp.db.YPDB001QMDAO.selectListRsvCncPtrnCht", inputDataSet);
		
		
		//구간공급 좌석 (일반좌석) 조회
		Map<String, Object> bsSeatNumMap = (Map<String, Object>) dao.select("com.korail.yz.yp.db.YPDB001QMDAO.selectBsSeatNum", inputDataSet);
		
		LOGGER.debug("구간공급 좌석 수 ::::::"+bsSeatNumMap.get("BS_SEAT_NUM"));
		inputDataSet.put("BS_SEAT_NUM", String.valueOf(bsSeatNumMap.get("BS_SEAT_NUM")));
		
		//구간 통과율 정보 조회
		ArrayList<Map<String, Object>> segNstpRtInfoList = (ArrayList) dao.list("com.korail.yz.yp.db.YPDB001QMDAO.selectListSegNstpRtInfo", inputDataSet);
		
		//메시지 처리
		if(resultList.isEmpty())
		{
			XframeControllerUtils.setMessage("IZZ000004", result); //해당 조건의 자료가 존재하지 않습니다.
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result); //정상적으로 조회 되었습니다.
		}
		result.put("dsSegNstpRt", segNstpRtInfoList);
		result.put("dsCht", chtList);
		result.put("dsList", resultList);
		
		return result;

	}
}

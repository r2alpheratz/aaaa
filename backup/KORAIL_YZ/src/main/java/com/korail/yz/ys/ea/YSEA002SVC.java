/**
 * project : KORAIL_YZ
 * package : com.korail.yz.ys.ea
 * date : 2014. 5. 27.오전 9:39:25
 */
package com.korail.yz.ys.ea;


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
 * @date 2014. 5. 27. 오전 9:39:25
 * Class description : 할인표 기준관리
 */
@Service("com.korail.yz.ys.ea.YSEA002SVC")
public class YSEA002SVC {
	

	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public  final Logger LOGGER = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
 
	
	/**
	 * @author 한현섭
	 * @date 2014. 6. 4. 오후 1:03:26
	 * Method description : 
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?>  selectListDcntRtStdr (Map<String, ?> param){
	
 		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();

		/* 입력 오브젝트 */
		Map<String, String> inputDataSet = XframeControllerUtils	.getParamDataSet(param, "dsGrdCond");
		//열차운영사업자구분코드 추가
		String trnOprBzDvCd = XframeControllerUtils.getParamData(param, "GDS_USER_INFO", "TRN_OPR_BZ_DV_CD");
		inputDataSet.put("TRN_OPR_BZ_DV_CD", trnOprBzDvCd);
		LOGGER.debug("inputDateSet--->"+inputDataSet);

		/* DAO - 쿼리 실행 후 결과 획득*/
		List<Map<String, Object>> resultList
		= (List<Map<String, Object>>) dao.list("com.korail.yz.ys.ea.YSEA002QMDAO.selectListDcntRtStdr", inputDataSet);

		for(int i=0;i<resultList.size() ;i++)
		{
			LOGGER.debug(resultList.get(i).toString());
		}
		//error 메시지 날리기
		if(resultList.isEmpty()){
			XframeControllerUtils.setMessage("IZZ000004", result);
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result);
		}
		result.put("dsGrdResult", resultList);
		result.put("dsGrdStat", resultList);
		return result;
	}

	
	
	/**
	 * @author 한현섭
	 * @date 2014. 6. 4. 오후 1:03:28
	 * Method description : 할인율 기준관리
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ?>  updateDcntRtStdr(Map<String, ?> param){
		
		/* 리턴 오브젝트 */
		Map<String, Object> result = new HashMap<String, Object>();
		
		/* 입력 오브젝트 */
		List<Map<String, String>> inputDataArray = (List<Map<String, String>>) param.get("dsCudCond");
		
		LOGGER.debug("inputDateSet--->"+inputDataArray);
		
				
		/* DAO - For Loop으로 각 행을 입력/수정/ 삭제 처리하는 쿼리 실행- PK문제로 수정과 삭제를 먼저 실행하고 입력을 실행*/
		try{
			//삭제		
			for (Map<String, ?> inputDataSet : inputDataArray)
			{
				String stat = (String) inputDataSet.get("STAT");
				if("D".equals(stat))
				{
					dao.delete("com.korail.yz.ys.ea.YSEA002QMDAO.deleteDcntRtStdr",inputDataSet);
				}
				
			}
			//수정
			for (Map<String, ?> inputDataSet : inputDataArray)
			{
				String stat = (String) inputDataSet.get("STAT");
				if("U".equals(stat)){
					dao.update("com.korail.yz.ys.ea.YSEA002QMDAO.updateDcntRtStdr",inputDataSet);
				}
			}
			//입력
			for (Map<String, ?> inputDataSet : inputDataArray)
			{
				String stat = inputDataSet.get("STAT").toString();
				if("I".equals(stat)){
					dao.insert("com.korail.yz.ys.ea.YSEA002QMDAO.insertDcntRtStdr",inputDataSet);
				}
			}		
		}catch(Exception e)
		{
			XframeControllerUtils.setMessage("EZZ000018", result);
		}
		
		XframeControllerUtils.setMessage("IZZ000013", result);
		return result;
	}
}

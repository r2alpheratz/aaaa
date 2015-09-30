/**
 * project : KORAIL_YZ
 * package : com.korail.yz.ys.ed
 * date : 2014. 7. 8.오후 1:35:51
 */
package com.korail.yz.ys.ed;

import java.math.BigDecimal;
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
import cosmos.comm.exception.CosmosRuntimeException;

/**
 * @author EQ
 * @date 2014. 7. 8. 오후 1:35:51
 * Class description : 임시열차유형관리SVC
 * 임시열차 유형 관리를 위한 Service 클래스
 */
@Service("com.korail.yz.ys.ed.YSED002SVC")
public class YSED002SVC {
	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public  static final Logger  LOGGER = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
	

	/**
	 * 임시열차 유형관리조회
	 * @author 김응규
	 * @date 2014. 7. 7. 오후 5:36:00
	 * Method description : 임시열차의 구분을 위해 유형을 분류하여 관리한다.
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public Map<String, ?> selectListTtrnTpMg(Map<String, ?> param) {		

		Map<String, Object> result = new HashMap<String, Object>();

		LOGGER.debug("param ==> "+param);
		
		
		//임시열차유형관리 조회
		ArrayList<Map<String, Object>> resultList = (ArrayList) dao.list("com.korail.yz.ys.ed.YSED002QMDAO.selectListTtrnTpMg", null);

		//메시지 처리
		if(resultList.isEmpty())
		{
			XframeControllerUtils.setMessage("IZZ000004", result); //해당 조건의 자료가 존재하지 않습니다.
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result); //정상적으로 조회 되었습니다.
		}
		result.put("dsList", resultList);
		
		return result;

	}
	/**
	 * 임시열차 유형관리 수정
	 * @author 김응규
	 * @date 2014. 7. 7. 오후 5:36:00
	 * Method description : 임시열차 유형을 입력/수정/삭제 처리한다.
	 * @param param
	 * @return
	 */
	@SuppressWarnings({ "unchecked" })
	public Map<String, ?> updateTtrnTpMg(Map<String, ?> param) {		

		Map<String, Object> result = new HashMap<String, Object>();

		LOGGER.debug("param ==> "+param);
		
		ArrayList<Map<String, String>> ttrnTpList = (ArrayList<Map<String, String>>) param.get("dsList");
		
		String userId = String.valueOf(param.get("USER_ID"));
		
		int insertCnt = 0;
		int updateCnt = 0;
		int deleteCnt = 0;
		
		LOGGER.debug("ttrnTpList 사이즈:::::::::::::::"+ttrnTpList.size());
	    for( int i = 0; i < ttrnTpList.size() ; i++ )
	    {
	    	Map<String, String> item = ttrnTpList.get(i);
	    	
	    	LOGGER.debug("dsAbvCausList["+i+"]번째 ROW =====>"+item);
	    	item.put("USER_ID", userId);	    	
	    	
	    	
	        if(item.get("DMN_PRS_DV_CD").equals("I"))  /*요청처리구분코드가 I : insert*/
	        {
	        	/* [SQL] 기존 등록된 임시열차 유형이 있는지 확인. */
	        	HashMap<String, BigDecimal> ttrnTpCntMap = (HashMap<String, BigDecimal>) dao.select("com.korail.yz.ys.ed.YSED002QMDAO.selectTtrnTpCnt", item);
	        	if(ttrnTpCntMap.get("QRY_CNT").intValue() > 0)
		    	{
	        		throw new CosmosRuntimeException("WZZ000013", null); 
					//이미 등록된 내역이 존재합니다.  입력값을 확인하십시오. 
		    	}
	        	insertCnt += dao.insert("com.korail.yz.ys.ed.YSED002QMDAO.insertTtrnTpMg", item);
	        }
	        else if(item.get("DMN_PRS_DV_CD").equals("U"))  /*요청처리구분코드가 U : update*/
	        {
	        	updateCnt += dao.update("com.korail.yz.ys.ed.YSED002QMDAO.updateTtrnTpMg", item);	
	        }
	        else if(item.get("DMN_PRS_DV_CD").equals("D"))  /*요청처리구분코드가 D : delete*/
	        {
	        	deleteCnt += dao.delete("com.korail.yz.ys.ed.YSED002QMDAO.deleteTtrnTpMg", item);
	        }
	    }
	    LOGGER.debug("입력 ["+insertCnt+"] 건, 수정 ["+updateCnt+"] 건, 삭제 ["+deleteCnt+"] 건 수행하였습니다.");
	    
		//메시지 처리
  		if(insertCnt < 1 && updateCnt < 1 && deleteCnt < 1){
  			XframeControllerUtils.setMessage("WYZ000007", result); //해당 자료를 수정할수 없습니다.	수정자료를 확인하여 주십시오.
  		}
  		else
  		{
  			XframeControllerUtils.setMessage("IZZ000013", result); //정상적으로 저장 되었습니다.
  		}
  		
		return result;

	}
}

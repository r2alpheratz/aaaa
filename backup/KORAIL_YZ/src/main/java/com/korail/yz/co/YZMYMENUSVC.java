/**
 * project : KORAIL_YZ
 * package : com.korail.yz.co
 * date : 2014. 6. 16.오후 1:53:05
 */
package com.korail.yz.co;

import java.io.IOException;
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
 * @author "Changki.woo"
 * @date 2014. 6. 16. 오후 1:53:05
 * Class description : 
 */
@Service("com.korail.yz.co.YZMYMENUSVC")

public class YZMYMENUSVC {
	
	@Resource(name = "commDAO")
	private CommDAO dao;
		
	@Resource(name="messageSource")
	MessageSource messageSource;
	
	public  final Logger logger = Logger.getLogger(ISA0001SVC.LOGGER_NAME_COM_KORAIL);
	
	/**
	 * @author "Changki.woo"
	 * @date 2014. 6. 16. 오후 1:55:00
	 * Method description : 나의 메뉴 조회
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, ? > selectListMyMenu(Map<String, ?> param){
		
		/* DATASET NAME: dsMyMenu
		 * DATASET COLUMNS:
		 * TRVL_USR_ID : 여객사용자ID
		 * TRVL_MENU_ID : 메뉴ID
		 * DMN_PRS_DV_CD : 요청처리구분코드 (I:등록, D:삭제)
		 * TRVL_SCN_URL_ADR : 여객화면URL주소
		 * */
		
		Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> getParamSet  = XframeControllerUtils.getParamDataSet(param, "dsMyMenu");
		
		List<Map<String, Object>> resultList = null;
		
		String svcUrl = "com.korail.yz.comm.COMMQMDAO.selectListMyMenuList";
		
		resultList = (List<Map<String, Object>>) dao.list(svcUrl, getParamSet);
		
		result.put("dsList", resultList);
		result.put("dsCht", resultList);		
		
		if(resultList.size() < 1)
		{
			XframeControllerUtils.setMessage("IZZ000004", result); //해당 조건의 자료가 존재하지 않습니다.
		}
		else
		{
			XframeControllerUtils.setMessage("IZZ000009", result);
		}
		
		return result;
		
	}
	
	/**
	 * @author "Changki.woo"
	 * @date 2014. 6. 16. 오후 1:55:00
	 * Method description : 나의 메뉴 조회
	 * @param param
	 * @return
	 * @throws Exception 
	 */
	public Map<String, ?>updateMyMenu(Map<String, ?> param) throws Exception{
		
		/* DATASET NAME: dsMyMenu
		 * DATASET COLUMNS:
		 * TRVL_USR_ID : 여객사용자ID
		 * TRVL_MENU_ID : 메뉴ID
		 * DMN_PRS_DV_CD : 요청처리구분코드 (I:등록, D:삭제)
		 * TRVL_SCN_URL_ADR : 여객화면URL주소
		 * */
		
		/*
		 * 추가 필요요소
		 * YMGT_PGM_NM 프로그램명?
		 * REQ_SQNO 등록일련번호. (selectMaxRegSqno 수행후 가져옴)
		 * 
		 * */
		 Map<String, Object> result = new HashMap<String, Object>();
		Map<String, String> paramDs  = XframeControllerUtils.getParamDataSet(param, "dsMyMenu");
		
		String opCode = paramDs.get("DMN_PRS_DV_CD").toUpperCase();
		String urlAdr = paramDs.get("TRVL_SCN_URL_ADR");
		
		//삽입
		if("I".equals( opCode ))
		{
			//1. 이미 마이메뉴에 등록되있는지 확인한다.
			
			Map<String, Object > retMap = selectMaxRegSqno( paramDs );
			
			String regSqno    = retMap.get("REG_SQNO").toString();
			String checkExist = retMap.get("CHECK_EXISTS").toString();
			
			//paramDs에 등록일련번호 PUT
			paramDs.put("REG_SQNO", regSqno);
			
			if("Y".equals(checkExist))
			{
				//이미 있는 메뉴
				throw new BizLogicException("이미 등록된 메뉴입니다.");
			}
			
			if(urlAdr.length() == 0)
			{	
				//등록할 수 없는 메뉴항목입니다.
				throw new BizLogicException("등록할 수 없는 메뉴항목입니다.");
			}
			
			//2. 마이페이지그룹이 있나없나 확인한다.
			Map<String,Object> retMyPgGrpYnMap = selectMyPgGrpYn(paramDs);
			
			if(!retMyPgGrpYnMap.containsKey("MYPGGRPYN"))
			{
				insertMyPageGrpList(paramDs);
			}
			//3. 나의메뉴를 등록한다.
			insertMyPageMenuList(paramDs);
	
			// 종료
			
			
		}
		//삭제
		else if ("D".equals( opCode ))
		{
			//1. 나의 메뉴 삭제.
			deleteMyPgMenuList(paramDs);
			
			//2. 삭제후 마이페이지 그룹 내역이 있나 확인.
			int munuCnt = selectMyPgMenuCount(paramDs);
			
			//다 삭제되서 남은 메뉴가 0개다 하면
			if(munuCnt < 1)
			{
				deleteMyPgGrpList(paramDs);
			}
			
			// 종료
			
		}
		else
		{
			
			//do-nothing..
			return result;
		}
			
		return result;
	}
	
	/**
	 * @author "Changki.woo"
	 * @date 2014. 6. 16. 오후 4:32:09
	 * Method description : 마이페이지그룹내역을 등록한다.
	 * @param inDs
	 * @return
	 */
	public int insertMyPageGrpList(Map<String, ?> inDs) throws Exception{
		
		//TRVL_USR_ID
		//YMGT_PGM_NM 필요
		String svcUrl = "com.korail.yz.comm.COMMQMDAO.insertMyPgGrpList";
		
		int retCode =  dao.update(svcUrl, inDs);
		
		if(retCode < 0 )
		{
			throw new IOException("insert Failure ::::::: method = 'myPageGrpList' ");
		}
		
		return retCode;
	}
	
	/**
	 * @author "Changki.woo"
	 * @date 2014. 6. 16. 오후 4:31:52
	 * Method description : 마이페이지메뉴내역을 등록한다. 
	 * @param inDs
	 * @return
	 */
	public int insertMyPageMenuList(Map<String, ?> inDs) throws Exception{
		
		//TRVL_USR_ID
		//YMGT_PGM_NM
		//YMGT_PGM_URL_ADR
        //REQ_SQNO 필요
		String svcUrl = "com.korail.yz.comm.COMMQMDAO.insertMyPgMenuList";
		
		int retCode =  dao.update(svcUrl, inDs);
		
		if(retCode < 0 )
		{
			throw new IOException("insert Failure ::::::: method = 'myPageMenuList' ");
		}
		
		return retCode;
	}

	/**
	 * @author "Changki.woo"
	 * @date 2014. 6. 16. 오후 4:31:39
	 * Method description : 마이페이지그룹 유무를 조회한다.
	 * @param inDs
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectMyPgGrpYn(Map<String, ?> inDs){
		
		//TRVL_USR_ID
		//YMGT_PGM_NM
		//YMGT_PGM_URL_ADR
        //REQ_SQNO 필요
		String svcUrl = "com.korail.yz.comm.COMMQMDAO.selectMyPgGrpYnQry";
		
		Map<String, Object> retMap =  (Map<String, Object>) dao.select(svcUrl, inDs);
		
		return retMap;
	}
	
	/**
	 * @author "Changki.woo"
	 * @date 2014. 6. 16. 오후 4:32:59
	 * Method description : 등록된 마이페이지메뉴 갯수를 조회한다.
	 * @param inDs
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public int selectMyPgMenuCount(Map<String, ?> inDs){
		
		//TRVL_USR_ID
		//YMGT_PGM_NM
		//YMGT_PGM_URL_ADR
        //REQ_SQNO 필요
		String svcUrl = "com.korail.yz.comm.COMMQMDAO.selectMyPgMenuCountQry";
		
		Map<String, Object> retMap =  (Map<String, Object>) dao.select(svcUrl, inDs);
		int count = Integer.parseInt(retMap.get("COUNT").toString());
		
		return count;
	}
	
	/**
	 * @author "Changki.woo"
	 * @date 2014. 6. 17. 오전 9:21:09
	 * Method description : 등록된 마이페이지메뉴내역을 삭제한다.
	 * @param inDs
	 * @return
	 * @throws Exception
	 */
	public int deleteMyPgMenuList(Map<String, ?> inDs) throws Exception{
		
		//TRVL_USR_ID
		//YMGT_PGM_NM
		//YMGT_PGM_URL_ADR
        //REQ_SQNO 필요
		String svcUrl = "com.korail.yz.comm.COMMQMDAO.deleteMyPgMenuList";
		
		int retCode = dao.update(svcUrl, inDs);
		
		if(retCode < 0 )
		{
			throw new IOException("delete failure ::::::: method = 'deleteMyPgMenuList' ");
		}
		
		return retCode;
	}
	
	
	/**
	 * @author "Changki.woo"
	 * @date 2014. 6. 17. 오전 9:21:33
	 * Method description : 등록된 마이페이지그룹내역을 삭제한다.
	 * @param inDs
	 * @return
	 * @throws Exception
	 */
	public int deleteMyPgGrpList(Map<String, ?> inDs) throws Exception{
		
		//TRVL_USR_ID
		//YMGT_PGM_NM
		//YMGT_PGM_URL_ADR
        //REQ_SQNO 필요
		String svcUrl = "com.korail.yz.comm.COMMQMDAO.deleteMyPgGrpList";
		
		int retCode = dao.update(svcUrl, inDs);
		
		if(retCode < 0 )
		{
			throw new IOException("delete failure ::::::: method = 'deleteMyPgGrpList' ");
		}
		
		return retCode;
	}
	
	/**
	 * @author "Changki.woo"
	 * @date 2014. 6. 17. 오전 9:21:50
	 * Method description : 등록일련번호와 이미 내 마이메뉴에 등록된 화면인지 확인한다.
	 * @param inDs
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectMaxRegSqno(Map<String, ?> inDs){
		
		//TRVL_USR_ID
		//YMGT_PGM_NM
		//YMGT_PGM_URL_ADR
        //REQ_SQNO 필요
		String svcUrl = "com.korail.yz.comm.COMMQMDAO.selectMaxRegSqnoQry";
		
		Map<String, Object> retMap =  (Map<String, Object>) dao.select(svcUrl, inDs);
		
		return retMap;
	}
	
	
	
	
	
	
}

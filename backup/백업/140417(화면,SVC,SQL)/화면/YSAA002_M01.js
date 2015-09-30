/*
** =================================================================================================
** 시 스 템 명 : YZ (수익관리)
** 화  면  ID : YSAA002_M01
** 화  면  명 : 수익관리대상열차 일별분석
** 개      요 : 수익관리작업 현황을 파악하고 수익관리대상열차의 분석상태를 처리한다.
** ================================================================================================= 
** << 변경 정보 >>
** -------------------------------------------------------------------------------------------------
** 변 경 일 자  : 변경자 : 변	경	내	역
** -------------------------------------------------------------------------------------------------
** 2014-03-27 : 김응규 : 신규작성
** YYYY-MM-DD :       
** =================================================================================================
*/

/* 
** ========================================================================
** 1. 전역 변수 영역
** ======================================================================== 
*/

var m_yzmod 	  = KRI.getTeamModule(screen, "YZ", "YZCmmnUtil");

var m_today 	  = KRUtil.TodayDate(screen); 			/* 오늘 날짜 전역변수		*/
var m_runTrmStDt  = KRUtil.addDateFromYYYYMMDD(m_today, 1); /* 운행기간시작일자 기본값	*/
var m_runTrmClsDt = KRUtil.addDateFromYYYYMMDD(m_today, 2); /* 운행기간종료일자 기본값	*/

/*
** ========================================================================
** 2. 화면 이벤트 영역
** ========================================================================
*/

/*
* 화면 온로드
*/ 
function screen_on_load()
{
	KRI.init(screen);	// 화면 초기화 (필수)
	

	/* 화면 로드시 작업일자별 조회를 기본으로 셋팅 */
	rdoJOB_DT_SRCH.setcheck(true);
	
	
	/*모든 콤포넌트 초기화 셋팅*/
	fn_init();
	
	/* 주운행선/노선 데이터셋 셋팅 */
	/* xDataSet 초기화 */	
	dsMrntList.init();
	dsRoutList.init();
	dsObjCond.insertrow(0);
	dsObjCond.setdatabyname(0, "MRNT", "1");
	dsObjCond.setdatabyname(0, "ROUT", "1");
	KRI.requestSubmit(screen,"/yz/yb/co/selectListObject.do",true);
	
		
	
}

/*
* 스크린 사이즈 변경시
*/ 
function screen_on_size(window_width, window_height)
{
	KRI.processResize(screen, window_width, window_height);
}

/* 
* submit 완료시 호출
*/
function screen_on_submitcomplete(mapid, result, recv_userheader, recv_code, recv_msg)
{
	if (KRI.submitComplete(screen, mapid, result, recv_userheader, recv_code, recv_msg) == false) return;
	
	if (mapid == "/yz/yb/co/selectListObject.do") /*주운행선/노선 전체조회 및 수익관리 담당자목록 조회*/
	{
		cboMRNT.setselectedindex(0);
		cboROUT.setselectedindex(0);
		cboMRNT2.setselectedindex(0);
		cboROUT2.setselectedindex(0);
		KRI.setTranMessage(screen, 0, "화면이 로딩 되었습니다.");
	}
	else if (mapid == "/yz/ys/aa/selectListYmgtTgtTrnDdprAnalJobDt.do")
	{
		var nRowCnt = grdListJobDt.getrowcount();
		if(nRowCnt > 0)
		{
			fldQRY_CNT.setvisible(true);
			fldQRY_CNT.settext("총 "+nRowCnt+"건");
			btnExcel.setenable(true);
			btnTrnPrFcstAcvmAbrdPrnb.setenable(true);
			btnAlcCnqeQry.setenable(true); /* 할당결과조회버튼 */
			/*조회결과 메시지*/
			KRI.setTranMessage(screen, 0, "정상적으로 조회 되었습니다.");
		}
		else /* 조회결과가 0건이면 */
		{
			btnExcel.setenable(false);
			btnTrnPrFcstAcvmAbrdPrnb.setenable(false);
			btnAlcCnqeQry.setenable(false); /* 할당결과조회버튼 */
			
			fldQRY_CNT.setvisible(false);
			fldQRY_CNT.settext("");
			KRI.setTranMessage(screen, 0, "조회할 자료가 없습니다.");
			
		}
		fldQRY_CNT2.setvisible(false);
		fldQRY_CNT2.settext("");
				
	}
	else if (mapid == "/yz/ys/aa/selectListYmgtTgtTrnDdprAnalRunDt.do")
	{
		var nRowCnt = grdListRunDt.getrowcount();
		if(nRowCnt > 0)
		{
			fldQRY_CNT2.setvisible(true);
			fldQRY_CNT2.settext("총 "+nRowCnt+"건");
			/*수익관리할당처리상태(예발) 컬럼값 "반영제외"인 경우 빨간색 표시*/
			fn_setGridColor(grdListRunDt, dsListRunDt);
			btnExcel.setenable(true);
			btnTrnPrFcstAcvmAbrdPrnb.setenable(true);
			btnAlcCnqeQry.setenable(true); /* 할당결과조회버튼 */

			
			/*조회결과 메시지*/
			KRI.setTranMessage(screen, 0, "정상적으로 조회 되었습니다.");
		}
		else /* 조회결과가 0건이면 */
		{
			fldQRY_CNT2.setvisible(false);
			fldQRY_CNT2.settext("");
			btnExcel.setenable(false);
			btnTrnPrFcstAcvmAbrdPrnb.setenable(false);
			btnAlcCnqeQry.setenable(false); /* 할당결과조회버튼 */
			KRI.setTranMessage(screen, 0, "조회결과가 없습니다.");		
		}
		fldQRY_CNT.setvisible(false);
		fldQRY_CNT.settext("");
	}
}

/*
** ========================================================================
** 3. 필수 구현 함수 영역
** ========================================================================
*/

/*
* 화면이 리사이징 될때 변동될 컨트롤정보를 등록한다.
*/
function processResize()
{
//	KRI.addResize(pnlCondition, KRConstant.CST_DIRECTION_HORZ);
//	KRI.addReposition(pnlSearch, KRConstant.CST_DIRECTION_HORZ);
//	KRI.addResize(OUTREC1_GRID, KRConstant.CST_DIRECTION_BOTH);
}


/*
** ========================================================================
** 4. 사용자 정의 함수 영역
** ========================================================================
*/
function fn_init()
{
	/*작업일자, 요일 오늘일자로 셋팅*/
	fldJOB_DT.settext(m_today);
	m_yzmod.fn_setDayField(fldJOB_DT, txtJobDay);
	/* 운행기간셋팅 (내일~모레)*/ 
	fldRUN_TRM_ST_DT.settext(m_runTrmStDt);
	fldRUN_TRM_CLS_DT.settext(m_runTrmClsDt);
	m_yzmod.fn_setDayField(fldRUN_TRM_ST_DT, txtFromDay);
	m_yzmod.fn_setDayField(fldRUN_TRM_CLS_DT, txtToDay);
	
	cboSTLB_TRN_CLSF_CD.setselectedcode("00");//KTX -기본 셋팅
	cboSTLB_TRN_CLSF_CD2.setselectedcode("00");//KTX -기본 셋팅

	
	/* 상하행구분코드 -상하행- 기본셋팅 */
	cboUP_DN_DV_CD.setselectedindex(0);
	cboUP_DN_DV_CD2.setselectedindex(0);
	
	/*운행일자, 요일 오늘일자로 셋팅*/
	fldRUN_DT.settext(m_today);
	m_yzmod.fn_setDayField(fldRUN_DT, txtDay);

	cboMRNT.setselectedindex(0);
	cboROUT.setselectedindex(0);
	cboMRNT2.setselectedindex(0);
	cboROUT2.setselectedindex(0);

	/* GRID CLEAR */
	KRI.setGridMode(screen, grdListJobDt, KRConstant.GRID_CLEAR);
	KRI.setGridMode(screen, grdListRunDt, KRConstant.GRID_CLEAR);
    /* xDataSet 초기화 */	
	dsListJobDt.init();
	dsListRunDt.init();
	/* 총건수 초기화 */
	fldQRY_CNT.settext("");
	fldQRY_CNT2.settext("");
	fldQRY_CNT.setvisible(false);
	fldQRY_CNT2.setvisible(false);
	
	fldTRN_NO.settext("");
	
	btnExcel.setenable(false);
	btnTrnPrFcstAcvmAbrdPrnb.setenable(false);
}
/* 작업일자별 조회 */
function fn_searchJobDt()
{
    /* GRID CLEAR */
	KRI.setGridMode(screen, grdListJobDt, KRConstant.GRID_CLEAR);
	KRI.setGridMode(screen, grdListRunDt, KRConstant.GRID_CLEAR);
    /* xDataSet 초기화 */	
	dsListJobDt.init();
	dsListRunDt.init();
	
	KRI.requestSubmit(screen,"/yz/ys/aa/selectListYmgtTgtTrnDdprAnalJobDt.do",true);

	
    /* 조회 중 중단 가능하도록 화면에 포커스를 지정 */
	screen.setfocus();
}
/*작업일자별 조회 validation Check*/
function validCheckJobDt()
{
	if(fldJOB_DT.gettext() == "")
	{
		KRI.alert(screen, "날짜를 입력하세요");
		fldJOB_DT.setfocus();
		return false;
	}
	if(fldRUN_TRM_ST_DT.gettext() == "")
	{
		KRI.alert(screen, "날짜를 입력하세요");
		fldRUN_TRM_ST_DT.setfocus();
		return false;
	}
	if(fldRUN_TRM_CLS_DT.gettext() == "")
	{
		KRI.alert(screen, "날짜를 입력하세요");
		fldRUN_TRM_CLS_DT.setfocus();
		return false;
	}
	if(!KRUtil.checkPeriodDate(fldRUN_TRM_ST_DT.gettext(), fldRUN_TRM_CLS_DT.gettext(), "YYYYMMDD", true))
	{
	    KRI.alert(screen, "조회시작일자가 조회종료일자보다 클 수 없습니다.");
		fldRUN_TRM_ST_DT.setfocus();
		return false; 
	}
	return true;
}

/* 작업일자별 조회 */
function fn_searchRunDt()
{
    /* GRID CLEAR */
	KRI.setGridMode(screen, grdListJobDt, KRConstant.GRID_CLEAR);
	KRI.setGridMode(screen, grdListRunDt, KRConstant.GRID_CLEAR);
    /* xDataSet 초기화 */	
	dsListJobDt.init();
	dsListRunDt.init();
	
	KRI.requestSubmit(screen,"/yz/ys/aa/selectListYmgtTgtTrnDdprAnalRunDt.do",true);

	
    /* 조회 중 중단 가능하도록 화면에 포커스를 지정 */
	screen.setfocus();
}
/*작업일자별 조회 validation Check*/
function validCheckRunDt()
{
	if(fldRUN_DT.gettext() == "")
	{
		KRI.alert(screen, "날짜를 입력하세요");
		fldRUN_DT.setfocus();
		return false;
	}
	return true;
}

/*수익관리할당처리상태(예발) 컬럼값 "반영제외"인 경우 빨간색 표시*/
function fn_setGridColor(oGrid, oDataset)
{
	for (var i = 0; i < oGrid.getrowcount(); i++)
	{
		var sAlcPrsSttCd = oDataset.getdatabyname(i, "ALC_PRS_STT_CD");
		if (sAlcPrsSttCd == "9")
		{
			oGrid.setitemforecolor(i, oGrid.getcolumn("ALC_PRS_STT_CD"), factory.rgb(255, 0, 0));
		}
	}
}

/*
** ========================================================================
** 5. 컨트롤 이벤트 영역
** ========================================================================
*/
//작업일자 달력팝업 버튼클릭 이벤트
function btnJobCalendar_on_mouseup(objInst)
{
	KRI.showCalendar(screen, fldJOB_DT);
	m_yzmod.fn_setDayField(fldJOB_DT, txtJobDay);
}
//운행일자 달력팝업 버튼클릭 이벤트
function btnCalendar_on_mouseup(objInst)
{
	KRI.showCalendar(screen, fldRUN_DT);
	m_yzmod.fn_setDayField(fldRUN_DT, txtDay);
}
/*
** ========================================================================
** 날짜, 기간 값 변경후 focusout 이벤트 
** ver : 1.0
** author : 김응규
** 대상obj : fldRUN_DT(운행일자) + txtDay(요일)
**		  fldRUN_TRM_ST_DT(운행기간시작일자) + txtFromDay(요일)
**		  fldRUN_TRM_CLS_DT(운행기간종료일자) + txtToDay(요일)
**
** 날짜입력필드의 focusout 이벤트에 연결시켜주어야함.
** ※ 조회 이벤트 시 날짜가 비워져 있는 경우에 validation check 해야함
** ※ 기간 조회 시 (시작일자-종료일자) validation check 해야함
** ========================================================================
*/
function fldDate_on_focusout(objInst)
{
	var sObjNm = objInst.getname();
	var sDate = KRUtil.trim(objInst.gettext());
	var isValid = KRUtil.checkDate(sDate, "YYYYMMDD", true); //빈값 허용하여 날짜 유효성 check
	if(!isValid) //비정상적인 날짜 값인 경우
	{
		KRI.alert(screen, "날짜를 바르게 입력하세요.");
		objInst.settext("");
		objInst.setfocus();
		if(sObjNm == "fldRUN_DT") txtDay.settext("");
		else if(sObjNm == "fldRUN_TRM_ST_DT") txtFromDay.settext("");
		else if(sObjNm == "fldRUN_TRM_CLS_DT") txtToDay.settext("");
		else if(sObjNm == "fldJOB_DT") txtJobDay.settext("");
		return false;
	}
	else
	{
		if(sDate == "")
		{
			if(sObjNm == "fldRUN_DT") txtDay.settext("");
			else if(sObjNm == "fldRUN_TRM_ST_DT") txtFromDay.settext("");
			else if(sObjNm == "fldRUN_TRM_CLS_DT") txtToDay.settext("");
			else if(sObjNm == "fldJOB_DT") txtJobDay.settext("");
		}
		else
		{
			if(sObjNm == "fldRUN_DT") m_yzmod.fn_setDayField(objInst, txtDay);
			else if(sObjNm == "fldRUN_TRM_ST_DT") m_yzmod.fn_setDayField(objInst, txtFromDay);
			else if(sObjNm == "fldRUN_TRM_CLS_DT") m_yzmod.fn_setDayField(objInst, txtToDay);
			else if(sObjNm == "fldJOB_DT") m_yzmod.fn_setDayField(objInst, txtJobDay);
		}
	}
}

//운행기간 달력팝업 버튼클릭 이벤트
function btnPeriodCalendar_on_mouseup(objInst)
{
	KRI.showPeriodCalendar(screen, btnPeriodCalendar, fldRUN_TRM_ST_DT, fldRUN_TRM_CLS_DT);
	m_yzmod.fn_setDayField(fldRUN_TRM_ST_DT, txtFromDay);
	m_yzmod.fn_setDayField(fldRUN_TRM_CLS_DT, txtToDay);
}

/* 주운행선/노선 조회 버튼 클릭 */
function btnMrntRout_on_mouseup(objInst)
{
	var popupUrl="/BIZ/YZ/YB/CO/YBCO004_P01";
	KRI.loadSystemPopup(screen, popupUrl, true);
	
	//팝업화면이 종료된 후의 수행
	var sMrntCd = KRI.getLinkValue("MRNT_CD");
	var sMrntNm = KRI.getLinkValue("MRNT_NM");
	var sRoutCd = KRI.getLinkValue("ROUT_CD");
	var sRoutNm = KRI.getLinkValue("ROUT_NM");
	KRI.clearLinkValue();  
	if (sMrntCd == null || sMrntCd =="")
	{
		cboMRNT.setselectedindex(0);
		cboMRNT2.setselectedindex(0);
	}
	else
	{
		cboMRNT.setselectedcode(sMrntCd);
		cboMRNT2.setselectedcode(sMrntCd);
	}
	if (sRoutCd == null || sRoutCd == "")
	{
		cboROUT.setselectedindex(0);
		cboROUT2.setselectedindex(0);
	}
	else
	{
		cboROUT.setselectedcode(sRoutCd);
		cboROUT2.setselectedcode(sRoutCd);
	}

}
/*
** ========================================================================
** 열차번호선택(기본) 팝업 관련 스크립트
** ver : 1.2
** author : changki.woo
** 현재까지 2가지 종류의 callType을 지원
**
** callType = "YMS" (YMS에 맞는 열차번호를 가져옴)  YRAA001_S01 참조
** callType = "BASE"(모든 열차번호를 가져옴) YRAA006_S01 참조
** trnNoBsPopupCall()에서 callType을 정확하게 설정해줘야 작동함.
** ========================================================================
*/

function fn_call_trn_no_popup()
{
	var callType = "YSAA001"
	var popupUrl="/BIZ/YZ/YB/CO/YBCO002_P01";
	m_yzmod.trnNoBsPopupCall(screen, callType, popupUrl);
}


//변수뽑아내서 팝업 호출까지 한번에 호출하는 함수.
//
// delimiter - 쿼리 선택 파라미터 (서비스에서 받아서 분기)
//
function trnNoBs_on_mousedown(objInst)
{	
	fn_call_trn_no_popup();
}


function fldTRN_NO_on_keydown(objInst, keycode, bctrldown, bshiftdown, baltdown, bnumpadkey)
{
	//조회수행
	if(keycode == 13)
	{
		fn_call_trn_no_popup();
	}
}

/*
** ========================================================================
** 열차번호선택(기본) 팝업 관련 스크립트 끝
** ========================================================================
*/

/* 작업일자별 조회/운행일자별조회 라디오버튼 클릭 */
function rdo_on_click(objInst, bPrevCheckState, bCurCheckState)
{
	var sObjNm = objInst.getname();
	
	if(bPrevCheckState == 0) /* 이전체크상태가 0 일때(체크되어있지 않았을때)만 동작*/
	{
	    fn_init();
		if(sObjNm == "rdoJOB_DT_SRCH") /* 작업일자별조회 선택시 */
		{
			grdListJobDt.setvisible(true);
			grdListRunDt.setvisible(false);
			rdoRUN_DT_SRCH.setcheck(false);  /*체크상태변경*/
			/*패널visible변경*/
			pnlSearchRunDt.setvisible(false);
			pnlSearchRunDtBtn.setvisible(false);
			pnlSearchJobDt.setvisible(true);
			pnlSearchJobDtBtn.setvisible(true);
		}
		else
		{
			grdListJobDt.setvisible(false);
			grdListRunDt.setvisible(true);
			rdoJOB_DT_SRCH.setcheck(false);
			/*패널visible변경*/
			pnlSearchRunDt.setvisible(true);
			pnlSearchRunDtBtn.setvisible(true);
			pnlSearchJobDt.setvisible(false);
			pnlSearchJobDtBtn.setvisible(false);
		}
	}
}

/* 작업일자별 조회 버튼클릭 */
function btnSearchJobDt_on_mouseup(objInst)
{
	//validation 체크
	if(validCheckJobDt())
	{
		fn_searchJobDt();
	}else 
		return false;
}
/* 운행일자별 조회 버튼클릭 */
function btnSearchRunDt_on_mouseup(objInst)
{
	//validation 체크
	if(validCheckRunDt())
	{
		fn_searchRunDt();
	}else 
		return false;
}

/* 엑셀 버튼클릭 */
function btnExcel_on_mouseup(objInst)
{
	if (rdoJOB_DT_SRCH.getcheck()) /* 작업일자별 조회 */
	{
		grdListJobDt.saveexcel();
	}
	else /* 운행일자별조회 */
	{
		grdListRunDt.saveexcel();
	}
}


/* 열차별 예측/실적 승차인원 조회 버튼클릭 */
function btnTrnPrFcstAcvmAbrdPrnb_on_mouseup(objInst)
{
	var popupUrl="/BIZ/YZ/YS/AA/YSAA002_P01";
	var nRow = 0;
	var objPram = new Object();
	objPram = {};
	
	if (rdoJOB_DT_SRCH.getcheck()) /* 작업일자별조회인경우 */
	{
		nRow = grdListJobDt.getselectrow();
		objPram.runDt     = dsListJobDt.getdatabyname(nRow, "RUN_DT");
		objPram.trnNo     = dsListJobDt.getdatabyname(nRow, "TRN_NO");
		objPram.orgRsStnCdNm = dsListJobDt.getdatabyname(nRow, "ORG_RS_STN_CD_NM"); /* 시발예발역코드명 */
		objPram.tmnRsStnCdNm = dsListJobDt.getdatabyname(nRow, "TMN_RS_STN_CD_NM"); /* 종착예발역코드명 */
		objPram.dptTmPram = dsListJobDt.getdatabyname(nRow, "DPT_TM_PRAM"); /* 출발시각(파라미터-시분초) */
		objPram.arvTmPram = dsListJobDt.getdatabyname(nRow, "ARV_TM_PRAM"); /* 도착시각(파라미터-시분초) */
	}
	else /* 운행일자별조회인경우 */
	{
		nRow = grdListRunDt.getselectrow();
		objPram.runDt     = dsListRunDt.getdatabyname(nRow, "RUN_DT");
		objPram.trnNo     = dsListRunDt.getdatabyname(nRow, "TRN_NO");
		objPram.orgRsStnCdNm = dsListRunDt.getdatabyname(nRow, "ORG_RS_STN_CD_NM"); /* 시발예발역코드명 */
		objPram.tmnRsStnCdNm = dsListRunDt.getdatabyname(nRow, "TMN_RS_STN_CD_NM"); /* 종착예발역코드명 */
		objPram.dptTmPram = dsListRunDt.getdatabyname(nRow, "DPT_TM_PRAM"); /* 출발시각(파라미터-시분초) */
		objPram.arvTmPram = dsListRunDt.getdatabyname(nRow, "ARV_TM_PRAM"); /* 도착시각(파라미터-시분초) */
	}
	
	KRLog.trace("runDt:::::::::"+objPram.runDt);
	KRLog.trace("trnNo:::::::::"+objPram.trnNo);
	KRLog.trace("orgRsStnCdNm:::::::::"+objPram.orgRsStnCdNm);
	KRLog.trace("orgRsStnCdNm:::::::::"+objPram.orgRsStnCdNm);
	KRLog.trace("dptTmPram:::::::::"+objPram.dptTmPram);
	KRLog.trace("arvTmPram:::::::::"+objPram.arvTmPram);
	KRI.setLinkValue("popupPram", objPram);
	
	
	KRI.loadSystemPopup(screen, popupUrl, true);
	
}
/* 할당결과조회 버튼클릭 */
function btnAlcCnqeQry_on_mouseup(objInst)
{
	var popupUrl="/BIZ/YZ/YS/AA/YSAA002_P02";
	var nRow = 0;
	
	if (rdoJOB_DT_SRCH.getcheck()) /* 작업일자별조회인경우 */
	{
		nRow = grdListJobDt.getselectrow();
		var sRunDt     = dsListJobDt.getdatabyname(nRow, "RUN_DT");
		var sTrnNo     = dsListJobDt.getdatabyname(nRow, "TRN_NO");
		var sYmgtJobId = dsListJobDt.getdatabyname(nRow, "YMGT_JOB_ID"); /* 수익관리작업ID */
	}
	else /* 운행일자별조회인경우 */
	{
		nRow = grdListRunDt.getselectrow();
		var sRunDt     = dsListRunDt.getdatabyname(nRow, "RUN_DT");
		var sTrnNo     = dsListRunDt.getdatabyname(nRow, "TRN_NO");
		var sYmgtJobId = dsListRunDt.getdatabyname(nRow, "YMGT_JOB_ID"); /* 수익관리작업ID */
	}
	
	KRLog.trace("RUN_DT:::::::::"+sRunDt);
	KRLog.trace("TRN_NO:::::::::"+sTrnNo);
	KRLog.trace("YMGT_JOB_ID:::::::::"+sYmgtJobId);
	KRI.setLinkValue("RUN_DT", sRunDt);
	KRI.setLinkValue("TRN_NO", sTrnNo);
	KRI.setLinkValue("YMGT_JOB_ID", sYmgtJobId);
	
	
	KRI.loadSystemPopup(screen, popupUrl, true);
}
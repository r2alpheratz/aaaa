/*
** =================================================================================================
** 시 스 템 명 : YZ (수익관리)
** 화  면  ID : YSAA001_P01
** 화  면  명 : 작업일별 수익관리열차조회
** 개      요 : 작업일별 운행기간별 수익관리대상열차를 조회한다.
** ================================================================================================= 
** << 변경 정보 >>
** -------------------------------------------------------------------------------------------------
** 변 경 일 자  : 변경자 : 변	경	내	역
** -------------------------------------------------------------------------------------------------
** 2014-04-07 : 김응규 : 신규작성
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
	
//	var sRunDt = KRI.getLinkValue("RUN_DT");
//	var sTrnNo = KRI.getLinkValue("TRN_NO");
//	KRI.clearLinkValue();
	
	/*모든 콤포넌트 초기화 셋팅*/
	fn_init();
	
	/* 주운행선/노선 데이터셋 셋팅 */
	/* xDataSet 초기화 */	
	dsMrntList.init();
	dsRoutList.init();
	dsObjCond.insertrow(0);
	dsObjCond.setdatabyname(0, "YMGT_CG_PS", "1");
	dsObjCond.setdatabyname(0, "MRNT", "1");
	dsObjCond.setdatabyname(0, "ROUT", "1");
	
	/* 수익관리담당자조회 호출 */
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
		fn_search();
	}
	else if (mapid == "/yz/ys/aa/selectListJobDdprYmgtTgtTrn.do")
	{
		var nRowCnt = grdList.getrowcount(); //전체대상열차수
		var nYmgtTgtTrnCnt = 0; //수익관리대상열차수
		var nExcsRsvTgtTrnCnt = 0; //초과예약대상열차수
		var bYmsAplFlg = ""; //YMS적용여부
		var bShtmExcsRsvAllwFlg = "" //단기초과예약허용여부
		if (nRowCnt > 0)
		{
			fldQRY_CNT.setvisible(true);
			fldQRY_CNT.settext("총 "+nRowCnt+"건");
			/*수익관리할당처리상태(예발) 컬럼값 "반영제외"인 경우 빨간색 표시*/
			fn_setGridColor(grdList, dsList);
			btnExcel.setenable(true);
			for (var i = 0; i < nRowCnt; i++)
			{
				bYmsAplFlg          = dsList.getdatabyname(i, "YMS_APL_FLG");
				bShtmExcsRsvAllwFlg = dsList.getdatabyname(i, "SHTM_EXCS_RSV_ALLW_FLG");
				if(bYmsAplFlg == "Y")
				{
					nYmgtTgtTrnCnt++;
				}
				if(bShtmExcsRsvAllwFlg == "Y")
				{
					nExcsRsvTgtTrnCnt++;
				}
			}
			var sRunTrmStDt = dsList.getdatabyname(0, "RUN_DT");
			var sRunTrmClsDt = m_yzmod.fn_yz_comm_DS_get_col_max_val(dsList, "RUN_DT");
			
			fldJOB_RUN_TRM_ST_DT.settext(sRunTrmStDt);
			fldJOB_RUN_TRM_CLS_DT.settext(sRunTrmClsDt);
			fldWHL_TGT_TRN_NUM.settext(nRowCnt+" 대");
			fldYMGT_TGT_TRN_NUM.settext(nYmgtTgtTrnCnt+" 대");
			fldEXCS_RSV_TGT_TRN_NUM.settext(nExcsRsvTgtTrnCnt+ " 대");
			
			/*조회결과 메시지*/
			KRI.setTranMessage(screen, 0, "정상적으로 조회 되었습니다.");
		}
		else /* 조회결과가 0건이면 */
		{
			KRI.setTranMessage(screen, 0, "조회할 자료가 없습니다.");		
		}

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
	
	/* 상하행구분코드 -상하행- 기본셋팅 */
	cboUP_DN_DV_CD.setselectedindex(0);
	
	cboMRNT.setselectedindex(0);
	cboROUT.setselectedindex(0);
	
	/* GRID CLEAR */
	KRI.setGridMode(screen, grdList, KRConstant.GRID_CLEAR);
	/* xDataSet 초기화 */	
	dsList.init();
	/* 총건수 초기화 */
	fldQRY_CNT.settext("");
	fldQRY_CNT.setvisible(false);
}
/* 작업일별 수익관리대상열차 조회 */
function fn_search()
{
    /* GRID CLEAR */
	KRI.setGridMode(screen, grdList, KRConstant.GRID_CLEAR);
    /* xDataSet 초기화 */	
	dsList.init();
	KRI.requestSubmit(screen,"/yz/ys/aa/selectListJobDdprYmgtTgtTrn.do",true);

	
    /* 조회 중 중단 가능하도록 화면에 포커스를 지정 */
	screen.setfocus();
}
/*작업일자별 조회 validation Check*/
function validCheck()
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

//운행기간 달력팝업 버튼클릭 이벤트
function btnPeriodCalendar_on_mouseup(objInst)
{
	KRI.showPeriodCalendar(screen, btnPeriodCalendar, fldRUN_TRM_ST_DT, fldRUN_TRM_CLS_DT);
	m_yzmod.fn_setDayField(fldRUN_TRM_ST_DT, txtFromDay);
	m_yzmod.fn_setDayField(fldRUN_TRM_CLS_DT, txtToDay);
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
	if (sMrntCd == null || sMrntCd == "")
	{
		cboMRNT.setselectedindex(0);
	}
	else
	{
		cboMRNT.setselectedcode(sMrntCd);
	}
	if (sRoutCd == null || sRoutCd == "")
	{
		cboROUT.setselectedindex(0);
	}
	else
	{
		cboROUT.setselectedcode(sRoutCd);
	}

}

/* 작업일별 수익관리대상열차 조회 버튼클릭 */
function btnSearch_on_mouseup(objInst)
{
	//validation 체크
	if(validCheck())
	{
		fn_search();
	}else 
		return false;
}

/* 엑셀 버튼클릭 */
function btnExcel_on_mouseup(objInst)
{
	grdList.saveexcel();
}

/* 닫기 버튼 클릭 */
function btnClose_on_mouseup(objInst)
{
	KRI.unloadPopup(screen);
}
/*
** =================================================================================================
** 시 스 템 명 : YZ (수익관리)
** 화  면  ID : YSAA001_P02
** 화  면  명 : 열차별 상세처리결과조회
** 개      요 : 수익관리 처리결과 이력을 조회한다.
** ================================================================================================= 
** << 변경 정보 >>
** -------------------------------------------------------------------------------------------------
** 변 경 일 자  : 변경자 : 변	경	내	역
** -------------------------------------------------------------------------------------------------
** 2014-04-08 : 김응규 : 신규작성
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
	var sJobDt = KRI.getLinkValue("JOB_DT");
	var sRunDt = KRI.getLinkValue("RUN_DT");
	var sTrnNo = KRI.getLinkValue("TRN_NO");
	KRI.clearLinkValue();
	
	
	/* 작업일자, 요일 셋팅 */
	fldJOB_DT.settext(sJobDt);
	m_yzmod.fn_setDayField(fldJOB_DT, txtJobDay);
	/* 운행일자, 요일 셋팅 */
	fldRUN_DT.settext(sRunDt);
	m_yzmod.fn_setDayField(fldRUN_DT, txtDay);
	/* 열차번호 셋팅 */
	fldTRN_NO.settext(sTrnNo);
	/*모든 콤포넌트 초기화 셋팅*/
	fn_init();

	fn_search();
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
	
	if (mapid == "/yz/ys/aa/selectListDtlPrsCnqe.do")
	{
		var nRowCnt = grdList.getrowcount();
		if (nRowCnt > 0)
		{
			fldQRY_CNT.setvisible(true);
			fldQRY_CNT.settext("총 "+nRowCnt+"건");
			/*수익관리할당처리상태(예발) 컬럼값 "반영제외"인 경우 빨간색 표시*/
			fn_setGridColor(grdList, dsList);
			/*조회결과 메시지*/
			KRI.setTranMessage(screen, 0, "정상적으로 조회 되었습니다.");
		}
		else /* 조회결과가 0건이면 */
		{
			KRI.setTranMessage(screen, 0, "조회할 자료가 없습니다.");
			fldQRY_CNT.setvisible(false);
			fldQRY_CNT.settext("");
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
	KRI.requestSubmit(screen,"/yz/ys/aa/selectListDtlPrsCnqe.do",true);

	
    /* 조회 중 중단 가능하도록 화면에 포커스를 지정 */
	screen.setfocus();
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
/* 닫기 버튼 클릭 */
function btnClose_on_mouseup(objInst)
{
	KRI.unloadPopup(screen);
}
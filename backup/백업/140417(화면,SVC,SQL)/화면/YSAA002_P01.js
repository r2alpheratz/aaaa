/*
** =================================================================================================
** 시 스 템 명 : YZ (수익관리)
** 화  면  ID : YSAA002_P01
** 화  면  명 : 열차별 예측-실적 승차인원 조회
** 개      요 : 열차별 예측-실적 승차인원 조회 내역을 차트로 보여준다.
** ================================================================================================= 
** << 변경 정보 >>
** -------------------------------------------------------------------------------------------------
** 변 경 일 자  : 변경자 : 변	경	내	역
** -------------------------------------------------------------------------------------------------
** 2014-04-11 : 김응규 : 신규작성
** YYYY-MM-DD :       
** =================================================================================================
*/

/* 
** ========================================================================
** 1. 전역 변수 영역
** ======================================================================== 
*/
var objPram;

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
	
	
	if (mapid == "/yz/yb/co/selectListObject.do") /* 출발-도착역 조회 */
	{
		cboDPT_ARV_STGP_CD.setselectedindex(0);
		
//		var nRowCnt = grdList.getrowcount();
//		if (nRowCnt > 0)
//		{
//			
//			KRI.setTranMessage(screen, 0, "정상적으로 조회 되었습니다.");
//		}
//		else /* 조회결과가 0건이면 */
//		{
//			KRI.setTranMessage(screen, 0, "조회할 자료가 없습니다.");
//		}

	}
	else if (mapid == "/yz/ys/aa/selectListTrnPrFcstAcvmAbrdPrnb.do")
	{
		
		
		//열차별 예측-실적 승차인원조회 차트
		var sReportId = "/YZ/YS/AA/YSAA002_P01_CHT01.reb"; //보고서ID
		var aFields = null;  //매개변수 필드(여기서는 사용하지 않음)
		var sCSV = KRI.makeCSV(screen, "grdList");   //그리드데이터를 CSV형태로 변환
		var sOOF = KRI.makeOOF(screen, sReportId, aFields, sCSV); //OOF Xml 생성
		oReport.innerctrl.CloseAll();
		oReport.innerctrl.SetCSS("appearance.toolbar.visible=0"); 
		oReport.innerctrl.SetCSS("appearance.statusbar.visible=0");   
		oReport.innerctrl.SetCSS("appearance.pagemargin.visible=0");   
		oReport.innerctrl.SetCSS("appearance.tabheader.visible=0");   
		oReport.innerctrl.SetCSS("appearance.canvas.offsetx=0");   
		oReport.innerctrl.SetCSS("appearance.canvas.offsety=0");   
		oReport.innerctrl.SetCSS("appearance.paper.backgroundtransparent=1");   
		oReport.innerctrl.UpdateCSS();   
		
		oReport.innerctrl.OpenOOF(sOOF);
		oReport.setvisible(true);
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

//	var sRunDt = KRI.getLinkValue("RUN_DT");
//	var sTrnNo = KRI.getLinkValue("TRN_NO");
//	KRI.clearLinkValue();
//	
//	
//	/* 운행일자, 요일 셋팅 */
//	fldRUN_DT.settext(sRunDt);
//	m_yzmod.fn_setDayField(fldRUN_DT, txtDay);
//	/* 열차번호 셋팅 */
//	fldTRN_NO.settext(sTrnNo);
//	/*모든 콤포넌트 초기화 셋팅*/
	objPram = KRI.getLinkValue("popupPram");
	
	dsCond.insertrow(0);
	dsCond.setdatabyname(0, "RUN_DT", objPram.runDt);
	dsCond.setdatabyname(0, "TRN_NO", objPram.trnNo);

	fldORG_RS_STN_CD_NM.settext(objPram.orgRsStnCdNm);
	fldTMN_RS_STN_CD_NM.settext(objPram.tmnRsStnCdNm);
	fldDPT_TM.settext(objPram.dptTmPram);
	fldARV_TM.settext(objPram.arvTmPram);
	m_yzmod.fn_setDayField(fldRUN_DT, txtDay);
	/* 출발-도착역그룹 데이터셋 셋팅 */
	/* xDataSet 초기화 */	
	dsDptArvStgpList.init();
	dsObjCond.insertrow(0);
	
	dsObjCond.setdatabyname(0, "DPT_ARV_STGP", "1");
	dsObjCond.setdatabyname(0, "NON_NML_TRN_FLG", "1");
	KRI.requestSubmit(screen,"/yz/yb/co/selectListObject.do",true);

}
/* 작업일별 수익관리대상열차 조회 */
function fn_search()
{
	var sDptArvStgpCd = cboDPT_ARV_STGP_CD.getselectedcode();
	var sDptStgpCd = sDptArvStgpCd.substring(0,5);
	var sArvStgpCd = sDptArvStgpCd.substring(5,10);
	
	dsCond.setdatabyname(0, "DPT_STGP_CD", sDptStgpCd);
	dsCond.setdatabyname(0, "ARV_STGP_CD", sArvStgpCd);
	
    /* GRID CLEAR */
	KRI.setGridMode(screen, grdList, KRConstant.GRID_CLEAR);
    /* xDataSet 초기화 */	
	dsList.init();
	KRI.requestSubmit(screen,"/yz/ys/aa/selectListTrnPrFcstAcvmAbrdPrnb.do",true);

	
    /* 조회 중 중단 가능하도록 화면에 포커스를 지정 */
	screen.setfocus();
}
/*
** ========================================================================
** 5. 컨트롤 이벤트 영역
** ========================================================================
*/
/* 조회 버튼 클릭*/
function btnSearch_on_mouseup(objInst)
{
	fn_search();
}

/* 닫기 버튼 클릭 */
function btnClose_on_mouseup(objInst)
{
	KRI.unloadPopup(screen);
}
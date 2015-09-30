/*
** =================================================================================================
** 시 스 템 명 : YZ (수익관리)
** 화  면  ID : YFAA003_P01
** 화  면  명 : 이상열차정보 차트 조회
** 개      요 : 이상열차와 비교대상열차의 승차인원수를 차트로 보여준다.
** ================================================================================================= 
** << 변경 정보 >>
** -------------------------------------------------------------------------------------------------
** 변 경 일 자  : 변경자 : 변	경	내	역
** -------------------------------------------------------------------------------------------------
** 2014-03-17 : 김응규 : 신규작성
** YYYY-MM-DD :       
** =================================================================================================
*/

/* 
** ========================================================================
** 1. 전역 변수 영역
** ======================================================================== 
*/
var m_today = KRUtil.TodayDate(screen);

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

	var sRunDt = KRI.getLinkValue("RUN_DT");
	var sTrnNo = KRI.getLinkValue("TRN_NO");
	KRI.clearLinkValue();
	
	fldRUN_DT.settext(sRunDt);
	fldTRN_NO.settext(sTrnNo);
	//테스트를 위해 임의 값 셋팅
	//TO-DO  날짜 셋팅 변경할것
	fldRUN_TRM_ST_DT.settext("20131201");
	fldRUN_TRM_CLS_DT.settext("20131212");
	fldCOMP_TGT_TRN_NO.settext("101");
	cboDAY_DV_CD.setselectedindex(0);
	
	fn_setDayField(fldRUN_DT, txtDay);//요일 셋팅
	fn_setDayField(fldRUN_TRM_ST_DT, txtFromDay);//요일 셋팅
	fn_setDayField(fldRUN_TRM_CLS_DT, txtToDay);//요일 셋팅
	
	KRI.sortComboboxData(cboDAY_DV_CD, 0, 1);
}

/*
* 스크린 사이즈 변경시
*/ 
function screen_on_size(window_width, window_height)
{
	KRI.processResize(screen, window_width, window_height);
}

/*
* 스크린에서 키 입력시
*/
function screen_on_keydown(keycode, bctrldown, bshiftdown, baltdown, bnumpadkey)
{
	if(keycode == 13) //엔터키 입력
	{
		fn_search();
	}
	return 0;
}

/* 
* submit 완료시 호출
*/
function screen_on_submitcomplete(mapid, result, recv_userheader, recv_code, recv_msg)
{
	if(KRI.submitComplete(screen, mapid, result, recv_userheader, recv_code, recv_msg) == false) return;
	if(mapid == "/yz/yf/aa/selectAbvTrnCompQry.do")
	{
		if(grdAbvTrnAbrdPrnb.getrowcount < 1)
		{
			grdAbvTrnAbrdPrnb.additem();  // 그리드 row 추가
		}
		grdAbvTrnAbrdPrnb.setitemtext(0,1,"1.이상 열차");
		grdAbvTrnAbrdPrnb.additem();  // 그리드 row 추가
		grdAbvTrnAbrdPrnb.setitemtext(1,1,"2.평균치"); 
		grdAbvTrnAbrdPrnb.setitemtext(1,2, grdCompTrnAbrdPrnb.getitemtext(0,1)); //비교대상열차 승차인원수 셋팅
		
		//이상열차비교차트
		var sReportId = "/YZ/YF/AA/YFAA003_P01_CHT01.reb"; //보고서ID
		var aFields = null;  //매개변수 필드(여기서는 사용하지 않음)
		var sCSV = KRI.makeCSV(screen, "grdAbvTrnAbrdPrnb");   //그리드데이터를 CSV형태로 변환
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
		
		//비교대상열차추이차트
		for(var i = 0; i < grdCompTrnAbrdPrnbPrDt.getrowcount(); i++)
		{
			grdCompTrnAbrdPrnbPrDt.setitemtext(i, grdCompTrnAbrdPrnbPrDt.getcolumn("DV"), "1");
		}
		grdCompTrnAbrdPrnbPrDt.insertitemtext(0,0,"1.이상열차");
		grdCompTrnAbrdPrnbPrDt.setitemtext(0, 2, grdAbvTrnAbrdPrnb.getitemtext(0,2));
		grdCompTrnAbrdPrnbPrDt.setitemtext(0, grdCompTrnAbrdPrnbPrDt.getcolumn("DV"), "0");		
		grdCompTrnAbrdPrnbPrDt.sort(0,1);
		
		
		sReportId = "/YZ/YF/AA/YFAA003_P01_CHT02.reb"; //보고서ID
		aFields = null;  //매개변수 필드(여기서는 사용하지 않음)
		sCSV = KRI.makeCSV(screen, "grdCompTrnAbrdPrnbPrDt");   //그리드데이터를 CSV형태로 변환
		sOOF = KRI.makeOOF(screen, sReportId, aFields, sCSV); //OOF Xml 생성
		oReport2.innerctrl.CloseAll();
		oReport2.innerctrl.SetCSS("appearance.toolbar.visible=0"); 
		oReport2.innerctrl.SetCSS("appearance.statusbar.visible=0");   
		oReport2.innerctrl.SetCSS("appearance.pagemargin.visible=0");   
		oReport2.innerctrl.SetCSS("appearance.tabheader.visible=0");   
		oReport2.innerctrl.SetCSS("appearance.canvas.offsetx=0");   
		oReport2.innerctrl.SetCSS("appearance.canvas.offsety=0");   
		oReport2.innerctrl.SetCSS("appearance.paper.backgroundtransparent=1");   
		oReport2.innerctrl.UpdateCSS();   
		
		oReport2.innerctrl.OpenOOF(sOOF);
		oReport2.setvisible(true);		
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
function fn_search()
{
    /* GRID CLEAR */
	KRI.setGridMode(screen, grdAbvTrnAbrdPrnb, KRConstant.GRID_CLEAR);
	KRI.setGridMode(screen, grdCompTrnAbrdPrnb, KRConstant.GRID_CLEAR);
	KRI.setGridMode(screen, grdCompTrnAbrdPrnbPrDt, KRConstant.GRID_CLEAR);		
    /* xDataSet 초기화 */	
	dsAbvTrnAbrdPrnb.init();
	dsCompTrnAbrdPrnb.init();
	dsCompTrnAbrdPrnbPrDt.init();
		
	/* 검색조건(dsCond) 셋 */
	dsCond.setdatabyname(0, "RUN_DT", fldRUN_DT.gettext());
	dsCond.setdatabyname(0, "TRN_NO", KRUtil.trim(fldTRN_NO.gettext()));
	dsCond.setdatabyname(0, "RUN_TRM_ST_DT", fldRUN_TRM_ST_DT.gettext());
	dsCond.setdatabyname(0, "RUN_TRM_CLS_DT", fldRUN_TRM_CLS_DT.gettext());
	dsCond.setdatabyname(0, "COMP_TGT_TRN_NO", fldCOMP_TGT_TRN_NO.gettext());	
	dsCond.setdatabyname(0, "DAY_DV_CD", cboDAY_DV_CD.getselectedcode());
	
	KRI.requestSubmit(screen,"/yz/yf/aa/selectAbvTrnCompQry.do",true);

	
    /* 조회 중 중단 가능하도록 화면에 포커스를 지정 */
	screen.setfocus();
}

function validCheck()
{
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
//날짜(일자, 기간) 오브젝트의 요일과 요일에 해당하는 색깔을 셋팅하는 함수
function fn_setDayField(objDate, objDay)
{
	var bValidDate = KRUtil.checkDate(objDate.gettext(), "YYYYMMDD", false);
	if(bValidDate)
	{
		var day = KRUtil.SearchforDay(objDate.gettext(), false).substr(0,1);
		objDay.settext(day);
		if(day == "일")
		{
			objDate.setforecolor(255,0,0);//빨강
			objDay.setforecolor(255,0,0);//빨강
			
		}
		else if(day == "토")
		{
			objDate.setforecolor(0,0,255);//파랑
			objDay.setforecolor(0,0,255);//파랑
		}
		else
		{
			objDate.setforecolor(0,0,0); //검정
			objDay.setforecolor(0,0,0); //검정
		}
	}
	else
	{
		objDay.settext("");
	} 
}


/*
** ========================================================================
** 5. 컨트롤 이벤트 영역
** ========================================================================
*/
//운행일자 달력팝업 버튼클릭 이벤트
function btnCalendar_on_mouseup(objInst)
{
	KRI.showCalendar(screen, fldRUN_DT);
	fn_setDayField(RUN_DT, txtDay);
}


//운행기간 달력팝업 버튼클릭 이벤트
function btnPeriodCalendar_on_mouseup(objInst)
{
	KRI.showPeriodCalendar(screen, btnPeriodCalendar, fldRUN_TRM_ST_DT, fldRUN_TRM_CLS_DT);
	fn_setDayField(fldRUN_TRM_ST_DT, txtFromDay);
	fn_setDayField(fldRUN_TRM_CLS_DT, txtToDay);
}
//차트조회 버튼클릭 이벤트
function btnSearch_on_mouseup(objInst)
{
	//validation 체크
	if(validCheck())
	{
		fn_search();
	}else 
		return false;
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
** ex)---------------------------------------------------------------------

function btnSearch_on_mouseup(objInst)
{
	if(validCheck()) fn_search();
}
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
		return false;
	}
	else
	{
		if(sDate == "")
		{
			if(sObjNm == "fldRUN_DT") txtDay.settext("");
			else if(sObjNm == "fldRUN_TRM_ST_DT") txtFromDay.settext("");
			else if(sObjNm == "fldRUN_TRM_CLS_DT") txtToDay.settext("");
		}
		else
		{
			if(sObjNm == "fldRUN_DT") fn_setDayField(objInst, txtDay);
			else if(sObjNm == "fldRUN_TRM_ST_DT") fn_setDayField(objInst, txtFromDay);
			else if(sObjNm == "fldRUN_TRM_CLS_DT") fn_setDayField(objInst, txtToDay);
		}
	}
}

//닫기 버튼 클릭시
function btnClose_on_mouseup(objInst)
{
	KRI.unloadPopup(screen);
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

//변수뽑아내서 팝업 호출까지 한번에 호출하는 함수.
//
// delimiter - 쿼리 선택 파라미터 (서비스에서 받아서 분기)
//
function trnNoBs_on_mousedown(objInst)
{	
	trnNoBsPopupCall();
}

//변수뽑아내서 팝업 호출까지 한번에 호출하는 함수.
//
//
function trnNoBsPopupCall()
{

	//1. 열차번호 조회시 넘길 파라미터들 세팅
	var callType = "BASE";
	//var callType = "YMS";
	//var callType = "BASE";

	//BASE일 경우 기본열차조회
	//YMS일 경우 YMS를 where절에 사용하는 쿼리가 선택됨

	//1. 열차번호 조회시 넘길 파라미터들 세팅
	var callType = "BASE";
	var objPram = fn_setCond_search_trnNo(callType);

	//화면 호출
	var rsltObj = trnNoBsPopupCallWithParam(objPram);
	fn_auto_setCond(rsltObj);
	
}

//열차번호선택(기본) 팝업 호출 함수
function trnNoBsPopupCallWithParam(pram)
{
	KRI.setLinkValue("popupPram", pram);
	trnNoBsSysPopupCall();

	var objPram = KRI.getLinkValue("setCondPram");
	KRI.clearLinkValue();  

	return objPram;
}

//열차번호선택(기본) 팝업 호출함수
function trnNoBsSysPopupCall()
{
	var popupUrl="/BIZ/YZ/YB/CO/YBCO002_P01";
	KRI.loadSystemPopup(screen, popupUrl, true);
	
}

//열차번호선택(기본) 에디트박스에서 ENTER입력시 작동함수
function fldCOMP_TGT_TRN_NO_on_keydown(objInst, keycode, bctrldown, bshiftdown, baltdown, bnumpadkey)
{
	var nTrnNoLen = fldCOMP_TGT_TRN_NO.gettext().length;
	//조회수행
	if(keycode == 13)
	{
		if(nTrnNoLen == 0 || nTrnNoLen == 5)
		{
			fn_search();
		}
		else
		{
			trnNoBsPopupCall();
		}
	}
}

function fn_setCond_search_trnNo(callType)
{
	var objPram = new Object();
	objPram = {};
	
	//호출타입
	objPram.callType = callType;
	//열차번호
	objPram.trnNo = fldCOMP_TGT_TRN_NO.gettext();
	//운행일자
//	if(screen.getinstancebyname("fldRUN_DT") != undefined)
//		objPram.runDt	 = fldRUN_DT.gettext();
	//상하행구분코드
//	if(screen.getinstancebyname("cboUP_DN_DV_CD") != undefined)
//		objPram.dnDvCd    = cboUP_DN_DV_CD.getselectedcode();
//	//YMS적용여부
//	if(screen.getinstancebyname("cboYMS_APL_FLG") != undefined)
//		objPram.ymsAplFlg = cboYMS_APL_FLG.getselectedcode();
//	//열차종코드
//	if(screen.getinstancebyname("cboTRN_CLSF_CD") != undefined)
//		objPram.trnClsfCd = cboTRN_CLSF_CD.getselectedcode();
//	//주운행선/노선 (TBD)
//	if(screen.getinstancebyname("ROUT_CD") != undefined)
//		objPram.routCd    = ROUT_CD.gettext();

	return objPram;
}
//조회조검 패널중 상하행, YMS적용, 주운행선/구간의 오브젝트가 있는경우
//조회 결과를 SETTING해준다.
function fn_auto_setCond(obj)
{							
	if(obj == null)
	{
		fn_trn_no_init();
		return;
	}

	//열차번호
	fldCOMP_TGT_TRN_NO.settext(obj.trnNo)
	//상하행구분코드
//	if(screen.getinstancebyname("cboUP_DN_DV_CD") != undefined)
//		cboUP_DN_DV_CD.setselectedcode(obj.upDnDvCd);
	//YMS적용여부
//	if(screen.getinstancebyname("cboYMS_APL_FLG") != undefined)
//		cboYMS_APL_FLG.setselectedcode(obj.ymsAplFlg);
	//주운행선/노선 (TBD)
//	if(screen.getinstancebyname("ROUT_CD") != undefined)
	//objPram.routCd    = ROUT_CD.gettext();

	return obj;
}

function fn_trn_no_init()
{
	fldCOMP_TGT_TRN_NO.settext("");
}

/*
** ========================================================================
** 열차번호선택(기본) 팝업 관련 스크립트 끝
** ========================================================================
*/
/*
** =================================================================================================
** 시 스 템 명 : YZ (수익관리)
** 화  면  ID : YSBA001_M01
** 화  면  명 : 수요예측(기본)
** 개      요 : 기본열차 사용자조정 수요 조회 및 관리
** ================================================================================================= 
** << 변경 정보 >>
** -------------------------------------------------------------------------------------------------
** 변 경 일 자  : 변경자 : 변	경	내	역
** -------------------------------------------------------------------------------------------------
** 2014-04-17 : 김응규 : 신규작성
** YYYY-MM-DD :       
** =================================================================================================
*/

/* 
** ========================================================================
** 1. 전역 변수 영역
** ======================================================================== 
*/

var m_yzmod 	  = KRI.getTeamModule(screen, "YZ", "YZCmmnUtil");

//var m_today 	  = KRUtil.TodayDate(screen); 			/* 오늘 날짜 전역변수		*/
var m_today 	  = "20101101"; 

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
	
	if (mapid == "/yz/ys/ba/selectListUsrCtlYmgtFcstBsTrn.do")
	{
		var nRowCnt = grdList.getrowcount();
		if(nRowCnt > 0)
		{
			fldQRY_CNT.setvisible(true);
			fldQRY_CNT.settext("총 "+nRowCnt+"건");
			/*조회결과 메시지*/
			KRI.setTranMessage(screen, 0, "정상적으로 조회 되었습니다.");
		}
		else /* 조회결과가 0건이면 */
		{
			fldQRY_CNT.setvisible(false);
			fldQRY_CNT.settext("");
			KRI.setTranMessage(screen, 0, "조회할 자료가 없습니다.");
			
		}
		fldQRY_CNT2.setvisible(false);
		fldQRY_CNT2.settext("");
				
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
	//날짜 오브젝트 오늘날짜로 셋팅
	fldRUN_DT.settext(m_today);
	m_yzmod.fn_setDayField(fldRUN_DT, txtDay);//요일 셋팅
	
	/* GRID CLEAR */
	KRI.setGridMode(screen, grdList, KRConstant.GRID_CLEAR);
	KRI.setGridMode(screen, grdListDtl, KRConstant.GRID_CLEAR);
    /* xDataSet 초기화 */	
	dsList.init();
	dsListDtl.init();
	/* 총건수 초기화 */
	fldQRY_CNT.settext("");
	fldQRY_CNT2.settext("");
	fldQRY_CNT.setvisible(false);
	fldQRY_CNT2.setvisible(false);
	
	/* 열차번호 초기화 */
	fldTRN_NO.settext("");
	
	/* 요일 콤보박스 정렬 */  
	KRI.sortComboboxData(cboDAY_DV_CD, 0, 1);
	cboDAY_DV_CD.setselectedindex(0);
	
}
/* 적용기간별 열차번호 조회 조회 */
function fn_search()
{
    /* GRID CLEAR */
	KRI.setGridMode(screen, grdList, KRConstant.GRID_CLEAR);
	KRI.setGridMode(screen, grdListDtl, KRConstant.GRID_CLEAR);
    /* xDataSet 초기화 */	
	dsList.init();
	dsListDtl.init();
	
	KRI.requestSubmit(screen,"/yz/ys/ba/selectListUsrCtlYmgtFcstBsTrn.do",true);

	
    /* 조회 중 중단 가능하도록 화면에 포커스를 지정 */
	screen.setfocus();
}
/*작업일자별 조회 validation Check*/
function validCheck()
{
	if(fldRUN_DT.gettext() == "")
	{
		KRI.alert(screen, "날짜를 입력하세요");
		fldRUN_DT.setfocus();
		return false;
	}

	return true;
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
	var callType = "BASE"
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

function btnSearch_on_mouseup(objInst)
{
	fn_search();
}
/*
** =================================================================================================
** 시 스 템 명 : YZ (수익관리)
** 화  면  ID : YFAA003_E01
** 화  면  명 : 이상열차정보 등록
** 개      요 : 이상열차로 등록되어있지 않은 열차를 조회하여 이상열차로 등록한다.
** ================================================================================================= 
** << 변경 정보 >>
** -------------------------------------------------------------------------------------------------
** 변 경 일 자  : 변경자 : 변	경	내	역
** -------------------------------------------------------------------------------------------------
** 2014-03-19 : 김응규 : 신규작성
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

	var sRunTrmStDt  = KRI.getLinkValue("RUN_TRM_ST_DT");  //운행기간시작일자
	var sRunTrmClsDt = KRI.getLinkValue("RUN_TRM_CLS_DT"); //운행기간종료일자
	var sAbvTrnSrtCd = KRI.getLinkValue("ABV_TRN_SRT_CD"); //이상원인분류코드
	KRI.clearLinkValue();
	
	fldRUN_TRM_ST_DT.settext(sRunTrmStDt);
	fldRUN_TRM_CLS_DT.settext(sRunTrmClsDt);
	fldABV_TRN_SRT_CD.settext(sAbvTrnSrtCd);

//	fldRUN_TRM_ST_DT.settext("20130601");
//	fldRUN_TRM_CLS_DT.settext("20130617");
	
	fn_setDayField(fldRUN_TRM_ST_DT, txtFromDay);//요일 셋팅
	fn_setDayField(fldRUN_TRM_CLS_DT, txtToDay);//요일 셋팅
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
	if (mapid == "/yz/yf/aa/selectListNmlTrn.do")
	{
		var nRowCnt = grdList.getrowcount()
		fldQRY_CNT.settext("총 "+nRowCnt+"건");
		if (nRowCnt > 0)
		{
			fldRUN_TRM_ST_DT.setinputtype(2);
			//fldRUN_TRM_ST_DT.setbackcolor(243, 243, 243);
			fldRUN_TRM_CLS_DT.setinputtype(2);
			//fldRUN_TRM_CLS_DT.setbackcolor(243, 243, 243);
			txtFromDay.setbackcolor(243, 243, 243);
			txtToDay.setbackcolor(243, 243, 243);
			btnPeriodCalendar.setenable(false);
			chkReSearch.setenable(true);
			chkReSearch.setcheck(false);
			/*조회결과 메시지*/
			KRI.setTranMessage(screen, 0, "정상적으로 조회 되었습니다.");
		}
		else /* 조회결과가 0건이면 */
		{
			KRI.setTranMessage(screen, 0, "조회할 자료가 없습니다.");		
		}
		
	}
	else if (mapid == "/yz/yf/aa/insertAbvTrn.do")
	{
		if (dsMessage.getdatabyname(0, "MSG_CONT") != "")
		{
			var sMsg = "";
			for (var i = 0; i < dsMessage.getrowcount(); i++)
			{	
				if( i == dsMessage.getrowcount()-1)
				{
					sMsg += "["+dsMessage.getdatabyname(i, "MSG_CONT")+"]"
				//	KRLog.trace("sMsg:::::::::"+sMsg);
				}
				else
				{
					sMsg += "["+dsMessage.getdatabyname(i, "MSG_CONT")+"], "
				//	KRLog.trace("sMsg:::::::::"+sMsg);
				}
				KRLog.trace("sMsg:::::::::"+sMsg);
			}
		}
		KRI.alert(screen, "저장되었습니다.\n(단, 일일열차정보에 등록되어있지 않은 열차는 제외)");
		//모화면에 넘겨줄 데이터 설정
		KRI.setLinkValue("saveFlg" , "Y");
		KRI.setLinkValue("RUN_TRM_ST_DT" , fldRUN_TRM_ST_DT.gettext());
		KRI.setLinkValue("RUN_TRM_CLS_DT" , fldRUN_TRM_CLS_DT.gettext());
		//팝업창 종료
		KRI.unloadPopup(screen);
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
	KRI.setGridMode(screen, grdList, KRConstant.GRID_CLEAR);
    /* xDataSet 초기화 */	
	dsList.init();
		
	/* 검색조건(dsCond) 셋 */
	dsCond.setdatabyname(0, "RUN_TRM_ST_DT", fldRUN_TRM_ST_DT.gettext());
	dsCond.setdatabyname(0, "RUN_TRM_CLS_DT", fldRUN_TRM_CLS_DT.gettext());
	dsCond.setdatabyname(0, "TRN_NO", KRUtil.trim(fldTRN_NO.gettext()));
	
	KRI.requestSubmit(screen,"/yz/yf/aa/selectListNmlTrn.do",true);

	
    /* 조회 중 중단 가능하도록 화면에 포커스를 지정 */
	screen.setfocus();
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
/*조회시 validation check*/
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
	
	var nDateCnt = KRUtil.DateSpecificYYYYMMDD(fldRUN_TRM_ST_DT.gettext(), fldRUN_TRM_CLS_DT.gettext());
	
	if (nDateCnt > 61)
	{
		KRI.alert(screen, "운행기간을 2달 이내로 조정해주시기 바랍니다.");
		fldRUN_TRM_ST_DT.setfocus();
		return false;
	}
	return true;
}

/*저장시 validation check*/
function validCheckSave()
{

    var bRet = KRI.validate(screen, [
									{comp: mltABV_OCUR_CAUS_CONT, rules: 'required|max_length[200]'},  // 이상발생원인
									]
							);
	if(bRet == false)
	{
		return false;
	}	


	if (validCheck()) /*조회후 저장전 날짜를 지운경우에 대한 validation check*/
	{
		var nChkCnt = grdList.getcheckedrowcount();
		if (nChkCnt > 300) /* 체크한 열차번호를 300개 까지로 제한 */
		{
			KRI.alert(screen, "선택한 열차번호가 너무 많습니다. \n300건 이하로 조정해주십시오.");
			return false;
		}
	}
	else
	{
		return false;
	}
	return true;
}

/*
** ========================================================================
** 5. 컨트롤 이벤트 영역
** ========================================================================
*/

//운행기간 달력팝업 버튼클릭 이벤트
function btnPeriodCalendar_on_mouseup(objInst)
{
	KRI.showPeriodCalendar(screen, btnPeriodCalendar, fldRUN_TRM_ST_DT, fldRUN_TRM_CLS_DT);
	
	
	fn_setDayField(fldRUN_TRM_ST_DT, txtFromDay);//요일 셋팅
	fn_setDayField(fldRUN_TRM_CLS_DT, txtToDay);//요일 셋팅
}
//조회 버튼클릭 이벤트
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
function validCheck()
{
	if(fldRUN_DT.gettext() == "")
	{
		KRI.alert(screen, "날짜를 입력하세요");
		fldRUN_DT.setfocus();
		return false;
	}
	if(!KRUtil.checkPeriodDate(fldRUN_TRM_ST_DT.gettext(), fldRUN_TRM_CLS_DT.gettext(), "YYYYMMDD")
	{
	    KRI.alert(screen, "조회시작일자가 조회종료일자보다 클 수 없습니다.");
		fldRUN_TRM_ST_DT.setfocus();
		return false; 
	}
	return true;
}
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
//그리드에서 체크된 행 클릭 시 호출
function grdList_on_checkrowclick(objInst, nRow, bCheckedRow)
{
	var nChkRowCnt = grdList.getcheckedrowcount();
	if(nChkRowCnt > 0)
	{
		btnSave.setenable(true);
	}
	else
	{
		btnSave.setenable(false);
	}
}


//저장버튼클릭 이벤트
function btnSave_on_mouseup(objInst)
{

	if (!validCheckSave())
	{
		return false;
	}
	var nRtn = KRI.messagebox(screen, "저장하시겠습니까?", XFD_MB_OKCANCEL); //저장하시겠습니까?		
	
	if(nRtn == XFD_MB_RESCANCEL || nRtn == "")
	{
		return(false);
	}
	var nRunTrmDno = KRUtil.DateSpecificYYYYMMDD(fldRUN_TRM_ST_DT.gettext(), fldRUN_TRM_CLS_DT.gettext()); 
	dsCond.setdatabyname(0,"RUN_TRM_DNO", nRunTrmDno); 
	
	//CUD 내역 전송 설정
//	KRI.setGridCheck(screen, grdList, true);
//	KRI.setGridCount(screen, grdList, grdList.getcheckedrowcount());
	
	for(var i = 0; i < dsList.getrowcount(); i++)
	{
		var sTrnNo = KRUtil.trim(dsList.getdatabyname(i, "TRN_NO"));
		dsList.setdatabyname(i, "TRN_NO", sTrnNo);
	}		
    // 처리시작 메세지 설정
	KRI.setTranMessage(screen, 0, "처리중입니다..."); //처리중입니다.
		
	KRI.requestSubmit(screen, "/yz/yf/aa/insertAbvTrn.do", true);
	
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
function fldTRN_NO_on_keydown(objInst, keycode, bctrldown, bshiftdown, baltdown, bnumpadkey)
{
	var nTrnNoLen = fldTRN_NO.gettext().length;
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
	objPram.trnNo = fldTRN_NO.gettext();
	//운행일자
	if(screen.getinstancebyname("fldRUN_DT") != undefined)
		objPram.runDt	 = fldRUN_DT.gettext();
	//상하행구분코드
	if(screen.getinstancebyname("cboUP_DN_DV_CD") != undefined)
		objPram.dnDvCd    = cboUP_DN_DV_CD.getselectedcode();
	//YMS적용여부
	if(screen.getinstancebyname("cboYMS_APL_FLG") != undefined)
		objPram.ymsAplFlg = cboYMS_APL_FLG.getselectedcode();
	//열차종코드
	if(screen.getinstancebyname("cboTRN_CLSF_CD") != undefined)
		objPram.trnClsfCd = cboTRN_CLSF_CD.getselectedcode();
	//주운행선/노선 (TBD)
	if(screen.getinstancebyname("ROUT_CD") != undefined)
		objPram.routCd    = ROUT_CD.gettext();

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
	fldTRN_NO.settext(obj.trnNo)
	//상하행구분코드
	if(screen.getinstancebyname("cboUP_DN_DV_CD") != undefined)
		cboUP_DN_DV_CD.setselectedcode(obj.upDnDvCd);
	//YMS적용여부
	if(screen.getinstancebyname("cboYMS_APL_FLG") != undefined)
		cboYMS_APL_FLG.setselectedcode(obj.ymsAplFlg);
	//주운행선/노선 (TBD)
	if(screen.getinstancebyname("ROUT_CD") != undefined)
	//objPram.routCd    = ROUT_CD.gettext();

	return obj;
}

function fn_trn_no_init()
{
	fldTRN_NO.settext("");
}


/*
** ========================================================================
** 열차번호선택(기본) 팝업 관련 스크립트 끝
** ========================================================================
*/
/* 운행기간다시설정 체크시 */
function chkReSearch_on_click(objInst)
{
	if (chkReSearch.getenable())
	{
		fldRUN_TRM_ST_DT.setinputtype(0);
		fldRUN_TRM_CLS_DT.setinputtype(0);
		txtFromDay.setbackcolor(255, 255, 255);
		txtToDay.setbackcolor(255, 255, 255);
		btnPeriodCalendar.setenable(true);
		chkReSearch.setenable(false);
		btnSave.setenable(false);
	    /* GRID CLEAR */
		KRI.setGridMode(screen, grdList, KRConstant.GRID_CLEAR);
	    /* xDataSet 초기화 */	
		dsList.init();
		fldQRY_CNT.settext("");
		mltABV_OCUR_CAUS_CONT.settext("");
	}
	else
	{
		return;
	}
	
			
}
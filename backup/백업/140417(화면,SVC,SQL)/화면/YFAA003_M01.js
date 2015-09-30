/*
** =================================================================================================
** 시 스 템 명 : YZ (수익관리)
** 화  면  ID : YFAA003_M01
** 화  면  명 : 이상원인 및 이상열차정보 관리
** 개      요 : 
** ================================================================================================= 
** << 변경 정보 >>
** -------------------------------------------------------------------------------------------------
** 변 경 일 자  : 변경자 : 변	경	내	역
** -------------------------------------------------------------------------------------------------
** 2014-03-13 : 김응규 : 신규작성
** YYYY-MM-DD :       
** =================================================================================================
*/

/* 
** ========================================================================
** 1. 전역 변수 영역
** ======================================================================== 
*/

var m_chgFlg = "N"; //이상원인목록 그리드 변경여부
var m_chgFlg2 = "N"; //이상열차목록 그리드 변경여부
var m_abvCausGridClickFlg = "Y"; //이상원인그리드클릭여부(이상열차조회 방법을 나누기 위함-Y:그리드클릭으로 조회, N-조회버튼클릭으로 조회)

var m_today = KRUtil.TodayDate(screen);
//var m_stDt = KRUtil.getCalculateMonth(m_today, -72);
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
	KRI.init(screen);	// 화면 초기화 (필수)  // 테스트시에는 주석처리(오류발생)
	//운행기간 기본 셋팅
	fldRUN_TRM_ST_DT.settext(m_today);
	fldRUN_TRM_CLS_DT.settext(m_today);
	//이상열차목록 버튼 활성화 여부
	btnCancel.setenable(false);
	btnSave.setenable(false);
	
	fn_setDayField(fldRUN_TRM_ST_DT, txtFromDay);//요일 셋팅
	fn_setDayField(fldRUN_TRM_CLS_DT, txtToDay);//요일 셋팅
	
	//이상원인목록 조회
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
* 스크린에서 키 입력시
*/
function screen_on_keydown(keycode, bctrldown, bshiftdown, baltdown, bnumpadkey)
{
	if(keycode == 13) //엔터키 입력
	{
		fn_search2_2();
	}
	return 0;
}
/* 
* submit 완료시 호출
*/
function screen_on_submitcomplete(mapid, result, recv_userheader, recv_code, recv_msg)
{
	if (KRI.submitComplete(screen, mapid, result, recv_userheader, recv_code, recv_msg) == false) return;
	if(mapid == "/yz/yf/aa/selectListAbvCaus.do")
	{
		var nRowCnt = grdAbvCausList.getrowcount();
		if (nRowCnt > 0)
		{
			grdAbvCausList.setselectitem(0,0);
			m_chgFlg = "N";
			btnUpdate.setenable(true);
			btnCancel.setenable(false);
			btnSave.setenable(false);
			fldQRY_CNT.settext("총 "+nRowCnt+"건");
			fldQRY_CNT.setvisible(true);
			
			fn_search2_1();
		}
		else
		{
			fldQRY_CNT.settext("");
			fldQRY_CNT.setvisible(true);
			KRI.setTranMessage(screen, 0, "조회결과가 없습니다.");
		}
	
	
	}
	else if(mapid == "/yz/yf/aa/selectListAbvTrn.do")
	{
		var nRowCnt = grdAbvTrnList.getrowcount();
		if(nRowCnt > 0)
		{
			fldQRY_CNT2.setvisible(true);
			fldQRY_CNT2.settext("총 "+nRowCnt+"건");
			btnExcel.setenable(true);
			btnChart.setenable(true);
			btnInsert.setenable(true);
			btnUpdate2.setenable(true);
			btnDelete.setenable(true);
			/*******************비고***************************
			*[이상원인그리드클릭]으로 조회시 운행기간을 null처리하여 조회하고
			*결과값중 첫번째 값의 운행일자를 fldRUN_TRM_ST_DT 로 셋하고
			*마지막 결과 값의 운행일자를 fldRUN_TRM_CLS_DT에 셋함(AS-IS 와 동일하게 처리)
			**************************************************/
			if(m_abvCausGridClickFlg == "Y") 
			{
				var sRunTrmStDt = grdAbvTrnList.getitemtextbyname(0, "RUN_DT");
				var sRunTrmClsDt = grdAbvTrnList.getitemtextbyname(nRowCnt-1, "RUN_DT");
				fldRUN_TRM_ST_DT.settext(sRunTrmStDt);
				fldRUN_TRM_CLS_DT.settext(sRunTrmClsDt);
				fn_setDayField(fldRUN_TRM_ST_DT, txtFromDay);//요일 셋팅
				fn_setDayField(fldRUN_TRM_CLS_DT, txtToDay);//요일 셋팅
			}
			KRI.setTranMessage(screen, 0, "정상적으로 조회 되었습니다.");
		}
		else
		{
			fldQRY_CNT2.setvisible(false);
			fldQRY_CNT2.settext("");
			fldRUN_TRM_ST_DT.settext(m_today);
			fldRUN_TRM_CLS_DT.settext(m_today);
			fn_setDayField(fldRUN_TRM_ST_DT, txtFromDay);//요일 셋팅
			fn_setDayField(fldRUN_TRM_CLS_DT, txtToDay);//요일 셋팅
			btnExcel.setenable(false);
			btnChart.setenable(false);
			btnInsert.setenable(true);
			btnUpdate2.setenable(false);
			btnCancel2.setenable(false);
			btnDelete.setenable(false);
			KRI.setTranMessage(screen, 0, "조회결과가 없습니다.");
		}
	}
	else if(mapid == "/yz/yf/aa/updateAbvCausList.do")
	{
		if(dsMessage.getdatabyname(0, "MSG_CONT") != "")
		{
			KRI.alert(screen, dsMessage.getdatabyname(0, "MSG_CONT"));
		}
		fn_search();
	}
	else if(mapid == "/yz/yf/aa/deleteAbvTrn.do")
	{
//		KRI.alert(screen, "삭제완료");
		fn_search2_2();
	}
	
	else if(mapid == "/yz/yf/aa/updateAbvTrnList.do")
	{
//		KRI.alert(screen, "수정완료");
		fn_search2_2();
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
/*
* 이상원인목록 조회
*/
function fn_search()
{
    /* GRID CLEAR */
	KRI.setGridMode(screen, grdAbvCausList, KRConstant.GRID_CLEAR);
    /* xDataSet 초기화 */	
	dsAbvCausList.init();
	
	
	
	KRI.requestSubmit(screen,"/yz/yf/aa/selectListAbvCaus.do",true);
    
	/* 조회 중 중단 가능하도록 화면에 포커스를 지정 */
	screen.setfocus();
}

/*
* 이상열차정보 조회(그리드 클릭 조회)
*/
function fn_search2_1()
{
    /* GRID CLEAR */
	KRI.setGridMode(screen, grdAbvTrnList, KRConstant.GRID_CLEAR);
    /* xDataSet 초기화 */	
	dsAbvTrnList.init();
	
	/* 검색조건(dsCond) 셋 */
	dsCond.setdatabyname(0, "ABV_TRN_SRT_CD", dsAbvCausList.getdatabyname(grdAbvCausList.getselectrow(), "ABV_TRN_SRT_CD"));
	dsCond.setdatabyname(0, "RUN_TRM_ST_DT", "");
	dsCond.setdatabyname(0, "RUN_TRM_CLS_DT", "");
	
	m_abvCausGridClickFlg = "Y";
	KRI.requestSubmit(screen,"/yz/yf/aa/selectListAbvTrn.do",true);

	
    /* 조회 중 중단 가능하도록 화면에 포커스를 지정 */
	screen.setfocus();
}


/*
* 이상열차정보 조회(조회버튼 클릭 조회)
*/
function fn_search2_2()
{
	//validation 체크
	var bValidDate = KRUtil.checkPeriodDate(fldRUN_TRM_ST_DT.gettext(), fldRUN_TRM_CLS_DT.gettext(), "YYYYMMDD", false);
	if(!bValidDate)
	{
		KRI.alert(screen, "비정상적인 날짜입니다. 날짜를 다시 입력해주십시오.");
		fldRUN_TRM_ST_DT.setfocus();
		return false;
	}
	
	
    /* GRID CLEAR */
	KRI.setGridMode(screen, grdAbvTrnList, KRConstant.GRID_CLEAR);
    /* xDataSet 초기화 */	
	dsAbvTrnList.init();
	
	/* 검색조건(dsCond) 셋 */
	dsCond.setdatabyname(0, "ABV_TRN_SRT_CD", dsAbvCausList.getdatabyname(grdAbvCausList.getselectrow(), "ABV_TRN_SRT_CD"));
	dsCond.setdatabyname(0, "RUN_TRM_ST_DT", fldRUN_TRM_ST_DT.gettext());
	dsCond.setdatabyname(0, "RUN_TRM_CLS_DT", fldRUN_TRM_CLS_DT.gettext());
	//dsCond.setdatabyname(0, "TRN_NO","%");
	
	m_abvCausGridClickFlg = "N"
	KRI.requestSubmit(screen,"/yz/yf/aa/selectListAbvTrn.do",true);

	
    /* 조회 중 중단 가능하도록 화면에 포커스를 지정 */
	screen.setfocus();
}

/**
 * 칼럼을 특정 위치에 추가하고 추가된 칼럼에 대한 속성을 지정한다.
 * @param objGrid 그리드 오브젝트
 * @param bEditable 추가된 로우의 편집 모드로 바로 시작할 지 여부
 * @return 
 *    nRowIndex 추가된 로우 인덱스 (Zero-Base)
 */
function fn_addGridItem(objGrid, bEditStart)
{
    var nRowIndex;
    var i;
	
    // 그리드에 맨 마지막에 로우 추가
    var nRowIndex = objGrid.additem();

    // 편집 시작 여부가 false이면 바로 리턴
    if(bEditStart == false) {
        return nRowIndex;
    }
	
    // 칼럼 갯수를 구함
    var nColumnCount = objGrid.getcolumncount();
					
    // 칼럼 카운트 만큼 돌면서, 편집 가능한 칼럼을 편집 모드로 시작함.
    for(i = 0; i < nColumnCount; i++) {
        // 칼럼 편집 가능 속성 여부 검사
        if(objGrid.getcolumneditable(i) == true) {
            // 편집 모드로 들어감
            objGrid.setitemeditstart(nRowIndex, i, bEditStart);
            break;
        }
    }
	
    return nRowIndex;
}


function setGridItemEditable(oGrid, nRow, sColumnName, bEditable)
{
	oGrid.setitemeditable(nRow, oGrid.getcolumn(sColumnName), bEditable);
	if (bEditable)
	{
		//oGrid.setitembackcolor(nRow, oGrid.getcolumn(sColumnName), factory.rgb(244,253,255));
		/*입력컬럼 흰색으로 변경*/
		oGrid.setitembackcolor(nRow, oGrid.getcolumn(sColumnName), factory.rgb(255,255,255));
	}
	else
	{
		oGrid.setitembackcolor(nRow, oGrid.getcolumn(sColumnName), factory.rgb(255,255,255));
	}	
}

function fn_validateAll()
{
	//변경여부 체크
	for( var i = 0 ; i < grdAbvCausList.getrowcount() ; i++ )
	{
		if(grdAbvCausList.getitemtext(i, 0) != "")
		{
			for(var j = 0 ; j < 2 ; j++)
			{
				if(grdAbvCausList.getitemtext(i, j) == "")
				{
					KRI.setTranMessage(screen, 1, grdAbvCausList.getheadertext(0, j) + "은(는) 필수입력항목입니다.");
					//해당열로 커서 이동
					grdAbvCausList.setselectitem(i, j);
					grdAbvCausList.setitemeditstart(i, j, true);
					return false;
				}
			}
		}
	}	
}


//수정버튼 클릭시 (PK는 수정불가하도록 처리)
function fn_btnUpdate_on_mousup(oGrid, btnUpdate, btnCancel, btnSave)
{
	var nFstRow = 0;
	for(var j=0 ; j < oGrid.getrowcount() ; j++)
	{	
		if(oGrid.getitemtext(j, oGrid.getcolumn("DMN_PRS_DV_CD")) == "")
		{
			if(nFstRow == 0) nFstRow = j;
		
			for(var i=0 ; i < oGrid.getcolumncount() ; i++)
			{
				//요청처리구분코드, 이상원인코드, 운행일자, 열차번호는 수정 불가
				if(i != oGrid.getcolumn("DMN_PRS_DV_CD") && i != oGrid.getcolumn("ABV_TRN_SRT_CD")
				 && i != oGrid.getcolumn("RUN_DT") && i != oGrid.getcolumn("TRN_NO"))
				{
					setGridItemEditable(oGrid, j, oGrid.getcolumnname(i), true);
				}
			}	
		}
	}
	
	if(oGrid.getitemtext(oGrid.getselectrow(), oGrid.getcolumn("DMD_PRS_DV_CD")) != "")
	{
		oGrid.setselectitem(nFstRow, 0);
	}
	
	//첫열로 커서 이동
	oGrid.setselectitem(oGrid.getselectrow(), 0);
	oGrid.setitemeditstart(oGrid.getselectrow(), 0, true);
	
	btnUpdate.setenable(false);
	btnCancel.setenable(true);
	btnSave.setenable(true);	
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

/*
** ========================================================================
** 5. 컨트롤 이벤트 영역
** ========================================================================
*/
//운행기간 달력팝업 버튼클릭 이벤트
function btnPeriodCalendar_on_mouseup(objInst)
{
	KRI.showPeriodCalendar(screen, btnPeriodCalendar, fldRUN_TRM_ST_DT, fldRUN_TRM_CLS_DT);
	fn_setDayField(fldRUN_TRM_ST_DT, txtFromDay);
	fn_setDayField(fldRUN_TRM_CLS_DT, txtToDay);
}


/*
*  이상원인목록 그리드클릭
*  이상열차목록을 조회한다. 
*  그리드 입력/수정 중일 때는 조회하지 않는다.
*/
function grdAbvCausList_on_itemclick(objInst, nClickRow, nClickColumn)
{
	if(m_chgFlg == "N") //그리드 편집중일때는 이상열차목록을 조회하지 않는다.
	{
		fn_search2_1();
	}
	
}

/*
*  조회 버튼클릭 이벤트
*  이상열차목록을 조회한다. 
*/
function btnSearch_on_mouseup(objInst)
{
	//validation 체크
	if(validCheck())
	{
		fn_search2_2();
	}else 
		return false;
}
/*
*  이상원인목록 행추가 버튼클릭 이벤트
*  이상원인목록의 행을 추가한다. 
*/
function btnAdd_on_mouseup(objInst)
{
	//행을 하나 추가
	var nRow = fn_addGridItem(grdAbvCausList, true);
	
	//row별 처리구분 지정(요청처리구분코드 I : insert, U : update, D : delete)
	dsAbvCausList.setdatabyname(nRow, "DMN_PRS_DV_CD", "I");
	
	//행추가 상태 아이콘 추가
	grdAbvCausList.setitemimage(nRow, 0, "/IMG/BTN/Grid_add.png");
	for(var i=0;i<grdAbvCausList.getcolumncount();i++)
	{
		setGridItemEditable(grdAbvCausList, nRow, grdAbvCausList.getcolumnname(i), true);
	}
	setGridItemEditable(grdAbvCausList, nRow, grdAbvCausList.getcolumnname(1), true);
	setGridItemEditable(grdAbvCausList, nRow, grdAbvCausList.getcolumnname(0), true);
	
	//첫열로 커서 이동
	grdAbvCausList.setselectitem(nRow, 1);
	grdAbvCausList.setitemeditstart(nRow, 0, true);
	m_chgFlg = "Y";
	btnCancel.setenable(true);
	btnSave.setenable(true);
}

//이상열차목록 행삭제 버튼클릭이벤트
function btnDel_on_mouseup(objInst)
{
	var nRow = grdAbvCausList.getselectrow();
	//행추가된 row가 아니면 삭제아이콘표시
	if(grdAbvCausList.getitemtext(nRow, grdAbvCausList.getcolumn("DMN_PRS_DV_CD")) != "I")
	{
		grdAbvCausList.setitemimage(nRow, 0, "/IMG/BTN/Grid_del.png");
		grdAbvCausList.setitemtext(nRow, grdAbvCausList.getcolumn("DMN_PRS_DV_CD"), "D");
		m_chgFlg = "Y";		
	}
	//행추가된 row이면 그리드에서 삭제
	else
	{
		grdAbvCausList.deleterow(nRow);
	}

	if(m_chgFlg == "Y")
	{
		btnCancel.setenable(true);
		btnSave.setenable(true);
	}
}

/*
*  이상원인목록 수정 버튼클릭 이벤트
*  이상원인목록그리드의 상태를 Editable true 상태로 변경한다.
*/
function btnUpdate_on_mouseup(objInst)
{
	m_chgFlg = "Y"
	fn_btnUpdate_on_mousup(grdAbvCausList, btnUpdate, btnCancel, btnSave);	
}

/*
*  이상원인목록 취소 버튼클릭 이벤트
*  이상원인목록에서 입력/수정 중이던 작업을 취소하고 이전 상태로 그리드를 되돌린다.
*/
function btnCancel_on_mouseup(objInst)
{
	if(m_chgFlg == "Y")
	{
		var nRtn = KRI.messagebox(screen, "취소하시겠습니까?", XFD_MB_OKCANCEL);	

		if(nRtn == XFD_MB_RESCANCEL || nRtn == "")
		{
			return(false);
		}
		m_chgFlg = "N"; //그리드 변경여부 초기화
	}
	btnCancel.setenable(false);
	btnSave.setenable(false);
	btnUpdate.setenable(true);
	fn_search();
}

/*
*  이상원인목록 저장 버튼클릭 이벤트
*  이상원인목록에서 입력/수정 중이던 작업을 저장한다.
*/
function btnSave_on_mouseup(objInst)
{
	var bRet = KRI.validate_grid(screen, grdAbvCausList, 2, 
       [{
		    colidx: 0,  
		    rules: 'required'
		}, {
		    colidx: 1,  
		    rules: 'required'
		}
		]);

	if(bRet == false)
	{
		return;
	}
	
	var nRtn = KRI.messagebox(screen, "저장하시겠습니까?", XFD_MB_OKCANCEL); //저장하시겠습니까?		
	
	if(nRtn == XFD_MB_RESCANCEL || nRtn == "")
	{
		return(false);
	}
	
	//KRDataset.debug(dsAbvCausList);
	//CUD 내역 전송 설정
	KRI.setGridCheck(screen, grdAbvCausList, true);
	KRI.setGridCount(screen, grdAbvCausList, grdAbvCausList.getcheckedrowcount());
		
    // 처리시작 메세지 설정
	KRI.setTranMessage(screen, 0, "처리중입니다..."); //처리중입니다.
		
	KRI.requestSubmit(screen, "/yz/yf/aa/updateAbvCausList.do", true);

}

//엑셀 버튼클릭이벤트
function btnExcel_on_mouseup(objInst)
{
	grdAbvTrnList.saveexcel();
}

//차트조회 버튼클릭이벤트
function btnChart_on_mouseup(objInst)
{
	//팝업 호출
	//조회조건 popupPram에 담아서 팝업으로 보냄
	var nRow = grdAbvTrnList.getselectrow();
	
	KRI.setLinkValue("RUN_DT",grdAbvTrnList.getitemtextbyname(nRow, "RUN_DT"));
	KRI.setLinkValue("TRN_NO",grdAbvTrnList.getitemtextbyname(nRow, "TRN_NO"));

	var popupUrl="/BIZ/YZ/YF/AA/YFAA003_P01";
	KRI.loadSystemPopup(screen, popupUrl, true);
}

//이상열차정보 등록 버튼클릭이벤트
function btnInsert_on_mouseup(objInst)
{
	//팝업 호출
	//조회조건 popupPram에 담아서 팝업으로 보냄
	var nRow = grdAbvCausList.getselectrow();
	
	KRI.setLinkValue("RUN_TRM_ST_DT", fldRUN_TRM_ST_DT.gettext()); //운행기간시작일자
	KRI.setLinkValue("RUN_TRM_CLS_DT", fldRUN_TRM_CLS_DT.gettext()); //운행기간종료일자
	KRI.setLinkValue("ABV_TRN_SRT_CD",grdAbvCausList.getitemtextbyname(nRow, "ABV_TRN_SRT_CD"));//이상원인분류코드

	var popupUrl="/BIZ/YZ/YF/AA/YFAA003_E01";
	KRI.loadSystemPopup(screen, popupUrl, true);
	
	//팝업화면이 종료된 후의 수행
	var saveFlg = KRI.getLinkValue("saveFlg");
	var sRunTrmStDt = KRI.getLinkValue("RUN_TRM_ST_DT")
	var sRunTrmClsDt = KRI.getLinkValue("RUN_TRM_CLS_DT");
	KRI.clearLinkValue();  
	if(saveFlg == "Y")
	{
		fldRUN_TRM_ST_DT.settext(sRunTrmStDt);
		fldRUN_TRM_CLS_DT.settext(sRunTrmClsDt);
		fn_setDayField(fldRUN_TRM_ST_DT, txtFromDay);//요일 셋팅
		fn_setDayField(fldRUN_TRM_CLS_DT, txtToDay);//요일 셋팅	
		fn_search2_2();
	}
}

//이상열차목록 수정 버튼클릭 이벤트
function btnUpdate2_on_mouseup(objInst)
{
	fn_btnUpdate_on_mousup(grdAbvTrnList, btnUpdate2, btnCancel2, btnSave2);
}


//이상열차정보 취소 버튼클릭이벤트
function btnCancel2_on_mouseup(objInst)
{
	if(m_chgFlg2 == "Y")
	{
		var nRtn = KRI.messagebox(screen, "취소하시겠습니까?", XFD_MB_OKCANCEL);	

		if(nRtn == XFD_MB_RESCANCEL || nRtn == "")
		{
			return(false);
		}
		m_chgFlg2 = "N"; //그리드 변경여부 초기화
	}
	btnCancel2.setenable(false);
	btnSave2.setenable(false);
	btnUpdate2.setenable(true);
	fn_search2_2();
}

//이상열차정보 삭제 버튼클릭이벤트
function btnDelete_on_mouseup(objInst)
{
	/* 단건 삭제 */
//	var nRow = grdAbvTrnList.getselectrow();
//	grdAbvTrnList.setcheckedrow(nRow, true);
	/* 다건 삭제 */
	var nStartRow = grdAbvTrnList.getselectrowfirst();
	var cnt = 0;
	KRLog.trace("nStartRow:::::::::::"+nStartRow);
	grdAbvTrnList.setcheckedrow(nStartRow, true);
	var nSelectRow = 0;
	while (nSelectRow != -1)
	{
		cnt++; 
		nSelectRow = grdAbvTrnList.getselectrownext(nStartRow);
		KRLog.trace("nSelectRow:::::::::::"+nSelectRow+"["+cnt+"]번째");
		if(nSelectRow == -1)
		{
			break;
		}
		grdAbvTrnList.setcheckedrow(nSelectRow, true);
		nStartRow = nSelectRow + 1;
	}
	KRLog.trace("체크로우수:::::::::::"+grdAbvTrnList.getcheckedrowcount());
	
	var nRtn = KRI.messagebox(screen, "삭제하시겠습니까?", XFD_MB_OKCANCEL);	
	if (nRtn == XFD_MB_RESCANCEL || nRtn == "")
	{
		return(false);
	}
	
	
    // 처리시작 메세지 설정
	KRI.setTranMessage(screen, 0, "처리중입니다..."); //처리중입니다.
		
	KRI.requestSubmit(screen, "/yz/yf/aa/deleteAbvTrn.do", true);
	
}

//이상열차정보 저장 버튼클릭이벤트
function btnSave2_on_mouseup(objInst)
{
	var bRet = KRI.validate_grid(screen, grdAbvTrnList, 3, 
       [{
		    colidx: 2,  
		    rules: 'required'
		}
		]);

	if(bRet == false)
	{
		return;
	}
	
	var nRtn = KRI.messagebox(screen, "저장하시겠습니까?", XFD_MB_OKCANCEL); //저장하시겠습니까?		
	
	if(nRtn == XFD_MB_RESCANCEL || nRtn == "")
	{
		return(false);
	}
	
	//KRDataset.debug(dsAbvCausList);
	//CUD 내역 전송 설정
	KRI.setGridCheck(screen, grdAbvTrnList, true);
	KRI.setGridCount(screen, grdAbvTrnList, grdAbvTrnList.getcheckedrowcount());
		
    // 처리시작 메세지 설정
	KRI.setTranMessage(screen, 0, "처리중입니다..."); //처리중입니다.
		
	KRI.requestSubmit(screen, "/yz/yf/aa/updateAbvTrnList.do", true);

}

//이상원인 목록 그리드 수정완료 이벤트
//이상원인 목록 수정을 완료하면 DMN_PRS_DV_CD를 "U"(update)로 셋
function grdAbvCausList_on_itemeditcomplete(objInst, nRow, nColumn, strPrevItemText)
{
	if(grdAbvCausList.getitemtext(nRow, nColumn) != strPrevItemText && grdAbvCausList.getitemtext(nRow, grdAbvCausList.getcolumn("DMN_PRS_DV_CD")) != "I")
	{
		grdAbvCausList.setitemtext(nRow, grdAbvCausList.getcolumn("DMN_PRS_DV_CD"), "U");
		grdAbvCausList.setitemimage(nRow, 0, "/IMG/BTN/Grid_write.png");
	}
	return 1;
}

//이상열차 목록 그리드 수정완료 이벤트
//이상열차 목록 수정을 완료하면 DMN_PRS_DV_CD를 "U"(update)로 셋
function grdAbvTrnList_on_itemeditcomplete(objInst, nRow, nColumn, strPrevItemText)
{
	if(grdAbvTrnList.getitemtext(nRow, nColumn) != strPrevItemText)
	{
		grdAbvTrnList.setitemtext(nRow, grdAbvTrnList.getcolumn("DMN_PRS_DV_CD"), "U");
		grdAbvTrnList.setitemimage(nRow, 0, "/IMG/BTN/Grid_write.png");
	}
	return 1;
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
			fn_search2_2();
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
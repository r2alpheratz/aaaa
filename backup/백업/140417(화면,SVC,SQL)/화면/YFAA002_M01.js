/*
** =================================================================================================
** 시 스 템 명 : RZ (예약발매)
** 화  면  ID : YFAA002_M01			
** 화  면  명 : DSP별 비정상판단비율 조회
** 개      요 : DSP별로 기준값과 긴급, 주의, 보통별 비정상 열차 판단 비율을 보여준다.(상한비율, 하한비율)
** ================================================================================================= 
** << 변경 정보 >>
** -------------------------------------------------------------------------------------------------
** 변 경 일 자  : 변경자 : 변	경	내	역
** -------------------------------------------------------------------------------------------------
** 0000-00-00 : 나윤채 : 신규작성
** YYYY-MM-DD : 2014-03-25      
** =================================================================================================
*/

/* 
** ========================================================================
** 1. 전역 변수 영역
** ======================================================================== 
*/

var m_UpdateFlg = false;	

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
	cboLUMP_APL_TGT.setselectedindex(0);
	cboLUMP_APL_TGT_DV.setselectedindex(0);
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

	if (mapid == "/yz/yf/aa/updateNonNmlPct.do")
	{
		m_UpdateFlg = true;
		fn_search();	
	}
	
	if (mapid == "/yz/yf/aa/selectListNonNmlPct.do" )
	{
		var nRowCnt = grdList.getrowcount();
			
		if (m_UpdateFlg)
		{	
			/*수정결과 메시지*/
			KRI.setTranMessage(screen, 0, "정상적으로 수정 되었습니다.");	
		}
		else 
		{
			if (nRowCnt > 0)
			{	
				/*조회결과 메시지*/
				KRI.setTranMessage(screen, 0, "정상적으로 조회 되었습니다.");
			}
			else 
			{
				/* 조회결과가 0건 */
				KRI.setTranMessage(screen, 0, "조회결과가 없습니다.");		
			}
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

/*	화면 초기화	*/
function fn_search()
{
	/* GRID CLEAR */
	KRI.setGridMode(screen, grdList, KRConstant.GRID_CLEAR);
    /* xDataSet 초기화 */	
	dsList.init();
	/* GRID 리스트 출력*/
	KRI.requestSubmit(screen,"/yz/yf/aa/selectListNonNmlPct.do",true);
}

/*	버튼 초기화	*/
function fn_buttonReset()
{
	btnCancel.setenable(false);
	btnSave.setenable(false);
	btnUpdate.setenable(true);
}

/*	수정,삭제 대상의 위치를 잡기 위한 표식	*/
function fn_gridFlag(i)
{
	grdList.setitemtext(i, grdList.getcolumn("DMN_PRS_DV_CD"), "U");
	grdList.setitemimage(i, 0, "/IMG/BTN/Grid_write.png");
}

/*
** ========================================================================
** 5. 컨트롤 이벤트 영역
** ========================================================================
*/

/*	상하한비율 적용 버튼 클릭	*/
function btnLUMP_APL_on_mouseup(objInst)
{
	/*	숫자 입력가능범위 체크	*/
	if (fldLUMP_APL_VAL_INP.gettext() > 1 || fldLUMP_APL_VAL_INP.gettext() < 0)
	{
		KRI.alert(screen, "입력 가능한 범위는 0~1 입니다");
		fldLUMP_APL_VAL_INP.setfocus();
		return false;
	}	

	var sLumpAplTgt = cboLUMP_APL_TGT.getselectedcode();
	var sLumpAplTgtDv = cboLUMP_APL_TGT_DV.getselectedcode();

	sVals = Number (fldLUMP_APL_VAL_INP.gettext());
	/*	소수점 둘째자리 까지 비어있을 경우 0으로 채움	*/
	sVal = sVals.toFixed(2);
	sMVal = (1-sVal).toFixed(2);
	
	/*	grdList 그리드에 일괄수정 값을 상/하한 쌍으로 갱신	*/
	for( var i =0; i < grdList.getrowcount(); i+=1)
	{
		if(sLumpAplTgt=="URG")
		{
			if(sLumpAplTgtDv=="EXCS")
			{
				dsList.setdatabyname(i,"URG_ULMT_EXCS_PCT",sVal);
				dsList.setdatabyname(i,"URG_LLMT_UNDR_PCT",sMVal);
				fn_gridFlag(i);
			}
			else
			{
				dsList.setdatabyname(i,"URG_LLMT_UNDR_PCT",sVal);
				dsList.setdatabyname(i,"URG_ULMT_EXCS_PCT",sMVal);
				fn_gridFlag(i);
			}
		}
		else if(sLumpAplTgt=="CARE")
		{
			if(sLumpAplTgtDv=="EXCS")
			{
				dsList.setdatabyname(i,"CARE_ULMT_EXCS_PCT",sVal);
				dsList.setdatabyname(i,"CARE_LLMT_UNDR_PCT",sMVal);
				fn_gridFlag(i);
			}
			else
			{
				dsList.setdatabyname(i,"CARE_LLMT_UNDR_PCT",sVal);
				dsList.setdatabyname(i,"CARE_ULMT_EXCS_PCT",sMVal);
				fn_gridFlag(i);
			}
		}
		else if(sLumpAplTgt=="CMNS")
		{
			if(sLumpAplTgtDv=="EXCS")
			{
				dsList.setdatabyname(i,"CMNS_ULMT_EXCS_PCT",sVal);
				dsList.setdatabyname(i,"CMNS_LLMT_UNDR_PCT",sMVal);
				fn_gridFlag(i);
			}
			else
			{
				dsList.setdatabyname(i,"CMNS_LLMT_UNDR_PCT",sVal);
				dsList.setdatabyname(i,"CMNS_ULMT_EXCS_PCT",sMVal);
				fn_gridFlag(i);
			}
		}
	}//end for
	
	btnSave.setenable(true);
	btnCancel.setenable(true);
	btnUpdate.setenable(true);
}

/*	취소 버튼 클릭 이벤트	*/
function btnCancel_on_mouseup(objInst)
{
	var nRtn = KRI.messagebox(screen, "취소하시겠습니까?", XFD_MB_OKCANCEL);	
	
	if(nRtn == XFD_MB_RESCANCEL || nRtn == "")
	{
		return(false);	
	}
	
	m_UpdateFlg = false;
	fn_search();		
	fn_buttonReset();
}

/*	저장 버튼 클릭 이벤트	*/
function btnSave_on_mouseup(objInst)
{

	var nRtn = KRI.messagebox(screen, "저장하시겠습니까?", XFD_MB_OKCANCEL); //저장하시겠습니까?		
	
	if(nRtn == XFD_MB_RESCANCEL || nRtn == "")
	{
		return(false);
	}
	
	/*	처리시작 메세지 설정	*/
	KRI.setTranMessage(screen, 0, "처리중입니다..."); //처리중입니다.
	KRI.requestSubmit(screen, "/yz/yf/aa/updateNonNmlPct.do", true);
	fn_buttonReset();
}

/*	수정 버튼 클릭 이벤트	*/
function btnUpdate_on_mouseup(objInst)
{
	var nFstRow = 0;
	for(var j=0 ; j < grdList.getrowcount() ; j++)
	{	
		if(grdList.getitemtext(j, grdList.getcolumn("DMD_PRS_DV_CD")) == "")
		{
			if(nFstRow == 0) nFstRow = j;
		
			for(var i=0 ; i < grdList.getcolumncount() ; i++)
			{
				/*	DSP구분, 기준 열은 수정 불가	*/
				if(i != grdList.getcolumn("DASP_DV_NO") && i != grdList.getcolumn("DASP_DV_STDR_PCT"))
				{
					KRI.setGridItemEditable(grdList, j, grdList.getcolumnname(i), true);
				}
			}//
		}
	}
	
	if(grdList.getitemtext(grdList.getselectrow(), grdList.getcolumn("DMN_PRS_DV_CD")) != "")
	{
		grdList.setselectitem(nFstRow, 0);
	}
	
	/*	첫열로 커서 이동	*/
	grdList.setselectitem(grdList.getselectrow(), 0);
	grdList.setitemeditstart(grdList.getselectrow(), 0, true);
	
	btnCancel.setenable(true);
	btnSave.setenable(true);
	btnUpdate.setenable(false);
	

}

function grdList_on_itemeditcomplete(objInst, nRow, nColumn, strPrevItemText)
{
	/*수정 대상 row 체크*/
	if(grdList.getitemtext(nRow, nColumn) != strPrevItemText)
	{
		grdList.setitemtext(nRow, grdList.getcolumn("DMN_PRS_DV_CD"), "U");
		grdList.setitemimage(nRow, 0, "/IMG/BTN/Grid_write.png");
	}
	
	/*	숫자 입력가능범위 체크	*/
	if (grdList.getitemtext(nRow,nColumn) > 1 || grdList.getitemtext(nRow,nColumn) < 0)
	{
		KRI.alert(screen, "입력 가능한 범위는 0~1 입니다");
		grdList.setitemtext(nRow,nColumn,strPrevItemText);
		return false;
	}	
	
	/* 개별 수정시 상/하한 합이 1이 되도록 조정 */
	grdList.setitemtext(nRow,nColumn, Number(grdList.getitemtext( nRow, nColumn )).toFixed(2));
	
	if (grdList.getcolumnname(nColumn) == "URG_ULMT_EXCS_PCT" )
	{
		 grdList.setitemtextbyname(nRow,"URG_LLMT_UNDR_PCT",Number(1-grdList.getitemtext( nRow, nColumn )).toFixed(2));
	}
	else if(grdList.getcolumnname(nColumn) == "URG_LLMT_UNDR_PCT" )
	{
		 grdList.setitemtextbyname(nRow,"URG_ULMT_EXCS_PCT",Number(1-grdList.getitemtext( nRow, nColumn )).toFixed(2));
	}else if(grdList.getcolumnname(nColumn) == "CARE_ULMT_EXCS_PCT" )
	{
		 grdList.setitemtextbyname(nRow,"CARE_LLMT_UNDR_PCT",Number(1-grdList.getitemtext( nRow, nColumn )).toFixed(2));
	}else if(grdList.getcolumnname(nColumn) == "CARE_LLMT_UNDR_PCT" )
	{
		 grdList.setitemtextbyname(nRow,"CARE_ULMT_EXCS_PCT",Number(1-grdList.getitemtext( nRow, nColumn )).toFixed(2));
	}else if(grdList.getcolumnname(nColumn) == "CMNS_ULMT_EXCS_PCT" )
	{
		 grdList.setitemtextbyname(nRow,"CMNS_LLMT_UNDR_PCT",Number(1-grdList.getitemtext( nRow, nColumn )).toFixed(2));
	}else if(grdList.getcolumnname(nColumn) == "CMNS_LLMT_UNDR_PCT" )
	{
		 grdList.setitemtextbyname(nRow,"CMNS_ULMT_EXCS_PCT",Number(1-grdList.getitemtext( nRow, nColumn )).toFixed(2));
	}
	
	return 1;
}


function btnPopup_on_mouseup(objInst)
{
	KRI.setLinkValue("dsList",dsList);
	/*	팝업 호출	*/
	var popupUrl = "/BIZ/YZ/YF/AA/YFAA002_P01";
	KRI.loadSystemPopup(screen, popupUrl, true);
}

function fldLUMP_APL_VAL_INP_on_keydown(objInst, keycode, bctrldown, bshiftdown, baltdown, bnumpadkey)
{
	if(fldLUMP_APL_VAL_INP.gettext() =='')
	{
		btnLUMP_APL.setenable(false);
	}else{
		btnLUMP_APL.setenable(true);
	};
	return 0;
}
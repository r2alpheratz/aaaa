/*
** =================================================================================================
** 시 스 템 명 : YS (의사결정지원)
** 화  면  ID : YSAA002_P02
** 화  면  명 : 최적화 구간별 할당결과조회
** 개      요 : 최적화 구간별 할당결과조회를 조회한다
** ================================================================================================= 
** << 변경 정보 >>
** -------------------------------------------------------------------------------------------------
** 변 경 일 자  : 변경자 : 변	경	내	역
** -------------------------------------------------------------------------------------------------
** 2014-04-11 : 한현섭 : 신규작성
** YYYY-MM-DD :  
** =================================================================================================
*/

/* 
** ========================================================================
** 1. 전역 변수 영역
** ======================================================================== 
*/
	var m_objYZCmmnUtil = KRI.getTeamModule(screen, "YZ", "YZCmmnUtil");

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
	KRI.init(screen);	// 화면 초기화 (필수) 로컬테스트 에러?
	fldQRY_CNT_FLD.setinputtype(2);
	m_objYZCmmnUtil.fn_calendar_init(screen, "m_objYZCmmnUtil");
	fn_make_fld_get_all();
	fn_get_prams_from_parent_and_ajax();
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
	if ("/yz/ys/aa/selectListQtmzSgmpAlcCnqe.do")
	{

	}
	fldQRY_CNT_FLD.settext("총 " + grdList.getrowcount() +" 건");	
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

}


/*
** ========================================================================
** 4. 사용자 정의 함수 영역
** ========================================================================
*/
function fn_make_all_code(objComboInst, strParam){
	objComboInst.insertstring(0, strParam);
	objComboInst.setselectedindex(0);
}

function fn_call_trn_no_popup()
{
	var callType = "BASE"
	var popupUrl="/BIZ/YZ/YB/CO/YBCO002_P01";
	m_objYZCmmnUtil.trnNoBsPopupCall(screen, callType, popupUrl);
	m_objYZCmmnUtil.yz_comm_set_select_seg_list(screen);
	grdList.deleteall();

}

function fn_make_fld_get_all()
{
	fn_make_all_code(cboPSRM_CL_CD, "%:전체");
	fn_make_all_code(cboSEAT_ATT_CD, "%:전체");	
	fn_make_all_code(cboUDWN_DV_CD, "%:상하행");
	cboUDWN_DV_CD.deletestring(1);
	fn_make_all_code(cboZONE_SEG_GP_NO, "%:전체");
	cboACVM_RT.setselectedcode("0");
}

function fn_get_prams_from_parent_and_ajax()
{
	var sYmgtJobId = KRI.getLinkValue("YMGT_JOB_ID");
	var sRunDt = KRI.getLinkValue("RUN_DT");
	var sTrnNo = KRI.getLinkValue("TRN_NO");
	dsOptSeqCondition.setdatabyname(0, "YMGT_JOB_ID", sYmgtJobId);
	dsOptSeqCondition.setdatabyname(0, "TRN_NO", sTrnNo);
	dsOptSeqCondition.setdatabyname(0, "RUN_DT", sRunDt);
	
	fldRUN_DT.settext(sRunDt);
	fldTRN_NO.settext(sTrnNo);
	KRLog.trace("(받음)YMGT_JOB_ID :::::::"+sYmgtJobId);
	KRLog.trace("(받음)TRN_NO :::::::"+sRunDt);
	KRLog.trace("(받음)RUN_DT :::::::"+sTrnNo);
	
	//dsOptSeqCondition.setdatabyname(0, "YMGT_JOB_ID", "B_YD2301120130204001");
	//dsOptSeqCondition.setdatabyname(0, "TRN_NO", "00152");
	//dsOptSeqCondition.setdatabyname(0, "RUN_DT", "20130304");
	//dsOptSeqCondition.setdatabyname(0, "BKCL_CD", "F1");	
	//아마 기타 속성들을 '전체'로해서 날리는듯
	
	KRI.requestSubmit(screen, "/yz/ys/aa/selectListQtmzSgmpAlcCnqe.do", true);
	m_objYZCmmnUtil.yz_comm_set_select_seg_list(screen, true);
}


/*
** ========================================================================
** 5. 컨트롤 이벤트 영역
** ========================================================================
*/

function trnBtn_on_mouseup(objInst)
{
	 fn_call_trn_no_popup();
}
function fldTRN_NO_on_keydown(objInst, keycode, bctrldown, bshiftdown, baltdown, bnumpadkey)
{
	if(keycode == '13')
	{
		 fn_call_trn_no_popup();
	}
}

function btnSearch_on_mouseup(objInst)
{
	KRI.requestSubmit(screen, "/yz/ys/aa/selectListQtmzSgmpAlcCnqe.do", true);
	m_objYZCmmnUtil.yz_comm_set_select_seg_list(screen, false);
}



function cboZONE_SEG_GP_NO_on_focusout(objInst)
{
	 m_objYZCmmnUtil.yz_comm_set_select_seg_list(screen);
}
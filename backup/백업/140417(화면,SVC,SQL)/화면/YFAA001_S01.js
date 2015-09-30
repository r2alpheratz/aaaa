/*
** =================================================================================================
** 시 스 템 명 : YZ (수익관리)
** 화  면  ID : YFAA001_S01
** 화  면  명 : 역그룹 조회
** 개      요 : 
** ================================================================================================= 
** << 변경 정보 >>
** -------------------------------------------------------------------------------------------------
** 변 경 일 자  : 변경자 : 변	경	내	역
** -------------------------------------------------------------------------------------------------
** 2014-03-01 : 김응규 : 신규작성
** YYYY-MM-DD :       
** =================================================================================================
*/

/* 
** ========================================================================
** 1. 전역 변수 영역
** ======================================================================== 
*/
//var bContinue = true; //페이징처리시 필요한 전역변서

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
	KRI.init(screen);	// 화면 초기화 (필수) //로컬에서 테스트시 에러발생으로 주석처리
	STGP_CD.insertstring(0, ":전체");
	STGP_CD.setselectedindex(0);
	TRN_CLSF_CD.setselectedindex(0);
	STGP_CD.setfocus();
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
	if (KRI.submitComplete(screen, mapid, result, recv_userheader, recv_code, recv_msg) == false) return;
	if(mapid == "/yz/yf/aa/selectListStgpInfo.do")
	{
		var nRowCnt = grdList.getrowcount();
//		QRY_CNT_FLD.settext("총 "+grdList.getrowcount()+"/"+dsCond.getdatabyname(0,"TOT_CNT") +"건");
		if (nRowCnt > 0)
		{
			fldQRY_CNT.settext("총 "+nRowCnt+"건");
			fldQRY_CNT.setvisible(true);
			/*조회결과 메시지*/
			KRI.setTranMessage(screen, 0, "정상적으로 조회 되었습니다.");
		}
		else /* 조회결과가 0건이면 */
		{
			KRI.setTranMessage(screen, 0, "조회할 자료가 없습니다.");		
		}
		/* 다음ROW가 있으면 자동 페이징 처리 */		
//		if (dsCond.getdatabyname(0, "QRY_NUM_NEXT") != 0 && bContinue == true)
//		{
//			KRLog.trace("# "+dsCond.getdatabyname(0, "QRY_NUM_NEXT"));
//			KRLog.trace("# "+dsCond.getdatabyname(0, "PG_PR_CNT"));
//			KRI.setGridMode(screen, grdList, KRConstant.GRID_APPEND);
//			KRI.requestSubmit(screen, "/tz/pl/selectStgpCdList.do", true);
//		}else		
//		{   
//            /* 중단점이 설정된 경우 더이상 조회하지 않고 알람메시지 표시 */
//            if(bContinue == false)
//            {
//			    bContinue = true;
//			    KRI.alert(screen, "사용자 요청에 의해 조회를 중단했습니다.");
//            }
//
//            /* 조회가 완료되면 반드시 WIAT DIALOG를 닫아야 한다 */
//		    KRI.endWaitDialog(screen);
//        
//            /* 조회된 건수만큼 표시 */
//		    QRY_CNT_FLD.settext("총 " + grdList.getrowcount() +" 건");
//					
//		}
		
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

	dsStgpInfoList.init();
	//페이징처리시
	//dsCond.setdatabyname(0,"QRY_NUM_NEXT","0");
	//KRI.beginWaitDialog(screen);
	dsCond.setdatabyname(0, "STGP_CD", STGP_CD.getselectedcode());
	dsCond.setdatabyname(0, "TRN_CLSF_CD", TRN_CLSF_CD.getselectedcode());	
	KRLog.trace("117");
	KRI.requestSubmit(screen,"/yz/yf/aa/selectListStgpInfo.do",true);
}

/*
** ========================================================================
** 5. 컨트롤 이벤트 영역
** ========================================================================
*/

function btnSearch_on_mouseup(objInst)
{
	fn_search();
}
/* //페이징 처리시 전역변수 조정
function screen_on_keydown(keycode, bctrldown, bshiftdown, baltdown, bnumpadkey)
{
	if(keycode == 27){
		bContinue = false;
	}
	return 0;
}
*/
//스크롤바가 밑으로 내려갔을 때 재조회 하는 페이징처리
/*
function grdList_on_vscroll(objInst, nScrollPos, nPrevScrollPos, nSBCode, bSBMax)
{
	if (bSBMax && dsCond.getdatabyname(0,"QRY_NUM_NEXT") != 0)
	{
		KRI.setGridMode(screen,objInst, KRConstant.GRID_APPEND);
		KRI.requestSubmit(screen,"/tz/pl/selectStgpCdList.do",true);
	}
	else if (bSBMax && dsCond.getdatabyname(0,"QRY_NUM_NEXT")== 0)
	{
		KRI.alert(screen, "조회할 자료가 없습니다.");
	}
}*/
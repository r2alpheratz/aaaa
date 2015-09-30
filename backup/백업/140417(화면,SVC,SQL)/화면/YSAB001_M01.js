/*
** =================================================================================================
** 시 스 템 명 : YS (의사결정지원)
** 화  면  ID : YSAB001_M01
** 화  면  명 : 온라인 수익관리 작업처리
** 개      요 : 온라인 수익관리 작업처리내역을 조회하고 최적화를 실행한다.
** ================================================================================================= 
** << 변경 정보 >>
** -------------------------------------------------------------------------------------------------
** 변 경 일 자  : 변경자 : 변	경	내	역
** -------------------------------------------------------------------------------------------------
** 2014-04-08 : 한현섭 : 신규작성
** YYYY-MM-DD :  
** =================================================================================================
*/

/* 
** ========================================================================
** 1. 전역 변수 영역
** ======================================================================== 
*/
	var m_objYZCmmnUtil = KRI.getTeamModule(screen,"YZ","YZCmmnUtil");
	var m_sTodayDt = KRUtil.TodayDate(screen);
	var m_sOptErrTb = "";
	var m_aOptChkTb = ["열차편성내역",
						"열차기본",
						"열차운행내역",
						"잔여석기본",
						"LEG잔여석내역",
						"SEG잔여석내역",
						"구역별구간그룹내역",
						"YMS할당잔여석내역",
						"부킹클래스적용내역"] ;
	var m_nProgStt = 10;						

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
	m_objYZCmmnUtil.fn_calendar_init(screen,"m_objYZCmmnUtil");
	pnlProg.setvisible(false);
	progBar.setmaxvalue(100);
	progBar.setpos(m_nProgStt,true);
	fldLEFT_QRY_CNT_FLD.setinputtype(2);
	fldRIGHT_QRY_CNT_FLD.setinputtype(2);


	
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
	if ( mapid == "/yz/ys/ab/selectListYmgtJobDmnLst.do")
	{
		fldLEFT_QRY_CNT_FLD.settext("총 " + grdYmgtJobDmnLst.getrowcount() +" 건");
	}
	if ( mapid == "/yz/ys/ab/selectListYmgtJobDmnDtlLst.do")
	{
		fldRIGHT_QRY_CNT_FLD.settext("총 " + grdYmgtJobDtlLst.getrowcount() +" 건");
	}
	if( mapid == "/yz/ys/ab/insertKtxRsvSaleDmnTrnRcvCfm.do" ||
		mapid ==  "/yz/ys/ab/insertSmlRsvSaleDmnTrnRcvCfm.do" )
	{
		fn_insert_callback();
	}
	if (mapid == "/yz/ys/ab/insertOtmzExc.do")
	{
		//배치 실행후 에러시 에러메시지발생, 정상의 경우 화면 refresh
		var batResult = dsRsvOptResult.getdatabyname(0,"BATCH_RESULT");

		if ( batResult == ""){
			fn_seacrh_ymgt();
		}
		else
		{
			KRI.alert(screen, batResult, "에러");
			KRI.setTranMessage(screen, 0, batResult);
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
	  KRI.addResize(grdYmgtJobDtlLst, KRConstant.CST_DIRECTION_BOTH);
	  KRI.addResize(grdYmgtJobDmnLst, KRConstant.CST_DIRECTION_VERT);
	  KRI.addResize(pnlCondition, KRConstant.CST_DIRECTION_HORZ);
	  KRI.addReposition(pnlSearch,KRConstant.CST_DIRECTION_HORZ);
	  KRI.addReposition(pnlBtns,KRConstant.CST_DIRECTION_VERT);
	  KRI.addReposition(btnExecute,KRConstant.CST_DIRECTION_BOTH);
}


/*
** ========================================================================
** 4. 사용자 정의 함수 영역
** ========================================================================
*/
//작업요청상세목록 조회
function fn_seacrh_ymgt()
{
	grdYmgtJobDtlLst.deleteall();
	var jobDt = fldRUN_DT.gettext()
	dsGrdYmgtCond.setdatabyname(0, "JOB_DT", jobDt);
	KRI.requestSubmit(screen, "/yz/ys/ab/selectListYmgtJobDmnLst.do", true, true, true);
}
//작업요청상세목록 조회
function fn_seacrh_ymgt_dtl(nClickRow)
{
	var sYmgtJobId = grdYmgtJobDmnLst.getitemtextbyname(nClickRow,"YMGT_JOB_ID");
	dsGrdYmgtDtlCond.setdatabyname(0, "YMGT_JOB_ID", sYmgtJobId);
	KRI.requestSubmit(screen, "/yz/ys/ab/selectListYmgtJobDmnDtlLst.do", true, true, true);
}

//열차 수신확인 Y/N 
function fn_chk_rsv_receive_confirm(sChkFlg)
{
	var sTodayDt = m_sTodayDt.substring(0,4)+". "+m_sTodayDt.substring(4,6)+". "+m_sTodayDt.substring(6,8);
	var sMsg = sTodayDt+"에 예약발매최적화요청 열차가 수신되었는지 확인하시겠습니까?";
	if(6 ==  KRI.messagebox(screen, sMsg, XFD_MB_YESNO))
	{
		if (sChkFlg == "KTX")
		{
			KRI.requestSubmit(screen, "/yz/ys/ab/insertKtxRsvSaleDmnTrnRcvCfm.do", true);
		}
		else if (sChkFlg == "SML")
		{
			KRI.requestSubmit(screen, "/yz/ys/ab/insertSmlRsvSaleDmnTrnRcvCfm.do", true);
		}
	}
	
}

function fn_insert_callback()
{
		var rstFlg = dsRsvDmnTrnRcvCfm.getdatabyname(0,"RESULT_FLAG");
		switch(rstFlg)
		{
			case '0' :
				KRI.alert(screen, "현재 예약발매요청 열차의 수신파일을 처리중입니다.", "Information");
				KRI.setTranMessage(screen, 0, "현재 예약발매요청 열차의 수신파일을 처리중입니다.");
				break;
			case '1' :
				KRI.alert(screen, "예약발매요청열차 자료수신확인 중 오류가 발생했습니다.", "Alert");
				KRI.setTranMessage(screen, 0, "예약발매요청열차 자료수신확인 중 오류가 발생했습니다.");
				break;
			case '2' :
				//fn_seacrh_ymgt();
				KRI.loadSystemPopup(screen, "/BIZ/YZ/YS/AB/YSAB001_P01", true)
				break;
			default : 
				KRI.alert(screen, "처리에러", "Alert");
				KRI.setTranMessage(screen, 0, "처리에러");
		}
}
function fn_set_dsRsvOptExc(nClickRow){

	var jobDttm = fldRUN_DT.gettext();
	var ymgtJobId = grdYmgtJobDmnLst.getitemtextbyname(nClickRow, "YMGT_JOB_ID");
	var jobStDttm = grdYmgtJobDmnLst.getitemtextbyname(nClickRow, "JOB_DT");
	var trvlUsrId = grdYmgtJobDmnLst.getitemtextbyname(nClickRow, "TRVL_USR_NM");

	dsRsvOptExc.setdata(0,0,jobDttm);
	dsRsvOptExc.setdata(0,1,ymgtJobId);
	dsRsvOptExc.setdata(0,2,jobStDttm);
	dsRsvOptExc.setdata(0,3,trvlUsrId);
}

function fn_rsv_opt_exc()
{

	var jobStDttm = dsRsvOptExc.getdatabyname(0, "JOB_ST_DTTM");
	
	if (jobStDttm == "-")
	{
		KRI.alert(screen, "이 작업은 이미 실행한 적이 있습니다.", "Information");
	}
	else
	{	
		m_sOptErrTb = "";
		pnlProg.setvisible(true);
		for( var i = 0 ; i < m_aOptChkTb.length ; i++)
		{
			var sTbNm = m_aOptChkTb[i]
			dsRsvOptExc.setdatabyname(0, "TB_NM", sTbNm);		
			KRI.requestSubmit(screen, "/yz/ys/ab/insertOtmzExc.do", false, false);
			
			//프로그레스바 진행률 10%증가
			m_nProgStt += 10;
			progBar.setpos(m_nProgStt,true);
			
			//프로그레스바 진행률이 100%이 되면 감춤
			if(m_nProgStt == 100){
				pnlProg.setvisible(false);
			}
			
			//데이터가 존재하는지 여부를 검색하여 없는 경우, 해당 에러테이블명이 ds를 통해 도착. 이것을 
			var sErrorTb = dsRsvOptChkErrTb.getdatabyname(0,"errorTable");
			if (sErrorTb != "")
			{
				m_sOptErrTb = m_sOptErrTb + sErrorTb + ", ";
			}
			if(m_sOptErrTb != "" && m_nProgStt >= 100)
			{
				m_sOptErrTb = "다음 테이블에서 오류가 발생하였습니다. : "+m_sOptErrTb.substring(0, m_sOptErrTb.length-2);
				KRI.alert(screen, m_sOptErrTb);

				m_sOptErrTb = ""; //오류메시지 초기화
				
				// 프로그레스바 초기화
				m_nProgStt = 10; 
				progBar.setpos(m_nProgStt,true);
				return;
			}
		}
		//배치실행
		dsRsvOptExc.setdatabyname(0, "TB_NM", "");		
		KRI.requestSubmit(screen, "/yz/ys/ab/insertOtmzExc.do",true);
		
	}
}

/*
** ========================================================================
** 5. 컨트롤 이벤트 영역
** ========================================================================
*/

function btnSearch_on_mouseup(objInst)
{
	fn_seacrh_ymgt();
}

function btnKTX_on_mouseup(objInst)
{
	fn_chk_rsv_receive_confirm("KTX");
}

function btnSML_on_mouseup(objInst)
{
	fn_chk_rsv_receive_confirm("SML");
}

function btnOnlineStat_on_mouseup(objInst)
{
	KRI.alert(screen, "온라인작업상태조회창 링크 예정", "Information");
}	

function grdYmgtJobDmnLst_on_itemclick(objInst, nClickRow, nClickColumn)
{
	fn_set_dsRsvOptExc(nClickRow);
	fn_seacrh_ymgt_dtl(nClickRow);
}

function fldRUN_DT_on_change(objInst)
{
	var jobDt = fldRUN_DT.gettext();

	if(m_sTodayDt == jobDt)
	{
		btnExecute.setenable(true);
	}
	else
	{
		btnExecute.setenable(false);
	}
}

function btnExecute_on_mouseup(objInst)
{
	fn_rsv_opt_exc();
}
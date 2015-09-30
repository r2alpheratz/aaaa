// 조회 버튼 이벤트 처리
function btnSelect_on_mouseup()
{
	screen.requestsubmit("TR_SELECT_EMP", true);
}

// First-Row 조회 버튼 이벤트 처리
function btnFristRowSelect_on_mouseup()
{
	screen.requestsubmit("TR_FIRSTROW_EMP", true);
}

// 삭제 버튼 이벤트 처리
function btnDeleteEmp_on_mouseup()
{
	var nCurrentRow;

	// 현재 선택된 로우를 구함
	nCurrentRow = grdEmpList.getselectrow();
	if(nCurrentRow < 0) {
		return;
	}
	
	// 현재 선택된 로우를 삭제
	if(screen.confirm("현재 선택된 로우를 삭제하시겠습니까?") == true) {
		grdEmpList.deleterow(nCurrentRow);
	}
}

// 신규 버튼 이벤트 처리
function btnNewEmp_on_mouseup()
{
	// 맨 마지막에 로우 추가하고, 추가된 로우를 선택함
	var nRowIndex = grdEmpList.additem();
	grdEmpList.setselectitem(nRowIndex, 0);
}

// 저장 버튼 이벤트 처리
function btnProcessEmp_on_mouseup()
{
	screen.requestsubmit("TR_PROCESS_EMP", true);
}

// 화면 로드 이벤트 처리
function screen_on_load()
{
	screen.requestsubmit("TR_SELECT_EMP", true);
}

// 트랜잭션 처리 완료 이벤트 처리
function screen_on_submitcomplete(mapid, result, recv_userheader, recv_code, recv_msg)
{
	MAP_ID.settext(mapid);
	RESULT.settext(result);
	RECV_CODE.settext(recv_code);
	RECV_MSG.settext(recv_msg);
}
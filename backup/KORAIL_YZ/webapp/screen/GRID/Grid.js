// 추가 버튼 이벤트 처리
function btnAdd_on_mouseup(objInst)
{
	// 그리드의 새로운 아이템을 추가
	var nRowIndex = grdList.additem();
	
	// 선택된 아이템의 위치를 새로 추가된 아이템으로 이동
	grdList.setselectitem(nRowIndex, 0);
}

// 체크 삭제 버튼 이벤트 처리
function btnDeleteChecked_on_mouseup(objInst)
{
	var nCheckedRowCount = grdList.getcheckedrowcount();
	if(nCheckedRowCount < 1) {
		screen.alert("체크된 로우가 없습니다.");
		return;
	}
	
	// 모든 체크된 로우 삭제
	grdList.deletecheckedrow();
}

// 전체 삭제 버튼 이벤트 처리
function btnDeleteAll_on_mouseup(objInst)
{
	// 모든 로우 삭제
	grdList.deleteall();
}
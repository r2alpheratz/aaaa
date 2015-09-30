// 화면 로드 이벤트 처리
function screen_on_load()
{
	// 부무 화면의 화면 오브젝트를 구함
	var objParentScreen = screen.getparent();
	
	// 부무 화면의 "fldDataToPopup" 필드 오브젝트을 구함
	var objFldDataToPopup = objParentScreen.getinstancebyname("fldDataToPopup");
	
	// 팝업 화면의 필드에 부모 화면의 필드의 값을 설정
	fldDataFromScreen.settext(objFldDataToPopup.gettext());
}

// 확인 버튼 이벤트 처리
function btnOk_on_mouseup(objInst)
{
	// 부무 화면의 화면 오브젝트를 구함
	var objParentScreen = screen.getparent();
	
	// 부모 화면의 "fldDataFromPopup" 필드 컨트롤을 구함
	var objFldDataFromPopup = objParentScreen.getinstancebyname("fldDataFromPopup");
	
	// 부모 화면의 필드에 팝업 화면의 필드의 값을 설정
	objFldDataFromPopup.settext(fldDataToScreen.gettext());
	
	// 팝업 화면 닫는 합수 호출
	screen.unloadpopup(1);
}

// 취소 버튼 이벤트 처리
function btnCancel_on_mouseup(objInst)
{
	// 팝업 화면 닫기 확인
	if(screen.confirm("팝업 화면을 닫으시겠습니까?") == true) {
		// 팝업 화면 닫는 합수 호출
		screen.unloadpopup(0);
	}
}
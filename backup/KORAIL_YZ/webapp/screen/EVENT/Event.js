// 버튼 이벤트 처리
function btnEvent_on_mouseup(objInst)
{
	screen.alert("버튼 이벤트는 단순 이벤트 입니다.\n리턴 값이 없습니다.");
}

// 탭 아이템 삭제 이벤트 처리
function tabEvent_on_itemdestroy(objInst, itemindex)
{
	// 삭제 이벤트가 발생한 탭 아이템의 텍스트를 구함
	var strItemText = tabEvent.gettabitemtext(itemindex);
	
	// 탭 아이템 삭제 확인 메시지 박스 표시
	if(screen.confirm(strItemText + "을 닫으시겠습니까?") == false) {
		// 탭 아이템이 삭제되지 않토록, 0을 리턴
		return 0;
	}
	
	// 그외의 경우에는 1을 리턴하여 탭이 삭제되도록 처리
	return 1;
}

// 화면의 키 다운 이벤트 처리
function screen_on_keydown(keycode, bctrldown, bshiftdown, baltdown, bnumpadkey)
{
	factory.consoleprint("screen_on_keydown> keycode = " + keycode);
	
	// F1 키를 눌렀을 경우
	if(keycode == 1112) {
		screen.alert("화면에 대한 도움말입니다.\n이 화면은 이벤트에 대한 샘플입니다.");
		return 1;
	}
	
	return 0;
}

// 이름 필드에 대한 키 다운 이벤트 처리
function fldName_on_keydown(objInst, keycode, bctrldown, bshiftdown, baltdown, bnumpadkey)
{
	factory.consoleprint("fldEvent_on_keydown> keycode = " + keycode);
	
	// F1 키를 눌렀을 경우
	if(keycode == 1112) {
		screen.alert("필드에 대한 도움말입니다.\n이름을 입력해 주세요!");
		
		// 키 이벤트를 화면으로 전달하지 않기 위해, 1을 리턴
		return 1;
	}
	
	// 키 이벤트를 화면으로 전달시키기 위해, 0을 리턴
	return 0;
}

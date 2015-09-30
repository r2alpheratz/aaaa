// 개발자가 직접 개발한 함수
// 화면 타이틀 텍스트와 탭 아이템의 텍스트를 변경
function setTitleTextAndTabItemText(nTabIndex)
{
	// 탭 아이템에 링크된 화면의 타이틀을 구하여 화면 타이틀 설정
	txtScreenTitle.settext(tabScreen.getinnerscreentitle(nTabIndex));
	
	// 타이틀 텍스트 길이 길만큼 텍스트 컨트롤의 길이 조절
	txtScreenTitle.fittext();
	
	// 텝에 링크된 화면 오브젝트를 구함
	var objScreen = tabScreen.getchildscreeninstance(nTabIndex);

	// 탭에 링크된 화면의 ID를 구함
	var strScreenId = objScreen.getscreenid();
	
	// 탭 아이템 텍스트를 링크돤 화면의 ID로 변경
	tabScreen.settabitemtext(nTabIndex, strScreenId);
	
	return;
}

// 열기 버튼 이벤트 처리
function btnOpenScreen_on_mouseup(objInst)
{
	// 화면 경로 필드 값을 구함
	var strScreenUrl = fldScreenUrl.gettext();
	if(strScreenUrl.length == 0) {
		screen.alert("화면 경로를 입력하세요");
		return;
	}
	
	// 탭에 화면 경로에 해당하는 화면을 로드하고, 새로 추가된 탭 아이템의 인덱스를 구함
	var nTabIndex = tabScreen.addtab("SCREEN_ID", 1, 100, strScreenUrl);
	if(nTabIndex == -2) {
		screen.alert("화면 경로에 해당하는 화면이 존재하지 않습니다.");
		return;
	}
	
	// 화면 타이틀 텍스트와 탭 아이템의 텍스트를 변경하는 함수 호출
	setTitleTextAndTabItemText(nTabIndex);
}

// 닫기 버튼 이벤트 처리
function btnCloseScreen_on_mouseup(objInst)
{
	// 현재 포커스를 가진 탭의 인덱스를 구함
	var nTabIndex = tabScreen.gettabitemfocus();
	if(nTabIndex < 0) {
		screen.alert("현재 탭이 없습니다.");
		return;
	}
	
	// 현재 포커스를 가진 탭 아이템을 삭제함
	// 탭 컨트롤의 "on_itemdestroy" 이벤트가 발생한다.
	tabScreen.deletetab(nTabIndex);
}

// Reload 버튼 이벤트 처리
function btnReloadScreen_on_mouseup(objInst)
{	
	// 현재 포커스를 가진 탭 아이템의 인덱스를 구함
	var nTabIndex = tabScreen.gettabitemfocus();
	if(nTabIndex < 0) {
		screen.alert("현재 탭이 없습니다.");
		return;
	}

	// 현재 탭에 링크된 화면의 URL을 구함	
	var strScreenUrl = tabScreen.getinnerscreenurl(nTabIndex);
	
	// 현재 포커스를 가진 탭에 기존 화면 URL에 해당하는 화면을 새롭게 로드
	var nResult = tabScreen.setinnerscreenurl(nTabIndex, strScreenUrl);
	if(nResult == -2) {
		screen.alert("화면 경로에 해당하는 화면이 존재하지 않습니다.");
		return;
	}

	// 화면 타이틀 텍스트와 탭 아이템의 텍스트를 변경	
	setTitleTextAndTabItemText(nTabIndex);
}

// 탭의 아이템 선택 변경 이벤트 처리
function tabScreen_on_itemchange(objInst, itemindex)
{
	// 화면 타이틀 텍스트와 탭 아이템의 텍스트를 변경
	setTitleTextAndTabItemText(itemindex);
}

// 탭의 아이템 삭제 이벤트 처리
function tabScreen_on_itemdestroy(objInst, itemindex)
{
	// 화면 타이틀 텍스트의 내용을 초기화
	txtScreenTitle.settext("");
	return 1;
}

// 화면 URL 필드에 대한 키 이벤트 처리
function fldScreenUrl_on_keydown(objInst, keycode, bctrldown, bshiftdown, baltdown, bnumpadkey)
{
	// 키코드가 엔터키인 경우
	if(keycode == 13) {
		// "열기" 버튼 마우스업 이벤트 처리 함수를 직접 호출
		btnOpenScreen_on_mouseup();
		return 1;
	}
	
	return 0;
}

// 정렬 버튼 이벤트 처리
function btnAlign_on_mouseup(objInst)
{
	// 정렬 타입 콤보에서 현재 선택한 코드 값을 구함
	var strAlignType = cboAlignType.getselectedcode();

	// 정렬 코드 값에 따라 분기 처리
	switch(strAlignType) {
		case "0" :	// 최대화 모드 
			tabScreen.changeshowmode(1);			
			break;
		case "1" :	// 수직 정렬
			tabScreen.showtilevert();
			break;
		case "2" :	// 수평 정렬
			tabScreen.showtilehorz();
			break;
		case "3" :	// Cascade 정렬
			tabScreen.showcascade();
			break;
		default : 
			screen.alert("정의되지 않은 정렬 타입입니다.");
			break;
	}	
}

// 화면 로드 이벤트 처리
function screen_on_load()
{
	// 화면 URL 필드에 기본값 설정
	fldScreenUrl.settext("/START/SayHello");
}
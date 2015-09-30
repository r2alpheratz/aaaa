// 화면 로드 이벤트 처리
function screen_on_load()
{
	// 트리의 Root 아이템 추가
	var nRootItem = treMenu.insertitem("메뉴 트리", 0, 0, 0);
	
	// Root 아이템에 하위에 디렉토리 아이템 추가
	var nDirItem = treMenu.insertitem("샘플 화면", 1, 2, nRootItem);
	
	var nScreenItem;
	
	// 디렉토리 아이템에 화면을 링크할 아이템 추가
	nScreenItem = treMenu.insertitem("Say Hello", 3, 3, nDirItem);
	
	// 추가된 아이템에 화면 경로 정보 설정
	treMenu.setitemdata(nScreenItem, "/START/SayHello");
	
	// 디렉토리 아이템에 화면을 링크할 아이템 추가	
	nScreenItem = treMenu.insertitem("Load Popup", 3, 3, nDirItem);
	
	// 추가된 아이템에 화면 경로 정보 설정	
	treMenu.setitemdata(nScreenItem, "/POPUP/LoadPopup");
	
	// Root 트리 아이템을 펼침
	treMenu.expand(nRootItem, XFD_TREEITEM_EXPAND);
}

/**
 * 화면 URL에 탭의 아이템 인덱스를 리턴
 * @param strScreenUrl 찾을 화면의 URL
 * @return 
 * 	>= 0 탭 아이템 인덱스
 * 	-1 탭에 없는 경우
 */
function getScreenTabIndex(strScreenUrl)
{
	var nTabIndex = -1;
	
	// 탭 아이템의 갯수를 구함
	var nTabCount = tabScreen.gettabitemcount();
	var i;

	// 탭 아이템 갯수만큼 Loop
	for(i = 0; i < nTabCount; i++) {
		// 탭 아이템에 링크된 화면의 URL을 구함
		var strTempScreenUrl = tabScreen.getinnerscreenurl(i);
		
		// 화면 URL 비교하여 같으면, Loop 종료
		if(strTempScreenUrl == strScreenUrl) {
			nTabIndex = i;
			break;
		}
	}
	
	return nTabIndex;
}

// 트리 더블클릭 이벤트 처리
function treMenu_on_itemdblclick(objInst, item)
{
	// 더블클릭 이벤트가 발생한 트리 아이템의 데이터 정보를 구함
	// 데이터 정보는 화면 로드 이벤트에서 트리 아이템 추가시
	// setitemdata 함수를 통해서 설정한 데이터임
	var strItemData = treMenu.getitemdata(item);
	
	// 트리 아이템에 설정된 데이터가 없는 경우에는 그냥 리턴
	if(strItemData == 0) {
		return;
	}
	
	// 화면 중복 열기 허용 옵션이 체크되어 있지 않은 경우
	if(chkOption.getcheck() == false) {
		// 탭에 이미 화면이 열려져 있는지 확인
		var nTabIndex = getScreenTabIndex(strItemData);
		if(nTabIndex >= 0) {
			// 탭에 이미 화면이 열려져 있는 경우, 
			// 해당 탭 아이템에 포커스를 주고, 리턴
			tabScreen.settabitemfocus(nTabIndex, true);
			return;
		}
	}
	
	// 트리 아이템 데이터는 화면 경로가 설정되어 있으므로, 화면 로드 함수 호출
	var nRet = loadScreenInTab(strItemData);
	if(nRet < 0) {
		screen.alert("화면 로드 오류가 발생하였습니다.");
	}
	
	return;
}

/**
 * 화면 URL에 대한 정보에 해당하는 화면을 탭 아이템을 추가하면서 로드한다.
 * 트리 콘트롤의 더블 클릭 이벤트 처리 함수에서 호출하는 함수이다.
 * @param strScreenUrl 로딩할 화면의 URL
 * @return 
 * 	>0 : 추가된 탭 인덱츠
 * 	-1 : 내부 오류
 * 	-2 : 화면이 존재하지 않음
 */ 
function loadScreenInTab(strScreenUrl)
{
	// 탭에 화면 경로에 해당하는 화면을 로드하고, 새로 추가된 탭 아이템의 인덱스를 구함
	var nTabIndex = tabScreen.addtab("SCREEN_ID", 1, 100, strScreenUrl);
	if(nTabIndex < 0) {
		return nTabIndex;
	}
	
	// 텝에 링크된 화면 오브젝트를 구함
	var objScreen = tabScreen.getchildscreeninstance(nTabIndex);

	// 탭에 링크된 화면의 ID를 구함
	var strScreenId = objScreen.getscreenid();
	
	// 탭 아이템 텍스트를 링크돤 화면의 ID로 변경
	tabScreen.settabitemtext(nTabIndex, strScreenId);	
	
	return nTabIndex;
}

// 숨기기 버튼 이벤트 처리
function btnHide_on_mouseup(objInst)
{
	// 숨기기 버튼을 숨김
	btnHide.setvisible(false);
	
	// 체크 박스 숨김
	chkOption.setvisible(false);
	
	// 보이기 버튼을 표시
	btnShow.setvisible(true);
		
	// 트리 컨트롤을 숨김
	treMenu.setvisible(false);
		
	// 탭의 좌표를 구하고, 탭의 좌표중 좌측 X 값을 조절하고, 탭의 크기 변경
	var arrRect = tabScreen.getrect();
	arrRect[0] = arrRect[0] - 140;
	tabScreen.setrect(arrRect[0], arrRect[1], arrRect[2], arrRect[3]);	
	
	return;
}

// 보이기 버튼 이벤트 처리
function btnShow_on_mouseup(objInst)
{
	// 숨기기 버튼을 표시
	btnHide.setvisible(true);
		
	// 체크 박스 표시
	chkOption.setvisible(true);
			
	// 보이기 버튼을 숨김
	btnShow.setvisible(false);
		
	// 트리 컨트롤을 표시
	treMenu.setvisible(true);
	
	// 탭의 좌표를 구하고, 탭의 좌표중 좌측 X 값을 조절하고, 탭의 크기 변경
	var arrRect = tabScreen.getrect();
	arrRect[0] = arrRect[0] + 140;
	tabScreen.setrect(arrRect[0], arrRect[1], arrRect[2], arrRect[3]);
	
	return;
}
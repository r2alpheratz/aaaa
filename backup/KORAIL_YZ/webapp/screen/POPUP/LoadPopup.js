// 팝업 버튼 이벤트 처리
function btnLoadPopup_on_mouseup(objInst)
{
	// 팝업 이름 변수 선업 및 값 지정
	var strPopupName = "POPUP_NAME1";
	
	// factory 오브젝트를 이용하여 팝업 화면 생성
	// 두번재 파라미터는 팝업 화면의 경로를 의미한다.
	// 화면 경로는 프로젝트 ID가 "/"로 표시되고, 그 하위의 경로는
	// 디렉토리명과 화면 ID로 구성된다.
	factory.loadpopup(strPopupName, "/POPUP/popup", "팝업 타이틀", 
		false, 2, 0, 0, true, true, screen);
	
	// 생성한 팝업 화면 오브젝트를 팝업 이름을 이용하여 찾음
	var objPopup = factory.findpopup(strPopupName);
		
	// 팝업 화면을 모달 형식으로 화면에 표시
	var nReturn = objPopup.domodal();
	
	// 팝업 화면 스크립트에서 호출한 unloadpopup 함수의 파라미터로 전달된 값이
	// domodal() 함수의 리턴 값으로 전달됨
	factory.consoleprint("nReturn = " + nReturn);
}
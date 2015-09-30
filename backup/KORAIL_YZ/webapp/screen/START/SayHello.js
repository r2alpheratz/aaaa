var m_strDefaultName = "홍길동";

// 화면 로드 이벤트 처리
function screen_on_load()
{
	// 이름 필드에 값을 설정한다.
	fldName.settext("홍길동");
}

// 아래의 함수는 직접 작성한 함수이다.
// 현재 사간을 구하여 리턴한다.
function getCurrentTime()
{
	// factory 오브젝트를 이용해서 현재 시간을 구한다.
	// JavaScript에서 변수는 "var" 예약어를 이용해서 선언한다.
	var strCurrentTime = factory.getsystemtime("%Y-%M-%D %h:%m:%s");
	
	// factory 오브젝트를 이용해서 콘솔 창에 변수의 내용을 출력한다.
	factory.consoleprint("strCurrentTime : " + strCurrentTime);	
	
	// 현재 시간을 리턴한다.
	return strCurrentTime;
}

/*
버튼의 마우스 업 이벤트를 처리한다.
objInst 파라미터는 이벤트가 발생한 UI 컨트롤의 오브젝트이다.
*/
function btnSayHello_on_mouseup(objInst)
{
	// factory 오브젝트를 이용해서 콘솔 창에 objInst 파라미터의 이름을 출력한다.
	factory.consoleprint("Object Name : " + objInst.getname());
	
	// 현재 시간을 구하는 함수를 호출하여 값을 구한다.
	var strTime = TimeUtil.getCurrentTime();
	
	// screen 오브젝트를 이용해서 화면에 Alert 창을 표시한다.
	// 공통 모듈의 변수를 참조한다.
	// 표시되는 문자열을 개행을 하기위해서는 "\n"을 사용한다.
	screen.alert(TimeUtil.strGreeting + " " + 
		fldName.gettext() + "\n현재 시각 : " + strTime);
}

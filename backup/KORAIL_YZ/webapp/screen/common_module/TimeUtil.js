var strGreeting = "Hello!";

// 현재 사간을 구하여 리턴한다.
function getCurrentTime()
{
	// factory 오브젝트를 이용해서 현재 시간을 구한다.
	// JavaScript에서 변수는 "var" 예약어를 이용해서 선언한다.
	var strCurrentTime = factory.getsystemtime("%Y-%M-%D %h:%m:%s");
	
	// factory 오브젝트를 이용해서 콘솔 창에 objInst 파라미터의 이름을 출력한다.
	factory.consoleprint("strCurrentTime : " + strCurrentTime);	
	
	// 현재 시간을 리턴한다.
	return strCurrentTime;
}
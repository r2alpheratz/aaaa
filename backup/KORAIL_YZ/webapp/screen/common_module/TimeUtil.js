var strGreeting = "Hello!";

// ���� �簣�� ���Ͽ� �����Ѵ�.
function getCurrentTime()
{
	// factory ������Ʈ�� �̿��ؼ� ���� �ð��� ���Ѵ�.
	// JavaScript���� ������ "var" ���� �̿��ؼ� �����Ѵ�.
	var strCurrentTime = factory.getsystemtime("%Y-%M-%D %h:%m:%s");
	
	// factory ������Ʈ�� �̿��ؼ� �ܼ� â�� objInst �Ķ������ �̸��� ����Ѵ�.
	factory.consoleprint("strCurrentTime : " + strCurrentTime);	
	
	// ���� �ð��� �����Ѵ�.
	return strCurrentTime;
}
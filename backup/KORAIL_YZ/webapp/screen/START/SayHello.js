var m_strDefaultName = "ȫ�浿";

// ȭ�� �ε� �̺�Ʈ ó��
function screen_on_load()
{
	// �̸� �ʵ忡 ���� �����Ѵ�.
	fldName.settext("ȫ�浿");
}

// �Ʒ��� �Լ��� ���� �ۼ��� �Լ��̴�.
// ���� �簣�� ���Ͽ� �����Ѵ�.
function getCurrentTime()
{
	// factory ������Ʈ�� �̿��ؼ� ���� �ð��� ���Ѵ�.
	// JavaScript���� ������ "var" ���� �̿��ؼ� �����Ѵ�.
	var strCurrentTime = factory.getsystemtime("%Y-%M-%D %h:%m:%s");
	
	// factory ������Ʈ�� �̿��ؼ� �ܼ� â�� ������ ������ ����Ѵ�.
	factory.consoleprint("strCurrentTime : " + strCurrentTime);	
	
	// ���� �ð��� �����Ѵ�.
	return strCurrentTime;
}

/*
��ư�� ���콺 �� �̺�Ʈ�� ó���Ѵ�.
objInst �Ķ���ʹ� �̺�Ʈ�� �߻��� UI ��Ʈ���� ������Ʈ�̴�.
*/
function btnSayHello_on_mouseup(objInst)
{
	// factory ������Ʈ�� �̿��ؼ� �ܼ� â�� objInst �Ķ������ �̸��� ����Ѵ�.
	factory.consoleprint("Object Name : " + objInst.getname());
	
	// ���� �ð��� ���ϴ� �Լ��� ȣ���Ͽ� ���� ���Ѵ�.
	var strTime = TimeUtil.getCurrentTime();
	
	// screen ������Ʈ�� �̿��ؼ� ȭ�鿡 Alert â�� ǥ���Ѵ�.
	// ���� ����� ������ �����Ѵ�.
	// ǥ�õǴ� ���ڿ��� ������ �ϱ����ؼ��� "\n"�� ����Ѵ�.
	screen.alert(TimeUtil.strGreeting + " " + 
		fldName.gettext() + "\n���� �ð� : " + strTime);
}

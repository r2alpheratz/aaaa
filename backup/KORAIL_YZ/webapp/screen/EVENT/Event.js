// ��ư �̺�Ʈ ó��
function btnEvent_on_mouseup(objInst)
{
	screen.alert("��ư �̺�Ʈ�� �ܼ� �̺�Ʈ �Դϴ�.\n���� ���� �����ϴ�.");
}

// �� ������ ���� �̺�Ʈ ó��
function tabEvent_on_itemdestroy(objInst, itemindex)
{
	// ���� �̺�Ʈ�� �߻��� �� �������� �ؽ�Ʈ�� ����
	var strItemText = tabEvent.gettabitemtext(itemindex);
	
	// �� ������ ���� Ȯ�� �޽��� �ڽ� ǥ��
	if(screen.confirm(strItemText + "�� �����ðڽ��ϱ�?") == false) {
		// �� �������� �������� �����, 0�� ����
		return 0;
	}
	
	// �׿��� ��쿡�� 1�� �����Ͽ� ���� �����ǵ��� ó��
	return 1;
}

// ȭ���� Ű �ٿ� �̺�Ʈ ó��
function screen_on_keydown(keycode, bctrldown, bshiftdown, baltdown, bnumpadkey)
{
	factory.consoleprint("screen_on_keydown> keycode = " + keycode);
	
	// F1 Ű�� ������ ���
	if(keycode == 1112) {
		screen.alert("ȭ�鿡 ���� �����Դϴ�.\n�� ȭ���� �̺�Ʈ�� ���� �����Դϴ�.");
		return 1;
	}
	
	return 0;
}

// �̸� �ʵ忡 ���� Ű �ٿ� �̺�Ʈ ó��
function fldName_on_keydown(objInst, keycode, bctrldown, bshiftdown, baltdown, bnumpadkey)
{
	factory.consoleprint("fldEvent_on_keydown> keycode = " + keycode);
	
	// F1 Ű�� ������ ���
	if(keycode == 1112) {
		screen.alert("�ʵ忡 ���� �����Դϴ�.\n�̸��� �Է��� �ּ���!");
		
		// Ű �̺�Ʈ�� ȭ������ �������� �ʱ� ����, 1�� ����
		return 1;
	}
	
	// Ű �̺�Ʈ�� ȭ������ ���޽�Ű�� ����, 0�� ����
	return 0;
}

// "Say Hello" ��ư �̺�Ʈ ó��
function btnMenu1_on_mouseup(objInst)
{
	// ȭ�� �ε� �Լ� ȣ��
	loadScreenByCallParentScreenFunc("/START/SayHello");
}

// "Load Popup" ��ư �̺�Ʈ ó��
function btnMenu2_on_mouseup(objInst)
{
	// ȭ�� �ε� �Լ� ȣ��
	loadScreenByCallParentScreenFunc("/POPUP/LoadPopup");
}

/**
 * ȭ�� URL�� ���� ������ �ش��ϴ� ȭ���� �ε��ϱ� ���ؼ�
 * �θ� ȭ���� loadScreen �Լ��� ȣ���Ѵ�.
 * @param strScreenUrl �ε��� ȭ���� URL
 */ 
function loadScreenByCallParentScreenFunc(strScreenUrl)
{
	// �޴��� �ε��� �θ� ȭ�� ������Ʈ�� ����
	var objParentScreen = screen.getparent();

	// �θ� ȭ�� ������Ʈ�� �������� �˻�
	if(factory.isobject(objParentScreen) == false) {
		screen.alert("�θ� ȭ���� ���� �� �����ϴ�.");
		return;
	}
	
	// �θ� ȭ���� JavaScript ��� ������Ʈ�� ����
	var objParentScreenMember = objParentScreen.getmembers(XFD_JAVASCRIPT);
	
	// �θ� ȭ�� JavaScript ��� ������Ʈ�� �������� �˻�
	if(factory.isobject(objParentScreenMember) == false) {
		screen.alert("�θ� ȭ�� ����� ���� �� �����ϴ�.");
		return;
	}
	
	// �θ� ȭ���� JavaScript ��� ������Ʈ�� ���ؼ�
	// �θ� ȭ���� JavaScript�� ����� ���� ������ �����Ͽ� ���� ó��
	if(objParentScreenMember.bConfirmOpen == true) {
		if(screen.confirm(strScreenUrl + " ȭ���� �ε��Ͻðڽ��ϱ�?") == false) {
			return;
		}
	}
	 
	// �θ� ȭ���� JavaScript ��� ������Ʈ�� ���ؼ�,
	// �θ� ȭ�鿡 �ִ� loadScreen �Լ� ȣ��
	var nRet = objParentScreenMember.loadScreenInTab(strScreenUrl);
	if(nRet < 0) {
		screen.alert("ȭ�� �ε� ������ �߻��Ͽ����ϴ�.");
	}
	
	return;
}
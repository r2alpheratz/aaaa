// �˾� ��ư �̺�Ʈ ó��
function btnLoadPopup_on_mouseup(objInst)
{
	// �˾� �̸� ���� ���� �� �� ����
	var strPopupName = "POPUP_NAME1";
	
	// factory ������Ʈ�� �̿��Ͽ� �˾� ȭ�� ����
	// �ι��� �Ķ���ʹ� �˾� ȭ���� ��θ� �ǹ��Ѵ�.
	// ȭ�� ��δ� ������Ʈ ID�� "/"�� ǥ�õǰ�, �� ������ ��δ�
	// ���丮��� ȭ�� ID�� �����ȴ�.
	factory.loadpopup(strPopupName, "/POPUP/popup", "�˾� Ÿ��Ʋ", 
		false, 2, 0, 0, true, true, screen);
	
	// ������ �˾� ȭ�� ������Ʈ�� �˾� �̸��� �̿��Ͽ� ã��
	var objPopup = factory.findpopup(strPopupName);
		
	// �˾� ȭ���� ��� �������� ȭ�鿡 ǥ��
	var nReturn = objPopup.domodal();
	
	// �˾� ȭ�� ��ũ��Ʈ���� ȣ���� unloadpopup �Լ��� �Ķ���ͷ� ���޵� ����
	// domodal() �Լ��� ���� ������ ���޵�
	factory.consoleprint("nReturn = " + nReturn);
}
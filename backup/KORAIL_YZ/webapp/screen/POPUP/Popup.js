// ȭ�� �ε� �̺�Ʈ ó��
function screen_on_load()
{
	// �ι� ȭ���� ȭ�� ������Ʈ�� ����
	var objParentScreen = screen.getparent();
	
	// �ι� ȭ���� "fldDataToPopup" �ʵ� ������Ʈ�� ����
	var objFldDataToPopup = objParentScreen.getinstancebyname("fldDataToPopup");
	
	// �˾� ȭ���� �ʵ忡 �θ� ȭ���� �ʵ��� ���� ����
	fldDataFromScreen.settext(objFldDataToPopup.gettext());
}

// Ȯ�� ��ư �̺�Ʈ ó��
function btnOk_on_mouseup(objInst)
{
	// �ι� ȭ���� ȭ�� ������Ʈ�� ����
	var objParentScreen = screen.getparent();
	
	// �θ� ȭ���� "fldDataFromPopup" �ʵ� ��Ʈ���� ����
	var objFldDataFromPopup = objParentScreen.getinstancebyname("fldDataFromPopup");
	
	// �θ� ȭ���� �ʵ忡 �˾� ȭ���� �ʵ��� ���� ����
	objFldDataFromPopup.settext(fldDataToScreen.gettext());
	
	// �˾� ȭ�� �ݴ� �ռ� ȣ��
	screen.unloadpopup(1);
}

// ��� ��ư �̺�Ʈ ó��
function btnCancel_on_mouseup(objInst)
{
	// �˾� ȭ�� �ݱ� Ȯ��
	if(screen.confirm("�˾� ȭ���� �����ðڽ��ϱ�?") == true) {
		// �˾� ȭ�� �ݴ� �ռ� ȣ��
		screen.unloadpopup(0);
	}
}
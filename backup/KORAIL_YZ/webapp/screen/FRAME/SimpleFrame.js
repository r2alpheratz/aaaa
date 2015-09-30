// �����ڰ� ���� ������ �Լ�
// ȭ�� Ÿ��Ʋ �ؽ�Ʈ�� �� �������� �ؽ�Ʈ�� ����
function setTitleTextAndTabItemText(nTabIndex)
{
	// �� �����ۿ� ��ũ�� ȭ���� Ÿ��Ʋ�� ���Ͽ� ȭ�� Ÿ��Ʋ ����
	txtScreenTitle.settext(tabScreen.getinnerscreentitle(nTabIndex));
	
	// Ÿ��Ʋ �ؽ�Ʈ ���� �游ŭ �ؽ�Ʈ ��Ʈ���� ���� ����
	txtScreenTitle.fittext();
	
	// �ܿ� ��ũ�� ȭ�� ������Ʈ�� ����
	var objScreen = tabScreen.getchildscreeninstance(nTabIndex);

	// �ǿ� ��ũ�� ȭ���� ID�� ����
	var strScreenId = objScreen.getscreenid();
	
	// �� ������ �ؽ�Ʈ�� ��ũ�� ȭ���� ID�� ����
	tabScreen.settabitemtext(nTabIndex, strScreenId);
	
	return;
}

// ���� ��ư �̺�Ʈ ó��
function btnOpenScreen_on_mouseup(objInst)
{
	// ȭ�� ��� �ʵ� ���� ����
	var strScreenUrl = fldScreenUrl.gettext();
	if(strScreenUrl.length == 0) {
		screen.alert("ȭ�� ��θ� �Է��ϼ���");
		return;
	}
	
	// �ǿ� ȭ�� ��ο� �ش��ϴ� ȭ���� �ε��ϰ�, ���� �߰��� �� �������� �ε����� ����
	var nTabIndex = tabScreen.addtab("SCREEN_ID", 1, 100, strScreenUrl);
	if(nTabIndex == -2) {
		screen.alert("ȭ�� ��ο� �ش��ϴ� ȭ���� �������� �ʽ��ϴ�.");
		return;
	}
	
	// ȭ�� Ÿ��Ʋ �ؽ�Ʈ�� �� �������� �ؽ�Ʈ�� �����ϴ� �Լ� ȣ��
	setTitleTextAndTabItemText(nTabIndex);
}

// �ݱ� ��ư �̺�Ʈ ó��
function btnCloseScreen_on_mouseup(objInst)
{
	// ���� ��Ŀ���� ���� ���� �ε����� ����
	var nTabIndex = tabScreen.gettabitemfocus();
	if(nTabIndex < 0) {
		screen.alert("���� ���� �����ϴ�.");
		return;
	}
	
	// ���� ��Ŀ���� ���� �� �������� ������
	// �� ��Ʈ���� "on_itemdestroy" �̺�Ʈ�� �߻��Ѵ�.
	tabScreen.deletetab(nTabIndex);
}

// Reload ��ư �̺�Ʈ ó��
function btnReloadScreen_on_mouseup(objInst)
{	
	// ���� ��Ŀ���� ���� �� �������� �ε����� ����
	var nTabIndex = tabScreen.gettabitemfocus();
	if(nTabIndex < 0) {
		screen.alert("���� ���� �����ϴ�.");
		return;
	}

	// ���� �ǿ� ��ũ�� ȭ���� URL�� ����	
	var strScreenUrl = tabScreen.getinnerscreenurl(nTabIndex);
	
	// ���� ��Ŀ���� ���� �ǿ� ���� ȭ�� URL�� �ش��ϴ� ȭ���� ���Ӱ� �ε�
	var nResult = tabScreen.setinnerscreenurl(nTabIndex, strScreenUrl);
	if(nResult == -2) {
		screen.alert("ȭ�� ��ο� �ش��ϴ� ȭ���� �������� �ʽ��ϴ�.");
		return;
	}

	// ȭ�� Ÿ��Ʋ �ؽ�Ʈ�� �� �������� �ؽ�Ʈ�� ����	
	setTitleTextAndTabItemText(nTabIndex);
}

// ���� ������ ���� ���� �̺�Ʈ ó��
function tabScreen_on_itemchange(objInst, itemindex)
{
	// ȭ�� Ÿ��Ʋ �ؽ�Ʈ�� �� �������� �ؽ�Ʈ�� ����
	setTitleTextAndTabItemText(itemindex);
}

// ���� ������ ���� �̺�Ʈ ó��
function tabScreen_on_itemdestroy(objInst, itemindex)
{
	// ȭ�� Ÿ��Ʋ �ؽ�Ʈ�� ������ �ʱ�ȭ
	txtScreenTitle.settext("");
	return 1;
}

// ȭ�� URL �ʵ忡 ���� Ű �̺�Ʈ ó��
function fldScreenUrl_on_keydown(objInst, keycode, bctrldown, bshiftdown, baltdown, bnumpadkey)
{
	// Ű�ڵ尡 ����Ű�� ���
	if(keycode == 13) {
		// "����" ��ư ���콺�� �̺�Ʈ ó�� �Լ��� ���� ȣ��
		btnOpenScreen_on_mouseup();
		return 1;
	}
	
	return 0;
}

// ���� ��ư �̺�Ʈ ó��
function btnAlign_on_mouseup(objInst)
{
	// ���� Ÿ�� �޺����� ���� ������ �ڵ� ���� ����
	var strAlignType = cboAlignType.getselectedcode();

	// ���� �ڵ� ���� ���� �б� ó��
	switch(strAlignType) {
		case "0" :	// �ִ�ȭ ��� 
			tabScreen.changeshowmode(1);			
			break;
		case "1" :	// ���� ����
			tabScreen.showtilevert();
			break;
		case "2" :	// ���� ����
			tabScreen.showtilehorz();
			break;
		case "3" :	// Cascade ����
			tabScreen.showcascade();
			break;
		default : 
			screen.alert("���ǵ��� ���� ���� Ÿ���Դϴ�.");
			break;
	}	
}

// ȭ�� �ε� �̺�Ʈ ó��
function screen_on_load()
{
	// ȭ�� URL �ʵ忡 �⺻�� ����
	fldScreenUrl.settext("/START/SayHello");
}
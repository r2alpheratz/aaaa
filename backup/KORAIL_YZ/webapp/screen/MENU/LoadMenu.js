// ȭ�� ���½� ����� Ȯ�� ���� �÷���
// �޴� ȭ�鿡�� �����ϱ� ���ؼ� ���ȴ�.
var bConfirmOpen = true;

// �޴� �ε� ��ư ���콺 �� �̺�Ʈ ó��
function btnLoadMenu_on_mousein(objInst)
{
	// �޴� ȭ���� ���� �� ���� ���� ����
	var nMenuWidth = 110;
	var nMenuHeight = 80;
	
	// �޴� ȭ���� �̸� ����
	var strMenuName = "MENU";
	
	// ��ư�� Left�� Bottom ��ġ�� �޴� ǥ�� ��ǥ ����
	var nMenuXPos = btnLoadMenu.getwindowleft();
	var nMenuYPos = btnLoadMenu.getwindowbottom();
	
	// �޴� ȭ�� �ε�
	factory.loadmenu(strMenuName, "/MENU/Menu", nMenuXPos, nMenuYPos, nMenuWidth, nMenuHeight, screen);
}

/**
 * �޴� ȭ�鿡�� ȣ��Ǵ� �Լ��̸�,
 * ȭ�� URL�� ���� ������ �ش��ϴ� ȭ���� �� �������� �߰��ϸ鼭 �ε��Ѵ�.
 * @param strScreenUrl �ε��� ȭ���� URL
 * @return 
 * 	>0 : �߰��� �� �ε���
 * 	-1 : ���� ����
 *	 -2 : ȭ���� �������� ����
 */ 
function loadScreenInTab(strScreenUrl)
{
	// �ǿ� ȭ�� ��ο� �ش��ϴ� ȭ���� �ε��ϰ�, ���� �߰��� �� �������� �ε����� ����
	var nTabIndex = tabScreen.addtab("SCREEN_ID", 1, 100, strScreenUrl);
	if(nTabIndex < 0) {
		return nTabIndex;
	}
	
	// �ܿ� ��ũ�� ȭ�� ������Ʈ�� ����
	var objScreen = tabScreen.getchildscreeninstance(nTabIndex);

	// �ǿ� ��ũ�� ȭ���� ID�� ����
	var strScreenId = objScreen.getscreenid();
	
	// �� ������ �ؽ�Ʈ�� ��ũ�� ȭ���� ID�� ����
	tabScreen.settabitemtext(nTabIndex, strScreenId);	
	
	return nTabIndex;
}

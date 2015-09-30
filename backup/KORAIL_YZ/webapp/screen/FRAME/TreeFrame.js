// ȭ�� �ε� �̺�Ʈ ó��
function screen_on_load()
{
	// Ʈ���� Root ������ �߰�
	var nRootItem = treMenu.insertitem("�޴� Ʈ��", 0, 0, 0);
	
	// Root �����ۿ� ������ ���丮 ������ �߰�
	var nDirItem = treMenu.insertitem("���� ȭ��", 1, 2, nRootItem);
	
	var nScreenItem;
	
	// ���丮 �����ۿ� ȭ���� ��ũ�� ������ �߰�
	nScreenItem = treMenu.insertitem("Say Hello", 3, 3, nDirItem);
	
	// �߰��� �����ۿ� ȭ�� ��� ���� ����
	treMenu.setitemdata(nScreenItem, "/START/SayHello");
	
	// ���丮 �����ۿ� ȭ���� ��ũ�� ������ �߰�	
	nScreenItem = treMenu.insertitem("Load Popup", 3, 3, nDirItem);
	
	// �߰��� �����ۿ� ȭ�� ��� ���� ����	
	treMenu.setitemdata(nScreenItem, "/POPUP/LoadPopup");
	
	// Root Ʈ�� �������� ��ħ
	treMenu.expand(nRootItem, XFD_TREEITEM_EXPAND);
}

/**
 * ȭ�� URL�� ���� ������ �ε����� ����
 * @param strScreenUrl ã�� ȭ���� URL
 * @return 
 * 	>= 0 �� ������ �ε���
 * 	-1 �ǿ� ���� ���
 */
function getScreenTabIndex(strScreenUrl)
{
	var nTabIndex = -1;
	
	// �� �������� ������ ����
	var nTabCount = tabScreen.gettabitemcount();
	var i;

	// �� ������ ������ŭ Loop
	for(i = 0; i < nTabCount; i++) {
		// �� �����ۿ� ��ũ�� ȭ���� URL�� ����
		var strTempScreenUrl = tabScreen.getinnerscreenurl(i);
		
		// ȭ�� URL ���Ͽ� ������, Loop ����
		if(strTempScreenUrl == strScreenUrl) {
			nTabIndex = i;
			break;
		}
	}
	
	return nTabIndex;
}

// Ʈ�� ����Ŭ�� �̺�Ʈ ó��
function treMenu_on_itemdblclick(objInst, item)
{
	// ����Ŭ�� �̺�Ʈ�� �߻��� Ʈ�� �������� ������ ������ ����
	// ������ ������ ȭ�� �ε� �̺�Ʈ���� Ʈ�� ������ �߰���
	// setitemdata �Լ��� ���ؼ� ������ ��������
	var strItemData = treMenu.getitemdata(item);
	
	// Ʈ�� �����ۿ� ������ �����Ͱ� ���� ��쿡�� �׳� ����
	if(strItemData == 0) {
		return;
	}
	
	// ȭ�� �ߺ� ���� ��� �ɼ��� üũ�Ǿ� ���� ���� ���
	if(chkOption.getcheck() == false) {
		// �ǿ� �̹� ȭ���� ������ �ִ��� Ȯ��
		var nTabIndex = getScreenTabIndex(strItemData);
		if(nTabIndex >= 0) {
			// �ǿ� �̹� ȭ���� ������ �ִ� ���, 
			// �ش� �� �����ۿ� ��Ŀ���� �ְ�, ����
			tabScreen.settabitemfocus(nTabIndex, true);
			return;
		}
	}
	
	// Ʈ�� ������ �����ʹ� ȭ�� ��ΰ� �����Ǿ� �����Ƿ�, ȭ�� �ε� �Լ� ȣ��
	var nRet = loadScreenInTab(strItemData);
	if(nRet < 0) {
		screen.alert("ȭ�� �ε� ������ �߻��Ͽ����ϴ�.");
	}
	
	return;
}

/**
 * ȭ�� URL�� ���� ������ �ش��ϴ� ȭ���� �� �������� �߰��ϸ鼭 �ε��Ѵ�.
 * Ʈ�� ��Ʈ���� ���� Ŭ�� �̺�Ʈ ó�� �Լ����� ȣ���ϴ� �Լ��̴�.
 * @param strScreenUrl �ε��� ȭ���� URL
 * @return 
 * 	>0 : �߰��� �� �ε���
 * 	-1 : ���� ����
 * 	-2 : ȭ���� �������� ����
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

// ����� ��ư �̺�Ʈ ó��
function btnHide_on_mouseup(objInst)
{
	// ����� ��ư�� ����
	btnHide.setvisible(false);
	
	// üũ �ڽ� ����
	chkOption.setvisible(false);
	
	// ���̱� ��ư�� ǥ��
	btnShow.setvisible(true);
		
	// Ʈ�� ��Ʈ���� ����
	treMenu.setvisible(false);
		
	// ���� ��ǥ�� ���ϰ�, ���� ��ǥ�� ���� X ���� �����ϰ�, ���� ũ�� ����
	var arrRect = tabScreen.getrect();
	arrRect[0] = arrRect[0] - 140;
	tabScreen.setrect(arrRect[0], arrRect[1], arrRect[2], arrRect[3]);	
	
	return;
}

// ���̱� ��ư �̺�Ʈ ó��
function btnShow_on_mouseup(objInst)
{
	// ����� ��ư�� ǥ��
	btnHide.setvisible(true);
		
	// üũ �ڽ� ǥ��
	chkOption.setvisible(true);
			
	// ���̱� ��ư�� ����
	btnShow.setvisible(false);
		
	// Ʈ�� ��Ʈ���� ǥ��
	treMenu.setvisible(true);
	
	// ���� ��ǥ�� ���ϰ�, ���� ��ǥ�� ���� X ���� �����ϰ�, ���� ũ�� ����
	var arrRect = tabScreen.getrect();
	arrRect[0] = arrRect[0] + 140;
	tabScreen.setrect(arrRect[0], arrRect[1], arrRect[2], arrRect[3]);
	
	return;
}
// �߰� ��ư �̺�Ʈ ó��
function btnAdd_on_mouseup(objInst)
{
	// �׸����� ���ο� �������� �߰�
	var nRowIndex = grdList.additem();
	
	// ���õ� �������� ��ġ�� ���� �߰��� ���������� �̵�
	grdList.setselectitem(nRowIndex, 0);
}

// üũ ���� ��ư �̺�Ʈ ó��
function btnDeleteChecked_on_mouseup(objInst)
{
	var nCheckedRowCount = grdList.getcheckedrowcount();
	if(nCheckedRowCount < 1) {
		screen.alert("üũ�� �ο찡 �����ϴ�.");
		return;
	}
	
	// ��� üũ�� �ο� ����
	grdList.deletecheckedrow();
}

// ��ü ���� ��ư �̺�Ʈ ó��
function btnDeleteAll_on_mouseup(objInst)
{
	// ��� �ο� ����
	grdList.deleteall();
}
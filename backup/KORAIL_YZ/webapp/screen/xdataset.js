// ��ȸ ��ư �̺�Ʈ ó��
function btnSelect_on_mouseup()
{
	screen.requestsubmit("TR_SELECT_EMP", true);
}

// First-Row ��ȸ ��ư �̺�Ʈ ó��
function btnFristRowSelect_on_mouseup()
{
	screen.requestsubmit("TR_FIRSTROW_EMP", true);
}

// ���� ��ư �̺�Ʈ ó��
function btnDeleteEmp_on_mouseup()
{
	var nCurrentRow;

	// ���� ���õ� �ο츦 ����
	nCurrentRow = grdEmpList.getselectrow();
	if(nCurrentRow < 0) {
		return;
	}
	
	// ���� ���õ� �ο츦 ����
	if(screen.confirm("���� ���õ� �ο츦 �����Ͻðڽ��ϱ�?") == true) {
		grdEmpList.deleterow(nCurrentRow);
	}
}

// �ű� ��ư �̺�Ʈ ó��
function btnNewEmp_on_mouseup()
{
	// �� �������� �ο� �߰��ϰ�, �߰��� �ο츦 ������
	var nRowIndex = grdEmpList.additem();
	grdEmpList.setselectitem(nRowIndex, 0);
}

// ���� ��ư �̺�Ʈ ó��
function btnProcessEmp_on_mouseup()
{
	screen.requestsubmit("TR_PROCESS_EMP", true);
}

// ȭ�� �ε� �̺�Ʈ ó��
function screen_on_load()
{
	screen.requestsubmit("TR_SELECT_EMP", true);
}

// Ʈ����� ó�� �Ϸ� �̺�Ʈ ó��
function screen_on_submitcomplete(mapid, result, recv_userheader, recv_code, recv_msg)
{
	MAP_ID.settext(mapid);
	RESULT.settext(result);
	RECV_CODE.settext(recv_code);
	RECV_MSG.settext(recv_msg);
}
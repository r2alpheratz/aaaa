// �ڵ� ������ ���� ��ư �̺�Ʈ ó��
function btnSetCode_on_mouseup(objInst)
{
	// �⺻ �޺� �ڽ��� �ִ� ������ ��� ����
	cboScript.removeall();

	// �ڵ� �� �ڵ� ����(Comment)�� ���� ��� ���� ����
	var arrCode = ["01", "02", "03"];
	var arrComment = ["���ѹα�", "�߱�", "�̱�"];

	// �ڵ� �����Ϳ� ���� Delimeter ���� ����
	var strDelimeter = ":";
			
	var i;

	// JavaScript ���� ��� ������ ���� ���̴� length �Ӽ��� �о ���� �� �ִ�.
	// ��� ���� ��ŭ Loop�� ���鼭 �޺� �ڽ��� �ڵ� ������ �߰�
	for(i = 0; i < arrCode.length; i++) {
		// �ڵ� ������ ���� : "�ڵ�" + "�ڵ� Delimeter" + "�ڵ� ����(Comment")
		cboScript.addstring(arrCode[i] + strDelimeter + arrComment[i]);
	}
}
/*
** =================================================================================================
** �� �� �� �� : YZ (���Ͱ���)
** ȭ  ��  ID : YFAA001_S01
** ȭ  ��  �� : ���׷� ��ȸ
** ��      �� : 
** ================================================================================================= 
** << ���� ���� >>
** -------------------------------------------------------------------------------------------------
** �� �� �� ��  : ������ : ��	��	��	��
** -------------------------------------------------------------------------------------------------
** 2014-03-01 : ������ : �ű��ۼ�
** YYYY-MM-DD :       
** =================================================================================================
*/

/* 
** ========================================================================
** 1. ���� ���� ����
** ======================================================================== 
*/
//var bContinue = true; //����¡ó���� �ʿ��� ��������

/*
** ========================================================================
** 2. ȭ�� �̺�Ʈ ����
** ========================================================================
*/

/*
* ȭ�� �·ε�
*/ 
function screen_on_load()
{
	KRI.init(screen);	// ȭ�� �ʱ�ȭ (�ʼ�) //���ÿ��� �׽�Ʈ�� �����߻����� �ּ�ó��
	STGP_CD.insertstring(0, ":��ü");
	STGP_CD.setselectedindex(0);
	TRN_CLSF_CD.setselectedindex(0);
	STGP_CD.setfocus();
}

/*
* ��ũ�� ������ �����
*/ 
function screen_on_size(window_width, window_height)
{
	KRI.processResize(screen, window_width, window_height);
}

/*
* ��ũ������ Ű �Է½�
*/
function screen_on_keydown(keycode, bctrldown, bshiftdown, baltdown, bnumpadkey)
{
	if(keycode == 13) //����Ű �Է�
	{
		fn_search();
	}
	return 0;
}

/* 
* submit �Ϸ�� ȣ��
*/
function screen_on_submitcomplete(mapid, result, recv_userheader, recv_code, recv_msg)
{
	if (KRI.submitComplete(screen, mapid, result, recv_userheader, recv_code, recv_msg) == false) return;
	if(mapid == "/yz/yf/aa/selectListStgpInfo.do")
	{
		var nRowCnt = grdList.getrowcount();
//		QRY_CNT_FLD.settext("�� "+grdList.getrowcount()+"/"+dsCond.getdatabyname(0,"TOT_CNT") +"��");
		if (nRowCnt > 0)
		{
			fldQRY_CNT.settext("�� "+nRowCnt+"��");
			fldQRY_CNT.setvisible(true);
			/*��ȸ��� �޽���*/
			KRI.setTranMessage(screen, 0, "���������� ��ȸ �Ǿ����ϴ�.");
		}
		else /* ��ȸ����� 0���̸� */
		{
			KRI.setTranMessage(screen, 0, "��ȸ�� �ڷᰡ �����ϴ�.");		
		}
		/* ����ROW�� ������ �ڵ� ����¡ ó�� */		
//		if (dsCond.getdatabyname(0, "QRY_NUM_NEXT") != 0 && bContinue == true)
//		{
//			KRLog.trace("# "+dsCond.getdatabyname(0, "QRY_NUM_NEXT"));
//			KRLog.trace("# "+dsCond.getdatabyname(0, "PG_PR_CNT"));
//			KRI.setGridMode(screen, grdList, KRConstant.GRID_APPEND);
//			KRI.requestSubmit(screen, "/tz/pl/selectStgpCdList.do", true);
//		}else		
//		{   
//            /* �ߴ����� ������ ��� ���̻� ��ȸ���� �ʰ� �˶��޽��� ǥ�� */
//            if(bContinue == false)
//            {
//			    bContinue = true;
//			    KRI.alert(screen, "����� ��û�� ���� ��ȸ�� �ߴ��߽��ϴ�.");
//            }
//
//            /* ��ȸ�� �Ϸ�Ǹ� �ݵ�� WIAT DIALOG�� �ݾƾ� �Ѵ� */
//		    KRI.endWaitDialog(screen);
//        
//            /* ��ȸ�� �Ǽ���ŭ ǥ�� */
//		    QRY_CNT_FLD.settext("�� " + grdList.getrowcount() +" ��");
//					
//		}
		
	}
}

/*
** ========================================================================
** 3. �ʼ� ���� �Լ� ����
** ========================================================================
*/

/*
* ȭ���� ������¡ �ɶ� ������ ��Ʈ�������� ����Ѵ�.
*/
function processResize()
{
//	KRI.addResize(pnlCondition, KRConstant.CST_DIRECTION_HORZ);
//	KRI.addReposition(pnlSearch, KRConstant.CST_DIRECTION_HORZ);
//	KRI.addResize(OUTREC1_GRID, KRConstant.CST_DIRECTION_BOTH);
}


/*
** ========================================================================
** 4. ����� ���� �Լ� ����
** ========================================================================
*/

function fn_search()
{

	dsStgpInfoList.init();
	//����¡ó����
	//dsCond.setdatabyname(0,"QRY_NUM_NEXT","0");
	//KRI.beginWaitDialog(screen);
	dsCond.setdatabyname(0, "STGP_CD", STGP_CD.getselectedcode());
	dsCond.setdatabyname(0, "TRN_CLSF_CD", TRN_CLSF_CD.getselectedcode());	
	KRLog.trace("117");
	KRI.requestSubmit(screen,"/yz/yf/aa/selectListStgpInfo.do",true);
}

/*
** ========================================================================
** 5. ��Ʈ�� �̺�Ʈ ����
** ========================================================================
*/

function btnSearch_on_mouseup(objInst)
{
	fn_search();
}
/* //����¡ ó���� �������� ����
function screen_on_keydown(keycode, bctrldown, bshiftdown, baltdown, bnumpadkey)
{
	if(keycode == 27){
		bContinue = false;
	}
	return 0;
}
*/
//��ũ�ѹٰ� ������ �������� �� ����ȸ �ϴ� ����¡ó��
/*
function grdList_on_vscroll(objInst, nScrollPos, nPrevScrollPos, nSBCode, bSBMax)
{
	if (bSBMax && dsCond.getdatabyname(0,"QRY_NUM_NEXT") != 0)
	{
		KRI.setGridMode(screen,objInst, KRConstant.GRID_APPEND);
		KRI.requestSubmit(screen,"/tz/pl/selectStgpCdList.do",true);
	}
	else if (bSBMax && dsCond.getdatabyname(0,"QRY_NUM_NEXT")== 0)
	{
		KRI.alert(screen, "��ȸ�� �ڷᰡ �����ϴ�.");
	}
}*/
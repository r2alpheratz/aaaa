/*
** =================================================================================================
** �� �� �� �� : YZ (���Ͱ���)
** ȭ  ��  ID : YSAA001_P02
** ȭ  ��  �� : ������ ��ó�������ȸ
** ��      �� : ���Ͱ��� ó����� �̷��� ��ȸ�Ѵ�.
** ================================================================================================= 
** << ���� ���� >>
** -------------------------------------------------------------------------------------------------
** �� �� �� ��  : ������ : ��	��	��	��
** -------------------------------------------------------------------------------------------------
** 2014-04-08 : ������ : �ű��ۼ�
** YYYY-MM-DD :       
** =================================================================================================
*/

/* 
** ========================================================================
** 1. ���� ���� ����
** ======================================================================== 
*/

var m_yzmod 	  = KRI.getTeamModule(screen, "YZ", "YZCmmnUtil");

var m_today 	  = KRUtil.TodayDate(screen); 			/* ���� ��¥ ��������		*/
var m_runTrmStDt  = KRUtil.addDateFromYYYYMMDD(m_today, 1); /* ����Ⱓ�������� �⺻��	*/
var m_runTrmClsDt = KRUtil.addDateFromYYYYMMDD(m_today, 2); /* ����Ⱓ�������� �⺻��	*/

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
	KRI.init(screen);	// ȭ�� �ʱ�ȭ (�ʼ�)
	var sJobDt = KRI.getLinkValue("JOB_DT");
	var sRunDt = KRI.getLinkValue("RUN_DT");
	var sTrnNo = KRI.getLinkValue("TRN_NO");
	KRI.clearLinkValue();
	
	
	/* �۾�����, ���� ���� */
	fldJOB_DT.settext(sJobDt);
	m_yzmod.fn_setDayField(fldJOB_DT, txtJobDay);
	/* ��������, ���� ���� */
	fldRUN_DT.settext(sRunDt);
	m_yzmod.fn_setDayField(fldRUN_DT, txtDay);
	/* ������ȣ ���� */
	fldTRN_NO.settext(sTrnNo);
	/*��� ������Ʈ �ʱ�ȭ ����*/
	fn_init();

	fn_search();
}

/*
* ��ũ�� ������ �����
*/ 
function screen_on_size(window_width, window_height)
{
	KRI.processResize(screen, window_width, window_height);
}

/* 
* submit �Ϸ�� ȣ��
*/
function screen_on_submitcomplete(mapid, result, recv_userheader, recv_code, recv_msg)
{
	if (KRI.submitComplete(screen, mapid, result, recv_userheader, recv_code, recv_msg) == false) return;
	
	if (mapid == "/yz/ys/aa/selectListDtlPrsCnqe.do")
	{
		var nRowCnt = grdList.getrowcount();
		if (nRowCnt > 0)
		{
			fldQRY_CNT.setvisible(true);
			fldQRY_CNT.settext("�� "+nRowCnt+"��");
			/*���Ͱ����Ҵ�ó������(����) �÷��� "�ݿ�����"�� ��� ������ ǥ��*/
			fn_setGridColor(grdList, dsList);
			/*��ȸ��� �޽���*/
			KRI.setTranMessage(screen, 0, "���������� ��ȸ �Ǿ����ϴ�.");
		}
		else /* ��ȸ����� 0���̸� */
		{
			KRI.setTranMessage(screen, 0, "��ȸ�� �ڷᰡ �����ϴ�.");
			fldQRY_CNT.setvisible(false);
			fldQRY_CNT.settext("");
		}

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
function fn_init()
{
	
	/* GRID CLEAR */
	KRI.setGridMode(screen, grdList, KRConstant.GRID_CLEAR);
	/* xDataSet �ʱ�ȭ */	
	dsList.init();
	/* �ѰǼ� �ʱ�ȭ */
	fldQRY_CNT.settext("");
	fldQRY_CNT.setvisible(false);
}
/* �۾��Ϻ� ���Ͱ�������� ��ȸ */
function fn_search()
{
    /* GRID CLEAR */
	KRI.setGridMode(screen, grdList, KRConstant.GRID_CLEAR);
    /* xDataSet �ʱ�ȭ */	
	dsList.init();
	KRI.requestSubmit(screen,"/yz/ys/aa/selectListDtlPrsCnqe.do",true);

	
    /* ��ȸ �� �ߴ� �����ϵ��� ȭ�鿡 ��Ŀ���� ���� */
	screen.setfocus();
}
/*���Ͱ����Ҵ�ó������(����) �÷��� "�ݿ�����"�� ��� ������ ǥ��*/
function fn_setGridColor(oGrid, oDataset)
{
	for (var i = 0; i < oGrid.getrowcount(); i++)
	{
		var sAlcPrsSttCd = oDataset.getdatabyname(i, "ALC_PRS_STT_CD");
		if (sAlcPrsSttCd == "9")
		{
			oGrid.setitemforecolor(i, oGrid.getcolumn("ALC_PRS_STT_CD"), factory.rgb(255, 0, 0));
		}
	}
}

/*
** ========================================================================
** 5. ��Ʈ�� �̺�Ʈ ����
** ========================================================================
*/
/* �ݱ� ��ư Ŭ�� */
function btnClose_on_mouseup(objInst)
{
	KRI.unloadPopup(screen);
}
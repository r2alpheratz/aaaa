/*
** =================================================================================================
** �� �� �� �� : YZ (���Ͱ���)
** ȭ  ��  ID : YSBA001_M01
** ȭ  ��  �� : ���俹��(�⺻)
** ��      �� : �⺻���� ��������� ���� ��ȸ �� ����
** ================================================================================================= 
** << ���� ���� >>
** -------------------------------------------------------------------------------------------------
** �� �� �� ��  : ������ : ��	��	��	��
** -------------------------------------------------------------------------------------------------
** 2014-04-17 : ������ : �ű��ۼ�
** YYYY-MM-DD :       
** =================================================================================================
*/

/* 
** ========================================================================
** 1. ���� ���� ����
** ======================================================================== 
*/

var m_yzmod 	  = KRI.getTeamModule(screen, "YZ", "YZCmmnUtil");

//var m_today 	  = KRUtil.TodayDate(screen); 			/* ���� ��¥ ��������		*/
var m_today 	  = "20101101"; 

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
	
	/*��� ������Ʈ �ʱ�ȭ ����*/
	fn_init();
	
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
	
	if (mapid == "/yz/ys/ba/selectListUsrCtlYmgtFcstBsTrn.do")
	{
		var nRowCnt = grdList.getrowcount();
		if(nRowCnt > 0)
		{
			fldQRY_CNT.setvisible(true);
			fldQRY_CNT.settext("�� "+nRowCnt+"��");
			/*��ȸ��� �޽���*/
			KRI.setTranMessage(screen, 0, "���������� ��ȸ �Ǿ����ϴ�.");
		}
		else /* ��ȸ����� 0���̸� */
		{
			fldQRY_CNT.setvisible(false);
			fldQRY_CNT.settext("");
			KRI.setTranMessage(screen, 0, "��ȸ�� �ڷᰡ �����ϴ�.");
			
		}
		fldQRY_CNT2.setvisible(false);
		fldQRY_CNT2.settext("");
				
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
	//��¥ ������Ʈ ���ó�¥�� ����
	fldRUN_DT.settext(m_today);
	m_yzmod.fn_setDayField(fldRUN_DT, txtDay);//���� ����
	
	/* GRID CLEAR */
	KRI.setGridMode(screen, grdList, KRConstant.GRID_CLEAR);
	KRI.setGridMode(screen, grdListDtl, KRConstant.GRID_CLEAR);
    /* xDataSet �ʱ�ȭ */	
	dsList.init();
	dsListDtl.init();
	/* �ѰǼ� �ʱ�ȭ */
	fldQRY_CNT.settext("");
	fldQRY_CNT2.settext("");
	fldQRY_CNT.setvisible(false);
	fldQRY_CNT2.setvisible(false);
	
	/* ������ȣ �ʱ�ȭ */
	fldTRN_NO.settext("");
	
	/* ���� �޺��ڽ� ���� */  
	KRI.sortComboboxData(cboDAY_DV_CD, 0, 1);
	cboDAY_DV_CD.setselectedindex(0);
	
}
/* ����Ⱓ�� ������ȣ ��ȸ ��ȸ */
function fn_search()
{
    /* GRID CLEAR */
	KRI.setGridMode(screen, grdList, KRConstant.GRID_CLEAR);
	KRI.setGridMode(screen, grdListDtl, KRConstant.GRID_CLEAR);
    /* xDataSet �ʱ�ȭ */	
	dsList.init();
	dsListDtl.init();
	
	KRI.requestSubmit(screen,"/yz/ys/ba/selectListUsrCtlYmgtFcstBsTrn.do",true);

	
    /* ��ȸ �� �ߴ� �����ϵ��� ȭ�鿡 ��Ŀ���� ���� */
	screen.setfocus();
}
/*�۾����ں� ��ȸ validation Check*/
function validCheck()
{
	if(fldRUN_DT.gettext() == "")
	{
		KRI.alert(screen, "��¥�� �Է��ϼ���");
		fldRUN_DT.setfocus();
		return false;
	}

	return true;
}


/*
** ========================================================================
** 5. ��Ʈ�� �̺�Ʈ ����
** ========================================================================
*/

//�������� �޷��˾� ��ưŬ�� �̺�Ʈ
function btnCalendar_on_mouseup(objInst)
{
	KRI.showCalendar(screen, fldRUN_DT);
	m_yzmod.fn_setDayField(fldRUN_DT, txtDay);
}
/*
** ========================================================================
** ��¥, �Ⱓ �� ������ focusout �̺�Ʈ 
** ver : 1.0
** author : ������
** ���obj : fldRUN_DT(��������) + txtDay(����)
**		  fldRUN_TRM_ST_DT(����Ⱓ��������) + txtFromDay(����)
**		  fldRUN_TRM_CLS_DT(����Ⱓ��������) + txtToDay(����)
**
** ��¥�Է��ʵ��� focusout �̺�Ʈ�� ��������־����.
** �� ��ȸ �̺�Ʈ �� ��¥�� ����� �ִ� ��쿡 validation check �ؾ���
** �� �Ⱓ ��ȸ �� (��������-��������) validation check �ؾ���
** ========================================================================
*/
function fldDate_on_focusout(objInst)
{
	var sObjNm = objInst.getname();
	var sDate = KRUtil.trim(objInst.gettext());
	var isValid = KRUtil.checkDate(sDate, "YYYYMMDD", true); //�� ����Ͽ� ��¥ ��ȿ�� check
	if(!isValid) //���������� ��¥ ���� ���
	{
		KRI.alert(screen, "��¥�� �ٸ��� �Է��ϼ���.");
		objInst.settext("");
		objInst.setfocus();
		if(sObjNm == "fldRUN_DT") txtDay.settext("");
		else if(sObjNm == "fldRUN_TRM_ST_DT") txtFromDay.settext("");
		else if(sObjNm == "fldRUN_TRM_CLS_DT") txtToDay.settext("");
		else if(sObjNm == "fldJOB_DT") txtJobDay.settext("");
		return false;
	}
	else
	{
		if(sDate == "")
		{
			if(sObjNm == "fldRUN_DT") txtDay.settext("");
			else if(sObjNm == "fldRUN_TRM_ST_DT") txtFromDay.settext("");
			else if(sObjNm == "fldRUN_TRM_CLS_DT") txtToDay.settext("");
			else if(sObjNm == "fldJOB_DT") txtJobDay.settext("");
		}
		else
		{
			if(sObjNm == "fldRUN_DT") m_yzmod.fn_setDayField(objInst, txtDay);
			else if(sObjNm == "fldRUN_TRM_ST_DT") m_yzmod.fn_setDayField(objInst, txtFromDay);
			else if(sObjNm == "fldRUN_TRM_CLS_DT") m_yzmod.fn_setDayField(objInst, txtToDay);
			else if(sObjNm == "fldJOB_DT") m_yzmod.fn_setDayField(objInst, txtJobDay);
		}
	}
}

/*
** ========================================================================
** ������ȣ����(�⺻) �˾� ���� ��ũ��Ʈ
** ver : 1.2
** author : changki.woo
** ������� 2���� ������ callType�� ����
**
** callType = "YMS" (YMS�� �´� ������ȣ�� ������)  YRAA001_S01 ����
** callType = "BASE"(��� ������ȣ�� ������) YRAA006_S01 ����
** trnNoBsPopupCall()���� callType�� ��Ȯ�ϰ� ��������� �۵���.
** ========================================================================
*/

function fn_call_trn_no_popup()
{
	var callType = "BASE"
	var popupUrl="/BIZ/YZ/YB/CO/YBCO002_P01";
	m_yzmod.trnNoBsPopupCall(screen, callType, popupUrl);
}


//�����̾Ƴ��� �˾� ȣ����� �ѹ��� ȣ���ϴ� �Լ�.
//
// delimiter - ���� ���� �Ķ���� (���񽺿��� �޾Ƽ� �б�)
//
function trnNoBs_on_mousedown(objInst)
{	
	fn_call_trn_no_popup();
}


function fldTRN_NO_on_keydown(objInst, keycode, bctrldown, bshiftdown, baltdown, bnumpadkey)
{
	//��ȸ����
	if(keycode == 13)
	{
		fn_call_trn_no_popup();
	}
}

/*
** ========================================================================
** ������ȣ����(�⺻) �˾� ���� ��ũ��Ʈ ��
** ========================================================================
*/

function btnSearch_on_mouseup(objInst)
{
	fn_search();
}
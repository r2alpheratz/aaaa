/*
** =================================================================================================
** �� �� �� �� : YZ (���Ͱ���)
** ȭ  ��  ID : YSAA002_M01
** ȭ  ��  �� : ���Ͱ�������� �Ϻ��м�
** ��      �� : ���Ͱ����۾� ��Ȳ�� �ľ��ϰ� ���Ͱ���������� �м����¸� ó���Ѵ�.
** ================================================================================================= 
** << ���� ���� >>
** -------------------------------------------------------------------------------------------------
** �� �� �� ��  : ������ : ��	��	��	��
** -------------------------------------------------------------------------------------------------
** 2014-03-27 : ������ : �ű��ۼ�
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
	

	/* ȭ�� �ε�� �۾����ں� ��ȸ�� �⺻���� ���� */
	rdoJOB_DT_SRCH.setcheck(true);
	
	
	/*��� ������Ʈ �ʱ�ȭ ����*/
	fn_init();
	
	/* �ֿ��༱/�뼱 �����ͼ� ���� */
	/* xDataSet �ʱ�ȭ */	
	dsMrntList.init();
	dsRoutList.init();
	dsObjCond.insertrow(0);
	dsObjCond.setdatabyname(0, "MRNT", "1");
	dsObjCond.setdatabyname(0, "ROUT", "1");
	KRI.requestSubmit(screen,"/yz/yb/co/selectListObject.do",true);
	
		
	
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
	
	if (mapid == "/yz/yb/co/selectListObject.do") /*�ֿ��༱/�뼱 ��ü��ȸ �� ���Ͱ��� ����ڸ�� ��ȸ*/
	{
		cboMRNT.setselectedindex(0);
		cboROUT.setselectedindex(0);
		cboMRNT2.setselectedindex(0);
		cboROUT2.setselectedindex(0);
		KRI.setTranMessage(screen, 0, "ȭ���� �ε� �Ǿ����ϴ�.");
	}
	else if (mapid == "/yz/ys/aa/selectListYmgtTgtTrnDdprAnalJobDt.do")
	{
		var nRowCnt = grdListJobDt.getrowcount();
		if(nRowCnt > 0)
		{
			fldQRY_CNT.setvisible(true);
			fldQRY_CNT.settext("�� "+nRowCnt+"��");
			btnExcel.setenable(true);
			btnTrnPrFcstAcvmAbrdPrnb.setenable(true);
			btnAlcCnqeQry.setenable(true); /* �Ҵ�����ȸ��ư */
			/*��ȸ��� �޽���*/
			KRI.setTranMessage(screen, 0, "���������� ��ȸ �Ǿ����ϴ�.");
		}
		else /* ��ȸ����� 0���̸� */
		{
			btnExcel.setenable(false);
			btnTrnPrFcstAcvmAbrdPrnb.setenable(false);
			btnAlcCnqeQry.setenable(false); /* �Ҵ�����ȸ��ư */
			
			fldQRY_CNT.setvisible(false);
			fldQRY_CNT.settext("");
			KRI.setTranMessage(screen, 0, "��ȸ�� �ڷᰡ �����ϴ�.");
			
		}
		fldQRY_CNT2.setvisible(false);
		fldQRY_CNT2.settext("");
				
	}
	else if (mapid == "/yz/ys/aa/selectListYmgtTgtTrnDdprAnalRunDt.do")
	{
		var nRowCnt = grdListRunDt.getrowcount();
		if(nRowCnt > 0)
		{
			fldQRY_CNT2.setvisible(true);
			fldQRY_CNT2.settext("�� "+nRowCnt+"��");
			/*���Ͱ����Ҵ�ó������(����) �÷��� "�ݿ�����"�� ��� ������ ǥ��*/
			fn_setGridColor(grdListRunDt, dsListRunDt);
			btnExcel.setenable(true);
			btnTrnPrFcstAcvmAbrdPrnb.setenable(true);
			btnAlcCnqeQry.setenable(true); /* �Ҵ�����ȸ��ư */

			
			/*��ȸ��� �޽���*/
			KRI.setTranMessage(screen, 0, "���������� ��ȸ �Ǿ����ϴ�.");
		}
		else /* ��ȸ����� 0���̸� */
		{
			fldQRY_CNT2.setvisible(false);
			fldQRY_CNT2.settext("");
			btnExcel.setenable(false);
			btnTrnPrFcstAcvmAbrdPrnb.setenable(false);
			btnAlcCnqeQry.setenable(false); /* �Ҵ�����ȸ��ư */
			KRI.setTranMessage(screen, 0, "��ȸ����� �����ϴ�.");		
		}
		fldQRY_CNT.setvisible(false);
		fldQRY_CNT.settext("");
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
	/*�۾�����, ���� �������ڷ� ����*/
	fldJOB_DT.settext(m_today);
	m_yzmod.fn_setDayField(fldJOB_DT, txtJobDay);
	/* ����Ⱓ���� (����~��)*/ 
	fldRUN_TRM_ST_DT.settext(m_runTrmStDt);
	fldRUN_TRM_CLS_DT.settext(m_runTrmClsDt);
	m_yzmod.fn_setDayField(fldRUN_TRM_ST_DT, txtFromDay);
	m_yzmod.fn_setDayField(fldRUN_TRM_CLS_DT, txtToDay);
	
	cboSTLB_TRN_CLSF_CD.setselectedcode("00");//KTX -�⺻ ����
	cboSTLB_TRN_CLSF_CD2.setselectedcode("00");//KTX -�⺻ ����

	
	/* �����౸���ڵ� -������- �⺻���� */
	cboUP_DN_DV_CD.setselectedindex(0);
	cboUP_DN_DV_CD2.setselectedindex(0);
	
	/*��������, ���� �������ڷ� ����*/
	fldRUN_DT.settext(m_today);
	m_yzmod.fn_setDayField(fldRUN_DT, txtDay);

	cboMRNT.setselectedindex(0);
	cboROUT.setselectedindex(0);
	cboMRNT2.setselectedindex(0);
	cboROUT2.setselectedindex(0);

	/* GRID CLEAR */
	KRI.setGridMode(screen, grdListJobDt, KRConstant.GRID_CLEAR);
	KRI.setGridMode(screen, grdListRunDt, KRConstant.GRID_CLEAR);
    /* xDataSet �ʱ�ȭ */	
	dsListJobDt.init();
	dsListRunDt.init();
	/* �ѰǼ� �ʱ�ȭ */
	fldQRY_CNT.settext("");
	fldQRY_CNT2.settext("");
	fldQRY_CNT.setvisible(false);
	fldQRY_CNT2.setvisible(false);
	
	fldTRN_NO.settext("");
	
	btnExcel.setenable(false);
	btnTrnPrFcstAcvmAbrdPrnb.setenable(false);
}
/* �۾����ں� ��ȸ */
function fn_searchJobDt()
{
    /* GRID CLEAR */
	KRI.setGridMode(screen, grdListJobDt, KRConstant.GRID_CLEAR);
	KRI.setGridMode(screen, grdListRunDt, KRConstant.GRID_CLEAR);
    /* xDataSet �ʱ�ȭ */	
	dsListJobDt.init();
	dsListRunDt.init();
	
	KRI.requestSubmit(screen,"/yz/ys/aa/selectListYmgtTgtTrnDdprAnalJobDt.do",true);

	
    /* ��ȸ �� �ߴ� �����ϵ��� ȭ�鿡 ��Ŀ���� ���� */
	screen.setfocus();
}
/*�۾����ں� ��ȸ validation Check*/
function validCheckJobDt()
{
	if(fldJOB_DT.gettext() == "")
	{
		KRI.alert(screen, "��¥�� �Է��ϼ���");
		fldJOB_DT.setfocus();
		return false;
	}
	if(fldRUN_TRM_ST_DT.gettext() == "")
	{
		KRI.alert(screen, "��¥�� �Է��ϼ���");
		fldRUN_TRM_ST_DT.setfocus();
		return false;
	}
	if(fldRUN_TRM_CLS_DT.gettext() == "")
	{
		KRI.alert(screen, "��¥�� �Է��ϼ���");
		fldRUN_TRM_CLS_DT.setfocus();
		return false;
	}
	if(!KRUtil.checkPeriodDate(fldRUN_TRM_ST_DT.gettext(), fldRUN_TRM_CLS_DT.gettext(), "YYYYMMDD", true))
	{
	    KRI.alert(screen, "��ȸ�������ڰ� ��ȸ�������ں��� Ŭ �� �����ϴ�.");
		fldRUN_TRM_ST_DT.setfocus();
		return false; 
	}
	return true;
}

/* �۾����ں� ��ȸ */
function fn_searchRunDt()
{
    /* GRID CLEAR */
	KRI.setGridMode(screen, grdListJobDt, KRConstant.GRID_CLEAR);
	KRI.setGridMode(screen, grdListRunDt, KRConstant.GRID_CLEAR);
    /* xDataSet �ʱ�ȭ */	
	dsListJobDt.init();
	dsListRunDt.init();
	
	KRI.requestSubmit(screen,"/yz/ys/aa/selectListYmgtTgtTrnDdprAnalRunDt.do",true);

	
    /* ��ȸ �� �ߴ� �����ϵ��� ȭ�鿡 ��Ŀ���� ���� */
	screen.setfocus();
}
/*�۾����ں� ��ȸ validation Check*/
function validCheckRunDt()
{
	if(fldRUN_DT.gettext() == "")
	{
		KRI.alert(screen, "��¥�� �Է��ϼ���");
		fldRUN_DT.setfocus();
		return false;
	}
	return true;
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
//�۾����� �޷��˾� ��ưŬ�� �̺�Ʈ
function btnJobCalendar_on_mouseup(objInst)
{
	KRI.showCalendar(screen, fldJOB_DT);
	m_yzmod.fn_setDayField(fldJOB_DT, txtJobDay);
}
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

//����Ⱓ �޷��˾� ��ưŬ�� �̺�Ʈ
function btnPeriodCalendar_on_mouseup(objInst)
{
	KRI.showPeriodCalendar(screen, btnPeriodCalendar, fldRUN_TRM_ST_DT, fldRUN_TRM_CLS_DT);
	m_yzmod.fn_setDayField(fldRUN_TRM_ST_DT, txtFromDay);
	m_yzmod.fn_setDayField(fldRUN_TRM_CLS_DT, txtToDay);
}

/* �ֿ��༱/�뼱 ��ȸ ��ư Ŭ�� */
function btnMrntRout_on_mouseup(objInst)
{
	var popupUrl="/BIZ/YZ/YB/CO/YBCO004_P01";
	KRI.loadSystemPopup(screen, popupUrl, true);
	
	//�˾�ȭ���� ����� ���� ����
	var sMrntCd = KRI.getLinkValue("MRNT_CD");
	var sMrntNm = KRI.getLinkValue("MRNT_NM");
	var sRoutCd = KRI.getLinkValue("ROUT_CD");
	var sRoutNm = KRI.getLinkValue("ROUT_NM");
	KRI.clearLinkValue();  
	if (sMrntCd == null || sMrntCd =="")
	{
		cboMRNT.setselectedindex(0);
		cboMRNT2.setselectedindex(0);
	}
	else
	{
		cboMRNT.setselectedcode(sMrntCd);
		cboMRNT2.setselectedcode(sMrntCd);
	}
	if (sRoutCd == null || sRoutCd == "")
	{
		cboROUT.setselectedindex(0);
		cboROUT2.setselectedindex(0);
	}
	else
	{
		cboROUT.setselectedcode(sRoutCd);
		cboROUT2.setselectedcode(sRoutCd);
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
	var callType = "YSAA001"
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

/* �۾����ں� ��ȸ/�������ں���ȸ ������ư Ŭ�� */
function rdo_on_click(objInst, bPrevCheckState, bCurCheckState)
{
	var sObjNm = objInst.getname();
	
	if(bPrevCheckState == 0) /* ����üũ���°� 0 �϶�(üũ�Ǿ����� �ʾ�����)�� ����*/
	{
	    fn_init();
		if(sObjNm == "rdoJOB_DT_SRCH") /* �۾����ں���ȸ ���ý� */
		{
			grdListJobDt.setvisible(true);
			grdListRunDt.setvisible(false);
			rdoRUN_DT_SRCH.setcheck(false);  /*üũ���º���*/
			/*�г�visible����*/
			pnlSearchRunDt.setvisible(false);
			pnlSearchRunDtBtn.setvisible(false);
			pnlSearchJobDt.setvisible(true);
			pnlSearchJobDtBtn.setvisible(true);
		}
		else
		{
			grdListJobDt.setvisible(false);
			grdListRunDt.setvisible(true);
			rdoJOB_DT_SRCH.setcheck(false);
			/*�г�visible����*/
			pnlSearchRunDt.setvisible(true);
			pnlSearchRunDtBtn.setvisible(true);
			pnlSearchJobDt.setvisible(false);
			pnlSearchJobDtBtn.setvisible(false);
		}
	}
}

/* �۾����ں� ��ȸ ��ưŬ�� */
function btnSearchJobDt_on_mouseup(objInst)
{
	//validation üũ
	if(validCheckJobDt())
	{
		fn_searchJobDt();
	}else 
		return false;
}
/* �������ں� ��ȸ ��ưŬ�� */
function btnSearchRunDt_on_mouseup(objInst)
{
	//validation üũ
	if(validCheckRunDt())
	{
		fn_searchRunDt();
	}else 
		return false;
}

/* ���� ��ưŬ�� */
function btnExcel_on_mouseup(objInst)
{
	if (rdoJOB_DT_SRCH.getcheck()) /* �۾����ں� ��ȸ */
	{
		grdListJobDt.saveexcel();
	}
	else /* �������ں���ȸ */
	{
		grdListRunDt.saveexcel();
	}
}


/* ������ ����/���� �����ο� ��ȸ ��ưŬ�� */
function btnTrnPrFcstAcvmAbrdPrnb_on_mouseup(objInst)
{
	var popupUrl="/BIZ/YZ/YS/AA/YSAA002_P01";
	var nRow = 0;
	var objPram = new Object();
	objPram = {};
	
	if (rdoJOB_DT_SRCH.getcheck()) /* �۾����ں���ȸ�ΰ�� */
	{
		nRow = grdListJobDt.getselectrow();
		objPram.runDt     = dsListJobDt.getdatabyname(nRow, "RUN_DT");
		objPram.trnNo     = dsListJobDt.getdatabyname(nRow, "TRN_NO");
		objPram.orgRsStnCdNm = dsListJobDt.getdatabyname(nRow, "ORG_RS_STN_CD_NM"); /* �ù߿��߿��ڵ�� */
		objPram.tmnRsStnCdNm = dsListJobDt.getdatabyname(nRow, "TMN_RS_STN_CD_NM"); /* �������߿��ڵ�� */
		objPram.dptTmPram = dsListJobDt.getdatabyname(nRow, "DPT_TM_PRAM"); /* ��߽ð�(�Ķ����-�ú���) */
		objPram.arvTmPram = dsListJobDt.getdatabyname(nRow, "ARV_TM_PRAM"); /* �����ð�(�Ķ����-�ú���) */
	}
	else /* �������ں���ȸ�ΰ�� */
	{
		nRow = grdListRunDt.getselectrow();
		objPram.runDt     = dsListRunDt.getdatabyname(nRow, "RUN_DT");
		objPram.trnNo     = dsListRunDt.getdatabyname(nRow, "TRN_NO");
		objPram.orgRsStnCdNm = dsListRunDt.getdatabyname(nRow, "ORG_RS_STN_CD_NM"); /* �ù߿��߿��ڵ�� */
		objPram.tmnRsStnCdNm = dsListRunDt.getdatabyname(nRow, "TMN_RS_STN_CD_NM"); /* �������߿��ڵ�� */
		objPram.dptTmPram = dsListRunDt.getdatabyname(nRow, "DPT_TM_PRAM"); /* ��߽ð�(�Ķ����-�ú���) */
		objPram.arvTmPram = dsListRunDt.getdatabyname(nRow, "ARV_TM_PRAM"); /* �����ð�(�Ķ����-�ú���) */
	}
	
	KRLog.trace("runDt:::::::::"+objPram.runDt);
	KRLog.trace("trnNo:::::::::"+objPram.trnNo);
	KRLog.trace("orgRsStnCdNm:::::::::"+objPram.orgRsStnCdNm);
	KRLog.trace("orgRsStnCdNm:::::::::"+objPram.orgRsStnCdNm);
	KRLog.trace("dptTmPram:::::::::"+objPram.dptTmPram);
	KRLog.trace("arvTmPram:::::::::"+objPram.arvTmPram);
	KRI.setLinkValue("popupPram", objPram);
	
	
	KRI.loadSystemPopup(screen, popupUrl, true);
	
}
/* �Ҵ�����ȸ ��ưŬ�� */
function btnAlcCnqeQry_on_mouseup(objInst)
{
	var popupUrl="/BIZ/YZ/YS/AA/YSAA002_P02";
	var nRow = 0;
	
	if (rdoJOB_DT_SRCH.getcheck()) /* �۾����ں���ȸ�ΰ�� */
	{
		nRow = grdListJobDt.getselectrow();
		var sRunDt     = dsListJobDt.getdatabyname(nRow, "RUN_DT");
		var sTrnNo     = dsListJobDt.getdatabyname(nRow, "TRN_NO");
		var sYmgtJobId = dsListJobDt.getdatabyname(nRow, "YMGT_JOB_ID"); /* ���Ͱ����۾�ID */
	}
	else /* �������ں���ȸ�ΰ�� */
	{
		nRow = grdListRunDt.getselectrow();
		var sRunDt     = dsListRunDt.getdatabyname(nRow, "RUN_DT");
		var sTrnNo     = dsListRunDt.getdatabyname(nRow, "TRN_NO");
		var sYmgtJobId = dsListRunDt.getdatabyname(nRow, "YMGT_JOB_ID"); /* ���Ͱ����۾�ID */
	}
	
	KRLog.trace("RUN_DT:::::::::"+sRunDt);
	KRLog.trace("TRN_NO:::::::::"+sTrnNo);
	KRLog.trace("YMGT_JOB_ID:::::::::"+sYmgtJobId);
	KRI.setLinkValue("RUN_DT", sRunDt);
	KRI.setLinkValue("TRN_NO", sTrnNo);
	KRI.setLinkValue("YMGT_JOB_ID", sYmgtJobId);
	
	
	KRI.loadSystemPopup(screen, popupUrl, true);
}
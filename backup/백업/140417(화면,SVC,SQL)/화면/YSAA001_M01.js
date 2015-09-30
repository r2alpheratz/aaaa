/*
** =================================================================================================
** �� �� �� �� : YZ (���Ͱ���)
** ȭ  ��  ID : YSAA001_M01
** ȭ  ��  �� : ���Ͱ�������� �Ϻ�ó��
** ��      �� : ����ó���� ���Ͱ����۾� ��Ȳ�� �ľ��ϰ� �۾����¿� ���� �¶��� �������۾�ó���� �����Ѵ�.
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
	
		
	/* �۾����� ù��° index�� -��ü- �߰� */
	cboONLN_ARNG_DV_CD.insertstring(0, ":��ü");
	
	/*��� ������Ʈ �ʱ�ȭ ����*/
	fn_init();
	
	/* ���Ͱ��� ����� �޺��ڽ� ���� */
	/* �ֿ��༱/�뼱 �����ͼ� ���� */
	
	/* xDataSet �ʱ�ȭ */	
	dsYmgtCgPsList.init();
	dsMrntList.init();
	dsRoutList.init();
	dsObjCond.insertrow(0);
	dsObjCond.setdatabyname(0, "YMGT_CG_PS", "1");
	dsObjCond.setdatabyname(0, "MRNT", "1");
	dsObjCond.setdatabyname(0, "ROUT", "1");
	
	/* ���Ͱ����������ȸ ȣ�� */
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
		cboYMGT_CG_PS.setselectedindex(0);
		cboYMGT_CG_PS2.setselectedindex(0);
		KRI.setTranMessage(screen, 0, "ȭ���� �ε� �Ǿ����ϴ�.");
	}
	else if (mapid == "/yz/ys/aa/selectListYmgtTgtTrnJobDt.do")
	{
		var nRowCnt = grdListJobDt.getrowcount();
		if(nRowCnt > 0)
		{
			fldQRY_CNT.setvisible(true);
			fldQRY_CNT.settext("�� "+nRowCnt+"��");
			/*���Ͱ����Ҵ�ó������(����) �÷��� "�ݿ�����"�� ��� ������ ǥ��*/
			fn_setGridColor(grdListJobDt, dsListJobDt);
			btnExcel.setenable(true);
			btnDtlPrsRsltSrch.setenable(true);
			/*��ȸ��� �޽���*/
			KRI.setTranMessage(screen, 0, "���������� ��ȸ �Ǿ����ϴ�.");
		}
		else /* ��ȸ����� 0���̸� */
		{
			btnExcel.setenable(false);
			btnDtlPrsRsltSrch.setenable(false);
			fldQRY_CNT.setvisible(false);
			fldQRY_CNT.settext("");
			KRI.setTranMessage(screen, 0, "��ȸ�� �ڷᰡ �����ϴ�.");
			
		}
		fldQRY_CNT2.setvisible(false);
		fldQRY_CNT2.settext("");
				
	}
	else if (mapid == "/yz/ys/aa/selectListYmgtTgtTrnRunDt.do")
	{
		var nRowCnt = grdListRunDt.getrowcount();
		if(nRowCnt > 0)
		{
			fldQRY_CNT2.setvisible(true);
			fldQRY_CNT2.settext("�� "+nRowCnt+"��");
			/*���Ͱ����Ҵ�ó������(����) �÷��� "�ݿ�����"�� ��� ������ ǥ��*/
			fn_setGridColor(grdListRunDt, dsListRunDt);
			btnExcel.setenable(true);
			btnDtlPrsRsltSrch.setenable(true);
			
			/*��ȸ��� �޽���*/
			KRI.setTranMessage(screen, 0, "���������� ��ȸ �Ǿ����ϴ�.");
		}
		else /* ��ȸ����� 0���̸� */
		{
			fldQRY_CNT2.setvisible(false);
			fldQRY_CNT2.settext("");
			btnExcel.setenable(false);
			btnDtlPrsRsltSrch.setenable(false);
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

	cboONLN_ARNG_DV_CD.setselectedindex(0);
	
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
	cboYMGT_CG_PS.setselectedindex(0);
	cboYMGT_CG_PS2.setselectedindex(0);

	/* GRID CLEAR */
	KRI.setGridMode(screen, grdListJobDt, KRConstant.GRID_CLEAR);
	KRI.setGridMode(screen, grdListRunDt, KRConstant.GRID_CLEAR);
    /* xDataSet �ʱ�ȭ */	
	dsListJobDt.init();
	dsListRunDt.init();
	/* �ѰǼ� �ʱ�ȭ */
	fldQRY_CNT.settext("");
	fldQRY_CNT2.settext("");
	
	fldTRN_NO.settext("");
	
	btnExcel.setenable(false);
	btnDtlPrsRsltSrch.setenable(false);
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
	
	KRI.requestSubmit(screen,"/yz/ys/aa/selectListYmgtTgtTrnJobDt.do",true);

	
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
	
	KRI.requestSubmit(screen,"/yz/ys/aa/selectListYmgtTgtTrnRunDt.do",true);

	
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


//�����̾Ƴ��� �˾� ȣ����� �ѹ��� ȣ���ϴ� �Լ�.
//
//
//function trnNoBsPopupCall()
//{
//
//	//1. ������ȣ ��ȸ�� �ѱ� �Ķ���͵� ����
//	//BASE�� ��� �⺻������ȸ
//	//YMS�� ��� YMS�� where���� ����ϴ� ������ ���õ�
//
//	//1. ������ȣ ��ȸ�� �ѱ� �Ķ���͵� ����
//	var callType = "YSAA001"; /*�űԻ���*/
//	var objPram = fn_setCond_search_trnNo(callType);
//
//	//ȭ�� ȣ��
//	var rsltObj = trnNoBsPopupCallWithParam(objPram);
//	fn_auto_setCond(rsltObj);
//	
//}
//
////������ȣ����(�⺻) �˾� ȣ�� �Լ�
//function trnNoBsPopupCallWithParam(pram)
//{
//	KRI.setLinkValue("popupPram", pram);
//	trnNoBsSysPopupCall();
//
//	var objPram = KRI.getLinkValue("setCondPram");
//	KRI.clearLinkValue();  
//
//	return objPram;
//}
//
////������ȣ����(�⺻) �˾� ȣ���Լ�
//function trnNoBsSysPopupCall()
//{
//	var popupUrl="/BIZ/YZ/YB/CO/YBCO002_P01";
//	KRI.loadSystemPopup(screen, popupUrl, true);
//	
//}
//
////������ȣ����(�⺻) ����Ʈ�ڽ����� ENTER�Է½� �۵��Լ�
//
//function fn_setCond_search_trnNo(callType)
//{
//	var objPram = new Object();
//	objPram = {};
//	
//	//ȣ��Ÿ��
//	objPram.callType = callType;
//	//������ȣ
//	objPram.trnNo = fldTRN_NO.gettext();
//	//��������
//	objPram.runDt	 = fldRUN_DT.gettext();
//	//�����౸���ڵ�
//	objPram.upDnDvCd    = cboUP_DN_DV_CD2.getselectedcode();
//	//�������ڵ�
//	objPram.trnClsfCd = cboTRN_CLSF_CD2.getselectedcode();
//	//�ֿ��༱
//	objPram.routCd    = cboROUT2.getselectedcode();
//	/* �����ID */
//	objPram.trvlUsrId = cboYMGT_CG_PS2.getselectedcode();
//	
//
//	return objPram;
//}
////��ȸ���� �г��� ������, YMS����, �ֿ��༱/������ ������Ʈ�� �ִ°��
////��ȸ ����� SETTING���ش�.
//function fn_auto_setCond(obj)
//{							
//	if(obj == null)
//	{
//		fn_trn_no_init();
//		return;
//	}
//	KRLog.trace("������ȣ::"+obj.trnNo);
//	//������ȣ
//	fldTRN_NO.settext(obj.trnNo)
//	//�����౸���ڵ�
//	cboUP_DN_DV_CD2.setselectedcode(obj.upDnDvCd);
//	//�ֿ��༱/�뼱 (TBD)
//	if (obj.routCd != null && obj.routCd != "undefined" && KRUtil.trim(obj.routCd) != "")
//	{
//		cboROUT2.setselectedcode(obj.routCd);
//	}
//	else
//	{
//		//cboROUT2.setselectedindex(0);
//	}
//	if (obj.lnCd != null && obj.lnCd != "undefined" && KRUtil.trim(obj.lnCd) != "")
//	{
//		cboMRNT2.setselectedcode(obj.lnCd);
//	}
//	else
//	{
//		//cboMRNT2.setselectedindex(0);
//	}
//	
//	KRLog.trace("�����౸���ڵ�::"+obj.upDnDvCd);
//	KRLog.trace("�ֿ��༱�ڵ�(mrntCd)::"+obj.mrntCd);
//	KRLog.trace("�ֿ��༱�ڵ�(lnCd)::"+obj.lnCd);
//	KRLog.trace("�뼱�ڵ�::"+obj.routCd);
//	return obj;
//}
//
//function fn_trn_no_init()
//{
//	fldTRN_NO.settext("");
//}
//
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
			fldQRY_CNT.setvisible(true);
			fldQRY_CNT2.setvisible(false);
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
			fldQRY_CNT.setvisible(false);
			fldQRY_CNT2.setvisible(true);
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
/* �۾��Ϻ����Ͱ����������ȸ ��ưŬ�� */
function btnJobDtYmgtTgtTrnSrch_on_mouseup(objInst)
{
	//�˾� ȣ��
	//��ȸ���� popupPram�� ��Ƽ� �˾����� ����
//	var nRow = grdAbvTrnList.getselectrow();
//	
//	KRI.setLinkValue("RUN_DT",grdAbvTrnList.getitemtextbyname(nRow, "RUN_DT"));
//	KRI.setLinkValue("TRN_NO",grdAbvTrnList.getitemtextbyname(nRow, "TRN_NO"));

	var popupUrl="/BIZ/YZ/YS/AA/YSAA001_P01";
	KRI.loadSystemPopup(screen, popupUrl, true);
}

/* ��ó�������ȸ ��ưŬ�� */
function btnDtlPrsRsltSrch_on_mouseup(objInst)
{
	var sJobDt = "";
	var sRunDt = "";
	var sTrnNo = "";
	var nRow   = 0;
	
	if (rdoJOB_DT_SRCH.getcheck()) /* �۾����ں� ��ȸ�ΰ�� */
	{
		nRow = grdListJobDt.getselectrow();
		sJobDt = fldJOB_DT.gettext();
		sRunDt = dsListJobDt.getdatabyname(nRow, "RUN_DT");
		sTrnNo = dsListJobDt.getdatabyname(nRow, "TRN_NO");
	}
	else
	{
		nRow = grdListRunDt.getselectrow();
		sJobDt = dsListRunDt.getdatabyname(nRow, "JOB_DT");
		sRunDt = fldRUN_DT.gettext();
		sTrnNo = dsListRunDt.getdatabyname(nRow, "TRN_NO");
	}
	
	KRI.setLinkValue("JOB_DT", sJobDt);
	KRI.setLinkValue("RUN_DT", sRunDt);
	KRI.setLinkValue("TRN_NO", sTrnNo);

	var popupUrl="/BIZ/YZ/YS/AA/YSAA001_P02";
	KRI.loadSystemPopup(screen, popupUrl, true);
}

/* ���Ͽ�����������ȸ ��ưŬ�� */
function btnDlyTrnDtlInfoSrch_on_mouseup(objInst)
{
	KRI.alert(screen, "���� ���� ������ ȭ���Դϴ�.\n(����Ϸ��� : 2014-05-02(��))");
}

/* �¶��ο������۾���ư */
function btnOnlnTrnReJob_on_mouseup(objInst)
{
	KRI.alert(screen, "�ű��߰��Ǿ� ���߿����� ȭ���Դϴ�.\n(����Ϸ��� : ����)");
}


/* �¶����۾�������ȸ ��ưŬ�� */
function btnOnlnJobSttSrch_on_mouseup(objInst)
{
	KRI.alert(screen, "���� ���� ������ ȭ���Դϴ�.\n(����Ϸ��� : 2014-08-01(��))");
}
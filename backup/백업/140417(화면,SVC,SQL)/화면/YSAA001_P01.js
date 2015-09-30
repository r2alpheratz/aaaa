/*
** =================================================================================================
** �� �� �� �� : YZ (���Ͱ���)
** ȭ  ��  ID : YSAA001_P01
** ȭ  ��  �� : �۾��Ϻ� ���Ͱ���������ȸ
** ��      �� : �۾��Ϻ� ����Ⱓ�� ���Ͱ���������� ��ȸ�Ѵ�.
** ================================================================================================= 
** << ���� ���� >>
** -------------------------------------------------------------------------------------------------
** �� �� �� ��  : ������ : ��	��	��	��
** -------------------------------------------------------------------------------------------------
** 2014-04-07 : ������ : �ű��ۼ�
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
	
//	var sRunDt = KRI.getLinkValue("RUN_DT");
//	var sTrnNo = KRI.getLinkValue("TRN_NO");
//	KRI.clearLinkValue();
	
	/*��� ������Ʈ �ʱ�ȭ ����*/
	fn_init();
	
	/* �ֿ��༱/�뼱 �����ͼ� ���� */
	/* xDataSet �ʱ�ȭ */	
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
		fn_search();
	}
	else if (mapid == "/yz/ys/aa/selectListJobDdprYmgtTgtTrn.do")
	{
		var nRowCnt = grdList.getrowcount(); //��ü�������
		var nYmgtTgtTrnCnt = 0; //���Ͱ����������
		var nExcsRsvTgtTrnCnt = 0; //�ʰ�����������
		var bYmsAplFlg = ""; //YMS���뿩��
		var bShtmExcsRsvAllwFlg = "" //�ܱ��ʰ�������뿩��
		if (nRowCnt > 0)
		{
			fldQRY_CNT.setvisible(true);
			fldQRY_CNT.settext("�� "+nRowCnt+"��");
			/*���Ͱ����Ҵ�ó������(����) �÷��� "�ݿ�����"�� ��� ������ ǥ��*/
			fn_setGridColor(grdList, dsList);
			btnExcel.setenable(true);
			for (var i = 0; i < nRowCnt; i++)
			{
				bYmsAplFlg          = dsList.getdatabyname(i, "YMS_APL_FLG");
				bShtmExcsRsvAllwFlg = dsList.getdatabyname(i, "SHTM_EXCS_RSV_ALLW_FLG");
				if(bYmsAplFlg == "Y")
				{
					nYmgtTgtTrnCnt++;
				}
				if(bShtmExcsRsvAllwFlg == "Y")
				{
					nExcsRsvTgtTrnCnt++;
				}
			}
			var sRunTrmStDt = dsList.getdatabyname(0, "RUN_DT");
			var sRunTrmClsDt = m_yzmod.fn_yz_comm_DS_get_col_max_val(dsList, "RUN_DT");
			
			fldJOB_RUN_TRM_ST_DT.settext(sRunTrmStDt);
			fldJOB_RUN_TRM_CLS_DT.settext(sRunTrmClsDt);
			fldWHL_TGT_TRN_NUM.settext(nRowCnt+" ��");
			fldYMGT_TGT_TRN_NUM.settext(nYmgtTgtTrnCnt+" ��");
			fldEXCS_RSV_TGT_TRN_NUM.settext(nExcsRsvTgtTrnCnt+ " ��");
			
			/*��ȸ��� �޽���*/
			KRI.setTranMessage(screen, 0, "���������� ��ȸ �Ǿ����ϴ�.");
		}
		else /* ��ȸ����� 0���̸� */
		{
			KRI.setTranMessage(screen, 0, "��ȸ�� �ڷᰡ �����ϴ�.");		
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
	/*�۾�����, ���� �������ڷ� ����*/
	fldJOB_DT.settext(m_today);
	m_yzmod.fn_setDayField(fldJOB_DT, txtJobDay);
	/* ����Ⱓ���� (����~��)*/ 
	fldRUN_TRM_ST_DT.settext(m_runTrmStDt);
	fldRUN_TRM_CLS_DT.settext(m_runTrmClsDt);
	m_yzmod.fn_setDayField(fldRUN_TRM_ST_DT, txtFromDay);
	m_yzmod.fn_setDayField(fldRUN_TRM_CLS_DT, txtToDay);
	
	/* �����౸���ڵ� -������- �⺻���� */
	cboUP_DN_DV_CD.setselectedindex(0);
	
	cboMRNT.setselectedindex(0);
	cboROUT.setselectedindex(0);
	
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
	KRI.requestSubmit(screen,"/yz/ys/aa/selectListJobDdprYmgtTgtTrn.do",true);

	
    /* ��ȸ �� �ߴ� �����ϵ��� ȭ�鿡 ��Ŀ���� ���� */
	screen.setfocus();
}
/*�۾����ں� ��ȸ validation Check*/
function validCheck()
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

//����Ⱓ �޷��˾� ��ưŬ�� �̺�Ʈ
function btnPeriodCalendar_on_mouseup(objInst)
{
	KRI.showPeriodCalendar(screen, btnPeriodCalendar, fldRUN_TRM_ST_DT, fldRUN_TRM_CLS_DT);
	m_yzmod.fn_setDayField(fldRUN_TRM_ST_DT, txtFromDay);
	m_yzmod.fn_setDayField(fldRUN_TRM_CLS_DT, txtToDay);
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
	if (sMrntCd == null || sMrntCd == "")
	{
		cboMRNT.setselectedindex(0);
	}
	else
	{
		cboMRNT.setselectedcode(sMrntCd);
	}
	if (sRoutCd == null || sRoutCd == "")
	{
		cboROUT.setselectedindex(0);
	}
	else
	{
		cboROUT.setselectedcode(sRoutCd);
	}

}

/* �۾��Ϻ� ���Ͱ�������� ��ȸ ��ưŬ�� */
function btnSearch_on_mouseup(objInst)
{
	//validation üũ
	if(validCheck())
	{
		fn_search();
	}else 
		return false;
}

/* ���� ��ưŬ�� */
function btnExcel_on_mouseup(objInst)
{
	grdList.saveexcel();
}

/* �ݱ� ��ư Ŭ�� */
function btnClose_on_mouseup(objInst)
{
	KRI.unloadPopup(screen);
}
/*
** =================================================================================================
** �� �� �� �� : YZ (���Ͱ���)
** ȭ  ��  ID : YFAA003_P01
** ȭ  ��  �� : �̻������� ��Ʈ ��ȸ
** ��      �� : �̻����� �񱳴������ �����ο����� ��Ʈ�� �����ش�.
** ================================================================================================= 
** << ���� ���� >>
** -------------------------------------------------------------------------------------------------
** �� �� �� ��  : ������ : ��	��	��	��
** -------------------------------------------------------------------------------------------------
** 2014-03-17 : ������ : �ű��ۼ�
** YYYY-MM-DD :       
** =================================================================================================
*/

/* 
** ========================================================================
** 1. ���� ���� ����
** ======================================================================== 
*/
var m_today = KRUtil.TodayDate(screen);

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

	var sRunDt = KRI.getLinkValue("RUN_DT");
	var sTrnNo = KRI.getLinkValue("TRN_NO");
	KRI.clearLinkValue();
	
	fldRUN_DT.settext(sRunDt);
	fldTRN_NO.settext(sTrnNo);
	//�׽�Ʈ�� ���� ���� �� ����
	//TO-DO  ��¥ ���� �����Ұ�
	fldRUN_TRM_ST_DT.settext("20131201");
	fldRUN_TRM_CLS_DT.settext("20131212");
	fldCOMP_TGT_TRN_NO.settext("101");
	cboDAY_DV_CD.setselectedindex(0);
	
	fn_setDayField(fldRUN_DT, txtDay);//���� ����
	fn_setDayField(fldRUN_TRM_ST_DT, txtFromDay);//���� ����
	fn_setDayField(fldRUN_TRM_CLS_DT, txtToDay);//���� ����
	
	KRI.sortComboboxData(cboDAY_DV_CD, 0, 1);
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
	if(KRI.submitComplete(screen, mapid, result, recv_userheader, recv_code, recv_msg) == false) return;
	if(mapid == "/yz/yf/aa/selectAbvTrnCompQry.do")
	{
		if(grdAbvTrnAbrdPrnb.getrowcount < 1)
		{
			grdAbvTrnAbrdPrnb.additem();  // �׸��� row �߰�
		}
		grdAbvTrnAbrdPrnb.setitemtext(0,1,"1.�̻� ����");
		grdAbvTrnAbrdPrnb.additem();  // �׸��� row �߰�
		grdAbvTrnAbrdPrnb.setitemtext(1,1,"2.���ġ"); 
		grdAbvTrnAbrdPrnb.setitemtext(1,2, grdCompTrnAbrdPrnb.getitemtext(0,1)); //�񱳴���� �����ο��� ����
		
		//�̻�������Ʈ
		var sReportId = "/YZ/YF/AA/YFAA003_P01_CHT01.reb"; //����ID
		var aFields = null;  //�Ű����� �ʵ�(���⼭�� ������� ����)
		var sCSV = KRI.makeCSV(screen, "grdAbvTrnAbrdPrnb");   //�׸��嵥���͸� CSV���·� ��ȯ
		var sOOF = KRI.makeOOF(screen, sReportId, aFields, sCSV); //OOF Xml ����
		oReport.innerctrl.CloseAll();
		oReport.innerctrl.SetCSS("appearance.toolbar.visible=0"); 
		oReport.innerctrl.SetCSS("appearance.statusbar.visible=0");   
		oReport.innerctrl.SetCSS("appearance.pagemargin.visible=0");   
		oReport.innerctrl.SetCSS("appearance.tabheader.visible=0");   
		oReport.innerctrl.SetCSS("appearance.canvas.offsetx=0");   
		oReport.innerctrl.SetCSS("appearance.canvas.offsety=0");   
		oReport.innerctrl.SetCSS("appearance.paper.backgroundtransparent=1");   
		oReport.innerctrl.UpdateCSS();   
		
		oReport.innerctrl.OpenOOF(sOOF);
		oReport.setvisible(true);
		
		//�񱳴����������Ʈ
		for(var i = 0; i < grdCompTrnAbrdPrnbPrDt.getrowcount(); i++)
		{
			grdCompTrnAbrdPrnbPrDt.setitemtext(i, grdCompTrnAbrdPrnbPrDt.getcolumn("DV"), "1");
		}
		grdCompTrnAbrdPrnbPrDt.insertitemtext(0,0,"1.�̻���");
		grdCompTrnAbrdPrnbPrDt.setitemtext(0, 2, grdAbvTrnAbrdPrnb.getitemtext(0,2));
		grdCompTrnAbrdPrnbPrDt.setitemtext(0, grdCompTrnAbrdPrnbPrDt.getcolumn("DV"), "0");		
		grdCompTrnAbrdPrnbPrDt.sort(0,1);
		
		
		sReportId = "/YZ/YF/AA/YFAA003_P01_CHT02.reb"; //����ID
		aFields = null;  //�Ű����� �ʵ�(���⼭�� ������� ����)
		sCSV = KRI.makeCSV(screen, "grdCompTrnAbrdPrnbPrDt");   //�׸��嵥���͸� CSV���·� ��ȯ
		sOOF = KRI.makeOOF(screen, sReportId, aFields, sCSV); //OOF Xml ����
		oReport2.innerctrl.CloseAll();
		oReport2.innerctrl.SetCSS("appearance.toolbar.visible=0"); 
		oReport2.innerctrl.SetCSS("appearance.statusbar.visible=0");   
		oReport2.innerctrl.SetCSS("appearance.pagemargin.visible=0");   
		oReport2.innerctrl.SetCSS("appearance.tabheader.visible=0");   
		oReport2.innerctrl.SetCSS("appearance.canvas.offsetx=0");   
		oReport2.innerctrl.SetCSS("appearance.canvas.offsety=0");   
		oReport2.innerctrl.SetCSS("appearance.paper.backgroundtransparent=1");   
		oReport2.innerctrl.UpdateCSS();   
		
		oReport2.innerctrl.OpenOOF(sOOF);
		oReport2.setvisible(true);		
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
    /* GRID CLEAR */
	KRI.setGridMode(screen, grdAbvTrnAbrdPrnb, KRConstant.GRID_CLEAR);
	KRI.setGridMode(screen, grdCompTrnAbrdPrnb, KRConstant.GRID_CLEAR);
	KRI.setGridMode(screen, grdCompTrnAbrdPrnbPrDt, KRConstant.GRID_CLEAR);		
    /* xDataSet �ʱ�ȭ */	
	dsAbvTrnAbrdPrnb.init();
	dsCompTrnAbrdPrnb.init();
	dsCompTrnAbrdPrnbPrDt.init();
		
	/* �˻�����(dsCond) �� */
	dsCond.setdatabyname(0, "RUN_DT", fldRUN_DT.gettext());
	dsCond.setdatabyname(0, "TRN_NO", KRUtil.trim(fldTRN_NO.gettext()));
	dsCond.setdatabyname(0, "RUN_TRM_ST_DT", fldRUN_TRM_ST_DT.gettext());
	dsCond.setdatabyname(0, "RUN_TRM_CLS_DT", fldRUN_TRM_CLS_DT.gettext());
	dsCond.setdatabyname(0, "COMP_TGT_TRN_NO", fldCOMP_TGT_TRN_NO.gettext());	
	dsCond.setdatabyname(0, "DAY_DV_CD", cboDAY_DV_CD.getselectedcode());
	
	KRI.requestSubmit(screen,"/yz/yf/aa/selectAbvTrnCompQry.do",true);

	
    /* ��ȸ �� �ߴ� �����ϵ��� ȭ�鿡 ��Ŀ���� ���� */
	screen.setfocus();
}

function validCheck()
{
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
//��¥(����, �Ⱓ) ������Ʈ�� ���ϰ� ���Ͽ� �ش��ϴ� ������ �����ϴ� �Լ�
function fn_setDayField(objDate, objDay)
{
	var bValidDate = KRUtil.checkDate(objDate.gettext(), "YYYYMMDD", false);
	if(bValidDate)
	{
		var day = KRUtil.SearchforDay(objDate.gettext(), false).substr(0,1);
		objDay.settext(day);
		if(day == "��")
		{
			objDate.setforecolor(255,0,0);//����
			objDay.setforecolor(255,0,0);//����
			
		}
		else if(day == "��")
		{
			objDate.setforecolor(0,0,255);//�Ķ�
			objDay.setforecolor(0,0,255);//�Ķ�
		}
		else
		{
			objDate.setforecolor(0,0,0); //����
			objDay.setforecolor(0,0,0); //����
		}
	}
	else
	{
		objDay.settext("");
	} 
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
	fn_setDayField(RUN_DT, txtDay);
}


//����Ⱓ �޷��˾� ��ưŬ�� �̺�Ʈ
function btnPeriodCalendar_on_mouseup(objInst)
{
	KRI.showPeriodCalendar(screen, btnPeriodCalendar, fldRUN_TRM_ST_DT, fldRUN_TRM_CLS_DT);
	fn_setDayField(fldRUN_TRM_ST_DT, txtFromDay);
	fn_setDayField(fldRUN_TRM_CLS_DT, txtToDay);
}
//��Ʈ��ȸ ��ưŬ�� �̺�Ʈ
function btnSearch_on_mouseup(objInst)
{
	//validation üũ
	if(validCheck())
	{
		fn_search();
	}else 
		return false;
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
** ex)---------------------------------------------------------------------

function btnSearch_on_mouseup(objInst)
{
	if(validCheck()) fn_search();
}
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
		return false;
	}
	else
	{
		if(sDate == "")
		{
			if(sObjNm == "fldRUN_DT") txtDay.settext("");
			else if(sObjNm == "fldRUN_TRM_ST_DT") txtFromDay.settext("");
			else if(sObjNm == "fldRUN_TRM_CLS_DT") txtToDay.settext("");
		}
		else
		{
			if(sObjNm == "fldRUN_DT") fn_setDayField(objInst, txtDay);
			else if(sObjNm == "fldRUN_TRM_ST_DT") fn_setDayField(objInst, txtFromDay);
			else if(sObjNm == "fldRUN_TRM_CLS_DT") fn_setDayField(objInst, txtToDay);
		}
	}
}

//�ݱ� ��ư Ŭ����
function btnClose_on_mouseup(objInst)
{
	KRI.unloadPopup(screen);
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

//�����̾Ƴ��� �˾� ȣ����� �ѹ��� ȣ���ϴ� �Լ�.
//
// delimiter - ���� ���� �Ķ���� (���񽺿��� �޾Ƽ� �б�)
//
function trnNoBs_on_mousedown(objInst)
{	
	trnNoBsPopupCall();
}

//�����̾Ƴ��� �˾� ȣ����� �ѹ��� ȣ���ϴ� �Լ�.
//
//
function trnNoBsPopupCall()
{

	//1. ������ȣ ��ȸ�� �ѱ� �Ķ���͵� ����
	var callType = "BASE";
	//var callType = "YMS";
	//var callType = "BASE";

	//BASE�� ��� �⺻������ȸ
	//YMS�� ��� YMS�� where���� ����ϴ� ������ ���õ�

	//1. ������ȣ ��ȸ�� �ѱ� �Ķ���͵� ����
	var callType = "BASE";
	var objPram = fn_setCond_search_trnNo(callType);

	//ȭ�� ȣ��
	var rsltObj = trnNoBsPopupCallWithParam(objPram);
	fn_auto_setCond(rsltObj);
	
}

//������ȣ����(�⺻) �˾� ȣ�� �Լ�
function trnNoBsPopupCallWithParam(pram)
{
	KRI.setLinkValue("popupPram", pram);
	trnNoBsSysPopupCall();

	var objPram = KRI.getLinkValue("setCondPram");
	KRI.clearLinkValue();  

	return objPram;
}

//������ȣ����(�⺻) �˾� ȣ���Լ�
function trnNoBsSysPopupCall()
{
	var popupUrl="/BIZ/YZ/YB/CO/YBCO002_P01";
	KRI.loadSystemPopup(screen, popupUrl, true);
	
}

//������ȣ����(�⺻) ����Ʈ�ڽ����� ENTER�Է½� �۵��Լ�
function fldCOMP_TGT_TRN_NO_on_keydown(objInst, keycode, bctrldown, bshiftdown, baltdown, bnumpadkey)
{
	var nTrnNoLen = fldCOMP_TGT_TRN_NO.gettext().length;
	//��ȸ����
	if(keycode == 13)
	{
		if(nTrnNoLen == 0 || nTrnNoLen == 5)
		{
			fn_search();
		}
		else
		{
			trnNoBsPopupCall();
		}
	}
}

function fn_setCond_search_trnNo(callType)
{
	var objPram = new Object();
	objPram = {};
	
	//ȣ��Ÿ��
	objPram.callType = callType;
	//������ȣ
	objPram.trnNo = fldCOMP_TGT_TRN_NO.gettext();
	//��������
//	if(screen.getinstancebyname("fldRUN_DT") != undefined)
//		objPram.runDt	 = fldRUN_DT.gettext();
	//�����౸���ڵ�
//	if(screen.getinstancebyname("cboUP_DN_DV_CD") != undefined)
//		objPram.dnDvCd    = cboUP_DN_DV_CD.getselectedcode();
//	//YMS���뿩��
//	if(screen.getinstancebyname("cboYMS_APL_FLG") != undefined)
//		objPram.ymsAplFlg = cboYMS_APL_FLG.getselectedcode();
//	//�������ڵ�
//	if(screen.getinstancebyname("cboTRN_CLSF_CD") != undefined)
//		objPram.trnClsfCd = cboTRN_CLSF_CD.getselectedcode();
//	//�ֿ��༱/�뼱 (TBD)
//	if(screen.getinstancebyname("ROUT_CD") != undefined)
//		objPram.routCd    = ROUT_CD.gettext();

	return objPram;
}
//��ȸ���� �г��� ������, YMS����, �ֿ��༱/������ ������Ʈ�� �ִ°��
//��ȸ ����� SETTING���ش�.
function fn_auto_setCond(obj)
{							
	if(obj == null)
	{
		fn_trn_no_init();
		return;
	}

	//������ȣ
	fldCOMP_TGT_TRN_NO.settext(obj.trnNo)
	//�����౸���ڵ�
//	if(screen.getinstancebyname("cboUP_DN_DV_CD") != undefined)
//		cboUP_DN_DV_CD.setselectedcode(obj.upDnDvCd);
	//YMS���뿩��
//	if(screen.getinstancebyname("cboYMS_APL_FLG") != undefined)
//		cboYMS_APL_FLG.setselectedcode(obj.ymsAplFlg);
	//�ֿ��༱/�뼱 (TBD)
//	if(screen.getinstancebyname("ROUT_CD") != undefined)
	//objPram.routCd    = ROUT_CD.gettext();

	return obj;
}

function fn_trn_no_init()
{
	fldCOMP_TGT_TRN_NO.settext("");
}

/*
** ========================================================================
** ������ȣ����(�⺻) �˾� ���� ��ũ��Ʈ ��
** ========================================================================
*/
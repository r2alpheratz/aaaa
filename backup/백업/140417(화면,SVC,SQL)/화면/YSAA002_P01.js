/*
** =================================================================================================
** �� �� �� �� : YZ (���Ͱ���)
** ȭ  ��  ID : YSAA002_P01
** ȭ  ��  �� : ������ ����-���� �����ο� ��ȸ
** ��      �� : ������ ����-���� �����ο� ��ȸ ������ ��Ʈ�� �����ش�.
** ================================================================================================= 
** << ���� ���� >>
** -------------------------------------------------------------------------------------------------
** �� �� �� ��  : ������ : ��	��	��	��
** -------------------------------------------------------------------------------------------------
** 2014-04-11 : ������ : �ű��ۼ�
** YYYY-MM-DD :       
** =================================================================================================
*/

/* 
** ========================================================================
** 1. ���� ���� ����
** ======================================================================== 
*/
var objPram;

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
	
	
	if (mapid == "/yz/yb/co/selectListObject.do") /* ���-������ ��ȸ */
	{
		cboDPT_ARV_STGP_CD.setselectedindex(0);
		
//		var nRowCnt = grdList.getrowcount();
//		if (nRowCnt > 0)
//		{
//			
//			KRI.setTranMessage(screen, 0, "���������� ��ȸ �Ǿ����ϴ�.");
//		}
//		else /* ��ȸ����� 0���̸� */
//		{
//			KRI.setTranMessage(screen, 0, "��ȸ�� �ڷᰡ �����ϴ�.");
//		}

	}
	else if (mapid == "/yz/ys/aa/selectListTrnPrFcstAcvmAbrdPrnb.do")
	{
		
		
		//������ ����-���� �����ο���ȸ ��Ʈ
		var sReportId = "/YZ/YS/AA/YSAA002_P01_CHT01.reb"; //����ID
		var aFields = null;  //�Ű����� �ʵ�(���⼭�� ������� ����)
		var sCSV = KRI.makeCSV(screen, "grdList");   //�׸��嵥���͸� CSV���·� ��ȯ
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

//	var sRunDt = KRI.getLinkValue("RUN_DT");
//	var sTrnNo = KRI.getLinkValue("TRN_NO");
//	KRI.clearLinkValue();
//	
//	
//	/* ��������, ���� ���� */
//	fldRUN_DT.settext(sRunDt);
//	m_yzmod.fn_setDayField(fldRUN_DT, txtDay);
//	/* ������ȣ ���� */
//	fldTRN_NO.settext(sTrnNo);
//	/*��� ������Ʈ �ʱ�ȭ ����*/
	objPram = KRI.getLinkValue("popupPram");
	
	dsCond.insertrow(0);
	dsCond.setdatabyname(0, "RUN_DT", objPram.runDt);
	dsCond.setdatabyname(0, "TRN_NO", objPram.trnNo);

	fldORG_RS_STN_CD_NM.settext(objPram.orgRsStnCdNm);
	fldTMN_RS_STN_CD_NM.settext(objPram.tmnRsStnCdNm);
	fldDPT_TM.settext(objPram.dptTmPram);
	fldARV_TM.settext(objPram.arvTmPram);
	m_yzmod.fn_setDayField(fldRUN_DT, txtDay);
	/* ���-�������׷� �����ͼ� ���� */
	/* xDataSet �ʱ�ȭ */	
	dsDptArvStgpList.init();
	dsObjCond.insertrow(0);
	
	dsObjCond.setdatabyname(0, "DPT_ARV_STGP", "1");
	dsObjCond.setdatabyname(0, "NON_NML_TRN_FLG", "1");
	KRI.requestSubmit(screen,"/yz/yb/co/selectListObject.do",true);

}
/* �۾��Ϻ� ���Ͱ�������� ��ȸ */
function fn_search()
{
	var sDptArvStgpCd = cboDPT_ARV_STGP_CD.getselectedcode();
	var sDptStgpCd = sDptArvStgpCd.substring(0,5);
	var sArvStgpCd = sDptArvStgpCd.substring(5,10);
	
	dsCond.setdatabyname(0, "DPT_STGP_CD", sDptStgpCd);
	dsCond.setdatabyname(0, "ARV_STGP_CD", sArvStgpCd);
	
    /* GRID CLEAR */
	KRI.setGridMode(screen, grdList, KRConstant.GRID_CLEAR);
    /* xDataSet �ʱ�ȭ */	
	dsList.init();
	KRI.requestSubmit(screen,"/yz/ys/aa/selectListTrnPrFcstAcvmAbrdPrnb.do",true);

	
    /* ��ȸ �� �ߴ� �����ϵ��� ȭ�鿡 ��Ŀ���� ���� */
	screen.setfocus();
}
/*
** ========================================================================
** 5. ��Ʈ�� �̺�Ʈ ����
** ========================================================================
*/
/* ��ȸ ��ư Ŭ��*/
function btnSearch_on_mouseup(objInst)
{
	fn_search();
}

/* �ݱ� ��ư Ŭ�� */
function btnClose_on_mouseup(objInst)
{
	KRI.unloadPopup(screen);
}
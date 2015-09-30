/*
** =================================================================================================
** �� �� �� �� : RZ (����߸�)
** ȭ  ��  ID : YFAA002_P01
** ȭ  ��  �� : DSP�� �������Ǵܺ��� ��Ʈ��ȸ
** ��      �� : DSP�� �������Ǵ� ������ YFAA002_M01 ȭ�����κ��� �޾ƿ� ��Ʈ�� ��ȸ�Ѵ�.
** ================================================================================================= 
** << ���� ���� >>
** -------------------------------------------------------------------------------------------------
** �� �� �� ��  : ������ : ��	��	��	��
** -------------------------------------------------------------------------------------------------
** 0000-00-00 : ����ä : �ű��ۼ�
** YYYY-MM-DD : 2014-04-08
** =================================================================================================
*/

/* 
** ========================================================================
** 1. ���� ���� ����
** ======================================================================== 
*/


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

		cboSRCH_DV.setselectedindex(0);

	//To do
	KRDataset.copy(KRI.getLinkValue("dsList"),dsTransList,false);
	KRI.clearLinkValue();
	//��Ʈ
	
	fn_chart("grdList");	
	fn_SFMsg();
	
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

function fn_chart(grdData){
	var sReportId = "/YZ/YF/AA/YFAA002_P01_CHT01.reb"; //����ID
	var aFields = null;  //�Ű����� �ʵ�(���⼭�� ������� ����)
	var sCSV = KRI.makeCSV(screen, grdData);   //�׸��嵥���͸� CSV���·� ��ȯ
	KRLog.trace(sCSV);
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

function fn_SFMsg(){
	var nRowCnt = grdList.getrowcount();
	
	if (nRowCnt > 0)
	{	
		/*��ȸ��� �޽���*/
		KRI.setTranMessage("/BIZ/YZ/YF/AA/YFAA002_P01", 0, "���������� ��ȸ �Ǿ����ϴ�.");
	}
	else 
	{
		/* ��ȸ����� 0�� */
		KRI.setTranMessage("/BIZ/YZ/YF/AA/YFAA002_P01", 0, "��ȸ�� �ڷᰡ �����ϴ�.");		
	};
}

/*
** ========================================================================
** 5. ��Ʈ�� �̺�Ʈ ����
** ========================================================================
*/



function btnClose_on_mouseup(objInst)
{
	KRI.unloadPopup(screen);
}


function btnSearch_on_mouseup(objInst)
{
	var SrchCd = cboSRCH_DV.getselectedcode();
	KRDataset.copy(dsTransList, dsSrchDvList, false);

	for (var i =0; i< dsSrchDvList.getcolumncount(); i++)
	{
		var colId = dsSrchDvList.getcolumnid(i) // dsSrchDvList ��ü Į����
		
		if(colId.indexOf(SrchCd)== -1 && colId.indexOf("DASP") && SrchCd.indexOf("ALL")) 
		{
			for (var j=0; j<dsSrchDvList.getrowcount(); j++)
			{
			dsSrchDvList.setdata(j,i,"");
			}
		}				
	}
	fn_chart("grdSrchList");	
}
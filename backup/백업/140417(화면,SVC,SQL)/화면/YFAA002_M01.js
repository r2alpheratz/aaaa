/*
** =================================================================================================
** �� �� �� �� : RZ (����߸�)
** ȭ  ��  ID : YFAA002_M01			
** ȭ  ��  �� : DSP�� �������Ǵܺ��� ��ȸ
** ��      �� : DSP���� ���ذ��� ���, ����, ���뺰 ������ ���� �Ǵ� ������ �����ش�.(���Ѻ���, ���Ѻ���)
** ================================================================================================= 
** << ���� ���� >>
** -------------------------------------------------------------------------------------------------
** �� �� �� ��  : ������ : ��	��	��	��
** -------------------------------------------------------------------------------------------------
** 0000-00-00 : ����ä : �ű��ۼ�
** YYYY-MM-DD : 2014-03-25      
** =================================================================================================
*/

/* 
** ========================================================================
** 1. ���� ���� ����
** ======================================================================== 
*/

var m_UpdateFlg = false;	

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
	cboLUMP_APL_TGT.setselectedindex(0);
	cboLUMP_APL_TGT_DV.setselectedindex(0);
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

	if (mapid == "/yz/yf/aa/updateNonNmlPct.do")
	{
		m_UpdateFlg = true;
		fn_search();	
	}
	
	if (mapid == "/yz/yf/aa/selectListNonNmlPct.do" )
	{
		var nRowCnt = grdList.getrowcount();
			
		if (m_UpdateFlg)
		{	
			/*������� �޽���*/
			KRI.setTranMessage(screen, 0, "���������� ���� �Ǿ����ϴ�.");	
		}
		else 
		{
			if (nRowCnt > 0)
			{	
				/*��ȸ��� �޽���*/
				KRI.setTranMessage(screen, 0, "���������� ��ȸ �Ǿ����ϴ�.");
			}
			else 
			{
				/* ��ȸ����� 0�� */
				KRI.setTranMessage(screen, 0, "��ȸ����� �����ϴ�.");		
			}
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

/*	ȭ�� �ʱ�ȭ	*/
function fn_search()
{
	/* GRID CLEAR */
	KRI.setGridMode(screen, grdList, KRConstant.GRID_CLEAR);
    /* xDataSet �ʱ�ȭ */	
	dsList.init();
	/* GRID ����Ʈ ���*/
	KRI.requestSubmit(screen,"/yz/yf/aa/selectListNonNmlPct.do",true);
}

/*	��ư �ʱ�ȭ	*/
function fn_buttonReset()
{
	btnCancel.setenable(false);
	btnSave.setenable(false);
	btnUpdate.setenable(true);
}

/*	����,���� ����� ��ġ�� ��� ���� ǥ��	*/
function fn_gridFlag(i)
{
	grdList.setitemtext(i, grdList.getcolumn("DMN_PRS_DV_CD"), "U");
	grdList.setitemimage(i, 0, "/IMG/BTN/Grid_write.png");
}

/*
** ========================================================================
** 5. ��Ʈ�� �̺�Ʈ ����
** ========================================================================
*/

/*	�����Ѻ��� ���� ��ư Ŭ��	*/
function btnLUMP_APL_on_mouseup(objInst)
{
	/*	���� �Է°��ɹ��� üũ	*/
	if (fldLUMP_APL_VAL_INP.gettext() > 1 || fldLUMP_APL_VAL_INP.gettext() < 0)
	{
		KRI.alert(screen, "�Է� ������ ������ 0~1 �Դϴ�");
		fldLUMP_APL_VAL_INP.setfocus();
		return false;
	}	

	var sLumpAplTgt = cboLUMP_APL_TGT.getselectedcode();
	var sLumpAplTgtDv = cboLUMP_APL_TGT_DV.getselectedcode();

	sVals = Number (fldLUMP_APL_VAL_INP.gettext());
	/*	�Ҽ��� ��°�ڸ� ���� ������� ��� 0���� ä��	*/
	sVal = sVals.toFixed(2);
	sMVal = (1-sVal).toFixed(2);
	
	/*	grdList �׸��忡 �ϰ����� ���� ��/���� ������ ����	*/
	for( var i =0; i < grdList.getrowcount(); i+=1)
	{
		if(sLumpAplTgt=="URG")
		{
			if(sLumpAplTgtDv=="EXCS")
			{
				dsList.setdatabyname(i,"URG_ULMT_EXCS_PCT",sVal);
				dsList.setdatabyname(i,"URG_LLMT_UNDR_PCT",sMVal);
				fn_gridFlag(i);
			}
			else
			{
				dsList.setdatabyname(i,"URG_LLMT_UNDR_PCT",sVal);
				dsList.setdatabyname(i,"URG_ULMT_EXCS_PCT",sMVal);
				fn_gridFlag(i);
			}
		}
		else if(sLumpAplTgt=="CARE")
		{
			if(sLumpAplTgtDv=="EXCS")
			{
				dsList.setdatabyname(i,"CARE_ULMT_EXCS_PCT",sVal);
				dsList.setdatabyname(i,"CARE_LLMT_UNDR_PCT",sMVal);
				fn_gridFlag(i);
			}
			else
			{
				dsList.setdatabyname(i,"CARE_LLMT_UNDR_PCT",sVal);
				dsList.setdatabyname(i,"CARE_ULMT_EXCS_PCT",sMVal);
				fn_gridFlag(i);
			}
		}
		else if(sLumpAplTgt=="CMNS")
		{
			if(sLumpAplTgtDv=="EXCS")
			{
				dsList.setdatabyname(i,"CMNS_ULMT_EXCS_PCT",sVal);
				dsList.setdatabyname(i,"CMNS_LLMT_UNDR_PCT",sMVal);
				fn_gridFlag(i);
			}
			else
			{
				dsList.setdatabyname(i,"CMNS_LLMT_UNDR_PCT",sVal);
				dsList.setdatabyname(i,"CMNS_ULMT_EXCS_PCT",sMVal);
				fn_gridFlag(i);
			}
		}
	}//end for
	
	btnSave.setenable(true);
	btnCancel.setenable(true);
	btnUpdate.setenable(true);
}

/*	��� ��ư Ŭ�� �̺�Ʈ	*/
function btnCancel_on_mouseup(objInst)
{
	var nRtn = KRI.messagebox(screen, "����Ͻðڽ��ϱ�?", XFD_MB_OKCANCEL);	
	
	if(nRtn == XFD_MB_RESCANCEL || nRtn == "")
	{
		return(false);	
	}
	
	m_UpdateFlg = false;
	fn_search();		
	fn_buttonReset();
}

/*	���� ��ư Ŭ�� �̺�Ʈ	*/
function btnSave_on_mouseup(objInst)
{

	var nRtn = KRI.messagebox(screen, "�����Ͻðڽ��ϱ�?", XFD_MB_OKCANCEL); //�����Ͻðڽ��ϱ�?		
	
	if(nRtn == XFD_MB_RESCANCEL || nRtn == "")
	{
		return(false);
	}
	
	/*	ó������ �޼��� ����	*/
	KRI.setTranMessage(screen, 0, "ó�����Դϴ�..."); //ó�����Դϴ�.
	KRI.requestSubmit(screen, "/yz/yf/aa/updateNonNmlPct.do", true);
	fn_buttonReset();
}

/*	���� ��ư Ŭ�� �̺�Ʈ	*/
function btnUpdate_on_mouseup(objInst)
{
	var nFstRow = 0;
	for(var j=0 ; j < grdList.getrowcount() ; j++)
	{	
		if(grdList.getitemtext(j, grdList.getcolumn("DMD_PRS_DV_CD")) == "")
		{
			if(nFstRow == 0) nFstRow = j;
		
			for(var i=0 ; i < grdList.getcolumncount() ; i++)
			{
				/*	DSP����, ���� ���� ���� �Ұ�	*/
				if(i != grdList.getcolumn("DASP_DV_NO") && i != grdList.getcolumn("DASP_DV_STDR_PCT"))
				{
					KRI.setGridItemEditable(grdList, j, grdList.getcolumnname(i), true);
				}
			}//
		}
	}
	
	if(grdList.getitemtext(grdList.getselectrow(), grdList.getcolumn("DMN_PRS_DV_CD")) != "")
	{
		grdList.setselectitem(nFstRow, 0);
	}
	
	/*	ù���� Ŀ�� �̵�	*/
	grdList.setselectitem(grdList.getselectrow(), 0);
	grdList.setitemeditstart(grdList.getselectrow(), 0, true);
	
	btnCancel.setenable(true);
	btnSave.setenable(true);
	btnUpdate.setenable(false);
	

}

function grdList_on_itemeditcomplete(objInst, nRow, nColumn, strPrevItemText)
{
	/*���� ��� row üũ*/
	if(grdList.getitemtext(nRow, nColumn) != strPrevItemText)
	{
		grdList.setitemtext(nRow, grdList.getcolumn("DMN_PRS_DV_CD"), "U");
		grdList.setitemimage(nRow, 0, "/IMG/BTN/Grid_write.png");
	}
	
	/*	���� �Է°��ɹ��� üũ	*/
	if (grdList.getitemtext(nRow,nColumn) > 1 || grdList.getitemtext(nRow,nColumn) < 0)
	{
		KRI.alert(screen, "�Է� ������ ������ 0~1 �Դϴ�");
		grdList.setitemtext(nRow,nColumn,strPrevItemText);
		return false;
	}	
	
	/* ���� ������ ��/���� ���� 1�� �ǵ��� ���� */
	grdList.setitemtext(nRow,nColumn, Number(grdList.getitemtext( nRow, nColumn )).toFixed(2));
	
	if (grdList.getcolumnname(nColumn) == "URG_ULMT_EXCS_PCT" )
	{
		 grdList.setitemtextbyname(nRow,"URG_LLMT_UNDR_PCT",Number(1-grdList.getitemtext( nRow, nColumn )).toFixed(2));
	}
	else if(grdList.getcolumnname(nColumn) == "URG_LLMT_UNDR_PCT" )
	{
		 grdList.setitemtextbyname(nRow,"URG_ULMT_EXCS_PCT",Number(1-grdList.getitemtext( nRow, nColumn )).toFixed(2));
	}else if(grdList.getcolumnname(nColumn) == "CARE_ULMT_EXCS_PCT" )
	{
		 grdList.setitemtextbyname(nRow,"CARE_LLMT_UNDR_PCT",Number(1-grdList.getitemtext( nRow, nColumn )).toFixed(2));
	}else if(grdList.getcolumnname(nColumn) == "CARE_LLMT_UNDR_PCT" )
	{
		 grdList.setitemtextbyname(nRow,"CARE_ULMT_EXCS_PCT",Number(1-grdList.getitemtext( nRow, nColumn )).toFixed(2));
	}else if(grdList.getcolumnname(nColumn) == "CMNS_ULMT_EXCS_PCT" )
	{
		 grdList.setitemtextbyname(nRow,"CMNS_LLMT_UNDR_PCT",Number(1-grdList.getitemtext( nRow, nColumn )).toFixed(2));
	}else if(grdList.getcolumnname(nColumn) == "CMNS_LLMT_UNDR_PCT" )
	{
		 grdList.setitemtextbyname(nRow,"CMNS_ULMT_EXCS_PCT",Number(1-grdList.getitemtext( nRow, nColumn )).toFixed(2));
	}
	
	return 1;
}


function btnPopup_on_mouseup(objInst)
{
	KRI.setLinkValue("dsList",dsList);
	/*	�˾� ȣ��	*/
	var popupUrl = "/BIZ/YZ/YF/AA/YFAA002_P01";
	KRI.loadSystemPopup(screen, popupUrl, true);
}

function fldLUMP_APL_VAL_INP_on_keydown(objInst, keycode, bctrldown, bshiftdown, baltdown, bnumpadkey)
{
	if(fldLUMP_APL_VAL_INP.gettext() =='')
	{
		btnLUMP_APL.setenable(false);
	}else{
		btnLUMP_APL.setenable(true);
	};
	return 0;
}
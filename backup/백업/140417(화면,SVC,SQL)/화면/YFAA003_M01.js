/*
** =================================================================================================
** �� �� �� �� : YZ (���Ͱ���)
** ȭ  ��  ID : YFAA003_M01
** ȭ  ��  �� : �̻���� �� �̻������� ����
** ��      �� : 
** ================================================================================================= 
** << ���� ���� >>
** -------------------------------------------------------------------------------------------------
** �� �� �� ��  : ������ : ��	��	��	��
** -------------------------------------------------------------------------------------------------
** 2014-03-13 : ������ : �ű��ۼ�
** YYYY-MM-DD :       
** =================================================================================================
*/

/* 
** ========================================================================
** 1. ���� ���� ����
** ======================================================================== 
*/

var m_chgFlg = "N"; //�̻���θ�� �׸��� ���濩��
var m_chgFlg2 = "N"; //�̻������ �׸��� ���濩��
var m_abvCausGridClickFlg = "Y"; //�̻���α׸���Ŭ������(�̻�����ȸ ����� ������ ����-Y:�׸���Ŭ������ ��ȸ, N-��ȸ��ưŬ������ ��ȸ)

var m_today = KRUtil.TodayDate(screen);
//var m_stDt = KRUtil.getCalculateMonth(m_today, -72);
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
	KRI.init(screen);	// ȭ�� �ʱ�ȭ (�ʼ�)  // �׽�Ʈ�ÿ��� �ּ�ó��(�����߻�)
	//����Ⱓ �⺻ ����
	fldRUN_TRM_ST_DT.settext(m_today);
	fldRUN_TRM_CLS_DT.settext(m_today);
	//�̻������ ��ư Ȱ��ȭ ����
	btnCancel.setenable(false);
	btnSave.setenable(false);
	
	fn_setDayField(fldRUN_TRM_ST_DT, txtFromDay);//���� ����
	fn_setDayField(fldRUN_TRM_CLS_DT, txtToDay);//���� ����
	
	//�̻���θ�� ��ȸ
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
* ��ũ������ Ű �Է½�
*/
function screen_on_keydown(keycode, bctrldown, bshiftdown, baltdown, bnumpadkey)
{
	if(keycode == 13) //����Ű �Է�
	{
		fn_search2_2();
	}
	return 0;
}
/* 
* submit �Ϸ�� ȣ��
*/
function screen_on_submitcomplete(mapid, result, recv_userheader, recv_code, recv_msg)
{
	if (KRI.submitComplete(screen, mapid, result, recv_userheader, recv_code, recv_msg) == false) return;
	if(mapid == "/yz/yf/aa/selectListAbvCaus.do")
	{
		var nRowCnt = grdAbvCausList.getrowcount();
		if (nRowCnt > 0)
		{
			grdAbvCausList.setselectitem(0,0);
			m_chgFlg = "N";
			btnUpdate.setenable(true);
			btnCancel.setenable(false);
			btnSave.setenable(false);
			fldQRY_CNT.settext("�� "+nRowCnt+"��");
			fldQRY_CNT.setvisible(true);
			
			fn_search2_1();
		}
		else
		{
			fldQRY_CNT.settext("");
			fldQRY_CNT.setvisible(true);
			KRI.setTranMessage(screen, 0, "��ȸ����� �����ϴ�.");
		}
	
	
	}
	else if(mapid == "/yz/yf/aa/selectListAbvTrn.do")
	{
		var nRowCnt = grdAbvTrnList.getrowcount();
		if(nRowCnt > 0)
		{
			fldQRY_CNT2.setvisible(true);
			fldQRY_CNT2.settext("�� "+nRowCnt+"��");
			btnExcel.setenable(true);
			btnChart.setenable(true);
			btnInsert.setenable(true);
			btnUpdate2.setenable(true);
			btnDelete.setenable(true);
			/*******************���***************************
			*[�̻���α׸���Ŭ��]���� ��ȸ�� ����Ⱓ�� nulló���Ͽ� ��ȸ�ϰ�
			*������� ù��° ���� �������ڸ� fldRUN_TRM_ST_DT �� ���ϰ�
			*������ ��� ���� �������ڸ� fldRUN_TRM_CLS_DT�� ����(AS-IS �� �����ϰ� ó��)
			**************************************************/
			if(m_abvCausGridClickFlg == "Y") 
			{
				var sRunTrmStDt = grdAbvTrnList.getitemtextbyname(0, "RUN_DT");
				var sRunTrmClsDt = grdAbvTrnList.getitemtextbyname(nRowCnt-1, "RUN_DT");
				fldRUN_TRM_ST_DT.settext(sRunTrmStDt);
				fldRUN_TRM_CLS_DT.settext(sRunTrmClsDt);
				fn_setDayField(fldRUN_TRM_ST_DT, txtFromDay);//���� ����
				fn_setDayField(fldRUN_TRM_CLS_DT, txtToDay);//���� ����
			}
			KRI.setTranMessage(screen, 0, "���������� ��ȸ �Ǿ����ϴ�.");
		}
		else
		{
			fldQRY_CNT2.setvisible(false);
			fldQRY_CNT2.settext("");
			fldRUN_TRM_ST_DT.settext(m_today);
			fldRUN_TRM_CLS_DT.settext(m_today);
			fn_setDayField(fldRUN_TRM_ST_DT, txtFromDay);//���� ����
			fn_setDayField(fldRUN_TRM_CLS_DT, txtToDay);//���� ����
			btnExcel.setenable(false);
			btnChart.setenable(false);
			btnInsert.setenable(true);
			btnUpdate2.setenable(false);
			btnCancel2.setenable(false);
			btnDelete.setenable(false);
			KRI.setTranMessage(screen, 0, "��ȸ����� �����ϴ�.");
		}
	}
	else if(mapid == "/yz/yf/aa/updateAbvCausList.do")
	{
		if(dsMessage.getdatabyname(0, "MSG_CONT") != "")
		{
			KRI.alert(screen, dsMessage.getdatabyname(0, "MSG_CONT"));
		}
		fn_search();
	}
	else if(mapid == "/yz/yf/aa/deleteAbvTrn.do")
	{
//		KRI.alert(screen, "�����Ϸ�");
		fn_search2_2();
	}
	
	else if(mapid == "/yz/yf/aa/updateAbvTrnList.do")
	{
//		KRI.alert(screen, "�����Ϸ�");
		fn_search2_2();
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
/*
* �̻���θ�� ��ȸ
*/
function fn_search()
{
    /* GRID CLEAR */
	KRI.setGridMode(screen, grdAbvCausList, KRConstant.GRID_CLEAR);
    /* xDataSet �ʱ�ȭ */	
	dsAbvCausList.init();
	
	
	
	KRI.requestSubmit(screen,"/yz/yf/aa/selectListAbvCaus.do",true);
    
	/* ��ȸ �� �ߴ� �����ϵ��� ȭ�鿡 ��Ŀ���� ���� */
	screen.setfocus();
}

/*
* �̻������� ��ȸ(�׸��� Ŭ�� ��ȸ)
*/
function fn_search2_1()
{
    /* GRID CLEAR */
	KRI.setGridMode(screen, grdAbvTrnList, KRConstant.GRID_CLEAR);
    /* xDataSet �ʱ�ȭ */	
	dsAbvTrnList.init();
	
	/* �˻�����(dsCond) �� */
	dsCond.setdatabyname(0, "ABV_TRN_SRT_CD", dsAbvCausList.getdatabyname(grdAbvCausList.getselectrow(), "ABV_TRN_SRT_CD"));
	dsCond.setdatabyname(0, "RUN_TRM_ST_DT", "");
	dsCond.setdatabyname(0, "RUN_TRM_CLS_DT", "");
	
	m_abvCausGridClickFlg = "Y";
	KRI.requestSubmit(screen,"/yz/yf/aa/selectListAbvTrn.do",true);

	
    /* ��ȸ �� �ߴ� �����ϵ��� ȭ�鿡 ��Ŀ���� ���� */
	screen.setfocus();
}


/*
* �̻������� ��ȸ(��ȸ��ư Ŭ�� ��ȸ)
*/
function fn_search2_2()
{
	//validation üũ
	var bValidDate = KRUtil.checkPeriodDate(fldRUN_TRM_ST_DT.gettext(), fldRUN_TRM_CLS_DT.gettext(), "YYYYMMDD", false);
	if(!bValidDate)
	{
		KRI.alert(screen, "���������� ��¥�Դϴ�. ��¥�� �ٽ� �Է����ֽʽÿ�.");
		fldRUN_TRM_ST_DT.setfocus();
		return false;
	}
	
	
    /* GRID CLEAR */
	KRI.setGridMode(screen, grdAbvTrnList, KRConstant.GRID_CLEAR);
    /* xDataSet �ʱ�ȭ */	
	dsAbvTrnList.init();
	
	/* �˻�����(dsCond) �� */
	dsCond.setdatabyname(0, "ABV_TRN_SRT_CD", dsAbvCausList.getdatabyname(grdAbvCausList.getselectrow(), "ABV_TRN_SRT_CD"));
	dsCond.setdatabyname(0, "RUN_TRM_ST_DT", fldRUN_TRM_ST_DT.gettext());
	dsCond.setdatabyname(0, "RUN_TRM_CLS_DT", fldRUN_TRM_CLS_DT.gettext());
	//dsCond.setdatabyname(0, "TRN_NO","%");
	
	m_abvCausGridClickFlg = "N"
	KRI.requestSubmit(screen,"/yz/yf/aa/selectListAbvTrn.do",true);

	
    /* ��ȸ �� �ߴ� �����ϵ��� ȭ�鿡 ��Ŀ���� ���� */
	screen.setfocus();
}

/**
 * Į���� Ư�� ��ġ�� �߰��ϰ� �߰��� Į���� ���� �Ӽ��� �����Ѵ�.
 * @param objGrid �׸��� ������Ʈ
 * @param bEditable �߰��� �ο��� ���� ���� �ٷ� ������ �� ����
 * @return 
 *    nRowIndex �߰��� �ο� �ε��� (Zero-Base)
 */
function fn_addGridItem(objGrid, bEditStart)
{
    var nRowIndex;
    var i;
	
    // �׸��忡 �� �������� �ο� �߰�
    var nRowIndex = objGrid.additem();

    // ���� ���� ���ΰ� false�̸� �ٷ� ����
    if(bEditStart == false) {
        return nRowIndex;
    }
	
    // Į�� ������ ����
    var nColumnCount = objGrid.getcolumncount();
					
    // Į�� ī��Ʈ ��ŭ ���鼭, ���� ������ Į���� ���� ���� ������.
    for(i = 0; i < nColumnCount; i++) {
        // Į�� ���� ���� �Ӽ� ���� �˻�
        if(objGrid.getcolumneditable(i) == true) {
            // ���� ���� ��
            objGrid.setitemeditstart(nRowIndex, i, bEditStart);
            break;
        }
    }
	
    return nRowIndex;
}


function setGridItemEditable(oGrid, nRow, sColumnName, bEditable)
{
	oGrid.setitemeditable(nRow, oGrid.getcolumn(sColumnName), bEditable);
	if (bEditable)
	{
		//oGrid.setitembackcolor(nRow, oGrid.getcolumn(sColumnName), factory.rgb(244,253,255));
		/*�Է��÷� ������� ����*/
		oGrid.setitembackcolor(nRow, oGrid.getcolumn(sColumnName), factory.rgb(255,255,255));
	}
	else
	{
		oGrid.setitembackcolor(nRow, oGrid.getcolumn(sColumnName), factory.rgb(255,255,255));
	}	
}

function fn_validateAll()
{
	//���濩�� üũ
	for( var i = 0 ; i < grdAbvCausList.getrowcount() ; i++ )
	{
		if(grdAbvCausList.getitemtext(i, 0) != "")
		{
			for(var j = 0 ; j < 2 ; j++)
			{
				if(grdAbvCausList.getitemtext(i, j) == "")
				{
					KRI.setTranMessage(screen, 1, grdAbvCausList.getheadertext(0, j) + "��(��) �ʼ��Է��׸��Դϴ�.");
					//�ش翭�� Ŀ�� �̵�
					grdAbvCausList.setselectitem(i, j);
					grdAbvCausList.setitemeditstart(i, j, true);
					return false;
				}
			}
		}
	}	
}


//������ư Ŭ���� (PK�� �����Ұ��ϵ��� ó��)
function fn_btnUpdate_on_mousup(oGrid, btnUpdate, btnCancel, btnSave)
{
	var nFstRow = 0;
	for(var j=0 ; j < oGrid.getrowcount() ; j++)
	{	
		if(oGrid.getitemtext(j, oGrid.getcolumn("DMN_PRS_DV_CD")) == "")
		{
			if(nFstRow == 0) nFstRow = j;
		
			for(var i=0 ; i < oGrid.getcolumncount() ; i++)
			{
				//��ûó�������ڵ�, �̻�����ڵ�, ��������, ������ȣ�� ���� �Ұ�
				if(i != oGrid.getcolumn("DMN_PRS_DV_CD") && i != oGrid.getcolumn("ABV_TRN_SRT_CD")
				 && i != oGrid.getcolumn("RUN_DT") && i != oGrid.getcolumn("TRN_NO"))
				{
					setGridItemEditable(oGrid, j, oGrid.getcolumnname(i), true);
				}
			}	
		}
	}
	
	if(oGrid.getitemtext(oGrid.getselectrow(), oGrid.getcolumn("DMD_PRS_DV_CD")) != "")
	{
		oGrid.setselectitem(nFstRow, 0);
	}
	
	//ù���� Ŀ�� �̵�
	oGrid.setselectitem(oGrid.getselectrow(), 0);
	oGrid.setitemeditstart(oGrid.getselectrow(), 0, true);
	
	btnUpdate.setenable(false);
	btnCancel.setenable(true);
	btnSave.setenable(true);	
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

/*
** ========================================================================
** 5. ��Ʈ�� �̺�Ʈ ����
** ========================================================================
*/
//����Ⱓ �޷��˾� ��ưŬ�� �̺�Ʈ
function btnPeriodCalendar_on_mouseup(objInst)
{
	KRI.showPeriodCalendar(screen, btnPeriodCalendar, fldRUN_TRM_ST_DT, fldRUN_TRM_CLS_DT);
	fn_setDayField(fldRUN_TRM_ST_DT, txtFromDay);
	fn_setDayField(fldRUN_TRM_CLS_DT, txtToDay);
}


/*
*  �̻���θ�� �׸���Ŭ��
*  �̻�������� ��ȸ�Ѵ�. 
*  �׸��� �Է�/���� ���� ���� ��ȸ���� �ʴ´�.
*/
function grdAbvCausList_on_itemclick(objInst, nClickRow, nClickColumn)
{
	if(m_chgFlg == "N") //�׸��� �������϶��� �̻�������� ��ȸ���� �ʴ´�.
	{
		fn_search2_1();
	}
	
}

/*
*  ��ȸ ��ưŬ�� �̺�Ʈ
*  �̻�������� ��ȸ�Ѵ�. 
*/
function btnSearch_on_mouseup(objInst)
{
	//validation üũ
	if(validCheck())
	{
		fn_search2_2();
	}else 
		return false;
}
/*
*  �̻���θ�� ���߰� ��ưŬ�� �̺�Ʈ
*  �̻���θ���� ���� �߰��Ѵ�. 
*/
function btnAdd_on_mouseup(objInst)
{
	//���� �ϳ� �߰�
	var nRow = fn_addGridItem(grdAbvCausList, true);
	
	//row�� ó������ ����(��ûó�������ڵ� I : insert, U : update, D : delete)
	dsAbvCausList.setdatabyname(nRow, "DMN_PRS_DV_CD", "I");
	
	//���߰� ���� ������ �߰�
	grdAbvCausList.setitemimage(nRow, 0, "/IMG/BTN/Grid_add.png");
	for(var i=0;i<grdAbvCausList.getcolumncount();i++)
	{
		setGridItemEditable(grdAbvCausList, nRow, grdAbvCausList.getcolumnname(i), true);
	}
	setGridItemEditable(grdAbvCausList, nRow, grdAbvCausList.getcolumnname(1), true);
	setGridItemEditable(grdAbvCausList, nRow, grdAbvCausList.getcolumnname(0), true);
	
	//ù���� Ŀ�� �̵�
	grdAbvCausList.setselectitem(nRow, 1);
	grdAbvCausList.setitemeditstart(nRow, 0, true);
	m_chgFlg = "Y";
	btnCancel.setenable(true);
	btnSave.setenable(true);
}

//�̻������ ����� ��ưŬ���̺�Ʈ
function btnDel_on_mouseup(objInst)
{
	var nRow = grdAbvCausList.getselectrow();
	//���߰��� row�� �ƴϸ� ����������ǥ��
	if(grdAbvCausList.getitemtext(nRow, grdAbvCausList.getcolumn("DMN_PRS_DV_CD")) != "I")
	{
		grdAbvCausList.setitemimage(nRow, 0, "/IMG/BTN/Grid_del.png");
		grdAbvCausList.setitemtext(nRow, grdAbvCausList.getcolumn("DMN_PRS_DV_CD"), "D");
		m_chgFlg = "Y";		
	}
	//���߰��� row�̸� �׸��忡�� ����
	else
	{
		grdAbvCausList.deleterow(nRow);
	}

	if(m_chgFlg == "Y")
	{
		btnCancel.setenable(true);
		btnSave.setenable(true);
	}
}

/*
*  �̻���θ�� ���� ��ưŬ�� �̺�Ʈ
*  �̻���θ�ϱ׸����� ���¸� Editable true ���·� �����Ѵ�.
*/
function btnUpdate_on_mouseup(objInst)
{
	m_chgFlg = "Y"
	fn_btnUpdate_on_mousup(grdAbvCausList, btnUpdate, btnCancel, btnSave);	
}

/*
*  �̻���θ�� ��� ��ưŬ�� �̺�Ʈ
*  �̻���θ�Ͽ��� �Է�/���� ���̴� �۾��� ����ϰ� ���� ���·� �׸��带 �ǵ�����.
*/
function btnCancel_on_mouseup(objInst)
{
	if(m_chgFlg == "Y")
	{
		var nRtn = KRI.messagebox(screen, "����Ͻðڽ��ϱ�?", XFD_MB_OKCANCEL);	

		if(nRtn == XFD_MB_RESCANCEL || nRtn == "")
		{
			return(false);
		}
		m_chgFlg = "N"; //�׸��� ���濩�� �ʱ�ȭ
	}
	btnCancel.setenable(false);
	btnSave.setenable(false);
	btnUpdate.setenable(true);
	fn_search();
}

/*
*  �̻���θ�� ���� ��ưŬ�� �̺�Ʈ
*  �̻���θ�Ͽ��� �Է�/���� ���̴� �۾��� �����Ѵ�.
*/
function btnSave_on_mouseup(objInst)
{
	var bRet = KRI.validate_grid(screen, grdAbvCausList, 2, 
       [{
		    colidx: 0,  
		    rules: 'required'
		}, {
		    colidx: 1,  
		    rules: 'required'
		}
		]);

	if(bRet == false)
	{
		return;
	}
	
	var nRtn = KRI.messagebox(screen, "�����Ͻðڽ��ϱ�?", XFD_MB_OKCANCEL); //�����Ͻðڽ��ϱ�?		
	
	if(nRtn == XFD_MB_RESCANCEL || nRtn == "")
	{
		return(false);
	}
	
	//KRDataset.debug(dsAbvCausList);
	//CUD ���� ���� ����
	KRI.setGridCheck(screen, grdAbvCausList, true);
	KRI.setGridCount(screen, grdAbvCausList, grdAbvCausList.getcheckedrowcount());
		
    // ó������ �޼��� ����
	KRI.setTranMessage(screen, 0, "ó�����Դϴ�..."); //ó�����Դϴ�.
		
	KRI.requestSubmit(screen, "/yz/yf/aa/updateAbvCausList.do", true);

}

//���� ��ưŬ���̺�Ʈ
function btnExcel_on_mouseup(objInst)
{
	grdAbvTrnList.saveexcel();
}

//��Ʈ��ȸ ��ưŬ���̺�Ʈ
function btnChart_on_mouseup(objInst)
{
	//�˾� ȣ��
	//��ȸ���� popupPram�� ��Ƽ� �˾����� ����
	var nRow = grdAbvTrnList.getselectrow();
	
	KRI.setLinkValue("RUN_DT",grdAbvTrnList.getitemtextbyname(nRow, "RUN_DT"));
	KRI.setLinkValue("TRN_NO",grdAbvTrnList.getitemtextbyname(nRow, "TRN_NO"));

	var popupUrl="/BIZ/YZ/YF/AA/YFAA003_P01";
	KRI.loadSystemPopup(screen, popupUrl, true);
}

//�̻������� ��� ��ưŬ���̺�Ʈ
function btnInsert_on_mouseup(objInst)
{
	//�˾� ȣ��
	//��ȸ���� popupPram�� ��Ƽ� �˾����� ����
	var nRow = grdAbvCausList.getselectrow();
	
	KRI.setLinkValue("RUN_TRM_ST_DT", fldRUN_TRM_ST_DT.gettext()); //����Ⱓ��������
	KRI.setLinkValue("RUN_TRM_CLS_DT", fldRUN_TRM_CLS_DT.gettext()); //����Ⱓ��������
	KRI.setLinkValue("ABV_TRN_SRT_CD",grdAbvCausList.getitemtextbyname(nRow, "ABV_TRN_SRT_CD"));//�̻���κз��ڵ�

	var popupUrl="/BIZ/YZ/YF/AA/YFAA003_E01";
	KRI.loadSystemPopup(screen, popupUrl, true);
	
	//�˾�ȭ���� ����� ���� ����
	var saveFlg = KRI.getLinkValue("saveFlg");
	var sRunTrmStDt = KRI.getLinkValue("RUN_TRM_ST_DT")
	var sRunTrmClsDt = KRI.getLinkValue("RUN_TRM_CLS_DT");
	KRI.clearLinkValue();  
	if(saveFlg == "Y")
	{
		fldRUN_TRM_ST_DT.settext(sRunTrmStDt);
		fldRUN_TRM_CLS_DT.settext(sRunTrmClsDt);
		fn_setDayField(fldRUN_TRM_ST_DT, txtFromDay);//���� ����
		fn_setDayField(fldRUN_TRM_CLS_DT, txtToDay);//���� ����	
		fn_search2_2();
	}
}

//�̻������ ���� ��ưŬ�� �̺�Ʈ
function btnUpdate2_on_mouseup(objInst)
{
	fn_btnUpdate_on_mousup(grdAbvTrnList, btnUpdate2, btnCancel2, btnSave2);
}


//�̻������� ��� ��ưŬ���̺�Ʈ
function btnCancel2_on_mouseup(objInst)
{
	if(m_chgFlg2 == "Y")
	{
		var nRtn = KRI.messagebox(screen, "����Ͻðڽ��ϱ�?", XFD_MB_OKCANCEL);	

		if(nRtn == XFD_MB_RESCANCEL || nRtn == "")
		{
			return(false);
		}
		m_chgFlg2 = "N"; //�׸��� ���濩�� �ʱ�ȭ
	}
	btnCancel2.setenable(false);
	btnSave2.setenable(false);
	btnUpdate2.setenable(true);
	fn_search2_2();
}

//�̻������� ���� ��ưŬ���̺�Ʈ
function btnDelete_on_mouseup(objInst)
{
	/* �ܰ� ���� */
//	var nRow = grdAbvTrnList.getselectrow();
//	grdAbvTrnList.setcheckedrow(nRow, true);
	/* �ٰ� ���� */
	var nStartRow = grdAbvTrnList.getselectrowfirst();
	var cnt = 0;
	KRLog.trace("nStartRow:::::::::::"+nStartRow);
	grdAbvTrnList.setcheckedrow(nStartRow, true);
	var nSelectRow = 0;
	while (nSelectRow != -1)
	{
		cnt++; 
		nSelectRow = grdAbvTrnList.getselectrownext(nStartRow);
		KRLog.trace("nSelectRow:::::::::::"+nSelectRow+"["+cnt+"]��°");
		if(nSelectRow == -1)
		{
			break;
		}
		grdAbvTrnList.setcheckedrow(nSelectRow, true);
		nStartRow = nSelectRow + 1;
	}
	KRLog.trace("üũ�ο��:::::::::::"+grdAbvTrnList.getcheckedrowcount());
	
	var nRtn = KRI.messagebox(screen, "�����Ͻðڽ��ϱ�?", XFD_MB_OKCANCEL);	
	if (nRtn == XFD_MB_RESCANCEL || nRtn == "")
	{
		return(false);
	}
	
	
    // ó������ �޼��� ����
	KRI.setTranMessage(screen, 0, "ó�����Դϴ�..."); //ó�����Դϴ�.
		
	KRI.requestSubmit(screen, "/yz/yf/aa/deleteAbvTrn.do", true);
	
}

//�̻������� ���� ��ưŬ���̺�Ʈ
function btnSave2_on_mouseup(objInst)
{
	var bRet = KRI.validate_grid(screen, grdAbvTrnList, 3, 
       [{
		    colidx: 2,  
		    rules: 'required'
		}
		]);

	if(bRet == false)
	{
		return;
	}
	
	var nRtn = KRI.messagebox(screen, "�����Ͻðڽ��ϱ�?", XFD_MB_OKCANCEL); //�����Ͻðڽ��ϱ�?		
	
	if(nRtn == XFD_MB_RESCANCEL || nRtn == "")
	{
		return(false);
	}
	
	//KRDataset.debug(dsAbvCausList);
	//CUD ���� ���� ����
	KRI.setGridCheck(screen, grdAbvTrnList, true);
	KRI.setGridCount(screen, grdAbvTrnList, grdAbvTrnList.getcheckedrowcount());
		
    // ó������ �޼��� ����
	KRI.setTranMessage(screen, 0, "ó�����Դϴ�..."); //ó�����Դϴ�.
		
	KRI.requestSubmit(screen, "/yz/yf/aa/updateAbvTrnList.do", true);

}

//�̻���� ��� �׸��� �����Ϸ� �̺�Ʈ
//�̻���� ��� ������ �Ϸ��ϸ� DMN_PRS_DV_CD�� "U"(update)�� ��
function grdAbvCausList_on_itemeditcomplete(objInst, nRow, nColumn, strPrevItemText)
{
	if(grdAbvCausList.getitemtext(nRow, nColumn) != strPrevItemText && grdAbvCausList.getitemtext(nRow, grdAbvCausList.getcolumn("DMN_PRS_DV_CD")) != "I")
	{
		grdAbvCausList.setitemtext(nRow, grdAbvCausList.getcolumn("DMN_PRS_DV_CD"), "U");
		grdAbvCausList.setitemimage(nRow, 0, "/IMG/BTN/Grid_write.png");
	}
	return 1;
}

//�̻��� ��� �׸��� �����Ϸ� �̺�Ʈ
//�̻��� ��� ������ �Ϸ��ϸ� DMN_PRS_DV_CD�� "U"(update)�� ��
function grdAbvTrnList_on_itemeditcomplete(objInst, nRow, nColumn, strPrevItemText)
{
	if(grdAbvTrnList.getitemtext(nRow, nColumn) != strPrevItemText)
	{
		grdAbvTrnList.setitemtext(nRow, grdAbvTrnList.getcolumn("DMN_PRS_DV_CD"), "U");
		grdAbvTrnList.setitemimage(nRow, 0, "/IMG/BTN/Grid_write.png");
	}
	return 1;
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
function validCheck()
{
	if(fldRUN_DT.gettext() == "")
	{
		KRI.alert(screen, "��¥�� �Է��ϼ���");
		fldRUN_DT.setfocus();
		return false;
	}
	if(!KRUtil.checkPeriodDate(fldRUN_TRM_ST_DT.gettext(), fldRUN_TRM_CLS_DT.gettext(), "YYYYMMDD")
	{
	    KRI.alert(screen, "��ȸ�������ڰ� ��ȸ�������ں��� Ŭ �� �����ϴ�.");
		fldRUN_TRM_ST_DT.setfocus();
		return false; 
	}
	return true;
}
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
function fldTRN_NO_on_keydown(objInst, keycode, bctrldown, bshiftdown, baltdown, bnumpadkey)
{
	var nTrnNoLen = fldTRN_NO.gettext().length;
	//��ȸ����
	if(keycode == 13)
	{
		if(nTrnNoLen == 0 || nTrnNoLen == 5)
		{
			fn_search2_2();
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
	objPram.trnNo = fldTRN_NO.gettext();
	//��������
	if(screen.getinstancebyname("fldRUN_DT") != undefined)
		objPram.runDt	 = fldRUN_DT.gettext();
	//�����౸���ڵ�
	if(screen.getinstancebyname("cboUP_DN_DV_CD") != undefined)
		objPram.dnDvCd    = cboUP_DN_DV_CD.getselectedcode();
	//YMS���뿩��
	if(screen.getinstancebyname("cboYMS_APL_FLG") != undefined)
		objPram.ymsAplFlg = cboYMS_APL_FLG.getselectedcode();
	//�������ڵ�
	if(screen.getinstancebyname("cboTRN_CLSF_CD") != undefined)
		objPram.trnClsfCd = cboTRN_CLSF_CD.getselectedcode();
	//�ֿ��༱/�뼱 (TBD)
	if(screen.getinstancebyname("ROUT_CD") != undefined)
		objPram.routCd    = ROUT_CD.gettext();

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
	fldTRN_NO.settext(obj.trnNo)
	//�����౸���ڵ�
	if(screen.getinstancebyname("cboUP_DN_DV_CD") != undefined)
		cboUP_DN_DV_CD.setselectedcode(obj.upDnDvCd);
	//YMS���뿩��
	if(screen.getinstancebyname("cboYMS_APL_FLG") != undefined)
		cboYMS_APL_FLG.setselectedcode(obj.ymsAplFlg);
	//�ֿ��༱/�뼱 (TBD)
	if(screen.getinstancebyname("ROUT_CD") != undefined)
	//objPram.routCd    = ROUT_CD.gettext();

	return obj;
}

function fn_trn_no_init()
{
	fldTRN_NO.settext("");
}

/*
** ========================================================================
** ������ȣ����(�⺻) �˾� ���� ��ũ��Ʈ ��
** ========================================================================
*/
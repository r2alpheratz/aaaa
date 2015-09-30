/*
** =================================================================================================
** �� �� �� �� : YZ (���Ͱ���)
** ȭ  ��  ID : YFAA003_E01
** ȭ  ��  �� : �̻������� ���
** ��      �� : �̻����� ��ϵǾ����� ���� ������ ��ȸ�Ͽ� �̻����� ����Ѵ�.
** ================================================================================================= 
** << ���� ���� >>
** -------------------------------------------------------------------------------------------------
** �� �� �� ��  : ������ : ��	��	��	��
** -------------------------------------------------------------------------------------------------
** 2014-03-19 : ������ : �ű��ۼ�
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

	var sRunTrmStDt  = KRI.getLinkValue("RUN_TRM_ST_DT");  //����Ⱓ��������
	var sRunTrmClsDt = KRI.getLinkValue("RUN_TRM_CLS_DT"); //����Ⱓ��������
	var sAbvTrnSrtCd = KRI.getLinkValue("ABV_TRN_SRT_CD"); //�̻���κз��ڵ�
	KRI.clearLinkValue();
	
	fldRUN_TRM_ST_DT.settext(sRunTrmStDt);
	fldRUN_TRM_CLS_DT.settext(sRunTrmClsDt);
	fldABV_TRN_SRT_CD.settext(sAbvTrnSrtCd);

//	fldRUN_TRM_ST_DT.settext("20130601");
//	fldRUN_TRM_CLS_DT.settext("20130617");
	
	fn_setDayField(fldRUN_TRM_ST_DT, txtFromDay);//���� ����
	fn_setDayField(fldRUN_TRM_CLS_DT, txtToDay);//���� ����
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
	if (mapid == "/yz/yf/aa/selectListNmlTrn.do")
	{
		var nRowCnt = grdList.getrowcount()
		fldQRY_CNT.settext("�� "+nRowCnt+"��");
		if (nRowCnt > 0)
		{
			fldRUN_TRM_ST_DT.setinputtype(2);
			//fldRUN_TRM_ST_DT.setbackcolor(243, 243, 243);
			fldRUN_TRM_CLS_DT.setinputtype(2);
			//fldRUN_TRM_CLS_DT.setbackcolor(243, 243, 243);
			txtFromDay.setbackcolor(243, 243, 243);
			txtToDay.setbackcolor(243, 243, 243);
			btnPeriodCalendar.setenable(false);
			chkReSearch.setenable(true);
			chkReSearch.setcheck(false);
			/*��ȸ��� �޽���*/
			KRI.setTranMessage(screen, 0, "���������� ��ȸ �Ǿ����ϴ�.");
		}
		else /* ��ȸ����� 0���̸� */
		{
			KRI.setTranMessage(screen, 0, "��ȸ�� �ڷᰡ �����ϴ�.");		
		}
		
	}
	else if (mapid == "/yz/yf/aa/insertAbvTrn.do")
	{
		if (dsMessage.getdatabyname(0, "MSG_CONT") != "")
		{
			var sMsg = "";
			for (var i = 0; i < dsMessage.getrowcount(); i++)
			{	
				if( i == dsMessage.getrowcount()-1)
				{
					sMsg += "["+dsMessage.getdatabyname(i, "MSG_CONT")+"]"
				//	KRLog.trace("sMsg:::::::::"+sMsg);
				}
				else
				{
					sMsg += "["+dsMessage.getdatabyname(i, "MSG_CONT")+"], "
				//	KRLog.trace("sMsg:::::::::"+sMsg);
				}
				KRLog.trace("sMsg:::::::::"+sMsg);
			}
		}
		KRI.alert(screen, "����Ǿ����ϴ�.\n(��, ���Ͽ��������� ��ϵǾ����� ���� ������ ����)");
		//��ȭ�鿡 �Ѱ��� ������ ����
		KRI.setLinkValue("saveFlg" , "Y");
		KRI.setLinkValue("RUN_TRM_ST_DT" , fldRUN_TRM_ST_DT.gettext());
		KRI.setLinkValue("RUN_TRM_CLS_DT" , fldRUN_TRM_CLS_DT.gettext());
		//�˾�â ����
		KRI.unloadPopup(screen);
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
	KRI.setGridMode(screen, grdList, KRConstant.GRID_CLEAR);
    /* xDataSet �ʱ�ȭ */	
	dsList.init();
		
	/* �˻�����(dsCond) �� */
	dsCond.setdatabyname(0, "RUN_TRM_ST_DT", fldRUN_TRM_ST_DT.gettext());
	dsCond.setdatabyname(0, "RUN_TRM_CLS_DT", fldRUN_TRM_CLS_DT.gettext());
	dsCond.setdatabyname(0, "TRN_NO", KRUtil.trim(fldTRN_NO.gettext()));
	
	KRI.requestSubmit(screen,"/yz/yf/aa/selectListNmlTrn.do",true);

	
    /* ��ȸ �� �ߴ� �����ϵ��� ȭ�鿡 ��Ŀ���� ���� */
	screen.setfocus();
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
/*��ȸ�� validation check*/
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
	
	var nDateCnt = KRUtil.DateSpecificYYYYMMDD(fldRUN_TRM_ST_DT.gettext(), fldRUN_TRM_CLS_DT.gettext());
	
	if (nDateCnt > 61)
	{
		KRI.alert(screen, "����Ⱓ�� 2�� �̳��� �������ֽñ� �ٶ��ϴ�.");
		fldRUN_TRM_ST_DT.setfocus();
		return false;
	}
	return true;
}

/*����� validation check*/
function validCheckSave()
{

    var bRet = KRI.validate(screen, [
									{comp: mltABV_OCUR_CAUS_CONT, rules: 'required|max_length[200]'},  // �̻�߻�����
									]
							);
	if(bRet == false)
	{
		return false;
	}	


	if (validCheck()) /*��ȸ�� ������ ��¥�� �����쿡 ���� validation check*/
	{
		var nChkCnt = grdList.getcheckedrowcount();
		if (nChkCnt > 300) /* üũ�� ������ȣ�� 300�� ������ ���� */
		{
			KRI.alert(screen, "������ ������ȣ�� �ʹ� �����ϴ�. \n300�� ���Ϸ� �������ֽʽÿ�.");
			return false;
		}
	}
	else
	{
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
	
	
	fn_setDayField(fldRUN_TRM_ST_DT, txtFromDay);//���� ����
	fn_setDayField(fldRUN_TRM_CLS_DT, txtToDay);//���� ����
}
//��ȸ ��ưŬ�� �̺�Ʈ
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
//�ݱ� ��ư Ŭ����
function btnClose_on_mouseup(objInst)
{
	KRI.unloadPopup(screen);
}
//�׸��忡�� üũ�� �� Ŭ�� �� ȣ��
function grdList_on_checkrowclick(objInst, nRow, bCheckedRow)
{
	var nChkRowCnt = grdList.getcheckedrowcount();
	if(nChkRowCnt > 0)
	{
		btnSave.setenable(true);
	}
	else
	{
		btnSave.setenable(false);
	}
}


//�����ưŬ�� �̺�Ʈ
function btnSave_on_mouseup(objInst)
{

	if (!validCheckSave())
	{
		return false;
	}
	var nRtn = KRI.messagebox(screen, "�����Ͻðڽ��ϱ�?", XFD_MB_OKCANCEL); //�����Ͻðڽ��ϱ�?		
	
	if(nRtn == XFD_MB_RESCANCEL || nRtn == "")
	{
		return(false);
	}
	var nRunTrmDno = KRUtil.DateSpecificYYYYMMDD(fldRUN_TRM_ST_DT.gettext(), fldRUN_TRM_CLS_DT.gettext()); 
	dsCond.setdatabyname(0,"RUN_TRM_DNO", nRunTrmDno); 
	
	//CUD ���� ���� ����
//	KRI.setGridCheck(screen, grdList, true);
//	KRI.setGridCount(screen, grdList, grdList.getcheckedrowcount());
	
	for(var i = 0; i < dsList.getrowcount(); i++)
	{
		var sTrnNo = KRUtil.trim(dsList.getdatabyname(i, "TRN_NO"));
		dsList.setdatabyname(i, "TRN_NO", sTrnNo);
	}		
    // ó������ �޼��� ����
	KRI.setTranMessage(screen, 0, "ó�����Դϴ�..."); //ó�����Դϴ�.
		
	KRI.requestSubmit(screen, "/yz/yf/aa/insertAbvTrn.do", true);
	
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
/* ����Ⱓ�ٽü��� üũ�� */
function chkReSearch_on_click(objInst)
{
	if (chkReSearch.getenable())
	{
		fldRUN_TRM_ST_DT.setinputtype(0);
		fldRUN_TRM_CLS_DT.setinputtype(0);
		txtFromDay.setbackcolor(255, 255, 255);
		txtToDay.setbackcolor(255, 255, 255);
		btnPeriodCalendar.setenable(true);
		chkReSearch.setenable(false);
		btnSave.setenable(false);
	    /* GRID CLEAR */
		KRI.setGridMode(screen, grdList, KRConstant.GRID_CLEAR);
	    /* xDataSet �ʱ�ȭ */	
		dsList.init();
		fldQRY_CNT.settext("");
		mltABV_OCUR_CAUS_CONT.settext("");
	}
	else
	{
		return;
	}
	
			
}
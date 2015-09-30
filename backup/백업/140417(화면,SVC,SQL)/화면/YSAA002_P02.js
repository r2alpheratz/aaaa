/*
** =================================================================================================
** �� �� �� �� : YS (�ǻ��������)
** ȭ  ��  ID : YSAA002_P02
** ȭ  ��  �� : ����ȭ ������ �Ҵ�����ȸ
** ��      �� : ����ȭ ������ �Ҵ�����ȸ�� ��ȸ�Ѵ�
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
	var m_objYZCmmnUtil = KRI.getTeamModule(screen, "YZ", "YZCmmnUtil");

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
	KRI.init(screen);	// ȭ�� �ʱ�ȭ (�ʼ�) �����׽�Ʈ ����?
	fldQRY_CNT_FLD.setinputtype(2);
	m_objYZCmmnUtil.fn_calendar_init(screen, "m_objYZCmmnUtil");
	fn_make_fld_get_all();
	fn_get_prams_from_parent_and_ajax();
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
	if ("/yz/ys/aa/selectListQtmzSgmpAlcCnqe.do")
	{

	}
	fldQRY_CNT_FLD.settext("�� " + grdList.getrowcount() +" ��");	
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

}


/*
** ========================================================================
** 4. ����� ���� �Լ� ����
** ========================================================================
*/
function fn_make_all_code(objComboInst, strParam){
	objComboInst.insertstring(0, strParam);
	objComboInst.setselectedindex(0);
}

function fn_call_trn_no_popup()
{
	var callType = "BASE"
	var popupUrl="/BIZ/YZ/YB/CO/YBCO002_P01";
	m_objYZCmmnUtil.trnNoBsPopupCall(screen, callType, popupUrl);
	m_objYZCmmnUtil.yz_comm_set_select_seg_list(screen);
	grdList.deleteall();

}

function fn_make_fld_get_all()
{
	fn_make_all_code(cboPSRM_CL_CD, "%:��ü");
	fn_make_all_code(cboSEAT_ATT_CD, "%:��ü");	
	fn_make_all_code(cboUDWN_DV_CD, "%:������");
	cboUDWN_DV_CD.deletestring(1);
	fn_make_all_code(cboZONE_SEG_GP_NO, "%:��ü");
	cboACVM_RT.setselectedcode("0");
}

function fn_get_prams_from_parent_and_ajax()
{
	var sYmgtJobId = KRI.getLinkValue("YMGT_JOB_ID");
	var sRunDt = KRI.getLinkValue("RUN_DT");
	var sTrnNo = KRI.getLinkValue("TRN_NO");
	dsOptSeqCondition.setdatabyname(0, "YMGT_JOB_ID", sYmgtJobId);
	dsOptSeqCondition.setdatabyname(0, "TRN_NO", sTrnNo);
	dsOptSeqCondition.setdatabyname(0, "RUN_DT", sRunDt);
	
	fldRUN_DT.settext(sRunDt);
	fldTRN_NO.settext(sTrnNo);
	KRLog.trace("(����)YMGT_JOB_ID :::::::"+sYmgtJobId);
	KRLog.trace("(����)TRN_NO :::::::"+sRunDt);
	KRLog.trace("(����)RUN_DT :::::::"+sTrnNo);
	
	//dsOptSeqCondition.setdatabyname(0, "YMGT_JOB_ID", "B_YD2301120130204001");
	//dsOptSeqCondition.setdatabyname(0, "TRN_NO", "00152");
	//dsOptSeqCondition.setdatabyname(0, "RUN_DT", "20130304");
	//dsOptSeqCondition.setdatabyname(0, "BKCL_CD", "F1");	
	//�Ƹ� ��Ÿ �Ӽ����� '��ü'���ؼ� �����µ�
	
	KRI.requestSubmit(screen, "/yz/ys/aa/selectListQtmzSgmpAlcCnqe.do", true);
	m_objYZCmmnUtil.yz_comm_set_select_seg_list(screen, true);
}


/*
** ========================================================================
** 5. ��Ʈ�� �̺�Ʈ ����
** ========================================================================
*/

function trnBtn_on_mouseup(objInst)
{
	 fn_call_trn_no_popup();
}
function fldTRN_NO_on_keydown(objInst, keycode, bctrldown, bshiftdown, baltdown, bnumpadkey)
{
	if(keycode == '13')
	{
		 fn_call_trn_no_popup();
	}
}

function btnSearch_on_mouseup(objInst)
{
	KRI.requestSubmit(screen, "/yz/ys/aa/selectListQtmzSgmpAlcCnqe.do", true);
	m_objYZCmmnUtil.yz_comm_set_select_seg_list(screen, false);
}



function cboZONE_SEG_GP_NO_on_focusout(objInst)
{
	 m_objYZCmmnUtil.yz_comm_set_select_seg_list(screen);
}
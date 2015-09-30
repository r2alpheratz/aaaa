/*
** =================================================================================================
** �� �� �� �� : YS (�ǻ��������)
** ȭ  ��  ID : YSAB001_M01
** ȭ  ��  �� : �¶��� ���Ͱ��� �۾�ó��
** ��      �� : �¶��� ���Ͱ��� �۾�ó�������� ��ȸ�ϰ� ����ȭ�� �����Ѵ�.
** ================================================================================================= 
** << ���� ���� >>
** -------------------------------------------------------------------------------------------------
** �� �� �� ��  : ������ : ��	��	��	��
** -------------------------------------------------------------------------------------------------
** 2014-04-08 : ������ : �ű��ۼ�
** YYYY-MM-DD :  
** =================================================================================================
*/

/* 
** ========================================================================
** 1. ���� ���� ����
** ======================================================================== 
*/
	var m_objYZCmmnUtil = KRI.getTeamModule(screen,"YZ","YZCmmnUtil");
	var m_sTodayDt = KRUtil.TodayDate(screen);
	var m_sOptErrTb = "";
	var m_aOptChkTb = ["����������",
						"�����⺻",
						"�������೻��",
						"�ܿ����⺻",
						"LEG�ܿ�������",
						"SEG�ܿ�������",
						"�����������׷쳻��",
						"YMS�Ҵ��ܿ�������",
						"��ŷŬ�������볻��"] ;
	var m_nProgStt = 10;						

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
	m_objYZCmmnUtil.fn_calendar_init(screen,"m_objYZCmmnUtil");
	pnlProg.setvisible(false);
	progBar.setmaxvalue(100);
	progBar.setpos(m_nProgStt,true);
	fldLEFT_QRY_CNT_FLD.setinputtype(2);
	fldRIGHT_QRY_CNT_FLD.setinputtype(2);


	
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
	if ( mapid == "/yz/ys/ab/selectListYmgtJobDmnLst.do")
	{
		fldLEFT_QRY_CNT_FLD.settext("�� " + grdYmgtJobDmnLst.getrowcount() +" ��");
	}
	if ( mapid == "/yz/ys/ab/selectListYmgtJobDmnDtlLst.do")
	{
		fldRIGHT_QRY_CNT_FLD.settext("�� " + grdYmgtJobDtlLst.getrowcount() +" ��");
	}
	if( mapid == "/yz/ys/ab/insertKtxRsvSaleDmnTrnRcvCfm.do" ||
		mapid ==  "/yz/ys/ab/insertSmlRsvSaleDmnTrnRcvCfm.do" )
	{
		fn_insert_callback();
	}
	if (mapid == "/yz/ys/ab/insertOtmzExc.do")
	{
		//��ġ ������ ������ �����޽����߻�, ������ ��� ȭ�� refresh
		var batResult = dsRsvOptResult.getdatabyname(0,"BATCH_RESULT");

		if ( batResult == ""){
			fn_seacrh_ymgt();
		}
		else
		{
			KRI.alert(screen, batResult, "����");
			KRI.setTranMessage(screen, 0, batResult);
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
	  KRI.addResize(grdYmgtJobDtlLst, KRConstant.CST_DIRECTION_BOTH);
	  KRI.addResize(grdYmgtJobDmnLst, KRConstant.CST_DIRECTION_VERT);
	  KRI.addResize(pnlCondition, KRConstant.CST_DIRECTION_HORZ);
	  KRI.addReposition(pnlSearch,KRConstant.CST_DIRECTION_HORZ);
	  KRI.addReposition(pnlBtns,KRConstant.CST_DIRECTION_VERT);
	  KRI.addReposition(btnExecute,KRConstant.CST_DIRECTION_BOTH);
}


/*
** ========================================================================
** 4. ����� ���� �Լ� ����
** ========================================================================
*/
//�۾���û�󼼸�� ��ȸ
function fn_seacrh_ymgt()
{
	grdYmgtJobDtlLst.deleteall();
	var jobDt = fldRUN_DT.gettext()
	dsGrdYmgtCond.setdatabyname(0, "JOB_DT", jobDt);
	KRI.requestSubmit(screen, "/yz/ys/ab/selectListYmgtJobDmnLst.do", true, true, true);
}
//�۾���û�󼼸�� ��ȸ
function fn_seacrh_ymgt_dtl(nClickRow)
{
	var sYmgtJobId = grdYmgtJobDmnLst.getitemtextbyname(nClickRow,"YMGT_JOB_ID");
	dsGrdYmgtDtlCond.setdatabyname(0, "YMGT_JOB_ID", sYmgtJobId);
	KRI.requestSubmit(screen, "/yz/ys/ab/selectListYmgtJobDmnDtlLst.do", true, true, true);
}

//���� ����Ȯ�� Y/N 
function fn_chk_rsv_receive_confirm(sChkFlg)
{
	var sTodayDt = m_sTodayDt.substring(0,4)+". "+m_sTodayDt.substring(4,6)+". "+m_sTodayDt.substring(6,8);
	var sMsg = sTodayDt+"�� ����߸�����ȭ��û ������ ���ŵǾ����� Ȯ���Ͻðڽ��ϱ�?";
	if(6 ==  KRI.messagebox(screen, sMsg, XFD_MB_YESNO))
	{
		if (sChkFlg == "KTX")
		{
			KRI.requestSubmit(screen, "/yz/ys/ab/insertKtxRsvSaleDmnTrnRcvCfm.do", true);
		}
		else if (sChkFlg == "SML")
		{
			KRI.requestSubmit(screen, "/yz/ys/ab/insertSmlRsvSaleDmnTrnRcvCfm.do", true);
		}
	}
	
}

function fn_insert_callback()
{
		var rstFlg = dsRsvDmnTrnRcvCfm.getdatabyname(0,"RESULT_FLAG");
		switch(rstFlg)
		{
			case '0' :
				KRI.alert(screen, "���� ����߸ſ�û ������ ���������� ó�����Դϴ�.", "Information");
				KRI.setTranMessage(screen, 0, "���� ����߸ſ�û ������ ���������� ó�����Դϴ�.");
				break;
			case '1' :
				KRI.alert(screen, "����߸ſ�û���� �ڷ����Ȯ�� �� ������ �߻��߽��ϴ�.", "Alert");
				KRI.setTranMessage(screen, 0, "����߸ſ�û���� �ڷ����Ȯ�� �� ������ �߻��߽��ϴ�.");
				break;
			case '2' :
				//fn_seacrh_ymgt();
				KRI.loadSystemPopup(screen, "/BIZ/YZ/YS/AB/YSAB001_P01", true)
				break;
			default : 
				KRI.alert(screen, "ó������", "Alert");
				KRI.setTranMessage(screen, 0, "ó������");
		}
}
function fn_set_dsRsvOptExc(nClickRow){

	var jobDttm = fldRUN_DT.gettext();
	var ymgtJobId = grdYmgtJobDmnLst.getitemtextbyname(nClickRow, "YMGT_JOB_ID");
	var jobStDttm = grdYmgtJobDmnLst.getitemtextbyname(nClickRow, "JOB_DT");
	var trvlUsrId = grdYmgtJobDmnLst.getitemtextbyname(nClickRow, "TRVL_USR_NM");

	dsRsvOptExc.setdata(0,0,jobDttm);
	dsRsvOptExc.setdata(0,1,ymgtJobId);
	dsRsvOptExc.setdata(0,2,jobStDttm);
	dsRsvOptExc.setdata(0,3,trvlUsrId);
}

function fn_rsv_opt_exc()
{

	var jobStDttm = dsRsvOptExc.getdatabyname(0, "JOB_ST_DTTM");
	
	if (jobStDttm == "-")
	{
		KRI.alert(screen, "�� �۾��� �̹� ������ ���� �ֽ��ϴ�.", "Information");
	}
	else
	{	
		m_sOptErrTb = "";
		pnlProg.setvisible(true);
		for( var i = 0 ; i < m_aOptChkTb.length ; i++)
		{
			var sTbNm = m_aOptChkTb[i]
			dsRsvOptExc.setdatabyname(0, "TB_NM", sTbNm);		
			KRI.requestSubmit(screen, "/yz/ys/ab/insertOtmzExc.do", false, false);
			
			//���α׷����� ����� 10%����
			m_nProgStt += 10;
			progBar.setpos(m_nProgStt,true);
			
			//���α׷����� ������� 100%�� �Ǹ� ����
			if(m_nProgStt == 100){
				pnlProg.setvisible(false);
			}
			
			//�����Ͱ� �����ϴ��� ���θ� �˻��Ͽ� ���� ���, �ش� �������̺���� ds�� ���� ����. �̰��� 
			var sErrorTb = dsRsvOptChkErrTb.getdatabyname(0,"errorTable");
			if (sErrorTb != "")
			{
				m_sOptErrTb = m_sOptErrTb + sErrorTb + ", ";
			}
			if(m_sOptErrTb != "" && m_nProgStt >= 100)
			{
				m_sOptErrTb = "���� ���̺��� ������ �߻��Ͽ����ϴ�. : "+m_sOptErrTb.substring(0, m_sOptErrTb.length-2);
				KRI.alert(screen, m_sOptErrTb);

				m_sOptErrTb = ""; //�����޽��� �ʱ�ȭ
				
				// ���α׷����� �ʱ�ȭ
				m_nProgStt = 10; 
				progBar.setpos(m_nProgStt,true);
				return;
			}
		}
		//��ġ����
		dsRsvOptExc.setdatabyname(0, "TB_NM", "");		
		KRI.requestSubmit(screen, "/yz/ys/ab/insertOtmzExc.do",true);
		
	}
}

/*
** ========================================================================
** 5. ��Ʈ�� �̺�Ʈ ����
** ========================================================================
*/

function btnSearch_on_mouseup(objInst)
{
	fn_seacrh_ymgt();
}

function btnKTX_on_mouseup(objInst)
{
	fn_chk_rsv_receive_confirm("KTX");
}

function btnSML_on_mouseup(objInst)
{
	fn_chk_rsv_receive_confirm("SML");
}

function btnOnlineStat_on_mouseup(objInst)
{
	KRI.alert(screen, "�¶����۾�������ȸâ ��ũ ����", "Information");
}	

function grdYmgtJobDmnLst_on_itemclick(objInst, nClickRow, nClickColumn)
{
	fn_set_dsRsvOptExc(nClickRow);
	fn_seacrh_ymgt_dtl(nClickRow);
}

function fldRUN_DT_on_change(objInst)
{
	var jobDt = fldRUN_DT.gettext();

	if(m_sTodayDt == jobDt)
	{
		btnExecute.setenable(true);
	}
	else
	{
		btnExecute.setenable(false);
	}
}

function btnExecute_on_mouseup(objInst)
{
	fn_rsv_opt_exc();
}
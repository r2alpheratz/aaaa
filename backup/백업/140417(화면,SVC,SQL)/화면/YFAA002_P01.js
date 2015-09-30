/*
** =================================================================================================
** 시 스 템 명 : RZ (예약발매)
** 화  면  ID : YFAA002_P01
** 화  면  명 : DSP별 비정상판단비율 차트조회
** 개      요 : DSP별 비정상판단 비율을 YFAA002_M01 화면으로부터 받아와 차트로 조회한다.
** ================================================================================================= 
** << 변경 정보 >>
** -------------------------------------------------------------------------------------------------
** 변 경 일 자  : 변경자 : 변	경	내	역
** -------------------------------------------------------------------------------------------------
** 0000-00-00 : 나윤채 : 신규작성
** YYYY-MM-DD : 2014-04-08
** =================================================================================================
*/

/* 
** ========================================================================
** 1. 전역 변수 영역
** ======================================================================== 
*/


/*
** ========================================================================
** 2. 화면 이벤트 영역
** ========================================================================
*/

/*
* 화면 온로드
*/ 
function screen_on_load()
{
	KRI.init(screen);	// 화면 초기화 (필수)

		cboSRCH_DV.setselectedindex(0);

	//To do
	KRDataset.copy(KRI.getLinkValue("dsList"),dsTransList,false);
	KRI.clearLinkValue();
	//차트
	
	fn_chart("grdList");	
	fn_SFMsg();
	
}

/*
* 스크린 사이즈 변경시
*/ 
function screen_on_size(window_width, window_height)
{
	KRI.processResize(screen, window_width, window_height);
}

/* 
* submit 완료시 호출
*/
function screen_on_submitcomplete(mapid, result, recv_userheader, recv_code, recv_msg)
{
	if (KRI.submitComplete(screen, mapid, result, recv_userheader, recv_code, recv_msg) == false) return;
}

/*
** ========================================================================
** 3. 필수 구현 함수 영역
** ========================================================================
*/

/*
* 화면이 리사이징 될때 변동될 컨트롤정보를 등록한다.
*/
function processResize()
{
//	KRI.addResize(pnlCondition, KRConstant.CST_DIRECTION_HORZ);
//	KRI.addReposition(pnlSearch, KRConstant.CST_DIRECTION_HORZ);
//	KRI.addResize(OUTREC1_GRID, KRConstant.CST_DIRECTION_BOTH);
}


/*
** ========================================================================
** 4. 사용자 정의 함수 영역
** ========================================================================
*/

function fn_chart(grdData){
	var sReportId = "/YZ/YF/AA/YFAA002_P01_CHT01.reb"; //보고서ID
	var aFields = null;  //매개변수 필드(여기서는 사용하지 않음)
	var sCSV = KRI.makeCSV(screen, grdData);   //그리드데이터를 CSV형태로 변환
	KRLog.trace(sCSV);
	var sOOF = KRI.makeOOF(screen, sReportId, aFields, sCSV); //OOF Xml 생성
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
		/*조회결과 메시지*/
		KRI.setTranMessage("/BIZ/YZ/YF/AA/YFAA002_P01", 0, "정상적으로 조회 되었습니다.");
	}
	else 
	{
		/* 조회결과가 0건 */
		KRI.setTranMessage("/BIZ/YZ/YF/AA/YFAA002_P01", 0, "조회할 자료가 없습니다.");		
	};
}

/*
** ========================================================================
** 5. 컨트롤 이벤트 영역
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
		var colId = dsSrchDvList.getcolumnid(i) // dsSrchDvList 전체 칼럼명
		
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

<%--     샘플
    @author caley
    @since: 2015. 2. 11. 오전 9:48:44
	     --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%--   페이지 로케이션 바
<div class="depthbox1 fix mt25">
	<h1 id="title01">${viewPageInfoVo.menuNm}</h1>
	<div class="dir_align">
		<div id="currMenuSq"  hidden="true" style="display:none">${viewPageInfoVo.menuSq}</div>
		<dl class="fix" id="locationinfo">
			<dt style="font-weight: normal;">${viewPageInfoVo.superPrntNm}</dt>
			<dt style="font-weight: normal;">${viewPageInfoVo.parentMenuNm}</dt>
			<dt>
				<strong>${viewPageInfoVo.menuNm}</strong>
			</dt>
		</dl>
	</div>
</div>
--%>
<div id="content">
	<div class="fL mr20" style="width: 720px;">
<div id="sendMail" class="detail_basic">
	<form name="sendMailForm" id="sendMailForm">
		<br />
		<table class="table-border">
			<colgroup>
				<col width="15%">
				<col width="">
			</colgroup>
			<thead style="display: none"></thead>
			<tfoot></tfoot>
			<tbody>
				<tr>
					<th>
						<%-- <span class="noessential fL"><spring:message  code="UI_TEXT_FORM_USER_ID" /></span> --%>
						<span class="essential fL"><spring:message  code="UI_TEXT_FORM_SENDER" /></span>
					</th>
					<td>
					<div>
						<input type="text" name="sender"  id="sender" vtype="required,emailCheck"
						 	vname="<spring:message  code="UI_TEXT_FORM_SENDER" />"  style="width:600px"
						 	datatype="kor|eng|num|space|sig" minlength="1" value="${email}"></input>
					</div>
					</td>
				</tr>
				<tr>
					<th>
						<span class="essential fL"><spring:message  code="UI_TEXT_FORM_RECEIVER" /></span>
					</th>
					<td>
					<div>
						<input type="text" name="receivers"  id="receivers" vtype="required,emailsCheck"
						 	vname="<spring:message  code="UI_TEXT_FORM_RECEIVER" />"  style="width:600px"
						 	datatype="kor|eng|num|space|sig" minlength="1">
					</div>
					</td>
				</tr>
				<tr>
					<th>
						<%-- <span class="noessential fL"><spring:message  code="UI_TEXT_FORM_USER_ID" /></span> --%>
						<span class="essential fL"><spring:message  code="UI_TEXT_FORM_MAILTITLE" /> </span>
					</th>
					<td>
					<div>
						<input type="text" name="title"  id="title" vtype="required"
						 	vname="<spring:message  code="UI_TEXT_FORM_MAILTITLE" />"  style="width:600px"
						 	datatype="kor|eng|num|space|sig" minlength="1"
							onkeypress="javascript:gf_checkTypes(this, 'NOTSPC', event);">
					</div>
					</td>
				</tr>
				<tr>
					<th>
						<%-- <span class="essential fL"><spring:message  code="UI_TEXT_FORM_AGE" /></span> --%>
						<span class="essential fL"><spring:message  code="UI_TEXT_FORM_MAILCONTENT" /></span>
					</th>
					<td>
						<textarea name="mailBody"  id="mailBody"
							 vname="<spring:message  code="UI_TEXT_FORM_MAILCONTENT" />" vtype="required" style="width:600px; height:500px"
							 notnull="y" datatype="kor|eng|num|space|sig"/>
					</td>
				</tr>
				<tr>
					<th>
					<span class="noessential fL"><spring:message  code="UI_TEXT_FORM_ATTACHMENT" /></span></th>
					 <%-- <div class="form_wrap">
						<%@ include file="/WEB-INF/pages/faro/comm/fileUploadPopup_cottonseed.jsp" %>
					</div> --%>
					<td>

						<span id="importBtn" class="btn_pc" onclick="uploadFilePopup();"><spring:message  code="UI_TEXT_FORM_ATTACHMENT" /></span>

						<span id="fileNames"></span>

					        <div style="overflow: hidden;">
					            <div style="border: none;" id="listbox">
					            </div>
					        </div>
					        <!-- <div style="overflow: hidden;" id="ContentPanel">
					        </div> -->
					</td>
				</tr>

			</tbody>
		</table>
		<input type="hidden" name="fileList" id="fileList" />
		<div class="btngrid_right" style="margin-top: 10px">

			<span id="btn_expandall" class="btn_pc" onclick="sendmail()">
				<spring:message  code="UI_TEXT_BTN_SENDMAIL" />
			</span>

		</div>
	</form>
</div>
</div>
</div>


<script>


function sendmail(){
	if (validateFormValues("<spring:message  code='UI_TEXT_LABEL_SEND_MAIL' />", $("#sendMailForm"))) {
		var url = CONTEXTPATH + "/common/esb/sendMail";

		var data = { title : $('#title').val() ,
					 content : $('#mailBody').val(),
					 fileNames : $("#listbox").jqxListBox('getItems'),//$('#fileNames').text(),
					 sender : $('#sender').val(),
					 receivers : $('#receivers').val()
				   };
		lego_common_ajax(url, data, function(ret) {
			if(ret.SUCC =="TRUE"){
				$('#fileNames').text("");
				lego_common_succ("<spring:message  code='UI_TEXT_LABEL_SEND_MAIL' />", "<spring:message  code='UI_TEXT_LABEL_SEND_MAIL_SUCCESS' />");
	    	}else{
	    		lego_common_alert("<spring:message  code='UI_TEXT_LABEL_SEND_MAIL' />", ret.errormsg);
	    	}

		});
	}
}

function uploadFilePopup(){
	//lego_common_alert("준비중","아직 준비중인 메뉴입니다.");

	var title = "File Upload";
	var url = CONTEXTPATH + "/common/esb/attachments";
	var data = {"title" : title};
	var allowFileTypes = [];
	var pop;

	if (LEGO_POPUP.hasPopup('fileUploadPopup')) {
		pop = LEGO_POPUP.getPopup('fileUploadPopup');
	} else {
		pop = LEGO_POPUP.createPopup({
			name : 'fileUploadPopup',
			url : CONTEXTPATH + '/common/file/viewFileUploadPopup' ,
			title : title,
			width : '680px',
			/* height : '415', */
			popupArgs : {
				url : url,
                data : data,
                allowFileTypes: allowFileTypes,
                allowFileExt : allowFileTypes,
                deniedFileExt : ['exe', 'bat'],
                maxUploadSizeMb : <spring:eval expression=" @comProps['maxUploadSizeMb']"/>,
                maxEachFileSizeMb : <spring:eval expression="@comProps['maxEachFileSizeMb']"/>,
                title : title,
                multiple : true,
                callback: function(data) { // 업로드 완료 콜백함수
                	if(data.SUCC =="TRUE"){
                		lego_common_succ(title, "Upload completed!");
                		// 화면에 리스트를 뿌려준다.

                		/* if($('#fileNames').text() != null && $('#fileNames').text()!="")
                			$('#fileNames').text($('#fileNames').text()+','+ data.fileNames);
                		else
                			$('#fileNames').text(data.fileNames); */


                		/* var items = $("#jqxListBox").jqxListBox('getItems');
                		if(items == null || items.length==0){
                			//data
                		} */

                		var items = data.fileNames;
                		if(items != null && items.length > 0){
                			// 중복파일 걸러내기
                			// 리스트에 더함
                			for(var i=0; i<items.length; i++){
                				var isDuplicated = false;

                				var fileArr = $("#listbox").jqxListBox('getItems');
                				for(var j=0; j<fileArr.length;j++){
	               					 if(items[i] == fileArr[j].value){
	               						 isDuplicated = true;
	               						 break;
	               					 }
	               				}

                				if(isDuplicated){
                					lego_common_alert(title,"UI_MSG_WARN_DENIED_DUPLICATED_FILE".i18n(items[i]));
                				}else{
                					$("#listbox").jqxListBox('addItem', items[i] );
                				}


                			}
                		}


                	}else{
                		lego_common_alert(title, "Upload Failed!");
                	}
                	modalClose();
                }
			},
			closeCallback : function closeCallback() {
				LEGO_POPUP.destroyPopup('fileUploadPopup');
				console.log('closeCallback');
			},
			destroyCallback : function destroyCallback() {
				console.log('destroyCallback');
			}
		});
	}
	pop.show();
}

function deleteItem(value){

	$("#listbox").jqxListBox('removeItem', value );
	lego_common_succ("File Upload", "UI_MSG_DEL_SAVE".i18n());
}

function initFileListBox(){
    // prepare the data
    var data = new Array();

    var row = {};
    row["filename"]="asdfadsf";
    var k = 0;
    var source =
    {
        localdata: data,
        datatype: "array"
    };
    var dataAdapter = new $.jqx.dataAdapter(source);
    $('#listbox').on('select', function (event) {

    });

    // Create jqxListBox
    $('#listbox').jqxListBox({ selectedIndex: 0,  source: dataAdapter, displayMember: "firstname", valueMember: "notes", autoHeight:true, width: '100%',
        renderer: function (index, label, value) {
            var table = '<table style="min-width: 130px;"><tr><td style="width: 91%; border-bottom: none; border-left:none">' + value.filename + '</td><td style="border-bottom: none; border-left:none"><span id="importBtn" class="btn_pc" onclick="deleteItem('+index+');"><spring:message  code="UI_TEXT_LABEL_DEL" /></span></td></tr></table>';
            return table;
        }
    });
}
$(document).ready(function () {
   $('#mailBody').jqxEditor({
        height: "400px",
        width: '600px'
    });

    initFileListBox();
});

</script>

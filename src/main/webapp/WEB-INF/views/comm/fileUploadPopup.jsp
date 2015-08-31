<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<div class="container-upload">
<div class="title-area"></div>
<div id="streamUploader"></div>
</div>

<script>



    var ENV = {
        UPLOADER_MAIN: '#streamUploader',
        ADD_BTN: '#add',
        UPLOAD_ALL_BTN: '#uploadAll',
        UPLOAD_AT_ONCE_BTN: '#uploadAtOnce',
        CLEAR_BTN: '#clear',
        CANCEL_BTN: '#cancel'
    }


    var mainView = {

        initUploader: function (popupData) {
            $(ENV.UPLOADER_MAIN).jqxFileUploader({
                  url: popupData.url
                , data : popupData.data
                , title : popupData.title
                , width: 600
                , buttonIconOnly: false  //Optional: true인 경우 버튼 아이콘만 표시, false는 아이콘+텍스트 표시
                , allowFileTypes: popupData.allowFileTypes   // ex> ['jpg', 'gif', 'png']   //Optional: 허용할 확장자 리스트. 리스트가 비어있으면 모두 허용
//                , maxUploadSize: 1024 * 1024 * 10 // 10MB : 전체 업로드 가능 사이즈
//                , maxEachFileSize: 1024 * 1024 * 3 // 3MB : 개별 파일 업로드 가능 사이즈
                , uploadSuccess: popupData.callback
            });

			if (popupData.multiple == false) {
				$(ENV.UPLOADER_MAIN).on('addfile', function(event) {
					$("button.aui-fileuploader-control-addbtn").addClass("jqx-fill-state-disabled");
					$("button.aui-fileuploader-control-addbtn").jqxButton({ disabled: true});
				});
				$(ENV.UPLOADER_MAIN).on('removefile', function(event) {
					$("button.aui-fileuploader-control-addbtn").removeClass("jqx-fill-state-disabled");
					$("button.aui-fileuploader-control-addbtn").jqxButton({ disabled: false});
				});
			}

		   $('#streamUploader').on('onabort', function(event) {
				$("button.aui-fileuploader-control-addbtn").removeClass("jqx-fill-state-hover");
				$("button.aui-fileuploader-control-uploadbtn").removeClass("jqx-fill-state-hover");
				$("button.aui-fileuploader-control-resetbtn").removeClass("jqx-fill-state-hover");
				$("button.aui-fileuploader-control-cancelbtn").removeClass("jqx-fill-state-hover");
				lego_common_alert(popupData.title,  event.args.data.responseJSON.errormsg);
				$('#streamUploader').jqxFileUploader('removeFile', event.args.file.id);
				  return false;
		   });

		   $('#streamUploader').on('removefile', function(event) {
				$("button.aui-fileuploader-control-addbtn").removeClass("jqx-fill-state-hover");
				$("button.aui-fileuploader-control-uploadbtn").removeClass("jqx-fill-state-hover");
				$("button.aui-fileuploader-control-resetbtn").removeClass("jqx-fill-state-hover");
				$("button.aui-fileuploader-control-cancelbtn").removeClass("jqx-fill-state-hover");
		   });

		   $('#streamUploader').on('select', function(event) {

				alert("sdfasf");
		   });
			$('#streamUploader').on('addfile', function(event) {
			 //if(event.args.file.type != 'application/vnd.ms-excel'){
				 $("button.aui-fileuploader-control-addbtn").removeClass("jqx-fill-state-hover");
				 $("button.aui-fileuploader-control-uploadbtn").removeClass("jqx-fill-state-hover");
				 $("button.aui-fileuploader-control-resetbtn").removeClass("jqx-fill-state-hover");
				 $("button.aui-fileuploader-control-cancelbtn").removeClass("jqx-fill-state-hover");
			     // 허가되는 파일 타입 체크
				 if(popupData.allowTypes != null && popupData.allowTypes !=''){
					if(event.args.file.type != popupData.allowTypes){
						 lego_common_alert(popupData.title, "UI_MSG_WARN_ONLY_SPECIFIED_FILE_POSSIBLE".i18n(popupData.allowTypes));
						  $('#streamUploader').jqxFileUploader('removeFile', event.args.file.id);
						  return false;
					 }
				 }

				// 허가된 파일 확장자 체크
				 if(popupData.allowFileExt != null && popupData.allowFileExt !=''){
					 var ext = event.args.file.name.split('.').pop().toLowerCase();
				      if($.inArray(ext,popupData.allowFileExt) == -1) {
				    	  lego_common_alert(popupData.title, "UI_MSG_WARN_ONLY_SPECIFIED_EXT_POSSIBLE".i18n(popupData.allowFileExt));
				    	  $('#streamUploader').jqxFileUploader('removeFile', event.args.file.id);
				    	  return false;
				      }
				 }

				// 거부된 파일 확장자 체크
				 if(popupData.deniedFileExt != null && popupData.deniedFileExt !=''){
					 var ext = event.args.file.name.split('.').pop().toLowerCase();
				      if($.inArray(ext,popupData.deniedFileExt) == 0) {
				    	  lego_common_alert(popupData.title, "UI_MSG_WARN_ONLY_SPECIFIED_EXT_DENIED".i18n(popupData.deniedFileExt));
				    	  $('#streamUploader').jqxFileUploader('removeFile', event.args.file.id);
				    	  return false;
				      }
				 }

				// 중복파일명 체크
				 var fileArr = $('#streamUploader').jqxFileUploader('getFileInfoList');
				 for(var i=0; i<fileArr.length-1;i++){
					 if(event.args.file.name == fileArr[i].name){
						 lego_common_alert(popupData.title,"UI_MSG_WARN_DENIED_DUPLICATED_FILE".i18n(event.args.file.name), function(){$('#streamUploader').jqxFileUploader('removeFile', event.args.file.id);});
						 return false;
					 }
				 }

				// 파일 당 용량 체크
				 if(event.args.file.size > 1024 * 1024 * popupData.maxEachFileSizeMb){
					 lego_common_alert(popupData.title,"UI_MSG_WARN_OVERSIZE_FILE".i18n(popupData.maxEachFileSizeMb), function(){$('#streamUploader').jqxFileUploader('removeFile', event.args.file.id);});
					 return false;
				 }

				// 파일 전체 용량 체크
				var totalFilesSize = 0;
				 for(var i=0; i<fileArr.length-1;i++){
					 totalFilesSize += fileArr[i].size;
				 }
				 if(totalFilesSize > 1024 * 1024 * popupData.maxUploadSizeMb){
					 lego_common_alert(popupData.title,"UI_MSG_WARN_OVERSIZE_TOTAL_FILES".i18n(popupData.maxUploadSizeMb), function(){$('#streamUploader').jqxFileUploader('removeFile', event.args.file.id);});
					 return false;
				 }


			});

			$("body").on("change", function(){
				$(".aui-fileuploader-progressbar").css('width', '170px');
			});


		}



	}

    var formatDownload;

	function modalClose() {
		LEGO_POPUP.getPopup("fileUploadPopup").close();
	}

	$(document).ready(
			function() {

				/*
					url : url  - String
					data: data - Json  ex) { key: value, key : value}
					allowFileTypes : Array  ex) ['jpg', 'gif', 'png']   //Optional: 허용할 확장자 리스트. 리스트가 비어있으면 모두 허용
					formatDownload : String ex)'<div class="btngrid_right" style="padding-top: 10px"><span id="downloadExcelForm" class="btn_pc" onclick="formatDownload();">Format Download</span></div>'
					formatDownloadFunction : function
				*/

				var popupData = LEGO_POPUP.getPopup("fileUploadPopup");
				if(popupData.popupArgs.formatDownload != null && popupData.popupArgs.formatDownload != ''){
					var sampleBtn = $(popupData.popupArgs.formatDownload);

					formatDownload = popupData.popupArgs.formatDownloadFunction;

					var closeBtn = '<div class="btngrid fix mt10 pt10_divider"><div class="btngrid_right" style="padding-bottom: 12px;"><span class="btn_pc"  style="margin-right: 10px" onclick="modalClose()"><spring:message  code="UI_TEXT_BTN_CLOSE" /></span></div></div>';
					$('.pop_wrap').append(closeBtn);
					$("div.btngrid_right").prepend(sampleBtn);
				}else{

					var closeBtn = '<div class="btngrid fix mt10 pt10_divider"><div class="btngrid_right" style="padding-bottom: 12px;"><span class="btn_pc" style="margin-right: 10px" onclick="modalClose()"><spring:message  code="UI_TEXT_BTN_CLOSE" /></span></div></div>';
					$('.pop_wrap').append(closeBtn);
				}

				$('.aui-fileuploader-title-area').css("font-family", "Arial");

				mainView.initUploader(popupData.popupArgs);
				$("input[name=files_nm]").attr('multiple',popupData.popupArgs.multiple);
				$("input[name=files_nm]").attr('accept',popupData.popupArgs.allowTypes);

				$('#getOrder').on('click', function(e) {
					$(ENV.UPLOADER_MAIN).jqxFileUploader('_getFileOrderList');
				});
				/*$(ENV.UPLOADER_MAIN).css("width", "620px");
				 $('.aui-fileuploader-progress-area').css("width", "100%");
				$('.aui-fileuploader-progressbar').css("width", "100%"); */



			});
</script>

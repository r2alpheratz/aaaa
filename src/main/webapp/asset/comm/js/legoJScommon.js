/*
 * Copyright © 2014 Lego Team .. 본 코드는 Lego 팀에서 개발한 공통모듈로 Samsung SDS 내에서 자유롭게
 * 수정 및 확산이 가능하며 기여 또한 가능합니다. homepage : http://70.121.244.190/gitnsam
 *
 */
/**
 * AJAX COMMON
 */
function lego_common_ajax(url, data, _succesFnc, method) {
	if (method == undefined || method == '') {
		method = "POST";
	}
	var _data = {};

	if (data != undefined && _data != '') {
		var _data = JSON.stringify(data);


	} else {
		var _data = JSON.stringify(_data);
	}
	LegoCommonMessage.showLoading();

	$.ajax({
				type : method,
				url : url,
				dataType : "json",
				contentType : "application/json+lego; charset=UTF-8",
				data : _data, // serializes the form's elements.
				success : _succesFnc,
				/***************************************************************
				 * success : function(resultData) {
				 * eval(_succesFnc+"(resultData)"); },
				 **************************************************************/
				error : function(xhr, status, error) {
					console.log('status', status);
					console.log('xhr', xhr);

					if(!xhr.responseText){
						lego_common_alert("Error", "COM_MSG_ERR_998".i18n());
						return;
					}
					if (xhr.status == '405') {
						lego_common_alert("Error", "COM_MSG_ERR_999".i18n());
						return;
					}
					if (xhr.status == '400') {
						lego_common_alert("Error", "COM_MSG_ERR_999".i18n());
						return;
					}
					if (status == 'error') {
						if (!xhr.responseJSON) {
							lego_common_alert("Error", "COM_MSG_ERR_999".i18n());
							return;
						}
						if (xhr.responseJSON.errorcode == 'COM_MSG_ERR_EXPIRED_SESSION') {
							sessionexpired_alert(xhr.responseJSON.errormsg);
							return;
						}
						lego_common_alert("Error", xhr.responseJSON.errormsg);
					}

					else {
						lego_common_alert("Error", "COM_MSG_ERR_999".i18n());
					}
				},
				complete : function() {

					LegoCommonMessage.hideLoading();
				}
			});
}



function sessionexpired_alert(message) {
	lego_common_confirm("Error", message, callback);
	function callback(isConfirmed) {
		if(isConfirmed){
			LegoCommonMessage.showLoading();
			location.href = CONTEXTPATH;
		}

	}
}

function lego_common_alert(title, message, callback) {

	if (callback == '-2000') {
		sessionexpired_alert(title, message);
		return;
	}

	else {
		LegoCommonMessage.alert(title, message, callback);
	}

}

function lego_common_confirm(title, message, desc, callback) {
	LegoCommonMessage.confirm(title, message, desc, callback);
}

function lego_common_succ(title, message, callback) {
	LegoCommonMessage.succ(title, message);
}


function lego_common_dataset_error(pageName, response) {


var	data=response[0].responseJSON;

	if(data.errorcode=="COM_MSG_ERR_EXPIRED_SESSION"){
		sessionexpired_alert(data.errormsg);
	}
	else if (data.errormsg){
		lego_common_alert(pageName, response.errormsg);
	}
	else{
		lego_common_alert(pageName,"COM_MSG_ERR_999".i18n());
	}


}

function destoryAUICompPop() {

	var contentsArray= [
	                    $('#popupContent  div[role^="combobox"]'),
	                     $('#popupContent  div[role^="listbox"]'),
	                     $('#popupContent  div[class^="jqx-editor jqx-widget jqx-rc-all jqx-widget-header"]'),
	                     $('#popupContent  div[aria-owns^="calendarjqxWidge"]'),
	                     $('#popupContent  div[class^="aui-fileuploader-area"]')

	                     ];
	destoryAUI(contentsArray);

}
function destoryAUIComp() {


	var contentsArray= [ $('#contents_area  div[role^="combobox"]'),
	                     $('#contents_area  div[role^="listbox"]'),
	                     $('#contents_area  div[class^="jqx-editor jqx-widget jqx-rc-all jqx-widget-header"]'),
	                     $('#contents_area  div[aria-owns^="calendarjqxWidge"]'),
	                     $('#contents_area  div[id^="jqxtooltip"]')

	                     ];
	destoryAUI(contentsArray);
}
function destoryAUI(contentsArray) {
	  postdestroywidgets = [];
	for (var int = 0; int < contentsArray.length; int++) {
		var contents=contentsArray[int];

		if(!contents ||contents.length==0){
			  continue;
		}

		for (var j = 0; j < contents.length; j++) {
    	 var node = "#"+contents[j].id;
       widgetkey = node;
       chkwidget = $(widgetkey).data();
//      console.log('chkwidget', chkwidget);
       widgetinst = chkwidget ? chkwidget.jqxWidget : null;
       if (widgetinst && (
               widgetinst.widgetName == 'jqxTabs'  ||
               widgetinst.widgetName == 'jqxPanel' ||
               widgetinst.widgetName == 'jqxWindow' ||
               widgetinst.widgetName == 'jqxScrollView'
           )
       ) {

     	  postdestroywidgets.push( widgetinst );
    	  continue;
       }

       if (widgetinst && widgetinst.destroy) {
    //	   console.log("a", widgetinst);
  		  //console.log('contents', contents);
   		  //console.log('d', widgetinst);
     	  widgetinst.destroy();
       }
	}

	}
	  for(var px = 0, pmax = postdestroywidgets.length; px < pmax; px++) {
       widgetinst = postdestroywidgets[px];

       if (widgetinst && widgetinst.destroy) {
           widgetinst.destroy();
       }
   }
   postdestroywidgets.splice( 0, postdestroywidgets.length );

}

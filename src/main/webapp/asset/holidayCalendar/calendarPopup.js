/**
 * 휴일 관리
 *
 * @author 박진영
 * @since: 2015. 8. 26. 오전 10:00:00
 */

debugger;
var holidayEnv = {
	editMode : "ADD", // or “EDIT”
	initModal : "false",
	pageInfo : $("#title01").html()
};


/* 메뉴 페이지 그리드 */
var holidayPageInfoGridEnv = {
	holidayPageInfoGrid : null, // Grid를 생성할 DOM 셀렉터
	holidayPageInfoGridDataSet : null, // Grid에 바인딩할 DataSet 객체
	holidayPageInfoGridColumns : null, // Grid 컬럼 정보
	holidayPageInfoGridBinder : null,
	holidayPageInfoGridSource : null,

	createHolidayPageInfoGridBinder : function() {
		this.holidayPageInfoGridBinder = AUI.createModule('binder', {
			bindmodel : "grid",
			src : this.holidayPageInfoGridDataSet,
			target : "#holidayPageGrid"
		});
	},

	createHolidayPageInfoGridDataSet : function() {
		// DataSet의 API 는 매뉴얼을 참고 바랍니다.
		this.holidayPageInfoGridDataSet = AUI.createModule("dataset", {
			id : "holidayInfoVoList", // dataset type을 사용하는 경우, vo naming과 일치하다록 설정해야 합니다.(README.txt 참고)
			url : CONTEXTPATH + '/searchholidayPageList',
			localmode : false,
			autoload : true,
			reqobject : {
				async : true,
				readtype : AUI.DS_READTYPE.READ_RANGE,
				readindex : 0,
				readcount : 10
			},
			events : [{
				ename : AUI.DS_EVENT.LOADCOMPLETE, // event
													// name
				efunc : function(response) {
				//	alert(response.rowcount);
					  $("#total1_divGrid").text(response.rowcount);
					//BDA_GRID_UTIL.setTreeGridTotalCount(holidayPageInfoGridEnv.holidayPageInfoGridDataSet, "total1_divGrid", "total1_divGrid");
				}
			}, {
				ename : AUI.DS_EVENT.TRANSACTION_ERROR, // event name
				efunc : function(response) {
					lego_common_dataset_error(holidaymgnEnv.pageInfo, response);
				}
			}]
		// DataSet을 Grid에 Binding 후 Server에 요청을 보냅니다.

		});

		this.holidayPageInfoGridDataSet.eventon(AUI.DS_EVENT.TRANSACTION_ERROR, function(request, response) {
			//console.log("LOADCOMPLETE...");
			lego_common_dataset_error(holidaymgnEnv.pageInfo, response);
		});



	},

	createHolidayPageInfoGridColumns : function() {
		this.holidayPageInfoGridColumns = [
		    {
				text : "startDate",
				datafield : 'holidayStDt',
				width : 85,
				align : 'center',
				cellsalign : 'center'
			}, {
				text : "endDate",
				datafield : 'holidayEndDt',
				width : 85,
				align : 'center',
				cellsalign : 'center'
			}, {
				text : "name",
				datafield : 'holidayNm',
				width : 110,
				align : 'center',
				cellsalign : 'center'
			}, {
				text : "description",
				datafield : 'holidayDescription',
				width : 120,
				align : 'center',
				cellsalign : 'center'
			}, {
				text : "holidaySq",
				datafield : 'holidaySq',
				width : 120,
				align : 'center',
				cellsalign : 'center'
			}, {
				text : "countryCd",
				datafield : 'countryCd',
				width : 120,
				align : 'center',
				cellsalign : 'center'
			}, {
				text : "useYn",
				datafield : 'useYn',
				width : 120,
				align : 'center',
				cellsalign : 'center'
			}
		];
	},

	/** 메뉴 페이지 그리드 생성 * */
	createHolidayPageInfoGrid : function() {

		// DataSet, Columns setting
		this.createHolidayPageInfoGridDataSet(); // create dataset object
		this.createHolidayPageInfoGridBinder();
		this.holidayPageInfoGridSource = {
			localdata : this.holidayPageInfoGridBinder,
			datatype : "binder",
			datafields : [ {
				name : 'holidayStDt',
				type : 'string'
			}, {
				name : 'holidayEndDt',
				type : 'string'
			},{
				name : 'holidayNm',
				type : 'string'
			}, {
				name : 'holidayDescription',
				type : 'string'
			},{
				name : 'holidaySq',
				type : 'string'
			}, {
				name : 'countryCd',
				type : 'string'
			},{
				name : 'useYn',
				type : 'string'
			},{
				name : 'serialVersionUID',
				type : 'string'
			},{
				name : 'menuPageSq',
				type : 'string'
			}, {
				name : 'menuSq',
				type : 'string'
			}, {
				name : 'pageType',
				type : 'string'
			}, {
				name : 'pageTypeName',
				type : 'string'
			}, {}, {
				name : 'readYn',
				type : 'string'
			}, {}, {
				name : 'updateYn',
				type : 'string'
			}, {}, {
				name : 'executeYn',
				type : 'string'
			}, {
				name : 'description',
				type : 'string'
			}, {
				name : 'pageUrl',
				type : 'string'
			}, {
				name : 'useYn',
				type : 'string'
			}, {
				name : 'createUsrId',
				type : 'string'
			}, {
				name : 'createDt',
				type : 'date'
			}, {
				name : 'updateUsrId',
				type : 'string'
			}, {
				name : 'updateDt',
				type : 'date'
			}, {
				name : 'messageKey',
				type : 'string'
			}, {
				name : 'holidayYn',
				type : 'string'
			}
			
			
			
			
			
			]
		};

		this.createHolidayPageInfoGridColumns();
		this.holidayPageInfoGrid = $('#holidayGrid').jqxGrid({
				    selectionmode : 'checkbox',
					sortable : false,
					pagermode : 'advanced',
					enabletooltips : true,
					width : '100%',
					height : '120px' ,
					editable : true,
					editmode : 'dblclick',
					source : this.holidayPageInfoGridSource,
					columns : this.holidayPageInfoGridColumns,
					useDatasetPaging : true,
				      columnsresize: true,
				      columnsreorder: true,
					initdspaging : function(pagenum, pagesize, pagetotal,
							totalrowcount) {
						var $pagerDivGrid = $("#pager");
//						console.log("#pagerDivGrid", $pagerDivGrid);
//						console.log(holidayPageInfoGridEnv.holidayPageInfoGrid.outerWidth());
						$pagerDivGrid.closest('div.pager-wrapper').css('width','100%');
						$pagerDivGrid.closest('div.pager-wrapper').css('padding-top','15px');
				//		console.log("#pagetotal", pagetotal);
						$pagerDivGrid.jqxPager({
							totalPages : pagetotal,
							visiblePages : 5,
      						firstTemplate: "<<",
     						lastTemplate: ">>",
     						prevTemplate: "<",
      						nextTemplate: ">"
						}).on(
								'pageChanged',
								function(e) {
													
								var	data = {
											"holidaySq" :$("#holidaySq").val()
										};

//									console.log("pageIndex", e.args.pageIndex);
//									console.log("pageNumber", e.args.page);
									holidayPageInfoGridEnv.holidayPageInfoGrid.jqxGrid('gotodspaging',e.args.pageIndex, {data: data});

								});
					},
					updatedspaging : function(pagenum, oldpagenum, pagesize,
							pagetotal, oldpagetotal, totalrowcount) {

			holidayPageInfoGridEnv.holidayPageInfoGrid.jqxGrid('clearselection');

//						console.log('widget-updatedspaging', arguments);
						$("#pager").jqxPager({
							totalPages : pagetotal
						});
					}
				});

		this.addholidayPageInfoGridEventHandler();

		// 초기 페이지 그리드 (동적 그리드 아니면 필요없음 )

		// $("#pager").closest('div.pager-wrapper').css('width',
		// holidayPageInfoGridEnv.holidayPageInfoGrid.outerWidth()); //Pager 를 그리드
		// width 에 맞게 배치한다. pager 위젯을 감싸고 있는 div 의 width 조정

		// $("#pager").jqxPager({ totalPages: 1, visiblePages: 5 });

	},

	/** 메뉴 페이지 리스트 추가/삭제 * */
	addholidayPageInfoGridEventHandler : function() {
		var self = this;

		$('#btn_rowAdd')
				.on(
						'click',
						function(event) {
							var holidaySq = $('#holidaySq').val();
//							if (!holidaySq) {
//								lego_common_alert(holidaymgnEnv.pageInfo,
//										"UI_MSG_WARN_holiday_PAGE_INSERT_NO_holidaySQ"
//												.i18n());
//								return false;
//							}
//
//							if (!$('#holidayUrl').val()) {
//								lego_common_alert(holidaymgnEnv.pageInfo,
//										"UI_MSG_WARN_holiday_PAGE_INSERT_NO_holidayURL"
//												.i18n());
//								return false;
//							}
							var datarow = { holidayStDt: '', holidayEndDt: '', holidayNm: '',  holidayDescription: '', holidaySq: '',countryCd : '' ,useYn: ''  };
							self.holidayPageInfoGrid.jqxGrid('addRow', null, datarow); // addRow jqxGrid
							  $("#total1_divGrid").text(parseInt($("#total1_divGrid").html()) + 1);
						});

		$('#btn_rowDel').on(
				'click',
				function(event) {
					var holidaySq = $('#holidaySq').val();
					if (!holidaySq) {
						lego_common_alert(holidaymgnEnv.pageInfo,
								"UI_MSG_WARN_holidayMGN_NO_SELECTED_holiday".i18n());
						return false;
					}

					var data =	self.holidayPageInfoGrid.jqxGrid('deleterow',
							self.holidayPageInfoGrid.jqxGrid('getrowid', self.holidayPageInfoGrid.jqxGrid('getselectedrowindex')));

			//		console.log(data);
					if(!data){
						lego_common_alert(holidaymgnEnv.pageInfo, "UI_MSG_WARN_NO_SELECTED_DELETE_DATA".i18n());
						return false;
					}else{
						  $("#total1_divGrid").text(parseInt($("#total1_divGrid").html()) -1);
						//BDA_GRID_UTIL.setGridCount("TOTAL", "total1_divGrid",self.holidayPageInfoGridDataSet.getRowCount());
					}



				});
		/* 메뉴 페이지 정보 저장 */
//		$('#btn_holidayPage_save')
//				.on(
//						'click',
//						function(event) {
//
//
//
//							// 데이터 수정 여부 체크
//							var ifUpated = "false";
//							///삭제해서 0
//
//							if(!(self.holidayPageInfoGridDataSet.getRowCount() ==	 self.holidayPageInfoGridDataSet.getRealRowCount()) ){
//								ifUpated = "true";
//
//							}
//
//							if (ifUpated == "false") {
//							for (var int = 0; int < self.holidayPageInfoGridDataSet.getRowCount(); int++) {
//								var status = self.holidayPageInfoGridDataSet.status(AUI.DS_STATUS.STAT_ROWEDITTYPE, int)
//								//console.log("status"+ status);
//								if (status != 'dstrt_none') {
//									ifUpated = "true";
//									break;
//								}
//							}
//							}
//
//							if (ifUpated == "false") {
//								lego_common_alert(holidaymgnEnv.pageInfo,
//										"UI_MSG_WARN_NO_SAVE_DATA".i18n());
//								return;
//							}
//
//							// 빈값 및 벨리데이션 체크
//							var rows = self.holidayPageInfoGrid.jqxGrid('getrows');
//							for (i = 0; i < rows.length; i++) {
//							//	console.log(rows[i].pageType);
//								if (!isNull(rows[i].pageType)) {
//									// alert("divNm Insert");"[User ID] is
//									// required."
//									lego_common_alert(holidaymgnEnv.pageInfo,
//											"COM_MSG_WARN_COM_REQUIRED".i18n("UI_TEXT_FORM_TYPE".i18n()));
//									return false;
//								}
//								if (!isNull(rows[i].description)) {
//									// if(rows[i].description == null ||
//									// rows[i].description == ""){
//									// alert("useYn Insert");
//									lego_common_alert(holidaymgnEnv.pageInfo,
//											"COM_MSG_WARN_COM_REQUIRED"
//													.i18n("UI_TEXT_FORM_DESCRIPTION"
//															.i18n()));
//									return false;
//								}
//
//								if (!koEngNullNumCheck(rows[i].description)) {
//									// if(rows[i].description == null ||
//									// rows[i].description == ""){
//									// alert("useYn Insert");
//									lego_common_alert(holidaymgnEnv.pageInfo,
//											"UI_MSG_WARN_WRONG_KOENGNULLNUMCHECK"
//													.i18n("UI_TEXT_FORM_DESCRIPTION"
//															.i18n()));
//									return false;
//								}
//
//								if (!isNull(rows[i].pageUrl)) {
//									// alert("useYn Insert");
//									lego_common_alert(holidaymgnEnv.pageInfo,
//											"COM_MSG_WARN_COM_REQUIRED"
//													.i18n("UI_TEXT_FORM_URL"
//															.i18n()));
//									return false;
//								}
//
//								if (!urlCheck(rows[i].pageUrl)) {
//									// alert("useYn Insert");
//									lego_common_alert(holidaymgnEnv.pageInfo,
//											"UI_MSG_WARN_WRONG_URL"
//													.i18n("UI_TEXT_FORM_URL"
//															.i18n()));
//									return false;
//								}
//
//								//
//								if (!isNull(rows[i].useYn)) {
//									// alert("useYn Insert");
//									lego_common_alert(holidaymgnEnv.pageInfo,
//											"COM_MSG_WARN_COM_REQUIRED"
//													.i18n("UI_TEXT_FORM_USABLE"
//															.i18n()));
//									return false;
//								}
//							}
//
//							self.holidayPageInfoGridDataSet
//									.requestTransaction({
//										url : CONTEXTPATH
//												+ '/admin/holidayPageMgn/saveholidayPageList',
//										localmode : false,
//										autoload : true,
//										reqobject : {
//											async : true,
//											readtype : AUI.DS_READTYPE.READ_RANGE,
//											readindex : 0,
//											readcount : 10
//										}}
//									);
//
//
//
//
//							lego_common_succ(holidaymgnEnv.pageInfo,
//									"UI_MSG_SUCC_SAVE".i18n());
//
//					   holidayPageInfoGridEnv.searchholidayPageInfoList($('#holidaySq').val());
//							$("#pager").jqxPager('moveFirstPage', false);
//							//$('#pager').jqxPager('movePage', 1);
//
//						});
	},




	// 메뉴 클릭 시 메뉴 페이지 리스트 조회
	searchholidayPageInfoList : function(holidaySq) {


		this.holidayPageInfoGrid.jqxGrid('clearselection');
	//	$("#pager").jqxPager('moveFirstPage', false);
//		if(!holidaySq){
//			return false;
//
//		}
		data = {
			"holidaySq" : holidaySq
		};
	//	console.log('searchholidayPageInfoList holidaySq', holidaySq);
		holidayPageInfoGridEnv.holidayPageInfoGridDataSet.requestTransaction({
			url : CONTEXTPATH + '/admin/holidayPageMgn/searchholidayPageList',
			data : data,
			localmode: false ,
			autoload : true,
			async: true,
			readtype:AUI.DS_READTYPE.READ_RANGE,
			readindex: 0,
			readcount: 10
		});


		//$("#pager").jqxPager('moveFirstPage', false)
	},

}

function setMediumCategoryCombos(){

	var url = CONTEXTPATH + '/code/searchChildCode';

	var data = {'parentCodeSq' : 'MSG_020000'};



	lego_common_ajax(url, data, function(data) {
		var mediumCategorySource = data;
		var list = new Array;
		var nullVal = { codeNm : "UI_TEXT_LABEL_COMBO_ALL".i18n(), codeValue : ""};
		list.push(nullVal);
		for(i=0; i<mediumCategorySource.length; i++){
			value = { codeNm : mediumCategorySource[i].codeNm , codeValue : mediumCategorySource[i].codeNm};
			list.push(value);
		}


		$("#srchMediumCategoryCombo").jqxComboBox({
			source : list,
			width : 70,
			height : 25,
			dropDownHeight : 40,
			autoDropDownHeight : true,
			displayMember : "codeNm",
			valueMember : "codeValue",
			selectedIndex : 0
		});
		$("#srchMediumCategoryCombo").find('input').attr('readonly', 'readonly');

	});
}

function setSmallCategoryCombos(){

	var url = CONTEXTPATH + '/code/searchChildCode';
	var data = {'parentCodeSq' : 'MSG_030000'};

	lego_common_ajax(url, data, function(data) {
		var smallCategorySource = data;
		var list = new Array;
		var nullVal = { codeNm : "UI_TEXT_LABEL_COMBO_ALL".i18n(), codeValue : ""};
		list.push(nullVal);
		for(i=0; i<smallCategorySource.length; i++){
			value = { codeNm : smallCategorySource[i].codeNm , codeValue : smallCategorySource[i].codeNm};
			list.push(value);
		}


		$("#srchSmallCategoryCombo").jqxComboBox({
			source : list,
			width : 70,
			height : 25,
			dropDownHeight : 40,
			autoDropDownHeight : true,
			displayMember : "codeNm",
			valueMember : "codeValue",
			selectedIndex : 0
		});

		$("#srchSmallCategoryCombo").find('input').attr('readonly', 'readonly');

	});
}

//function searchHolidayList() {
//	holidayGRD.searchHolidayList();
//}

function editHolidayMgnPopup(row) {
	var rowData = BDA_GRID_UTIL.getGridRowData(holidayGRD.holidayGrid, row);
	holidayEnv.editMode = "EDIT";

	var url = CONTEXTPATH + '/admin/holidaymgn/searchHolidayOne'; // the script
	// where you
	// handle the
	// form input.
	var data = {
		"holidayKey" : rowData.holidayKey
	};

	lego_common_ajax(url, data, function(data) {
		// var msg = "MSG_DEL_SUCC".i18n();
		var pageName = "UI_TEXT_LABEL_MESSAGE_MGN".i18n();
		holidayGRD.holidayGrid.jqxGrid('clearselection');

		if (data.holidayKey == null || data.holidayKey == "") {

			lego_common_alert(pageName, "COM_MSG_ERR_ALREADY_DELETED".i18n());

		} else {
			addHolidayPopup(data);

		}
	});
}

function deleteHoliday() {

	var rows = BDA_GRID_UTIL.getSelectedRowIndexes(holidayGRD.holidayGrid);
	if (rows.length > 0) {

		var url = CONTEXTPATH + '/admin/holidaymgn/deleteHoliday';

		var arr = new Array;
		for (i = 0; i < rows.length; i++) {
			var row = rows[i];
			var rowdata = BDA_GRID_UTIL.getGridRowData(holidayGRD.holidayGrid,
					row);

			arr.push(rowdata);

		}

		var pageHeader = "UI_TEXT_LABEL_MESSAGE_MGN".i18n();
		var pageName = "UI_TEXT_LABEL_MESSAGE_MGN".i18n();
		var holiday = "UI_MSG_CON_DELETE".i18n();
		lego_common_confirm(pageHeader, "", holiday, confirmCallback);
		function confirmCallback(isConfirmed) {
			if (isConfirmed) {
				lego_common_ajax(url, arr, function(data) {
					var msg = "UI_MSG_DEL_SAVE".i18n();
					lego_common_succ(pageName, msg);
					holidayGRD.holidayGrid.jqxGrid('clearselection');

					var url = CONTEXTPATH
							+ '/searchHolidayList'; // the
					// script
					// where
					// you
					// handle
					// the
					// form
					// input.
					var data = {
						"srchHolidayKey" : $('#srchHolidayKey').val(),
						"srchHolidayValue" : $('#srchHolidayValue').val(),
						"srchLargeCategoryCd" : $('#srchLargeCategoryCd').val(),
					 	"srchMediumCategoryCd" : $('#srchMediumCategoryCd').val(),
					 	"srchSmallCategoryCd" : $('#srchSmallCategoryCd').val()

					};
					holidayGRD.holidayGridDataSet.requestTransaction({
						url : url,
						data : data,
						readtype : AUI.DS_READTYPE.READ_RANGE,
						readindex : 0,
						readcount : 10
					});
					$('#pagerholiday').jqxPager('movePage', 1);
				});
			}
		}
	} else {
		var pageName = "UI_TEXT_LABEL_MESSAGE_MGN".i18n();
		var msg = "UI_MSG_WARN_SELECTCHECK".i18n();
		lego_common_alert(pageName, msg);
	}
	// }
}

function addHolidayPopup(data) {

	var title = "UI_TEXT_LABEL_ADD_MESSAGE".i18n();
	if (holidayEnv.editMode == "EDIT") {
		title = "UI_TEXT_LABEL_EDIT_MESSAGE".i18n();
	}

	var pop;
	if (LEGO_POPUP.hasPopup('holidayAddPopup')) {
		pop = LEGO_POPUP.getPopup('holidayAddPopup');
	} else {
		pop = LEGO_POPUP.createPopup({
			name : 'holidayAddPopup',
			url : CONTEXTPATH + '/admin/holidaymgn/viewHolidayAddPopup?holidaySq='
					+ $('#currholidaySq').html(),
			title : title,
			width : '600',
//			height : '250',
			popupArgs : {
				popType : holidayEnv.editMode,
				data : data
			},
			closeCallback : function closeCallback() {
				LEGO_POPUP.destroyPopup('holidayAddPopup');
				holidayEnv.editMode = "ADD";
				console.log('closeCallback');
			},
			destroyCallback : function destroyCallback() {
				// GRD_MASTER.onSearch();
				holidayEnv.editMode = "ADD";
				console.log('destroyCallback');
			}
		});
	}
	pop.show();

}

$("#srchHolidayKey, #srchHolidayValue").focusout(function() {
	trim($("#srchHolidayKey"));
	trim($("#srchHolidayValue"));
});

$("#srchHolidayKey").bind("paste", function(e) {
	setTimeout(function() {
		gf_replaceExtraChar($("#srchHolidayKey"));
	}, 100);
});

$("#srchHolidayValue").bind("paste", function(e) {
	setTimeout(function() {
		gf_replaceExtraChar($("#srchHolidayValue"));
	}, 100);
});

$('#srchLargeCategoryCombo').on('select', function (event) {
	var args = event.args;
	var item = $('#srchLargeCategoryCombo').jqxComboBox('getItem', args.index);
	$('#srchLargeCategoryCd').val(item.value);

});

$('#srchMediumCategoryCombo').on('select', function (event) {
	var args = event.args;
	var item = $('#srchMediumCategoryCombo').jqxComboBox('getItem', args.index);
	$('#srchMediumCategoryCd').val(item.value);
});

$('#srchSmallCategoryCombo').on('select', function (event) {
	var args = event.args;
	var item = $('#srchSmallCategoryCombo').jqxComboBox('getItem', args.index);
	$('#srchSmallCategoryCd').val(item.value);
});


$(document).ready(function() {
	holidayPageInfoGridEnv.createHolidayPageInfoGrid();
//	var data = LEGO_POPUP.getPopup("updateholidayPopup").popupArgs['data'];
//	var _strDate; 
//	if(data != null){
//		
//		var yyyy = data.getFullYear().toString();
//	    var mm = (data.getMonth() + 1).toString();
//	    var dd = data.getDate().toString();
//	    
//		_strDate = yyyy + "-"+(mm[1] ? mm : '0'+mm[0]) + "-" +(dd[1] ? dd : '0'+dd[0]);
//	}
//	$('#strtDate').val(_strDate);
//	$('#endDate').val(_strDate);
//	$('#holidayNm').val(data.roleNm);
//	$('#holidayDescription').val(data.description);
	
//	setLargeCategoryCombos();
//	setMediumCategoryCombos();
//	setSmallCategoryCombos();
	//holidayGRD.createHolidayGrid();
	$('.tit70').text("(" + $('#languageCombo').find('input').val() + ")");
	
	    jQuery('.tabs .tab-links a').on('click', function(e)  {
	        var currentAttrValue = jQuery(this).attr('href');
	 
	        // Show/Hide Tabs
	        jQuery('.tabs ' + currentAttrValue).show().siblings().hide();
	 
	        // Change/remove current tab to active
	        jQuery(this).parent('li').addClass('active').siblings().removeClass('active');
	 
	        e.preventDefault();
	    });
});

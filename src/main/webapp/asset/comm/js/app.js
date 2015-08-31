/**
 * 공통 페이지: Leftmenu, Header, footer에 일어나는 동작
 *
 * @author : 이지정
 * @since : 2015. 2. 24. 오전 9:48:44
 */

var commonLayout = {
	_PARAM : []
};

var i18n;

$(document).ready(function() {

	var url = CONTEXTPATH + '/message/selectMessages'; // the script where
	var faro_language = $.cookie("faro_language");
	var data = {
		"largeCategory" : 'UI',
		"language" :faro_language

	};


	// 메시지

	lego_common_ajax(url, data, function(data) {
		var I18NDATA;
		var lang_code;
		/*if (faro_language.toLowerCase() == "en") {
			I18NDATA = {en : data};
			lang_code = "en";
		} else if (faro_language.toLowerCase() == "zh") {
			I18NDATA = {zh : data};
			lang_code = "zh";
		} else if (faro_language.toLowerCase() == "ko" || faro_language == null) {
			I18NDATA = {ko : data};
			lang_code = "ko";
		} else {
			I18NDATA = {ko : data};
			lang_code = "ko";
		}*/
		if (faro_language == null) {
			I18NDATA = {ko : data};
			lang_code = "ko";
		}else{
			
			lang_code = faro_language.toLowerCase();
			var jsonArray = { };
			jsonArray[lang_code] = data;
			I18NDATA = jsonArray;
		}

		i18n = AUI.createModule("i18n", {
			overwrite : true,
			localmode : true,
			data : I18NDATA
		});

		i18n.setLanguage(lang_code);
	 // console.log(LANG);
	});

	if (!(MAIN_PAGE == "Index")) {
		return;

	}
	var url = CONTEXTPATH + '/menu/searchMenuList';

	var data = {"language" :faro_language};


	data = JSON.stringify(data);
	$.ajax({
		type : "POST",
		url : url,
		dataType : "json",
		contentType : "application/json+lego; charset=UTF-8",
		data : data, // serializes the form's elements.
		success : function(ret) {
			var menuTree = ret.menuTree;
			_initMenuTree(menuTree);
			megaMenu._headerMenuOn();

			$("a[name='headMenu']").click(function() {
				$("div.workspace").removeClass("select");
				$("#header .btn_more p").removeClass("selectbtn");
				// $("div[name='workspace']").removeClass("select");
				if ($(this).parent()[0].className == "workspace")
					$(this).parent().addClass("select");
				else
					$(this).parent().addClass("selectbtn");
				var idx = $(this).attr("param");
				megaMenu._lnbOn(menuTree[idx], menuTree[idx].sysCdName, "");
				$("#header .btn_more_layer li").removeClass("select");
				$(".btn_more_layer").hide();
				$.cookie('currentPage', idx);
			});
		},
		complete : function(data) {
			// 통신이 실패했어도 완료가 되었을 때 이 함수를 타게 된다.
			// TODO

			if ($.cookie('currentPage') == null) {
				$("a[name='headMenu']").first().trigger('click');
			} else {
				var id = $.cookie('currentPage');
				$("a[name='headMenu']:eq(" + id + ")").trigger('click');
			}

		},
		error : function(xhr, status, error) {
			if (error == "Method Not Allowed") {
				lego_common_alert("ERROR", "COM_MSG_ERR_999".i18n());
				return;
			}

			lego_common_alert("ERROR", "COM_MSG_ERR_999".i18n());
			// alert(error);

		}
	});

	var _initMenuTree = function(menuTree) {
		megaMenu._menuTree = menuTree;
	};

});

var megaMenu = {
	_menuTree : {},
	_model : "",
	_finalFn : "",
	_headerMenuOn : function() {
		var menuTree = this._menuTree;
		var headMenuCode = "";
		var hasMore = false;
		var topMenuNum = menuTree.length;

		for (var i = 0; i < menuTree.length; i++) {
			if (topMenuNum > 6 && i >= 5) {
				hasMore = true;
				break;
			}

			headMenuCode += '<div class="workspace"  >'
					+ "\n"
					+ '<a id="headMenu" name="headMenu" class="headMenu" param='
					+ '\"' + i + '\" href="#none">' + menuTree[i].menuNm
					+ '</a>' + "\n" + '</div>' + "\n";

		//	console.log(headMenuCode);

		}
		if (hasMore) {
			headMenuCode += '<div class="btn_more"  >'
					+ "\n"
					+ '<p class="selectbtn">'
					// + '<a href="#">'
					+ '<a id="headMenu" name="headMenu" param='
					+ '\"'
					+ 5
					+ '\" href="#">'
					+ menuTree[5].menuNm
					+ '<span>'
					+ menuTree[5].menuNm
					+ '</span>'

					+ '</a>'
					+ '</p>'
					+ '<div class="btn_more_layer" style="display: none;">'
					+ "\n"
					+ '<ul>'
					+ '<li class="select">'

					+ '<a id="headMenu" name="headMenu" class="headMenu" param='
					+ '\"' + 5 + '\" href="#none" style="width:100px">'
					+ menuTree[5].menuNm + '</a>' + "\n" + '</li>';
			for (var i = 6; i < menuTree.length; i++) {
				headMenuCode += '<li>'
						+ '<a id="headMenu" name="headMenu" class="headMenu" param='
						+ '\"' + i + '\" href="#none">' + menuTree[i].menuNm
						+ '</a>' + "\n" + '</li>';
			}
			headMenuCode += '</ul>' + "\n" + '</div>' + "\n" + '</div>' + "\n";
		}

		// var $headCode = $(headMenuCode);

		$('#header div.gnbinner').html(headMenuCode);



		var btn = $("<img src='comm/img/arrow_header.png'>").click(function(e) {
			e.preventDefault();
			e.stopPropagation();
			if (!$(".btn_more_layer").is(":visible")) {
				$(".btn_more_layer").show();
			} else {
				$(".btn_more_layer").hide();
			}
		}).attr("style",
				"cursor:pointer; padding:5px 5px 4px 5px; margin-left:5px");

		var $btn_more = $("#header .btn_more p a");
		$btn_more.append(btn);
		$btn_more.off("click");
		$btn_more.on("click", function(e) {
			$(".gnbinner li").removeClass("select");
			$("div.workspace").removeClass("select");
			$("#header .btn_more p").addClass("selectbtn");
			// $(".gnbinner li [data-rscid=" + rscId +
			// "]").parent().addClass("select");

			var idx = $btn_more.attr("param");
			megaMenu._lnbOn(menuTree[idx], menuTree[idx].sysCdName, "");
			// _me.loadMenu(rscId);
		});

		$("#header .btn_more_layer li")
				.click(
						function(e) {
							e.preventDefault();
							e.stopPropagation();
							$("#header .btn_more p").addClass("selectbtn");
							var rscNm = $(this).text().replace("\n", "");
							var rscId = $(this).find("a").attr("param");
							// _setBtnMore(rscNm,rscId);
							var $btn_more = $("#header .btn_more p a");
							$btn_more.empty();
							$btn_more.append(rscNm).append(
									"<span>" + rscNm + "</span>");
							$(".gnbinner li [param=" + rscId + "]").parent()
									.addClass("select");

							var btn = $("<img src='comm/img/arrow_header.png'>")
									.click(
											function(e) {
												e.preventDefault();
												e.stopPropagation();
												if (!$(".btn_more_layer").is(
														":visible")) {
													$(".btn_more_layer").show();
												} else {
													$(".btn_more_layer").hide();
												}
											})
									.attr("style",
											"cursor:pointer; padding:5px 5px 4px 5px; margin-left:5px");

							var $btn_more = $("#header .btn_more p a");
							$btn_more.append(btn);
							$btn_more.off("click");
							$btn_more.on("click", function(e) {
								$(".gnbinner li").removeClass("select");
								$("div.workspace").removeClass("select");
								$("#header .btn_more p").addClass("selectbtn");
								// $(".gnbinner li [data-rscid=" + rscId +
								// "]").parent().addClass("select");

								$("#header .btn_more p").addClass("selectbtn");
								// _me.loadMenu(rscId);
								megaMenu._lnbOn(menuTree[rscId],
										menuTree[rscId].sysCdName, "");

							});

							// $("#header .btn_more
							// p").removeClass("selectbtn");
							$(".btn_more_layer").hide();
						});
	},
	_lnbOn : function(model, sysCd, defaultPage) {
		var _me = this;
		if (location.hash && !(location.hash == "#none")) {
			loadHashUrl();
		}

		$("#contanier").css("marginTop", "0px");
		$('#contanier div.leftmenu').show();
		$('#contanier div.leftmenu').css("left", "0px");
		$("#content").css("padding-left", "207px"); // 2014-09-26 189->190

		$('#contanier div.leftmenu').html("");
		_me._gnbScrnTcd = "C";

		// menuLnb.bindModel(model, _me._lnbOption.callbackFn);
		menuLnb.bindModel(model, LnbAction);



	},
	bindModel : function(data, callbackFn) {
		this._finalFn = callbackFn;
		this._setModel(data);
	},
	_setModel : function(data) {
		this._model = data;

		this._drawSubmenus();
	},
	_drawSubmenus : function() {
		// depth-0
		var depth0 = this._model;
		var _data_group_ = ' data-group=' + '\"' + depth0.menuSq + '\"';
		var submenu = "";
		submenu += "\t" + '<div class="submenu" style="display:none;"'
				+ _data_group_ + '>' + "\n";

		// depth1
		submenu += "\t\t" + '<ul class="fix">' + "\n";
		// depth-1
		for ( var obj0 in depth0.children) {
			if (!depth0.children[obj0].menuNm) {
				continue;
			}
			;
			submenu += '\t\t\t'
					+ '<li class="depth2_menu">'
					+ /* this._getLinkPath(depth0.children[obj0]) */"<a style='cursor:default'>"
					+ depth0.children[obj0].menuNm + "</a>" + '</li>' + "\n";

			// depth2:menu
		}
		submenu += "\t\t" + '</ul>' + "\n";
		submenu += "\t"
				+ '<div class="sub_submenu_wrap_group" style="margin-left:207px;"></div></div>'
				+ "\n";

		var $submenu = $(submenu);
		var submenu_obj = $('div.submenus').html($submenu);
		// LOOP 가 아닌 사용자가 원하는 위치에 붙이기 위해 append 를 쓰고 부득이하게 for 를 한번 더 ...

		var sub_submenu_wrap = "";
		for ( var obj0 in depth0.children) {
			if (!depth0.children[obj0].menuNm) {
				continue;
			}
			;

			sub_submenu_wrap += '\t\t' + '<div class="sub_submenu_wrap fix">'
					+ '\n';
			var sub_submenu_wrap_2arr = new Array();
			sub_submenu_wrap_2arr[0] = new Array();
			sub_submenu_wrap_2arr[1] = new Array();
			sub_submenu_wrap_2arr[2] = new Array();

			var depth1 = depth0.children[obj0];

			for ( var obj1 in depth1.children) {
				if (!depth1.children[obj1].splitId) {
					continue;
				}
				;

				var target = sub_submenu_wrap_2arr[Number(depth1.children[obj1].splitId - 1)][Number(depth1.children[obj1].splitOrdb)] = {};
				// depth3 info arr
				target.param = depth1.children[obj1].param;
				target.menuNm = depth1.children[obj1].menuNm;
				target.menuUrl = depth1.children[obj1].menuUrl;
				target.menuSq = depth1.children[obj1].menuSq;
				target.childHtml = "";

				if (typeof (depth1.children[obj1].children) != "undefined"
						&& depth1.children[obj1].children.length > 0) {
					var depth2 = depth1.children[obj1];
					var depth3_html = "";
					for ( var obj2 in depth2.children) {
						if (typeof (depth2.children[obj2].menuNm) != "string") {
							continue;
						}
						;
						depth3_html += '\t\t\t\t' + '<li>'
								+ this._getLinkPath(depth2.children[obj2])
								+ "\n";
						// depth4[S]
						if (typeof (depth2.children[obj2].children) != "undefined"
								&& depth2.children[obj2].children.length > 0) {
							var depth3 = depth2.children[obj2];
							var depth4_html = "";
							for ( var obj3 in depth3.children) {
								if (typeof (depth3.children[obj3].menuNm) != "string") {
									continue;
								}
								;
								depth4_html += '\t\t\t\t\t\t'
										+ "<li>"
										+ this
												._getLinkPath(depth3.children[obj3])
										+ "</li>" + "\n";
								// depth5
							}
							if (depth4_html != "") {
								depth3_html += '\t\t\t\t'
										+ '<ul class="depth5">' + depth4_html
										+ '</ul>' + "\n";
							}
						}
						depth3_html += '\t\t\t\t' + '</li>' + "\n";
						// depth4[E]
					}

					if (depth3_html != "") {
						target.childHtml += '\t\t\t' + "<ul>" + depth3_html
								+ "</ul>" + "\n";
					}
				}
			}

			for (var i = 0; i < sub_submenu_wrap_2arr.length; i++) {
				if (sub_submenu_wrap_2arr[i]
						&& sub_submenu_wrap_2arr[i].length > 0) {
					sub_submenu_wrap += '\t\t\t' + '<div class="sub_submenu">'
							+ '\n';
					for (var j = 0; j < sub_submenu_wrap_2arr[i].length; j++) {
						if (sub_submenu_wrap_2arr[i][j]) {
							if (typeof (sub_submenu_wrap_2arr[i][j].menuNm) != "string") {
								continue;
							}
							;
							sub_submenu_wrap += '\t\t\t\t'
									+ '<div class="sub_submenu_depth3_group">'
									+ '\n';
							if (typeof (sub_submenu_wrap_2arr[i][j].menuUrl) == "string"
									&& sub_submenu_wrap_2arr[i][j].menuUrl != "") {
								sub_submenu_wrap += '\t\t\t\t\t'
										+ '<strong>'
										+ this._getLinkPath(
												sub_submenu_wrap_2arr[i][j],
												true) + '</strong>' + '\n';
							} else {
								sub_submenu_wrap += '\t\t\t\t\t' + '<strong>'
										+ sub_submenu_wrap_2arr[i][j].menuNm
										+ '</strong>' + '\n';
							}
							if (sub_submenu_wrap_2arr[i][j].childHtml != "") {
								sub_submenu_wrap += '\t\t\t\t\t\t'
										+ sub_submenu_wrap_2arr[i][j].childHtml
										+ '\n';
							}
							sub_submenu_wrap += '\t\t\t\t' + '</div>' + '\n';
						}
					}
					sub_submenu_wrap += '\t\t\t' + '</div>' + '\n';
				}
			}
			sub_submenu_wrap += '\t\t' + '</div>' + '\n';
		}
		$sub_submenu_wrap = $(sub_submenu_wrap);
		$submenu.find("div.sub_submenu_wrap_group").append($sub_submenu_wrap);
		this._finalAction();
	},



	_finalAction : function() {
		this._finalFn();
	}
};

var menuLnb = {
	RootTitle : "",
	_model : "",
	_finalFn : "",
	hashUrlMenuId : "",
	bindModel : function(model, callbackFn) {
		this._model = model;
		this._finalFn = callbackFn;
	this._drawContainer();
	},
	_drawContainer : function() {
		var tree = this._model;

		this.RootTitle = tree.menuNm;
		var lnb = '';
		// .leftmenu
		lnb += '\t' + '<div class="titbox">' + '\n';
		lnb += '\t\t'
				+ '<h3 class="menutit" style="margin-top : 0px;margin-bottom : 0px">'
				+ this.RootTitle + '</h3>' + '\n';
		lnb += '\t' + '</div>' + '\n';
		lnb += '\t' + '<div class="bgarea">' + '\n';
		lnb += '\t\t'
				+ '<a href="#none" class="menubtn"><img src="'
				+ CONTEXTPATH
				+ '/comm/opusstyle/img/common/btn_left_menu.png" alt="닫기" /></a>'
				+ '\n';
		lnb += '\t' + '</div>' + '\n';
		lnb += '\t' + '<div class="scarea"><ul class="treeDepth01">' + '\n';

		var depth1 = tree.children;

		for ( var obj1 in depth1) {
			if (!depth1[obj1].menuNm) {
				continue;
			};

			lnb += this._getLinkPath(depth1[obj1], 1);


			var depth2 = depth1[obj1].children;

//			if (depth2 && depth2.length > 0)
			lnb += this._getTabLine(2).ul + '<ul class="treeDepth02">'
					+ '\n';

			for ( var obj2 in depth2) {

				if (!depth2[obj2].menuNm) {
					continue;
				}
				;

				// depth2[obj2]
				lnb += this._getLinkPath(depth2[obj2], 2);

				var depth3 = depth2[obj2].children;

				if (depth3 && depth3.length > 0)
					lnb += this._getTabLine(3).ul + '<ul class="treeDepth03">'
							+ '\n';

				for ( var obj3 in depth3) {
					if (!depth3[obj3].menuNm) {
						continue;
					}
					;

					// depth3[obj3];
					lnb += this._getLinkPath(depth3[obj3], 3);

					var depth4 = depth3[obj3].children;

					if (depth4 && depth4.length > 0)
						lnb += this._getTabLine(4).ul
								+ '<ul class="treeDepth04">' + '\n';

					for ( var obj4 in depth4) {
						if (!depth4[obj4].menuNm) {
							continue;
						}
						;

						// depth4[obj4];
						lnb += this._getLinkPath(depth4[obj4], 4);

						var depth5 = depth4[obj4].children;

						if (depth5 && depth5.length > 0)
							lnb += this._getTabLine(5).ul
									+ '<ul class="treeDepth05">' + '\n';

						for ( var obj5 in depth5) {
							if (!depth5[obj5].menuNm) {
								continue;
							}
							;

							// depth5[obj5];
							lnb += this._getLinkPath(depth5[obj5], 5);

							lnb += this._getTabLine(5).li + '</li>' + '\n';

						}

						if (depth5 && depth5.length > 0)
							lnb += this._getTabLine(5).ul + '</ul>' + '\n';

						lnb += this._getTabLine(4).li + '</li>' + '\n';
					}

					if (depth4 && depth4.length > 0)
						lnb += this._getTabLine(4).ul + '</ul>' + '\n';

					lnb += this._getTabLine(3).li + '</li>' + '\n';

				}

				if (depth3 && depth3.length > 0)
					lnb += this._getTabLine(3).ul + '</ul>' + '\n';

				lnb += this._getTabLine(2).li + '</li>' + '\n';

			}

//			if (depth2 && depth2.length > 0)
			lnb += this._getTabLine(2).ul + '</ul>' + '\n';

			lnb += this._getTabLine(1).li + '</li>' + '\n';

		}

		lnb += '\t' + '</ul></div>' + '\n';
		lnb += '' + '\n';
		// .leftmenu

		$('div.leftmenu').html(lnb);

		this._finalAction();
	},
	_getLinkPath : function(obj, tree) {

		var tabLine = this._getTabLine(tree);

		var xTemplate = "", rStr = "";

		xTemplate += tabLine.li + '<li>' + '\n';

		var depthCls = "depth0" + String(tree);

		var divCls = "nodepth";

		if (obj.menuUrl && obj.menuUrl != "") {
			if (tree >= 5)
				divCls = depthCls;

			rStr = tabLine.div + xTemplate + '<div class="' + divCls + '">'
					+ this._getLinkTag(obj) + '</div>' + '\n';

		} else {
			xTemplate = tabLine.div + xTemplate + '<div class="' + depthCls
					+ '"><a href="#none" class="branch">{:menuNm:}</a></div>'
					+ '\n';
			rStr = xTemplate.replace(/{:menuNm:}/gi, obj.menuNm);

		}

		return rStr;

	},
	_getLinkTag : function(obj) {

		var xTemplate = "", rStr = "";

		xTemplate = '<a id=\'lnb'
				+ obj.menuSq
				+ '\' href="javascript:menuLnb.loadBasic(\'{:MENUID:}\', \'{:MENUURL:}\', \'{:MENUNM:}\',\'{:PARAM:}\')" class="useLink">{:MENUNM:}</a>';
		rStr = xTemplate.replace("{:MENUID:}", obj.menuSq);
		rStr = rStr.replace("{:MENUURL:}", obj.menuUrl);
		rStr = rStr.replace(/{:MENUNM:}/gi, obj.menuNm);
		if (obj.menuParamVal && obj.menuParamVal != undefined) {
			rStr = rStr.replace("{:PARAM:}", obj.menuParamVal);
		} else {
			rStr = rStr.replace(",\'{:PARAM:}\'", '');
		}
		if (obj.menuUrl == location.hash.replace("#", "")) {
//			console.log(location.hash, obj.menuSq);
			// //TODO
			this.hashUrlMenuId = obj.menuSq;

		}

		return rStr;

	},


	loadBasic : function(menuSq, menuUrl, menuNm, param) {

        destoryAUIComp();
		// clear interval
		if (my_global.intID != null && my_global.intID != ""
				&& typeof my_global.intID != "undefined") {
			clearInterval(my_global.intID);
			my_global.intID = null;
		}

		var url = menuUrl + "?menuSq=" + menuSq;

		location.hash = url;

		var data = {};

		var paramJson = {};
		if (param && param != '' && param != undefined && param != 'undefined') {
			var parameter = param;
			var paramArr = parameter.split(',');
			for (var k = 0; k < paramArr.length; k++) {
				var paramSplit = paramArr[k].split('=');
				paramJson[paramSplit[0]] = paramSplit[1];
			}

			var _parent = this;
			// _parent.activeStatus($('.leftmenu #lnb' + menuSq), 0);
			menuLnb._activeStatus($('.leftmenu #lnb' + menuSq), 0);
			data = JSON.stringify(paramJson);

			commonLayout._PARAM["LNB_" + menuSq] = data;

		} else {
			data = JSON.stringify(data);
		}

		$.ajax({
			type : "GET",
			url : url,
			dataType : "text",
			contentType : "application/json+lego; charset=UTF-8",
			data : data, // serializes the form's elements.
			success : function(ret) {
				if ($('#contents_area').find('.jqx-grid').length > 0) {
					$('#contents_area').find('.jqx-grid').jqxGrid('destroy');
				}

				var superPrntNm = ' ';
				var parentMenuNm = ' ';
				
				var param = {};
				param.menuSq = menuSq;
				param.menuUrl = menuUrl;
				
				$.ajax({
					// 요청할URL
					url : CONTEXTPATH + '/locationInfomation',
					data : JSON.stringify(param),
					type : "POST",
					async : true,
					dataType : "json",
					contentType : "application/json",
					success : function(json) {
						superPrntNm = json.menuMgnVo.superPrntNm;
						parentMenuNm = json.menuMgnVo.parentMenuNm;
						$('#locationinfo dt strong').parent().prev("dt").text(parentMenuNm).prev("dt").text(superPrntNm);
					},
					error : function(xhr, status, err) {
						initWindow.window_message_popup(error.msg);
					},
					complete : function(xhr, status) {
					}			
				});
				
				var location =
					  '<div class="depthbox1 fix mt25">'
					+ '	<h1 id="title01">' + menuNm + '</h1>'
					+ '	<div class="dir_align">'
					+ '		<div id="currMenuSq" hidden="true" style="display:none">' + menuSq + '</div>'
					+ '		<dl class="fix" id="locationinfo">'
					+ '			<dt style="font-weight: normal;">' + superPrntNm + '</dt>'
					+ '			<dt style="font-weight: normal;">' + parentMenuNm + '</dt>'
					+ '			<dt>'
					+ '				<strong>' + menuNm + '</strong>'
					+ '			</dt>'
					+ '		</dl>'
					+ '	</div>'
					+ '</div>'
					;
				$('#content div.contents_area').html(location + ret); 
				

//				$('#content div.contents_area').html(ret);



				$("#contents_area").show();
			},
			complete : function(data) {

				// 통신이 실패했어도 완료가 되었을 때 이 함수를 타게 된다.
				// TODO
			},
			error : function(xhr, status, error) {
			//	console.log('xhr.responseText', xhr.responseText);
			//	console.log('xhr.responseText.errormsg', xhr.responseText.errormsg);
				var responseText=$.parseJSON(xhr.responseText);
			//	console.log('responseText', responseText.errormsg);

				if(responseText){
					lego_common_alert("ERROR", responseText.errormsg);
					return;
				}

				lego_common_alert("ERROR", "COM_MSG_ERR_999".i18n());
			}
		});

	},
	_getTabLine : function(tree) {
		var size = new Array();
		size = tree * 2;
		var rObj = {};
		rObj.li = "";
		rObj.div = "";
		rObj.ul = "";
		for (var i = 0; i < size; i++) {
			rObj.li += "\t";
		}

		rObj.div = rObj.li + "\t";
		rObj.ul = rObj.li.replace("\t", "");

		return rObj;
	},
	_finalAction : function() {
		this._finalFn();
	},

	_activeStatus : function($el, tc) {
		var count = tc;
		if (count == 0) {

			var active = false;
			var spread = false;
			var nodepth = false;
			var depth01 = false;
			if ($el.hasClass("active")) active = true;
			if ($el.hasClass("spread")) spread = true;
			if ($el.parent().hasClass("nodepth")) nodepth = true;
			if ($el.parent().hasClass("depth01")) depth01 = true;

			if (nodepth) {

				$('.leftmenu .nodepth>a.active').removeClass("active");
				$('.leftmenu .depth01>a.active').removeClass("active").addClass("spread");
				$el.closest('.treeDepth01>li').find('.depth01>a').removeClass("spread").addClass("active");
				//console.log('$el', $el);
				//console.log("$el.closest('.treeDepth01>li')", $el.closest('.treeDepth01>li'));
				//console.log("$el.closest('.treeDepth01>li').find('.depth01>a')", $el.closest('.treeDepth01>li').find('.depth01>a'));
				if (active) {
					$el.removeClass("active");
				} else {
					$el.addClass("active");
				}

			}


			if (depth01) {
				if (active) {
					$el.removeClass("active");
				} else if (spread) {
					$el.removeClass("spread");

				} else {
					$('.leftmenu .depth01>a.active').removeClass("active").removeClass("spread");
					$el.addClass("active");

				}
			}

		}
		count++;

		if (!$el.get(0))
			return;
		if ($el.get(0).tagName == "UL") {
			if (typeof ($el.prev().get(0)) === "object"
					&& $el.prev().get(0).tagName == "DIV") {
				$el.prev().children("a").addClass("active");
			}
		}
		$parent = $el.parent();

		if ($el.hasClass("treeDepth01")) {
			return null;
		} else {
			return this._activeStatus($parent, count);
		}
	}
};

function getQueryStringData(name) {
	var result = null;
	var regexS = "[\\?&#]" + name + "=([^&#]*)";
	var regex = new RegExp(regexS);
	var results = regex.exec('?' + window.location.href.split('?')[1]);
	if (results != null) {
		result = decodeURIComponent(results[1].replace(/\+/g, " "));
	}
	return result;
}

function loadHashUrl() {
	url = location.hash.replace("#", "");
	$.ajax({
		type : "GET",
		url : url,
		dataType : "text",
		contentType : "application/json+lego; charset=UTF-8",
		success : function(ret) {
			// 페이지를 새로 고침하면 여기가 두번 호출되는 것이 문제
			// 두번째 호출 시에는 바로 리턴되도록 처리
			if ($('#contents_area').find('.jqx-grid').length) {
				return;
			}
			
			var menuNm = ' ';
			var menuSq = getQueryStringData('menuSq');

			var superPrntNm = ' ';
			var parentMenuNm = ' ';
			
			var param = {};
			param.menuSq = menuSq;
			param.menuUrl = url.split("?")[0];
			
			$.ajax({
				// 요청할URL
				url : CONTEXTPATH + '/locationInfomation',
				data : JSON.stringify(param),
				type : "POST",
				async : true,
				dataType : "json",
				contentType : "application/json",
				success : function(json) {
					superPrntNm = json.menuMgnVo.superPrntNm;
					parentMenuNm = json.menuMgnVo.parentMenuNm;
					menuNm = json.menuMgnVo.menuNm;
					
					$('#title01').text(menuNm);
					$('#locationinfo dt strong').text(menuNm).parent().prev("dt").text(parentMenuNm).prev("dt").text(superPrntNm);
				},
				error : function(xhr, status, err) {
					initWindow.window_message_popup(error.msg);
				},
				complete : function(xhr, status) {

				}			
			});
			
			var location =
				  '<div class="depthbox1 fix mt25">'
				+ '	<h1 id="title01">' + menuNm + '</h1>'
				+ '	<div class="dir_align">'
				+ '		<div id="currMenuSq" hidden="true" style="display:none">' + menuSq + '</div>'
				+ '		<dl class="fix" id="locationinfo">'
				+ '			<dt style="font-weight: normal;">' + superPrntNm + '</dt>'
				+ '			<dt style="font-weight: normal;">' + parentMenuNm + '</dt>'
				+ '			<dt>'
				+ '				<strong>' + menuNm + '</strong>'
				+ '			</dt>'
				+ '		</dl>'
				+ '	</div>'
				+ '</div>'
				;
			
			$('#content div.contents_area').html(location + ret);
			
//			$('#content div.contents_area').html(ret);
			if ($('.leftmenu #lnb' + menuLnb.hashUrlPrntMenuId)) {
				menuLnb._activeStatus($('.leftmenu #lnb'
						+ menuLnb.hashUrlMenuId), 0);
				$('.leftmenu #lnb' + menuLnb.hashUrlMenuId).parent().parent()
						.parent().css("display", "block");
			}
			$("#contents_area").show();

		},
		error : function(xhr, status, error) {
			location.href = CONTEXTPATH + "/index";
		}
	});

}

function LnbAction() {
	var _parent = this;
	$('.menubtn')
			.click(
					function() {
						var conHei = $('#contanier').outerHeight();
						// content 의 height 값
						var mL01 = -$('.leftmenu').width() + 15 + 'px';
						if ($('.bgarea').hasClass('btnbg')) {
							$(this).parent().css({
								'width' : 'auto',
								'background' : 'transparent',
								zIndex : '0'
							});
							$('.leftmenu').animate({
								left : '0'
							}, 200);
							$('#content').animate({
								'padding-left' : '207px' // 2014-09-24
															// 189->190
							}, {
								duration : 200,
								complete : function() {
									$('.jqx-grid').trigger('resize');
								}
							});
							// change class 2014-05-23 kdm
							$(this)
									.find('img')
									.attr(
											{
												'src' : CONTEXTPATH
														+ '/comm/opusstyle/img/common/btn_left_menu.png',
												'alt' : '닫기'
											});
							$(this).parents('.leftmenu').find('ul').css(
									'overflow', 'auto');
							$('.leftmenu .titbox').css('background', '#fff');
							$('.bgarea').removeClass('btnbg');
							$(this).css({
								'right' : '0',
								'top' : '0'
							});

						} else {
							$(this).parent().css({
								'width' : '10px',
								'background' : '#fff',
								zIndex : '1'
							});
							$('.leftmenu').animate({
								left : '-197'
							}, 200);
							$('.bgarea').css('height', conHei)
									.addClass('btnbg');
							$('#content').animate({
								'padding-left' : '0px'
							}, {
								duration : 200,
								complete : function() {
									$('.jqx-grid').trigger('resize');
								}
							});
							// change class 2014-05-23 kdm
							$(this)
									.find('img')
									.attr(
											{
												'src' : CONTEXTPATH
														+ '/comm/opusstyle/img/common/btn_left_menu_open.png',
												'alt' : '열기'
											});
							// change gif 2014-05-16 park
							$(this).parents('.leftmenu').find('ul').css(
									'overflow', 'hidden');
							$('.leftmenu .titbox').css('background', '#fff');
							$(this).css({
								// 'right' : '-16px',
								'top' : '0px'
							});


						}
					});

	$('.leftmenu .treeDepth01 a.branch').click(function() {
		var children = $(this).parent().next("ul");
		var otherChildren =  $('.leftmenu .treeDepth02');

		if ($(".treeDepth01").hasClass("preventclick")) { // 애니메이션중 클릭방지!
			return;
		}
		if (children.is(":hidden")) {
			$(".treeDepth01").addClass("preventclick");
			otherChildren.slideUp(function() {
				_parent.isTreeDepthScrollBar();
				$(".treeDepth01").removeClass("preventclick");
			});
			children.slideDown(function() {
				_parent.isTreeDepthScrollBar();
				$(".treeDepth01").removeClass("preventclick");
			});

		}else {
			$(".treeDepth01").addClass("preventclick");
			children.slideUp(function() {
				_parent.isTreeDepthScrollBar();
				$(".treeDepth01").removeClass("preventclick");
			});
		}
		menuLnb._activeStatus($(this), 0);
		// _parent.activeStatus($(this), 0);
	});

	$('.leftmenu a.useLink').click(function() {
		menuLnb._activeStatus($(this), 0);
		// _parent.activeStatus($(this), 0);
	});


	$('.leftmenu').css('height',
			$('#wrap').height() - $('#header').height() - 1);

	window.setTimeout(function() {
		$(window).resize(function() {

			_parent.isTreeDepthScrollBar();

			var bodyWidth = $(document.body).width();
			var bodyHeight = $(document.body).height();
			var wrapWidth = $('#wrap').width();
			var wrapHeight = $('#wrap').height()
			var popLeft =  $('#wrap').width()/2 - $('#popup').width()/2;
			var contents_area = $('#contents_area').width();
			var mainGridWidth = $('#mainGrid').width();
			var popupContent = $('#popupContent').width();

			$('.leftmenu').css('height',
					$('#wrap').height() - $('#header').height() - 1);

			$('#screenPopup').css('width', bodyWidth);
			$('#screenPopup').css('height', bodyHeight);




			$('#popup').css('left',popLeft);

			$('.pager-wrapper').css('width',contents_area);
			$('#popup .pager-wrapper').css('width',popupContent);
			$('.mt20 .pager-wrapper').css('width',mainGridWidth);

			$('#faro_screen').css('height', wrapHeight);

		}).scroll(function() {
			/*
			 * $('.leftmenu').css( 'height', String($(window).height() -
			 * $('#header').height() - 1) + "px");
			 */
			_parent.isTreeDepthScrollBar();
		});
	}, 1000);
	/*
	 *
	 * $('.accordionDepth01 > li > .depth01').click(function() {// �꾩퐫�붿뼵 醫뚯륫硫붾돱
	 * var idx = $('.accordionDepth01 > li > .depth01').index(this);
	 *
	 * if ($(this).hasClass('on')) { $('.accordionDepth02').eq(idx).slideUp();
	 * $('.accordionDepth01 > li > a').removeClass('active');
	 * $(this).removeClass('on'); $(this).find('a').removeClass('active');
	 * $('.accordionDepth01 > li').eq(idx).find('a').removeClass('active');
	 * $('.accordionDepth01 > li').eq(idx).find('ul').slideUp(); } else {
	 * $('.accordionDepth02').eq(idx).slideDown();
	 * $(this).find('a').addClass('active'); $(this).addClass('on'); } });
	 */

	this.isTreeDepthScrollBar = function() {
		var ns = {
			scarea : "div.leftmenu div.scarea",
			target : "ul.treeDepth01",
			area : "div.leftmenu",
			xareas : [ {
				obj : "div.titbox"
			} ]
		};

		var wrh = Number($(ns.area).height());

		var xh = 0;

		for (var i = 0; i < ns.xareas.length; i++) {
			xh += Number($(ns.xareas[i].obj).height());

		}
		var ah = wrh - xh;
		// /정확하지않은 높이로인해 lnb높이가 이상해짐: 재현방법을 못찾겠다
		var tah = Number($(ns.target).height());

		if (Number(tah) + 10 > ah) {
			$(ns.scarea).height(String(ah + "px"));
			if ($(ns.scarea).data("isscrollcustom") != "true") {
				$(ns.scarea).data("isscrollcustom", "true");
				$(ns.scarea).mCustomScrollbar({
					scrollButtons : {
						enable : false
					}
				});
			}
			// $(ns.scarea).mCustomScrollbar("update");
		} else {
			if ($(ns.scarea).data("isscrollcustom") == "true") {
				// $(ns.scarea).mCustomScrollbar("disable", true);
			}

			// $(ns.scarea).mCustomScrollbar("update");
		}

	};

}

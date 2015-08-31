/**
 * UI 메시지 처리 관련 API
 */

(function(window) {
	var wrapWidth = $("body div:first-child").width();
	var wrapHeight = $("body div:first-child").height();

	//var testParent =$(opener.document).find("#wrap").val("width");

	//console.log("testParent: ", testParent)

	if(!$('#wrap').width()){
		wrapWidth = '100%';
		wrapHeight = '100%';
	}
	var _Faro_Message = {
			verifyType: function(object, type){
				if(Object.prototype.toString.call(type) !== "[object String]"){
					throw "type has to be a string";
				}

				if(type === ""){
					throw "type can't be null string";
				}

				type = type.replace(/^[a-z]/, type[0].toUpperCase());

				return Object.prototype.toString.call(object) === "[object " + type + "]";
			},
		CSS_MAP : {
			MARGIN_RIGHT_5PX : "mr5",
			MARGIN_CENTER_5PX : "mc5",
			//MARGIN_TOP_5PX : "mt5",
			TEXT_CENTER_ALIGN : "tC"
		},
		POPUP_CSS_MAP : {
			POPUP_WRAPPER : "pop_wrap",
			POPUP_HEADER : "pop_haeder",
			POPUP_CONTENT : "pop_cont",
			POPUP_MESSAGE_TITLE : "message_txt",
			POPUP_MESSAGE_CONTENT : "message_cont",
			POPUP_X_BUTTON : "close",
			POPUP_MESSAGE_AREA : "message_area",
			POPUP_BUTTON_WRAPPER : "btn_wrap",
			POPUP_BUTTON_NORMAL : "btn_pcn",
			POPUP_BUTTON : "btn_pc",
			POPUP_FOOTER : "pop_footer",
			POPUP_CLOSE_WRAPPER : "close_wrap",
			POPUP_CLOSE_BUTTON : "foot_close",
			POPUP_ALERT_WARNING : "pop_text warning",
			POPUP_ALERT_CHECK : "pop_text check",
			POPUP_ALERT_INFO : "pop_text information",
			POPUP_ALERT_SYSTEM : "pop_text system",
			POPUP_DETAIL_BOX : "box_detail",
			POPUP_DETAIL_TEXT : "txt_detail"
		},
		POPUP_SRC_MAP : {
			POPUP_X_BUTTON_CONFIRM : CONTEXTPATH+ "/comm/img/pop_close.png",
			POPUP_X_BUTTON : "comm/img/pop_close02.gif"
		},
		POPUP_TEXT : {
			CONFIRM : "Ok",
			DETAIL : "Detail",
			YES : "Yes",
			NO : "No"
		},
		SELECTORS : {
			ID_ALERT : "faro_alert",
			ID_CONFIRM : "faro_confirm",
			ID_SCREEN : "faro_screen",
			ID_LOADING : "faro_loading"
		},
		POPUP_SCREEN_STYLE : {
			backgroundColor : "#cccccc",
			opacity : 0.4,
			zIndex : 8500,
			display : "none",
			position : "absolute",
			left : 0,
			top : 0,
			width : wrapWidth,
			height : wrapHeight
		},
		LOADING_IMAGE_STYLE : {
			position : 'absolute',
			top : '50%',
			left : '50%',
			marginLeft : -26,
			marginRight : -26,
			zIndex : 8501
		},
		POPUP_STYLE_MAP : {
			CONFIRM_WIDTH : "550px",
			CONFIRM_HEIGHT : "136px",
			ALERT_WIDTH : "450px",
			ALERT_HEIGHT : "130px"
		},
		MESSAGE_TYPES : {
			CONFIRM : "confirm",
			WARNING : "warning",
			CHECK : "check",
			INFO : "info",
			DETAIL : "detail",
			INFO_DETAIL : "info_detail",
			SYSTEM : "system"
		},
		/**
		 * Customized Alert Function
		 *
		 * @param title
		 *            {string} //required
		 * @param message
		 *            {string} //required
		 * @param type
		 *            {string} //optional (default: warning)
		 * @param errorlist
		 *            {array} //optional (only when the type is 'array')
		 * @param callback
		 *            {function} //optional (only when the type is 'function')
		 */

		alert : function(title, message, callback){
			var me = this;
			setTimeout(function(){

				me._alert(title, message, callback);
			}, 200);
		},

		_alert : function(title, message, callback) {
			if (window.parent != window) {
				var thisObj = window.parent.LegoCommonMessage;

				window.parent.LegoCommonMessage.alert.apply(thisObj, arguments);
				return;
			}

			/*******************************************************************
			 * arguments validation
			 ******************************************************************/
			// required arguments
			for (var i = 0; i < 2; ++i) {
				if (arguments[i] === undefined || arguments[i] === null) {
					throw "title, message can not be null or undefined";
					return;
				}
			}

			var type = null, errorlist = null;

			for (var i = 2; i < 5; ++i) {
				if (arguments[i] === undefined) {
					break;
				}

				if (_Faro_Message.verifyType(arguments[i], "function")) {
					callback = arguments[i];
				} else if (_Faro_Message.verifyType(arguments[i], "string")) {
					if (type != null) {
						errorlist = arguments[i];
					} else {
						type = arguments[i];
					}
				} else if (_Faro_Message.verifyType(arguments[i], "array")) {
					errorlist = arguments[i];
				} else {
					throw "check the type of arguments, type: string, errorlist: array, callback: function";
				}
			}

			var bodyWidth = $(document.body).width();
			var bodyHeight = $(document.body).height();

			/*******************************************************************
			 * popup structure
			 ******************************************************************/
			// build popup structure
			var messageType = this._getMessageType(type);
			var divAlert = this._buildWrapper(this.MESSAGE_TYPES.CONFIRM,
					bodyWidth, bodyHeight);
			// var divAlert = this._buildWrapper(messageType, bodyWidth,
			// bodyHeight),
			divBody = this._buildAlertBody(title, message), divBtns = this
					._buildAlertBtns(messageType, errorlist, callback),
					rtBtn = this._buildRtCloseBtn(messageType);

			var divHeader = this._buildHeader(title);
			console.log(divHeader);
			// divAlert.append(divBody).append(divBtns).append(rtBtn);
			aClose = this._buildRtCloseBtn(this.MESSAGE_TYPES.CONFIRM);
			divAlert.append(divHeader).append(divBody).append(divBtns).append(
					aClose);// .append(rtBtn);
			divAlert.css("height", "150px")
			// ui block screen
			var me = this;

			var warnHandler = function(e) {
				e.preventDefault();

				$(document).find(
						"#" + me.SELECTORS.ID_CONFIRM + ", #"
								+ me.SELECTORS.ID_SCREEN).hide();
//				$(document).remove(
//						"#" + me.SELECTORS.ID_CONFIRM + ", #"
//								+ me.SELECTORS.ID_SCREEN);
				$('#'+me.SELECTORS.ID_CONFIRM).remove();
				$('#'+me.SELECTORS.ID_SCREEN).remove();

				callback(e.data.result);
			};

			aClose.click({
				result : false
			}, warnHandler);


			var divScreen = this._buildScreen(bodyWidth, bodyHeight);

			divScreen.show();
			divAlert.show();

			$(document.body).append(divScreen);
			$(document.body).append(divAlert);

			if(aClose){
				aClose.focus();
			}
			// set focus
			// var btnFocus = divAlert.find("button." +
			// this.POPUP_CSS_MAP.POPUP_BUTTON)[0];
			// btnFocus.focus();
		},

		succ : function(title, message) {
			var me = this;
			setTimeout(function(){
				me._succ(title, message);
				}, 200);
			},

		_succ : function(title, message){
			if (window.parent != window) {
				var thisObj = window.parent.LegoCommonMessage;

				window.parent.LegoCommonMessage.alert.apply(thisObj, arguments);
				return;
			}

			/*******************************************************************
			 * arguments validation
			 ******************************************************************/
			// required arguments
			for (var i = 0; i < 2; ++i) {
				if (arguments[i] === undefined || arguments[i] === null) {
					throw "title, message can not be null or undefined";
					return;
				}
			}

			var type = null, callback = null, errorlist = null;

			for (var i = 2; i < 5; ++i) {
				if (arguments[i] === undefined) {
					break;
				}

				if (_Faro_Message.verifyType(arguments[i], "function")) {
					callback = arguments[i];
				} else if (_Faro_Message.verifyType(arguments[i], "string")) {
					if (type != null) {
						errorlist = arguments[i];
					} else {
						type = arguments[i];
					}
				} else if (_Faro_Message.verifyType(arguments[i], "array")) {
					errorlist = arguments[i];
				} else {
					throw "check the type of arguments, type: string, errorlist: array, callback: function";
				}
			}

			var bodyWidth = $(document.body).width();
			var bodyHeight = $(document.body).height();

			/*******************************************************************
			 * popup structure
			 ******************************************************************/
			// build popup structure
			var messageType = this._getMessageType(type);
			var divSucc = this._buildWrapper(this.MESSAGE_TYPES.CONFIRM,
					bodyWidth, bodyHeight);

			divBody = this._buildSuccBody(title, message), divBtns = this
					._buildAlertBtns(messageType, errorlist, callback),
					rtBtn = this._buildRtCloseBtn(messageType);

			var divHeader = this._buildHeader(title);
			console.log(divHeader);
			// divAlert.append(divBody).append(divBtns).append(rtBtn);
			aClose = this._buildRtCloseBtn(this.MESSAGE_TYPES.CONFIRM);
			divSucc.append(divHeader).append(divBody).append(divBtns).append(
					aClose);// .append(rtBtn);
			divSucc.css("height", "150px")
			// ui block screen
			var me = this;

			var succHandler = function(e) {
				e.preventDefault();

				$(document).find(
						"#" + me.SELECTORS.ID_CONFIRM + ", #"
								+ me.SELECTORS.ID_SCREEN).hide();
//				$(document).remove(
//						"#" + me.SELECTORS.ID_CONFIRM + ", #"
//								+ me.SELECTORS.ID_SCREEN);
				$('#'+me.SELECTORS.ID_CONFIRM).remove();
				$('#'+me.SELECTORS.ID_SCREEN).remove();
				callback(e.data.result);
			};

			aClose.click({
				result : false
			}, succHandler);

			var divScreen = this._buildScreen(bodyWidth, bodyHeight);

			divScreen.show();
			divSucc.show();

			$(document.body).append(divScreen);
			$(document.body).append(divSucc);

			// set focus
			// var btnFocus = divAlert.find("button." +
			// this.POPUP_CSS_MAP.POPUP_BUTTON)[0];
			// btnFocus.focus();
		},

		/**
		 *
		 * @param title
		 *            {string} //required
		 * @param message
		 *            {string} //required
		 * @param desc
		 *            {string} //optional
		 * @param callback
		 *            {function} //required
		 */



		confirm : function(title, message, desc, callback) {
			if (window.parent != window) {
				window.parent.LegoCommonMessage.confirm(title, message, desc,
						callback);
				return;
			}

			var me = this;

			/*******************************************************************
			 * arguments validation
			 ******************************************************************/
			if (typeof desc == 'function') {
				callback = desc;
			}

			for (var i = 0; i < 2; ++i) {
				if (!_Faro_Message.verifyType(arguments[i], "string")) {
					throw "title, message are essential";
				}
			}

			if (typeof callback != 'function') {
				throw "argument callback has to be a function";
			} else if (callback === undefined) {
				throw "argument callback is undefined";
			}
			/*
			 * switch(arguments.length) { case 3: if(typeof arguments[2] ==
			 * 'function') { callback = desc; break; } case 4: if(typeof
			 * arguments[3] == 'function') { break; } default: throw "title,
			 * message, callback can not be null or undefined"; return; }
			 */
			var bodyWidth = $(document.body).width();
			var bodyHeight = $(document.body).height();

			/*******************************************************************
			 * popup structure
			 ******************************************************************/
			// build popup structure
			// popup wrapper
			var divConfirm = this._buildWrapper(this.MESSAGE_TYPES.CONFIRM,
					bodyWidth, bodyHeight);

			// popup components
			var divHeader = this._buildHeader(title), divContent = this
					._buildConfirmBody(message, desc),
			// divFooter = this._buildFooter(),
			aClose = this._buildRtCloseBtn(this.MESSAGE_TYPES.CONFIRM);

			divConfirm.append(divHeader).append(divContent)
					/* .append(divFooter) */.append(aClose);

			// event handler
			var confirmHandler = function(e) {
				e.preventDefault();

			$(document).find(
						"#" + me.SELECTORS.ID_CONFIRM + ", #"
								+ me.SELECTORS.ID_SCREEN).hide();
//				$(document).remove(
//						"#" + me.SELECTORS.ID_CONFIRM + ", #"
//								+ me.SELECTORS.ID_SCREEN);
				$('#'+me.SELECTORS.ID_CONFIRM).remove();
				$('#'+me.SELECTORS.ID_SCREEN).remove();
				callback(e.data.result);
			};

			// event handler
			divContent.find("." + this.POPUP_CSS_MAP.POPUP_BUTTON_NORMAL)
					.click({
						result : false
					}, confirmHandler);
			divContent.find("." + this.POPUP_CSS_MAP.POPUP_BUTTON).click({
				result : true
			}, confirmHandler);
			aClose.click({
				result : false
			}, confirmHandler);
			// divFooter.find("." +
			// this.POPUP_CSS_MAP.POPUP_CLOSE_BUTTON).click({result: false},
			// confirmHandler);

			// ui block screen
			var divScreen = this._buildScreen(bodyWidth, bodyHeight);

			divScreen.show();
			divConfirm.show();

			$(document.body).append(divScreen);
			$(document.body).append(divConfirm);

			// set focus
			// var btnFocus = divConfirm.find("button." +
			// this.POPUP_CSS_MAP.POPUP_BUTTON)[0];
			// console.log(btnFocus);

			var btnFocus = divConfirm.find("button."
					+ this.POPUP_CSS_MAP.POPUP_BUTTON_NORMAL)[0];
		//	console.log(btnFocus);
			// alert("dd");
			btnFocus.focus();
		},


		/**
		 * UI loading image 출력
		 */
		showLoading : function() {
			if (window.parent != window) {
				window.parent.LegoCommonMessage.showLoading();
				return;
			}
			var screen = this._buildScreen();
			var loadingImg = $(
					"<img  class='loading' src='comm/img/loading-0.png'>").attr(
					"id", this.SELECTORS.ID_LOADING).css(
					this.LOADING_IMAGE_STYLE);

			loadingImg.show();
			screen.show();

			$(document.body).append(screen);
			$(document.body).append(loadingImg);
		},
		/**
		 * UI loading image 제거
		 */
		hideLoading : function() {
			if (window.parent != window) {
				window.parent.LegoCommonMessage.hideLoading();
				return;
			}


			$(document).find(
					"#" + this.SELECTORS.ID_LOADING + ", #"
							+ this.SELECTORS.ID_SCREEN).hide();
			$('#'+this.SELECTORS.ID_LOADING).remove();
			$('#'+this.SELECTORS.ID_SCREEN).remove();
		},
		/**

		 *
		 * @param msgCd
		 *            {string} required
		 * @param langCd
		 *            {string} required
		 * @param args
		 *            {array} required
		 * @param replacement
		 *            {string} optional
		 * @return {string} 변형된 메시지
		 */
		getMessage : function(msgCd, langCd, args, replacement) {
			for (var i = 0; i < arguments.length; ++i) {
				if (!arguments[i] && i != 3) {
					throw "msgCd, langCd, args are essential";
				}

				if (i == 2 && !$.isArray(arguments[i])) {
					throw "type of args has to be an array";
				}

				if (i != 2 && !$.jqx.dataFormat.isString(arguments[i])) {
					throw "msgCd, langCd, replacement have to be strings";
				}
			}

			var msgStr = this._getMessage(msgCd, langCd) || replacement;

			if (!msgStr) {
				return "";
			}

			var regExp = /{[0-9]+}/g, matchIndex = 0, rStr = '';

			rStr = msgStr.replace(regExp, function(matched) {
				if (!args[matchIndex]) {
					matchIndex++;
					return '';
				} else {
					return args[matchIndex++];
				}
			});

			return rStr;
		},
		/**

		 *
		 * @param msgCd
		 *            {string}
		 * @param langCd
		 *            {string}
		 * @return {string} message meta data
		 */
		_getMessage : function(msgCd, langCd) {
			return "test {0} test {1} test {27} test {3} test {49} test {5} test {9} test {21}";
		},

		/**
		 * UI Block Screen 생성
		 *
		 * @param width
		 *            {number}
		 * @param height
		 *            {height}
		 * @return divScreen {element}
		 */
		_buildScreen : function(width, height) {
			var divScreen = $("<div>");
			divScreen.attr("id", this.SELECTORS.ID_SCREEN).css(
					this.POPUP_SCREEN_STYLE);

			return divScreen;
		},
		_getMessageType : function(type) {
			if (!type) {
				return this.MESSAGE_TYPES.WARNING;
			}

			for ( var key in this.MESSAGE_TYPES) {
				if (type.toLowerCase() == this.MESSAGE_TYPES[key]) {
					return this.MESSAGE_TYPES[key];
				}
			}

			return this.MESSAGE_TYPES.WARNING;
		},
		/**
		 * Alert Container 생성
		 *
		 * @param meesageType
		 *            {string}
		 * @return divWrapper {element}
		 */
		_buildWrapper : function(messageType, bodyWidth, bodyHeight) {
			var divWrapper = $("<div>"), popId = '', popClassName = '', style = {
				left : '50%',
				top : '50%',
				position : 'absolute'
			};

			if (messageType == this.MESSAGE_TYPES.CONFIRM) {
				popId = this.SELECTORS.ID_CONFIRM;
				popClassName = this.POPUP_CSS_MAP.POPUP_WRAPPER
						+ " faro_confirm";
				style.width = this.POPUP_STYLE_MAP.CONFIRM_WIDTH;
				style.height = this.POPUP_STYLE_MAP.CONFIRM_HEIGHT;
				style.marginLeft = -(parseInt(this.POPUP_STYLE_MAP.CONFIRM_WIDTH) / 2);
				style.marginTop = -(parseInt(this.POPUP_STYLE_MAP.CONFIRM_HEIGHT) / 2);
			} else {
				popId = this.SELECTORS.ID_ALERT;
				style.width = this.POPUP_STYLE_MAP.ALERT_WIDTH;
				// style.height = this.POPUP_STYLE_MAP.ALERT_HEIGHT;
				style.marginLeft = -(parseInt(this.POPUP_STYLE_MAP.ALERT_WIDTH) / 2);
				// style.marginTop =
				// -(parseInt(this.POPUP_STYLE_MAP.ALERT_HEIGHT) / 2);
				style.marginTop = -(parseInt(this.POPUP_STYLE_MAP.ALERT_WIDTH) / 2);

				switch (messageType) {
				case this.MESSAGE_TYPES.WARNING:
				case this.MESSAGE_TYPES.DETAIL:
				case this.MESSAGE_TYPES.CHECK:
					popClassName = this.POPUP_CSS_MAP.POPUP_ALERT_WARNING
							+ " faro_alert";
					break;
				/*
				 * case this.MESSAGE_TYPES.CHECK: popClassName =
				 * this.POPUP_CSS_MAP.POPUP_ALERT_CHECK + " faro_alert"; break;
				 */
				case this.MESSAGE_TYPES.INFO:
				case this.MESSAGE_TYPES.INFO_DETAIL:
					popClassName = this.POPUP_CSS_MAP.POPUP_ALERT_INFO
							+ " faro_alert";
					break;

				case this.MESSAGE_TYPES.SYSTEM:
					popClassName = this.POPUP_CSS_MAP.POPUP_ALERT_SYSTEM
							+ " faro_alert";
					break;
				}
			}

			divWrapper.attr("id", popId).attr("class", popClassName).css(style);

			return divWrapper;
		},
		/**
		 * Header 생성
		 *
		 * @param title
		 *            {string}
		 * @return divHeader {element}
		 */
		_buildHeader : function(title) {
			var divHeader = $("<div>").append($("<h1>").append(title))
					.addClass(this.POPUP_CSS_MAP.POPUP_HEADER);
			return divHeader;
		},
		/**
		 * Footer 생성
		 *
		 * @param
		 * @return divFooter {element}
		 */
		_buildFooter : function() {
			var divFooter = $("<div>");
			divFooter.addClass(this.POPUP_CSS_MAP.POPUP_FOOTER);

			var divCloseWrapper = $("<div>");
			divCloseWrapper.addClass(this.POPUP_CSS_MAP.POPUP_CLOSE_WRAPPER);

			var aClose = $("<a>");
			aClose.addClass(this.POPUP_CSS_MAP.POPUP_CLOSE_BUTTON)
					.html("Close");

			divFooter.append(divCloseWrapper.append(aClose));

			return divFooter;
		},

		_buildSuccBody : function(message, desc) {
			var divBody = $("<div>").addClass(this.POPUP_CSS_MAP.POPUP_CONTENT)
					.css("background-color", "white").css("padding",
							"15px 20px").css("font-size", "15px");

			var divMessageArea = $("<div>").addClass(
					this.POPUP_CSS_MAP.POPUP_MESSAGE_AREA);
			// addClass(this.CSS_MAP.TEXT_CENTER_ALIGN);
			// .addClass("warning_img");
			divImgArea = $("<div>").css("float", "left").css("margin-right",
					"20px").css("padding", "22px");
			// divMessageArea.append("<div style='float:left height:65px
			// padding-right:20px' >왼쪽</div>");
			divImgArea.addClass("succ_img");
			divMessageArea.append(divImgArea);
			divMessageArea.append(desc);

			var divConfirmBtnArea = $("<div>").addClass(
					this.POPUP_CSS_MAP.POPUP_BUTTON_WRAPPER);

			divBody.append(divMessageArea);

			return divBody;
		},

		/**
		 * Alert Body(content) 생성
		 *
		 * @param title
		 *            {string}
		 * @param message
		 *            {string}
		 * @return divBody {element}
		 */
		_buildAlertBody : function(message, desc) {
			var divBody = $("<div>").addClass(this.POPUP_CSS_MAP.POPUP_CONTENT)
					.css("background-color", "white").css("padding",
							"15px 20px").css("font-size", "15px");

			var divMessageArea = $("<div>").addClass(
					this.POPUP_CSS_MAP.POPUP_MESSAGE_AREA);
			divImgArea = $("<div>").css("float", "left").css("margin-right",
					"20px").css("padding", "22px");
			divImgArea.addClass("warning_img");
			divMessageArea.append(divImgArea);
			divMessageArea.append(desc);

			var divConfirmBtnArea = $("<div>").addClass(
					this.POPUP_CSS_MAP.POPUP_BUTTON_WRAPPER);

			divBody.append(divMessageArea);

			return divBody;
		},

		/**
		 * Alert Button 영역 생성
		 *
		 * @param messageType
		 *            {string}
		 * @param errorlist
		 *            {array}
		 * @return divButtonArea, divDetail {element[]}
		 */
		_buildAlertBtns : function(messageType, errorlist, callback) {
			var divButtonArea = $("<div>").addClass(
					this.CSS_MAP.TEXT_CENTER_ALIGN).addClass(
					this.CSS_MAP.MARGIN_TOP_5PX),
			// spanOkButton =
			// $("<span>").addClass(this.POPUP_CSS_MAP.POPUP_BUTTON).html(this.POPUP_TEXT.CONFIRM),
			btnOk = $("<button> ").attr('id', this.POPUP_CSS_MAP.POPUP_BUTTON).addClass(this.POPUP_CSS_MAP.POPUP_BUTTON)
					.html(this.POPUP_TEXT.CONFIRM),
			// spanDetailButton =
			// $("<span>").addClass(this.POPUP_CSS_MAP.POPUP_BUTTON).html(this.POPUP_TEXT.DETAIL).css("margin-left",
			// "5px"),
			btnDetail = $("<button>").addClass(this.POPUP_CSS_MAP.POPUP_BUTTON)
					.html(this.POPUP_TEXT.DETAIL).css("margin-left", "5px"), divDetail = $(
					"<div>").addClass(this.POPUP_CSS_MAP.POPUP_DETAIL_BOX).css(
					"display", "none"), divText = $("<div>").addClass(
					this.POPUP_CSS_MAP.POPUP_DETAIL_TEXT).css({
				height : '115px',
				overflow : 'auto'
			}), me = this;

			// divButtonArea.append(spanOkButton);
			divButtonArea.append(btnOk);

			// prevent keydown -> mouseclick
			if (window.event) {
				if (window.event.type == 'keydown') {
					window.event.preventDefault();
				}
			}

			// spanOkButton.click(function(e) {
			btnOk.click(function(e) {

				me._destroyAlert(e);
				if (callback) {
					callback();
				}
			});

			if (messageType == this.MESSAGE_TYPES.DETAIL
					|| messageType == this.MESSAGE_TYPES.INFO_DETAIL) {
				// divButtonArea.append(spanDetailButton);
				divButtonArea.append(btnDetail);
				divText.html(this._errorlistToText(errorlist));
				divDetail.append(divText);

				// spanDetailButton.click(function(e){
				btnDetail.click(function(e) {
					divDetail.toggle();
				});

				return [ divButtonArea, divDetail ];
			}

			return divButtonArea;

		},
		/**
		 * vo list -> html 변환 함수
		 *
		 * @param errorlist
		 *            {array}
		 * @return rString {string}
		 */
		_errorlistToText : function(errorlist) {
			var rString = "";

			if (_Faro_Message.verifyType(errorlist, "array")) {
				for (var i = 0; i < errorlist.length; ++i) {
					var errorObj = errorlist[i];

					for ( var key in errorObj) {
						if (rString.lastIndexOf("<br>") != rString.length - 4
								&& rString != "") {
							rString += ", ";
						}

						rString += key + ": " + errorObj[key];
					}

					rString += "<br><br>";
				}
			} else if (_Faro_Message.verifyType(errorlist, "string")) {
				rString += errorlist.toString();
			}

			return rString;
		},
		/**
		 * Confirm Body(content) 생성
		 *
		 * @param message
		 *            {string}
		 * @param desc
		 *            {string}
		 * @return divBody {element}
		 */
		_buildConfirmBody : function(message, desc) {
			var divBody = $("<div>").addClass(this.POPUP_CSS_MAP.POPUP_CONTENT)
					.css("background-color", "white").css("padding",
							"15px 20px").css("font-size", "15px");

			var divMessageArea = $("<div>").addClass(this.POPUP_CSS_MAP.POPUP_MESSAGE_AREA)
			//.addClass(this.CSS_MAP.TEXT_CENTER_ALIGN).addClass("confirm_img");

				divImgArea = $("<div>").css("float", "left").css("margin-right",
					"20px").css("padding", "22px");
	          divImgArea.addClass("confirm_img");
			divMessageArea.append(divImgArea);

			var strongMessage = $("<strong>").html(message);
			divMessageArea.append(strongMessage).append("<br>").append(desc);

			var divConfirmBtnArea = $("<div>").addClass(
					this.POPUP_CSS_MAP.POPUP_BUTTON_WRAPPER);

			// var aYes =
			// $("<a>").addClass(this.POPUP_CSS_MAP.POPUP_BUTTON).addClass(this.CSS_MAP.MARGIN_RIGHT_5PX).html("Yes");
			// var aNo =
			// $("<a>").addClass(this.POPUP_CSS_MAP.POPUP_BUTTON_NORMAL).html("No");
			var btnYes = $("<button>")
					.addClass(this.POPUP_CSS_MAP.POPUP_BUTTON).addClass(
							this.CSS_MAP.MARGIN_RIGHT_5PX).html(
							this.POPUP_TEXT.YES);
			var btnNo = $("<button>").addClass(
					this.POPUP_CSS_MAP.POPUP_BUTTON_NORMAL).html(
					this.POPUP_TEXT.NO);

			divConfirmBtnArea.append(btnYes).append(btnNo);
			divBody.append(divMessageArea).append(divConfirmBtnArea);

			return divBody;
		},
		_destroyAlert : function(e) {
			e.preventDefault();

			$(document).find(
					"#" + this.SELECTORS.ID_CONFIRM + ", #"
							+ this.SELECTORS.ID_SCREEN).hide();
//			$(document).remove(
//					"#" + this.SELECTORS.ID_CONFIRM + ", #"
//							+ this.SELECTORS.ID_SCREEN);
			$('#'+this.SELECTORS.ID_CONFIRM).remove();
			$('#'+this.SELECTORS.ID_SCREEN).remove();
		},
		/**
		 * Right Top Close Button 생성
		 *
		 * @param messageType
		 *            {string}
		 * @return aClose {element}
		 */
		_buildRtCloseBtn : function(messageType) {
			var imgSrc = messageType === this.MESSAGE_TYPES.CONFIRM ? this.POPUP_SRC_MAP.POPUP_X_BUTTON_CONFIRM
					: this.POPUP_SRC_MAP.POPUP_X_BUTTON;

			// event handler
			var aClose = $("<a href id='closebtn' class='"
					+ this.POPUP_CSS_MAP.POPUP_X_BUTTON + "'>"), imgClose = $("<img src='"
					+ imgSrc + "' alt='close'>");

			if (messageType !== this.MESSAGE_TYPES.CONFIRM) {
				imgClose.click($.proxy(this._destroyAlert, this));
			}

			aClose.append(imgClose);
		//	console.log(aClose);

			return aClose;
		}
	};

	window.LegoCommonMessage = _Faro_Message;

})(window);

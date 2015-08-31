(function(window) {


	var LEGO_POPUP = {
		CSS_MAP : {
			MARGIN_RIGHT_5PX : "mr5",
			TEXT_CENTER_ALIGN : "tC"
		},
		POPUP_CSS_MAP : {
			POPUP_WRAPPER : "pop_wrap",
			POPUP_HEADER : "pop_haeder",
			POPUP_CONTENT : "pop_cont",
			POPUP_MESSAGE_TITLE : "message_title",
			POPUP_MESSAGE_CONTENT : "message_cont",
			POPUP_X_BUTTON : "close",
			POPUP_MESSAGE_AREA : "message_area",
			POPUP_BUTTON_WRAPPER : "btn_wrap",
			POPUP_BUTTON_NORMAL : "pop_btn_normal",
			POPUP_BUTTON : "pop_btn",
			POPUP_FOOTER : "pop_footer",
			POPUP_CLOSE_WRAPPER : "close_wrap",
			POPUP_CLOSE_BUTTON : "foot_close",
			POPUP_ALERT_WARNING : "pop_text warning",
			POPUP_ALERT_CHECK : "pop_text check"
		},
		POPUP_SRC_MAP : {
			POPUP_X_BUTTON : "comm/img/pop_close.png"
		},
		CONSTANT : {
			ZINDEX_STEP : 10
		},

		popups : {},
		zIndex : 1000,
		createPopup : function(prop) {
			if (window.parent != window) {
				return window.parent.LEGO_POPUP.createPopup(prop);
			}

			if (prop.name === undefined || prop.name === null) {
				throw "property name 'name' is undefined";
			}
			if (prop.url === undefined || prop.url === null) {
				throw "property name 'url' is undefined";
			}

			if (this.popups[prop.name] === undefined
					|| this.popups[prop.name] === null) {
				this.popups[prop.name] = new LegoPopup(prop, this.zIndex);
				this.popups[prop.name].init();
				this.zIndex += this.CONSTANT.ZINDEX_STEP;

				return this.popups[prop.name];
			}

			throw "the popup already exists which has a same name";
		},
		destroyPopup : function(name) {

			destoryAUICompPop();
			if (window.parent != window) {
				return window.parent.LEGO_POPUP.destroyPopup(name);
			}

			if (this.popups[name] !== undefined && this.popups[name] !== null) {
				var popup = this.popups[name];
				popup.destroy();

				// this.popups[name] = null;

				delete this.popups[name];

				return true;
			}

			throw "the popup doesn't exist";
		},
		getPopup : function(name) {
			if (window.parent != window) {
				return window.parent.LEGO_POPUP.getPopup(name);
			}
			if (this.popups[name] !== undefined && this.popups[name] !== null) {
				return this.popups[name];
			}

			throw "the popup doesn't exist";
		},
		hasPopup : function(name) {
			if (window.parent != window) {
				return window.parent.LEGO_POPUP.hasPopup(name);
			}

			return this.popups.hasOwnProperty(name);
		}
	};

	window.LEGO_POPUP = LEGO_POPUP;
})(window);

function LegoPopup(prop, zIndex) {
	if (!(this instanceof LegoPopup)) {
		return new LegoPopup(prop, zIndex);
	}

	this._setPopupProperties(prop);
	this.name = prop.name;
	this.url = prop.url;
	this.closeCallback = prop.closeCallback;
	this.destroyCallback = prop.destroyCallback;
	this.zIndex = zIndex;
	this.setPopupArgs(prop.popupArgs || {});
	this.result = {};
}

LegoPopup.prototype = {
	CONSTANT : {
		HEADER_SUFFIX : "Header",
		CONTENT_SUFFIX : "Content",
		FOOTER_SUFFIX : "Footer",
		SCREEN_SUFFIX : "Screen",
		CLOSER_SUFFIX : "Closer",
		HEIGHT_NOT_CONTENT_FOOTER : 119,
		HEIGHT_NOT_CONTENT : 10,
		POPUP_TOP : "20%",
		DEFAULT_WIDTH : 800,
		DEFAULT_HEIGHT : 600,
		MAX_HEIGHT : 700
	},
	// width: 800,
	// height: 600,
	// left: 0,
	// top: 0,
	backgroundColor : "white",
	position : "absolute",
	display : 'none',
	// modal: true,
	init : function() {
		var bodyWidth = $(document.body).width();
//		var wrapWidth = $('#wrap').width();
//		if(!wrapWidth){
//			wrapWidth = $(document.body).width();
//
//		}

		this.title = this.prop.title || this.url;
		this.width = parseInt(this.prop.width || this.CONSTANT.DEFAULT_WIDTH);
		// height limit
		// this.height = this.prop.height ? (this.prop.height >
		// this.CONSTANT.MAX_HEIGHT ? this.CONSTANT.MAX_HEIGHT :
		// this.prop.height) || this.CONSTANT.DEFAULT_HEIGHT;
		if (this.prop.height) {
			this.height = parseInt(this.prop.height > this.CONSTANT.MAX_HEIGHT ? this.CONSTANT.MAX_HEIGHT
					: this.prop.height);
		} else {
			this.height = this.CONSTANT.DEFAULT_HEIGHT;
		}

		this.modal = (this.prop.modal === undefined ? true : this.prop.modal);
		this.left = bodyWidth / 2 - this.width / 2;
		//this.left = wrapWidth / 2 - this.width / 2;
		this.top = this.CONSTANT.POPUP_TOP;
		this.parent = $(document);
		this.footer = (this.prop.footer == true ? true : false);
		this.popup = $("<div id= 'popup' name='" + this.name + "'>").css({
			backgroundColor : this.backgroundColor,
			position : this.position,
			border : this.border,
			display : this.display,
			left : this.left,
			top : this.top,
			zIndex : this.zIndex,
			width : this.width,
			height : this.height
		}).addClass(LEGO_POPUP.POPUP_CSS_MAP.POPUP_WRAPPER);

		this._appendHeader();
		this._appendContent();
		this._appendFooter();
		this._appendCloser();
		this._appendScreen();

		$(document.body).append(this.popup);
		//$('#wrap').append(this.popup);

		/*
		if(!$('#wrap').width()){
			$(document.body).append(this.popup);
		}*/
	},
	show : function(type) {
		$(document.body).find(".jqx-validator-hint").hide();

		this.popup.show();

		var modal = this.modal;
		if (type !== undefined && type !== null) {
			modal = (type == 'modal' ? true : false);
		}

		if (modal) {
			// console.log("popup opened as a modal");
			this.screen.show();
		}
	},
	close : function(type) {
		this.popup.hide();
		this.screen.hide();

		this.closeCallback(this.result);
		$(document.body).find(".jqx-validator-hint").show();
	},
	destroy : function() {
		this.popup.remove();
		this.screen.remove();

		this.destroyCallback(this.result);

		$(document.body).find(".jqx-validator-hint").show();
	},
	saveResult : function(result) {
		if (!this.result) {
			this.result = {};
		}

		if (Object.prototype.toString.call(result) !== "[object Object]") {
			throw "the type of result has to be Javascript Object";
		}

		for ( var key in result) {
			this.result[key] = result[key];
		}
	},
	getResult : function() {
		return this.result;
	},
	setPopupArgs : function(popupArgs) {
		if (Object.prototype.toString.call(popupArgs) !== "[object Object]") {
			throw "the type of result has to be Javascript Object";
		}

		if (!this.popupArgs) {
			this.popupArgs = {};
		}

		for ( var key in popupArgs) {
			this.popupArgs[key] = popupArgs[key];
		}
	},
	setPopupArg : function(key, value) {
		if (!this.popupArgs) {
			this.popupArgs = {};
		}

		this.popupArgs[key] = value;
	},
	getPopupArgs : function(key) {
		if (key === undefined || key === null) {
			return this.popupArgs || {};
		} else {
			return this.popupArgs[key] || null;
		}
	},
	_appendHeader : function() {
		var me = this;

		// make header division
		var headerDiv = $("<div>");
		headerDiv.attr("name", this.name + this.CONSTANT.HEADER_SUFFIX);
		headerDiv.addClass(LEGO_POPUP.POPUP_CSS_MAP.POPUP_HEADER).css({
			"-webkit-user-select" : "none",
			"cursor" : "default"
		});

		// adding title span on header division
		var h1Title = $("<h1>" + this.title + "</h1>");
		headerDiv.append(h1Title);

		// adding drag event handlers for popup drag action
		headerDiv.mousedown(function(e) {
			return me._popupHeaderMouseDownHandler(me, e);
		});

		$(document).on("mousemove.LegoPopup", function(e) {
			return me._popupHeaderMouseMoveHandler(me, e);
		});

		$(document).on("mousemove.LegoPopup", function(e) {
			return me._popupHeaderDragHandler(me, e);
		});

		$(document).on("mouseup.LegoPopup", function(e) {
			return me._popupHeaderMouseUpHandler(me, e);
		});

		this.popup.append(headerDiv);
	},

	_popupHeaderMouseDownHandler : function(self, event) {
		// set mouse position
		self._mousePosition = {
			x : event.pageX,
			y : event.pageY
		};

		self._isMouseDown = true;
		self._isDragging = false;

		// bring popup front
		if (self.zIndex + LEGO_POPUP.CONSTANT.ZINDEX_STEP == LEGO_POPUP.zIndex) {
			// popup is already placed at the front. so do nothing
		} else {
			// popup is placed at the back
			// bring it front
			self.zIndex = LEGO_POPUP.zIndex;
			LEGO_POPUP.zIndex += LEGO_POPUP.CONSTANT.ZINDEX_STEP;
			$(self.popup).css("z-index", self.zIndex);
		}
	},

	_popupHeaderMouseMoveHandler : function(self, event) {
		if (self._isMouseDown && !self._isDragging) {
			var pageX = event.pageX, pageY = event.pageY;

			if ((pageX + 3 < self._mousePosition.x || pageX - 3 > self._mousePosition.x)
					|| (pageY + 3 < self._mousePosition.y || pageY - 3 > self._mousePosition.y)) {
				self._isDragging = true;

				$(document.body).addClass('jqx-disableselect');
			}
		}
	},

	_popupHeaderDragHandler : function(self, event) {
		if (self._isDragging) {
			var pageX = event.pageX, pageY = event.pageY, displaceX = pageX
					- self._mousePosition.x, displaceY = pageY
					- self._mousePosition.y;

			if (self.left + displaceX + self.width < $(document).width()
					&& self.left + displaceX > 0) {
				self.popup.css("left", self.left + displaceX);
			}

			if (self.top + displaceY + self.height < $(document).height()
					&& self.top + displaceY > 0) {
				self.popup.css("top", self.top + displaceY);
			}
		}
	},

	_popupHeaderMouseUpHandler : function(self, event) {
		if (self._isDragging) {
			self.left = self.popup.coord().left;
			self.top = self.popup.coord().top;
		}

		self._isDragging = false;
		self._isMouseDown = false;

		$(document.body).removeClass('jqx-disableselect');
	},

	_appendContent : function() {
		// make content division
		var contentDiv = $("<div>"), heightNotContent = (this.footer == true ? this.CONSTANT.HEIGHT_NOT_CONTENT_FOOTER
				: this.CONSTANT.HEIGHT_NOT_CONTENT);
		contentDiv.attr("id", "popupContent");
		contentDiv.attr("name", this.name + this.CONSTANT.CONTENT_SUFFIX);
		contentDiv.addClass(LEGO_POPUP.POPUP_CSS_MAP.POPUP_CONTENT).css({
			height : this.height - heightNotContent,
			position : 'relative'
		});

		// load popup content(html file) with file path
		contentDiv.load(this.url);

		this.popup.append(contentDiv);
	},
	_appendFooter : function() {
		if (this.footer == false) {
			return;
		}

		var me = this;

		var divFooter = $("<div name='" + this.CONSTANT.FOOTER_SUFFIX + "'>");
		divFooter.addClass(LEGO_POPUP.POPUP_CSS_MAP.POPUP_FOOTER);

		var closeWrapper = $("<div class='"
				+ LEGO_POPUP.POPUP_CSS_MAP.POPUP_CLOSE_WRAPPER + "'>");
		closeWrapper.append(
				"<a href class='" + LEGO_POPUP.POPUP_CSS_MAP.POPUP_CLOSE_BUTTON
						+ "'>" + "Close" + "</a>").click(function(e) {
			e.preventDefault();

			LEGO_POPUP.destroyPopup(me.name);
		});

		divFooter.append(closeWrapper);
		this.popup.append(divFooter);
	},
	_appendCloser : function() {
		var me = this;

		var aClose = $(
				"<a href class='" + LEGO_POPUP.POPUP_CSS_MAP.POPUP_X_BUTTON
						+ "'>").append(
				$(
						"<img src='" + LEGO_POPUP.POPUP_SRC_MAP.POPUP_X_BUTTON
								+ "' alt='close'>").click(function(e) {
					e.preventDefault();

					LEGO_POPUP.destroyPopup(me.name);
				}));

		this.popup.append(aClose);
	},
	_appendScreen : function() {
		// make screen that blocks user interaction with parent page
		var screenDiv = $("<div>");
		var bodyWidth = $(document.body).width();
		var bodyHeight = $(document.body).height();


//		var wrapWidth = $('#wrap').width();
//		var wrapHeight = $('#wrap').height();

		screenDiv.attr("id", "screenPopup");
		screenDiv.attr("name", this.name + this.CONSTANT.SCREEN_SUFFIX);
		screenDiv.css({
			backgroundColor : "#cccccc",
			opacity : 0.4,
			zIndex : this.zIndex - 1,
			display : "none",
			position : "absolute",
			left : 0,
			top : 0,
			width : bodyWidth,
			height: bodyHeight
		});

		this.screen = screenDiv;
		$(document.body).append(this.screen);
		//$('#wrap').append(this.screen);
	},
	_setPopupProperties : function(prop) {
		if (!this.prop) {
			this.prop = {};
		}

		if (typeof prop != "object") {
			throw "type of properties has to be object";
		}

		for ( var key in prop) {
			this.prop[key] = prop[key];
		}
	}
};
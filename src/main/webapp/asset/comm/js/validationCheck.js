/**
 * 필수값 검증
 */
function requiredCheck(val) {

	if (!(this.isNull(val))) {
		// lego_common_alert("Error","필수값이 누락되었습니다.");
		return false;
	}
	return true;

}

/**
 * 한글전화번호유형 체크
 */
function koPhoneCheck(val) {

	if (!(!this.isNull(val) || this.check(
			/^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?[0-9]{3,4}-?[0-9]{4}$/i,
			val))) {
		// lego_common_alert("Error","한글 전화번호 형식이 잘못되었습니다.");

		return false;
	}
	return true;
}
/**
 * 전화번호유형 체크
 */
function phoneCheck(val) {

	if (!(!this.isNull(val) || this.check(/^[0-9+-]+$/i, val))) {
		// lego_common_alert("Error","전화번호 형식이 잘못되었습니다.");

		return false;
	}
	return true;
}

/**
 * 숫자만 하용
 *
 * @param {}
 *            val
 * @return {Boolean}
 */
function onlyNumCheck(val) {
	if (!((!this.isNull(val) || this.check(/^[0-9]+$/g, val)))) {
		// lego_common_alert("Error","숫자 형식이 잘못되었습니다.");

		return false;
	}
	return true;
}

/**
 * 특수문자 불가
 *
 * @param {}
 *            val
 * @return {Boolean}
 */
function koEngNullNumCheck(val) {

	if (!(!this.isNull(val) || this.check(/^[ㄱ-힣a-zA-Z0-9\-\_\,\.\(\)\/\s]+$/i, val))) {
		// lego_common_alert("Error","특수문자는 입력할 수 없습니다.");

		return false;
	}
	return true;
}

function correctKoEngNullNumCheck(val) {

	if (!(!this.isNull(val) || this.check(/^[가-힝a-zA-Z0-9\-\_\,\.\(\)\/\s]+$/i, val))) {
		// lego_common_alert("Error","특수문자는 입력할 수 없습니다.");

		return false;
	}
	return true;
}

/**
 * '%' 사용 불가 (기타 특수문자 허용)
 *
 * @param {}
 *            val
 * @return {Boolean}
 */
function koEngNullNumPercentCheck(val) {
	if (!(!this.isNull(val) || this
			.check(
					/^[ㄱ-힣a-zA-Z0-9\~\!\@\#\^\$\&\*\(\)\-\_\+\=\[\]\{\}\|\\,\.\?\<\>\'\"\/\;\`\s]+$/i,
					val))) {
		// lego_common_alert("Error","% 는 입력할 수 없습니다.");

		return false;
	}
	return true;
}

/**
 * 영문 숫자만 허용
 *
 * @param {}
 *            val
 * @return {Boolean}
 */
function engNumCheck(val) {

	if (!(!this.isNull(val) || this.check(/^[a-zA-Z0-9\-\_\,\.\(\)\/\s]+$/i, val))) {
		// lego_common_alert("Error","영문과 숫자만 허용됩니다.");

		return false;
	}
	return true;
}

function engNumSpcCharCheck(val) {

	if (!(!this.isNull(val) || this.check(/^[a-zA-Z0-9\-\_\,\.\(\)\/\s]+$/i, val))) {
		// lego_common_alert("Error","영문과 숫자만 허용됩니다.");

		return false;
	}
	return true;
}
/**
 * 영문과 숫자 . / 허용 (/ / . 는 가능 )
 *
 * @param {}
 *            val
 * @return {Boolean}
 */
function urlCheck(val) {

	if (!(!this.isNull(val) || this.check(/^[a-zA-Z0-9/\(\).?=_&\s]+$/i, val))) {
		// lego_common_alert("Error","영문과 숫자만 허용됩니다.");

		return false;
	}
	return true;
}

/**
 * 영문만 허용
 *
 * @param {}
 *            val
 * @return {Boolean}
 */
function engCheck(val) {

	if (!(!this.isNull(val) || this.check(/^[a-zA-Z\-\_\,\.\(\)\/\s]+$/i, val))) {
		return false;
	}
	return true;
}




function isSpaceCheck(val) {
	if ((!this.isNull(val) && val.length > 0)) {
		// /공백으로만 이루어진 키워드
		return false;
	} else if (val.length > val.replace(" ", "").length) {
		// 중간에 공백이 들어간 키워드
		return false;
	}
	return true;
}

function onlyengLowerNumCheck(val) {

	if (!(!this.isNull(val) || this.check(/^[0-9a-z,]*$/i, val))) {
		// lego_common_alert("Error","영문과 숫자만 허용됩니다.");

		return false;
	}
	return true;
}

/**
 * 이메일 유형만 허용
 *
 * @param {}
 *            val
 * @return {Boolean}
 */
function emailCheck(val) {
	if (!(!this.isNull(val) || this.check(/^[^\s@]+@[^\s@]+\.[^\s@]+$/, val))) {
		// lego_common_alert("Error","이메일 형식이 잘못되었습니다.");
		return false;
	}
	if (!(!this.isNull(val) || this.check(/^[a-zA-Z0-9\-\_\.\,\@\s]+$/i, val))) {
		// lego_common_alert("Error","영문과 숫자만 허용됩니다.");

		return false;
	}
	return true;
}

function emailsCheck(val) {
	var emails = val.split(',');
	var emailNum = emails.length;
	for(var i=0; i< emailNum; i++){
		if (!(!this.isNull(emails[i]) || this.check(/^[^\s@]+@[^\s@]+\.[^\s@]+$/, emails[i]))) {
			// lego_common_alert("Error","이메일 형식이 잘못되었습니다.");
			return false;
		}
		if (!(!this.isNull(emails[i]) || this.check(/^[a-zA-Z0-9\-\_\.\,\@\s]+$/i, emails[i]))) {
			// lego_common_alert("Error","영문과 숫자만 허용됩니다.");

			return false;
		}
	}

	return true;
}

function digitsCheck(data, min, max) {
	if (data.length < min || data.length > max) {
		return false;
	}

	return true;

}

function trim(input) {
	var data = input.val();
	input.val(data.replace(/(^\s*)|(\s*$)/gi, ""));

}

function del_space(input) {
	var data = input.val();

	input.val(data.replace(/(\s*)/gi, ""));

}

function check(regex, val) {
	if (regex.test(val)) {
		return true;
	}
	return false;
}
function isNull(val) { // 공백제거 /(^\s*)|(\s*$)/g
	if (val == null || val.replace(/(^\s*)|(\s*$)/g, "").length == 0) {
		return false;
	} else {
		return true;
	}
}

function pastelimitText(limitField, limitCount, limitNum) {

	var str_len = limitField.value.length; // 해당 필드 길이
	var cbyte = this.textLengthByte(limitField.value); // 필드 바이트 체크
	var li_len = 0;


	function setFocusTargetField() {
		if (limitField) {
			limitField.focus();
		}
	}

	// 라인수 제안 메시지
	var lineSplit = limitField.value.split("\n");


	if (lineSplit.length > 5) {

	//	 limitField.value =  limitField.value.replace(/\n/g, "");//행바꿈제거
			var newdata= "";
		 for (var int = 0; int < 5; int++) {
			 newdata=newdata+"\n" +lineSplit[int];
		}
		 limitField.value=newdata;
	}


}

function limitText(limitField, limitCount, limitNum) {
	var str_len = limitField.value.length; // 해당 필드 길이
	var cbyte = this.textLengthByte(limitField.value); // 필드 바이트 체크
	var li_len = 0;
	// for (var i = 0; i < str_len; i++) {
	// if (cbyte <= limitNum) {// 한계 수보다 필드 바이트가 작다면 얼마나 그 차이 계산,,
	// li_len = i + 1;
	// }
	// }



	// 라인수 제안 메시지
	var lineSplit = limitField.value.split("\n");

	if (lineSplit.length > 4 && event.keyCode == 13) {
       //   console.log('(lineSplit.length', lineSplit.length);
		event.returnValue = false;

	}

	// console.log('cbyte', cbyte);
	// console.log('limitNum', limitNum);
	if (cbyte > limitNum) {
		limitField.value = subByte(limitField.value, limitNum); // 잘라서 보여줘야
		limitCount.value = limitNum;
	} else {

		limitCount.value = cbyte; // limitCount 표현할 곳
	}
}




function gf_replaceExtraChar(obj){
	var inputVal = obj[0].value;
	obj[0].value = inputVal.replace(/[\!\@\#\$\%\^\&\*\(\)\+\=\|\\\~\[\]\{\}\:\;\"\'\<\>\/\?\`]/g, '');
}

function gf_replaceOnlyNumber(obj){
	var inputVal = obj[0].value;
	obj[0].value = inputVal.replace(/[ㄱ-히|ㅏ-ㅣ|가-힣|a-z|A-Z|\!\@\#\$\%\^\&\*\(\)\+\=\|\\\~\[\]\{\}\:\;\"\'\<\>\/\?\`]/g, '');
}


function subByte(str, len) {

	var count = 0;

	for (var i = 0; i < str.length; i++) {
		if (escape(str.charAt(i)).length >= 4)
			count += 2;
		else if (escape(str.charAt(i)) != "%0D")
			count++;

		if (count > len) {
			if (escape(str.charAt(i)) == "%0A")
				i--;
			break;
		}
	}
	return str.substring(0, i);
}

function textLengthByte(str) {
	var length = 0;
	for (var i = 0; i < str.length; i++) {
		if (escape(str.charAt(i)).length >= 4)
			length += 2;
		else if (escape(str.charAt(i)) == "%A7")
			length += 2;
		else if (escape(str.charAt(i)) != "%0D")
			length++;
	}

	return length;
}

function checkPassword(pageName, password) {
	var passwordNum = password.length;
	var pwdStr = [ "ABCDEFGHIJKLMNOPQRSTUVWXYZ", "abcdefghijklmnopqrstuvwxyz",
	               "1234567890", ",./;'[]\\`-=<>?:\"{}~!@#$%^&*()_+" ];
	var cons = [ "qwer", "rewq", "wert", "trew", "erty", "ytre", "rtyu", "uytr", "tyui", "iuyt", "yuio", "oiuy", "uiop", "poiu",
	             "asdf", "fdsa", "sdfg", "gfds", "dfgh", "hgfd", "fghj", "jhgf", "ghjk", "kjhg", "hjkl", "lkjh",
	             "zxcv", "vcxz", "xcvb", "bvcx", "cvbn", "nbvc", "vbnm", "mnbv",
	             "1234", "4321", "2345", "5432", "3456", "6543", "4567", "7654", "5678", "8765", "6789", "9876", "7890", "0987" ];
	/** 자리수 검사* */
	if ((passwordNum < 8) || (passwordNum > 20)) {
		// alert("비밀번호는 8 자리 이상 20 자리 미만이여야 합니다.")
		lego_common_alert(pageName, "UI_MSG_WARN_PW_DIGITSCHECK".i18n());
		return false;
	}

	var intUse = [ 0, 0, 0, 0 ];
	var i;
	var intOrder = 0;
	var intRepeat = 0;
	for (i = 0; i < passwordNum; i++) {
		var chrPwd = password.charAt(i) + "";
		if ((passwordNum > i + 1)) {
			var nowPw = password.charAt(i);
			var nextPw = password.charAt(i + 1);
			if (nowPw + 1 == nextPw) {
				intOrder++;// 순차적인 문자 확인
			} else if ((password.charAt(i) == password.charAt(i + 1))) { // 같은
				// 문자인지
				intRepeat++; // 반복적인 문자 확인
			}
			;
		}
		;

		if (pwdStr[0].indexOf(chrPwd) >= 0) {
			intUse[0] = 1;
		} else if (pwdStr[1].indexOf(chrPwd) >= 0) {
			intUse[1] = 1;
		} else if (pwdStr[2].indexOf(chrPwd) >= 0) {
			intUse[2] = 1;
		} else if (pwdStr[3].indexOf(chrPwd) >= 0) {
			intUse[3] = 1;
		} else {
			break;
		}
		;
	}

	if (passwordNum != i || intUse[0] + intUse[1] + intUse[2] + intUse[3] < 3) {
		lego_common_alert(pageName, "UI_MSG_WARN_PW_COMBINATION_THREE_SCHECK".i18n());
		return false;

	} else if (3 <= intOrder) {
		lego_common_alert(pageName, "UI_MSG_WARN_PW_FOUR_CONSECUTIVE_SCHECK".i18n());
		return false;
	} else if (3 <= intRepeat) {
		lego_common_alert(pageName, "UI_MSG_WARN_PW_FOUR_CONTINUOUS_SCHECK".i18n());
		return false;
	} else {
		for (i = 0; i < cons.length; i++) {
			if (password.indexOf(cons[i]) >= 0) {
				lego_common_alert(pageName,
						"UI_MSG_WARN_PW_KEYBOARD_FOUR_CONTINUOUS_SCHECK".i18n());
				return false;
			}
			;
		}
		;
	}
	;
	return true;
}

/**
 * from-to date 전/후 관계 체크
 *
 * @param {}
 *            val
 * @return {Boolean}
 */
function fromToDateCheck(from, to) {
	if (from != null && to != null) {
		if (from > to) {
			return false;
		}
	}
	return true;
}

var Validator = {
		out : {},
		required : function(val) {
			Validator.out.succ = requiredCheck(val);
			Validator.out.msg = "UI_MSG_WARN_REQUIRED".i18n();
			return Validator.out;
		},
		phoneCheck : function(val) {
			Validator.out.succ = phoneCheck(val);
			Validator.out.msg = "UI_MSG_WARN_PHONECHECK".i18n();
			return Validator.out;
		},
		onlyNumCheck : function(val) {
			Validator.out.succ = onlyNumCheck(val);
			Validator.out.msg = "UI_MSG_WARN_ONLYNUMCHECK".i18n();
			return Validator.out;
		},
		koEngNullNumCheck : function(val) {
			Validator.out.succ = koEngNullNumCheck(val);
			Validator.out.msg = "UI_MSG_WARN_KOENGNULLNUMCHECK".i18n();
			return Validator.out;
		},

		correctKoEngNullNumCheck : function(val) {
			Validator.out.succ = correctKoEngNullNumCheck(val);
			Validator.out.msg = "UI_MSG_WARN_CORRECTKOENGNULLNUMCHECK".i18n();
			return Validator.out;
		},

		engNumSpcCharCheck : function(val) {
			Validator.out.succ = engNumSpcCharCheck(val);
			Validator.out.msg = "UI_MSG_WARN_ENGNUMSPCCHARCHECK".i18n();
			return Validator.out;
		},

		engNumCheck : function(val) {
			Validator.out.succ = engNumCheck(val);
			Validator.out.msg = "UI_MSG_WARN_ENGNUMCHECK".i18n();
			return Validator.out;
		},

		engCheck : function(val) {
			Validator.out.succ = engCheck(val);
			Validator.out.msg = "UI_MSG_WARN_ENGCHECK".i18n();
			return Validator.out;
		},
		emailCheck : function(val) {
			Validator.out.succ = emailCheck(val);
			Validator.out.msg = "UI_MSG_WARN_EMAILCHECK".i18n();
			return Validator.out;
		},
		emailsCheck : function(val) {
			Validator.out.succ = emailsCheck(val);
			Validator.out.msg = "UI_MSG_WARN_EMAILCHECK".i18n();
			return Validator.out;
		},
		urlCheck : function(val) {
			Validator.out.succ = urlCheck(val);
			Validator.out.msg = "UI_MSG_WARN_URLCHECK".i18n();
			return Validator.out;
		},

}
var _vcheck_n_add = function(input) {
	var d;
	var vl = input.getAttribute('vtype').split(',');
	var v = input.value;
	var isValid = true
	for (var i = 0; i < vl.length; ++i) {
		var vt = vl[i];
		var valResult = Validator[vt](v);
		if (!valResult.succ) {
			d = {
					'tagname' : input.localName,
					'name' : input.name,
					'id' : input.id,
					'vname' : input.getAttribute('vname') || '',
					'vtype' : vt,
					'errMsg' : valResult.msg
			};
			isValid = false;
		//	console.log(d);
			break;

		}
	}
	return d;
}

/**
 * 한글 삭제함
 *
 * @param obj
 */
function gf_delHangul(obj) {
	var pattern = /[ㄱ-히|ㅏ-ㅣ|가-힣]/;
	//var objVal = obj.value;
	while (true) {
		if (!pattern.test(obj.value)) {
			break;
		}
		else{
			obj.value = obj.value.replace(pattern, '');
		}
	}

}

/**
 * 저장전 폼 벨리데이션
 *
 * @param pageName
 * @param form
 * @returns {Boolean}
 */
function validateFormValues(pageName, form) {

	var returnVal = false;
	var vname;
	var errMsg;
	var $inputs = form.find('input,textarea');
	$inputs.each(function() {
		$input = this;
		if (!$input.getAttribute('vtype')) {
			return;
		}
		if ($input.disabled) {
			return;
		}
		err = _vcheck_n_add($input);
		if (err) {
			returnVal = false;
			vname = "[" + err.vname + "]";
			errMsg = err.errMsg;
			return false;
		} else {
			returnVal = true;
		}

	});

	if (!returnVal) {
		lego_common_alert(pageName, vname + " " + errMsg);
	}

	return returnVal;
}

/*
 * * FUNCTION 명 : gf_checkHangul FUNCTION 기능설명 : 입력한 값에 한글 제한
 *
 * @param obj : INPUT TYPE Object @param evt : 화면 event @return N/A
 */
function gf_checkHangul(obj, evt) {
	/*
	 * 정규식을 사용하여 한글 포함여부 확인 IE : ime-mode:disabled; 멀티브라우져 : css 적용이 안되어, 체크로직을
	 * 추가 적용함. 한글이 중간에 입력되는것은 막을 수 있지만 전체 한글은 못막음 ㅜㅜ(이 이벤트를 안탐)
	 */

	var objVal = obj.value;
	var pattern = /[ㄱ-히|ㅏ-ㅣ|가-힣]/;
//	console.log('objVal', objVal);
	if (pattern.test(objVal)) {
		obj.style.imeMode = "disabled";
		obj.focus();
		if (window.event) {
			var x = objVal.split(pattern).join("");
			obj.value = x;
		} else {
			evt.preventDefault();
		}
	}
}

function gf_checkTypes(obj, type, evt) {
	var key = "";
	if (window.event && navigator.appName == "Microsoft Internet Explorer") {
		key = evt.keyCode;

	} else if (evt) {
		key = evt.which;
		// "<-"는 예외처리
		if (key == 0x08 || key == 0) {
			return true;
		}
	} else {
		return true;
	}


	switch(type) {
	case "NUM":    // 숫자 and ,
	{
		gf_checkHangul(obj, evt);
		obj.style.imeMode = "disabled";
		if(!((key >= 0x30 && key <= 0x39)) ){
			obj.focus();
			if(window.event && navigator.appName == "Microsoft Internet Explorer"){
				window.event.returnValue = false;
			}else{
				evt.preventDefault();
				return false;
			}
		}else{
			return true;
		}

		break;
	}
	case "NUMB":    // 숫자 and , +
	{
		//console.log(key);
		gf_checkHangul(obj, evt);
		obj.style.imeMode = "disabled";
		//console.log(key);
		if(!((key >= 0x30 && key <= 0x39)|| key == 43 )){
			obj.focus();
			if(window.event && navigator.appName == "Microsoft Internet Explorer"){
				window.event.returnValue = false;
			}else{
				evt.preventDefault();
				return false;
			}
		}else{
			return true;
		}

		break;
	}

	case "NOTSPC" :    // 한글, 영문, 숫자,  Space , _ (언더바) .(마침표) ,(쉼표) -(하이픈) /(슬래쉬) (enter )  (괄호)http://web.cs.mun.ca/~michael/c/ascii-table.html
	{    obj.style.imeMode = "disabled";
//	 console.log('key', key);
	if(!(((key >= 0x61 && key <= 0x7A) || (key >= 0x41 && key <= 0x5A)) || (key >= 0x2E && key <= 0x3A) ||  key == 0x20 || key ==0x2e
			||  key ==0x5f || key ==45 || key ==44 || key ==13|| key ==41|| key ==40))
	{
		obj.focus();
		if(window.event && navigator.appName == "Microsoft Internet Explorer"){
			window.event.returnValue = false;
		}else{
			evt.preventDefault();
			return false;
		}
	}
	else
	{ return true;
	}

	break;
	}
	case "ECNOS":    // 영문 또는 숫자 .-_
	{
		gf_checkHangul(obj, evt);
		obj.style.imeMode = "disabled";

		if(!(((key >= 0x61 && key <= 0x7A) || (key >= 0x41 && key <= 0x5A)) || (key >= 0x30 && key <= 0x39) || (key>=0x60 && key<= 0x69) || key == 0x2D || key==0x5F || key == 9 || key==190
				|| key==189 || key==46|| key ==41|| key ==40 ||key ==41|| key ==40))
		{
			obj.focus();
			if(window.event && navigator.appName == "Microsoft Internet Explorer"){
				window.event.returnValue = false;
			}else{
				evt.preventDefault();
				return false;
			}
		}
		else return true;
		break;
	}
	case "ECNOS2":    // 영문 또는 숫자 ._
	{
		gf_checkHangul(obj, evt);
		obj.style.imeMode = "disabled";
	//	console.log('key', key);
		if(!(((key >= 0x61 && key <= 0x7A) || (key >= 0x41 && key <= 0x5A)) || (key >= 0x30 && key <= 0x39) || (key>=0x60 && key<= 0x69) || key==0x5F || key==190 || key==189|| key==18|| key==45 || key == 96||key ==41|| key ==40))
		{
		//	console.log('s', key);
			obj.focus();
			if(window.event && navigator.appName == "Microsoft Internet Explorer"){
				window.event.returnValue = false;
			}else{
				evt.preventDefault();
				return false;
			}
		}
		else return true;
		break;
	}
	case "HENSS":    // 한글, 숫자, 영문, 스페이스 - _
	{
		obj.style.imeMode = "active";

		if(!((key >= 0xAC00 && key <= 0xD7A3) || (key >= 0x3131 && key <= 0x314E) || (key >= 0x30 && key <= 0x39) || (key>=0x60 && key<= 0x69) || (key >= 0x61 && key <= 0x7A) || (key >= 0x41 && key <= 0x5A) ||key == 0x2D|| key==0x5F|| key == 0x20))
		{
			obj.focus();
			if(window.event && navigator.appName == "Microsoft Internet Explorer"){
				window.event.returnValue = false;
			}else{
				evt.preventDefault();
				return false;
			}
		}
		else return true;
		break;
	}
	case "ENGNUM" :    // , 영문, 숫자,  Space , _ , . http://web.cs.mun.ca/~michael/c/ascii-table.html
	{
		gf_checkHangul(obj, evt);
		obj.style.imeMode = "disabled";
		if(!(((key >= 0x61 && key <= 0x7A) || (key >= 0x41 && key <= 0x5A)) || (key >= 0x2E && key <= 0x3A)||  key == 0x20 || key ==0x2e
				||  key ==0x5f ||  key ==0x5f || key ==45 || key ==44|| key ==41|| key ==40))
		{
			obj.focus();
			if(window.event && navigator.appName == "Microsoft Internet Explorer"){
				window.event.returnValue = false;
			}else{
				evt.preventDefault();
				return false;

			}
		}
	}
	}
}
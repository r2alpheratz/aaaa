if (!String.prototype.format) {
	String.prototype.format = function(args) {
		return this.replace(/{(\d+)}/g, function(match, number) {
			return typeof args[number] != 'undefined'
				? args[number]
				: match
			;
		});
	};
}

//aui multi language
String.prototype.i18n = function() {

	var key = this.valueOf();

	var val = i18n.translate(key);
/*
	if(!LANG || !(LANG[key])){
		return key;
	}
	var val = LANG[key];

	if (!val) val = key;

	if (arguments.length > 0) {
		val = val.format(arguments[0]);
	}
*/
//	console.log(key);
	//console.log(args);
	if (arguments.length > 0) {
		val = val.format(arguments[0]);
	}
	return val;
}

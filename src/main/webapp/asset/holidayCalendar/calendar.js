

/*$('#countryCombo').on('select', function (event) {
	var args = event.args;
	var item = $('#countryCombo').jqxComboBox('getItem', args.index);
	$('#grdCd').val(item.value);
});
*/


$(document).ready(function() {

	
	var codeUrl = CONTEXTPATH + '/searchCountryCodeList';
	alert(codeUrl+"3");
	var codeData = {};
	
	lego_common_ajax(codeUrl, codeData, function(codeData) {
		var countryCodeSource = codeData.searchCountryCodeList;

		$("#countryCombo").jqxComboBox({
			selectedIndex : 0,
			source : countryCodeSource,
			width : 100,
			height : 15,
			dropDownHeight : 40,
			autoDropDownHeight : true,
			displayMember : "codeEngNm",
			valueMember : "codeSq"
		});
		$("#countryCombo").find('input').attr('readonly', 'readonly');
		

	});
});




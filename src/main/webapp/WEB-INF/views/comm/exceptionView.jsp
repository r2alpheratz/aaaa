<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=9; IE=8; IE=7; IE=EDGE" />


</head>
<body>
	<div id="wrap"></div>

	<script type="text/javascript">

	var MAIN_PAGE="exceptionView";

	$(document).ready(function() {
  	var errCode = "${errCode}";
	   var errMg = "${errormsg}";
	   lego_common_alert("ERROR", errMg);

	});
		</script>


</body>
</html>

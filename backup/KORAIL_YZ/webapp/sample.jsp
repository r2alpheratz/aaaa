<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<style type="text/css">
		#newsPane{
			float: left;
			width:300px;
			height:400px;
			border-style:groove;
			border-width:1px;
		}
		#actionPane{
			float: left;
			width:700px;
			height:400px;
			border-style:groove;
			border-width:1px;
		}
		#actionTable{
			width:100%;
		}
		#newsTable{
			width:100%;
		}
	</style>
	<title>Insert title here</title>
	<script src="<c:url value="/js/jquery/jquery-1.7.1.js" />" type="text/javascript"></script>
	<script language="javascript">
		$(function(){
			$("#btnQuery").click(function(){
				queryData();
			});
		});
		function queryData(){
			$.ajax({
				type:"post"
				, url:"<c:url value="/sample/dynamic.do" />"
				, data : {
					"seqs":["2", "3"]
				}, beforeSend:function(){
				}, success:function(data){
					var result = data.result; 
					alert(result);
				}, error:function(data, status, err){
					alert("Error : " + err);
				}, complete:function(){
				}
			});
		}
	</script>
</head>
<body>
	<div id="buttonPane">
		<input id="btnQuery" type="button" value="query" />
	</div>
	<div id="newsPane">
		NEWS
		<table id="newsTable">
			<thead>
				<tr>
					<th>News</th>
				</tr>
			</thead>
		</table>
	</div>
	<div id="actionPane">
		ACTION
		<table id="actionTable">
			<colgroup>
				<col width="50%" />
				<col width="50%" />
			</colgroup>
			<thead>
				<tr>
					<th>Action Id</th>
					<th>Service Id</th>
				</tr>
			</thead>
		</table>
	</div>
</body>
</html>
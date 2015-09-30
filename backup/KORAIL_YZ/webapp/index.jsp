<%@ page contentType="text/html;charset=utf-8" pageEncoding="utf-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
	<title>Cosmos_Set</title>
</head>

<c:set var="ctxName" value="<%=request.getContextPath()%>"/>
<link rel="stylesheet" type="text/css" href="${ctxName}/css/style.css" >


<script language="javascript">

document.onkeydown = function(e) {
	if (e == null) {	//from IE
		login();
	} else {			//from not IE
		login(e);
	}
}

function login(e) {
	var key;
	if (e == null) {
		key	= window.event.keyCode;
	} else {
		key	= e.keyCode;
	}

	if (key	!= 13){
		return;
	}

	if (loginForm.userId.value == '') {
		alert('userId를 입력하시오');
		return;
	}

	if (loginForm.password.value == '') {
		alert('password를 입력하시오');
		return;
	}

	document.loginForm.action = "login.do";
	document.loginForm.target = 'iLoginFrame';
	document.loginForm.submit();
}

function gotoMain() {
	document.loginForm.action = "main.jcdo";
	document.loginForm.target = '_self';
	document.loginForm.submit();
}

function fnLogin(){
	if (loginForm.loginId.value == '') {
		alert('loginId를 입력하시오');
		return;
	}else{
	document.loginForm.action = "cms.login";
	document.loginForm.target = '_self';
	document.loginForm.submit();
	
	}
}
</script>

<body bgcolor="#FFFFFF"	leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loginForm.userId.focus();">
	<table width="960" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td	valign="top">&nbsp;</td>
		</tr>
		<tr>
			<td	width="960"	valign="top" align="center">
<!--
				<p align="center"><b><a href="jsp/commNewsList.jsp">CommSVC Test</a></b><p/>
				<p align="center"><b><a href="jsp/CamelCasedNewsList.jsp">CamelCase Test</a></b><p/>
				
				<p align="center"><b><a href="newsSvc.jsp">NewsSVC Test</a></b><p/>
-->
				
				<p align="center"><b><a href="${ctxName}/com/jspSample/news/listPageNews.do?pageSize=10&pageOffset=0">Set2 Sample</a></b><p/>

<!--					
				<p align="center"><b><a href="${ctxName}/com/sampledomain/scroll/scrollPage.do">Scroll Sample</a></b><p/>

				<p align="center"><b><a href="${ctxName}/set1/sample.do?sampleKey=1">Set1 Sample</a></b><p/>

				<p align="center"><b><a href="jsp/sqlTool.jsp">sqlTool</a></b><p/>
				<div align="center">
					<form id="loginForm" name="loginForm" method="post" >
						<table width="100%"	border="0" cellpadding=1 cellspacing=1 bgcolor="#CCCCCC">
	  						<tr>
								<td width="60%" align="right" >LOGIN ID :
		  							<input type="text" id="loginId" name="loginId" class="input" size="15" >
		  						</td>
								<td  width="40%" >
									<button onClick="javascriopt:fnLogin();">Click!!!
                                    </button>
								</td>
							</tr>
	  						<tr>
								<td	width="30%"	align=center>passwd :
		  							<input type="password" id="password" name="password" style='font-size:9pt;' size="15" onkeydown="" >
		  						</td>
							</tr>
						</table>
					</form>
					<p></p>
	  			</div>
-->
			</td>
		</tr>
		<tr>
			<td height="50" bgcolor="#8393D5" align=center>
				<table border=0>
					<tr>
 						<td align=center valign=top><font size=2 color="#FFFFFF"><b>
  							Copyright(c) 2012	Samsung	SDS	Co., Ltd. All rights reserved.
 						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>

<iframe name="iLoginFrame" scrolling=no marginWidth="0" marginHeight="0" frameborder=0 width=0  height=0  src="">
</iframe>

</body>

</html>

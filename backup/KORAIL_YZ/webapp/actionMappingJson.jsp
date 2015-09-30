<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import=
		"org.springframework.jdbc.datasource.*,org.springframework.web.context.support.WebApplicationContextUtils,org.springframework.web.context.WebApplicationContext,org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate,org.springframework.jdbc.core.JdbcTemplate"
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--
	CREATE TABLE ACTION_MAPPING(
		ATN_ID VARCHAR(255) NOT NULL PRIMARY KEY
		, SVC_ID VARCHAR(255)
		, METHOD VARCHAR(255)
		, SQL_ID VARCHAR(255)
		, COUNT_ID VARCHAR(255)
		, FWD_YN CHAR(1) DEFAULT 'N'
		, SCREEN_URL VARCHAR(255) NOT NULL
	);
	
--%>

<%!
	private String nullConvert(Object obj){
		return nullConvert(obj, "");
	}
	private String nullConvert(Object obj, String defaultVal){
		if(null == obj){
			return defaultVal;
		}else{
			return obj.toString().trim();
		}
	}
	
	final String selectSql = "SELECT \n"
			+ " _Value \n"
			+ " FROM a_map \n"
			+ " WHERE _id = :actionId";
			
	final String insertSql = "INSERT INTO a_map \n"
			+ " (_id, _value) \n"
			+ " VALUES \n"
			+ " (:actionId, :value )";
			
	final String updateSql = "UPDATE a_map SET \n"
			+ " _value = :value \n"
			+ " WHERE _id = :actionId ";
			
	final String deleteSql = "DELETE FROM a_map WHERE _id = :actionId";
	
	final String listSql = "SELECT _id, _value \n"
			+ " FROM a_map \n"
			+ " WHERE _id like '%' || :searchActionId || '%'\n"
			+ " ORDER BY _id ASC \n";
	final String countSql = "SELECT COUNT(1) cnt \n"
			+ " FROM a_map \n"
			+ " WHERE _id like '%' || :searchActionId || '%'\n";
			
	final String pagingListSql = "SELECT * FROM ( \n"
			+ "		SELECT rownum pagingRowNum, a.* FROM ( \n"
			+ listSql
			+ "		) A \n"
			+ "		WHERE ROWNUM <= :pageSize * :pageIndex \n"
			+ ") WHERE pagingRowNum > :pageSize * (:pageIndex - 1) ";
%>
<%
	javax.servlet.ServletContext servletContext = pageContext.getServletContext();
	WebApplicationContext context = WebApplicationContextUtils.getRequiredWebApplicationContext(servletContext);

	javax.sql.DataSource dataSource = (javax.sql.DataSource) context.getBean("dataSource");
	java.sql.Connection con = dataSource.getConnection();
	con.setAutoCommit(true);
	SingleConnectionDataSource singleDataSource = new SingleConnectionDataSource(con, true);

	NamedParameterJdbcTemplate jdbcTemplate = new NamedParameterJdbcTemplate(singleDataSource);

	// CRUD flag
	String cmd = nullConvert(request.getParameter("cmd"));
	int pageSize = Integer.parseInt(nullConvert(request.getParameter("pageSize"), "20"));
	int pageIndex = Integer.parseInt(nullConvert(request.getParameter("pageIndex"), "1"));
	request.setAttribute("pageSize", pageSize);
	request.setAttribute("pageIndex", pageIndex);

	Map paramMap = new HashMap();
	paramMap.put("actionId", nullConvert(request.getParameter("actionId")));
	paramMap.put("value", nullConvert(request.getParameter("value")));
	paramMap.put("searchActionId", nullConvert(request.getParameter("searchActionId")));
	
	paramMap.put("pageSize", pageSize);
	paramMap.put("pageIndex", pageIndex);
	
	if ("insert".equals(cmd)) {
		jdbcTemplate.update(insertSql, paramMap);
	}
	else if ("update".equals(cmd)) {
		jdbcTemplate.update(updateSql, paramMap);
	}
	else if ("delete".equals(cmd)) {
		jdbcTemplate.update(deleteSql, paramMap);
	}

	int recordCount = jdbcTemplate.queryForInt(countSql, paramMap);
	List resultList = jdbcTemplate.queryForList(pagingListSql, paramMap);
	
	if (resultList == null) {
		resultList = new ArrayList();
	}
	request.setAttribute("recordCount", recordCount);
	request.setAttribute("resultList", resultList);
	
	con.commit();

	((SingleConnectionDataSource) ((JdbcTemplate) jdbcTemplate.getJdbcOperations()).getDataSource()).destroy();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 
<html xmlns="http://www.w3.org/1999/xhtml"> 
<head> 
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<title>Insert title here</title>
<style type="text/css">
body {
	margin: 0;
	font-family: Tahoma, Sans-serif;
	font-size: .9em;
	background: #fff;
	color: #000;
}

table {
	margin: 0;
	font-family: Tahoma, Sans-serif;
	font-size: .9em;
	background: #fff;
	color: #000;
}

table {
	border-collapse: collapse;
	border: 1px solid #000000;
	font: normal 11px verdana, arial, helvetica, sans-serif;
	color: #000000;
	background: #ffffff;
}
td, th {
	border: 1px solid #000000;
	padding: .2em;
	color: #000000;
}

.hover {
	cursor: 　hand;
	background-color: Yellow;
}

.trclick {
	background-color: #00CCCC;
}

</style>
<script	src="${pageContext.request.contextPath}/js/jquery/jquery-1.7.1.js"	type="text/javascript"></script>
<script type="text/javascript">
$(document).ready(function () {
	var table = $("#list");
	var tr = table.find(">tr");

	$("#list tbody tr:gt(0)").hover(
		function () { $(this).addClass("hover"); },
		function () { $(this).removeClass("hover"); }
	);

	$("#list tbody tr").click( function() {
		$("[name=actionId]").removeClass("trclick");
		$("[name=method]").removeClass("trclick");
		
		$("#list tr").removeClass("trclick");
		$(this).addClass("trclick");

		$("#formModeEdit").click();
		var actionId = "";
		var value = "";

		$(this).find("td").each(function(i) {
			if(i == 0)	actionId = $(this).text();
			if(i == 1)	value = $(this).text();
		});
		
		fillFormData(actionId, value);
	});

	$("#formModeCreate").click( function() {
		$("#isUpdate").val("insert");
	});
	$("#formModeEdit").click( function() {
		$("#isUpdate").val("update");
	});
	
	$("#clearButton").click(function(){
		fillFormData("", "");
	});
	$("#updateButton").click( function() {
		if($("#isUpdate").val() == "update") {
			$("#detailForm").attr("action", "${pageContext.request.contextPath}/actionMappingJson.jsp?cmd=update").submit();
		} else {
			$("#detailForm").attr("action", "${pageContext.request.contextPath}/actionMappingJson.jsp?cmd=insert").submit();
		}
	});

	$("#deleteButton").click( function() {
		$("#deletedActionId").val($("[name=actionId]").val());
		$("#detailForm").attr("action", "${pageContext.request.contextPath}/actionMappingJson.jsp?cmd=delete").submit();
	});
});

function movePage(newPageNo){
	$("#pageIndex").val(newPageNo);
	$("#listForm").submit();
}
function fillFormData(actionId, value){
	$("[name=actionId]").val(actionId);
	$("[name=value]").val(value);
}

</script>
</head>
<body>
<form id="listForm" name="listForm"
	action="${pageContext.request.contextPath}/actionMappingJson.jsp?cmd=list"
	method="get">
	searchActionId : <input name="searchActionId" value="${param.searchActionId}" /> 
	<input type="hidden" id="pageSize" name="pageSize" value="${pageSize}" />
	<input type="hidden" id="pageIndex" name="pageIndex" value="${pageIndex}" />
	<input type="submit" value="조회" />
	
    <table id="list" width="100%" >
		<colgroup>
			<col width="250" />
			<col width="*" />
		</colgroup>
		<thead>
    	<tr align="center" bgcolor="#dddddd">
    		<th>actionId</th>
    		<th>value</th>
    	</tr>
		</thead>
		<tbody>
    	<c:forEach  var="item" items="${resultList}"  varStatus="status">
    	<tr>
    		<td>${item._id}</td>
    		<td>${item._value}</td>
    	</tr>
        </c:forEach>
		</tbody>
		<tfoot>
		<tr>
			<td colspan="7" align="center">
				<c:set var="pageBlockNoTemp" value="${ (i - ((i-1) mod 5)) / 5    }" />
				
				<c:set var="pageBlockNo" value = "${ pageBlockNoTemp - pageBlockNoTemp mod 1 + 1}" />
				<c:set var="pageCountTemp" value="${ recordCount / pageSize }" />
				<c:set var="maxPageNo" value="${pageCountTemp + (1-(pageCountTemp%1))%1}" />
				
				<c:set var="pageBlockStart" value="${(pageBlockNo-1) * pageSize + 1}" />
				<!--
				<c:set var="pageBlockEnd" value="${pageBlockNo * pageSize }" />
				
				<c:if test="${pageBlockEnd gt maxPageNo}">
					<c:set var="pageBlockEnd" value="${maxPageNo }" />
				</c:if>
				-->
				
				<c:set var="pageBlockEnd" value="${maxPageNo }" />
				
				<c:forEach var="i" begin="${pageBlockStart}" end="${pageBlockEnd}" >
					<c:if test="${i == pageIndex}">
						[<B><c:out value="${i}" /></B>]
					</c:if>
					<c:if test="${i != pageIndex}">
						[<a href="#" onclick="movePage(<c:out value="${i}" />);"><c:out value="${i}" /></a>]
					</c:if>
                </c:forEach>
			</td>
		</tr>
		</tfoot>
    </table>
</form>
<br />

<form id="detailForm" name="detailForm" action="${pageContext.request.contextPath}/actionMappingJson.jsp?cmd=update" method="post">
<table width="100%" border="1" cellspacing="0" cellpadding="0">
	<tr>
		<td width="10%">actionId</td>
		<td><input id="actionId" name="actionId" size="50" value="" /></td>
	</tr>
	<tr>
		<td>value</td>
		<td>
			<textarea id="value" name="value" rows="10" cols="120" ></textarea>
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="radio" name="formMode" id="formModeCreate" value=""> <label for="formModeCreate">생성모드</label>
			<input type="radio" name="formMode" id="formModeEdit" value=""> <label for="formModeEdit">수정모드</label>
		</td>
	</tr>
</table>
<input id="isUpdate" type="hidden" name="isUpdate" value="" />
<input id="clearButton" type="button" value="Clear" />
<input id="updateButton" type="button" value="저장" />
<input id="deleteButton" type="button" value="삭제" />
</form>
</body>
</html>
	
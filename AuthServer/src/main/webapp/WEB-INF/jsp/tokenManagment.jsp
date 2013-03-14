<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Token Managment of - <security:authentication
		property="principal.username" /></title>

<link
	href="<c:url value="/resources/css/ui-darkness/jquery-ui-1.9.2.custom.css"/>"
	rel="stylesheet">
<script src="<c:url value="/resources/js/jquery-1.8.3.js"/>"></script>
<script src="<c:url value="/resources/js/jquery-ui-1.9.2.custom.js"/>"></script>

<%
	String url = request.getScheme() + "://" + request.getServerName()
			+ ":" + request.getServerPort() + request.getContextPath();
%>

<script type="text/javascript">
var userName="<security:authentication property="principal.username" htmlEscape="false"/>";
$(document).ready(function() {
	tokensURL = "<%=url%>/oauth/users/" + userName + "/tokens";
		$.get(tokensURL, function(data) {
			var tbody = $("#tbody");
			$.each(data, createTable);
		});
	});
	function deleteToken(token) {
		deleteURL = "<%=url%>/oauth/users/" + userName + "/tokens/"+ token;
		$.ajax({
			url : deleteURL,
			type : 'DELETE',
			dataType : 'json',
			contentType : "application/json; charset=utf-8",
			error : function(jqXHR, textStatus,
					errorThrown) {
				alert("error " + errorThrown);
			},
			success : function(data) {
				location.reload();
			}
		});
	}
	function createTable(i, object) {
		var clientId = object.client_id;
		var tr = $("<tr>");
		var td = $("<td>");
		td.html(object.token_type);
		td.appendTo(tr);
		td = $("<td>");
		td.html(clientId);
		td.appendTo(tr);
		td = $("<td>");
		td.html(object.access_token);
		td.appendTo(tr);
		td = $("<td>");
		td.html(object.refresh_token);
		td.appendTo(tr);
		td = $("<td>");
		td.html(object.scope);
		td.appendTo(tr);
		td = $("<td>");
		var deleteButton = $("<span>");
		deleteButton.addClass("ui-icon ui-icon-trash");
		deleteButton.click(function() {
			deleteToken(object.access_token);
		});
		deleteButton.appendTo(td);
		td.appendTo(tr);
		tr.appendTo(tbody);
	}
</script>
</head>
<body>
	<h1>
		Token Managment of -
		<security:authentication property="principal.username" />
	</h1>
	<div id="content">
		<table border="1" width="100%" class="ui-widget">
			<thead class="ui-widget-header">
				<tr>
					<th>TokenType</th>
					<th>client_id</th>
					<th>Access Token</th>
					<th>Refresh Token</th>
					<th>Scope</th>
					<th>Delete</th>
				</tr>
			</thead>
			<tbody id="tbody" class="ui-widget-content">
			</tbody>
		</table>
	</div>
</body>
</html>
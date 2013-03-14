<%@page contentType="text/html;charset=UTF-8" language="java"%>
<%@page isELIgnored="false"%>
<%@ taglib prefix="authz"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf8" />
<title>REST</title>
<link rel="stylesheet" href="<spring:theme code="css"/>" type="text/css" />
</head>
<body>

	<h1>REST</h1>

	<div id="content">
		<h2>Home</h2>
		<authz:authorize ifNotGranted="ROLE_USER">
			<h2>Login</h2>
			<form id="loginForm" name="loginForm"
				action="<c:url value="/login.do"/>" method="post">
				<p>
					<label>Username: <input type='text' name='j_username'
						value="user_01"></label>
				</p>
				<p>
					<label>Password: <input type="password" name='j_password'
						value="password"></label>
				</p>

				<p>
					<input name="login" value="Login" type="submit">
				</p>
			</form>
		</authz:authorize>
		<authz:authorize ifAllGranted="ROLE_USER">
			<div style="text-align: center">
				<form action="<c:url value="/logout.do"/>">
					<input type="submit" value="Logout">
				</form>
			</div>
		</authz:authorize>
	</div>

	<div id="footer">
		Sample application for <a
			href="http://github.com/SpringSource/spring-security-oauth"
			target="_blank">Spring Security OAuth</a>
	</div>


</body>
</html>

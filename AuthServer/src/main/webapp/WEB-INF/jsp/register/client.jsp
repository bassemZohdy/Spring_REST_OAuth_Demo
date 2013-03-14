<%@page contentType="text/html;charset=UTF-8" language="java"%>
<%@page isELIgnored="false"%>
<%@ taglib prefix="authz"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">




<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf8" />
<title>Register Client</title>
<link rel="stylesheet" href="<spring:theme code="css"/>" type="text/css" />
</head>
<body>
	<h1>Register Client</h1>
	<authz:authorize ifAllGranted="ROLE_USER">
		<form id="registerForm" name="registerForm"
			action='#' method="post">
			<p>
				<label>Client Id: <input type='text' name='clientId'
					value="user_01"></label>
			</p>
			<p>
				<label>Password: <input type="password" name='password'
					value="password"></label>
			</p>

			<p>
				<input name="login" value="Login" type="submit">
			</p>
		</form>
	</authz:authorize>
</body>
</html>
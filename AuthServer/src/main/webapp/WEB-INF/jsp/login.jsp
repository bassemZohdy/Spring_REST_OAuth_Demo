<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf8" />
<title>REST</title>
<!-- <link type="text/css" rel="stylesheet" href="<c:url value="/resources/css/style.css"/>" />-->
	<link rel="stylesheet" href='<spring:theme code="css"/>' type="text/css"/>
</head>

<body>

	<h1>REST</h1>

	<div id="content">
		<c:if test="${not empty param.authentication_error}">
			<h1>Woops!</h1>

			<p class="error">Your login attempt was not successful.</p>
		</c:if>
		<c:if test="${not empty param.authorization_error}">
			<h1>Woops!</h1>

			<p class="error">You are not permitted to access that resource.</p>
		</c:if>

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
				<input name="login" value="Login" type="submit" />
			</p>
		</form>
	</div>

</body>
</html>

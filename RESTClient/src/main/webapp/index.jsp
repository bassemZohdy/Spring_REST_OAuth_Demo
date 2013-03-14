<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>REST Client</title>
<!-- http://localhost:8080 -->
<%
	//String url = request.getScheme() + "://" + request.getServerName()+ ":" + request.getServerPort();
	//String url = "https" + "://" + request.getServerName()+ ":" + "8443";
	String url = "http" + "://" + request.getServerName() + ":"	+ "8080";
	//String clientURL="http://restclient-oauth.cloudfoundry.com";
	//String serverURL = "https://restserver-oauth.cloudfoundry.com";
	String clientURL = url + "/RESTClient";
	String serverURL = url + "/RESTServer";
	String authURL = url + "/AuthServer";
%>

<script type="text/javascript" src="js/jquery-1.8.3.js"></script>
<script type="text/javascript" src="js/jso.js"></script>
<script type="text/javascript">
	$(document)
			.ready(
					function() {
						jso_configure({
							"rest" : {
								client_id : "client1",
								redirect_uri : "<%=clientURL%>/index.jsp",
								debug : true,
								authorization : "<%=authURL%>/oauth/authorize"
							}
						});

						jso_ensureTokens({
							"rest" : [ "read","write", "delete" ]
						});

						jso_dump();
						$("#getButton").click(function() {
							getPerson($("#id").val());
							return false;
						});

						$("#delete").click(function() {
							deletePerson($("#id").val());
							return false;
						});

						$("#save").click(function() {
							savePerson();
							return false;
						});

						$("#clear").click(function() {
							$("#id").val("");
							$("#json").html("");
							$("#personId").val("");
							$("#firstName").val("");
							$("#lastName").val("");
							$("#number").val("");
							$("#birthDate").val("");
							return false;
						});

					});

	function getPerson(id) {
		var oneEntity = false;
		if (id) {
			var url = "<%=serverURL%>/rest/person/" + id;
			oneEntity = true;
		} else {
			var url = "<%=serverURL%>/rest/persons/";
			oneEntity = false;
		}
		$.oajax({
			url : url,
			jso_provider : "rest", // Will match the config identifier
			dataType : 'json',
			error : function(jqXHR, textStatus, errorThrown) {
				if(errorThrown == "Unauthorized"){
					location.reload();
				}else{
					alert("error:"+errorThrown);
				}
			},
			success : function(data) {
				var myObj = eval(data);
				if (oneEntity) {
					loadForm(myObj);
				}else{
					$("#json").html(JSON.stringify(myObj));
				}
			}
		});
	}

	function savePerson() {

		var url = "<%=serverURL%>/rest/person/";
		var person = getPersonForm();
		var newEntity = true;
		if (person.id) {
			newEntity = false;
			url += person.id;
		} else {
			newEntity = true;
		}
		if (newEntity) {
			$.oajax({
				url : url,
				type : 'POST',
				data : JSON.stringify(person),
				jso_provider : "rest", // Will match the config identifier
				dataType : 'json',
				contentType : "application/json; charset=utf-8",
				error : function(jqXHR, textStatus, errorThrown) {
					if(errorThrown == "Unauthorized"){
						location.reload();
					}else{
						alert("error:"+errorThrown);
					}
				},
				success : function(data) {
					var myObj = eval(data);
					loadForm(myObj);
				}
			});
		} else {
			$.oajax({
				url : url,
				type : 'PUT',
				data : JSON.stringify(person),
				jso_provider : "rest", // Will match the config identifier
				dataType : 'json',
				contentType : "application/json; charset=utf-8",
				error : function(jqXHR, textStatus, errorThrown) {
					if(errorThrown == "Unauthorized"){
						location.reload();
					}else{
						alert("error:"+errorThrown);
					}
				},
				success : function(data) {
					var myObj = eval(data);
					loadForm(myObj);
				}
			});
		}
	}

	function deletePerson(id) {
		var url = "<%=serverURL%>/rest/person/" + id;
		$.oajax({
			url : url,
			type : 'DELETE',
			jso_provider : "rest", // Will match the config identifier
			dataType : 'json',
			contentType : "application/json; charset=utf-8",
			error : function(jqXHR, textStatus, errorThrown) {
				if (errorThrown == "Unauthorized") {
					location.reload();
				} else {
					alert("error:" + errorThrown);
				}
			},
			success : function(data) {
				var myObj = eval(data);
				myObj.id = null;
				loadForm(myObj);
			}
		});
	}

	function getPersonForm() {
		var person = {};
		if ($("#personId").val()) {
			person.id = $("#personId").val();
			person.firstName = $("#firstName").val();
			person.lastName = $("#lastName").val();
			person.number = $("#number").val();
			person.birthDate = $("#birthDate").val();
			newEntity = false;
		} else {
			person.id = $("#personId").val();
			person.firstName = $("#firstName").val();
			person.lastName = $("#lastName").val();
			person.number = $("#number").val();
			person.birthDate = $("#birthDate").val();
			newEntity = true;
		}
		return person;
	}

	function loadForm(Person) {
		$("#id").val(Person.id);
		$("#json").html(JSON.stringify(Person));
		$("#personId").val(Person.id);
		$("#firstName").val(Person.firstName);
		$("#lastName").val(Person.lastName);
		$("#number").val(Person.number);
		$("#birthDate").val(Person.birthDate);
	}
</script>

</head>
<body>
	Id:
	<input type="text" id="id" />
	<button id="getButton">Get</button>
	<button id="delete">Delete</button>
	<br /> json
	<div id="json"></div>
	<br />
	<div id="personForm">
		<fieldset>
			<legend>Person</legend>
			<form accept-charset=utf-8>
				<label>id</label> <input type="text" id="personId" name="id"
					disabled="disabled" /> <br /> <label>First Name:</label> <input
					type="text" id="firstName" name="firstName" /> <br /> <label>Last
					Name:</label> <input type="text" id="lastName" name="lastName" /> <br />
				<label>Number:</label> <input type="text" id="number" name="number" />
				<br /> <label>Birth Date:</label> <input type="text" id="birthDate"
					name="birthDate" /> <br />
				<button id="clear">Clear</button>
				<button id="save">Save</button>
			</form>
		</fieldset>
	</div>
</body>
</html>
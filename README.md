Spring REST OAuth Demo
======================
This is a demo of using OAuth 2.0 with Spring REST application, this demo is part of presentation
https://docs.google.com/presentation/d/1wiOJTMnGWL51P6NyFTCbpJz7-TsrYYrTd6_Siv_9Sfo/edit?usp=sharing

the home project is a parent one, contains 3 chilcren application:

* Auth Server
-----------
The application will be responsible of handling the OAuth 2.0 tokens and clients details.

* REST Server
------------
The Resource provider application which is checking the token provided and if it is authorized,
it is provide the resources required by resource consumer.

* REST Client
--------------
Application using java script to access the resources required after getting a valid token from Auth Server

Note:
-----
in this application I'm using HTTP for all requests as it is demo in real line all request contains tokne have to be HTTPS

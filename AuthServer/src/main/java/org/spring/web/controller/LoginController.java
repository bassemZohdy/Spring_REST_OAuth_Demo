package org.spring.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class LoginController {

	@RequestMapping("login")
	public String login() {
		return "login";
	}

	@RequestMapping("logout")
	public String logout() {
		return "logout";
	}

	@RequestMapping("index")
	public String index() {
		return "index";
	}

	@RequestMapping("request_token_authorized")
	public String request_token_authorized() {
		return "request_token_authorized";
	}
	
}

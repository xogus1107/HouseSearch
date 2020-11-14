package com.ssafy.happyhouse.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MainController {

	@RequestMapping(value = "/qna", method = RequestMethod.GET)
	public String mvlist() {
		return "qnavue";
	}
	@RequestMapping(value = "/sitemap", method = RequestMethod.GET)
	public String mvsitemap() {
		return "notice/sitemap";
	}

}

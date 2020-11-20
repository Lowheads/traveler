package org.travelmaker.controller;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import org.travelmaker.domain.StatisticVO;
import org.travelmaker.domain.TestVO;
import org.travelmaker.service.TestService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/admin/*")
@AllArgsConstructor
public class TestController {

	private TestService service;

	private static final Logger logger = LoggerFactory.getLogger(AdminMemberContorller.class);

	

	@GetMapping("/registerTheme")
	public String themeTest() {

		System.out.println("register theme");

		return "registerTheme";
	}

	@GetMapping("/registerAction")
	public String acitonTest(TestVO t) {

		service.registerTheme(t);

		return "registerTheme";
	}
	
	

}

package org.travelmaker.controller;

import java.sql.Date;
import java.text.SimpleDateFormat;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.travelmaker.domain.BudgetVO;
import org.travelmaker.service.BudgetService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/budget/*")
@AllArgsConstructor
public class BudgetController {

	private BudgetService service;

	@GetMapping("/list")
	public void list(Model model) {

		log.info("list");

		// DB 모든 일정, 지출 내역
		model.addAttribute("list", service.getBudgetByUser());
	}

	@GetMapping("/list2")
	public void list2(Model model) {

		log.info("list");

		// DB 모든 일정, 지출 내역
		model.addAttribute("list", service.getBudgetByUser());
	}
}

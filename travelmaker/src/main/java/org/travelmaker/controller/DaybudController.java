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
import org.travelmaker.domain.DaybudVO;
import org.travelmaker.service.DaybudService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/daybud/*")
@AllArgsConstructor
public class DaybudController {

	private DaybudService service;

	
	@GetMapping("/get")
	public void get(@RequestParam("schno") Long schno, Model model) {
		
		log.info("/get or modify");
		
		// 선택 된 일정 지출 내역 카운트
		model.addAttribute("daybud", service.get(schno));
		// 날짜 셀렉트 박스
		model.addAttribute("box", service.box()); 
		// 파라미터, 일정 번호
		model.addAttribute("schno", schno);
	}

	// Test
//	@GetMapping("/list")
//	public void list(Model model) {
//		
//		log.info("list");
//		
//		model.addAttribute("list", service.getList());
//	}

}

package org.travelmaker.controller;

import java.text.SimpleDateFormat;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.travelmaker.domain.ScheduleDTO;
import org.travelmaker.service.BoardService;
import org.travelmaker.service.PlaceService;
import org.travelmaker.service.RegionService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/main/*")
@AllArgsConstructor
@Log4j
public class MainController {
	
	private RegionService service;
	private PlaceService placeService;
	private BoardService boardservice;
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(java.sql.Date.class, new CustomDateEditor(dateFormat, false));
	}
	@PostMapping(value="/theme", produces= {MediaType.APPLICATION_JSON_UTF8_VALUE}) 
	public void getInitSch(@ModelAttribute("schDto") ScheduleDTO schDTO, Model model) {
		for (int i = 1; i <= 6; i++) {
			model.addAttribute("theme"+i,placeService.getListWithTheme(schDTO.getSchRegion(),"TM00"+i));
		}
	}
	
	@GetMapping("/index")
	public void main(Model model){
		log.info(service.getList());
		model.addAttribute("list", service.getList());
		
		model.addAttribute("adminlist",boardservice.getAdminList());
	}
}

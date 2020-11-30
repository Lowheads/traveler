package org.travelmaker.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.travelmaker.domain.PlaceDTO;
import org.travelmaker.domain.ThemeVO;
import org.travelmaker.service.ThemeService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/admin/*")
@AllArgsConstructor
public class ThemeController {
	
	private ThemeService service;
	
	@GetMapping("/theme")	
	public String theme(Model model) {
		
		List<ThemeVO> list = service.getThemeList();
		
		System.out.println(list);

		model.addAttribute("list", list);

		return "theme";
	}
	
	@GetMapping("/themeInfo/{themeNo}")
	public String themeInfo(@PathVariable("themeNo") int themeNo, Model model) {
		
		List<PlaceDTO> list = service.getThemeInfo(themeNo);
		
		model.addAttribute("list", list);

		return "themeInfo";
	}
	
	@GetMapping("/modifyTheme/{themeNo}")
	public String modifyTheme(@PathVariable("themeNo") int themeNo, Model model) {

		List<PlaceDTO> list = service.getThemeInfo(themeNo);
		model.addAttribute("list", list);

		return "modifyTheme";
		
	}
	
	@PostMapping("/modifyTheme/{themeNo}")
	public String modifyThemeAction(@PathVariable("themeNo") int themeNo, Model model) {

		List<PlaceDTO> list = service.getThemeInfo(themeNo);
		model.addAttribute("list", list);

		return "modifyTheme";
		
	}
	
	

}

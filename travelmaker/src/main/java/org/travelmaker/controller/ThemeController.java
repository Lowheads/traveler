package org.travelmaker.controller;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
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
		
		List<Map<String, String>> list = service.getThemeList();

		model.addAttribute("list", list);
		System.out.println(list);

		return "theme";
	}
	
	@GetMapping("/themeInfo/{region_id}/{theme_code}")
	public String themeInfo(@PathVariable("region_id") String region_id, @PathVariable("theme_code") String theme_code,Model model) {
		
		List<String> list = service.getThemeInfo(region_id, theme_code);
		
		model.addAttribute("list", list);

		return "themeInfo";
	}
	

}

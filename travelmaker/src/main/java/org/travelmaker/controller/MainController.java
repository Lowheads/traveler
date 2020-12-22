package org.travelmaker.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.travelmaker.domain.PlaceDTO;
import org.travelmaker.domain.PlaceVO;
import org.travelmaker.domain.ScheduleDTO;
import org.travelmaker.domain.ThemeAttachVO;
import org.travelmaker.service.BoardService;
import org.travelmaker.service.PlaceService;
import org.travelmaker.service.RegionService;
import org.travelmaker.service.ThemeService;

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

	private ThemeService themeService;
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(java.sql.Date.class, new CustomDateEditor(dateFormat, false));
	}
	
	@PostMapping(value="/theme", produces= {MediaType.APPLICATION_JSON_UTF8_VALUE}) 
	public void getInitSch(@ModelAttribute("schDto") ScheduleDTO schDTO, Model model) {

		Map<Integer, List<PlaceDTO>> theme = new HashMap<Integer, List<PlaceDTO>>();
		
		for(int i =1; i<6;i++) {
			
			theme.put(i-1, placeService.getListWithTheme(schDTO.getSchRegion(),"TM00"+i));
		}
		
		model.addAttribute("themeList", theme);

		List<PlaceVO> rainyDay=new ArrayList<PlaceVO>();
		
		//만약 비가 온다면
		if(false) {
			rainyDay =  placeService.getPlaceByWeather(schDTO.getSchRegion());
		}
		
		model.addAttribute("rainydayRec", rainyDay);
	
	}
	
	@GetMapping(value ="/getWeatherRec/{regionNo}", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<List<PlaceVO>> getWeatherRec(@PathVariable("regionNo") int RegionNo){
		
		return new ResponseEntity<>(placeService.getPlaceByWeather(RegionNo), HttpStatus.OK);
	}
	
	@GetMapping(value ="/getAttachment", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<ThemeAttachVO> getAttachment(int themeNo){
		
		return new ResponseEntity<>(themeService.getAttachment(themeNo), HttpStatus.OK);
	}
	
	@GetMapping("/index")
	public void main(Model model){
		log.info(service.getList());
		model.addAttribute("list", service.getList());
		
		model.addAttribute("adminlist",boardservice.getAdminList());
	}
	
}

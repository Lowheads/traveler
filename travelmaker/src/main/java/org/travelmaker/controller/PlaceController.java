package org.travelmaker.controller;

import java.text.SimpleDateFormat;
import java.util.HashMap;
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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.travelmaker.domain.Criteria;
import org.travelmaker.domain.PageDTO;
import org.travelmaker.domain.ScheduleDTO;
import org.travelmaker.domain.ScheduleDtVO;
import org.travelmaker.domain.ScheduleVO;
import org.travelmaker.service.PlaceService;
import org.travelmaker.service.SchdtService;
import org.travelmaker.service.ScheduleService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RequestMapping("/place/*")
@Controller
@Log4j
@AllArgsConstructor
public class PlaceController {
	private PlaceService service;
	private ScheduleService schService;
	private SchdtService schDtService;
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(java.sql.Date.class, new CustomDateEditor(dateFormat, false));
	}
		
	@PostMapping(value="/")
	public String main(@ModelAttribute("schDto") ScheduleDTO schDTO,@RequestParam ("places") String[] plcNoArr, Model model) {
		if(plcNoArr.length!=0) 
		model.addAttribute("places", service.get(plcNoArr));
		return "/place/home";
	}
	
	@GetMapping(value="/pages/{title}/{regionNo}/{pageNum}",	produces = {MediaType.APPLICATION_XML_VALUE,MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<Map<String,Object>> getList(@PathVariable String title,@PathVariable int regionNo, @PathVariable int pageNum) {
		Criteria cri = new Criteria(pageNum,10);
		PageDTO pageMaker = new PageDTO(cri,service.getSearchResultTotalCnt(title,regionNo));
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("list", service.getList(title,regionNo,cri));
		map.put("pageMaker", pageMaker);
		return new ResponseEntity<>(map, HttpStatus.OK);
	}
	
	@PostMapping(value="/test",produces = "application/json;")
	@ResponseBody
	public String getInitSchedule(@RequestBody ScheduleDtVO[][] scheduleDtVO) {
		System.out.println(scheduleDtVO[0][0].toString());
//		System.out.println(scheduleDtVO[0][1].toString());
//		System.out.println(scheduleDtVO[1][0].toString());
//		System.out.println(scheduleDtVO[1][1].toString());
		System.out.println(scheduleDtVO.length);
		service.getInitSchWithDistAndDu(scheduleDtVO);
		
		return "/place/test";
	}
	
	@PostMapping(value="/test/sch",produces = {MediaType.APPLICATION_JSON_UTF8_VALUE})
	@ResponseBody
	public String putInitSchedule(@RequestBody ScheduleVO scheduleVO,@RequestBody ScheduleDtVO[][] scheduleDtVO) {
		schService.register(scheduleVO);
//		schDtService.
//		schService.
//		System.out.println(scheduleDtVO[0][1].toString());
//		System.out.println(scheduleDtVO[1][0].toString());
//		System.out.println(scheduleDtVO[1][1].toString());
		service.getInitSchWithDistAndDu(scheduleDtVO);
		
		return "/place/test";
	}
	
	
}

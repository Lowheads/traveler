package org.travelmaker.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

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
import org.travelmaker.domain.PlaceVO;
import org.travelmaker.domain.ScheduleDTO;
import org.travelmaker.domain.ScheduleDtVO;
import org.travelmaker.service.PlaceService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RequestMapping("/place/*")
@Controller
@Log4j
@AllArgsConstructor
public class PlaceController {
	private PlaceService service;
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(java.sql.Date.class, new CustomDateEditor(dateFormat, false));
	}
		
	@PostMapping(value="/")
	public String main(@ModelAttribute("schDto") ScheduleDTO schDTO,@RequestParam ("places") String[] plcNoArr, Model model) {
		List<PlaceVO> list = new ArrayList<PlaceVO>();	
		for (int i = 0; i < plcNoArr.length; i++) {
			list.add(service.get(Long.parseLong(plcNoArr[i])));
		}
		// 리뷰 for 문 대신 plcNoArr을 문자열로 만들어서 mapper에서 query문이 한번만 실행되게 바꾸기
		model.addAttribute("places", list);
		return "/place/home";
	}
	
	@GetMapping(value="/pages/{title}",	produces = {MediaType.APPLICATION_XML_VALUE,MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<List<PlaceVO>> getList(@PathVariable String title) {
		log.info("getList...........");
		return new ResponseEntity<>(service.getList(title), HttpStatus.OK);
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
	
	
}

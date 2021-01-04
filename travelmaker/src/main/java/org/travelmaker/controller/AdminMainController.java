package org.travelmaker.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.travelmaker.domain.BoardVO;
import org.travelmaker.domain.StatisticVO;
import org.travelmaker.service.MainService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/admin/*")
@AllArgsConstructor
public class AdminMainController {

	private MainService service;

	@GetMapping("/main")
	public String showChart(Model model) {

		List<StatisticVO> list = service.getChart("daily");

		model.addAttribute("today", list.get(0));

		model.addAttribute("qna", service.getQnaInfo());

		return "main";
	}

	@GetMapping("/getChart/{type}")
	public ResponseEntity<List<StatisticVO>> getChart(@PathVariable("type") String type) {

		return new ResponseEntity<>(service.getChart(type), HttpStatus.OK);
	}

	@GetMapping("/getPostByPopularity/{type}")
	public ResponseEntity<List<BoardVO>> getPostByPopularity(@PathVariable("type") String type) {

		return new ResponseEntity<>(service.getPostByPopularity(type), HttpStatus.OK);
	}

}

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

import com.fasterxml.jackson.core.JsonProcessingException;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/admin/*")
@AllArgsConstructor
public class AdminMainController {
	
	private MainService service;
	
	@GetMapping("/main")
	public String showChart(Model model){

		/*
		 * List<StatisticVO> daily = service.getDaily(); ObjectMapper mapper = new
		 * ObjectMapper(); String jsonText =mapper.writeValueAsString(daily);
		 */	

		/*
		 * model.addAttribute("daily", jsonText);
		 * 
		 * model.addAttribute("daily2", service.getDaily());
		 */
		
		
		/*
		 * List<String> date = new ArrayList<String>(); List<String> cntMember = new
		 * ArrayList<String>(); List<String> cntPost = new ArrayList<String>();
		 * List<String> cntWithdraw = new ArrayList<String>();
		 * 
		 * for(int i =0; i<daily.size();i++) {
		 * 
		 * date.add(i, daily.get(i).getTargetDate()); cntMember.add(i,
		 * daily.get(i).getCntMember()); cntPost.add(i, daily.get(i).getCntPost());
		 * cntWithdraw.add(i, daily.get(i).getCntWithdrawalMember());
		 * 
		 * }
		 * 
		 * model.addAttribute("date", date); model.addAttribute("cntMember", cntMember);
		 * model.addAttribute("cntPost", cntPost); model.addAttribute("cntWithdraw",
		 * cntWithdraw);
		 * 
		 * 
		 * 
		 * 
		 * 
		 */
		//model.addAttribute("newestPost", service.newestPost());
		
		List<StatisticVO> list = service.getChart("daily");
		
		model.addAttribute("today", list.get(0));
		
		
		return "main";
	}
	
	
	@GetMapping("/getChart/{type}")
	public ResponseEntity<List<StatisticVO>> getChart(@PathVariable("type") String type){
		
		
		
		return new ResponseEntity<>(service.getChart(type), HttpStatus.OK);
	}
	
	@GetMapping("/getPostByPopularity/{type}")
	public ResponseEntity<List<BoardVO>> getPostByPopularity(@PathVariable("type") String type){
		
		return new ResponseEntity<>(service.getPostByPopularity(type), HttpStatus.OK);
	}

}

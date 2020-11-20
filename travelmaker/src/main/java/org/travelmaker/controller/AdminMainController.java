package org.travelmaker.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

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

		List<StatisticVO> list1 = service.getDailyStatistic();
		
		String result1 = "";

		for (int i = 0; i < list1.size(); i++) {

			result1 += "['" + list1.get(i).getDailyLog() + "'," + list1.get(i).getCntMember() + "," + list1.get(i).getCntPost() +"]";
			if (i != list1.size() - 1) {
				result1 += ",";
			}
		}


		System.out.println(result1);
		
		List<StatisticVO> list2 = service.getMonthlyStatistic();
		
		String result2 = "";
		for (int i = 0; i < list2.size(); i++) {

			result2 += "['" + list2.get(i).getDailyLog() + "월'," + list2.get(i).getCntMember() +"," + list2.get(i).getCntPost() +"]";
			if (i != list2.size() - 1) {
				result2 += ",";
			}
		}
		System.out.println("---------------------------");
		System.out.println(result2);

		model.addAttribute("result1", result1);
		
		model.addAttribute("result2", result2);

		

		return "main";
	}

}

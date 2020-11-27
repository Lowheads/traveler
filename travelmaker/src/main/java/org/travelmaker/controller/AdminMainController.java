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

		List<StatisticVO> dailyStatistic = service.getDailyStatistic();
		
		String dailyLog = "";

		for (int i = 0; i < dailyStatistic.size(); i++) {

			dailyLog += "['" + dailyStatistic.get(i).getTargetDate() + "'," + dailyStatistic.get(i).getCntMember() + "," + dailyStatistic.get(i).getCntPost() +"]";
			if (i != dailyStatistic.size() - 1) {
				dailyLog += ",";
			}
		}
		
		List<StatisticVO> monthlyStatistic = service.getMonthlyStatistic();
		
		String monthlyLog = "";
		for (int i = 0; i < monthlyStatistic.size(); i++) {

			monthlyLog += "['" + monthlyStatistic.get(i).getTargetDate() + "월'," + monthlyStatistic.get(i).getCntMember() +"," + monthlyStatistic.get(i).getCntPost() +"]";
			if (i != monthlyStatistic.size() - 1) {
				monthlyLog += ",";
			}
		}

		model.addAttribute("dailyLog", dailyLog);
		model.addAttribute("monthlyLog", monthlyLog);
		

		return "main";
	}

}

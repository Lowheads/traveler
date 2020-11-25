package org.travelmaker.controller;

import java.sql.Date;
import java.text.SimpleDateFormat;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.travelmaker.domain.BuddtVO;
import org.travelmaker.service.BuddtService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/buddt/*")
@AllArgsConstructor
public class BuddtController {

	private BuddtService service;

	
	@GetMapping("/get")
	public void get(@RequestParam("paydate") Date paydate, @RequestParam("schno") Long schno, Model model) {

		log.info("/get");

		System.out.println(service.get(paydate));

		// 날짜별 지출 상세 내역 출력
		model.addAttribute("buddt", service.get(paydate));
		// 파라미터
		model.addAttribute("paydate", paydate); 
		model.addAttribute("schno", schno);
		
//		그래프
//		model.addAttribute("cateCnt", service.cateCnt());
	}
	
	
	@GetMapping("/listAll")
	public void listAll(@RequestParam("schno") Long schno, Model model) {
		
		log.info("listAll");
		
		// 선택 된 일정의 모든 지출 상세 내역
		model.addAttribute("listAll", service.readAll(schno));
		// 파라미터
		model.addAttribute("schno", schno);
	}

	@GetMapping("/register")
	public void register(@RequestParam("schno") Long schno, Model model) {
		
		BuddtVO buddt = new BuddtVO();
		
		buddt.setSchno(schno);
		
		System.out.println(buddt.getSchno());
		
		// DB의 모든 일정 번호
		model.addAttribute("box", service.box());
		// 선택 된 일정의 최소, 최대 날짜
		model.addAttribute("buddt", service.mmDate(schno));
	}

	
	@PostMapping("/register")
	public String register(BuddtVO buddt, RedirectAttributes rttr) {

		log.info("register" + buddt);

		service.register(buddt);

		rttr.addFlashAttribute("result", buddt.getNo());

		return "redirect:/buddt/listAll?schno=" + buddt.getSchno();
	}

	
	@GetMapping("/modify")
	public void modify(@RequestParam("no") Long no, @RequestParam("paydate") Date paydate,
			@RequestParam("schno") Long schno, Model model) {

		log.info("modify end");

		// 읽기 전용 VO 생성
		BuddtVO vo = new BuddtVO(no, paydate, schno);
		model.addAttribute("buddt", service.readed(vo));
		
		System.out.println(vo);
	}

	
	@PostMapping("/modify")
	public String modfy(BuddtVO buddt, RedirectAttributes rttr) {
		log.info("modfy" + buddt);

		if (service.modify(buddt)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/buddt/listAll?schno=" + buddt.getSchno();
	}

	
	@PostMapping("/remove")
	public String remove(BuddtVO buddt, RedirectAttributes rttr) {
		log.info("remove..." + buddt.getNo());
		
		service.remove(buddt.getNo());
		return "redirect:/buddt/listAll?schno=" + buddt.getSchno();
	}

}

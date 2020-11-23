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

	@PostMapping("/register")
	public String register(BuddtVO buddt, RedirectAttributes rttr) {
		
		log.info("register" + buddt);
		
		service.register(buddt);
		
		rttr.addFlashAttribute("result", buddt.getNo());
		
		return "redirect:/buddt/listAll?schno="+buddt.getSchno(); // post라 안보이게 넘어감..
	}

	
	@GetMapping("/register")
	public void register(@RequestParam("schno") Long schno, Model model) {
		BuddtVO buddt=new BuddtVO();
		buddt.setSchno(schno);
		System.out.println(buddt.getSchno());
		model.addAttribute("box", service.box());
		model.addAttribute("buddt",service.mmDate(schno));
		System.out.println(buddt);
	}
	
	@GetMapping("/get")
	public void get(@RequestParam("paydate") Date paydate, @RequestParam("schno") Long schno,
			 
			Model model) {
		
		log.info("/get");
		
		
		System.out.println(service.get(paydate));
		
		model.addAttribute("buddt", service.get(paydate));
		model.addAttribute("paydate",paydate); // 2020-11-03 & 그래프 & 수정
		model.addAttribute("schno",schno); //
		model.addAttribute("cateCnt",service.cateCnt()); //
	}
	
	@GetMapping("/modify")
	public void modify(@RequestParam("no") Long no, @RequestParam("paydate") Date paydate, @RequestParam("schno") Long schno,
			Model model) {
			System.out.println("@@@@@@@@@@@@@@@@@@@");
			System.out.println(no);
			System.out.println(paydate);
			System.out.println(schno);
			
			BuddtVO vo = new BuddtVO(no,paydate,schno);
			
			model.addAttribute("buddt", service.readed(vo));
			System.out.println(vo);
			log.info("modify end");
	}
	
	
	@PostMapping("/modify")
	public String modfy(BuddtVO buddt, RedirectAttributes rttr) {
		log.info("modfy" + buddt);
		
		if (service.amend(buddt)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/buddt/listAll?schno="+buddt.getSchno(); // 수정
	}
	
	@PostMapping("/remove")
	public String remove(@RequestParam("no") Long no, RedirectAttributes rttr) {
		
		log.info("remove..." + no);
		if (service.remove(no)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/budget/list";
	}
	
	@GetMapping("/listAll")
	public void listAll(@RequestParam("schno") Long schno, Model model) {
		
		log.info("listAll");
		
		model.addAttribute("listAll", service.readAll(schno));
		model.addAttribute("schno", schno);
	}
	
}

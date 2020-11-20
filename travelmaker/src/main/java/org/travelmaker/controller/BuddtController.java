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

// 10.2.1 목록에 대한 처리와 테스트
// 보드콘트롤러에서 전체 목록을 가져오는 처리를 먼저 작성합니다. 
// 보드콘트롤러는 BoardService 타입의 객체와 같이 연동해야 하므로
// 의존성에 대한 처리도 같이 진행합니다. 
@Controller
@Log4j
@RequestMapping("/buddt/*")
@AllArgsConstructor
public class BuddtController {

//	@InitBinder
//    public void initBinder(WebDataBinder binder) {
//        SimpleDateFormat sdf = new SimpleDateFormat("MM-dd-yyyy");
//        sdf.setLenient(true);
//        binder.registerCustomEditor(Date.class, new CustomDateEditor(sdf, true));
//    }
	 
	private BuddtService service;
	
//	@GetMapping("/list")
//	public void list(Model model) {
//		
//		log.info("list");
//		
//		model.addAttribute("list", service.getList());
//	}

	@PostMapping("/register")
	public String register(BuddtVO buddt, RedirectAttributes rttr) {
		
		log.info("register" + buddt);
		
		service.register(buddt);
		
		rttr.addFlashAttribute("result", buddt.getNo());
		
		return "redirect:/buddt/listAll?schno="+buddt.getSchno(); // post라 안보이게 넘어감..
	}
	
/*	@PostMapping("/modify")
	public String modify(BoardVO board, RedirectAttributes rttr) {
		log.info("modify : " + board);
		
		if (service.modify(board)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/board/list";
	}
*/	
	
	@GetMapping("/register")
	public void register() {
		
	}
	
	@GetMapping("/get")
	public void get(@RequestParam("paydate") Date paydate, @RequestParam("schno") Long schno,
			 
			Model model) {
		
		log.info("/get");
		
		
		System.out.println(service.get(paydate));
		
		model.addAttribute("buddt", service.get(paydate));
		model.addAttribute("paydate",paydate); // 2020-11-03 & 그래프 & 수정
		model.addAttribute("schno",schno); //
//		model.addAttribute("bud_cate",bud_cate); //
//		model.addAttribute("cate_cnt",cate_cnt); // 
		model.addAttribute("cateCnt",service.cateCnt()); //
//		model.addAttribute("sch_no", sch_no);
//		model.addAttribute("listAll",service.readAll()); //
	}
	
	@GetMapping({"/modify", "/amend"})
	public void modify(@RequestParam("no") Long no, @RequestParam("paydate") Date paydate, @RequestParam("schno") Long schno,
			 
			Model model) {
			System.out.println("@@@@@@@@@@@@@@@@@@@");
			System.out.println(no);
			System.out.println(paydate);
			System.out.println(schno);
			
			BuddtVO vo = new BuddtVO(no,paydate,schno);
			
			model.addAttribute("buddt", service.readed(vo));
			System.out.println(vo);
//			model.addAttribute("pay_date",pay_date); // 2020-11-03 & 그래프 & 수정
//			model.addAttribute("sch_no",sch_no); //
//			model.addAttribute("no",no); //
			
			log.info("modify end");
	}
	
	
	@PostMapping("/modify")
	public String modfy(BuddtVO buddt, RedirectAttributes rttr) {
		log.info("modfy" + buddt);
		
		if (service.amend(buddt)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/budget/list"; // 수정
	}
	
	@PostMapping("/remove")
	public String remove(@RequestParam("no") Long no, RedirectAttributes rttr) {
		
		log.info("remove..." + no);
		if (service.remove(no)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/budget/list";
	}
	
//	@RequestParam("cate_cnt") Long cate_cnt,
//	@RequestParam("bud_cate") String bud_cate,
	
	@GetMapping("/listAll")
	public void listAll(@RequestParam("schno") Long schno, Model model) {
		
		log.info("listAll");
		
		model.addAttribute("listAll", service.readAll(schno));
		model.addAttribute("schno", schno);
	}
}

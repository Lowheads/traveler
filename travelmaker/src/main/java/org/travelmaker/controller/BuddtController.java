package org.travelmaker.controller;

import java.sql.Date;
import java.text.SimpleDateFormat;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.travelmaker.domain.BuddtVO;
import org.travelmaker.service.BuddtService;

import com.google.gson.Gson;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/buddt/*")
@AllArgsConstructor
public class BuddtController {

	private BuddtService service;
	
	@GetMapping(value = "/getDetail/{no}", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<BuddtVO> test(@PathVariable("no") int no) {
		
		return new ResponseEntity<>(service.getBuddt(no), HttpStatus.OK);
	}
	
	 
	@GetMapping("/list")
	public void list(@RequestParam("paydate") Date paydate, @RequestParam("schno") Long schno, Model model) {

//		log.info("/get");

		BuddtVO vo = new BuddtVO(paydate, schno);
		
		// 날짜별 지출 상세 내역 출력
		model.addAttribute("buddt", service.getBudgetListByDate(vo));
		// 파라미터
		model.addAttribute("paydate", paydate);
		model.addAttribute("schno", schno);
		// 카테고리 ㅇㅁㅇㄱ
		model.addAttribute("cafeBudget", service.getExpenseByCafeWDate(vo));
		model.addAttribute("restaurantBudget", service.getExpenseByRestaurantWDate(vo));
		model.addAttribute("activityBudget", service.getExpenseByActivityWDate(vo));
		model.addAttribute("lodgingBudget", service.getExpenseByLodgingWDate(vo));
		model.addAttribute("transBudget", service.getExpenseByTransWDate(vo));
		model.addAttribute("shoppingBudget", service.getExpenseByShoppingWDate(vo));
		model.addAttribute("entertainmentBudget", service.getExpenseByEntertainmentWDate(vo));
		model.addAttribute("etcBudget", service.getExpenseByEtcWDate(vo));
		//
		model.addAttribute("chartText", service.getChartText(vo));
		
		// register
		BuddtVO buddt = new BuddtVO();
		
		buddt.setSchno(schno);
		System.out.println(buddt.getSchno());
		
		// 셀렉트 박스 - 일정 선택 (distinct sch_no)  
		model.addAttribute("schnoBox", service.setBoxBySch());
		// 선택 된 일정의 최소, 최대 날짜
		model.addAttribute("dateBox", service.setBoxByDate(schno));
		
		model.addAttribute("paydate", paydate); 
		
//		model.addAttribute("dateBySch", service.getDateBySchno(schno));
		model.addAttribute("daybud", service.getBudgetBySch(schno));
		
		model.addAttribute("schtitle", service.getTitleBySchno(schno));
	}
	
	@GetMapping("/listAll")
	public void listAll(@RequestParam("schno") Long schno, Model model) {
		
		log.info("listAll");
		
		// 선택 된 일정의 모든 지출 상세 내역
		model.addAttribute("listAll", service.getBudgetListByAllDates(schno));
		// 파라미터
		model.addAttribute("schno", schno);
		// 카테고리8
		model.addAttribute("cafeBudget", service.getExpenseByCafe(schno));
		model.addAttribute("restaurantBudget", service.getExpenseByRestaurant(schno));
		model.addAttribute("activityBudget", service.getExpenseByActivity(schno));
		model.addAttribute("lodgingBudget", service.getExpenseByLodging(schno));
		model.addAttribute("transBudget", service.getExpenseByTrans(schno));
		model.addAttribute("shoppingBudget", service.getExpenseByShopping(schno));
		model.addAttribute("entertainmentBudget", service.getExpenseByEntertainment(schno));
		model.addAttribute("etcBudget", service.getExpenseByEtc(schno));
		// 간날짜온날짜 
		model.addAttribute("dateBox", service.setBoxByDate(schno));
		//
		model.addAttribute("chartTextByListAll", service.getChartTextByListAll(schno));
		// 일정 셀렉박스 
		model.addAttribute("daybud", service.getBudgetBySch(schno));
		
		// 셀렉트 박스 - 일정 선택 (distinct sch_no)
		model.addAttribute("schnoBox", service.setBoxBySch());
		// 선택 된 일정의 최소, 최대 날짜
		model.addAttribute("dateBox", service.setBoxByDate(schno));
		
		model.addAttribute("schtitle", service.getTitleBySchno(schno));
	}

	@GetMapping("/register")
	public void register(@RequestParam("paydate") Date paydate, @RequestParam("schno") Long schno, Model model) {
		
		// 기존에 있는 
		BuddtVO buddt = new BuddtVO();
		
		buddt.setSchno(schno);
		
		System.out.println(buddt.getSchno());
		
		// 셀렉트 박스 - 일정 선택 (distinct sch_no)
		model.addAttribute("schnoBox", service.setBoxBySch());
		// 선택 된 일정의 최소, 최대 날짜
		model.addAttribute("dateBox", service.setBoxByDate(schno));
		System.out.println(service.setBoxByDate(schno)); // print schno == 1
		
		model.addAttribute("paydate", paydate); 
	}
	
	@GetMapping("/register2")
	public void register2(@RequestParam("schno") Long schno, Model model) {
		
		// 기존에 있는 
		BuddtVO buddt = new BuddtVO();
		
		buddt.setSchno(schno);
		
		System.out.println(buddt.getSchno());
		
		// 셀렉트 박스 - 일정 선택 (distinct sch_no)
		model.addAttribute("schnoBox", service.setBoxBySch());
		// 선택 된 일정의 최소, 최대 날짜
		model.addAttribute("dateBox", service.setBoxByDate(schno));
	}

	
	@PostMapping("/register")
	public String register(BuddtVO buddt, RedirectAttributes rttr) {
		System.out.println("==============="+buddt);
		log.info("register" + buddt);

//		try-catch()
		service.register(buddt);

		rttr.addFlashAttribute("result", buddt.getNo());

		return "redirect:/buddt/listAll?schno=" + buddt.getSchno();
	}
	
	@GetMapping("/modify") 
	public void modify(@RequestParam("no") Long no, @RequestParam("paydate") Date paydate,
			@RequestParam("schno") Long schno, Model model) {
		log.info("modify end");
		
		System.out.println("modify/get");
		
		// 페이징 + readonly VO
		BuddtVO vo = new BuddtVO(no, paydate, schno);
		model.addAttribute("loadVO", service.loadVO(vo));
		
		// System.out.println(service.loadVO(vo));
	}
	
	@PostMapping(value = "/modify")
	public String modify(@RequestBody BuddtVO buddt, RedirectAttributes rttr) {
				
//		System.out.println("modify/post"+buddt);
//		System.out.println(buddt.getModifiedExpense());
//		log.info("modfy" + buddt);

		if (service.modify(buddt)) {
			rttr.addFlashAttribute("result", "success");
		}
//		service.modifyExpense(buddt);
		return "redirect:/buddt/listAll?schno=" + buddt.getSchno();
		
		
	}
	
	@PostMapping("/remove")
	public String remove(@RequestBody BuddtVO buddt, RedirectAttributes rttr) {
		log.info("remove..." + buddt.getNo());
		
		service.remove(buddt);
		return "redirect:/buddt/listAll?schno=" + buddt.getSchno();
	}


}

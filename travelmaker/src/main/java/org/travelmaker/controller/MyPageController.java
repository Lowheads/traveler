package org.travelmaker.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.travelmaker.domain.Criteria;
import org.travelmaker.domain.PickVO;
import org.travelmaker.domain.PlacePageDTO;
import org.travelmaker.domain.PlaceVO;
import org.travelmaker.service.*;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/mypage/*")
@AllArgsConstructor
public class MyPageController {

	private PlaceService PLCservice;
	private ScheduleService SchService;
	private PickService PICKservice;

	@GetMapping("/pickPL")
	public void getPlaceList(Criteria cri,Model model,HttpServletRequest request) {
		HttpSession session = request.getSession();
		int memNo = Integer.parseInt(String.valueOf(session.getAttribute("memNo")));
		cri.setMemNo(memNo);
		int total = PLCservice.getTotal(cri);
		cri.setAmount(8);
		model.addAttribute("list",PLCservice.getList(cri));
		model.addAttribute("pageMaker",new PlacePageDTO(cri,total));
	}

	@RequestMapping(value = "/deleteSchedule", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public void deleteSchedule(@RequestParam("schNo")int schNo) {
		SchService.remove(schNo);
	}

	@GetMapping("/pickSch")
	public void getSchList(Criteria cri,Model model,HttpServletRequest request) {
		HttpSession session = request.getSession();
		int memNo = Integer.parseInt(String.valueOf(session.getAttribute("memNo")));
		cri.setMemNo(memNo);
		cri.setAmount(8);
		model.addAttribute("list",SchService.getList(cri));
		model.addAttribute("pageMaker",new PlacePageDTO(cri,SchService.getTotal(cri)));
	}

	@GetMapping({"/past/get","/pickSch/get","/upcomming/get"})
	public void get(@RequestParam("sch_no")int schNo,@ModelAttribute("cri") Criteria cri,Model model) {

		model.addAttribute("board",SchService.get(schNo));
	}

	@GetMapping("/past")
	public void getPastSch(Criteria cri,Model model,HttpServletRequest request) {
		HttpSession session = request.getSession();
		int memNo = Integer.parseInt(String.valueOf(session.getAttribute("memNo")));
		cri.setMemNo(memNo);
		cri.setAmount(8);
		model.addAttribute("list",SchService.getPastList(cri));
		model.addAttribute("pageMaker",new PlacePageDTO(cri,SchService.getPtotal(cri)));
	}

	@GetMapping("/upcomming")
	public void getUpcommingSch(Criteria cri,Model model,HttpServletRequest request) {
		HttpSession session = request.getSession();
		int memNo = Integer.parseInt(String.valueOf(session.getAttribute("memNo")));
		cri.setMemNo(memNo);
		cri.setAmount(8);
		model.addAttribute("list",SchService.getUpCommingList(cri));
		model.addAttribute("pageMaker",new PlacePageDTO(cri,SchService.getCtotal(cri)));
	}

	@ResponseBody
	@RequestMapping(value = "/heart", method = RequestMethod.POST, produces = "application/json")
	public void deleteHeart(HttpSession session,PickVO vo) throws Exception {
		int memNo = Integer.parseInt(String.valueOf(session.getAttribute("memNo")));
		vo.setMemNo(memNo);
		PICKservice.remove(vo);
	}
	
	
	 @RequestMapping(value = "/getDB", method = RequestMethod.POST
  		   ,produces = "application/json")
     @ResponseBody
     public String ajaxTest(PlaceVO vo) throws Exception {

  	   System.out.println(vo);
  	   
  	   try {
  		   
  		   PLCservice.register(vo);
  	   }
  	   catch(Exception e) {
  		   System.out.println("에러발생");
  		   e.printStackTrace();
  	   }
  	   return "/home";
     }
}

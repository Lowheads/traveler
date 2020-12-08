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

	private PlaceService placeService;
	private ScheduleService SchService;
	private PickService pickService;
	private SchdtService schdtService;

	@GetMapping("/pickPL")
	public void getPlaceList(Criteria cri,Model model,HttpServletRequest request) {
		HttpSession session = request.getSession();
		int memNo = Integer.parseInt(String.valueOf(session.getAttribute("memNo")));
		cri.setMemNo(memNo);
		int total = placeService.getTotal(cri);
		cri.setAmount(8);
		model.addAttribute("list",placeService.getListWithPaging(cri));
		model.addAttribute("pageMaker",new PlacePageDTO(cri,total));
	}

	@RequestMapping(value = "/deleteSchedule", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public void deleteSchedule(@RequestParam("schNo")int schNo) {
		SchService.removeSchdule(schNo);
		schdtService.deleteSchdt(schNo);
	}

	@GetMapping("/pickSch")
	public void getScheduleList(Criteria cri,Model model,HttpServletRequest request) {
		HttpSession session = request.getSession();
		int memNo = Integer.parseInt(String.valueOf(session.getAttribute("memNo")));
		cri.setMemNo(memNo);
		cri.setAmount(8);
		model.addAttribute("list",SchService.getList(cri));
		model.addAttribute("pageMaker",new PlacePageDTO(cri,SchService.getTotal(cri)));
	}

	@GetMapping({"/past/get","/pickSch/get","/upcomming/get"})
	public void getSchedule(@RequestParam("sch_no")int schNo,@ModelAttribute("cri") Criteria cri,Model model) {

		model.addAttribute("board",SchService.getSchedule(schNo));
		model.addAttribute("Schdt",schdtService.getSchdtList(schNo));
	}

	@GetMapping("/past")
	public void getPastSchedule(Criteria cri,Model model,HttpServletRequest request) {
		HttpSession session = request.getSession();
		int memNo = Integer.parseInt(String.valueOf(session.getAttribute("memNo")));
		cri.setMemNo(memNo);
		cri.setAmount(8);
		model.addAttribute("list",SchService.getPastList(cri));
		model.addAttribute("pageMaker",new PlacePageDTO(cri,SchService.getPastScheduleTotal(cri)));
	}

	@GetMapping("/upcomming")
	public void getUpcomingSchedule(Criteria cri,Model model,HttpServletRequest request) {
		HttpSession session = request.getSession();
		int memNo = Integer.parseInt(String.valueOf(session.getAttribute("memNo")));
		cri.setMemNo(memNo);
		cri.setAmount(8);
		model.addAttribute("list",SchService.getUpComingList(cri));
		model.addAttribute("pageMaker",new PlacePageDTO(cri,SchService.getComingScheduleTotal(cri)));
	}

	@ResponseBody
	@RequestMapping(value = "/deletePick", method = RequestMethod.POST, produces = "application/json")
	public void deletePickPlace(HttpSession session,PickVO vo) throws Exception {
		int memNo = Integer.parseInt(String.valueOf(session.getAttribute("memNo")));
		vo.setMemNo(memNo);
		pickService.remove(vo);
	}
	
	@ResponseBody
	@RequestMapping(value = "/insertPick", method = RequestMethod.POST, produces = "application/json")
	public void insertPickPlace(HttpSession session,PickVO vo) throws Exception {
		int memNo = Integer.parseInt(String.valueOf(session.getAttribute("memNo")));
		vo.setMemNo(memNo);
		pickService.register(vo);
	}
}

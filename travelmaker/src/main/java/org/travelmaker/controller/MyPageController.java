package org.travelmaker.controller;

import java.util.List;
import java.util.Map;

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
	private MemberService memberService;

	@GetMapping("/pickPL")
	public void getPlaceList(Criteria cri,Model model,HttpServletRequest request) {
		HttpSession session = request.getSession();
		int memNo = Integer.parseInt(String.valueOf(session.getAttribute("memNo")));
		cri.setMemNo(memNo);
		int total = placeService.getTotal(cri);
		cri.setAmount(6);
		model.addAttribute("list",placeService.getListWithPaging(cri));
		model.addAttribute("pageMaker",new PlacePageDTO(cri,total));
	}

	@RequestMapping(value = "/deleteSchedule", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public void deleteSchedule(@RequestParam("schNo")String schNo) {
		SchService.removeSchdule(Integer.parseInt(schNo));
		schdtService.deleteSchdt(Integer.parseInt(schNo));
	}

	@GetMapping("/pickSch")
	public void getScheduleList(Criteria cri,Model model,HttpServletRequest request) {
		HttpSession session = request.getSession();
		int memNo = Integer.parseInt(String.valueOf(session.getAttribute("memNo")));
		cri.setMemNo(memNo);
		cri.setAmount(6);
		model.addAttribute("list",SchService.getList(cri));
		model.addAttribute("pageMaker",new PlacePageDTO(cri,SchService.getTotal(cri)));
	}

	@GetMapping({"/past/get","/pickSch/get","/upcoming/get"})
	public void getSchedule(@RequestParam("schNo")int schNo,@ModelAttribute("cri") Criteria cri,Model model) {
		model.addAttribute("schedule",SchService.getSchedt(schNo));
		model.addAttribute("Schdt",schdtService.getSchdtList(schNo));
	}

	@GetMapping("/past")
	public void getPastSchedule(Criteria cri,Model model,HttpServletRequest request) {
		HttpSession session = request.getSession();
		int memNo = Integer.parseInt(String.valueOf(session.getAttribute("memNo")));
		cri.setMemNo(memNo);
		cri.setAmount(6);
		model.addAttribute("list",SchService.getPastList(cri));
		model.addAttribute("pageMaker",new PlacePageDTO(cri,SchService.getPastScheduleTotal(cri)));
	}

	@GetMapping("/upcoming")
	public void getUpcomingSchedule(Criteria cri,Model model,HttpServletRequest request) {
		HttpSession session = request.getSession();
		int memNo = Integer.parseInt(String.valueOf(session.getAttribute("memNo")));
		cri.setMemNo(memNo);
		cri.setAmount(6);
		model.addAttribute("list",SchService.getUpComingList(cri));
		model.addAttribute("pageMaker",new PlacePageDTO(cri,SchService.getComingScheduleTotal(cri)));
	}

	@ResponseBody
	@RequestMapping(value = "/deletePick", method = RequestMethod.POST, produces = "application/json")
	public int deletePickPlace(HttpSession session,PickVO vo) throws Exception {
		if(session.getAttribute("memNo")==null) {
			return 0;
		}
		int memNo = Integer.parseInt(String.valueOf(session.getAttribute("memNo")));
		vo.setMemNo(memNo);

		return pickService.remove(vo);
	}

	@ResponseBody
	@RequestMapping(value = "/insertPick", method = RequestMethod.POST, produces = "application/json")
	public int insertPickPlace(HttpSession session,PickVO vo) throws Exception {
		if(session.getAttribute("memNo")==null) {
			return 0;
		}
		int memNo = Integer.parseInt(String.valueOf(session.getAttribute("memNo")));
		vo.setMemNo(memNo);

		return pickService.register(vo);
	}

	@ResponseBody
	@RequestMapping(value = "/testResult", method = RequestMethod.POST, produces = "application/json")
	public List<Map<String,Object>> resultType(String type,HttpSession session){

		if(session.getAttribute("memNo") == null) {
			return placeService.getYourList(type, 0);
		}

		int memNo = Integer.parseInt(String.valueOf(session.getAttribute("memNo")));

		memberService.updateTT(type,memNo);
		return placeService.getYourList(type,memNo);
	}
}
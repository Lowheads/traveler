package org.travelmaker.controller;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.request;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.travelmaker.domain.Criteria;
import org.travelmaker.domain.PICK_VO;
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
		private PICK_Service PICKservice;
		
		//찜한장소 페이지 들어왔을때 장소 리스트 뽑아와야되니까
		@GetMapping("/pickPL")
		public void list(Criteria cri,Model model,HttpServletRequest request,String selected) {
			HttpSession session = request.getSession();
			int memNo = Integer.parseInt(String.valueOf(session.getAttribute("memNo")));
			System.out.println(memNo);
			log.info("list");
			cri.setMemNo(memNo);
			int total = PLCservice.getTotal(cri);
			cri.setAmount(6);
				model.addAttribute("list",PLCservice.getList(cri));
				model.addAttribute("pageMaker",new PlacePageDTO(cri,total));	
				if(selected!=null) {
					if(selected.equals("like")){
						model.addAttribute("list",PLCservice.getLikeList(cri));
					}
					if(selected.equals("new")){
						model.addAttribute("list",PLCservice.getNewestList(cri));
					}
					if(selected.equals("old")){
						model.addAttribute("list",PLCservice.getOldestList(cri));
					}
				}
		}
		
		@PostMapping("/remove")
		public String remove(@RequestParam("plc_no")int plcNo,RedirectAttributes rttr) {
			log.info("remove..."+plcNo);
			if(PLCservice.remove(plcNo)) {
				rttr.addFlashAttribute("result","success");
			}
			return "redirect:/mypage/list";
			}
		
		@GetMapping("/pickSch")
		public void pickSch(Criteria cri,Model model,HttpServletRequest request) {
			HttpSession session = request.getSession();
			int memNo = Integer.parseInt(String.valueOf(session.getAttribute("memNo")));
			cri.setMemNo(memNo);
			model.addAttribute("list",SchService.getList(cri));
			model.addAttribute("pageMaker",new PlacePageDTO(cri,SchService.getTotal(cri)));
		}
		
		@GetMapping({"/past/get","/pickSch/get","/upcomming/get"})
		public void get(@RequestParam("sch_no")int schNo,@ModelAttribute("cri") Criteria cri,Model model) {
			
			System.out.println("===================sch_no:"+schNo);
			model.addAttribute("board",SchService.get(schNo));
		}
		
		@GetMapping("/past")
		public void past(Criteria cri,Model model,HttpServletRequest request) {
			HttpSession session = request.getSession();
			int memNo = Integer.parseInt(String.valueOf(session.getAttribute("memNo")));
			log.info("list");
			cri.setMemNo(memNo);
			log.info("list");
			model.addAttribute("list",SchService.getPastList(cri));
			model.addAttribute("pageMaker",new PlacePageDTO(cri,SchService.getPtotal(cri)));
		}
		
		@GetMapping("/upcomming")
		public void upcomming(Criteria cri,Model model,HttpServletRequest request) {
			HttpSession session = request.getSession();
			int memNo = Integer.parseInt(String.valueOf(session.getAttribute("memNo")));
			log.info("list");
			cri.setMemNo(memNo);
			log.info("list");
			model.addAttribute("list",SchService.getUpCommingList(cri));
			model.addAttribute("pageMaker",new PlacePageDTO(cri,SchService.getCtotal(cri)));
		}
		
		
		@ResponseBody
		@RequestMapping(value = "/heart", method = RequestMethod.POST, produces = "application/json")
		    public int heart(HttpServletRequest httpRequest,HttpSession session,@RequestParam("plc_no") int plcNo) throws Exception {
			 	int heart = Integer.parseInt(httpRequest.getParameter("heart"));
			 	int memNo = Integer.parseInt(String.valueOf(session.getAttribute("memNo")));
		        PICK_VO vo = new PICK_VO();
		        vo.setMemNo(memNo);
		        vo.setPlcNo(plcNo);
		        PICKservice.remove(vo);
		        return heart;
		    }
		
		@ResponseBody
		@RequestMapping(value = "/heartSch", method = RequestMethod.POST, produces = "application/json")
		    public int heartSch(HttpServletRequest httpRequest,HttpSession session,@RequestParam("sch_no") int schNo) throws Exception {
				int heart = Integer.parseInt(httpRequest.getParameter("heart"));
			 	int memNo = Integer.parseInt(String.valueOf(session.getAttribute("memNo")));
		        PICK_VO vo = new PICK_VO();
		        vo.setMemNo(memNo);
		        vo.setSchNo(schNo);
		        PICKservice.removeSch(vo);
		        return heart;
		    }
}

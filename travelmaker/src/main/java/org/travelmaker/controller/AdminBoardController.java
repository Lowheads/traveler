package org.travelmaker.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import org.travelmaker.domain.*;

import org.travelmaker.service.AdminBoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/admin/*")
@AllArgsConstructor
public class AdminBoardController {
	//테스트
	//테스트2222
private AdminBoardService service;
		
	private static final Logger logger = LoggerFactory.getLogger(AdminMemberContorller.class);
	
	@GetMapping("/boardList")
	public String boardList(Criteria cri, Model model) {
		
		List<BoardVO> result;
		
		if (cri.getKeyword() == null||cri.getType()==null) {
			result = service.getBoardList();
			model.addAttribute("board", result);
		}else {
			result = service.searchBoardWriter(cri);
			model.addAttribute("board", result);
		}
		

		return "boardList";
	}
	
	@GetMapping("/removeContent")
	public String removePost(int[] result, RedirectAttributes rttr) {
		
		
		for(int i =0;i<result.length;i++) {
			service.removePost(result[i]);
		}
		
		rttr.addFlashAttribute("message", "SUCCESS");
		return "redirect:/admin/boardList";
	}
	
	

}

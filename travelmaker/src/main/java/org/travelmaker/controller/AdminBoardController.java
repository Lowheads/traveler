package org.travelmaker.controller;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import org.travelmaker.domain.*;

import org.travelmaker.service.AdminBoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import oracle.jdbc.proxy.annotation.Post;

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
	public String getPost(Criteria cri, Model model) {
		
		List<BoardVO> result;
		
		if (cri.getKeyword() == null||cri.getType()==null) {
			result = service.getBoardList();
			model.addAttribute("board", result);
		}else {
			result = service.searchPost(cri);
			model.addAttribute("board", result);
		}
		
		return "/boardList";
	}
	
	@GetMapping("/removeContent/{boardNo}")
	public String removePost(@PathVariable("boardNo") ArrayList<Integer> boardNo, RedirectAttributes rttr) {

		if(boardNo.size() == service.removePost(boardNo)) {
			rttr.addFlashAttribute("message", "SUCCESS");
		}else {
			rttr.addFlashAttribute("message", "FAIL");
		}
		
		return "redirect:/admin/boardList";
	}
	
	
	@GetMapping(value = "/getDetail/{boardNo}", produces= {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<List<BoarddtVO>> getDetail(@PathVariable("boardNo") int boardNo) {
		
		ResponseEntity<List<BoarddtVO>> result = null;
		result = ResponseEntity.status(HttpStatus.OK).body(service.getPostDetail(boardNo));
		
		return result;
	} 
	
	

}

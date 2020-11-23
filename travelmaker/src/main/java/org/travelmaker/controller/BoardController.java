package org.travelmaker.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.travelmaker.domain.BoardVO;
import org.travelmaker.domain.BoarddtVO;
import org.travelmaker.domain.Criteria;
import org.travelmaker.domain.PageDTO;
import org.travelmaker.service.BoardService;
import org.travelmaker.service.BoarddtService;
import org.travelmaker.service.SchdtService;
import org.travelmaker.service.ScheduleService;
import org.travelmaker.utils.UploadFileUtils;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board/*")
@AllArgsConstructor
public class BoardController {

	//빈의 이름을 검색해서 주입할 객체 설정
	@Resource(name="uploadPath")
	private String uploadPath;
	
	private BoardService boardservice;
	
	private ScheduleService scheduleservice;
	
	private SchdtService schdtservice;
	
	private BoarddtService boarddtservice;

	@GetMapping("/schedulelist")
	public void schedulelist(Model model) {
		log.info("schedulelist");
		model.addAttribute("schedulelist",scheduleservice.getList());
	}
	
	@GetMapping("/list")
	public void list(Criteria cri, Model model) {
		log.info("list: "+cri);
		model.addAttribute("list",boardservice.getList(cri));

		System.out.println(boardservice.getList(cri));
		int total= boardservice.getTotal(cri);
		log.info("total:" + total);

		model.addAttribute("pageMaker",new PageDTO(cri, total));
	}
	
	
	@GetMapping("/register")
	public void register(@RequestParam("schNo")int schNo,Model model) {
		model.addAttribute("schNo",schNo);
			
	}
	
	@PostMapping("/register")
	public String register(BoardVO board, RedirectAttributes rttr, MultipartFile file, Model model) throws Exception {
		log.info("register: "+board);

		//파일처리 관련 코드
		String imgUploadPath = uploadPath + File.separator + "imgUpload";
		String ymdPath =UploadFileUtils.calcPath(imgUploadPath);
		String fileName = null;
		rttr.addFlashAttribute("boardTitle", board.getBoardTitle());
		rttr.addFlashAttribute("result", board.getBoardNo());
		String boardTitle = URLEncoder.encode(board.getBoardTitle(),"UTF-8");
		
		
		if (file != null) {
			fileName = UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath);
		} else {
			fileName = uploadPath + File.separator + "images" + File.separator + "none.png";
		}

		board.setBoardImg(File.separator + "imgUpload" + ymdPath + File.separator + fileName);
		board.setThumbImg(
				File.separator + "imgUpload" + ymdPath + File.separator + "s" + File.separator + "s_" + fileName);
		System.out.println(board.getBoardImg()+","+board.getThumbImg());
		
		model.addAttribute("board",board);
		
		boardservice.register(board);
		System.out.println(board);
		
		return "redirect:/board/dtregister?boardTitle="+boardTitle+"&schNo="+board.getSchNo();
	}
	
	
	//게시물 명 중복 체크해주는 메소드
	//자바 객체를  HTTP 요청의 body 내용으로 매핑
	@ResponseBody
	@RequestMapping(value = "/titlecheck", method = RequestMethod.POST, produces = "application/json")
	public boolean titlecheck(@RequestParam("boardTitle") String boardTitle, @RequestParam("schNo") String schNo) {
		BoardVO board = new BoardVO();

		board.setBoardTitle(boardTitle);
		board.setSchNo(Integer.parseInt(schNo));
		
		//같은 일정번호의 게시물명이 중복이 아닐 때
		if (boardservice.getbytitle(board) != null) {
			return true;
		}
		//중복일 때
		return false;
	}
	
	
	@GetMapping("/dtregister")
	public void dtregister(BoardVO board,Model model) throws UnsupportedEncodingException {
		
		//board_title = URLEncoder.encode(board_title,"UTF-8");

		board=boardservice.getbytitle(board);
		model.addAttribute("board",board);
		
	}
	
	@PostMapping("/dtregister")
	public String dtregister(BoarddtVO boarddt, RedirectAttributes rttr, MultipartFile file) throws Exception{
		log.info("dtregister: "+boarddt);
		
		//파일처리 관련 코드
		String imgUploadPath = uploadPath + File.separator + "imgUpload";
		String ymdPath =UploadFileUtils.calcPath(imgUploadPath);
		String fileName = null;
		
		if (file != null) {
			fileName = UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath);
		} else {
			fileName = uploadPath + File.separator + "images" + File.separator + "none.png";
		}

		boarddt.setBoarddtImg(File.separator + "imgUpload" + ymdPath + File.separator + fileName);
		boarddt.setDtThumbImg(
				File.separator + "imgUpload" + ymdPath + File.separator + "s" + File.separator + "s_" + fileName);

		
		System.out.println(boarddt);
		
		boarddtservice.register(boarddt);
		return "redirect:/board/list";
	}
	
	
	
	@GetMapping({"/modify"})
	public void modify(@RequestParam("boardNo")int boardNo, @ModelAttribute("cri") Criteria cri, Model model) {
	
		log.info("/modify");
		model.addAttribute("board",boardservice.get(boardNo));
	
	}
	
	
	@GetMapping({"/get"})
	public void get(@RequestParam("schNo")int schNo, @RequestParam("boardNo")int boardNo, 
			@ModelAttribute("cri") Criteria cri, Model model) {
		
		log.info("/get");
		
		model.addAttribute("schedule",scheduleservice.getListSchedule(schNo));
		model.addAttribute("schdtplace", schdtservice.getplacetitle(schNo));
		model.addAttribute("boarddt",boarddtservice.getList(boardNo));
		model.addAttribute("board",boardservice.get(boardNo));
		model.addAttribute("boardNo",boardNo);
	
	}
	
	@PostMapping("/modify")
	public String modify(BoardVO board, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr,MultipartFile file) throws Exception {
		log.info("modify:"+board);
		//파일처리 관련 코드
		String imgUploadPath = uploadPath + File.separator + "imgUpload";
		String ymdPath =UploadFileUtils.calcPath(imgUploadPath);
		String fileName = null;
		
		if (file != null) {
			fileName = UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath);
		} else {
			fileName = uploadPath + File.separator + "images" + File.separator + "none.png";
		}

		board.setBoardImg(File.separator + "imgUpload" + ymdPath + File.separator + fileName);
		board.setThumbImg(
				File.separator + "imgUpload" + ymdPath + File.separator + "s" + File.separator + "s_" + fileName);
		System.out.println(board.getBoardImg()+","+board.getThumbImg());
		
		if(boardservice.modify(board)) {
			rttr.addFlashAttribute("result","success");
			
			rttr.addAttribute("pageNum",cri.getPageNum());
			rttr.addAttribute("amount",cri.getAmount());
		}
		return "redirect:/board/list";
	}
	
	@PostMapping("/remove")
	public String remove(@RequestParam("boardNo") int boardNo, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		log.info("remove..."+boardNo);
		boarddtservice.remove(boardNo);
		if(boardservice.remove(boardNo)) {
			rttr.addFlashAttribute("result","success");
		}
		rttr.addAttribute("pageNum",cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		
		return "redirect:/board/list";
	}
}

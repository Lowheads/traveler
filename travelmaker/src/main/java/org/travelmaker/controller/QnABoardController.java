package org.travelmaker.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.travelmaker.domain.QnABoardCriteria;
import org.travelmaker.domain.QnABoardVO;
import org.travelmaker.domain.QnAPageDTO;
import org.travelmaker.service.MemberService;
import org.travelmaker.service.QnABoardService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/qnaboard/*")
public class QnABoardController {

	private final QnABoardService service;
	private final MemberService memberService;
	
	public QnABoardController(QnABoardService qnaBoardService, MemberService memberService) {
		this.service = qnaBoardService;
		this.memberService = memberService;
	}
	
	@GetMapping("/list")
	public void list(QnABoardCriteria cri, Model model, HttpSession session) {

		model.addAttribute("list", service.getList(cri)); // 게시물 출력
		model.addAttribute("pageMaker", new QnAPageDTO(cri, service.getTotal(cri))); // 페이징
		
		// 로그인 중인 계정의 닉네임과 등급을 조회페이지(list)로 넘긴다.(비밀글은 본인과 관계자만 조회 가능하기때문)
		service.sendMyNicknameAndGrade(session, model);
	}
	
	// 게시글 등록
	@GetMapping("/register") 
	public void register(Model model, HttpSession session, RedirectAttributes rttr) {
		
		// 로그인한 이메일
		try {
			// 작성자는 로그인한 내 닉네임
			model.addAttribute("nickname", service.getMyNickname((String)session.getAttribute("email")));
			// 회원번호 가져오자
			model.addAttribute("memNo", service.getMyMemNo((String)session.getAttribute("email")));
		}catch (Exception e) {
			e.getStackTrace();
		}
	}
	
	// 게시물을 서버에 올리면(저장)하면 포스트 방식
	@PostMapping("/register")
	public String register(QnABoardVO qnaBoard, RedirectAttributes rttr,HttpSession sessoin, HttpServletRequest request) {
		// 현재 로그인 중인 회원의 닉네임을 nickname에 저장한다
		String nickname = memberService.getMember((String)sessoin.getAttribute("email")).getNickname();
		
		if(!(qnaBoard.getNickname().equals(nickname))) { // 개발자 도구로 닉네임 변경 막기
			rttr.addFlashAttribute("msg", "회원의 닉네임과 일치하지 않습니다.");
			return "redirect:/qnaboard/register";
		}
		
		service.register(qnaBoard, request); // 게시글 등록
		rttr.addFlashAttribute("msg", qnaBoard.getBno() +"번 글이 등록되었습니다."); // 게시글 등록엔 등록하는 회원의 멤버번호도 필요
		return "redirect:/qnaboard/list";
	}
	
	@GetMapping({"/get", "/modify"}) // 특정 게시물 조회
	public void get(@RequestParam("bno") int bno, @ModelAttribute("cri") QnABoardCriteria cri, Model model,
			HttpSession session, RedirectAttributes rttr) {
		
			// 게시물 정보
			QnABoardVO pageObj = service.get(bno); 
			
			// 선택한 페이지 조회 (게시글 목록 출력)
			model.addAttribute("board", pageObj);
			model.addAttribute("secret", pageObj.getSecret());
			
			// 로그인한 회원의 번호를 넘겨준다.(글의 수정여부를 판별하기 위함)
			model.addAttribute("loginMemNo", service.getMyMemNo((String)session.getAttribute("email")));
			
			// 로그인한 사용자의 닉네임을 넘겨준다.(댓글의 수정/삭제 여부 판단을 위함)
			session.setAttribute("myNickname", service.getMyNickname((String)session.getAttribute("email")));
			
	}
	
	@PostMapping("/modify") // 게시물 수정
	public String modify(QnABoardVO qnaBoard, @ModelAttribute("cri") QnABoardCriteria cri, RedirectAttributes rttr) {
		log.info("여기는 게시글 수정 : " + qnaBoard);
		
		if(service.modify(qnaBoard)) {
			rttr.addFlashAttribute("msg", qnaBoard.getBno() + "번글이 수정되었습니다.");
		}
		
		// UriComponentsBuilder를 사용하면 필요한 파라미터를 쉽게 추가 가능
		return "redirect:/qnaboard/list" + cri.getListLink();
	}
	
	@PostMapping("/remove") // 게시물 삭제
	public String remove(@RequestParam("bno") int bno, @ModelAttribute("cri") QnABoardCriteria cri, RedirectAttributes rttr) {
		log.info("삭제합니다 : " +  bno);
		
		if(service.remove(bno))
			rttr.addFlashAttribute("msg", bno + "번글이 삭제되었습니다.");
		
		return "redirect:/qnaboard/list" + cri.getListLink();
	}
	
	
	
}

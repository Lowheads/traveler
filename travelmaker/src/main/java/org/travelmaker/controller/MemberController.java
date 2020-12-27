package org.travelmaker.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.travelmaker.domain.MemberVO;
import org.travelmaker.service.SocialLoginService;
import org.travelmaker.service.MemberService;

import com.fasterxml.jackson.databind.JsonNode;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/member/*")
public class MemberController {

	private final MemberService service;
	private final SocialLoginService socialLoginService;
	
	public MemberController(MemberService memberService, SocialLoginService socialLoginService) {
		this.service = memberService;
		this.socialLoginService = socialLoginService;
	}
	
	@GetMapping("/main")
	public void getMain() {
		log.info("main");
	}
	
	// 회원가입
	@RequestMapping(value = "/joinMember", method = RequestMethod.POST)
	public ModelAndView joinMember(MemberVO mVO, HttpSession session, RedirectAttributes rttr) {
		ModelAndView mav = new ModelAndView("redirect:/main/index");
		
		// 이메일, 닉네임 한번 더 검사하자
		if(service.isDuplicateCheck(mVO, rttr)) {
			return mav;
		}
		
		// 중복이 없다면.. 가입 시키자
		service.join(mVO); // 내용을 저장한다.
		rttr.addFlashAttribute("msg", "여행의정석 가족이 되신걸 환영합니다. 로그인 해주세요");
		return mav; // 회원가입 후, main으로 이동
	}

	// 로그인
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public ModelAndView login(MemberVO mVO, HttpSession session, HttpServletRequest request, HttpServletResponse response, RedirectAttributes rttr) {
		
		String referer = request.getHeader("Referer"); // 로그인 하는 페이지의 주소를 referer 변수에 저장한다.
		ModelAndView mav = new ModelAndView("redirect:" + referer); 
		
		// 계정 정보가 일치하지 않거나, 탈퇴한 회원이면 fail
		if(service.isMemberStatus(mVO, rttr, session)) {
			return mav;
		}
		// email 저장하기 여부
		service.rememberEmail(mVO.getEmail(), request, response);	
		
		log.info("로그인한 회원의 번호 : " + mVO.getMemNo());
		
		// 로그인 하자
		if(service.isAdminLogin(mVO, session)) {
			// 관리자는 관리자 페이지로 가주세요
			return mav = new ModelAndView("redirect:/admin/main"); 
		}
		
		return mav;
	}
	
	// 로그아웃
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session, HttpServletRequest request) throws Exception{
		session.invalidate(); // 세션 삭제
		
		// 로그아웃은 메인으로 이동시키자
		return "redirect:/main/index";
	}
	
	// 회원 조회
	@RequestMapping(value = "/getMember", method = RequestMethod.GET)
	public String getMember(String email, Model model, HttpSession session) {
		
		model.addAttribute("member", service.getMember(email));
		
		if(service.isApiLoginCheck(email, session)) {
			return "/member/apiMemberInfo";
		}
		
		// 조회페이지로 이동한다.
		return "/member/memberInfo";
	}
	
	// 비밀번호 변경
	@RequestMapping(value = "/modifyPwd", method = RequestMethod.POST)
	public String modifyPwd(String newPwd, String inputPwd, String email, HttpSession session, RedirectAttributes rttr) {
		
		// 정보변경 시, 입력한 내용이 유효한지 검사(이메일, 비밀번호 *개발자도구로 값바꾸는거 막자)
		if(service.isInputValidCheck(email, inputPwd, newPwd, session, rttr)) {
			return "redirect:/member/getMember?email=" + session.getAttribute("email");
		}

		// 비밀번호를 바꾼다.
		service.modifyPwd(newPwd, email);
		
		// 바뀐 회원의 정보를 화면에 출력한다.
		rttr.addFlashAttribute("msg", "정보를 정상적으로 변경하였습니다.");
		rttr.addFlashAttribute("member", service.getMember(email));
		return "redirect:/member/getMember?email=" + session.getAttribute("email");
	}
	
	// Ajax Email체크
	@RequestMapping("/hasEmail")
    @ResponseBody
    public String hasEmail(@RequestParam("email") String email) {
        
        String count = ""+service.hasEmail(email); // 중복되면 1 반환
        
        return count;
    }
	
	// Ajax 닉네임 체크(memberInfo)
	@RequestMapping("/hasNickname")
	@ResponseBody
	public String hasNickname(@RequestParam("nickname") String nickname) {

		String cnt = "" + service.hasNickname(nickname); // 닉네임 있으면 1, 없으면 0을 반환한다.
		System.out.println("닉네임 중복 ? : " + cnt);
			
		return cnt;
	}
	
	// 닉네임 수정(회원정보에서 저장하기 버튼 누르면 실행)
	@RequestMapping(value = "/modifyNickname", method = RequestMethod.POST)
	public String modifyNickname(String nickname, String email, HttpSession session, RedirectAttributes rttr) {
		
		// 닉네임 한번 더 검사(중복이면 중복이란 메세지를 띄웁니다)
		service.isNicknameTouch(nickname, email, rttr);
		
		// 중복이 없다면 정보가 정상적으로 저장되었습니다.
		return "redirect:/member/getMember?email=" + session.getAttribute("email");
	}
	
	
	// 회원탈퇴(status를 탈퇴로 바꾼다.. 계정이 사라지는게 아님)
	@RequestMapping(value = "/deleteMember", method = RequestMethod.POST)
	public ModelAndView deleteMember(String pwd, String email, HttpSession session, RedirectAttributes rttr) {
		ModelAndView mav;
			
		// 회원이 일치하는지 확인
		// 일치하면 탈퇴, 아니면 탈퇴 못함
		if(service.isMemberValid(pwd, email, rttr, session)) {
			mav = new ModelAndView("redirect:/member/getMember?email=" + session.getAttribute("email"));
			return mav;
		}
		mav = new ModelAndView("redirect:/member/main");
		return mav;
	}
	
	// api 회원탈퇴(status를 탈퇴로 바꾼다.. 계정이 사라지는게 아님)
	@RequestMapping(value = "/deleteApiMember", method = RequestMethod.POST)
	public String deleteApiMember(String email, HttpSession session, RedirectAttributes rttr) {
		
		service.deleteApiMember(email, rttr, session);
		return "redirect:/member/main";
	}
	

	// 카카오 로그인 시작
	 @RequestMapping(value="/kakao",method= RequestMethod.GET)
	 public String kakaoConnect(HttpServletRequest request, HttpSession session) {
		 String referer = request.getHeader("Referer"); // 로그인하는 페이지의 주소를 저장한다.
		 session.setAttribute("referer", referer);		// 현재 주소를 세션에 저장하자
		 
		  StringBuffer url = socialLoginService.getKakaoConnect();  // 카카오 소셜로그인 url 얻어오기
		  return "redirect:" + url.toString();
	 }
	 
		 
	 @RequestMapping(value="/kakaoLogin",produces="application/json",method= {RequestMethod.GET, RequestMethod.POST})
	 public String kakaoLogin(@RequestParam("code")String code, RedirectAttributes rttr, HttpSession session, HttpServletResponse response, HttpServletRequest request, Model model)throws IOException {
			 
		 String referer = (String)session.getAttribute("referer"); // 세션에 저장한 주소를 변수에 저장한다.
		 System.out.println("kakao code:"+code);
		  
	  JsonNode access_token = socialLoginService.getKakaoToken(code); // 카카오 토큰을 얻어온다
	  JsonNode userProfile = socialLoginService.getKakaoUserProfile(access_token); // 카카오 로그인 정보를 가져온다.
	  String email = userProfile.path("kakao_account").get("email").textValue(); // 프로필에서 이메일를 가져온다.
		         
	  		// 회원이 아니면 회원가입해주세요
	  		if(service.isKakaoApiJoinCheck(userProfile, model)) {
	  			return "/member/apiRegister";
	  		}
	  		
	  		// 탈퇴한 계정이면 로그인 안됩니다.
	  	    if(service.isDeleteAlready(email, rttr)) { 
		    	return "redirect:" + referer;
		    }
	  		
	  	// 이미 회원이면 로그인 처리
	  	session.setAttribute("email", email);
	  	service.setLoginDateToToday(email); // 최종 로그인은 오늘..
	  	log.info("카카오 로그인한 회원의 번호 : " + service.getMemNo(email));
	  	return "redirect:" + referer;
	  
	 }
    
}
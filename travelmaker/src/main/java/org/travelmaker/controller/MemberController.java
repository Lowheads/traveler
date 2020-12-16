package org.travelmaker.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.ParseException;
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
import org.travelmaker.loginapi.KakaoUserInfo;
import org.travelmaker.service.MemberService;
import org.travelmaker.service.apiLoginService;

import com.fasterxml.jackson.databind.JsonNode;
import com.github.scribejava.core.model.OAuth2AccessToken;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/member/*")
public class MemberController {

	@Setter(onMethod_ = @Autowired) // 무조건 주입
	private MemberService service;
	
	@Setter(onMethod_ = @Autowired) // api로그인
	private apiLoginService apiService;
	
	@GetMapping("/accountInfo") // 내 정보 페이지
	public void accountInfo() {
		log.info("accountInfo");
	}
	
	@GetMapping("/deletePage") // 회원탈퇴 페이지
	public void delete() {
		log.info("deletePage");
	}
	
	@RequestMapping(value = "/joinMember", method = RequestMethod.POST)
	public ModelAndView joinMember(MemberVO mVO, HttpSession session, RedirectAttributes rttr) {
		ModelAndView mav = new ModelAndView("redirect:/member/main");
		
		// 이메일, 닉네임 한번 더 검사하자
		if(service.isDuplicateCheck(mVO, rttr)) {
			return mav;
		}
		
		// 중복이 없다면.. 가입 시키자
		service.join(mVO); // 내용을 저장한다.
		rttr.addFlashAttribute("msg", "travel 가족이 되신걸 환영합니다 로그인 해주세요");
		return mav; // 회원가입 후, main으로 이동
	}

	// 로그인
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public ModelAndView login(MemberVO mVO, HttpSession session, HttpServletRequest request, HttpServletResponse response, RedirectAttributes rttr) {
		
		ModelAndView mav = new ModelAndView("redirect:/member/main");
		String getMovoPath = (String)session.getAttribute("movePath");
    	
		// 계정 정보가 일치하지 않거나, 탈퇴한 회원이면 로그인 실패!
		if(service.isMemberStatus(mVO, rttr, session)) {
			return mav = new ModelAndView("redirect:/member/main");
		}
		
		// email 저장하기 여부
		service.RememberEmail(mVO.getEmail(), request, response);	

		service.login(mVO); // 로그인 시키자..!
		session.setAttribute("email", mVO.getEmail()); // 세션에 이메일 담자

		if(getMovoPath != null) { // 다른 페이지 조회 중 로그인페이지로 이동됐다면 로그인 후 요청했던 주소로 이동하자.
    		return new ModelAndView("redirect:" + getMovoPath);
    	}
		
		return mav;
	}
	
	// 로그아웃
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) throws Exception{
		session.invalidate(); // 세션 삭제
		
		// 메인으로 이동
		return "redirect:main";
	}
	
	// 회원 조회
	@RequestMapping(value = "/getMember", method = RequestMethod.GET)
	public String getMember(String email, Model model, HttpSession session, HttpServletRequest request) {
		
		// URL에 다른 회원의 계정으로 접근하면 메인으로 보내버리자
		if(!(email.equals(session.getAttribute("email")))) {
			return "redirect:/member/main";
		}
		
		model.addAttribute("member", service.getMember(email));
		
		// api로그인 사용자는 비밀번호가 없는 정보조회 페이지로 이동하자
		if(service.isApiLoginCheck(email, session)) {
			return "/member/apiAccountInfo";
		}
		
		// 조회페이지로 이동한다.
		return "/member/accountInfo";
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
	
	// Ajax 닉네임 체크(accountInfo)
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
	
//	// 소셜로그인 닉네임 수정(회원정보에서 저장하기 버튼 누르면 실행)
//	@RequestMapping(value = "/modifyApiNickname", method = RequestMethod.POST)
//	public String modifyApiNickname(String nickname, String email, RedirectAttributes rttr, HttpSession session) {
//
//		// 닉네임을 수정하고 저장하기를 눌렀다면..
//		service.isNicknameTouch(nickname, email, rttr);
//			
//		// 중복이 없다면 정보가 정상적으로 저장되었습니다.
//		return "redirect:/member/getMember?email=" + session.getAttribute("email");
//	}
	
	//회원탈퇴 페이지 이동
	@RequestMapping(value = "/deletePage", method = RequestMethod.POST)
	public String deletePage(String email, Model model) {
		// 계정을 삭제하기 위한 페이지로 이동한다. (회원 정보를 가지고)
		model.addAttribute("member", service.getMember(email));
		
		return "/member/deletePage";
	}
	
	
	// 소셜 회원탈퇴 페이지 이동
	@RequestMapping(value = "/apiDeletePage", method = RequestMethod.POST)
	public String apiDeletePage(String email, Model model) {
		// 계정을 삭제하기 위한 페이지로 이동한다. (회원 정보를 가지고)
		model.addAttribute("member", service.getMember(email));
		
		return "/member/apiDeletePage";
	}
	
	
	// 회원탈퇴(status를 탈퇴로 바꾼다.. 계정이 사라지는게 아님)
	@RequestMapping(value = "/deleteMember", method = RequestMethod.POST)
	public ModelAndView deleteMember(String pwd, String email, HttpSession session, RedirectAttributes rttr) {
		ModelAndView mav;
			
		// 회원이 일치하는지 확인
		// 일치하면 탈퇴, 불일치하면 탈퇴 못함
		if(service.isMemberValid(pwd, email, rttr, session)) {
			mav = new ModelAndView("redirect:/member/deletePage");
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
	
	// 네아로
    @RequestMapping("/main")
    public ModelAndView naverLogin(HttpSession session) { // <- 네이버 로그인 성공하면 callback으로..
    	
    	/* 네아로 인증 URL을 생성하기 위하여 getAuthorizationUrl을 호출 */
        String naverAuthUrl = apiService.getNaverAuthUrl(session);
        
        /* 생성한 인증 URL을 View로 전달 */
        return new ModelAndView("/member/main", "url", naverAuthUrl);
    }
    
	  //네이버 로그인 성공시 callback호출 메소드
	  // 'id'값은 각 애플리케이션마다 회원 별로 유니크한 값
     @RequestMapping(value = "/callback", method = { RequestMethod.GET, RequestMethod.POST })
     public String callback(Model model, @RequestParam String code, @RequestParam String state, HttpSession session, RedirectAttributes rttr) throws IOException, ParseException {
	    System.out.println("여기는 callback");
	    
	    OAuth2AccessToken oauthToken = apiService.getNaverToken(code, state, session); // 네이버 토큰을 얻는다.
	    String userInfo = apiService.getNaverUserProfile(oauthToken); // // 로그인한 사용자 정보를 읽어온다.
	    
	    // 토큰과 네이버 프로필을 JSON형태로 
	    JSONObject responseObj = apiService.getJsonByNaver(oauthToken, userInfo);
	    String email = (String)responseObj.get("email"); // 로그인한 사용자의 이메일을 저장한다
	    String getMovoPath = (String)session.getAttribute("movePath");
	    
	    if(service.isNaverApiJoinCheck(responseObj, model)) // 회원이 아니면 회원가입 창으로 보낸다.
	    	return "/member/apiRegister";
	    
	     
	    if(service.isDeleteAlready(email, rttr))  // 탏퇴한 계정이면 로그인 안됩니다.
	    	return "redirect:/member/main";
	    
	    // 이미 회원이라면 세션주고 로그인
	    session.setAttribute("email", email);
	    
	    if(getMovoPath != null) { // 다른 페이지 조회 중 로그인페이지로 이동됐다면 로그인 후 요청했던 주소로 이동하자.
    		return "redirect:" + getMovoPath;
    	}
	    
	    return "redirect:/member/main";
     }
    
	// 카카오 로그인 시작
	 @RequestMapping(value="/kakao",method= RequestMethod.GET)
	 public String kakaoConnect() {
		  StringBuffer url = apiService.getKakaoConnect();  // 카카오 소셜로그인 url 얻어오기
		  return "redirect:" + url;
	 }
		 
	 @RequestMapping(value="/kakaoLogin",produces="application/json",method= {RequestMethod.GET, RequestMethod.POST})
	 public String kakaoLogin(@RequestParam("code")String code, RedirectAttributes rttr, HttpSession session, HttpServletResponse response, Model model)throws IOException {
			 
	  System.out.println("kakao code:"+code);
		  
	  JsonNode access_token = apiService.getKakaoToken(code); // 카카오 토큰을 얻어온다
	  JsonNode userProfile = apiService.getKakaoUserProfile(access_token); // 카카오 로그인 정보를 가져온다.
	  String email = userProfile.path("kakao_account").get("email").textValue(); // 프로필에서 이메일만 빼온다
	  String getMovoPath = (String)session.getAttribute("movePath");
	  
	  		// 회원이 아니면 회원가입해주세요
	  		if(service.isKakaoApiJoinCheck(userProfile, model)) 
	  			return "/member/apiRegister";
	  		
	  		// 탏퇴한 계정이면 로그인 안됩니다.
	  	    if(service.isDeleteAlready(email, rttr))  
		    	return "redirect:/member/main";
	  		
	  	// 이미 회원이면 로그인 처리
	  	session.setAttribute("email", email);
	  	
		if(getMovoPath != null) { // 다른 페이지 조회 중 로그인페이지로 이동됐다면 로그인 후 요청했던 주소로 이동하자.
    		return "redirect:" + getMovoPath;
    	}
		
	  return "redirect:/member/main";
	 }
    
}

package org.travelmaker.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import org.travelmaker.domain.Email;
import org.travelmaker.domain.EmailSender;
import org.travelmaker.service.MemberService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/search/*")
public class SendEmailController {
	
	@Setter(onMethod_ = @Autowired)
	private MemberService service;

	@Autowired
	   private EmailSender emailSender;
	
	@GetMapping("/searchPwd") 
	public void searchPw() {
		log.info("searchPW");
	}
	   
	@Autowired
	private Email email;
	   
	// 비밀번호 찾기
	// ModelAndView : 데이터와 내가 이동할 페이지를 저장한다.
	    @RequestMapping("/sendPwd")
	    public ModelAndView sendEmailAction (@RequestParam Map<String, Object> paramMap, ModelMap model, RedirectAttributes rttr) throws Exception {
	        ModelAndView mav;
	        String e_mail=(String) paramMap.get("email"); // 내가 입력한 이메일이 저장된다.
	        service.newPwd(e_mail); // 이메일을 넣으면 이건 새로운 비밀번호로 바뀐다.
	        String pw= service.findPwd(paramMap); // 이메일로 조회한 결과(비밀번호)를 저장한다.
	        
	        if(pw!=null) { // 이메일이 ture면..
	            email.setContent("안녕하세요, travel입니다! \n"
	            		+ "" + e_mail + "님의 임시 비밀번호는 "+pw+" 입니다\n"
	            				+ "로그인하시고 새로운 비밀번호로 변경해주세요!"); // 내용
	            email.setReceiver(e_mail); // 받는 사람
	            email.setSubject(e_mail+"님 travle에서 보내드리는 임시 비밀번호 메일입니다."); // 제목
	            emailSender.SendEmail(email);
	            // alert 출력
	        	rttr.addFlashAttribute("flag", false);
	        	rttr.addFlashAttribute("msg", "임시비밀번호를 보내드렸습니다.\n 확인해주세요!");
	        	// 성공하면 메인페이지로 이동.. 로그인해주세요
	        	mav= new ModelAndView("redirect:/member/main"); 
	            return mav;
	        }else { // 이메일이 false면..
	        	rttr.addFlashAttribute("flag", false);
	        	rttr.addFlashAttribute("msg", "travel회원이 아닙니다.. 회원가입해주세요 ㅠㅠ");
	        	// 실패하면 비번찾기 창으루..
	        	mav=new ModelAndView("redirect:/search/searchPwd"); 
	            return mav;
	        }

	    }
}

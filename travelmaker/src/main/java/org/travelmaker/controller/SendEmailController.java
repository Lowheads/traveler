package org.travelmaker.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
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
	
	private final MemberService service;
	private final EmailSender emailSender;
	
	public SendEmailController(MemberService memberService, EmailSender emailSender) {
		this.service = memberService;
		this.emailSender = emailSender;
	}
	
	// 비밀번호 찾기
	@RequestMapping("/sendPwd")
	public String sendEmailAction (String email, RedirectAttributes rttr) throws Exception {
	    Email emailObj = new Email();
	        
	    if(service.isEamilChack(email, rttr)) {
	      return "redirect:/main/index";
	     }

	    // Travel 회원이니까 임시비밀번호 메일을 만들어서 보내주자
        emailSender.SendEmail(service.writingEmail(email, emailObj));
        rttr.addFlashAttribute("msg", "임시비밀번호를 보내드렸습니다. 이메일을 확인해주세요!");
	       
	     return "redirect:/main/index";
	}
	    
	// 소셜 회원탈퇴(인증 이메일 보내기)
	@RequestMapping("/sendEmail")
	@ResponseBody
	public String sendEmail(@RequestParam("email") String email, @RequestParam("certNum") String certNum) throws Exception {
	  Email emailObj = new Email();

	  // 자바 스크립트에서 생성한 인증번호를 이메일에 넣어 보낸다.
	  emailSender.SendEmail(service.writingCertEmail(email, certNum, emailObj));
	  
	  return "1";
	}
	   
	    
}

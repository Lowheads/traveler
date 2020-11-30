package org.travelmaker.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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

	@Setter(onMethod_ = @Autowired)
	private EmailSender emailSender;
	
	@GetMapping("/searchPwd") 
	public void searchPw() {
		log.info("searchPW");
	}
	   
	// 비밀번호 찾기
	// ModelAndView : 데이터와 내가 이동할 페이지를 저장한다.
	    @RequestMapping("/sendPwd")
	    public ModelAndView sendEmailAction (String email, RedirectAttributes rttr) throws Exception {
	        ModelAndView mav = new ModelAndView("redirect:/member/main");
	        Email emailObj = new Email();
	        
	        // Travel 회원의 이메일이 아니라면..
	        if(service.isTravelMember(email, rttr)) {
	        	mav=new ModelAndView("redirect:/search/searchPwd");
	        	return mav;
	        }
	        
	        // Travel 회원이니까 임시비밀번호 메일을 만들어서 보내주자
            emailSender.SendEmail(service.writerEmail(email, emailObj));
            rttr.addFlashAttribute("msg", "임시비밀번호를 보내드렸습니다. 이메일을 확인해주세요!");
	        
	        return mav;
	    }
}

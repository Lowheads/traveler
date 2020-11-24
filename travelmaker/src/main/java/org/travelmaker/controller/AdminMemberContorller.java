package org.travelmaker.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.travelmaker.domain.Criteria;
import org.travelmaker.domain.MemberVO;
import org.travelmaker.service.AdminMemberService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

/**
 * Handles requests for the application home page.
 */
@Controller
@Log4j
@RequestMapping("/admin/*")
@AllArgsConstructor
public class AdminMemberContorller {

	private AdminMemberService service;
	
	private static final Logger logger = LoggerFactory.getLogger(AdminMemberContorller.class);

	@GetMapping("userInfo")
	public String userInfo(Criteria cri, Model model) {

		String type = cri.getType();
		String keyword =cri.getKeyword();
		
		if(type==null||keyword==null) {
			model.addAttribute("users", service.getUserList());
		}else {
			if(type.equals("회원번호")) {
				for(int i=0;i<keyword.length();i++) {
					char ck =keyword.charAt(i);
					if(ck<47||ck>57) {
						return "userInfo";
					}	
				}
			}
			
			model.addAttribute("users", service.searchUser(cri));
		}
		return "userInfo";
	}

	@GetMapping("withdraw")
	public String withdraw(Criteria cri, Model model) {

		String type = cri.getType();
		String keyword =cri.getKeyword();
		
		if (keyword == null || type == null) {
			model.addAttribute("users", service.getWithdrawUserList());
		} else {
			if(type.equals("회원번호")) {
				for(int i=0;i<keyword.length();i++) {
					char ck =keyword.charAt(i);
					if(ck<47||ck>57) {
						return "userInfo";
					}	
				}
			}
			model.addAttribute("users", service.searchWithdrawUser(cri));
		}
		return "withdraw";
	}

	@GetMapping("/remove/{ids}")
	public String removeUser(@PathVariable("ids") int[] ids, RedirectAttributes rttr) {

		if (ids != null) {
			for (int i = 0; i < ids.length; i++) {
				service.removeUser(ids[i]);
				rttr.addFlashAttribute("message", "SUCCESS");
			}
		}

		return "redirect:/admin/userInfo";
	}

}

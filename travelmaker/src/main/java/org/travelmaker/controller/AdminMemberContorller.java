package org.travelmaker.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
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

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);

		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);

		String formattedDate = dateFormat.format(date);

		model.addAttribute("serverTime", formattedDate);

		return "home";
	}

	@GetMapping("userInfo")
	public String userInfo(Criteria cri, Model model) {

		model.addAttribute("criteria", cri);

		if (cri.getKeyword() == null || cri.getType() == null) {
			model.addAttribute("users", service.getUserList());
		} else {
			model.addAttribute("users", service.searchUser(cri));
		}
		
		return "userInfo";
	}
	
	/*
	@GetMapping("userinfo/{type}/{keyword}")
	public String searchUser(@PathVariable("type") String type,@PathVariable("keyword") String keword) {
		model.addAttribute("users", service.searchUser(cri));
		return "userInfo";
	}*/
/*
	@GetMapping("userInfo/{memNo}")
	public void userInfo(@PathVariable("memNo") String memNo, RedirectAttributes rttr) {
		
		rttr.addFlashAttribute("userInfo", service.getUser(memNo));
		
	}*/

	@GetMapping("withdraw")
	public String withdraw(Criteria cri, Model model) {
		
		if (cri.getKeyword() == null || cri.getType() == null) {
			model.addAttribute("users", service.getWithdrawUserList());
		} else {
			model.addAttribute("users", service.searchWithdrawUser(cri));
		}
		return "withdraw";
	}

	@GetMapping("/remove")
	public String removeUser(int[] result, RedirectAttributes rttr) {
		
		if(result!=null) {
			for (int i = 0; i < result.length; i++) {
					service.removeUser(result[i]);
					rttr.addFlashAttribute("message", "SUCCESS");
			}
		}

		return "redirect:/admin/userInfo";
	}

}

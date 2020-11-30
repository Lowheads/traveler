package org.travelmaker.controller;

import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.travelmaker.domain.Criteria;
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
		
		model.addAttribute("users", service.getUserList(cri));
		
		return "userInfo";
	}

	@GetMapping("withdraw")
	public String withdraw(Criteria cri, Model model) {

		String type = cri.getType();
		String keyword =cri.getKeyword();
		
		model.addAttribute("users", service.getWithdrawUserList(cri));
		
		return "withdraw";
	}

	@GetMapping("/remove/{ids}")
	public String removeUser(@PathVariable("ids") ArrayList<Integer> ids, RedirectAttributes rttr) {

			service.removeUser(ids);
			rttr.addFlashAttribute("message", "SUCCESS");

		return "redirect:/admin/userInfo";
	}

}

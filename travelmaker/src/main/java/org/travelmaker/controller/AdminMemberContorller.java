package org.travelmaker.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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

	@RequestMapping(value= {"/userInfo","/withdraw"}, method=RequestMethod.GET)
	public String user(Criteria cri, Model model,  HttpServletRequest req) {

		String type = cri.getType();
		String keyword =cri.getKeyword();
		
		StringBuffer path = req.getRequestURL();
		
		String destinationUrl = "";
		
		if(path.indexOf("userInfo")!=-1) {
			
			model.addAttribute("users", service.getUserList(cri));
			destinationUrl = "userInfo";

		}else{
			
			model.addAttribute("users", service.getWithdrawUserList(cri));
			destinationUrl = "withdraw";
		}
		
		return destinationUrl;
	}

	@GetMapping("/remove/{ids}")
	public String removeUser(@PathVariable("ids") ArrayList<Integer> ids, RedirectAttributes rttr) {

		int result = service.removeUser(ids);
		
		if(result == ids.size()) {
			rttr.addFlashAttribute("message", "SUCCESS");
		}
		return "redirect:/admin/userInfo";
	}

}

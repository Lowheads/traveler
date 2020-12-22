package org.travelmaker.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.travelmaker.service.BoardService;
import org.travelmaker.service.PlaceService;
import org.travelmaker.service.RegionService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

/**
 * Handles requests for the application home page.
 */
@Controller
@AllArgsConstructor
@Log4j
public class HomeController {
	
	@GetMapping(path="/placeDB") //loginform이라는 요청이 들어오면
	public String loginform() {
			return "placeDB"; //해당 요청을 받아서 loginform.jsp 수행
		}
		
//해당 요청을 받아서 처리할 수 있는 컨트롤러
        @PostMapping(path="/login")
//name="passwd"는 input의 name과 일치해야 한다
		public String login(@RequestParam(name="passwd", required=true) String passwd, 
				HttpSession session,
				RedirectAttributes redirectAttr) {
			
			if("1234".equals(passwd)) {
				session.setAttribute("memNo", "1"); //세션의 이름과 값 설정
			} else {
				redirectAttr.addFlashAttribute("errorMessage", "암호가 틀렸습니다.");
				return "redirect:/loginform";
			}
			return "redirect:/mypage/pickPL";
		}
		
       @GetMapping(path="/logout")
		public String login(HttpSession session) {
			session.removeAttribute("isAdmin");
			return "redirect:/list";
		}
       
       @GetMapping("/")
       public String home() {
    	   return "redirect:/main/index";
    	   
       }
}

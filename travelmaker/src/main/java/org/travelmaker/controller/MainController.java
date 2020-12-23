package org.travelmaker.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.ParseException;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.travelmaker.domain.ScheduleDTO;
import org.travelmaker.service.BoardService;
import org.travelmaker.service.MemberService;
import org.travelmaker.service.PlaceService;
import org.travelmaker.service.RegionService;
import org.travelmaker.service.apiLoginService;

import com.github.scribejava.core.model.OAuth2AccessToken;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/main/*")
@AllArgsConstructor
@Log4j
public class MainController {
	
	private RegionService service;
	private PlaceService placeService;
	private BoardService boardservice;
	private apiLoginService apiService;
	private MemberService memberService;
	
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(java.sql.Date.class, new CustomDateEditor(dateFormat, false));
	}
	@PostMapping(value="/theme", produces= {MediaType.APPLICATION_JSON_UTF8_VALUE}) 
	public void getInitSch(@ModelAttribute("schDto") ScheduleDTO schDTO, Model model) {
		for (int i = 1; i <= 6; i++) {
			model.addAttribute("theme"+i,placeService.getListWithTheme(schDTO.getSchRegion(),"TM00"+i));
		}
	}
	
	@GetMapping("/index")
	public ModelAndView main(Model model, HttpSession session){
		log.info(service.getList());
		model.addAttribute("list", service.getList());
		
		model.addAttribute("adminlist",boardservice.getAdminList());
		
    	try {
    		
            /* 네아로 인증 URL을 생성하기 위하여 getAuthorizationUrl을 호출 */
            String naverAuthUrl = apiService.getNaverAuthUrl(session);
            
            /* 생성한 인증 URL을 View로 전달 */
            return new ModelAndView("/main/index", "url", naverAuthUrl);
        	}catch(Exception e) {
        		e.getMessage();
        		return new ModelAndView("/main/index");
        	}
	}
	
	//네이버 로그인 성공시 callback호출 메소드
	  // 'id'값은 각 애플리케이션마다 회원 별로 유니크한 값
   @RequestMapping(value = "/callback", method = { RequestMethod.GET, RequestMethod.POST })
   public String callback(Model model, @RequestParam String code, @RequestParam String state, HttpSession session, RedirectAttributes rttr) throws IOException, ParseException {
	    System.out.println("여기는 callback");
	    
	    OAuth2AccessToken oauthToken = apiService.getNaverToken(code, state, session); // 네이버 토큰을 얻는다.
	    String userInfo = apiService.getNaverUserProfile(oauthToken); // // 로그인한 사용자 정보를 읽어온다.
	    
	    // 데이터 파싱
	    // 토큰과 네이버 프로필을 JSON형태로 
	    JSONObject responseObj = apiService.getJsonByNaver(oauthToken, userInfo);
	    String email = (String)responseObj.get("email"); // 로그인한 사용자의 이메일을 저장한다
	    
	    if(memberService.isNaverApiJoinCheck(responseObj, model)) { // 회원이 아니면 회원가입 창으로 보낸다.
	    	return "/member/apiRegister";
	    }
	     
	    if(memberService.isDeleteAlready(email, rttr)) { // 탏퇴한 계정이면 로그인 안됩니다.
	    	return "redirect:/member/main";
	    }
	    
	    // 이미 회원이라면 세션주고 로그인
	    session.setAttribute("email", email);
	    memberService.setLoginDateToToday(email); // 최종 로그인은 오늘..
	    System.out.println("네이버 로그인한 회원의 번호 : " + memberService.getMemNo(email));
	    return "redirect:/main/index";
	    
   }
	
}

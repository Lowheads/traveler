package org.travelmaker.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.ParseException;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.travelmaker.domain.MemberVO;
import org.travelmaker.domain.PlaceDTO;
import org.travelmaker.domain.PlaceVO;
import org.travelmaker.domain.ScheduleDTO;
import org.travelmaker.domain.ScheduleVO;
import org.travelmaker.domain.ThemeAttachVO;
import org.travelmaker.service.BoardService;
import org.travelmaker.service.BudgetService;
import org.travelmaker.service.MemberService;
import org.travelmaker.service.PlaceService;
import org.travelmaker.service.RegionService;
import org.travelmaker.service.ScheduleService;
import org.travelmaker.service.SocialLoginService;
import org.travelmaker.service.ThemeService;

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
	private SocialLoginService socialLoginService;
	private MemberService memberService;
	private ThemeService themeService;
	private BudgetService budgetservice;
	private ScheduleService scheduleservice;
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(java.sql.Date.class, new CustomDateEditor(dateFormat, false));
	}
	@PostMapping(value="/theme", produces= {MediaType.APPLICATION_JSON_UTF8_VALUE}) 
	public void getInitSch(@ModelAttribute("schDto") ScheduleDTO schDTO, Model model) {

		Map<Integer, List<PlaceDTO>> theme = new HashMap<Integer, List<PlaceDTO>>();
		
		for(int i =1; i<7;i++) {
			
			theme.put(i-1, placeService.getListWithTheme(schDTO.getSchRegion(),"TM00"+i));
		}
		
		model.addAttribute("themeList", theme);

		List<PlaceVO> rainyDay=new ArrayList<PlaceVO>();
		
		//만약 비가 온다면
		if(false) {
			rainyDay =  placeService.getPlaceByWeather(schDTO.getSchRegion());
		}
		
		model.addAttribute("rainydayRec", placeService.getPlaceByWeather(schDTO.getSchRegion()));
	
	}
	
	@GetMapping(value ="/getWeatherRec/{regionNo}", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<List<PlaceVO>> getWeatherRec(@PathVariable("regionNo") int RegionNo){
		
		return new ResponseEntity<>(placeService.getPlaceByWeather(RegionNo), HttpStatus.OK);
	}
	
	@GetMapping(value ="/getAttachment", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<ThemeAttachVO> getAttachment(int themeNo){
		
		return new ResponseEntity<>(themeService.getAttachment(themeNo), HttpStatus.OK);
	}
	
	
	@GetMapping("/index")
	public ModelAndView main(Model model, HttpSession session){
		log.info(service.getList());
		model.addAttribute("list", service.getList());
		model.addAttribute("adminlist",boardservice.getAdminList());
		
        /* 네아로 인증 URL을 생성하기 위하여 getAuthorizationUrl을 호출 */
        String naverAuthUrl = socialLoginService.getNaverAuthUrl(session);
        if(session.getAttribute("email")!=null) {
        	model.addAttribute("budList", budgetservice.getBudgetByUser(memberService.getMemNo(String.valueOf(session.getAttribute("email")))));
        }
        /* 생성한 인증 URL을 View로 전달 */
        return new ModelAndView("/main/index", "url", naverAuthUrl);
        
	}
	
   @RequestMapping(value = "/callback", method = { RequestMethod.GET, RequestMethod.POST })
   public String callback(Model model, @RequestParam String code, @RequestParam String state, HttpSession session, RedirectAttributes rttr, HttpServletRequest request) throws IOException, ParseException {
	    
		
   	try {
	    OAuth2AccessToken oauthToken = socialLoginService.getNaverToken(code, state, session); // 네이버 토큰을 얻는다.
	    String userInfo = socialLoginService.getNaverUserProfile(oauthToken); // // 로그인한 사용자 정보를 읽어온다.
	    
	    
	    // 데이터 파싱
	    // 토큰과 네이버 프로필을 JSON형태로 
	    JSONObject responseObj = socialLoginService.getJsonByNaver(oauthToken, userInfo);
	    String email = (String)responseObj.get("email"); // 로그인한 사용자의 이메일을 저장한다
	    
	    if(memberService.isNaverApiJoinCheck(responseObj, model)) { // 회원이 아니면 회원가입 창으로 보낸다.
	    	return "/member/apiRegister";
	    }
	     
	    if(memberService.isDeleteAlready(email, rttr)) { // 탏퇴한 계정이면 로그인 안됩니다.
	    	return "redirect:/main/index";
	    }
	    
	    MemberVO naverMember = memberService.getMember(email);
	    
	    memberService.isAdminLogin(naverMember, session);
	    
	    // 이미 회원이라면 세션주고 로그인
	    log.info("네이버 로그인한 회원의 번호 : " + memberService.getMemNo(email));
	    return "redirect:/main/index";
	    
	}catch(Exception e) {
		e.getStackTrace();
		rttr.addFlashAttribute("msg", "예상치못한 에러가 발생했습니다. 메인 홈페이지로 이동합니다");
		return "redirect:/main/index";
	}
   	
   }
   
	@RequestMapping(value = "/getSchedule", method = RequestMethod.POST, produces = "application/json")
	@ResponseBody
	public List<Map<String, Object>> getSchedule(String email ){
		System.out.println(scheduleservice.checkBudgetList(memberService.getMemNo(email)));
		return scheduleservice.checkBudgetList(memberService.getMemNo(email));
	}
	
}

package org.travelmaker.controller;

import java.io.IOException;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.travelmaker.loginapi.NaverLoginBO;

import com.github.scribejava.core.model.OAuth2AccessToken;
import org.travelmaker.domain.MemberVO;
import org.travelmaker.service.MemberService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/member/*")
public class MemberComtroller {

	@Setter(onMethod_ = @Autowired) // 무조건 주입
	private MemberService service;
	
	// 메인페이지..
//	@GetMapping("/main")
//		public void home() {
//			log.info("home..");
//		}
	
	// 로그인에 성공하면 여기루 넘어온다.
	@GetMapping("/success") 
	public void success() {
		log.info("Success");
	}
	
	@GetMapping("/accountInfo") 
	public void accountInfo() {
		log.info("accountInfo");
	}
	
	@GetMapping("/deletePage") 
	public void delete() {
		log.info("deletePage");
	}
	
	// 회원가입정보를 다 입력하고 회원가입 버튼을 누른다. 
	// value : 폼액션에서 넘겨줄 주소이다.
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String register(MemberVO mVO, HttpSession session, RedirectAttributes rttr) {
		
		if(service.emailCheck(mVO.getEmail()) > 0) {
			rttr.addFlashAttribute("flag", false);
			rttr.addFlashAttribute("msg", "이메일이 중복된다구요 ㅠㅠ");
			return "redirect:main"; // 다시 메인으로 이동 ㅠ
		}
		
		if(service.nicknameDuplCheck(mVO.getNickname()) > 0) {
			rttr.addFlashAttribute("flag", false);
			rttr.addFlashAttribute("msg", "닉네임이 중복된다구요 ㅠㅠ");
			return "redirect:main"; // 다시 메인으로 이동 ㅠ
		}
		service.join(mVO); // 내용을 저장한다.
		session.setAttribute("email", mVO.getEmail()); // 세션을 추가한다.
		rttr.addFlashAttribute("flag", false);
		rttr.addFlashAttribute("msg", "travel 가족이 되신걸 환영합니다");
		return "redirect:main"; // 회원가입 후, success.jsp로 이동
	}
	
	// 로그인
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(MemberVO mVO, HttpSession session, HttpServletRequest request, HttpServletResponse response, RedirectAttributes rttr) {
		
		String email = request.getParameter("email");
		String check = request.getParameter("remember"); // 체크 여부를 담자
		Cookie cookie = new Cookie("email", email); // 쿠키 생성
		
		// 로그인에 실패하면 메인 페이지로
		if(service.login(mVO)==null) {
			rttr.addFlashAttribute("flag", false);
			rttr.addFlashAttribute("msg", "이메일 또는 패스워드를 확인해주세요 ㅠㅠ..");
		return "redirect:main";
		}
		
		// id저장하기 눌렀으면 쿠키 증정..
		if(service.isChecked(check)) {
			response.addCookie(cookie);
		}
		// id저장 안 눌렀으면 쿠키 없음..
		if(service.isChecked(check) == false) {
			cookie.setMaxAge(0);
			response.addCookie(cookie);
		}
		
		// DB와 정보가 맞으면 세션 주고, 로그인 성공
		service.login(mVO); // 로그인 시키자..!
		service.presentDate(mVO.getEmail()); // 최종 로그인은 오늘이겠지..
		MemberVO vo = service.viewMember(email);
		rttr.addFlashAttribute("flag", false); // 환영메시지 띄우기(alert)
		rttr.addFlashAttribute("msg", email+"님!!! travle에 방문해주셔서 감사합니다!"); // 환영메시지 띄우기(alert)
		session.setAttribute("email", mVO.getEmail()); // 세션에 이메일 담자
		//수정 순규
		session.setAttribute("memNo",vo.getMemNo());
		return "redirect:success";
	
	}
	
	// 로그아웃
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) throws Exception{

		// 세션 삭제
		session.invalidate();
		
		// 메인으로 이동
		return "redirect:main";
	}
	
	// 회원 조회
	@RequestMapping(value = "/viewMember", method = RequestMethod.GET)
	public String viewMember(String email, Model model) {
		// 로그인한 정보를 담는다.
		model.addAttribute("member", service.viewMember(email));
		// 조회페이지로 이동한다.
		return "/member/accountInfo";
	}
	
	// 비밀번호 변경
	@RequestMapping(value = "/pwdModify", method = RequestMethod.POST)
	public String pwdModify(String pwd, String email, Model model) {
		// 비밀번호를 바꾼다.
		service.pwdModify(pwd, email);
		
		// 바뀐 정보를 담는다.
		model.addAttribute("member", service.viewMember(email));
		// 조회페이지로 이동한다.
		return "/member/accountInfo";
	}
	
	// Email체크
	@RequestMapping("/emailCheck")
    @ResponseBody
    public String emailCheck(@RequestParam("email") String email) {
        
        String count = ""+service.emailCheck(email); // 중복되면 1 반환
        
        return count;
    }
	
	// 닉네임 체크
	@RequestMapping("/nicknameDuplCheck")
	@ResponseBody
	public String nicknameDuplCheck(@RequestParam("nickname") String nickname) {
		System.out.println(nickname);
		
		String cnt = ""+service.nicknameDuplCheck(nickname); // 닉네임 있으면 1, 없으면 0을 반환한다.
		
		return cnt;
	}
	
	// 닉네임 수정(회원정보에서 저장하기 버튼 누르면 실행)
	@RequestMapping(value = "/nNameModify", method = RequestMethod.POST)
	public String nNameModify(String nickname, String email, Model model, RedirectAttributes rttr) {

		// nickNameResult : 닉네임 있으면 1, 없으면 0
		int nickNameResult = service.nicknameDuplCheck(nickname); 
		
		// 저장하기를 눌렀을 떄, 닉네임을 변경하지 않았거나, 중복된 닉네임이 없다면 저장한다.
		if(service.myNicknamePass(nickname, email) || nickNameResult < 1) {
			service.nNameModify(nickname, email);
			rttr.addFlashAttribute("flag", false);
			rttr.addFlashAttribute("msg", "정보를 정상적으로 수정하였습니다!");
			return "redirect:main";
		}
			// 중복된 닉네임이 있다면 중복된다고 알려준다
			rttr.addFlashAttribute("flag", false);
			rttr.addFlashAttribute("msg", "닉네임이 중복됩니다. 다른 닉네임으로 선정해주세요!!");
			return "redirect:main";
	}
	
	//회원탈퇴 페이지 이동
	@RequestMapping(value = "/deletePage", method = RequestMethod.POST)
	public String deletePage(String email, Model model) {
		// 계정을 삭제하기 위한 페이지로 이동한다. (모델에 내 현재 email과 pwd를 담아서...)
		model.addAttribute("member", service.viewMember(email));
		
		return "/member/deletePage";
	}
	
	// 회원탈퇴(status를 탈퇴로 바꾼다.. 계정이 사라지는게 아님)
	@RequestMapping(value = "/deleteMember", method = RequestMethod.GET)
	public String deleteMember(String pwd, String email, HttpSession session, RedirectAttributes rttr) {
		
		System.out.println(pwd);
		System.out.println(email);
		
		// 회원 상태를 "탈퇴"로 변경한다.
		service.deleteMember(pwd, email);
		// 세션을 제거한다.
		session.invalidate();
		
		// 정상적으로 탈퇴 되었다는 메세지를 보낸다.
		rttr.addFlashAttribute("flag", false);
		rttr.addFlashAttribute("msg", "travel을 이용해주셔서 감사했습니다.");
		
		return "/member/main";
	}
	
	/* NaverLoginBO */
	private NaverLoginBO naverLoginBO;
	private String apiResult = null;

	/* NaverLoginBO */
	@Autowired
	private void setNaverLoginBO(NaverLoginBO naverLoginBO){
		this.naverLoginBO = naverLoginBO;
	}
	
    @RequestMapping("/main")
    public ModelAndView login(HttpSession session) { // <- 네이버 로그인 성공하면 callback으로 가는 듯.
        /* 네아로 인증 URL을 생성하기 위하여 getAuthorizationUrl을 호출 */
        String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
        
        /* 생성한 인증 URL을 View로 전달 */
        return new ModelAndView("/member/main", "url", naverAuthUrl);
    }
    
  //네이버 로그인 성공시 callback호출 메소드
    @RequestMapping(value = "/callback", method = { RequestMethod.GET, RequestMethod.POST })
    public String callback(Model model, @RequestParam String code, @RequestParam String state, HttpSession session) throws IOException, ParseException {
    System.out.println("여기는 callback");
    OAuth2AccessToken oauthToken;
    oauthToken = naverLoginBO.getAccessToken(session, code, state);
    //1. 로그인 사용자 정보를 읽어온다.
    apiResult = naverLoginBO.getUserProfile(oauthToken); //String형식의 json데이터
    /** apiResult json 구조
    {"resultcode":"00",
    "message":"success",
    "response":{"id":"33666449","nickname":"shinn****","age":"20-29","gender":"M","email":"sh@naver.com","name":"\uc2e0\ubc94\ud638"}}
    **/
    
    //2. String형식인 apiResult를 json형태로 바꿈
    JSONParser parser = new JSONParser();
    Object obj = parser.parse(apiResult);
    JSONObject jsonObj = (JSONObject) obj;
    
    //3. 데이터 파싱
    //Top레벨 단계 _response 파싱
    JSONObject response_obj = (JSONObject)jsonObj.get("response");
    //response의 nickname값 파싱
    String email = (String)response_obj.get("email");
   
    //4.파싱 이메일 세션으로 저장
    if(service.emailCheck(email) == 1) { // 이제 sns 회원 테이블 만들어야겠다(회원 번호, 아이디, 성별 정도만 받자..)
    	session.setAttribute("email",email); // 네이버아이디 == traver가족이면 회원가입 안 해도 됨. 바로 세션 주기
    }
    model.addAttribute("result", apiResult);
    // "oauth_state" 네이버 로그인하면 주는 세션 아이디인듯
    // 이걸 이용해서 회원 로그인 판단해도 될 듯..
    System.out.println(session.getAttribute("oauth_state"));
    System.out.println(apiResult); // 네이버 로그인 정보					
    return "/member/naverSuccess";
    }
    
    // 로그인 해야 들어갑니다아
	@RequestMapping(value = "/testPage", method = RequestMethod.GET)
	public String testPage(HttpSession session, RedirectAttributes rttr) {
		System.out.println("testPAge");
		// 회원 로그인
		String result = (String)session.getAttribute("email");
//		String naverSessoin = (String)session.getAttribute("oauth_state");
		
		// 로그인 안됐으면 로그인 하라고 알려주자
		if(result == null) {
			rttr.addFlashAttribute("flag", false);
			rttr.addFlashAttribute("msg", "로그인 해주세요!");
			return "redirect:main";
		}
		
		// testPage로 이동한다.
		return "/member/testPage";
	}
    
	
}

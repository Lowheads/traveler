package org.travelmaker.service;

import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.travelmaker.domain.Email;
import org.travelmaker.domain.MemberVO;
import org.travelmaker.mapper.MemberMapper;
import org.travelmaker.mapper.QnABoardMapper;

import com.fasterxml.jackson.databind.JsonNode;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class MemberServiceImpl implements MemberService {
   
	private final MemberMapper mapper; 
	private final PasswordEncoder passwordEncoder;
	
	   
	public MemberServiceImpl(MemberMapper memberMapper, PasswordEncoder passwordEncoder) {
		this.mapper = memberMapper;
		this.passwordEncoder = passwordEncoder;
	}
	   
	
	// 비밀번호 일치 확인(암호화) rawPwd : 입력한 비밀번호 / encodePwd : DB에 저장된 비밀번호
	public boolean isPwdMatch(String rawPwd, String encodePwd) {
		
		if(passwordEncoder.matches(rawPwd, encodePwd)) {
			return true;
		}
		return false;
	}
	
	
	@Override
	public void join(MemberVO mVO) {    // 회원가입
		   
		// 회원가입하면 비밀번호는 암호화돼서 DB에 저장된다.
		String encryptPwd = passwordEncoder.encode(mVO.getPwd());

		mVO.setPwd(encryptPwd);
		       
		mapper.join(mVO);
	}
	
	
	// email 기억하기 여부
	public boolean isChecked(String check) { 
	   return check != null ? true : false; 
	}
	
	// email 기억하기 (로그인)
	public void rememberEmail(String email, HttpServletRequest request, HttpServletResponse response) { 
	      
	   String check = request.getParameter("remember"); // 체크 여부를 담자
	   Cookie cookie = new Cookie("email", email);     // 쿠키 생성
	      
	   // email 저장하기 눌렀다면..
	   if(isChecked(check)) {
	  	 cookie.setPath("/");
	     response.addCookie(cookie);
	   }
	      
	   // email 저장하기를 해제했다면..
	   if(!(isChecked(check))) {
	      cookie.setMaxAge(0);
	      cookie.setPath("/");
	      response.addCookie(cookie);
	   }
	}
	
	   
	public boolean isDuplicateCheck(MemberVO mVO, RedirectAttributes rttr) { // 회원가입(이메일, 닉네임 중복체크)
	   if(hasEmail(mVO.getEmail()) > 0) { // 아이디가 중복이라면..
	      rttr.addFlashAttribute("msg", "아이디가 중복됩니다.");
	      return true;
	   }
	      
	   if(hasNickname(mVO.getNickname()) > 0) { // 닉네임이 중복이라면..
	      rttr.addFlashAttribute("msg", "닉네임이 중복됩니다.");
	      return true;
	   }
	   return false;
	}
	   

	public MemberVO login(MemberVO mVO) { // 로그인 기능
		setLoginDateToToday(mVO.getEmail()); 
	   return mapper.login(mVO);
	}
	   
	@Override
	public void setLoginDateToToday(String email) { // 최종 로그인 날짜 수정
	   mapper.lastLoginSetToday(email);
	}
	   
	
    // 로그인 (입력 정보가 틀리거나, 탈퇴한 회원은 안 돼요!)
	public boolean isValidMember(MemberVO mVO, RedirectAttributes rttr) { 
		   
	   try{
			   
			String rawPwd = mVO.getPwd();
			String encodePwd = mapper.getMember(mVO.getEmail()).getPwd();
			   
		    if(!(isPwdMatch(rawPwd, encodePwd))) {
		    	rttr.addFlashAttribute("msg", "이메일 또는 패스워드를 확인해주세요.");
		    	return true;
		    }
		    	mVO.setPwd(rawPwd);
			   
		    	MemberVO member = mapper.getMember(mVO.getEmail());
		    	
		      if(member.getStatus().equals("MS002")) {
		         rttr.addFlashAttribute("msg", "이미 탈퇴한 회원입니다.");
		         return true;
		      }
		   }catch (NullPointerException npe) {
			   npe.getStackTrace();
			   rttr.addFlashAttribute("msg", "이메일 또는 패스워드를 확인해주세요.");
			   return true;
		   }
	            
	      return false;
	   }
	
	
	// 로그인처리 (일반회원이면 main으로, 관리자면 관리자 페이지로 가자) 
	@Override
	public boolean isAdminLogin(MemberVO mVO, HttpSession session) {
		
		// 로그인 하는 회원의 등급을 memberGrade 변수에 저장
		String memberGrade = mapper.getMember(mVO.getEmail()).getMemGrade();

		session.setAttribute("email", mVO.getEmail()); // 세션에 이메일 담자
		session.setAttribute("memNo",getMemNo(mVO.getEmail()));
		session.setAttribute("myGrade", memberGrade);
		
		// 관리자는 관리자 페이지로
		if(memberGrade.equals("MG002")) {
			return true;
		}
				
		return false;
	}

	   
	@Override
	public int getMemNo(String email) { 
	   return mapper.getMemNo(email).getMemNo();
	}

	@Override
	public void modifyPwd(String pwd, String email) { // 비밀번호 수정
		   
		String rawPwd = passwordEncoder.encode(pwd);
		   	
	    mapper.modifyPwd(rawPwd, email);
	}

	@Override
	public MemberVO getMember(String email) { // 내 정보 조회
		   
		MemberVO vo = mapper.getMember(email);
		   
		if(vo == null) {
		   return vo;
		}
		
		if(vo.getGender().equals("M")) {
			vo.setGender("남");
		}else {
			vo.setGender("여");
		}

	return vo;
   }
	   
	public boolean isApiLoginCheck(String email) { // api로그인일경우 apimemberInfofo 페이지로 이동

		String grade = mapper.getMember(email).getMemGrade();
		
	   if(grade.equals("MG003")) {
	      return true;
	   }
	   return false;
	}
	   
	@Override
	public int hasEmail(String email) { // email 체크
	   return mapper.hasEmail(email);
	}

	public void modifyNickname(String nickname, String email) { // 닉네임 변경
	   mapper.modifyNickname(nickname, email);
	}

	@Override
	public int hasNickname(String nickname) { // 닉네임 중복체크
	   return mapper.hasNickname(nickname);
	}
	   
	// QnA게시판의 작성자 변경(닉네임 변경시 적용)
	public void modifyBoardNickname(String nickname, int memNo) {
		mapper.modifyBoardNickname(nickname, memNo);
	}
	   
	// QnA게시판의 작성자 변경(닉네임 변경시 적용)
	public void modifyBoardReplyer(String nickname, String replyer) {
		mapper.modifyBoardReplyer(nickname, replyer);
	}
	
	public boolean isNotModifyNickname(String nickname, MemberVO member) {
		if(nickname.equals(member.getNickname())) {
			return true;
		}
		return false;
	}

		
	@Override
	@Transactional
	public boolean doubleCheckOnesNickname(String nickname, MemberVO member, RedirectAttributes rttr) {
		
		if(isNotModifyNickname(nickname, member)) {
			rttr.addFlashAttribute("msg", "정보가 저장되었습니다.");
			return true;
		}
		
	   int nicknameResult = hasNickname(nickname);
	   
	   // 중복된 닉네임이면
	   if(nicknameResult > 0) {
		   rttr.addFlashAttribute("msg", "닉네임이 다른 회원과 중복됩니다.");
		   rttr.addFlashAttribute("member", member);
	     return true;
	   }
	    
	   // 정보가 정상적으로 저장되었습니다.
	    String changeBeforeNickname = member.getNickname(); // 변경 전 닉네임을 저장..
	    String email = member.getEmail();
	    
	    modifyNickname(nickname, email); // 닉네임 변경
		modifyBoardNickname(nickname, getMemNo(email)); // Q&A게시판 작성자를 바뀐 닉네임으로 수정
		modifyBoardReplyer(nickname, changeBeforeNickname); // 변경 전 닉네임을 전부 바뀐 닉네임으로 수정
		rttr.addFlashAttribute("msg", "정보가 저장되었습니다.");
		rttr.addFlashAttribute("member", getMember(email));
		return false;
	 }
	

	// 탈퇴 전 유효성 체크
	@Override
	public boolean isDoubleCheckOnesPwd(String pwd, String email, RedirectAttributes rttr, HttpSession session) {
		   
	   String dbPwd = mapper.getMember(email).getPwd();
	    
	   if(!(isPwdMatch(pwd, dbPwd))) {
	   	   rttr.addFlashAttribute("msg", "비밀번호가 일치하지 않습니다.");
	   	   return true;
	   }
	
	   mapper.deleteMember(email);	
	   session.invalidate();
	   rttr.addFlashAttribute("msg", "여행의정석을 이용해주셔서 감사했습니다.");
	   return false;
	}
	   
	@Override
	public void deleteApiMember(String email, RedirectAttributes rttr, HttpSession session) { // api 회원탈퇴
	   mapper.deleteMember(email);
	   rttr.addFlashAttribute("msg", "여행의정석을 이용해주셔서 감사했습니다.");
	   session.invalidate();
	}
	
	public String createUUID() {
	   String uuid = UUID.randomUUID().toString().replaceAll("-", ""); // -를 제거해 주었다.

	   // 새로운 비밀번호를 생성한다.
	   for (int i = 0; i < 1; i++) {
	      uuid = uuid.substring(0, 10); // uuid를 앞에서부터 10자리 잘라줌.
	   }
	      
	   return uuid;
	}
	   
	@Override
	public Email writingEmail(String email, Email emailObj) { // 임시 비밀번호 메일보내기
	      
		String uuid = createUUID();
		String encPassword = passwordEncoder.encode(uuid); // 임시 비밀번호를 암호화하여 변수에 저장한다.
		String newPwd= uuid; // 이메일로 보낼 비밀번호는 암호화 되기 전이야 한다.

		mapper.modifyPwd(encPassword, email);
	            
	    emailObj.setReceiver(email); // 받는 사람
	    emailObj.setSubject(email+"님 여행의정석에서 보내드리는 임시 비밀번호 메일입니다."); // 제목
	    emailObj.setContent("안녕하세요, 여행의정석입니다! \n" + email + "님의 임시 비밀번호는 "+newPwd+" 입니다\n"
	              + "로그인하시고 새로운 비밀번호로 변경해주세요!"); // 내용
	      
	  return emailObj;
	}
	   
	   
	@Override
	public Email writingCertEmail(String email, String certNum, Email emailObj) { // 소셜 계정 회원탈퇴 인증메일 보내기
	      
	     emailObj.setReceiver(email); // 받는 사람
	     emailObj.setSubject(email+"님 여행의정석에서 보내드리는 회원탈퇴 인증번호입니다."); // 제목
	     emailObj.setContent("안녕하세요, 여행의정석입니다! \n" + email + "님의 여행의정석 회원탈퇴 인증번호는 "+certNum+" 입니다\n"); // 내용
	      
	     return emailObj;
	}
	   
	   
	public boolean isNaverApiJoinCheck(JSONObject responseObj, Model model) { // api 로그인할 경우 회원가입 되어 있는지 확인
	    String email = (String)responseObj.get("email"); // 로그인한 사용자의 이메일을 저장한다
	    String nickname = (String)responseObj.get("nickname"); // 로그인한 사용자의 닉네임을 저장한다
	    String gender = (String)responseObj.get("gender"); // 로그인한 사용자의 성별을 저장한다
	      
	   // 우리 회원이 아니면 회원가입 창으로 보낸다.
	   if(hasEmail(email) != 1) {
 	      model.addAttribute("email", email);
	      model.addAttribute("nickname", nickname);
	      model.addAttribute("gender", gender);
	      return true;
	   }
	      
	   return false;
	}

	@Override
	public boolean isKakaoApiJoinCheck(JsonNode userProfile, Model model) {
	      
	        JsonNode properties = userProfile.path("properties"); // properties 경로를 저장한다.
	        JsonNode kakao_account = userProfile.path("kakao_account"); // 내 프로필 정보를 담는다.
	        String email = kakao_account.get("email").textValue(); // 프로필에서 이메일만 빼온다
	        String gender = kakao_account.get("gender").textValue(); // 프로필에서 성별을 빼온다.
	        String nickname = properties.path("nickname").asText(); // properties에서 이름을 빼온다.
	           
	        // 우리 회원이 아니면 회원가입 창으로 보낸다.
	        if(hasEmail(email) != 1) {
	           model.addAttribute("nickname", nickname);
	           model.addAttribute("email", email);
	           model.addAttribute("gender", gender);
	           return true;
	        }

	   return false;
	}
	
	// 소셜계정 탈퇴여부 확인
	@Override
	public boolean isDeleteAlready(String email, RedirectAttributes rttr) {
	      
		String status = mapper.getMember(email).getStatus();
		
	   if(status.equals("MS002")) {
	      rttr.addFlashAttribute("msg", "이미 탈퇴한 회원입니다.");
	      return true;
	   }
	      
	   return false;
	}

	@Override
	public boolean updateTT(String yourType, int memNo) {

		return (mapper.updateTTT(yourType,memNo)==1);
	}

	@Override
	public boolean isEamilChack(String email, RedirectAttributes rttr) {
		
		MemberVO member = mapper.getMember(email);
			
		// Travel 회원의 이메일이 아니라면..
	     if(member == null || member.getStatus().equals("MS002")) {
	      	rttr.addFlashAttribute("msg", "여행의정석 회원이 아닙니다.");
	       	return true;
	     }
	     // api 회원이면 비밀번호 찾을 필요 없이 로그인 해주세요
	     if(member.getMemGrade().equals("MG003")) {
	       	rttr.addFlashAttribute("msg", "소셜회원입니다. 소셜로그인 부탁드립니다.");
	       	return true;
	     }
			
	   return false;
	}

	
	// 내 정보 페이지에서 비밀번호 변경시 유효성 검사
	@Override
	public boolean isValidInputCheck(String email, String inputPwd, String newPwd, 
			HttpSession session, RedirectAttributes rttr) {
		
		String sessionEmail = (String)session.getAttribute("email");
		String presentPwd = mapper.getMember(sessionEmail).getPwd();

		// 개발자 도구 email 바꾸기 막기(hidden)
		if(!(email.equals(sessionEmail))) {
			rttr.addFlashAttribute("member", getMember(email));
			return true;
		}

		if(!(isPwdMatch(inputPwd, presentPwd))) {
			rttr.addFlashAttribute("msg", "현재 비밀번호와 일치하지 않습니다.");
			rttr.addFlashAttribute("member", getMember(email));
			return true;
		}

		return false;
	}


	@Override
	public void moneyCharging(long money, String email) {
		mapper.moneyCharging(money, email);
	}
	

}// end ServiceImpl
package org.travelmaker.service;

import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.travelmaker.domain.Email;
import org.travelmaker.domain.MemberVO;
import org.travelmaker.mapper.MemberMapper;

import com.fasterxml.jackson.databind.JsonNode;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
// 로직을 담당한다.
public class MemberServiceImpl implements MemberService {
	
	@Setter(onMethod_ = @Autowired)
	private MemberMapper mapper; // 무조건 주입
	
	@Override
	public void join(MemberVO mVO) { 	// 회원가입
		mapper.join(mVO);
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
	

	@Override
	public MemberVO login(MemberVO mVO) { // 로그인 기능
		return mapper.login(mVO);
	}
	
	@Override
	public void lastLoginSetToday(String email) { // 최종 로그인 날짜 수정
		mapper.lastLoginSetToday(email);
	}
	
	// email저장(로그인)
	public void RememberEmail(String email, HttpServletRequest request, HttpServletResponse response) { 
		
		String check = request.getParameter("remember"); // 체크 여부를 담자
		Cookie cookie = new Cookie("email", email); 	 // 쿠키 생성
		
		// email 저장하기 눌렀다면..
		if(isChecked(check)) {
			response.addCookie(cookie);
		}
		
		// email 저장하기를 해제했다면..
		if(!(isChecked(check))) {
			cookie.setMaxAge(0);
			response.addCookie(cookie);
		}
	}
	
	
	// 정보가 틀리거나, 탈퇴한 회원은 안 돼요!
	public boolean isMemberStatus(MemberVO mVO, RedirectAttributes rttr, HttpSession session) { 
		
		// 로그인에 실패하면 메인 페이지로
		if(login(mVO)==null) {
			rttr.addFlashAttribute("msg", "이메일 또는 패스워드를 확인해주세요.");
			return true;
			}
	
			// 탈퇴한 회원은 접속 못함
			if(deleteNoAccess(mVO.getEmail())) {
				rttr.addFlashAttribute("msg", "이미 탈퇴한 회원입니다.");
				return true;
			}
				
		return false;
	}

	
	@Override
	public int getMemNo(String email) { // 로그인하면 success창에 내 회원번호 띄어주기
		return mapper.getMemNo(email).getMemNo();
	}

	@Override
	public boolean isChecked(String check) { // 아이디 기억하기 여부
		return check != null ? true : false; 
	}

	@Override
	public void modifyPwd(String pwd, String email) { // 비밀번호 수정
		mapper.modifyPwd(pwd, email);
	}

	@Override
	public MemberVO getMember(String email) { // 내 정보 조회
		return mapper.getMember(email);
	}
	
	public boolean isApiLoginCheck(String email, HttpSession session) { // api로그인일경우 apiAccountInfo 페이지로 이동

		if(mapper.hasApiMemberCnt(email) > 0) {
			return true;
		}
		return false;
	}
	
	
	@Override
	public int hasEmail(String email) { // email 체크
		return mapper.hasEmail(email);
	}

	@Override
	public void modifyNickname(String nickname, String email) { // 닉네임 변경
		mapper.modifyNickname(nickname, email);
	}

	@Override
	public int hasNickname(String nickname) { // 닉네임 중복체크
		return mapper.hasNickname(nickname);
	}
	
	@Override
	public boolean isNicknameTouch(String nickname, String email, Model model) { // 닉네임 수정했어?
		
		// nickNameResult : 닉네임 있으면 1, 없으면 0
		int nicknameResult = hasNickname(nickname);
		
		// 닉네임을 수정했는데 중복이라면..
		if(isMyNicknamePass(nickname, email) && nicknameResult > 0) {
			model.addAttribute("msg", "닉네임이 다른 회원과 중복됩니다.");
			model.addAttribute("member", getMember(email));
			return true;
		}
		// 정보가 정상적으로 저장되었습니다.
		modifyNickname(nickname, email);
		model.addAttribute("msg", "정보가 저장되었습니다.");
		model.addAttribute("member", getMember(email));
		return false;
	}

	@Override
	public boolean isMemberValid(String pwd, String email, RedirectAttributes rttr, HttpSession session) { // 삭제 전 유효성 체크
		
		// 비밀번호가 다르면 다시 입력하세요
		if(mapper.memberValidCnt(pwd, email) == 0) {
			rttr.addFlashAttribute("msg", "비밀번호가 달라요!");
			return true;
		}
		
		// 비밀번호가 일치하면
		// 회원 상태를 "탈퇴"로 변경한다.
		deleteMember(pwd, email);
		// 세션을 제거한다.
		session.invalidate();
					
		// 정상적으로 탈퇴 되었다는 메세지를 보낸다.
		rttr.addFlashAttribute("msg", "travel을 이용해주셔서 감사했습니다.");
		return false;
	}
	
	@Override
	public void deleteMember(String pwd, String email) { // 회원탈퇴
		mapper.deleteMember(pwd, email);
	}
	
	@Override
	public void deleteApiMember(String email, RedirectAttributes rttr, HttpSession session) { // api 회원탈퇴
		mapper.deleteApiMember(email);
		rttr.addFlashAttribute("msg", "travel을 이용해주셔서 감사했습니다.");
		session.invalidate();
	}
	
	public boolean isNotTravelMember(String email, RedirectAttributes rttr) { // 트래블 회원인지 확인

		// 트래블 회원이 아니면 안됩니다!
		  if(getMember(email) == null || deleteNoAccess(email)) {
	        	rttr.addFlashAttribute("msg", "travel회원이 아닙니다. 회원가입해주세요");
	        	return true;
	        }
		  return false;
	}
	
	@Override
	public String findPwd(String email) { // 비밀번호 찾기
		return mapper.findPwd(email);
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
	public void setNewPwd(String email) { // 임시 비밀번호 생성

		String uuid = createUUID();

		// 현재 이메일을 임시 비밀번호로 변경한다.
		mapper.modifyPwd(uuid, email);
	}
	
	@Override
	public Email writerEmail(String email, Email emailObj) { // 임시 비밀번호 메일보내기
		
		setNewPwd(email); // 비번 찾기 창에서 입력한 이메일에 새로운 비밀번호가 저장된다.
        String newPwd= findPwd(email); // 새로운 비밀번호를 변수 pw에 저장한다.
            
        emailObj.setReceiver(email); // 받는 사람
        emailObj.setSubject(email+"님 travle에서 보내드리는 임시 비밀번호 메일입니다."); // 제목
        emailObj.setContent("안녕하세요, travel입니다! \n" + email + "님의 임시 비밀번호는 "+newPwd+" 입니다\n"
        		+ "로그인하시고 새로운 비밀번호로 변경해주세요!"); // 내용
		
        return emailObj;
	}
	
	
	@Override
	public Email certEmail(String email, String certNum, Email emailObj) { // 소셜 계정 회원탈퇴 인증메일 보내기
		
        emailObj.setReceiver(email); // 받는 사람
        emailObj.setSubject(email+"님 travle에서 보내드리는 회원탈퇴 인증번호입니다."); // 제목
        emailObj.setContent("안녕하세요, travel입니다! \n" + email + "님의 travel 회원탈퇴 인증번호는 "+certNum+" 입니다\n"); // 내용
		
        return emailObj;
	}
	
	@Override
	public boolean isMyNicknamePass(String nickname, String email) { // 정보 저장하기를 눌렀을 때, 이미 내 닉네임이면 중복된다는 멘트를 하지 않는다
		 String nameResult = mapper.getMyNickname(email);
		 return (!nickname.equals(nameResult)) ? true : false; // 저장하기를 눌렀을 때, 닉네임을 건드렸다면.. true
	}
	
	@Override
	public boolean deleteNoAccess(String email) { // 탈퇴한 회원은 접속 못함
		return mapper.deleteNoAccess(email) == 1 ? true : false;
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
		
		if(deleteNoAccess(email)) {
			rttr.addFlashAttribute("msg", "이미 탈퇴한 회원입니다.");
			return true;
		}
		
		return false;
	}

}

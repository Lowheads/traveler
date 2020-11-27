package org.travelmaker.service;

import java.util.Date;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.travelmaker.domain.MemberVO;
import org.travelmaker.mapper.MemberMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import oracle.net.aso.m;

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
	
	public boolean isDuplicateCheck(MemberVO mVO) { // 회원가입(이메일, 닉네임 중복체크)
		if(emailCheck(mVO.getEmail()) > 0) { // 아이디가 중복이라면..
			return true;
		}
		
		if(nicknameDuplCheck(mVO.getNickname()) > 0) { // 닉네임이 중복이라면..
			return true;
		}
		return false;
	}
	

	@Override
	public MemberVO login(MemberVO mVO) { // 로그인 기능
		return mapper.login(mVO);
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
	public boolean isLoginFail(MemberVO mVO, RedirectAttributes rttr, HttpSession session) { 
		
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
				
			login(mVO); // 로그인 시키자..!
			presentDate(mVO.getEmail()); // 최종 로그인은 오늘이겠지..
			session.setAttribute("email", mVO.getEmail()); // 세션에 이메일 담자
			session.setAttribute("memNo", getMemNo(mVO.getEmail())); // 회원 번호 
			return false;
	}

	
	@Override
	public int getMemNo(String email) { // 로그인하면 success창에 내 회원번호 띄어주기
		return mapper.getMemNo(email).getMemNo();
	}

	@Override
	public void presentDate(String email) { // 최종 로그인 날짜 수정
		mapper.presentDate(email);
	}

	@Override
	public boolean isChecked(String check) { // 아이디 기억하기 여부
		return check != null ? true : false; 
	}

	@Override
	public void pwdModify(String pwd, String email) { // 비밀번호 수정
				mapper.pwdModify(pwd, email);
	}

	@Override
	public MemberVO viewMember(String email) { // 내 정보 조회
		return mapper.viewMember(email);
	}

	@Override
	public int emailCheck(String email) { // email 체크
		return mapper.emailCheck(email);
	}

	@Override
	public void nicknameModify(String nickname, String email) { // 닉네임 변경
		mapper.nicknameModify(nickname, email);
	}

	@Override
	public int nicknameDuplCheck(String nickname) { // 닉네임 중복체크
		return mapper.nicknameDuplCheck(nickname);
	}
	
	@Override
	public boolean nicknameChange(String nickname, String email, Model model) { // 닉네임 수정했어?
		
		// nickNameResult : 닉네임 있으면 1, 없으면 0
		int nicknameResult = nicknameDuplCheck(nickname); 
		
		// 닉네임을 수정했는데 중복이라면..
		if(isMyNicknamePass(nickname, email) && nicknameResult > 0) {
			model.addAttribute("msg", "닉네임이 다른 회원과 중복됩니다.");
			model.addAttribute("member", viewMember(email));
			return true;
		}
		// 정보가 정상적으로 저장되었습니다.
		nicknameModify(nickname, email);
		model.addAttribute("msg", "정보가 저장되었습니다.");
		model.addAttribute("member", viewMember(email));
		return false;
	}

	@Override
	public boolean deleteValid(String pwd, String email, RedirectAttributes rttr, HttpSession session) { // 삭제 전 유효성 체크
		
		if(mapper.deleteValid(pwd, email) == 0) {
			rttr.addFlashAttribute("msg", "비밀번호가 달라요!");
			return true;
		}
		
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
	public String findPwd(Map<String, Object> paramMap) { // 비밀번호 찾기
		return mapper.findPwd(paramMap);
	}

	@Override
	public void newPwd(String email) { // 임시 비밀번호 생성

		String uuid = UUID.randomUUID().toString().replaceAll("-", ""); // -를 제거해 주었다.

		// 새로운 비밀번호를 생성한다.
		for (int i = 0; i < 1; i++) {
			uuid = uuid.substring(0, 10); // uuid를 앞에서부터 10자리 잘라줌.
			System.out.println(i + ") " + uuid);
		}

		// 현재 이메일을 임시 비밀번호로 변경한다.
		mapper.pwdModify(uuid, email);
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


}

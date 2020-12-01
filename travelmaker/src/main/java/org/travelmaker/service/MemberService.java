package org.travelmaker.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.ui.Model;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.travelmaker.domain.Email;
import org.travelmaker.domain.MemberVO;

public interface MemberService {

	public void join(MemberVO mVO); // 회원가입
	
	public boolean isDuplicateCheck(MemberVO mVO, RedirectAttributes rttr); // 회원가입(이메일, 닉네임 중복체크)

	public MemberVO login(MemberVO mVO); // 로그인 정보
	
	public void RememberEmail(String email, HttpServletRequest request, HttpServletResponse response); // email저장
	
	public boolean isMemberStatus(MemberVO mVO, RedirectAttributes rttr, HttpSession session); // 정보가 틀리거나, 탈퇴한 회원은 안 돼요!
	
	public int getMemNo(String email); // 멤버번호 가져오기
	
	public boolean isChecked(String check); // id기억하기의 체크 여부 확인 메서드

	public void modifyPwd(String pwd, String email); // 비밀번호 수정(id받아서 변경)

	public MemberVO getMember(String email); // 정보 조회
	
	public boolean isApiLoginCheck(String email, HttpSession session); // api로그인일경우 apiAccountInfo 페이지로 이동
	
	public int hasEmail(String email); // 이메일 중복체크
	
	public void modifyNickname(String nickname, String email); // email 확인 후, 닉네임 변경
	
	public int hasNickname(String nickname); // 닉네임 중복체크
	
	public boolean isNicknameTouch(String nickname, String email, Model model); // 닉네임 수정 여부 확인
	
	public boolean isMemberValid(String pwd, String email, RedirectAttributes rttr, HttpSession session); // 탈퇴전 유효성 체크
	
	public void deleteMember(String pwd, String email); // 회원 탈퇴
	
	public boolean isTravelMember(String email, RedirectAttributes rttr); // 트래블 회원인지 확인
	
	public String findPwd(String email); // 비밀번호찾기
	
	public void setNewPwd(String email); // 비밀번호 찾기(임시 비밀번호 생성)
	
	public Email writerEmail(String email, Email emailObj); // 메일보내기
	
	public void lastLoginSetToday(String email); // 최종로그인
	
	public boolean isMyNicknamePass(String nickname, String email); // 정보 저장하기를 눌렀을 때, 이미 내 닉네임이면 중복된다는 멘트를 하지 않는다
	
	public boolean deleteNoAccess(String email); // 삭제한 회원은 접근 못함
	
	public boolean isNaverApiJoinCheck(JSONObject responseObj, Model model); // api 로그인할 경우 회원가입 되어 있는지 확인
	
}

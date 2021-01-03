package org.travelmaker.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.ui.Model;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.travelmaker.domain.Email;
import org.travelmaker.domain.MemberVO;

import com.fasterxml.jackson.databind.JsonNode;

public interface MemberService {

   public void join(MemberVO mVO); // 회원가입
   
   public boolean isDuplicateCheck(MemberVO mVO, RedirectAttributes rttr); // 회원가입(이메일, 닉네임 중복체크)

   public boolean isAdminLogin(MemberVO mVO, HttpSession session); // 로그인 하자
   
   public void rememberEmail(String email, HttpServletRequest request, HttpServletResponse response); // email저장
   
   public boolean isValidMember(MemberVO mVO, RedirectAttributes rttr); // 정보가 틀리거나, 탈퇴한 회원은 안 돼요!
   
   public void setLoginDateToToday(String email); // 최종로그인
   
   public int getMemNo(String email); // 멤버번호 가져오기
   
   public void modifyPwd(String pwd, String email); // 비밀번호 수정

   public MemberVO getMember(String email); // 정보 조회
   
	// 정보 변경창(개발자도구 값 변경 등 유효성 체크)
   public boolean isValidInputCheck(String email, String inputPwd, String newPwd, HttpSession session, RedirectAttributes rttr);
   
   public boolean isApiLoginCheck(String email); // 소셜 로그인일경우 apiMemberInfo 페이지로 이동
   
   public int hasEmail(String email); // 이메일 중복체크
   
   public int hasNickname(String nickname); // 닉네임 중복체크
   
   public boolean isModifyNickname(String nickname, String email, RedirectAttributes rttr); // 닉네임 수정 여부 확인 // 닉네임 수정 여부 확인
   
   public boolean isDoubleCheckOnesPwd(String pwd, String email, RedirectAttributes rttr, HttpSession session); // 탈퇴전 유효성 체크
   
   public void deleteApiMember(String email, RedirectAttributes rttr, HttpSession session); // 소셜 회원 탈퇴
   
   public Email writingEmail(String email, Email emailObj); // 메일보내기
   
   public Email writingCertEmail(String email, String certNum, Email emailObj); // 소셜 계정 회원탈퇴 인증메일 보내기
   
   public boolean isNaverApiJoinCheck(JSONObject responseObj, Model model); // 네이버 api 로그인할 경우 회원가입 되어 있는지 확인

   public boolean isKakaoApiJoinCheck(JsonNode userProfile, Model model); // 카카오 api 로그인할 경우 회원가입 되어 있는지 확인
   
   public boolean isDeleteAlready(String email, RedirectAttributes rttr); // 소셜계정 탈퇴여부 확인
   
   public boolean isEamilChack(String email, RedirectAttributes rttr); // 비밀번호 찾기(이메일 체크)
   
   public boolean updateTT(String yourType,int memNo);

}
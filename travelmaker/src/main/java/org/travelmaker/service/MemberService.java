package org.travelmaker.service;

import java.util.Map;

import org.travelmaker.domain.MemberVO;

public interface MemberService {

	public void join(MemberVO mVO); // 회원가입

	public MemberVO login(MemberVO mVO); // 로그인 정보
	
	public int getMemNo(String email); // 멤버번호 가져오기
	
	public boolean isChecked(String check); // id기억하기의 체크 여부 확인 메서드

	public void pwdModify(String pwd, String email); // 비밀번호 수정(id받아서 변경)

	public MemberVO viewMember(String email); // 정보 조회
	
	public int emailCheck(String email); // 이메일 중복체크
	
	public void nicknameModify(String nickname, String email); // 이메일 수정(id받아서 변경)
	
	public int nicknameDuplCheck(String nickname); // 닉네임 중복체크
	
	public boolean deleteValid(String pwd, String email); // 탈퇴전 유효성 체크
	
	public void deleteMember(String pwd, String email); // 회원 탈퇴
	
	public String findPwd(Map<String, Object> paramMap); // 비밀번호찾기
	
	public void newPwd(String email); // 비밀번호 찾기(임시 비밀번호 생성)
	
	public void presentDate(String email); // 최종로그인
	
	public boolean myNicknamePass(String nickname, String email); // 정보 저장하기를 눌렀을 때, 이미 내 닉네임이면 중복된다는 멘트를 하지 않는다
	
	public boolean deleteNoAccess(String email); // 삭제한 회원은 접근 못함
	
}

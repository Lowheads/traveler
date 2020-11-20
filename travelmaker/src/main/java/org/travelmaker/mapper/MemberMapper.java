package org.travelmaker.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import org.travelmaker.domain.MemberVO;

// MemberDAO 인터페이스와 같음
// mapper.xml의 id값을 부른다.
public interface MemberMapper {

	public int cnt(); // 회원목록 출력
	
	public void join(MemberVO mVO); // 회원가입
	
	public MemberVO login(MemberVO mVO); // 로그인
	
    public void pwdModify(@Param("pwd") String pwd, @Param("email") String email); // 비밀번호 수정
    
    public int emailCheck(String email); // 이메일 중복체크
	
	public MemberVO viewMember(String email); // 내 정보 조회
	
	public int nicknameDuplCheck(String nickname); // 닉네임 중복체크 (있으면 1, 없으면 0 반환)
	
	public void nNameModify(@Param("nickname") String nickname, @Param("email") String email); //닉네임 수정
	
	public void deleteMember(@Param("pwd") String pwd, @Param("email") String email); // 회원 탈퇴
	
	public String findPwd(Map<String, Object> paramMap); // 패스워드 찾기
	
	public void presentDate(String email); // 최종 로그인
	
	public String myNicknamePass(String email); //정보 저장하기를 눌렀을 때, 이미 내 닉네임이면 중복된다는 멘트를 하지 않는다. 
}

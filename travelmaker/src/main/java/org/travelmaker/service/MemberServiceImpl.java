package org.travelmaker.service;

import java.util.Date;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import org.travelmaker.domain.MemberVO;
import org.travelmaker.mapper.MemberMapper;

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

	@Override
	public MemberVO login(MemberVO mVO) { // 로그인 기능
		return mapper.login(mVO);
	}
	
	@Override
	public int getMemNo(String email) {
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
	public boolean deleteValid(String pwd, String email) { // 삭제 전 유효성 체크
		return mapper.deleteValid(pwd, email) == 1 ? true : false; 
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
	public boolean myNicknamePass(String nickname, String email) { // 정보 저장하기를 눌렀을 때, 이미 내 닉네임이면 중복된다는 멘트를 하지 않는다
		 String nameResult = mapper.myNicknamePass(email);
		 
		 if(nickname.equals(nameResult)){ // 저장하기를 눌렀을 때, 닉네임은 건들지 않았다면.. true
			 return true;
		 }
		 
		 return false;
	}
	
	@Override
	public boolean deleteNoAccess(String email) { // 탈퇴한 회원은 접속 못함
		return mapper.deleteNoAccess(email) == 1 ? true : false;
	}


}

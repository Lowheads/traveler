package org.travelmaker.domain;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
public class MemberVO {

	private int memNo; // 번호 (시퀀스 : seq_memNo)
	private String email; // 이메일
	private String nickname; // 닉네임
	private String pwd; // 비밀번호
	private String birth; // 생년월일 (19930419)
	private String gender; // 성별(남,여)
	private Date regDate; // 가입일
	private Date lastDate; // 최종로그인
	private String status; // 상태 (일반:MS001 / 탈퇴:MS002 / 휴면:MS003)
	private String memGrade; // 회원유형 (멤버:MG001 / 관리자:MG002 / SNS회원:MG003)
	private String travelType; // 여행타입
	private long point;    	   // 포인트
	
}

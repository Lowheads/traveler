package org.travelmaker.domain;

import java.util.Date;

import lombok.Data;

@Data
public class QnABoardVO {

	private int bno;			// 게시물 번호
	private String title;		// 제목
	private String content;		// 내용
	private String nickname;	// 작성자
	private Date regDate;		// 등록일
	private Date updateDate;	// 수정일
	private int viewCnt;		// 조회수
	private int memNo;			// 회원번호(fk)
	private String secret;		// 게시글 공개여부
	private int replyCnt; 		// 댓글 수
}

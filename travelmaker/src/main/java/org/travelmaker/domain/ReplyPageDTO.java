package org.travelmaker.domain;


import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;

@Data
@AllArgsConstructor
@Getter
public class ReplyPageDTO {

	private int replyCnt; 			// 게시물에 달린 댓글의 수
	private List<ReplyVO> list;		// 댓글 내용 들..
}

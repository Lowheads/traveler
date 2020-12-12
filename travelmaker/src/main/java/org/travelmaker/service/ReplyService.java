package org.travelmaker.service;

import java.util.List;

import org.travelmaker.domain.QnABoardCriteria;
import org.travelmaker.domain.ReplyPageDTO;
import org.travelmaker.domain.ReplyVO;

public interface ReplyService {

	public int register(ReplyVO vo); // 댓글 등록
	
	public ReplyVO get(int rno); 	 // 댓글 읽기
	
	public int modify(ReplyVO vo); 	 // 댓글 수정
	
	public int remove(int rno); 	 // 댓글 삭제

	public List<ReplyVO> getList(QnABoardCriteria cri, int bno); 
	
	// 댓글 페이징처리( (페이지번호, 출력개수), (페이지 번호))
	public ReplyPageDTO getListPage(QnABoardCriteria cri, int bno);
	
}

package org.travelmaker.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.travelmaker.domain.QnABoardCriteria;
import org.travelmaker.domain.ReplyVO;

public interface ReplyMapper {

	public int insert(ReplyVO vo); // 댓글 등록
	
	public ReplyVO read(int rno); // 댓글 읽기
	
	public int delete(int rno);	  // 댓글 삭제
	
	public int update(ReplyVO vo); // 댓글 수정
	
	// 댓글 목록
	public List<ReplyVO> getListWithPaging(@Param("cri") QnABoardCriteria cri, @Param("bno") int bno); 
	
	public int getCountByBno(int bno); // 게시물 댓글의 숫자 파악
	
	public int modifyReplyCount(int bno); // 댓글을 추가나 삭제할 경우 board테이블의 replyCnt도 변경해주자
	
	public int getBno(int rno); // 리플번호로 해당 게시물 번호 가져오기
	
}

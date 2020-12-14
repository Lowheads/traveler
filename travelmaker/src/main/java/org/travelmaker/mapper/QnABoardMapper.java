package org.travelmaker.mapper;

import java.util.List;

import org.travelmaker.domain.QnABoardCriteria;
import org.travelmaker.domain.QnABoardVO;

public interface QnABoardMapper {

	public List<QnABoardVO> getList(); // 게시물 목록
	
	public List<QnABoardVO> getListWithPaging(QnABoardCriteria cri);
	
	public void insertSelectKey(QnABoardVO qnaBoard); // 게시물 등록
	
	public int getMyMemNo(String email); // 내 회원번호 가져오기
	
	public String getMyNickname(String email); // 내 닉네임 가져오기
	
	public QnABoardVO read(int bno); // 게시물 조회
	
	public void viewCntUp(int bno); // 조회수 1 증가
	
	public int update(QnABoardVO qnaBoard); // 게시물 수정

	public int remove(int bno); // 게시물 삭제
	
	public int deleteBoardReply(int bno); // 게시물 삭제 전, 달린 댓글 제거
	
	public int getTotalCount(QnABoardCriteria cri); // 게시물 수로 페이지 목록구하기
	
	public String findAdmin(int memNo); // admin 여부 확인
	
}

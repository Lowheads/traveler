package org.travelmaker.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;
import org.travelmaker.domain.QnABoardCriteria;
import org.travelmaker.domain.QnABoardVO;

public interface QnABoardService {

	public List<QnABoardVO> getList(QnABoardCriteria cri); // 게시글 목록
	
	public void register(QnABoardVO qnaBoard, HttpServletRequest request); // 게시물 등록
	
	public int getMyMemNo(String email); // 내 회원번호 가져오기
	
	public String getMyNickname(String email); // 내 닉네임 가져오기
	
	public QnABoardVO get(int bno); // 게시물 조회
	
	public void viewCntUp(int bno); // 조회수 1 증가
	
	public boolean modify(QnABoardVO qnaBoard); // 게시물 수정
	
	public boolean remove(int bno); // 게시물 삭제
	
	public int getTotal(QnABoardCriteria cri); // 전체 페이지 목록
	
	// 게시물 조회시, 로그인 중인 계정의 닉네임과 권한을 모델이 담아 list.jsp로 보낸다.
	public void sendMyNicknameAndGrade(HttpSession session, Model model);
	
}

package org.travelmaker.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.travelmaker.domain.QnABoardCriteria;
import org.travelmaker.domain.QnABoardVO;
import org.travelmaker.mapper.QnABoardMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class QnABoardServiceImpl implements QnABoardService {

	private final QnABoardMapper  mapper;
	
	public QnABoardServiceImpl(QnABoardMapper qnaBoardMapper) {
		this.mapper = qnaBoardMapper;
	}
	
	
	@Override
	public List<QnABoardVO> getList(QnABoardCriteria cri) { // 게시글 목록
		return mapper.getListWithPaging(cri);
	}


	public String isSecret(String secret) { // 게시글 등록할 경우, 비밀 선택여부 판단
		// 비밀이면 Y, 아니면 N
		return secret != null ? "Y": "N";
	}

	@Override
	public void register(QnABoardVO qnaBoard, HttpServletRequest request) { // 게시물 등록
		// 비밀글이면 Y, 아니면 N
		String secret = isSecret(qnaBoard.getSecret());
		
		qnaBoard.setSecret(secret); // 비밀여부를 담자
		mapper.insertSelectKey(qnaBoard);
	}
	
	@Override
	public int getMyMemNo(String email) { // 내 회원번호 가져오기
		return mapper.getMyMemNo(email);
	}

	@Override
	public String getMyNickname(String email) { // 내 닉네임 가져오기
		return mapper.getMyNickname(email);
	}

	@Override
	public QnABoardVO get(int bno) { // 게시물 조회
		viewCntUp(bno); // 조회수 증가
		return mapper.read(bno);
	}
	

	@Override
	public void sendMyInfoByPage(QnABoardVO pageObj, Model model, HttpSession session) {
			
		// 선택한 페이지 조회 (게시글 목록 출력)
		model.addAttribute("board", pageObj);
		model.addAttribute("secret", pageObj.getSecret());
		 model.addAttribute("myGrade", getMyGrade((String)session.getAttribute("email")));
			
		// 로그인한 회원의 번호를 넘겨준다.(글의 수정여부를 판별하기 위함)
		model.addAttribute("loginMemNo", getMyMemNo((String)session.getAttribute("email")));
					
		// 로그인한 사용자의 닉네임을 넘겨준다.(댓글의 수정/삭제 여부 판단을 위함)
		session.setAttribute("myNickname", getMyNickname((String)session.getAttribute("email")));		
	}
	

	@Override
	public void viewCntUp(int bno) { // 조회수 1증가
		mapper.viewCntUp(bno);
	}

	@Override
	public boolean modify(QnABoardVO qnaBoard) { // 게시물 수정
		
		// 비밀여부 변경 됐을 수도 있으니까..
		qnaBoard.setSecret(isSecret(qnaBoard.getSecret()));
		
		return mapper.update(qnaBoard) == 1 ? true : false;
	}
	
	public int deleteBoardReply(int bno) {
		return mapper.deleteBoardReply(bno);
	}

	@Override 
	@Transactional // 트랜잰션
	public boolean remove(int bno) { // 게시물 삭제
		
		// 1. 댓글 먼저 삭제
		mapper.deleteBoardReply(bno);
		
		// 2. 게시글 삭제
		return mapper.remove(bno) == 1 ? true : false;
	}

	@Override
	public int getTotal(QnABoardCriteria cri) { // 전체 페이지 목록
		return mapper.getTotalCount(cri);
	}


	public String getMyGrade(String email) { // 로그인 중인 회원이 어드민인지 확인
		int memNo = mapper.getMyMemNo(email); // 로그인 중인 회원의 번호를 저장한다.
		
		String grade = mapper.findAdmin(memNo).equals("1") ? "MG002":"MG001";
		
		return grade;
	}


	// list를 조회할 때 로그인 중인 회원의 닉네임과 등급을 얻는다.
	@Override
	public void sendMyNicknameAndGrade(HttpSession session, Model model) { 
		
		String email = (String)session.getAttribute("email");
		
		// 로그인 중인 회원의 닉네임을 저장한다.
		model.addAttribute("loginNickname", getMyNickname(email));
				
		// 로그인 중인 회원의 등급을 저장한다.(관리자라면 admin)
		model.addAttribute("myGrade", getMyGrade(email)); // admin 또는 member
		
	}





}

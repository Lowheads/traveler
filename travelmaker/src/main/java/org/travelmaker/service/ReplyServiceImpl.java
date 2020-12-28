package org.travelmaker.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.travelmaker.domain.QnABoardCriteria;
import org.travelmaker.domain.ReplyPageDTO;
import org.travelmaker.domain.ReplyVO;
import org.travelmaker.mapper.ReplyMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class ReplyServiceImpl implements ReplyService {

	private final ReplyMapper mapper;
	
	public ReplyServiceImpl(ReplyMapper replyMapper) {
		this.mapper = replyMapper;
	}
	
	@Override
	@Transactional
	public int register(ReplyVO vo) { // 댓글 등록
		int replyRegisterResult = mapper.insert(vo);
		
		if(replyRegisterResult == 1) { // 새로운 댓글을 등록하면 board테이블의 replyCnt를 변경
			modifyReplyCount(vo.getBno());
		}
		return replyRegisterResult;
	}

	@Override
	public ReplyVO get(int rno) { // 댓글 가져오기
		return mapper.read(rno);
	}

	@Override
	public int modify(ReplyVO vo) { // 댓글 수정
		return mapper.update(vo);
	}

	@Override
	@Transactional
	public int remove(int rno) { // 댓글 삭제
		int boardBno = mapper.getBno(rno);
		int replyRemoveResult = mapper.delete(rno);
		
		if(replyRemoveResult == 1) {
			modifyReplyCount(boardBno);
		}
		return replyRemoveResult;
	}

	@Override
	public List<ReplyVO> getList(QnABoardCriteria cri, int bno) { // 댓글 목록
		return mapper.getListWithPaging(cri, bno);
	}

	@Override
	public ReplyPageDTO getListPage(QnABoardCriteria cri, int bno) { // 댓글 페이징처리
		// 매개변수((게시물 번호), ((페이지번호, 출력개수), (게시물 번호)))
		return new ReplyPageDTO(mapper.getCountByBno(bno), mapper.getListWithPaging(cri, bno));
	}
	
	public void modifyReplyCount(int bno) { // 게시물의 댓글을 등록하거나 삭제하면 board테이블의 replyCnt의 수를 변경한다.
		mapper.modifyReplyCount(bno);
	}
	
	public int getBno(int rno) { // 리플번호로 해당 게시물 번호 가져오기
		return mapper.getBno(rno);
	}

}

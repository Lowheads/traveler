package org.travelmaker.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.travelmaker.domain.BoardVO;
import org.travelmaker.domain.Criteria;
import org.travelmaker.mapper.BoardMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class BoardServiceImpl implements BoardService{
	
	private BoardMapper mapper;
	
	@Override
	public void register(BoardVO board) {
		
		log.info("register....."+board);
		mapper.insertSelectKey(board);
		
	}

	@Override
	public BoardVO get(int boardNo) {
		log.info("get......"+boardNo);
		return mapper.read(boardNo);
	}
	
	@Override
	public BoardVO getbySchNo(BoardVO board) {
		log.info("getbytitle......"+board);
		return mapper.readbySchNo(board);
	}

	@Override
	public boolean modify(BoardVO board) {
		log.info("modify........"+board);
		return mapper.update(board)==1;
	}

	@Override
	public boolean remove(int boardNo) {
		log.info("remove......."+boardNo);
		return mapper.delete(boardNo)==1;
	}

	@Override
	public List<BoardVO> getList() {
		log.info("getList.........");
		
		return mapper.getList();
	}

	@Override
	public List<BoardVO> getList(Criteria cri) {
		log.info("get List with criteria: "+ cri);
		return mapper.getListWithPaging(cri);
	}

	@Override
	public int getTotal(Criteria cri) {
		log.info("get total count");
		return mapper.getTotalCount(cri);
	}

	@Override
	public void updateHidden(BoardVO board) {
		
		//hidden 속성이 공개이면 비공개로 바꿔주기
		if(board.getHidden().equals("y")) {
			mapper.updateN(board);
			System.out.println("y->n");
		}
		//hidden 속성이 비공개이면 공개로 바꿔주기
		if(board.getHidden().equals("n")) {
			mapper.updateY(board);
			System.out.println("n->y");
		}
	}
	
	
}

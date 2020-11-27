package org.travelmaker.service;

import java.util.List;

import org.springframework.stereotype.Service;

import org.travelmaker.domain.BoardVO;
import org.travelmaker.domain.BoarddtVO;
import org.travelmaker.domain.Criteria;
import org.travelmaker.mapper.AdminBoardMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class AdminBoardServiceImpl implements AdminBoardService{

	private AdminBoardMapper mapper;
	
	
	@Override
	public List<BoardVO> getBoardList() {
		
		return mapper.getBoardList();
	}

	@Override
	public void removePost(int result) {
		
		mapper.removePost(result);
	}

	@Override
	public List<BoardVO> searchPost(Criteria cri) {

		return mapper.searchPost(cri);
	}

	@Override
	public List<BoarddtVO> getPostDetail(int boardNo) {

		return mapper.getPostDetail(boardNo);
	}

}

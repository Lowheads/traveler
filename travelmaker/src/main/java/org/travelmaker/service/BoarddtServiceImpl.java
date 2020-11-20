package org.travelmaker.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.travelmaker.domain.BoarddtVO;
import org.travelmaker.mapper.BoarddtMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class BoarddtServiceImpl implements BoarddtService {

	private BoarddtMapper mapper;
	
	@Override
	public List<BoarddtVO> getList(int boardNo) {
		log.info("getList.........");
		
		return mapper.getList(boardNo);
	}

	@Override
	public void register(BoarddtVO boarddt) {
		log.info("register boarddt......"+boarddt);
		mapper.register(boarddt);
		
	}

	@Override
	public boolean remove(int boardNo) {
		log.info("remove......."+boardNo);
		return mapper.delete(boardNo)==1;
	}
}

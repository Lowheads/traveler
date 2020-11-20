package org.travelmaker.service;

import java.util.List;

import org.travelmaker.domain.BoarddtVO;

public interface BoarddtService {

	public List<BoarddtVO> getList(int boardNo);
	
	public void register(BoarddtVO boarddt);
	
	public boolean remove(int boardNo);
}

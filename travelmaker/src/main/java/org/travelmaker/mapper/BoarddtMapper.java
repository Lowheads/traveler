package org.travelmaker.mapper;

import java.util.List;

import org.travelmaker.domain.BoarddtVO;

public interface BoarddtMapper {

	public List<BoarddtVO> getList(int boardNo);
	
	public void register(BoarddtVO boarddt);
	
	public int delete(int boardNo);
}

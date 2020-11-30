package org.travelmaker.service;

import java.util.List;


import org.travelmaker.domain.BoardVO;
import org.travelmaker.domain.Criteria;

public interface BoardService {

	public void register(BoardVO board);
	
	public BoardVO get(int boardNo);
	
	public BoardVO getbySchNo(BoardVO board);
	
	public boolean modify(BoardVO board);
	
	public boolean remove(int boardNo);
	
	public List<BoardVO> getList();
	
	public List<BoardVO> getList(Criteria cri);
	
	public int getTotal(Criteria cri);
	
	public void updateHidden(BoardVO board);
}

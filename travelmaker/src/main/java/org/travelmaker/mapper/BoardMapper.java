package org.travelmaker.mapper;

import java.util.List;

import org.travelmaker.domain.BoardVO;
import org.travelmaker.domain.Criteria;

public interface BoardMapper {

	//@Select("select * from board where board_no>0")
	public List<BoardVO> getList();
	
	public List<BoardVO> getListWithPaging(Criteria cri);
	
	public void insert(BoardVO board);
	
	public void insertSelectKey(BoardVO board);
	
	public BoardVO read(int boardNo);
	
	public int delete(int boardNo);
	
	public int update(BoardVO board);

	public BoardVO readbytitle(BoardVO board);
	
	public int getTotalCount(Criteria cri);
	
	public void upCnt(int boardNo);
	
	public void downCnt(int boardNo);
}

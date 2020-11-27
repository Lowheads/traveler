package org.travelmaker.mapper;

import java.util.List;

import org.travelmaker.domain.BoardVO;
import org.travelmaker.domain.BoarddtVO;
import org.travelmaker.domain.Criteria;

public interface AdminBoardMapper{
	
	public List<BoardVO> getBoardList();
	
	public void removePost(int result);

	public List<BoardVO> searchPost(Criteria cri);
	
	public List<BoarddtVO> getPostDetail(int boardNo);
}

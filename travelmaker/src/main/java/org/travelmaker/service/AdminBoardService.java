package org.travelmaker.service;

import java.util.List;

import org.travelmaker.domain.BoardVO;
import org.travelmaker.domain.Criteria;

public interface AdminBoardService {
	
	public List<BoardVO> getBoardList();
	
	public void removePost(int result);
	
	public List<BoardVO> searchBoardWriter(Criteria cri);
	

}

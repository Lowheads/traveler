package org.travelmaker.mapper;

import java.util.List;
import java.util.Map;

import org.travelmaker.domain.BoarddtVO;

public interface BoarddtMapper {

	public BoarddtVO read(int boardNo);

	public List<BoarddtVO> getList(int boardNo);
	
	public void register(BoarddtVO boarddt);
	
	public int delete(int boardNo);

	public void insertFile(Map<String, Object> map);

	public List<Map<String, Object>> selectFileList(int boardNo);

	public Map<String, Object> selectFileInfo(Map<String, Object> map);

	public void update(BoarddtVO boarddt);

	public void updateFile(Map<String, Object> tempMap);

}

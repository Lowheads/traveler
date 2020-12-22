package org.travelmaker.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.travelmaker.domain.BoarddtVO;
import org.travelmaker.domain.MpFileVO;

public interface BoarddtService {

	public BoarddtVO get(int boardNo);
	
	public List<BoarddtVO> getList(int boardNo);
	
	public void register(BoarddtVO boarddt);
	
	public boolean remove(int boardNo);
	
	//boarddt 등록
	public void write(BoarddtVO boarddt, MultipartHttpServletRequest mpRequest, List<String> newContent) throws Exception;
	
	
	//boarddt 연결된 file테이블 첨부파일 추가
	void insertFile(Map<String, Object> map) throws Exception;
	//위에꺼 고치는중
	void insertFileTest(Map<String, Object> map, String content) throws Exception;
	
	//첨부파일 조회
	public List<Map<String, Object>> selectFileList(int boardNo) throws Exception;
	//첨부파일 다운로드
	public Map<String, Object> selectFileInfo(Map<String, Object>map) throws Exception;
	
	//게시물 수정
	void update(BoarddtVO boarddt, String[] files, String[] fileNames, MultipartHttpServletRequest mpRequest,
			List<String> newContent) throws Exception;

	public void updateContent(List<Integer> fileNo, List<String> fileContent);
	
}

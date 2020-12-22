package org.travelmaker.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.travelmaker.utils.FileUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.travelmaker.domain.BoardVO;
import org.travelmaker.domain.BoarddtVO;
import org.travelmaker.domain.MpFileVO;
import org.travelmaker.mapper.BoarddtMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class BoarddtServiceImpl implements BoarddtService {

	private BoarddtMapper mapper;
	
	@Resource(name="fileUtils")
	private FileUtils fileUtils;
	
	@Override
	public BoarddtVO get(int boardNo) {
		log.info("get......"+boardNo);
		return mapper.read(boardNo);
	}
	
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

	//boarddt 등록 (첨부파일 등록 메소드 호출)
	@Override
	public void write(BoarddtVO boarddt, MultipartHttpServletRequest mpRequest, List<String> newContent) throws Exception {
		mapper.register(boarddt);
		
		List<Map<String,Object>> list = fileUtils.parseInsertFileInfo(boarddt, mpRequest);
		
		int size=list.size();
		for(int i=0;i<size;i++) {
			
			insertFileTest(list.get(i),newContent.get(i));
		}
	}	
	//첨부파일 등록
	@Override
	public void insertFileTest(Map<String, Object> map, String content) throws Exception {
		map.put("FILE_CONTENT",content);
		mapper.insertFile(map);		
	}
	
	@Override
	public void insertFile(Map<String, Object> map) throws Exception {
		mapper.insertFile(map);		
	}

	//첨부파일 조회
	@Override
	public List<Map<String,Object>> selectFileList(int boardNo) throws Exception{
		return mapper.selectFileList(boardNo);
	}

	//첨부파일 다운
	@Override
	public Map<String, Object> selectFileInfo(Map<String, Object> map) throws Exception {
		return mapper.selectFileInfo(map);
	}

	@Transactional
	@Override
	public void update(BoarddtVO boarddt, String[] files, String[] fileNames, MultipartHttpServletRequest mpRequest,
			List<String> newContent) throws Exception {
		mapper.update(boarddt);

		List<Map<String, Object>> list = fileUtils.parseUpdateFileInfo(boarddt, files, fileNames, mpRequest);
		Map<String, Object> tempMap = null;

		int size = list.size();

		for (int i = 0; i < size; i++) {
			tempMap = list.get(i);
			if (tempMap.get("IS_NEW").equals("Y")) {
				tempMap.put("FILE_CONTENT", newContent.get(i));
				mapper.insertFile(tempMap);
			} else {
				mapper.updateFile(tempMap);
			}
		}
	}
	
	@Transactional
	@Override
	public void updateContent(List<Integer> fileNo, List<String> fileContent) {
		for(int i=0;i<fileNo.size();i++) {
			mapper.updateContent(fileNo.get(i),fileContent.get(i));
		}
		
	}
}



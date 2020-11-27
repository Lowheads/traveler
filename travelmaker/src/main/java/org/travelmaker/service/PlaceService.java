package org.travelmaker.service;

import java.util.List;

import org.travelmaker.domain.Criteria;
import org.travelmaker.domain.PlaceDTO;
import org.travelmaker.domain.PlaceVO;


public interface PlaceService {

	//등록
	public void register(PlaceVO place);
	//한개장소만가져오기
	public PlaceVO get(long plcNo);
	//삭제(하트클릭할때)
	public boolean remove(long plcNo);
	//전체리스트
	public List<PlaceVO> getList();
	
	public boolean modify(PlaceVO place);
	
	//종운 getList
	public List<PlaceVO> getList(String title);
	public List<PlaceDTO> getListWithTheme(int regionNo, int themeNum);
	
	//순규 getList
	public List<PlaceVO> getList(Criteria cri);
	
	public void updateLikeCnt(PlaceVO vo);
	
	public int getTotal(Criteria cri);
	
}
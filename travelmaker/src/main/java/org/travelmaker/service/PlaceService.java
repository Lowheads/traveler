package org.travelmaker.service;

import java.util.List;

import org.travelmaker.domain.Criteria;
import org.travelmaker.domain.PlaceDTO;
import org.travelmaker.domain.PlaceVO;
import org.travelmaker.domain.ScheduleDtVO;


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
	
	public List<PlaceVO> getLikeList(Criteria cri);
	public List<PlaceVO> getNewestList(Criteria cri);
	public List<PlaceVO> getOldestList(Criteria cri);
	
	public int getTotal(Criteria cri);
	
//	public List<List<Schdt_PlaceVO>> getInitSchedule(Schdt_PlaceVO[] schdt_placeVOs);
	
	public ScheduleDtVO[][] getInitSchWithDistAndDu(ScheduleDtVO[][] schdtVOs);
}

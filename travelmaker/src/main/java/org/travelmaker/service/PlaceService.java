package org.travelmaker.service;

import java.util.List;

import org.travelmaker.domain.Criteria;
import org.travelmaker.domain.PlaceDTO;
import org.travelmaker.domain.PlaceVO;
import org.travelmaker.domain.ScheduleDtVO;


public interface PlaceService {

	//등록
	public void register(PlaceVO place);
	//한개장소만가져오기였는데 성능이 떨어져서 in 을 구현해서 List로 바뀜
	public List<PlaceVO> get(String[] plcNoArr);
	//삭제(하트클릭할때)
	public boolean removePlace(long plcNo);

	public boolean modify(PlaceVO place);
	
	//종운 getList
	public List<PlaceVO> getList(String title,int regionNo,Criteria cri);
	public List<PlaceDTO> getListWithTheme(int regionNo, String themeCode);
	
	//순규 getList
	public List<PlaceVO> getListWithPaging(Criteria cri);
	
	public void updateLikeCnt(PlaceVO vo);
	
	public int getTotal(Criteria cri);
	
	public int getSearchResultTotalCnt(String title,int regionNo);
	
	public ScheduleDtVO[][] getInitSchWithDistAndDu(ScheduleDtVO[][] schdtVOs);
	
	public List<PlaceVO> getPlaceByWeather(int regionNo);
}

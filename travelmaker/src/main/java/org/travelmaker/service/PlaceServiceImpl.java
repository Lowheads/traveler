package org.travelmaker.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.travelmaker.domain.Criteria;
import org.travelmaker.domain.PlaceDTO;
import org.travelmaker.domain.PlacePageDTO;
import org.travelmaker.domain.PlaceVO;
import org.travelmaker.mapper.PlaceMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class PlaceServiceImpl implements PlaceService {

	@Setter(onMethod_ = @Autowired)
	private PlaceMapper mapper;
	
	@Override
	public void register(PlaceVO place) {
		mapper.insert(place);
	}

	@Override
	public PlaceVO get(long plcNo) {
		
		return mapper.read(plcNo);
		
	}

	@Override
	public boolean remove(long plcNo) {
		
		return mapper.delete(plcNo)==1;
	}

	@Override
	public List<PlaceVO> getList() {
		
		return mapper.getList();
	}

	@Override
	public boolean modify(PlaceVO place) {

		return mapper.update(place) ==1;
	}

	@Override
	public List<PlaceVO> getList(Criteria cri,String selected) {

		if(selected!=null) {
			if(selected.equals("like")){
				return mapper.sortLike(cri);
			}
			if(selected.equals("new")){
				return mapper.sortNewest(cri);
			}
			if(selected.equals("old")){
				return mapper.sortOldest(cri);
			}
		}
		return mapper.getListWithPaging(cri);
	}

	@Override
	public void updateLikeCnt(PlaceVO vo) {
		mapper.update(vo);
	}

	@Override
	public int getTotal(Criteria cri) {
		// TODO Auto-generated method stub
		return mapper.getTotalCount(cri);
	}
	
	//종운 메서드
	@Override
	public List<PlaceVO> getList(String title) {
		log.info("get place List of a map" + title);
		return mapper.getListWithTitle(title);
	}

	@Override
	public List<PlaceDTO> getListWithTheme(int regionNo, int themeNum) {
		log.info("get place List with Theme" + regionNo + " " + themeNum);
		return mapper.getListWithTheme(regionNo, themeNum);
	}
	
	

}

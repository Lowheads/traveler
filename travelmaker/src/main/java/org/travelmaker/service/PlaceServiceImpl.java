package org.travelmaker.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.travelmaker.domain.Criteria;
import org.travelmaker.domain.PlaceDTO;
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

		log.info("register"+place);
		mapper.insert(place);
	}

	@Override
	public PlaceVO get(long plcNo) {

		log.info("get...."+plcNo);
		
		return mapper.read(plcNo);
		
	}

	@Override
	public boolean remove(long plcNo) {
		
		log.info("remove...."+plcNo);
		
		return mapper.delete(plcNo)==1;
	}

	@Override
	public List<PlaceVO> getList() {
		
		log.info("getList.....");
		
		return mapper.getList();
	}

	@Override
	public boolean modify(PlaceVO place) {

		log.info("modify..."+place);
		
		return mapper.update(place) ==1;
	}

	@Override
	public List<PlaceVO> getList(Criteria cri) {


		log.info("get List with criteria: "+cri);
		
		return mapper.getListWithPaging(cri);
	}

	@Override
	public void updateLikeCnt(PlaceVO vo) {
		log.info("update,,,");
		mapper.update(vo);
	}

	@Override
	public List<PlaceVO> getLikeList(Criteria cri) {
		return mapper.sortLike(cri);
	}

	@Override
	public List<PlaceVO> getNewestList(Criteria cri) {
		return mapper.sortNewest(cri);
	}

	@Override
	public List<PlaceVO> getOldestList(Criteria cri) {
		return mapper.sortOldest(cri);
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

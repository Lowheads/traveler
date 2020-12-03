package org.travelmaker.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.travelmaker.domain.PlaceDTO;
import org.travelmaker.domain.PlaceVO;
import org.travelmaker.domain.ThemeVO;
import org.travelmaker.mapper.ThemeMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
@Log4j
@Service
@AllArgsConstructor
public class ThemeServiceImpl implements ThemeService {
	
	private ThemeMapper mapper;

	@Override
	public List<ThemeVO> getThemeList() {

		return mapper.getThemeList();
		 
	}

	@Override
	public List<PlaceVO> getThemeInfo(int themeNo) {
	
		return mapper.getThemeInfo(themeNo);
	}
	
	@Transactional
	@Override
	public int updateTheme(String[] removedPlaces,String[] addedPlaces, int themeNo) {
		
		int removeResult=0;
		
		if(removedPlaces.length!=0) {
			removeResult = mapper.deleteTheme(removedPlaces, themeNo);
		}
		
		if(addedPlaces.length!=0) {
			int insertResult = mapper.insertTheme(addedPlaces, themeNo);
		}

		return removeResult;
	}

	@Override
	public List<PlaceVO> getPlaceList(String keyword) {
		
		return mapper.getPlaceList(keyword);
	}
	
	


}

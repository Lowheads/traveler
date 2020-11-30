package org.travelmaker.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.travelmaker.domain.PlaceDTO;
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
	public List<PlaceDTO> getThemeInfo(int themeNo) {
	
		return mapper.getThemeInfo(themeNo);
	}

	

}

package org.travelmaker.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import org.travelmaker.mapper.ThemeMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
@Log4j
@Service
@AllArgsConstructor
public class ThemeServiceImpl implements ThemeService {
	
	private ThemeMapper mapper;

	@Override
	public List<Map<String, String>> getThemeList() {

		return mapper.getThemeList();
		 
	}

	@Override
	public List<String> getThemeInfo(String region_id, String theme_code) {
	
		return mapper.getThemeInfo(region_id,theme_code);
	}

	

}

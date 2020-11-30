package org.travelmaker.service;

import java.util.List;
import java.util.Map;

import org.travelmaker.domain.PlaceDTO;
import org.travelmaker.domain.ThemeVO;

public interface ThemeService {
	
public List<ThemeVO> getThemeList();
	
	public List<PlaceDTO> getThemeInfo(int themeNo);
	

}

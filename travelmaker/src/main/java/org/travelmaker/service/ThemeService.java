package org.travelmaker.service;

import java.util.List;

import org.travelmaker.domain.PlaceDTO;
import org.travelmaker.domain.PlaceVO;
import org.travelmaker.domain.ThemeVO;

public interface ThemeService {
	
public List<ThemeVO> getThemeList();
	
	public List<PlaceVO> getThemeInfo(int themeNo);
	
	public int updateTheme(String[] removedPlaces, String[] addedPlaces, int themeNo);
	
	public List<PlaceVO> getPlaceList(String keyword);
	

}

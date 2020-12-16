package org.travelmaker.service;

import java.util.List;
import java.util.Map;

import org.travelmaker.domain.Criteria;
import org.travelmaker.domain.PlaceVO;
import org.travelmaker.domain.ThemeAttachVO;
import org.travelmaker.domain.ThemeVO;

public interface ThemeService {
	
	public List<String> getThemeList();
	
	public List<PlaceVO> getThemeInfo(int themeNo);
	
	public Map<String, Integer> updateTheme(String[] removedPlaces, String[] addedPlaces, int themeNo, ThemeAttachVO attachment);
	
	public List<PlaceVO> getPlaceList(String keyword, int pageNum);
	
	public ThemeAttachVO getAttachment(int themeNo);
	
	public int getTotal(String keyword);

	

}

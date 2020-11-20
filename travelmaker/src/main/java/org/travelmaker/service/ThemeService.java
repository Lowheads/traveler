package org.travelmaker.service;

import java.util.List;
import java.util.Map;

public interface ThemeService {
	
public List<Map<String, String>> getThemeList();
	
	public List<String> getThemeInfo(String region_id, String theme_code);
	

}

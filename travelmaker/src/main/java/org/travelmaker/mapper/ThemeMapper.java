package org.travelmaker.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.travelmaker.domain.PlaceVO;
import org.travelmaker.domain.ThemeVO;

public interface ThemeMapper {

	public List<ThemeVO> getThemeList();

	public List<PlaceVO> getThemeInfo(@Param(value = "themeNo") int themeNo);
	
	public int deleteTheme(@Param(value = "list") String[] places, @Param(value = "themeNo") int themeNo);
	
	public int insertTheme(@Param(value = "list") String[] places, @Param(value = "themeNo") int themeNo);
	
	public List<PlaceVO> getPlaceList(String keyword);

}

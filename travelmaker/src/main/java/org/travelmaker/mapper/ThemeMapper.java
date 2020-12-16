package org.travelmaker.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.travelmaker.domain.PlaceVO;

public interface ThemeMapper {

	public List<String> getThemeList();

	public List<PlaceVO> getThemeInfo(@Param(value = "themeNo") int themeNo);
	
	public int deleteTheme(@Param(value = "list") String[] places, @Param(value = "themeNo") int themeNo);
	
	public int insertTheme(@Param(value = "list") String[] places, @Param(value = "themeNo") int themeNo);
	
	public List<PlaceVO> getPlaceList(@Param("keyword")String keyword, @Param("pageNum")int pageNum);

	public int getTotalCount(String keyword);
	
	public int updateTheme(int themeNo);
	
}

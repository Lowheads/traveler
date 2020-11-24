package org.travelmaker.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

public interface ThemeMapper {

	public List<Map<String,String>> getThemeList();

	public List<Map<String,String>> getThemeInfo(@Param(value = "regionNo") String regionNo,
			@Param(value = "themeCode") String themeCode);

}

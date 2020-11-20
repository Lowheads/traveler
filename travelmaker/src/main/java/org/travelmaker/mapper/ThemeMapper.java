package org.travelmaker.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

public interface ThemeMapper {

	public List<Map<String,String>> getThemeList();

	public List<String> getThemeInfo(@Param(value = "region_id") String region_id,
			@Param(value = "theme_code") String theme_code);

}

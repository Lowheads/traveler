package org.travelmaker.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.travelmaker.domain.PlaceDTO;
import org.travelmaker.domain.ThemeVO;

public interface ThemeMapper {

	public List<ThemeVO> getThemeList();

	public List<PlaceDTO> getThemeInfo(@Param(value = "themeNo") int themeNo);

}

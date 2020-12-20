package org.travelmaker.mapper;

import java.util.List;

import org.travelmaker.domain.BoardVO;
import org.travelmaker.domain.StatisticVO;

public interface MainMapper {
	
	public List<BoardVO> getPopularPostsByView();
	
	public List<BoardVO> getPopularPostsByPick();
	
	public List<StatisticVO> getDaily();
	
	public List<StatisticVO> getMonthly();
}

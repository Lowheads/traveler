package org.travelmaker.mapper;

import java.util.List;

import org.travelmaker.domain.StatisticVO;

public interface MainMapper {

	public List<StatisticVO> getDailyStatistic();
	
	public List<StatisticVO> getMonthlyStatistic();
}

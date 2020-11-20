package org.travelmaker.service;

import java.util.List;

import org.travelmaker.domain.StatisticVO;

public interface MainService {
	
	public List<StatisticVO> getDailyStatistic();
	
	public List<StatisticVO> getMonthlyStatistic();

}

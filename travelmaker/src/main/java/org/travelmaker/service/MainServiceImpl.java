package org.travelmaker.service;

import java.util.List;

import org.springframework.stereotype.Service;

import org.travelmaker.domain.StatisticVO;
import org.travelmaker.mapper.MainMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
@Log4j
@Service
@AllArgsConstructor
public class MainServiceImpl implements MainService{
	
	private MainMapper mapper;

	@Override
	public List<StatisticVO> getDailyStatistic() {
		
		return mapper.getDailyStatistic();
	}

	@Override
	public List<StatisticVO> getMonthlyStatistic() {

		return mapper.getMonthlyStatistic();
	}
	

}

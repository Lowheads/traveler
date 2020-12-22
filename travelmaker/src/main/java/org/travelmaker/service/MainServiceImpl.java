package org.travelmaker.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.travelmaker.domain.BoardVO;
import org.travelmaker.domain.QnABoardVO;
import org.travelmaker.domain.StatisticVO;
import org.travelmaker.mapper.MainMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
@Log4j
@Service
@AllArgsConstructor
public class MainServiceImpl implements MainService{
	
	private MainMapper mapper;

	
	public List<StatisticVO> getChart(String type){
		
		if(type.equals("daily")) {
			return mapper.getDaily();	
		}
		
		return mapper.getMonthly();
		
	}

	@Override
	public List<BoardVO> getPostByPopularity(String type) {
		
		if(type.equals("view")) {
			
			return mapper.getPopularPostsByView();
		}
		
		return mapper.getPopularPostsByPick();
	}

	@Override
	public Map<Integer, List<QnABoardVO>> getQnaInfo() {
		
		
		Map<Integer, List<QnABoardVO>> result = new HashMap<Integer, List<QnABoardVO>>();
		
		result.put(mapper.cntQnaPost(), mapper.getQnaPost());
		
		return result;
	}

}

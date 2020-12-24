package org.travelmaker.service;

import java.util.List;
import java.util.Map;

import org.travelmaker.domain.BoardVO;
import org.travelmaker.domain.QnABoardVO;
import org.travelmaker.domain.StatisticVO;

public interface MainService {

	public List<StatisticVO> getChart(String type);
	
	public List<BoardVO> getPostByPopularity(String type);
	
	public Map<Integer, List<QnABoardVO>> getQnaInfo();

}

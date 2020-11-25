package org.travelmaker.service;

import java.util.List;

import org.travelmaker.domain.DaybudVO;

public interface DaybudService {
	
	// get.jsp - 셀렉트 박스 : 날짜
	public List<DaybudVO> box();
	
	// get.jsp - 일정 지출 내역 카운트 -> 그래프
	public List<DaybudVO> get(Long no);

	// Test - 그래프
	public List<DaybudVO> getList();

}

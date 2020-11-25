package org.travelmaker.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.travelmaker.domain.DaybudVO;
import org.travelmaker.mapper.DaybudMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class DaybudServiceImpl implements DaybudService {
	
	private DaybudMapper mapper;

	// get.jsp - 셀렉트 박스 : 날짜
	@Override
	public List<DaybudVO> box() {
		return mapper.box();
	}
	
	// get.jsp - 날짜별 지출 내역 카운트 : 그래프
	@Override
	public List<DaybudVO> get(Long schno) {
		log.info("get......" + schno);
		return mapper.read(schno);
	}
	
	// Test - 그래프
	@Override // 
	public List<DaybudVO> getList() {
		log.info("getList......");
		return mapper.getList();
	}
	
}

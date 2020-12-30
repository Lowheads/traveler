package org.travelmaker.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.travelmaker.domain.BudgetVO;
import org.travelmaker.domain.DaybudVO;
import org.travelmaker.mapper.BudgetMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class BudgetServiceImpl implements BudgetService { // mapper(+xml) 에서 가져다가 사용 
	
	private BudgetMapper mapper;

	// list.jsp - 모든 일정, 지출 내역
	@Override
	public List<BudgetVO> getBudgetByUser() {
		log.info("getList......");
		return mapper.getBudgetByUser();
	}
	
}

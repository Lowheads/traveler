package org.travelmaker.service;

import java.util.List;

import org.travelmaker.domain.BudgetVO;
import org.travelmaker.domain.DaybudVO;

public interface BudgetService {
	
	// list.jsp - 모든 일정, 지출 내역
	public List<BudgetVO> getList();

}

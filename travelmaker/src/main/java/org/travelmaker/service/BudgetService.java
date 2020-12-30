package org.travelmaker.service;

import java.util.List;

import org.travelmaker.domain.BudgetVO;
import org.travelmaker.domain.DaybudVO;

public interface BudgetService {
	
	// list.jsp - 모든 일정, 지출 내역
	public List<BudgetVO> getBudgetByUser();
	// budgetList getBudgetByUser
	// schBudgetList getBudgetBySch
	// getDateBudgetList getBudgetListByDate
	// getAllDateBudgetList getBudgetListByAllDates
	
	// regDateBox selectBoxByDate setRegBoxByDate setBoxByDate
	// regSchBox selectBoxBySch setRegBoxBySch setBoxBySch
	// selectDateBox setSelectDateBox ??? getDateBox
	
	// 음식점, 카페, 이동, 레저, 숙박, 쇼핑, 유흥, 간
	// 음식점, 
	
}
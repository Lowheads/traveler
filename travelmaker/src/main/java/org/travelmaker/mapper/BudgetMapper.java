package org.travelmaker.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.travelmaker.domain.BudgetVO;
import org.travelmaker.domain.DaybudVO;

public interface BudgetMapper { 
	
	// list.jsp - 모든 일정, 지출 내역 출력
	public List<BudgetVO> getBudgetByUser(@Param("memNo")int memNo);

	//
//	public BudgetVO read(Long no);
	public void insertBudget(int schNo);
}

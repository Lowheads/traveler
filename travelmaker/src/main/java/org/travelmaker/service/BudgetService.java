package org.travelmaker.service;

import java.util.List;

import org.travelmaker.domain.BudgetVO;
import org.travelmaker.domain.DaybudVO;

public interface BudgetService {
	
	public void register(BudgetVO Budget);
	
	public BudgetVO get(Long no);
	
	public boolean modify(BudgetVO Budget);
	
	public boolean remove(Long no);
	
	public List<BudgetVO> getList();

}

package org.travelmaker.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Select;
import org.travelmaker.domain.BudgetVO;
import org.travelmaker.domain.DaybudVO;

public interface BudgetMapper { // xml과  세트 , 서비스는 여기서 가져다가 사용 
	
	//@Select("select * from schedule where sch_no > 0")
	public List<BudgetVO> getList();
	
	public void insert(BudgetVO Budget);
	
	public void insertSelectKey(BudgetVO Budget);

	public BudgetVO read(Long no);

	public int delete(Long no);
	
	public int update(BudgetVO Budget);

}

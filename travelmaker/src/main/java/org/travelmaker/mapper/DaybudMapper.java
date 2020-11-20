package org.travelmaker.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Select;
import org.travelmaker.domain.DaybudVO;

public interface DaybudMapper { // xml과  세트 , 서비스는 여기서 가져다가 사용 
	
	//@Select("select * from schedule where sch_no > 0")
	public List<DaybudVO> getList();
	
	public void insert(DaybudVO daybud);
	
	public void insertSelectKey(DaybudVO daybud);

	public List<DaybudVO> read(Long no);

	public int delete(Long no);
	
	public int update(DaybudVO daybud);
	
	public List<DaybudVO> select();
}

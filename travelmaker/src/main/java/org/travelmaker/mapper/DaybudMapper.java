package org.travelmaker.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Select;
import org.travelmaker.domain.DaybudVO;

public interface DaybudMapper { 
	
	// get.jsp - 셀렉트 박스 : 날짜
	public List<DaybudVO> box();
	
	// get.jsp - 날짜별 지출 내역 카운트 : 그래프
	public List<DaybudVO> read(Long no);
	
	// list.jsp - Test, 그래프
	public List<DaybudVO> getList();
 
}

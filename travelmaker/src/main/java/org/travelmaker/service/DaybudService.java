package org.travelmaker.service;

import java.util.List;

import org.travelmaker.domain.DaybudVO;

public interface DaybudService {
	
	public void register(DaybudVO daybud);
	
	public List<DaybudVO> get(Long no);
	
	public boolean modify(DaybudVO daybud);
	
	public boolean remove(Long no);
	
	public List<DaybudVO> getList();

	public List<DaybudVO> box();


}

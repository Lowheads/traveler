package org.travelmaker.mapper;

import org.travelmaker.domain.PickVO;

public interface PickMapper {

	public void insert(PickVO vo);
	
	public void insertSch(PickVO vo);
	
	public int delete(PickVO vo);
	
	public int deleteSch(PickVO vo);
	
}

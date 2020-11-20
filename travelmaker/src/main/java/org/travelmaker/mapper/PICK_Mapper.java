package org.travelmaker.mapper;

import org.travelmaker.domain.PICK_VO;

public interface PICK_Mapper {

	public int insert(PICK_VO vo);
	
	public int delete(PICK_VO vo);
	
	public int deleteSch(PICK_VO vo);
	
}

package org.travelmaker.service;

import org.travelmaker.domain.PickVO;

public interface PickService {

	public int register(PickVO vo);
	
	public int remove(PickVO vo);
	
	public int removeSch(PickVO vo);
	
}

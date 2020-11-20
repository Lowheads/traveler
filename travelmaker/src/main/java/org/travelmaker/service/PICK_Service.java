package org.travelmaker.service;

import org.travelmaker.domain.PICK_VO;

public interface PICK_Service {

	public int register(PICK_VO vo);
	
	public int remove(PICK_VO vo);
	
	public int removeSch(PICK_VO vo);
	
}

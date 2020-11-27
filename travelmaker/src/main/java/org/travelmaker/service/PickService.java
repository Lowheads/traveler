package org.travelmaker.service;

import org.travelmaker.domain.PickVO;

public interface PickService {

	public int register(PickVO vo);
	
	//좋아요취소
	public int remove(PickVO vo);
	
}
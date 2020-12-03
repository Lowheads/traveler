package org.travelmaker.mapper;

import java.util.List;

import org.travelmaker.domain.SchdtVO;
import org.travelmaker.domain.Schdt_PlaceVO;

public interface SchdtMapper {

	public List<SchdtVO> getSchdt(int schNo);
	
	public List<Schdt_PlaceVO> getplacetitle(int SchNo);
	
	public int insert(SchdtVO[] schdtVOs);
	}

package org.travelmaker.service;

import java.util.List;
import java.util.Map;

import org.travelmaker.domain.SchdtVO;
import org.travelmaker.domain.Schdt_PlaceVO;

public interface SchdtService {

	public List<SchdtVO> getSchdt(int schNo);

	List<Schdt_PlaceVO> getplacetitle(int schNo);
	
	public List<Map<String,Object>> getSchdtList(int schNo);
}

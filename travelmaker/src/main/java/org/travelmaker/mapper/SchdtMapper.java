package org.travelmaker.mapper;

import java.util.List;
import java.util.Map;

import org.travelmaker.domain.SchdtVO;
import org.travelmaker.domain.Schdt_PlaceVO;

public interface SchdtMapper {

	public List<SchdtVO> getSchdt(int schNo);
	public List<Schdt_PlaceVO> getplacetitle(int SchNo);
	
	public int insert(SchdtVO[] schdtVOs);
	//스케줄 dt + 사진까지
	public List<Map<String,Object>> getSchdtList(int schNo);
	
	public int deleteSchdt(int schNo);
	
}

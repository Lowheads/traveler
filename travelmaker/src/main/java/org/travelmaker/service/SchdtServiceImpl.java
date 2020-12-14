package org.travelmaker.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.travelmaker.domain.SchdtVO;
import org.travelmaker.domain.Schdt_PlaceVO;
import org.travelmaker.mapper.SchdtMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;


@Log4j
@Service
@AllArgsConstructor
public class SchdtServiceImpl implements SchdtService {

	private SchdtMapper mapper;
	@Override
	public List<SchdtVO> getSchdt(int schNo) {
		log.info("getSchDt........"+schNo);
		return mapper.getSchdt(schNo);
	}
	
	@Override
	public List<Schdt_PlaceVO> getplacetitle(int schNo){
		log.info("getplacetitle......."+schNo);
		return mapper.getplacetitle(schNo);
	}

	@Override
	public List<Map<String, Object>> getSchdtList(int schNo) {
		return mapper.getSchdtList(schNo);
	}

	@Override
	public int deleteSchdt(int schNo) {
		// TODO Auto-generated method stub
		return mapper.deleteSchdt(schNo);
	}

}

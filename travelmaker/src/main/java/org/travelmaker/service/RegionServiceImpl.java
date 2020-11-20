package org.travelmaker.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.travelmaker.domain.RegionVO;
import org.travelmaker.mapper.RegionMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class RegionServiceImpl implements RegionService {

	private RegionMapper mapper;
	
	@Override
	public List<RegionVO> getList() {
		
		log.info("getList.........");
		return mapper.getList();
	}
}

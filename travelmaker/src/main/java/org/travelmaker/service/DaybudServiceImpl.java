package org.travelmaker.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.travelmaker.domain.DaybudVO;
import org.travelmaker.mapper.DaybudMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class DaybudServiceImpl implements DaybudService { // mapper(+xml) 에서 가져다가 사용 
	
	private DaybudMapper mapper;

	@Override
	public void register(DaybudVO daybud) {
		log.info("register......" + daybud);
		mapper.insert(daybud);
	}

	@Override
	public List<DaybudVO> get(Long schno) {
		log.info("get......" + schno);
		return mapper.read(schno);
	}

	@Override
	public boolean modify(DaybudVO daybud) {
		log.info("modify......" + daybud);
		return mapper.update(daybud) == 1;
	}

	@Override
	public boolean remove(Long schno) {
		log.info("remove" + schno);
		return mapper.delete(schno) == 1;
	}

	@Override // 
	public List<DaybudVO> getList() {
		log.info("getList......");
		return mapper.getList();
	}

	@Override
	public List<DaybudVO> box() {
		return mapper.box();
	}
	
}

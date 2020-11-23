package org.travelmaker.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.travelmaker.domain.BudgetVO;
import org.travelmaker.domain.DaybudVO;
import org.travelmaker.mapper.BudgetMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class BudgetServiceImpl implements BudgetService { // mapper(+xml) 에서 가져다가 사용 
	
	private BudgetMapper mapper;

	@Override
	public void register(BudgetVO budget) {
		log.info("register......" + budget);
		mapper.insert(budget);
	}

	@Override
	public BudgetVO get(Long schno) {
		log.info("get......" + schno);
		return mapper.read(schno);
	}

	@Override
	public boolean modify(BudgetVO budget) {
		log.info("modify......" + budget);
		return mapper.update(budget) == 1;
	}

	@Override
	public boolean remove(Long schno) {
		log.info("remove" + schno);
		return mapper.delete(schno) == 1;
	}

	@Override // 이거 어떻게 동작할 수 있는지 ?
	public List<BudgetVO> getList() {
		log.info("getList......");
		return mapper.getList();
	}

}

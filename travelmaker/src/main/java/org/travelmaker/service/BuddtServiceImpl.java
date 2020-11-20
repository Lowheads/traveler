package org.travelmaker.service;

import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Service;
import org.travelmaker.domain.BuddtVO;
import org.travelmaker.mapper.BuddtMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class BuddtServiceImpl implements BuddtService { // mapper(+xml) 에서 가져다가 사용 
	
	private BuddtMapper mapper;

	@Override
	public void register(BuddtVO buddt) {
		log.info("register......" + buddt);
		mapper.insert(buddt);
	}

	@Override
	public List<BuddtVO> get(Date paydate) { // 그래프 & 2020-11-03
		log.info("get......" + paydate);
		return mapper.read(paydate);
	}
	
	@Override
	public BuddtVO get(Long no) {
		return null;
	}
	
	@Override
	public boolean modify(BuddtVO buddt) {
		log.info("modify......" + buddt);
		return mapper.update(buddt) == 1;
	}

	@Override
	public boolean remove(Long no) {
		log.info("remove" + no);
		return mapper.delete(no) == 1;
	}
	
	@Override
	public boolean amend(BuddtVO buddt) {
		log.info("amend" + buddt);
		return mapper.update(buddt) == 1;
	}

	@Override // ???????
	public List<BuddtVO> getList() {
		log.info("getList......");
		return mapper.getList();
	}

	@Override
	public List<BuddtVO> cateCnt() {
		log.info("cateCnt......");
		return mapper.cateCnt();
	}	
	
	@Override
	public List<BuddtVO> readAll(Long schno) {
		log.info("readAll......");
		return mapper.readAll(schno);
	}

	@Override
	public BuddtVO readed(BuddtVO vo) {
		// TODO Auto-generated method stub
		return mapper.readed(vo);
	}

	
}

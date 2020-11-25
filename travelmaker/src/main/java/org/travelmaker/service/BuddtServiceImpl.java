package org.travelmaker.service;

import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Service;
import org.travelmaker.domain.BuddtVO;
import org.travelmaker.domain.DaybudVO;
import org.travelmaker.mapper.BuddtMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class BuddtServiceImpl implements BuddtService {
	
	private BuddtMapper mapper;
	
	// get.jsp - 일정 지출 내역 : 날짜별
	@Override
	public List<BuddtVO> get(Date paydate) {
		log.info("get......" + paydate);
		return mapper.read(paydate);
	}

	// listAll.jsp - 선택된 일정 모든 지출 내역
	@Override
	public List<BuddtVO> readAll(Long schno) {
		log.info("readAll......");
		return mapper.readAll(schno);
	}

	// register.jsp - 지출 내역 등록
	@Override
	public void register(BuddtVO buddt) {
		log.info("register......" + buddt);
		mapper.insert(buddt);
	}
	
	// register.jsp - 셀렉트 박스 : 일정 선택
	@Override
	public List<DaybudVO> box() {
		return mapper.box();
	}
	
	// register.jsp - 날짜 선택 제한
	@Override
	public BuddtVO mmDate(Long schno) {
		log.info("mmDate......");
		return mapper.mmDate(schno);
	}	
	
	// modify.jsp - 수정
	@Override
	public boolean modify(BuddtVO buddt) {
		log.info("modify......" + buddt);
		return mapper.update(buddt) == 1;
	}
	
	// modify.jsp - 읽기 전용 VO
	@Override
	public BuddtVO readed(BuddtVO vo) {
		return mapper.readed(vo);
	}
	
	// modify.jsp - 삭제
	@Override
	public boolean remove(Long no) {
		log.info("remove" + no);
		return mapper.delete(no) == 1;
	}
	
	// Test - 그래프
//	@Override
//	public List<BuddtVO> cateCnt() {
//		log.info("cateCnt......");
//		return mapper.cateCnt();
//	}	
	
	// Test - 그래프
//	@Override 
//	public List<BuddtVO> getList() {
//		log.info("getList......");
//		return mapper.getList();
//	}
	
	// XX
//	@Override
//	public BuddtVO get(Long no) {
//		return null;
//	}
	
}

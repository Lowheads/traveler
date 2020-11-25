package org.travelmaker.service;

import java.util.Date;
import java.util.List;

import org.travelmaker.domain.BuddtVO;
import org.travelmaker.domain.DaybudVO;

public interface BuddtService {

	// get.jsp - 일정 지출 내역 : 날짜별 
	public List<BuddtVO> get(Date paydate);

	// listAll.jsp - 선택된 일정 모든 지출 내역
	public List<BuddtVO> readAll(Long schno);

	// register.jsp - 지출 내역 등록
	public void register(BuddtVO buddt);
	
	// register.jsp - 셀렉트 박스 : 일정 선택
	public List<DaybudVO> box();
	
	// register.jsp - 날짜 선택 제한
	public BuddtVO mmDate(Long schno);
	
	// modify.jsp - 수정
	public boolean modify(BuddtVO buddt);

	// modify.jsp - 읽기 전용 VO
	public BuddtVO readed(BuddtVO vo);
	
	// modify.jsp - 삭제
	public boolean remove(Long no);
	
	// Test - 그래프
//	public List<BuddtVO> cateCnt();
	
	// Test - 그래프
//	public Long calculCnt(Date paydate);
//	public List<BuddtVO> getList();

//	// XX
//	public BuddtVO get(Long no);
}

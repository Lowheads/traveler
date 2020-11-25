package org.travelmaker.mapper;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Select;
import org.travelmaker.domain.BuddtVO;
import org.travelmaker.domain.DaybudVO;

public interface BuddtMapper {
	
	// get.jsp - 해당 일정 지출 내역
	public List<BuddtVO> read(Date paydate);

	// listAll.jsp - 해당 일정 모든 지출 내역
	public List<BuddtVO> readAll(long schno);
	
	// register.jsp - 등록
	public void insert(BuddtVO buddt);
	
	// register.jsp - 셀렉트 박스 : 일정 선택
	public List<DaybudVO> box();
	
	// register.jsp - 날짜 선택 제한
	public BuddtVO mmDate(Long schno);
			
	// modify.jsp - 수정
	public int update(BuddtVO buddt);
	
	// modify.jsp - 읽기 전용 VO
	public BuddtVO readed(BuddtVO vo);
	
	// modify.jsp - 삭제
	public int delete(Long no);
	
	// list.jsp X
	public List<BuddtVO> getList();
	
	// get.jsp - 그래프 X
	public List<BuddtVO> cateCnt();
	
}
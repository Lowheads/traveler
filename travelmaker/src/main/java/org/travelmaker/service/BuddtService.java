package org.travelmaker.service;

import java.util.Date;
import java.util.List;

import org.travelmaker.domain.BuddtVO;
import org.travelmaker.domain.DaybudVO;

public interface BuddtService { // 그래프 & 2020-11-03

	public void register(BuddtVO buddt);

	public List<BuddtVO> get(Date paydate);

	public boolean modify(BuddtVO buddt);

	public boolean remove(Long no);

	public List<BuddtVO> getList();

//	public Long calculCnt(Date paydate); 그래프

	public List<BuddtVO> cateCnt();

	public List<BuddtVO> readAll(Long schno);

	public BuddtVO get(Long no);

//	수정 페이지에 입력 값을 가져옵니다.
	public BuddtVO readed(BuddtVO vo);

	boolean amend(BuddtVO buddt);

	public List<DaybudVO> box();

	public List<DaybudVO> dateBox();

	public BuddtVO mmDate(Long schno);

}

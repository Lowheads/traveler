package org.travelmaker.service;

import java.util.Date;
import java.util.List;

import org.travelmaker.domain.BuddtVO;

public interface BuddtService { // 그래프 & 2020-11-03
	
	public void register(BuddtVO buddt);
	
	public List<BuddtVO> get(Date paydate);
	
	public boolean modify(BuddtVO buddt);
	
	public boolean remove(Long no);
	
	public List<BuddtVO> getList();
	
//	public Long calculCnt(Date paydate);
	
	public List<BuddtVO> cateCnt();
	
	public List<BuddtVO> readAll(Long schno);

	public BuddtVO get(Long no);
	
	public BuddtVO readed(BuddtVO vo);

	boolean amend(BuddtVO buddt);

}

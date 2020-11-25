package org.travelmaker.service;

import java.util.List;

import org.travelmaker.domain.Criteria;
import org.travelmaker.domain.PlaceVO;
import org.travelmaker.domain.ScheduleVO;

public interface ScheduleService {


	//한개장소만가져오기
	public ScheduleVO get(int schNo);
	//삭제(하트클릭할때)
	public boolean remove(int schNo);
	//전체리스트
	public List<ScheduleVO> getList();
	
	//memno에 맞는 schedulelist가져오기
	public List<ScheduleVO> getList(int memNo);
	
	//memno에 맞는 schedule 공개, 비공개 여부 가져오기
	public List<ScheduleVO> getHiddenList(int memNo); 
	
	public int statusupdate(int schNo);

	public boolean modify(ScheduleVO vo);

	public List<ScheduleVO> getList(Criteria cri,String selected);

	public void updateLikeCnt(ScheduleVO vo);

	public List<ScheduleVO> getPastList(Criteria cri);

	public List<ScheduleVO> getUpCommingList(Criteria cri);

	public int getTotal(Criteria cri);

	public int getPtotal(Criteria cri);

	public int getCtotal(Criteria cri);

	public void register(ScheduleVO schedule);


	public ScheduleVO getListSchedule(int schNo); 

}
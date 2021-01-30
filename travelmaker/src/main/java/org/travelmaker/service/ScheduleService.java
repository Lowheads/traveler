package org.travelmaker.service;

import java.util.List;
import java.util.Map;

import org.travelmaker.domain.Criteria;
import org.travelmaker.domain.PlaceVO;
import org.travelmaker.domain.ScheduleVO;

public interface ScheduleService {


	//한개장소만가져오기
	public ScheduleVO getSchedule(int schNo);

	public boolean removeSchdule(int schNo);
	//전체리스트
	public List<ScheduleVO> getList();
	
	//memno에 맞는 schedulelist가져오기
	public List<ScheduleVO> getList(int memNo);
	
	//memno에 맞는 schedule 공개, 비공개 여부 가져오기
	public List<Map<String, Object>> getHiddenList(int memNo); 
	
	public List<Map<String, Object>> getSchedt(int schNo);

	public boolean modify(ScheduleVO vo);

	public List<Map<String, Object>> getList(Criteria cri);

	public void updateLikeCnt(ScheduleVO vo);

	public List<ScheduleVO> getPastList(Criteria cri);

	public List<ScheduleVO> getUpComingList(Criteria cri);

	public int getTotal(Criteria cri);

	public int getPastScheduleTotal(Criteria cri);

	public int getComingScheduleTotal(Criteria cri);

	public int register(ScheduleVO schedule) throws Exception;

	public ScheduleVO getListSchedule(int schNo);
	
	public void statusupdate(int schNo); 
	
	public boolean checkPick(ScheduleVO schedule); 
	
	public List<Map<String, Object>> checkBudgetList(int memNo);

}
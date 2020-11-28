package org.travelmaker.mapper;

import java.util.List;

import org.travelmaker.domain.Criteria;
import org.travelmaker.domain.PlaceVO;
import org.travelmaker.domain.ScheduleVO;

public interface ScheduleMapper {

	public ScheduleVO read(int schNo);

	// 리스트 불러와야되고 
	public List<ScheduleVO> getList();

	//memno에 맞는 schedulelist가져오기
	public List<ScheduleVO> getList(int memNo);
	
	public List<ScheduleVO> getHiddenList(int memNo);
	
	// 삭제가능해야되고
	public int delete(int schNo);

	// 업데이트 가능해야되고(좋아요 업다운)
	public int update(ScheduleVO vo);


	public void upCnt(int schNo);

	public int statusupdate(int schNo);

	public void downCnt(int schNo);

	public List<ScheduleVO> getListWithPaging(Criteria cri);

	public List<ScheduleVO> getPastSch(Criteria cri);

	public List<ScheduleVO> getUpCommingSch(Criteria cri);

	public int getTotalCount(Criteria cri);

	public int getPastTotal(Criteria cri);

	public int getCommingTotal(Criteria cri);

	public ScheduleVO getListSchedule(int schNo);

	public void insert(ScheduleVO schedule);

	public void insertSelectKey(ScheduleVO schedule);
	
//	public List<ScheduleVO> sortLike(Criteria cri);
	public List<ScheduleVO> sortNewest(Criteria cri);
	public List<ScheduleVO> sortOldest(Criteria cri);

}
package org.travelmaker.mapper;

import java.util.List;
import java.util.Map;

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

	//게시글 상태 미작성 -> 작성으로 변경
	public int statusWritten(int schNo);
	//게시글 상태 작성 -> 미작성으로 변경
	public int statusunWritten(int schNo);
	//게시글 상태 미작성-> 작성중으로 변경
	public int statusWritting(int schNo);
	
	public int statusupdate(int schNo);

	public List<Map<String,Object>> getListWithPaging(Criteria cri);

	public List<ScheduleVO> getPastSch(Criteria cri);

	public List<ScheduleVO> getUpComingList(Criteria cri);

	public int getTotalCount(Criteria cri);

	public int getPastScheduleTotal(Criteria cri);

	public int getComingScheduleTotal(Criteria cri);

	public ScheduleVO getListSchedule(int schNo);

	public void insert(ScheduleVO schedule);

	public int insertSelectKey(ScheduleVO schedule);
	
	public List<Map<String, Object>> getSortList(Criteria cri);

}


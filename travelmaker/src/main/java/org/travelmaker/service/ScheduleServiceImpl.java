package org.travelmaker.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.travelmaker.domain.Criteria;
import org.travelmaker.domain.PlaceVO;
import org.travelmaker.domain.ScheduleVO;
import org.travelmaker.mapper.ScheduleMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class ScheduleServiceImpl implements ScheduleService{

	@Setter(onMethod_ = @Autowired)
	private ScheduleMapper mapper;

	//	@Override
	//	public void register(SchVO vo) {
	//		log.info("register"+vo);
	//		mapper.insert(vo);
	//	}

	@Override
	public ScheduleVO get(int schNo) {

		log.info("get...."+schNo);

		return mapper.read(schNo);

	}
	
	@Override
	public int statusupdate(int schNo) {
		return mapper.statusupdate(schNo);
	}

	@Override
	public boolean remove(int schNo) {

		log.info("remove...."+schNo);

		return mapper.delete(schNo)==1;
	}

	@Override
	public List<ScheduleVO> getList() {

		log.info("getList.....");

		return mapper.getList();
	}
	
	//공개,비공개 여부 알 수 있는 리스트 가져오기
	@Override
	public List<ScheduleVO> getHiddenList(int memNo) {
		// TODO Auto-generated method stub
		return mapper.getHiddenList(memNo);
	}

	//memno에 맞는 schedulelist가져오기
	public List<ScheduleVO> getList(int memNo){
		return mapper.getList(memNo);
	}
	@Override
	public boolean modify(ScheduleVO vo) {

		log.info("modify..."+vo);

		return mapper.update(vo) ==1;
	}


	@Override
	public List<ScheduleVO> getList(Criteria cri,String selected) {

		if(selected!=null) {
		  //if(selected.equals("like")){
			//				}
			if(selected.equals("new")){
				return mapper.sortNewest(cri);
			}
			if(selected.equals("old")){
				return mapper.sortOldest(cri);
			}
		}
		return mapper.getListWithPaging(cri);
	}

	@Override
	public void updateLikeCnt(ScheduleVO vo) {
		log.info("update,,,");
		mapper.update(vo);
	}

	@Override
	public List<ScheduleVO> getPastList(Criteria cri) {
		log.info("get List with criteria: "+cri);

		return mapper.getPastSch(cri);
	}

	@Override
	public List<ScheduleVO> getUpCommingList(Criteria cri) {
		log.info("get List with criteria: "+cri);

		return mapper.getUpCommingSch(cri);
	}

	@Override
	public int getTotal(Criteria cri) {
		// TODO Auto-generated method stub
		return mapper.getTotalCount(cri);
	}

	@Override
	public int getPtotal(Criteria cri) {
		// TODO Auto-generated method stub
		return mapper.getPastTotal(cri);
	}

	@Override
	public int getCtotal(Criteria cri) {
		// TODO Auto-generated method stub
		return mapper.getCommingTotal(cri);
	}

	@Override
	public int register(ScheduleVO schedule) {

		log.info("register....."+schedule);
		return mapper.insertSelectKey(schedule);
	}

	public ScheduleVO getListSchedule(int schNo) {
		log.info("getschedule......"+schNo);
		return mapper.getListSchedule(schNo);
	}
}
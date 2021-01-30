package org.travelmaker.service;

import java.util.List;
import java.util.Map;

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
	public ScheduleVO getSchedule(int schNo) {

		log.info("get...."+schNo);

		return mapper.read(schNo);

	}


	@Override
	public void statusupdate(int schNo) {
		ScheduleVO schedule= getSchedule(schNo);
		String status=schedule.getSchStatus();
		System.out.println(status);
		//작성일때 -> 미작성으로
		if(status.equals("BS001")) {
			mapper.statusunWritten(schNo);
		}
		//작성중일때-> 작성으로
		else if(status.equals("BS002")) {
			mapper.statusWritten(schNo);
		}
		//미작성일때 -> 작성중으로
		else if(status.equals("BS003")) {
			mapper.statusWritting(schNo);
		}

	}


	@Override
	public boolean removeSchdule(int schNo) {

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
	public List<Map<String,Object>> getHiddenList(int memNo) {
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
	public List<Map<String, Object>> getList(Criteria cri) {

		if(cri.getSelected()==null || cri.getSelected().equals("null")) {
			return mapper.getListWithPaging(cri);
		}
		return mapper.getSortList(cri);
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
	public List<ScheduleVO> getUpComingList(Criteria cri) {
		log.info("get List with criteria: "+cri);

		return mapper.getUpComingList(cri);
	}

	@Override
	public int getTotal(Criteria cri) {
		// TODO Auto-generated method stub
		return mapper.getTotalCount(cri);
	}

	@Override
	public int getPastScheduleTotal(Criteria cri) {
		// TODO Auto-generated method stub
		return mapper.getPastScheduleTotal(cri);
	}

	@Override
	public int getComingScheduleTotal(Criteria cri) {
		// TODO Auto-generated method stub
		return mapper.getComingScheduleTotal(cri);
	}

	@Override
	public int register(ScheduleVO schedule) throws Exception {

		log.info("register....."+schedule);
		return mapper.insertSelectKey(schedule);
	}
	
	@Override
	public ScheduleVO getListSchedule(int schNo) {
		log.info("getschedule......"+schNo);
		return mapper.getListSchedule(schNo);
	}


	@Override
	public List<Map<String, Object>> getSchedt(int schNo) {

		return mapper.getSchedule(schNo);
	}

	//로그인 된 회원이 일정 찜 했는지 확인
	@Override
	public boolean checkPick(ScheduleVO schedule) {
		if(mapper.checkPicked(schedule)==1) {
			return true;
		}
		else return false;
	}


	@Override
	public List<Map<String, Object>> checkBudgetList(int memNo) {
		return mapper.checkBudget(memNo);
	}
	
	

}
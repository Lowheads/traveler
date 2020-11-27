package org.travelmaker.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.travelmaker.domain.PickVO;
import org.travelmaker.mapper.BoardMapper;
import org.travelmaker.mapper.PickMapper;
import org.travelmaker.mapper.PlaceMapper;
import org.travelmaker.mapper.ScheduleMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class PickServiceImpl implements PickService{

	@Setter(onMethod_ = @Autowired)
	private PickMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private PlaceMapper pMapper;
	
	@Setter(onMethod_ = @Autowired)
	private ScheduleMapper sMapper;
	
	@Setter(onMethod_ = @Autowired)
	private BoardMapper bMapper;
	
	@Override
	public int register(PickVO vo) {
		
		pMapper.upCnt(vo.getPlcNo());
		return mapper.insert(vo); 
	}

	@Override
	public int remove(PickVO vo) {
		
		//장소 좋아요취소일때
		if(vo.getPlcNo()!=0) {
			pMapper.downCnt(vo.getPlcNo());
			return mapper.delete(vo);
		}
		
		//일정에 대한 좋아요 취소일때
		return mapper.deleteSch(vo);
	}
}

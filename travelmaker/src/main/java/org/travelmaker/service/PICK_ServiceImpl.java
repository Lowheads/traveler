package org.travelmaker.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.travelmaker.domain.PICK_VO;
import org.travelmaker.mapper.BoardMapper;
import org.travelmaker.mapper.PICK_Mapper;
import org.travelmaker.mapper.PlaceMapper;
import org.travelmaker.mapper.ScheduleMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class PICK_ServiceImpl implements PICK_Service{

	@Setter(onMethod_ = @Autowired)
	private PICK_Mapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private PlaceMapper pMapper;
	
	@Setter(onMethod_ = @Autowired)
	private ScheduleMapper sMapper;
	
	@Setter(onMethod_ = @Autowired)
	private BoardMapper bMapper;
	
	@Override
	public int register(PICK_VO vo) {
		
		pMapper.upCnt(vo.getPlcNo());
		return mapper.insert(vo); 
	}

	@Override
	public int remove(PICK_VO vo) {
		pMapper.downCnt(vo.getPlcNo());
		return mapper.delete(vo);
		
	}

	@Override
	public int removeSch(PICK_VO vo) {
		log.info("deleteSch :"+vo.getSchNo());
//		bMapper.downCnt(vo.getSchNo());
		return mapper.deleteSch(vo);
	}

}

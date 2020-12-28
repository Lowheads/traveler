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

@Log4j
@Service
public class PickServiceImpl implements PickService{

   @Setter(onMethod_ = @Autowired)
   private PickMapper pickMapper;

   @Setter(onMethod_ = @Autowired)
   private PlaceMapper placeMapper;

   @Setter(onMethod_ = @Autowired)
   private ScheduleMapper scheduleMapper;

   @Setter(onMethod_ = @Autowired)
   private BoardMapper boardMapper;

   //좋아요 눌렀을때 찜한장소(일정) 리스트에 추가시키는 메서드인데 아직 게시판이랑 연동 x 
   @Override
   @Transactional
   public int register(PickVO vo) {
      if(vo.getSchNo()==0) {
         placeMapper.upCnt(vo.getPlcNo());
         return pickMapper.insert(vo); 
      }
      boardMapper.upCnt(vo.getSchNo());
      return pickMapper.insertSch(vo);
   }

   @Override
   @Transactional
   public int remove(PickVO vo) {

      //장소 좋아요취소일때
      if(vo.getSchNo()==0) {
         placeMapper.downCnt(vo.getPlcNo());
         return pickMapper.delete(vo);
      }
      
      //일정에 대한 좋아요 취소일때
      boardMapper.downCnt(vo.getSchNo());
      return pickMapper.deleteSch(vo);
   }
}
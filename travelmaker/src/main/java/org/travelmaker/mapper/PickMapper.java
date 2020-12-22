package org.travelmaker.mapper;

import org.travelmaker.domain.PickVO;

public interface PickMapper {

   public int insert(PickVO vo);
   
   public int insertSch(PickVO vo);
   
   public int delete(PickVO vo);
   
   public int deleteSch(PickVO vo);
   
}
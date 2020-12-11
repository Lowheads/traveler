package org.travelmaker.mapper;

import org.travelmaker.domain.ThemeAttachVO;

public interface ThemeAttachMapper {

		public int insert(ThemeAttachVO vo);
		
		public int update(ThemeAttachVO vo);
		
		public int delete(int themeNo);
		
		public ThemeAttachVO findByThemeNo(int themeNo);
		
	
}

package org.travelmaker.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.travelmaker.domain.Criteria;
import org.travelmaker.domain.PlaceVO;
import org.travelmaker.domain.ThemeAttachVO;
import org.travelmaker.domain.ThemeVO;
import org.travelmaker.mapper.ThemeAttachMapper;
import org.travelmaker.mapper.ThemeMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
@Log4j
@Service
@AllArgsConstructor
public class ThemeServiceImpl implements ThemeService {
	
	private ThemeMapper mapper;
	private ThemeAttachMapper attMapper;

	public List<String> getThemeList() {

		return mapper.getThemeList();
		 
	}

	@Override
	public List<PlaceVO> getThemeInfo(int themeNo) {
	
		return mapper.getThemeInfo(themeNo);
	}
	
	@Transactional
	@Override
	public Map<String, Integer> updateTheme(String[] removedPlaces,String[] addedPlaces, int themeNo, ThemeAttachVO attachment) {
		
		System.out.println("1");
		
		attMapper.delete(themeNo);
		
		if(attachment.isImage()) {
			
			attMapper.update(attachment);
					
		}
		System.out.println("update시작 ");
		int update = mapper.updateTheme(themeNo);
		System.out.println("update끝 "+update);
		
		Map<String, Integer> result = new HashMap<>();
		
		result.put("deleteResult",0);
		result.put("insertResult",0);
		
		if(removedPlaces.length!=0) {
			result.put("deleteResult", mapper.deleteTheme(removedPlaces, themeNo));
		}
		
		if(addedPlaces.length!=0) {
			result.put("insertResult", mapper.insertTheme(addedPlaces, themeNo));
		}
		
		return result;
	}
	
	@Override
	public List<PlaceVO> getPlaceList(String keyword, int pageNum ) {
		
		return mapper.getPlaceList(keyword, pageNum);
	}

	@Override
	public ThemeAttachVO getAttachment(int themeNo) {

		return attMapper.findByThemeNo(themeNo);
	}
	

	public int getTotal(String keyword) {
		
		return mapper.getTotalCount(keyword);
	}
	


}

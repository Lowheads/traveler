package org.zerock.mapper;

import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.travelmaker.domain.BoarddtVO;
import org.travelmaker.domain.Criteria;
import org.travelmaker.domain.MemberVO;
import org.travelmaker.mapper.AdminBoardMapper;
import org.travelmaker.mapper.AdminMemberMapper;
import org.travelmaker.mapper.ThemeMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class MapperTests {
	
	@Setter(onMethod_ =@Autowired)
	private AdminMemberMapper mapper;

	@Setter(onMethod_ =@Autowired)
	private AdminBoardMapper mapper2;
	
	@Setter(onMethod_ =@Autowired)
	private ThemeMapper mapper3;
	
	
//	@Test
	public void dateTest(){
		
		Criteria cri = new Criteria();
		cri.setType("이메일");
		cri.setKeyword("gmail");
		
		 List<MemberVO> list = mapper.searchUser(cri);
		
		list.forEach(member -> log.info(member.getRegDate()));
	}
	
//	@Test
	public void dateTest2(){
		
		
		 List<MemberVO> list = mapper.getUserList();
		
		list.forEach(member -> log.info(member.getRegDate()));
	}
	

	//@Test
	public void testtt() {
		
		
		List<BoarddtVO> list = mapper2.getPostDetail(3);
				
				list.forEach(member -> log.info(member.toString()));		
		
		
	}
	
	
	@Test
	public void themeTest() {
		
		List<Map<String,String>> list = mapper3.getThemeInfo("1", "C001");
		
		list.forEach(member -> log.info(member.toString()));		
		
	}
}

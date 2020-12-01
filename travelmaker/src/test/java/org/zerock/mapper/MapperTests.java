package org.zerock.mapper;

import java.util.ArrayList;
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
import org.travelmaker.domain.PlaceDTO;
import org.travelmaker.mapper.AdminBoardMapper;
import org.travelmaker.mapper.AdminMemberMapper;
import org.travelmaker.mapper.ThemeMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class MapperTests {

	@Setter(onMethod_ = @Autowired)
	private AdminMemberMapper mapper;

	@Setter(onMethod_ = @Autowired)
	private AdminBoardMapper mapper2;

	@Setter(onMethod_ = @Autowired)
	private ThemeMapper mapper3;

//	@Test
	public void dateTest() {

		Criteria cri = new Criteria();
		cri.setType("이메일");
		cri.setKeyword("gmail");

		// List<MemberVO> list = mapper.searchUser(cri);

		// list.forEach(member -> log.info(member.getRegDate()));
	}

//	@Test
	public void dateTest2() {

		// List<MemberVO> list = mapper.getUserList();

		// list.forEach(member -> log.info(member.getRegDate()));
	}

	// @Test
	public void testtt() {

		List<BoarddtVO> list = mapper2.getPostDetail(3);

		list.forEach(member -> log.info(member.toString()));

	}

	// @Test
	public void themeTest() {

		//List<Map<String, String>> list = mapper3.getThemeInfo("1", "C001");

		//list.forEach(member -> log.info(member.toString()));

	}

	//@Test
	public void mapperTest() {

		Criteria cri = new Criteria();

		List<MemberVO> list = mapper.getUserList(cri);

		cri.setType("회원번호");
		cri.setKeyword("3");
		log.info("-----------------------------------------");
		log.info(cri);
		log.info("-----------------------------------------");
		List<MemberVO> list2 = mapper.getUserList(cri);

		list.forEach(member -> log.info(member.toString()));

		log.info("-----------------------------------------");

		list2.forEach(member -> log.info(member.toString()));

	}

	@Test
	public void withdrawListTest() {
		
		Criteria cri = new Criteria();

		List<MemberVO> list = mapper.getWithdrawUserList(cri);

		cri.setType("회원번호");
		cri.setKeyword("3");
		
		List<MemberVO> list2 = mapper.getWithdrawUserList(cri);

		
		list.forEach(member -> log.info(member.toString()));

		log.info("-----------------------------------------");

		list2.forEach(member -> log.info(member.toString()));

	}
	
	//@Test
	public void removeTest() {
		
		//int id[] = {15};
		//int[] ids = {20,21,12};
		
		ArrayList list = new ArrayList<>();
		
		list.add(38);
		
		mapper.removeUser(list);
	}
	
//	@Test
	public void deletePost() {
		
		ArrayList posts = new ArrayList<>();
		
		posts.add(15);
		posts.add(16);
		posts.add(17);
		posts.add(18);
		
		System.out.println(mapper2.removePost(posts));
		
	}
	
	@Test
	public void themeTest2() {
		
		List<PlaceDTO> list =mapper3.getThemeInfo("3");
		list.forEach(member -> log.info(member.toString()));

	}

}

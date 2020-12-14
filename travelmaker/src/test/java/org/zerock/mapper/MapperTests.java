package org.zerock.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.travelmaker.domain.ThemeVO;
import org.travelmaker.mapper.AdminBoardMapper;
import org.travelmaker.mapper.AdminMemberMapper;
import org.travelmaker.mapper.ThemeAttachMapper;
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

	@Setter(onMethod_ = @Autowired)
	private ThemeAttachMapper mapper4;

//	@Test
	public void dateTest() {

//		Criteria cri = new Criteria();
//		cri.setType("이메일");
//		cri.setKeyword("gmail");
//
//		 List<MemberVO> list = mapper.searchUser(cri);
//
//		 list.forEach(member -> log.info(member.getRegDate()));
	}

//	@Test
	public void dateTest2() {

		// List<MemberVO> list = mapper.getUserList();

		// list.forEach(member -> log.info(member.getRegDate()));
	}

	// @Test
	public void testtt() {

//		List<BoarddtVO> list = mapper2.getPostDetail(3);
//
//		list.forEach(member -> log.info(member.toString()));

	}

	// @Test
	public void themeTest() {

		//List<Map<String, String>> list = mapper3.getThemeInfo("1", "C001");

		//list.forEach(member -> log.info(member.toString()));

	}

	//@Test
	public void mapperTest() {

//		Criteria cri = new Criteria();
//
//		List<MemberVO> list = mapper.getUserList(cri);
//
//		cri.setType("회원번호");
//		cri.setKeyword("3");
//		log.info("-----------------------------------------");
//		log.info(cri);
//		log.info("-----------------------------------------");
//		List<MemberVO> list2 = mapper.getUserList(cri);
//
//		list.forEach(member -> log.info(member.toString()));
//
//		log.info("-----------------------------------------");
//
//		list2.forEach(member -> log.info(member.toString()));

	}

//	@Test
	public void withdrawListTest() {
		
//		Criteria cri = new Criteria();
//
//		List<MemberVO> list = mapper.getWithdrawUserList(cri);
//
//		cri.setType("회원번호");
//		cri.setKeyword("3");
//		
//		List<MemberVO> list2 = mapper.getWithdrawUserList(cri);
//
//		
//		list.forEach(member -> log.info(member.toString()));
//
//		log.info("-----------------------------------------");
//
//		list2.forEach(member -> log.info(member.toString()));

	}
	
	//@Test
	public void removeTest() {
		
		//int id[] = {15};
		//int[] ids = {20,21,12};
		
//		ArrayList list = new ArrayList<>();
//		
//		list.add(38);
//		
//		mapper.removeUser(list);
	}
	
//	@Test
	public void deletePost() {
		
//		ArrayList posts = new ArrayList<>();
//		
//		posts.add(15);
//		posts.add(16);
//		posts.add(17);
//		posts.add(18);
//		
//		System.out.println(mapper2.removePost(posts));
//		
	}
	
	//@Test
	public void themeTest2() {
		/*
		List<PlaceDTO> list =mapper3.getThemeInfo(3);
		list.forEach(member -> log.info(member.toString()));
*/
	}
	
	//@Test
	public void modifyTheme() {
		
//		int[] list = new int[]{8552559};
//
//		int themeNo =5;
		
		//int result = mapper3.deleteTheme(list, themeNo);
		
		//int result = mapper3.insertTheme(list, themeNo);
		
		//log.info("---------------------------");
		//log.info(result);
		//log.info(result);
		
		
	}
	
	//@Test
	public void searchPlace() {
		
//		String keyword = "제주";
//		
//		List<PlaceVO> list = mapper3.getPlaceList(keyword);
//		
//		list.forEach(member -> log.info(member.toString()));
		
	}
	
	//@Test
	public void deleteThemeTests() {
		
//		String[]  places = {"8148451","8641860"};
//		int themeNo = 3;
//		
//		int result = mapper3.insertTheme(places, themeNo);
//		
//		log.info("@@@@@@@@@@"+result+"@@@@@@@@@@");
		
	}
	
//	@Test
	public void getTheme() {
		
//		int themeNo = 3;
//		
//		List<PlaceVO> list = mapper3.getThemeInfo(themeNo);
//		
//		list.forEach(member -> log.info(member.toString()));
		
		
		
	}
	
//	@Test
	public void attTest() {
		
//		int themeNo = 1;
//		
//		ThemeAttachVO img = mapper4.findByThemeNo(themeNo);
//		
//		log.info(img.toString());
		
		
		/*
		 * int themeNo = 2;
		 * 
		 * ThemeAttachVO img = new ThemeAttachVO();
		 * 
		 * 
		 * img.setUuid("knnnnnnnnsssnna"); img.setFileName("filename");
		 * img.setImage(true); img.setUploadPath("c/upload"); img.setThemeNo(themeNo);
		 * 
		 * int result = mapper4.update(img);
		 * 
		 * log.info(img.toString());
		 */	/*
		int result = mapper4.update(img);
		
		log.info("-----------------"+result+"-----------------");
		*/
		
		
		
		
//		
	}
	
	

}

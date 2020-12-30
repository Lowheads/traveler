package org.zerock.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.travelmaker.domain.Criteria;
import org.travelmaker.domain.PlaceVO;
import org.travelmaker.domain.QnABoardVO;
import org.travelmaker.domain.StatisticVO;
import org.travelmaker.mapper.AdminBoardMapper;
import org.travelmaker.mapper.AdminMemberMapper;
import org.travelmaker.mapper.MainMapper;
import org.travelmaker.mapper.PlaceMapper;
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
	
	@Setter(onMethod_ = @Autowired)
	private MainMapper mainMapper;

	@Setter(onMethod_ = @Autowired)
	private PlaceMapper placeMapper;
	

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
	
//	@Test
	public void updateThemeTest() {
		/*
		 * int themeNo = 2; log.info(mapper3.updateTheme(themeNo));
		 * 
		 * assertTrue(mapper3.updateTheme(themeNo)==1);
		 */	
		
	}
	
	//@Test
	public void codeTest() {
		
		List<String> list = mapper3.getThemeList();
		//List<ThemeVO> list = mapper3.getThemeList();
		
		
		
	//	HashMap<List<>, V>
		
		//List<ThemeVO> list = mapper3.getThemeList();
		
		//list.forEach(theme->log.info(theme.toString()));
	}
	
//	@Test
	public void getPostDetail() {
		
//		int boardNo = 19;
//		mapper2.getPostDetail(boardNo);
//		
		
	}
	//@Test
	public void mappertest() {
		
		/*
		 * int themeNo = 3;
		 * 
		 * List<PlaceVO> list = mapper3.getThemeInfo(themeNo);
		 * 
		 * list.forEach(theme->log.info(theme.toString()));
		 */
		/*
		 * int pageNum = 3;
		 * 
		 * String keyword = "바다";
		 * 
		 * List<PlaceVO> list = mapper3.getPlaceList(keyword, pageNum);
		 * 
		 * list.forEach(theme->log.info(theme.toString()));
		 */
		
	}
	
	//@Test
	public void mainMapperTest() {
		
		/*
		 * List<BoardVO> list = mainMapper.newestPost();
		 * 
		 * list.forEach(post->log.info(post.toString()));
		 */
		
		
		
//		/* List<StatisticVO> list = mainMapper.getDaily(); */
		 List<StatisticVO> list = mainMapper.getMonthly();
		 list.forEach(theme->log.info(theme.toString()));
		 
	}
	
	//@Test
	public void placeMapperTest() {
		
		int regionNo = 1;
	//	List<PlaceVO> list = placeMapper.getPlaceByWeather();
		List<PlaceVO> list = placeMapper.getPlaceByWeather(regionNo);
		
		list.forEach(theme->log.info(theme.toString()));
	}
	
	//@Test
	public void getMonthly() {
		
		/*
		 * List<StatisticVO> list = mainMapper.getMonthly();
		 * list.forEach(theme->log.info(theme.toString()));
		 */
		
		
		/*
		 * List<BoardVO> list = mainMapper.getPopularPostsByPick();
		 * list.forEach(theme->log.info(theme.toString()));
		 * 
		 * 
		 * List<BoardVO> list2 = mainMapper.getPopularPostsByView();
		 * list2.forEach(theme->log.info(theme.toString()));
		 */
		 
		/*
		 * int result = mainMapper.cntQnaPost(); log.info(result);
		 */
		
		List<QnABoardVO> list = mainMapper.getQnaPost();
		
		 list.forEach(theme->log.info(theme.toString()));
	}
	
	//@Test
	public void memberTest() {
		
		/*
		 * Criteria cri = new Criteria(); cri.setType("닉네임"); cri.setKeyword("아침");
		 * List<MemberVO> list= mapper.getUserList(null);
		 * 
		 * //List<MemberVO> list= mapper.getWithdrawUserList(cri);
		 * 
		 * list.forEach(theme->log.info(theme.toString()));
		 */
		
		
	}
	
//	@Test
	public void getPlaceList() {
		
		Criteria cri = new Criteria();
		
		cri.setKeyword("제주");
		cri.setPageNum(1);
		
		int regionNo=1;
		
		List<PlaceVO> list = mapper3.getPlaceList(cri.getKeyword(), cri.getPageNum(),regionNo);
		list.forEach(theme->log.info(theme.toString()));
	}
	
	@Test
	public void getImage() {
		
		int boardNo = 184;
		List<String> images = mapper2.getPostImages(boardNo);
		
		images.forEach(theme->log.info(theme.toString()));
		
		
	}
	

}

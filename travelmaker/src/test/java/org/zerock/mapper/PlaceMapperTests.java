package org.zerock.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.travelmaker.domain.Criteria;
import org.travelmaker.mapper.PlaceMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class PlaceMapperTests {

	@Setter(onMethod_ =@Autowired)
	private PlaceMapper mapper;
	
	@Test
	public void testGetListInCase() {
		String[] plcNoArr = {"17797733","8094035"};
		log.info(mapper.read(plcNoArr));
	}
	
	@Test
	public void testGetList() {
		mapper.getListWithTheme(1,"TM001").forEach(board -> log.info(board));
	}
	
	@Test
	public void testGetListWithTitle() {
		String title = "제주";
		Criteria cri = new Criteria();
		int regionNo = 1;
		mapper.getListWithTitle(title, regionNo, cri.getPageNum(), cri.getAmount());
	}
	
	@Test
	public void getTotalResultCnt() {
		String title = "제주";
		int regionNo = 1;
		Criteria cri = new Criteria();
		int totalCnt = mapper.getSearchResultTotalCnt(title,regionNo);
	}
}

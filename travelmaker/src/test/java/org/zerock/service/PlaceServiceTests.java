package org.zerock.service;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.travelmaker.domain.Criteria;
import org.travelmaker.service.PlaceService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class PlaceServiceTests {
	
	@Setter(onMethod_ = {@Autowired})
	private PlaceService service;
	
	@Test
	public void testExist() {
		log.info(service);
		assertNotNull(service);
	}
	
	@Test
	public void getTotal() {
		log.info(service.getSearchResultTotalCnt("제주",1));
	}
	
	@Test
	public void getListWithTitle() {
		log.info(service.getSearchResultTotalCnt("제주",1));
		Criteria cri = new Criteria(1,10);
		log.info(service.getList("제주",1, cri));
	}

}

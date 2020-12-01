package org.zerock.service;

import java.sql.Date;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.travelmaker.domain.ScheduleVO;
import org.travelmaker.service.ScheduleService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ScheduleServiceTests {
	
	@Setter(onMethod_ = {@Autowired})
	private ScheduleService service;
	
	
	@Test
	public void insertTests() {
		int memno = 11;
		ScheduleVO schVO = new ScheduleVO();
		schVO.setMemNo(memno);
		schVO.setMemo("hi");
		schVO.setImg("hhimg");
		schVO.setFromDate(new Date(0));
		schVO.setToDate(new Date(0));
		schVO.setSchLastDate(new Date(0));
		schVO.setSchRegDate(new Date(0));
		schVO.setSchTitle("service");
		schVO.setSchRegion("1");
		schVO.setSchStatus("미완성");
		System.out.println(schVO);
		service.register(schVO);
	}
	
}

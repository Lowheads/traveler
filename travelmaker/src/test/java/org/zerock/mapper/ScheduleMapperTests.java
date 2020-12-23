package org.zerock.mapper;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.travelmaker.domain.ScheduleVO;
import org.travelmaker.mapper.ScheduleMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ScheduleMapperTests {
	
	@Setter(onMethod_ =@Autowired)
	private ScheduleMapper mapper;
	
	@Test
	public void insertKeyTests() {
		ScheduleVO schVO = new ScheduleVO();
		schVO.setMemNo(11);
		schVO.setMemo("hi");
		schVO.setImg("hh.img");
		schVO.setFromDate(new Date(0));
		schVO.setToDate(new Date(0));
		schVO.setSchLastDate(new Date(0));
		schVO.setSchRegDate(new Date(0));
		schVO.setSchTitle("hello");
		schVO.setSchRegion("1");
		schVO.setSchStatus("미완성");
		mapper.insertSelectKey(schVO);
	}
	@Test
	public void insertTests() {
		int memno = 11;
		List list = new ArrayList<>();
		ScheduleVO schVO = new ScheduleVO();
		schVO.setMemNo(memno);
		schVO.setMemo("hi");
		schVO.setImg("hhimg");
		schVO.setFromDate(new Date(0));
		schVO.setToDate(new Date(0));
		schVO.setSchLastDate(new Date(0));
		schVO.setSchRegDate(new Date(0));
		schVO.setSchTitle("hello");
		schVO.setSchRegion("1");
		schVO.setSchStatus("미완성");
		list.add(schVO);
		//		mapper.insertSelectKey(schVO);
		System.out.println(mapper.insertSelectKey(schVO));;
		System.out.println(schVO.getSchNo());
	}
}

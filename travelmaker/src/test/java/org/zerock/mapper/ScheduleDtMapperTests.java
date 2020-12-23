package org.zerock.mapper;

import java.sql.Date;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.travelmaker.domain.SchdtVO;
import org.travelmaker.mapper.SchdtMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ScheduleDtMapperTests {
	
	@Setter(onMethod_= @Autowired)
	private SchdtMapper mapper;
	
	@Test
	public void insertSchdt() {
		Date d=  Date.valueOf("2004-06-22");
		SchdtVO schdtVO = new SchdtVO();
		schdtVO.setDistance(1);
		schdtVO.setDuration("이킬로메타");
		schdtVO.setFromPlc(5133393);
		schdtVO.setNum(2);
		schdtVO.setSchDate(d);
		schdtVO.setSchNo(37);
		schdtVO.setToPlc(5125523);
		schdtVO.setTransit("car");

		SchdtVO schdtVO2 = new SchdtVO();
		schdtVO2.setDistance(1);
		schdtVO2.setDuration("이킬로메타");
		schdtVO2.setFromPlc(5133393);
		schdtVO2.setNum(3);
		schdtVO2.setSchDate(d);
		schdtVO2.setSchNo(37);
		schdtVO2.setToPlc(5125523);
		schdtVO2.setTransit("car");
		SchdtVO[] array = {schdtVO,schdtVO2};
		mapper.insert(array);
//		mapper.insert(schdtVO);
	}
}

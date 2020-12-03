package org.zerock.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.travelmaker.domain.ScheduleDtVO;
import org.travelmaker.service.SchdtService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class SchDtServiceTests {
	
	@Setter(onMethod_ = {@Autowired})
	private SchdtService service;
	
	@Test
	public void setSchdtList() {
		ScheduleDtVO sch1 = new ScheduleDtVO();
		sch1.setDistance(1);
		sch1.setDuration("1");
		sch1.setFromPlcLat(10680320);
		sch1.setFromPlcLng(15295237);
		sch1.setToPlcLat(10587558);
		sch1.setToPlcLng(15259078);
		sch1.setFromPlcTitle("블루모모");
		sch1.setToPlcTitle("마세데카");
		sch1.setSchDate(1);
		sch1.setTransit("car");
		
		ScheduleDtVO[][] schdtVOs = {{sch1}};
		service.getInitSchWithDistAndDu(schdtVOs);
		
	}

}

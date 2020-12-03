package org.travelmaker.controller;

import java.text.SimpleDateFormat;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.travelmaker.domain.SchWrapDTO;
import org.travelmaker.domain.SchdtVO;
import org.travelmaker.domain.ScheduleVO;
import org.travelmaker.domain.TestVO;
import org.travelmaker.service.SchdtService;
import org.travelmaker.service.ScheduleService;
import org.travelmaker.service.TestService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RestController
@Log4j
@RequestMapping("/admin/*")
@AllArgsConstructor
public class TestController {

	private TestService service;
	private ScheduleService schService;
	private SchdtService schDtService;

	private static final Logger logger = LoggerFactory.getLogger(AdminMemberContorller.class);

	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(java.sql.Date.class, new CustomDateEditor(dateFormat, false));
	}

	@GetMapping("/registerTheme")
	public String themeTest() {

		System.out.println("register theme");

		return "registerTheme";
	}

	@GetMapping("/registerAction")
	public String acitonTest(TestVO t) {

		service.registerTheme(t);

		return "registerTheme";
	}
	
	@PostMapping(value = "/test/sch", produces = { MediaType.APPLICATION_JSON_UTF8_VALUE })
	@ResponseBody
	@Transactional(rollbackFor = Exception.class)
	public ResponseEntity<String> putInitSchedule(@RequestBody SchWrapDTO schwrapDTO) {
		ScheduleVO scheduleVO = schwrapDTO.getScheduleVO();
		SchdtVO[][] schdtVOs = schwrapDTO.getSchdtVOs();
			schService.register(scheduleVO);
			System.out.println(scheduleVO);
			System.out.println(scheduleVO.getSchNo());
			schDtService.setAll(scheduleVO.getSchNo(), schdtVOs);
			for (int i = 0; i < schdtVOs.length; i++) {
				schDtService.insertSchDt(schdtVOs[i]);
				System.out.println(schdtVOs[i][0].getSchNo());
		}
		return new ResponseEntity<>("success",HttpStatus.OK);
	}
	
	

}

package org.travelmaker.controller;

import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.travelmaker.domain.Criteria;
import org.travelmaker.domain.PagefDTO;
import org.travelmaker.domain.PlaceVO;
import org.travelmaker.domain.SchWrapDTO;
import org.travelmaker.domain.SchdtVO;
import org.travelmaker.domain.ScheduleDTO;
import org.travelmaker.domain.ScheduleDtVO;
import org.travelmaker.domain.ScheduleVO;
import org.travelmaker.service.PlaceService;
import org.travelmaker.service.SchdtService;
import org.travelmaker.service.ScheduleService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RequestMapping("/place/*")
@Controller
@Log4j
@AllArgsConstructor
@EnableAsync
public class PlaceController {
	private PlaceService service;
	private ScheduleService schService;
	private SchdtService schDtService;

	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(java.sql.Date.class, new CustomDateEditor(dateFormat, false));
	}

	@PostMapping(value = "/")
	public String main(@ModelAttribute("schDto") ScheduleDTO schDTO, @RequestParam("places") String[] plcNoArr,
			Model model) {
		List<PlaceVO> list = service.get(plcNoArr);
		model.addAttribute("places", list);
		return "/place/home";
	}

	@GetMapping(value = "/pages/{title}/{regionNo}/{pageNum}", produces = { MediaType.APPLICATION_XML_VALUE,
			MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<Map<String, Object>> getList(@PathVariable String title, @PathVariable int regionNo,
			@PathVariable int pageNum) {
		Criteria cri = new Criteria(pageNum, 10);
		PagefDTO pageMaker = new PagefDTO(cri, service.getSearchResultTotalCnt(title, regionNo));
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", service.getList(title, regionNo, cri));
		map.put("pageMaker", pageMaker);
		return new ResponseEntity<>(map, HttpStatus.OK);
	}

	@PostMapping(value = "/test", produces = "application/json;")
	@ResponseBody
	public ResponseEntity<String> getInitSchedule(@RequestBody ScheduleDtVO[][] scheduleDtVO) {
//		long start = System.currentTimeMillis(); //시작하는 시점 계산
//		List<CompletableFuture<Void>> futureList = schDtService.getInitSchWithDistAndDu(scheduleDtVO);
//		long end = System.currentTimeMillis(); //프로그램이 끝나는 시점 계산
//		System.out.println( "실행 시간 : " + ( end - start )/1000.0 +"초");
//		while(true) {
//			try {
//	            Thread.sleep(500);
//	            for (int i = 0; i < scheduleDtVO.length; i++) {
//	            	if(futureList.get(i).isDone()) {
//		            }
//	            	return new ResponseEntity<>(scheduleDtVO, HttpStatus.OK);
//				}
//	        } catch (InterruptedException e) {
//	            Thread.currentThread().interrupt();
//	        }
//		}
		return new ResponseEntity<>("success", HttpStatus.OK);
	}

//	@PostMapping(value="/test/sch",produces = {MediaType.APPLICATION_JSON_UTF8_VALUE})
//	@ResponseBody
//	@Transactional
//	public String putInitSchedule(@RequestBody ScheduleVO scheduleVO,@RequestBody SchdtVO[][] schdtVOsl) {
//		System.out.println(scheduleVO);
//		for (SchdtVO[] schdtVOs2 : schdtVOs) {
//			for (SchdtVO schdtVOs3 : schdtVOs2) {
//				System.out.println(schdtVOs3);
//			}
//		}
////		schService.register(scheduleVO);
//		//여기서 schDate를 설정을 해주거나 아니면 js 에서 넘길때 처리를 해줘야한다.
//		//ScheduleVO
//		schDtService.setAll(scheduleVO.getSchNo(), schdtVOs);
//		for (int i = 0; i < schdtVOs.length; i++) {
////			schDtService.insertSchDt(schdtVOs[i]);
//		}
//		return "/place/test";
//	}

	@PostMapping(value = "/put/sch", produces = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE })
	@ResponseBody
	public ResponseEntity<String> putInitSchedule(@RequestBody SchWrapDTO schwrapDTO) {
		ScheduleVO scheduleVO = schwrapDTO.getScheduleVO();
		SchdtVO[][] schdtVOs = schwrapDTO.getSchdtVOs();
			schService.register(scheduleVO);
			schDtService.setAll(scheduleVO.getSchNo(), schdtVOs);
			try {
				for (int i = 0; i < schdtVOs.length; i++) {
					schDtService.insertSchDt(schdtVOs[i]);
					// 에러 처리의 분기가 없다. 이거 좀 어떻게 해라
					// result =  ? : ;
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		return new ResponseEntity<>("/main/index",HttpStatus.OK);
	}

}

package org.travelmaker.service;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.CompletableFuture;

import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.stereotype.Service;
import org.travelmaker.domain.SchdtVO;
import org.travelmaker.domain.Schdt_PlaceVO;
import org.travelmaker.domain.ScheduleDtVO;
import org.travelmaker.mapper.SchdtMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;


@Log4j
@Service
@AllArgsConstructor
public class SchdtServiceImpl implements SchdtService {
	
	private SchdtMapper mapper;
	@Override
	public List<SchdtVO> getSchdt(int schNo) {
		log.info("getSchDt........"+schNo);
		return mapper.getSchdt(schNo);
	}
	
	@Override
	public List<Schdt_PlaceVO> getplacetitle(int schNo){
		log.info("getplacetitle......."+schNo);
		return mapper.getplacetitle(schNo);
	}
 
	@Override
	public int insertSchDt(SchdtVO[] schdtVOs) {
		for (int i = 0; i < schdtVOs.length; i++) {
			schdtVOs[i].setNum(i);
		}
		return mapper.insert(schdtVOs);
	}
  
	@Override
	public SchdtVO[][] setAll(int schNo, SchdtVO[][] schdtVOss) {
		for (SchdtVO[] schdtVOs : schdtVOss) {
			for (SchdtVO schdtVO : schdtVOs) {
				schdtVO.setSchNo(schNo);
			}
		}
		return schdtVOss;
	}

//	@Override
//	public List<CompletableFuture<Void>> getInitSchWithDistAndDu(ScheduleDtVO[][] schdtVOs) {
//		CompletableFuture<Void> future = null;
//		List<CompletableFuture<Void>> list = new ArrayList<>();
//		for (ScheduleDtVO[] scheduleDtVOs : schdtVOs) {
//			for (ScheduleDtVO scheduleDtVOs2 : scheduleDtVOs) {
//				System.out.println(Thread.currentThread());
//				// 여기서 caller 에 의해서 new Thread에 의해 실행제어;
//				list.add(tpes.setInitSchWithDistAndDu(scheduleDtVOs2));
//				
//			}
//		}
//			return list;
//	}
	
//	@Async
//	public void setInitSchWithDistAndDu(ScheduleDtVO schdtVO) {
//		// WebDriver 경로 설정
//        ChromeDriver driver = getDriver();
//        PositionVO pos = getKakaoGeoChanger(schdtVO);
//        String fromTitle = schdtVO.getFromPlcTitle();
//        int fromLat = pos.getFromLat();
//  		int fromLng = pos.getFromLng();
//  		String toTitle = schdtVO.getToPlcTitle();
//        int toLat = pos.getToLat();
//        int toLng = pos.getToLng();
//        String transit = schdtVO.getTransit();
//        //웹페이지에서 글제목 말고 query랑 그 document전체를 가져올 수 있는지 보자.
////      String URL = "https://map.kakao.com/link/from/지은이집,37.571210,126.976918/to/종운이형집,37.321590,127.126611"
//        //드라이버 로딩
////      String URL = "https://map.kakao.com/?map_type=TYPE_MAP&target="+car+"&rt="+schdtVO.getFromPlcLat()+","+schdtVO.getFromPlcLng()+","+schdtVO.getToPlcLat()+",";
//        String url = "https://map.kakao.com/?map_type=TYPE_MAP&target="+transit+"&rt="+fromLat+","+fromLng+","+toLat+","+toLng+"&rt1="+fromTitle+"&rt2="+toTitle+"&rtIds=%2C&rtTypes=%2C";
//        driver.get(url);
//        //selector로 지정하기
////      String parser = transit=="car"? "CarRouteSummaryView" : "traffic";
//        String parser = "CarRouteSummaryView";
//        WebElement page_summary = driver.findElementByClassName(parser);
//        if( page_summary != null  ) {
//            String text = page_summary.getText();
//            int timeIdx = text.indexOf("분")+1;
//            int distIdx = text.indexOf("m")+1;
//            String timeResult =  text.substring(0, timeIdx);
//            String distResult =	 text.substring(timeIdx+1, distIdx);
//            schdtVO.setDistance(distResult);
//            schdtVO.setDuration(timeResult);
//            System.out.println(timeResult); 
//            System.out.println(distResult);
//        }
//        // 탭 종료
//        driver.close();
//        try {
//            Thread.sleep(0);
//        } catch (InterruptedException e) {
//            e.printStackTrace();
//        } finally {
//            // WebDriver 종료
//            driver.quit();
//        }
//    }
//	
//	private ChromeDriver getDriver() {
//		System.setProperty("webdriver.chrome.driver", "C:\\WebDriver\\bin\\chromedriver.exe");
//        // WebDriver 옵션 설정 
//        ChromeOptions options = new ChromeOptions();
//        options.addArguments("--start-maximized");            // 전체화면으로 실행
//        options.addArguments("--disable-popup-blocking");    // 팝업 무시
//        options.addArguments("--disable-default-apps"); 
//        
//        options.addArguments("headless");
//        options.addArguments("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36\r\n");
//        // WebDriver 객체 생성
//        ChromeDriver driver = new ChromeDriver(options);
//		return driver;
//	}
//	
//	public PositionVO getKakaoGeoChanger(ScheduleDtVO schdtVO) {
//		double x1 = schdtVO.getFromPlcLat();
//		double y1 = schdtVO.getFromPlcLng();
//		double x2 = schdtVO.getToPlcLat();
//		double y2 = schdtVO.getToPlcLng();
//		PositionDTO pos1 = getPsuedoPosition(y1,x1);
//		PositionDTO pos2 = getPsuedoPosition(y2,x2);
//		return new PositionVO(pos1.getLat(),pos1.getLng(),pos2.getLat(),pos2.getLng());
//	}
//	
//	private PositionDTO getPsuedoPosition(double x, double y) {
//		
//		RestTemplate restTemplate = new RestTemplate(); 
//		HttpHeaders headers = new HttpHeaders(); 
//		headers.setContentType(MediaType.APPLICATION_JSON);//JSON 변환 header 정보설정
//		headers.set("Authorization", "KakaoAK aeef33528dba63fb6c8f964cf5103fb8"); //appKey 설정 
//		HttpEntity entity = new HttpEntity("parameters", headers); 
//		String urlStr = "https://dapi.kakao.com/v2/local/geo/transcoord.json?x="+x+"&y="+y+"&input_coord=WGS84&output_coord=WCONGNAMUL";
//		URI url=URI.create(urlStr); 
//		//x -> x좌표, y -> y좌표 
//
//		ResponseEntity<String> response= restTemplate.exchange(url, HttpMethod.GET, entity, String.class);
//		//String 타입으로 받아오면 JSON 객체 형식으로 넘어옴
//		JSONParser jsonParser = new JSONParser(); 
//		PositionVO posVO = null;
//		int px=0, py=0;
//		try {
//			JSONObject jsonObject = (JSONObject)jsonParser.parse(response.getBody().toString());
//			JSONArray positionInfoArray = (JSONArray) jsonObject.get("documents");
//			int len = positionInfoArray.size();
//			for (int i = 0; i < len; i++) {
//				JSONObject posObject = (JSONObject)positionInfoArray.get(i);
//				px = (int)(double)posObject.get("x");
//				py = (int)(double)posObject.get("y");
//			}
//		
//		} catch (ParseException e) {
//			e.printStackTrace();
//		}
//		return new PositionDTO(px,py);
//	}

}

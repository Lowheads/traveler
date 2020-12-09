package org.travelmaker.service;

import java.net.URI;
import java.util.concurrent.CompletableFuture;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.annotation.Async;
import org.springframework.web.client.RestTemplate;
import org.travelmaker.domain.PositionDTO;
import org.travelmaker.domain.PositionVO;
import org.travelmaker.domain.ScheduleDtVO;

import lombok.Data;

@Data
public class ThreadPoolExecutorService {
	
	
	@Async
	public CompletableFuture<Void> setInitSchWithDistAndDu(ScheduleDtVO schdtVO) {
		// WebDriver 경로 설정
		ChromeDriver driver = getDriver();
	    PositionVO pos = getKakaoGeoChanger(schdtVO);
	    String fromTitle = schdtVO.getFromPlcTitle();
	    int fromLat = pos.getFromLat();
			int fromLng = pos.getFromLng();
			String toTitle = schdtVO.getToPlcTitle();
	    int toLat = pos.getToLat();
	    int toLng = pos.getToLng();
	    String transit = schdtVO.getTransit();
	    //드라이버 로딩
	//  String URL = "https://map.kakao.com/?map_type=TYPE_MAP&target="+car+"&rt="+schdtVO.getFromPlcLat()+","+schdtVO.getFromPlcLng()+","+schdtVO.getToPlcLat()+",";
	    String url = "https://map.kakao.com/?map_type=TYPE_MAP&target="+transit+"&rt="+fromLat+","+fromLng+","+toLat+","+toLng+"&rt1="+fromTitle+"&rt2="+toTitle+"&rtIds=%2C&rtTypes=%2C";
	    driver.get(url);
	    //selector로 지정하기
	//  String parser = transit=="car"? "CarRouteSummaryView" : "traffic";
	    String parser = "CarRouteSummaryView";
	    WebElement page_summary = driver.findElementByClassName(parser);
	    if( page_summary != null  ) {
	        String text = page_summary.getText();
	        int timeIdx = text.indexOf("분")+1;
	        int distIdx = text.indexOf("m")+1;
	        String timeResult =  text.substring(0, timeIdx);
	        String distResult =	 text.substring(timeIdx+1, distIdx);
	        schdtVO.setDistance(distResult);
	        schdtVO.setDuration(timeResult);
	        System.out.println(schdtVO.getDistance());
	        System.out.println(schdtVO.getDuration());
	    }
	    // 탭 종료
	    driver.close();
	    
	    try {
	        Thread.sleep(0);
	    } catch (InterruptedException e) {
	        e.printStackTrace();
	    } finally {
	        // WebDriver 종료
	        driver.quit();
	    }
	    return null;
	}

	private ChromeDriver getDriver() {
		System.setProperty("webdriver.chrome.driver", "C:\\WebDriver\\bin\\chromedriver.exe");
	    // WebDriver 옵션 설정 
	    ChromeOptions options = new ChromeOptions();
	    options.addArguments("--start-maximized");            // 전체화면으로 실행
	    options.addArguments("--disable-popup-blocking");    // 팝업 무시
	    options.addArguments("--disable-default-apps"); 
	    
//	    options.addArguments("headless");
	    options.addArguments("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36\r\n");
	    // WebDriver 객체 생성
	    ChromeDriver driver = new ChromeDriver(options);
		return driver;
	}

	public PositionVO getKakaoGeoChanger(ScheduleDtVO schdtVO) {
		double x1 = schdtVO.getFromPlcLat();
		double y1 = schdtVO.getFromPlcLng();
		double x2 = schdtVO.getToPlcLat();
		double y2 = schdtVO.getToPlcLng();
		PositionDTO pos1 = getPsuedoPosition(y1,x1);
		PositionDTO pos2 = getPsuedoPosition(y2,x2);
		return new PositionVO(pos1.getLat(),pos1.getLng(),pos2.getLat(),pos2.getLng());
	}

	private PositionDTO getPsuedoPosition(double x, double y) {
		
		RestTemplate restTemplate = new RestTemplate(); 
		HttpHeaders headers = new HttpHeaders(); 
		headers.setContentType(MediaType.APPLICATION_JSON);//JSON 변환 header 정보설정
		headers.set("Authorization", "KakaoAK aeef33528dba63fb6c8f964cf5103fb8"); //appKey 설정 
		HttpEntity entity = new HttpEntity("parameters", headers); 
		String urlStr = "https://dapi.kakao.com/v2/local/geo/transcoord.json?x="+x+"&y="+y+"&input_coord=WGS84&output_coord=WCONGNAMUL";
		URI url=URI.create(urlStr); 
		//x -> x좌표, y -> y좌표 

		ResponseEntity<String> response= restTemplate.exchange(url, HttpMethod.GET, entity, String.class);
		//String 타입으로 받아오면 JSON 객체 형식으로 넘어옴
		JSONParser jsonParser = new JSONParser(); 
		int px=0, py=0;
		try {
			JSONObject jsonObject = (JSONObject)jsonParser.parse(response.getBody().toString());
			JSONArray positionInfoArray = (JSONArray) jsonObject.get("documents");
			int len = positionInfoArray.size();
			for (int i = 0; i < len; i++) {
				JSONObject posObject = (JSONObject)positionInfoArray.get(i);
				px = (int)(double)posObject.get("x");
				py = (int)(double)posObject.get("y");
			}
		
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return new PositionDTO(px,py);
	}

}

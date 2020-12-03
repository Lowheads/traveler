package org.travelmaker.service;

import java.util.List;

import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
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

	@Override
	public ScheduleDtVO[][] getInitSchWithDistAndDu(ScheduleDtVO[][] schdtVOs) {
		for (ScheduleDtVO[] scheduleDtVOs : schdtVOs) {
			for (ScheduleDtVO scheduleDtVOs2 : scheduleDtVOs) {
				setInitSchWithDistAndDu(scheduleDtVOs2);
			}
		}
		return schdtVOs;
	}
	
	public void setInitSchWithDistAndDu(ScheduleDtVO schdtVO) {
		// WebDriver 경로 설정
        System.setProperty("webdriver.chrome.driver", "C:\\WebDriver\\bin\\chromedriver.exe");
        // WebDriver 옵션 설정 
        ChromeOptions options = new ChromeOptions();
        options.addArguments("--start-maximized");            // 전체화면으로 실행
        options.addArguments("--disable-popup-blocking");    // 팝업 무시
        options.addArguments("--disable-default-apps"); 
        // 기본앱 사용안함
        options.addArguments("headless");
        options.addArguments("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36\r\n");
        // WebDriver 객체 생성
        ChromeDriver driver = new ChromeDriver(options);
        String fromTitle = schdtVO.getFromPlcTitle();
        int fromLat = schdtVO.getFromPlcLat();
  		int fromLng = schdtVO.getFromPlcLng();
  		String toTitle = schdtVO.getToPlcTitle();
        int toLat = schdtVO.getToPlcLat();
        int toLng = schdtVO.getToPlcLng();
        String transit = schdtVO.getTransit();
        //웹페이지에서 글제목 말고 query랑 그 document전체를 가져올 수 있는지 보자.
//        String URL = "https://map.kakao.com/link/from/지은이집,37.571210,126.976918/to/종운이형집,37.321590,127.126611"
        //드라이버 로딩
//        String URL = "https://map.kakao.com/?map_type=TYPE_MAP&target="+car+"&rt="+schdtVO.getFromPlcLat()+","+schdtVO.getFromPlcLng()+","+schdtVO.getToPlcLat()+",";
        String URL = "https://map.kakao.com/?map_type=TYPE_MAP&target=car&rt="+schdtVO.getFromPlcLat()+","+schdtVO.getFromPlcLng()+","+schdtVO.getToPlcLat()+",";
        driver.get("https://map.kakao.com/?map_type=TYPE_MAP&target=car&rt=494902%2C1131020%2C528056%2C1061777&rt1=1&rt2=21&rtIds=%2C&rtTypes=%2C");
        //selector로 지정하기
//        String parser = transit=="car"? "CarRouteSummaryView" : "traffic";
        String parser = "CarRouteSummaryView";
        WebElement page_summary = driver.findElementByClassName(parser);
        if( page_summary != null  ) {
            System.out.println(page_summary.getText() );            
        }
        // 탭 종료
        driver.close();
        
        // 5초 후에 WebDriver 종료
        try {
            Thread.sleep(10000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        } finally {
            // WebDriver 종료
            driver.quit();
        }
    }

}

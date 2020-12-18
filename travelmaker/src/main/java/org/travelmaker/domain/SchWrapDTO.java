package org.travelmaker.domain;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class SchWrapDTO {
	
	private ScheduleVO scheduleVO;
	private SchdtVO[][] schdtVOs;
//	private MultipartFile uploadFile;
}

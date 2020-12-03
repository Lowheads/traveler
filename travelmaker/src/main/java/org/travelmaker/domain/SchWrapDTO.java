package org.travelmaker.domain;
import lombok.Data;

@Data
public class SchWrapDTO {
	
	private ScheduleVO scheduleVO;
	private SchdtVO[][] schdtVOs;
}

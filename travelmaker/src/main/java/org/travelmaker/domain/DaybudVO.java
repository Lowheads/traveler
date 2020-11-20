package org.travelmaker.domain;

import java.sql.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class DaybudVO { // buddt 경비상세 
	
//	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date paydate;
	private Long schno;
	private String daypay;
	private Long daycnt;

}
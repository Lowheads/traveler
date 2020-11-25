package org.travelmaker.domain;

import java.sql.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class DaybudVO {
	
	private Date paydate;
	private Long schno;
	private String daypay;
	private Long daycnt;

}
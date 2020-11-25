package org.travelmaker.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class ScheduleVO {

	private int schNo;
	private int memNo;
	private String schTitle;
	private Date fromDate;
	private Date toDate;
	private String img;
	private Date schRegDate;
	private Date schLastDate;
	private String schStatus;
	private String memo;
	private String schRegion;
	
	private String hidden; //board와 조인한 hidden
	
}


package org.travelmaker.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
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


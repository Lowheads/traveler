package org.travelmaker.domain;

import java.sql.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class BudgetVO {
	
	private Long schno; 
	private String totalpay;
	private Long totalcnt;
	
	private String schtitle;
	private Date fromdate;
	private Date todate;

}
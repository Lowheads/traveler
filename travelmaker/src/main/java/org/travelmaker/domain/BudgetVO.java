package org.travelmaker.domain;

import java.sql.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class BudgetVO { // buddt 경비상세 
	
//	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Long schno; // 같아야함 1 
	private String totalpay;
	private Long totalcnt;

}
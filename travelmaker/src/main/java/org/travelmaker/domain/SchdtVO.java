package org.travelmaker.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class SchdtVO {

	private Date schDate;
	private int schNo;
	private int fromPlc;
	private int toPlc;
	private int distance;
	private String duration;
	private String transit;
	
}

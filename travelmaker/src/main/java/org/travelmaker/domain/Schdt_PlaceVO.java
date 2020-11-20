package org.travelmaker.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class Schdt_PlaceVO {

	private Date schDate;
	private int schNo;
	private String plcTitle;
	private String plcTitle1;
	private double distance;
	private String duration;
	private String transit;
}

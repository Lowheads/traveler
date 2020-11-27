package org.travelmaker.domain;


import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Data;

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class ScheduleDtVO {
	
	private int schDate;
	private int fromPlc;
	private int toPlc;
	private double fromPlcLat;
	private double fromPlcLng;
	private double toPlcLat;
	private double toPlcLng;
	private String fromPlcTitle;
	private String toPlcTitle;
	private String transit;
	private int distance;
	private String duration;
	private int schNo;
	
//	public ScheduleDtVO makeDistAndDu() {
//		
//	}
}

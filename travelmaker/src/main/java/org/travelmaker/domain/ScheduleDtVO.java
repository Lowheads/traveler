package org.travelmaker.domain;

import lombok.Data;

@Data
public class ScheduleDtVO {
	
	private int schDate;
	private double fromPlcLat;
	private double fromPlcLng;
	private double toPlcLat;
	private double toPlcLng;
	private String fromPlcTitle;
	private String toPlcTitle;
	private String transit;
	private String distance;
	private String duration;
	
}

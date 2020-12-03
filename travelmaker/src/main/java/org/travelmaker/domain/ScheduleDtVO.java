package org.travelmaker.domain;

import lombok.Data;

@Data
public class ScheduleDtVO {
	
	private int schDate;
	private int fromPlcLat;
	private int fromPlcLng;
	private int toPlcLat;
	private int toPlcLng;
	private String fromPlcTitle;
	private String toPlcTitle;
	private String transit;
	private int distance;
	private String duration;
	
}

package org.travelmaker.domain;

import lombok.Data;

@Data
public class PlaceVO {
	private long plcNo;
	private int regionNo;
	private String plcTitle;
	private double lat;
	private double lng;
	private String addressDt;
	private String pCate;
	private String holiday;
	private String openingH;
	private int likeCnt;
	
}

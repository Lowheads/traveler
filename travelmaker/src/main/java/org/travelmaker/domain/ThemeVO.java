package org.travelmaker.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ThemeVO {
	
	private int themeNo;
	private int regionNo;
	private int plcNo;
	private String themeCode;
	private Date modDate;
	private Date regDate;
//	private String img;
//	private String themeName;
	
	private ThemeAttachVO attachment;

}

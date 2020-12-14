package org.travelmaker.domain;

import lombok.Data;

@Data
public class ThemeAttachVO {
	
	private String fileName;
	private String uploadPath;
	private String uuid;
	private boolean image;

	private String fileType;
	
	private int themeNo;
}

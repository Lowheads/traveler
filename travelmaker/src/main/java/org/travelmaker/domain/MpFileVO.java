package org.travelmaker.domain;

import java.sql.Date;
import java.util.List;

import lombok.Data;

@Data
public class MpFileVO {

	private int fileNo;
	private int boardNo;
	private String orgFileName;
	private String storedFileName;
	private int fileSize;
	private Date regdate;
	private String delGb;
	private String fileContent;

}



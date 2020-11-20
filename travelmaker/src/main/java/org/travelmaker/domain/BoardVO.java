package org.travelmaker.domain;

import java.sql.Date;
import lombok.Data;

@Data
public class BoardVO {
	
	private int boardNo;
	private int schNo;
	private String boardTitle;
	private Date wDate;
	private int pickCnt;
	private Date modDate;
	private int vCnt;
	private String hidden;
	
	private String boardImg;
	private String thumbImg;
	
	

}

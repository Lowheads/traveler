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
	private String writer;  //schedule과 조인한 mem_no
	private String grade;   //member 테이블  member_grade
	
	private String boardImg;
	private String thumbImg;
	
	

}

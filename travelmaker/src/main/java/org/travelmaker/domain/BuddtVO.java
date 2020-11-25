package org.travelmaker.domain;

import java.sql.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class BuddtVO {
	
	private Long no;
	private Date paydate;
	private Long schno;
	private String store;
	private String expense;
	
	// get.jsp : 지출 그래프
	private String budcate;
	private Long catecnt;
	
	// register.jsp : 날짜 선택 제한
	private String maxDate;
	private String minDate;

	// modify.jsp : 읽기 전용 VO
	public BuddtVO() {};
	public BuddtVO (Long no,Date paydate,Long schno) {
		
		this.no = no;
		this.paydate = paydate;
		this.schno = schno;
		
	}
	
}
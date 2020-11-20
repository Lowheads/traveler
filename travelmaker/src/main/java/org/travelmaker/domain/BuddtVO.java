package org.travelmaker.domain;

import java.sql.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class BuddtVO { // bud_dt 경비상세 
	
	private Long no;
//	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date paydate;
	private Long schno;
	private String store;
	private String expense;
	private String budcate;
	private Long catecnt; 

	public BuddtVO() {};
	public BuddtVO (Long no,Date paydate,Long schno) {
		
		this.no = no;
		this.paydate = paydate;
		this.schno = schno;
	}
	
}
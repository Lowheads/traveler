package org.travelmaker.domain;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class SchdtVO {

	private Date schDate;
	private int schNo;
	private int fromPlc;
	private int toPlc;
	private String distance;
	private String duration;
	private String transit;
	private int num;
	
}

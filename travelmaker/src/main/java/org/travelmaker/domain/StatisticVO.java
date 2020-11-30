package org.travelmaker.domain;



import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class StatisticVO {
	
	private String targetDate;
	private String cntMember;
	private String cntPost;
	private String cntWithdrawalMember;

}

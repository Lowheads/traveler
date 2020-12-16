package org.travelmaker.domain;

import static org.springframework.test.web.client.match.MockRestRequestMatchers.queryParam;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class QnABoardCriteria {

	private int pageNum; 		// 페이지 번호
	private int amount;  		// 전체 페이지 목록
	private String type; 		// 검색 조건
	private String keyword;		// 검색어
	
	public QnABoardCriteria() {
		this(1, 18); // 페이지번호, 18개씩 출력
	}
	
	public QnABoardCriteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	
	// 검색 조건을 배열로 만들어서 처리하기 위한 배열 선언(T, W, C)
	public String[] getTypeArr() {
		return type == null ? new String[] {} : type.split("");
	}
	
	public String getListLink() {
		
		UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
		.queryParam("pageNum", this.pageNum)
		.queryParam("amount", this.getAmount())
		.queryParam("type", this.getType())
		.queryParam("keyword", this.getKeyword());
		
		return builder.toUriString();
	}
}

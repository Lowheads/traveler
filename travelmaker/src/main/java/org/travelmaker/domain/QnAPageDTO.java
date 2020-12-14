package org.travelmaker.domain;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class QnAPageDTO{
	
	private int startPage;
	private int endPage;
	private boolean prev, next; // 이전, 다음
	
	
	private int total;
	private QnABoardCriteria cri;
	
	public QnAPageDTO(QnABoardCriteria cri, int total) { 
		this.cri = cri;
		this.total = total;
		
		// endPage = cri.getPageNum()이 31이면 -> Math.ceil(3.1) * 10 = 40
		this.endPage = (int)(Math.ceil(cri.getPageNum() / 10.0)) * 10;
		
		this.startPage = this.endPage - 9;
		
		int realEnd = (int)(Math.ceil((total * 1.0) / cri.getAmount()));
		
		if(realEnd < this.endPage) {
			this.endPage = realEnd;
		}
		
		this.prev = this.startPage > 1;
		
		this.next = this.endPage < realEnd;
	}
}
package org.travelmaker.service;

import java.util.Date;
import java.util.List;

import org.travelmaker.domain.BuddtVO;
import org.travelmaker.domain.DaybudVO;

public interface BuddtService {
	
	//
	public BuddtVO getBuddt(int no);

	// get.jsp - 일정 지출 내역 : 날짜별 
	public List<BuddtVO> getBudgetListByDate(BuddtVO vo);

	// listAll.jsp - 선택된 일정 모든 지출 내역
	public List<BuddtVO> getBudgetListByAllDates(Long schno);

	// register.jsp - 지출 내역 등록
	public void register(BuddtVO buddt);
	
	// register.jsp - 셀렉트 박스 : 일정 선택
	public List<DaybudVO> setBoxBySch();
	
	// register.jsp - 날짜 선택 제한
	public BuddtVO setBoxByDate(Long schno);
	
	// modify.jsp - 수정
	public boolean modify(BuddtVO buddt);

	// modify.jsp - 읽기 전용 VO
	public BuddtVO loadVO(BuddtVO vo);
	
	// modify.jsp - 삭제
	public boolean remove(BuddtVO vo);
	
	// modify.jsp - 지출 빼기
	 public BuddtVO removeExpense(BuddtVO vo);
	
	//
	public List<BuddtVO> getDateBySchno(Long schno);
	
	// 일정명 얻기
	public BuddtVO getTitleBySchno(Long schno);
	
	// 그래프 - 8
	public int getExpenseByCafeWDate(BuddtVO vo);
	public int getExpenseByRestaurantWDate(BuddtVO vo);
	public int getExpenseByActivityWDate(BuddtVO vo);
	public int getExpenseByLodgingWDate(BuddtVO vo);
	public int getExpenseByTransWDate(BuddtVO vo);
	public int getExpenseByShoppingWDate(BuddtVO vo);
	public int getExpenseByEntertainmentWDate(BuddtVO vo);
	public int getExpenseByEtcWDate(BuddtVO vo);
	//
	public int getExpenseByCafe(Long schno);
	public int getExpenseByRestaurant(Long schno);
	public int getExpenseByActivity(Long schno);
	public int getExpenseByLodging(Long schno);
	public int getExpenseByTrans(Long schno);
	public int getExpenseByShopping(Long schno);
	public int getExpenseByEntertainment(Long schno);
	public int getExpenseByEtc(Long schno);
	//
	public BuddtVO getChartText(BuddtVO vo);
	//
	public BuddtVO getChartTextByListAll(Long schno);
	//
	public List<BuddtVO> getBudgetBySch(long schno);
	
}

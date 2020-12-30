package org.travelmaker.mapper;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Select;
import org.travelmaker.domain.BuddtVO;
import org.travelmaker.domain.DaybudVO;

public interface BuddtMapper {
	
	//
	public BuddtVO getBuddt(int no);
	
	// get.jsp - 해당 일정 지출 내역
	public List<BuddtVO> getBudgetListByDate(BuddtVO vo);

	// listAll.jsp - 해당 일정 모든 지출 내역
	public List<BuddtVO> getBudgetListByAllDates(long schno);
	
	// register.jsp - 등록
	public void insert(BuddtVO buddt);
	
	public void daypayUpdate(BuddtVO buddt);
	
	// register.jsp - 셀렉트 박스 : 일정 선택
	public List<DaybudVO> setBoxBySch();
	
	// register.jsp - 날짜 선택 제한
	public BuddtVO setBoxByDate(Long schno);
			
	// modify.jsp - 수정
	public int update(BuddtVO buddt);
	
	// modify.jsp - 페이징 + 읽기 전용 VO
	public BuddtVO loadVO(BuddtVO vo);
	
	// modify.jsp - 삭제
	public int delete(Long no);
	
	// list.jsp X
	public List<BuddtVO> getList();
	
	// get.jsp - 그래프 X
	public List<BuddtVO> cateCnt();
	
	public int removeExpense(BuddtVO vo);

//	public int modifyExpense(BuddtVO vo);
	public int modifyExpense(Long no);


	public int getTotalBudgetBySch(Long schno);

	// list 그래프
	public int getExpenseByCafeWDate(BuddtVO vo);
	public int getExpenseByRestaurantWDate(BuddtVO vo);
	public int getExpenseByActivityWDate(BuddtVO vo);
	public int getExpenseByLodgingWDate(BuddtVO vo);
	public int getExpenseByTransWDate(BuddtVO vo);
	public int getExpenseByShoppingWDate(BuddtVO vo);
	public int getExpenseByEntertainmentWDate(BuddtVO vo);
	public int getExpenseByEtcWDate(BuddtVO vo);
	
	// listAll 그래프
	public int getExpenseByCafe(Long schno);
	public int getExpenseByRestaurant(Long schno);
	public int getExpenseByActivity(Long schno);
	public int getExpenseByLodging(Long schno);
	public int getExpenseByTrans(Long schno);
	public int getExpenseByShopping(Long schno);
	public int getExpenseByEntertainment(Long schno);
	public int getExpenseByEtc(Long schno);

	public BuddtVO getChartText(BuddtVO vo);
	
 	public BuddtVO getChartTextByListAll(Long schno);
 	
 	public List<BuddtVO> getBudgetBySch(Long no);
 	
 	public List<BuddtVO> getDateBySchno(Long schno);
 	
 	public BuddtVO getTitleBySchno(Long schno);
 	
}
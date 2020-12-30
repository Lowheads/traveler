package org.travelmaker.service;

import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.travelmaker.domain.BuddtVO;
import org.travelmaker.domain.DaybudVO;
import org.travelmaker.mapper.BuddtMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class BuddtServiceImpl implements BuddtService {
	
	private BuddtMapper mapper;
	
	//
	public BuddtVO getBuddt(int no) {
		
		return mapper.getBuddt(no);
		
	}
	
	// get.jsp - 일정 지출 내역 : 날짜별
	@Override
	public List<BuddtVO> getBudgetListByDate(BuddtVO vo) {
		log.info("get......" + vo);
		return mapper.getBudgetListByDate(vo);
	}

	// listAll.jsp - 선택된 일정 모든 지출 내역
	@Override
	public List<BuddtVO> getBudgetListByAllDates(Long schno) {
		log.info("readAll......");
		return mapper.getBudgetListByAllDates(schno);
	}

	// register.jsp - 지출 내역 등록
	@Override
	public void register(BuddtVO buddt) {
		log.info("register......" + buddt);
		mapper.insert(buddt);
		mapper.daypayUpdate(buddt);
	}
	
	// register.jsp - 셀렉트 박스 : 일정 선택 ??????????????????????????????VO?
	@Override
	public List<DaybudVO> setBoxBySch() {
		return mapper.setBoxBySch();
	}
	
	// register.jsp - 날짜 선택 제한
	@Override
	public BuddtVO setBoxByDate(Long schno) {
		log.info("mmDate......");
		return mapper.setBoxByDate(schno);
	}	
	
	// modify.jsp - 수정
	@Override
	@Transactional
	public boolean modify(BuddtVO buddt){
		log.info("modify......" + buddt);
		int result = mapper.update(buddt);
		
		System.out.println("여기");
		System.out.println(buddt.getNo());
		
		mapper.modifyExpense(buddt.getNo()); // budget
		return result == 1; // bud_dt
	}
	
	// modify.jsp - 파라미터 + readonly VO
	@Override
	public BuddtVO loadVO(BuddtVO vo) {
		return mapper.loadVO(vo);
	}
	
	// modify.jsp - 삭제
	@Override
	@Transactional
	public boolean remove(BuddtVO vo) {
//		log.info("remove" + no);
		int result = mapper.delete(vo.getNo());
		
		mapper.removeExpense(vo);
		return result == 1;
	}

//	Test - 그래프
//	@Override
//	public List<BuddtVO> cateCnt() {
//		log.info("cateCnt......");
//		return mapper.cateCnt();
//	}	

	// 카테고리 8종
	@Override
	public int getExpenseByCafeWDate(BuddtVO vo) {
		try { return mapper.getExpenseByCafeWDate(vo); } 
		catch (Exception e) { return 0; }
	}

	@Override
	public int getExpenseByRestaurantWDate(BuddtVO vo) {
		try { return mapper.getExpenseByRestaurantWDate(vo); } 
		catch (Exception e) { return 0; }
	}

	@Override
	public int getExpenseByActivityWDate(BuddtVO vo) {
		try { return mapper.getExpenseByActivityWDate(vo); } 
		catch (Exception e) { return 0; }
	}

	@Override
	public int getExpenseByLodgingWDate(BuddtVO vo) {
		try { return mapper.getExpenseByLodgingWDate(vo); } 
		catch (Exception e) { return 0; }
	}

	@Override
	public int getExpenseByTransWDate(BuddtVO vo) {
		try { return mapper.getExpenseByTransWDate(vo); } 
		catch (Exception e) { return 0; }
	}

	@Override
	public int getExpenseByShoppingWDate(BuddtVO vo) {
		try { return mapper.getExpenseByShoppingWDate(vo); } 
		catch (Exception e) { return 0; }
	}

	@Override
	public int getExpenseByEntertainmentWDate(BuddtVO vo) {
		try { return mapper.getExpenseByEntertainmentWDate(vo); } 
		catch (Exception e) { return 0; }
	}

	@Override
	public int getExpenseByEtcWDate(BuddtVO vo) {
		try { return mapper.getExpenseByEtcWDate(vo); } 
		catch (Exception e) { return 0; }
	}

	@Override
	public BuddtVO getChartText(BuddtVO vo) {
		return mapper.getChartText(vo);
	}
	
	// 카테고리 8종
	@Override
	public int getExpenseByCafe(Long schno) {
		try { return mapper.getExpenseByCafe(schno); } 
		catch (Exception e) { return 0; }
	}

	@Override
	public int getExpenseByRestaurant(Long schno) {
		try { return mapper.getExpenseByRestaurant(schno); } 
		catch (Exception e) { return 0; }
	}

	@Override
	public int getExpenseByActivity(Long schno) {
		try { return mapper.getExpenseByActivity(schno); } 
		catch (Exception e) { return 0; }
	}

	@Override
	public int getExpenseByLodging(Long schno) {
		try { return mapper.getExpenseByLodging(schno); } 
		catch (Exception e) { return 0; }
	}

	@Override
	public int getExpenseByTrans(Long schno) {
		try { return mapper.getExpenseByTrans(schno); } 
		catch (Exception e) { return 0; }
	}

	@Override
	public int getExpenseByShopping(Long schno) {
		try { return mapper.getExpenseByShopping(schno); } 
		catch (Exception e) { return 0; }
	}

	@Override
	public int getExpenseByEntertainment(Long schno) {
		try { return mapper.getExpenseByEntertainment(schno); } 
		catch (Exception e) { return 0; }
	}

	@Override
	public int getExpenseByEtc(Long schno) {
		try { return mapper.getExpenseByEtc(schno); } 
		catch (Exception e) { return 0; }
	}
	
	@Override
	public BuddtVO getChartTextByListAll(Long schno) {
		return mapper.getChartTextByListAll(schno);
	}
	
	@Override
	public List<BuddtVO> getBudgetBySch(long schno) {
		return mapper.getBudgetBySch(schno);
	}

	@Override
	public BuddtVO removeExpense(BuddtVO vo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<BuddtVO> getDateBySchno(Long schno) {
		return mapper.getDateBySchno(schno);
	}

	@Override
	public BuddtVO getTitleBySchno(Long schno) {		
		return mapper.getTitleBySchno(schno);
	}
}

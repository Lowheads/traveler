//package org.zerock.mapper;
//
//import java.util.List;
//
//import org.junit.Test;
//import org.junit.runner.RunWith;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.test.context.ContextConfiguration;
//import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
//import org.travelmaker.domain.BoardVO;
//import org.travelmaker.domain.Criteria;
//import org.travelmaker.mapper.BoardMapper;
//import org.travelmaker.mapper.BoarddtMapper;
//
//import lombok.Setter;
//import lombok.extern.log4j.Log4j;
//
//@RunWith(SpringJUnit4ClassRunner.class)
//@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
//@Log4j
//public class BoardMapperTests{
//	@Setter(onMethod_ =@Autowired)
//	private BoardMapper mapper;
//	private BoarddtMapper mapper2;
//	
//	java.sql.Date date = new java.sql.Date(0000-00-00);
//	
//	@Test
//	public void testGetList() {
//		mapper.getList().forEach(board -> log.info(board));
//	}
//	
//	 @Test
//	   public void testInsert() {
//	      BoardVO board = new BoardVO();
//	      board.setSchNo(1001L);
//	      board.setBoardTitle("�ܿ￩��22");
//	      board.setWDate(date.valueOf("2020-11-03"));
//	      board.setPickCnt(3L);
//	      board.setModDate(date.valueOf("2020-11-05"));
//	      board.setVCnt(10L);
//	      board.setHidden("����");
//	      
//	      mapper.insert(board);
//	      log.info(board);
//	      
//	   }
//	 
//	 @Test
//	 public void testInsertSelectKey() {
//		 
//		 BoardVO board = new BoardVO();
//		 board.setSchNo(1001L);
//		 board.setBoardTitle("�ܿ￩��33");
//		 board.setWDate(date.valueOf("2020-11-04"));
//		 board.setPickCnt(5L);
//		 board.setModDate(date.valueOf("2020-11-05"));
//		 board.setVCnt(5L);
//		 board.setHidden("�����");
//		 
//		 mapper.insertSelectKey(board);
//		 log.info(board);
//	 }
//	 
//	 @Test
//	 public void testRead() {
//		 BoardVO board = mapper.read(4L);
//		 
//		 log.info(board);
//	 }
//	 
//	 @Test
//	 public void testDelete() {
//		 log.info("DELETE COUNT: "+ mapper.delete(3L));
//	 }
//	 
//	 @Test
//	 public void testUpdate() {
//		 BoardVO board = new BoardVO();
//		 board.setBoardNo(1L);
//		 board.setSchNo(1001L);
//	     board.setBoardTitle("�����ܿ￩��");
//	     board.setWDate(date.valueOf("2020-11-03"));
//	     board.setPickCnt(3L);
//	     board.setModDate(date.valueOf("2020-11-05"));
//	     board.setVCnt(10L);
//	     board.setHidden("����");
//	      
//	      int count = mapper.update(board);
//	      log.info("UPDATE COUNT: "+count);
//	 }
//	 
//	 @Test
//	 public void testDelete2() {
//		 mapper2.delete(45L);
//		 mapper.delete(45L);
//	 }
//	 
//	 @Test
//	 public void testregi() {
//		 BoardVO board= new BoardVO();
//		 board.setSchNo(1001L);
//		 board.setBoardTitle("�󼼻󼼼�");
//		 board.setHidden("y");
//		 
//		 mapper.insert(board);
//		 
//		 BoardVO newboard= new BoardVO();
//		 mapper.readbytitle(board.getBoardTitle());
//		 System.out.println(newboard.getBoardTitle());
//	 }
//	 
//	 @Test
//	 public void testPaging() {
//		 Criteria cri = new Criteria();
//		 cri.setPageNum(3);
//		 cri.setAmount(10);
//		 List<BoardVO> list = mapper.getListWithPaging(cri);
//		 list.forEach(board -> log.info(board.getBoardNo()));
//	 }
//
//}

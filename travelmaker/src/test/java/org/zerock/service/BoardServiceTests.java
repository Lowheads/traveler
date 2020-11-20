//package org.zerock.service;
//
//import static org.junit.Assert.assertNotNull;
//
//import java.sql.Date;
//
//import org.junit.Test;
//import org.junit.runner.RunWith;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.test.context.ContextConfiguration;
//import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
//import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
//import org.travelmaker.domain.BoardVO;
//import org.travelmaker.service.BoardService;
//
//import lombok.Setter;
//import lombok.extern.log4j.Log4j;
//
//@RunWith(SpringJUnit4ClassRunner.class)
//@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
//@Log4j
//public class BoardServiceTests {
//
//	java.sql.Date date = new java.sql.Date(0000-00-00);
//	
//	@Setter(onMethod_ = {@Autowired})
//	private BoardService service;
//	
//	@Test
//	public void testExist() {
//		log.info(service);
//		assertNotNull(service);
//	}
//	
//	@Test
//	public void testRegister() {
//		BoardVO  board = new BoardVO();
//		board.setSchNo(1001L);
//		board.setBoardTitle("�����ۼ�");
//		board.setWDate(date.valueOf("2020-11-03"));
//		board.setPickCnt(4L);
//		board.setModDate(date.valueOf("2020-11-05"));
//		board.setVCnt(20L);
//		board.setHidden("�����");
//		
//		service.register(board);
//		log.info("������ �Խù��� ��ȣ:" + board.getBoardNo());
//	}
//	
//	@Test
//	public void testGetList() {
//		service.getList().forEach(board->log.info(board));
//		
//	}
//	
//	@Test
//	public void testGet() {
//		log.info(service.get(1L));
//	}
//	
//	@Test
//	public void testDelete() {
//		log.info("REMOVE RESULT: "+service.remove(1L));
//	}
//	
//	@Test
//	public void testUpdate() {
//		BoardVO board = service.get(1L);
//		
//		if(board==null) return;
//		
//		board.setBoardTitle("���� ����.");
//		log.info("MODIFY RESULT:  "+service.modify(board));
//		
//	}
//	
//	@Test
//	public void testboarddt() {
//		
//		//�Τ�Ʈ
//		BoardVO board = new BoardVO();
//		board.setSchNo(1001L);
//		board.setBoardTitle("�ȴ�");
//		board.setHidden("y");
//		
//		service.register(board);
//		
////		
////		BoardVO newboard=new BoardVO();
////		newboard=service.get(board.getBoard_no());
////		System.out.println();
//		System.out.println(service.get(1001L));
//		
//		
//	}
//	
//}

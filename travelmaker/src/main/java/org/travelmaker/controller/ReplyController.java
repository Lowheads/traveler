package org.travelmaker.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.travelmaker.domain.QnABoardCriteria;
import org.travelmaker.domain.ReplyPageDTO;
import org.travelmaker.domain.ReplyVO;
import org.travelmaker.service.ReplyService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RequestMapping("/replies/*")
@RestController
@Log4j
public class ReplyController {

	private final ReplyService service;
	
	public ReplyController(ReplyService replySevice) {
		this.service = replySevice;
	}
	
	// 댓글 등록
	@PostMapping(value = "/new", consumes = "application/json", produces = "application/text; charset=utf8")
	public ResponseEntity<String> create(@RequestBody ReplyVO vo){
		log.info("ReplyVO : " + vo);
		
		// 댓글 등록(1이면 성공, 0이면 실패)
		int insertCnt = service.register(vo);
		
		log.info("Reply INSERT CNT(1(성공), 0(실패) : " + insertCnt);
		 
		// 성공이면 OK, 실패하면 SERVER ERROR
		return insertCnt == 1 ? new ResponseEntity<String>("댓글을 등록하였습니다.", HttpStatus.OK) : new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	// 댓글 목록 조회
	@GetMapping(value="/pages/{bno}/{page}", produces = {MediaType.APPLICATION_ATOM_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<ReplyPageDTO> getList(@PathVariable("page") int page, @PathVariable("bno") int bno){
		
		QnABoardCriteria cri = new QnABoardCriteria(page, 10); // 댓글 페이지당 10개씩 출력
		log.info("조회하는 게시글의 번호는 : " + bno);
		log.info("댓글 페이지 : " + cri);
		
		return new ResponseEntity<>(service.getListPage(cri, bno), HttpStatus.OK); 
	}
	
	// 댓글 조회
	@GetMapping(value="/{rno}", produces = {MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<ReplyVO> get(@PathVariable("rno") int rno){
		log.info("get : " + rno);
		
		return new ResponseEntity<ReplyVO>(service.get(rno), HttpStatus.OK);
	}
	
	// 댓글 삭제
	@DeleteMapping(value="/{rno}", produces = "application/text; charset=utf8")
	public ResponseEntity<String> remove(@PathVariable("rno") int rno){
		log.info("삭제합니다 : " + rno);
		
		// 삭제 성공하면 메세지와 함께 200, 실패하면 500
		return service.remove(rno) == 1 ? new ResponseEntity<String>("댓글을 삭제하였습니다.", HttpStatus.OK)
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	// 댓글 수정
	@RequestMapping(value = "/{rno}",  method = {RequestMethod.PUT, RequestMethod.PATCH}, 
			consumes = "application/json", produces = "application/text; charset=utf8")
	public ResponseEntity<String> modify(@RequestBody ReplyVO vo, @PathVariable("rno") int rno){
		vo.setBno(rno);
		log.info("rno : " + rno);
		log.info("modify : " + vo);
		
		return service.modify(vo) == 1 ? new ResponseEntity<String>("댓글을 수정하였습니다.", HttpStatus.OK)
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
}

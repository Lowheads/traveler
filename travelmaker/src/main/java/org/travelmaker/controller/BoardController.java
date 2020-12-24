package org.travelmaker.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.travelmaker.domain.BoardVO;
import org.travelmaker.domain.BoarddtVO;
import org.travelmaker.domain.Criteria;
import org.travelmaker.domain.MpFileVO;
import org.travelmaker.domain.PageDTO;
import org.travelmaker.domain.PickVO;
import org.travelmaker.domain.Schdt_PlaceVO;
import org.travelmaker.domain.ScheduleVO;
import org.travelmaker.service.BoardService;
import org.travelmaker.service.BoarddtService;
import org.travelmaker.service.PickService;
import org.travelmaker.service.SchdtService;
import org.travelmaker.service.ScheduleService;
import org.travelmaker.utils.UploadFileUtils;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board/*")
@AllArgsConstructor
public class BoardController {

	//빈의 이름을 검색해서 주입할 객체 설정
	@Resource(name="uploadPath")
	private String uploadPath;
	
	private BoardService boardservice;
	
	private ScheduleService scheduleservice;
	
	private SchdtService schdtservice;
	
	private BoarddtService boarddtservice;
	
	private PickService pickService;

	//날씨 페이지 확인
	@GetMapping("/weather2")
	public void weather() {
		
	}
	

	@GetMapping("/list")
	public void list(Criteria cri, Model model,  HttpServletRequest request) {

		cri.setAmount(12);
		model.addAttribute("list",boardservice.getList(cri));
		int total= boardservice.getTotal(cri);
		model.addAttribute("pageMaker",new PageDTO(cri, total));
	}
	
	//schedulelist
	@GetMapping("/schedulelist")
	public void schedulelist(Model model,HttpServletRequest request) {

		HttpSession session = request.getSession();
		int memNo = Integer.parseInt(String.valueOf(session.getAttribute("memNo")));
		System.out.println(memNo);

		model.addAttribute("schedulelist",scheduleservice.getList(memNo));
	}
	
	//hiddenlist
	@GetMapping("/hiddenlist")
	public void hiddencheck(Model model, HttpServletRequest request) {
		HttpSession session = request.getSession();
		int memNo = Integer.parseInt(String.valueOf(session.getAttribute("memNo")));
		List<Map<String,Object>> hiddenList = scheduleservice.getHiddenList(memNo);
		model.addAttribute("hiddenlist",hiddenList);
	}
	
	
	@GetMapping("/register")
	public void register(@RequestParam("schNo")int schNo,Model model) {
		model.addAttribute("schNo",schNo);
			
	}
	
	@PostMapping("/register")
	public String register(BoardVO board, MultipartFile file, Model model) throws Exception {
		log.info("register: "+board);

		//파일처리 관련 코드
		String imgUploadPath = uploadPath + File.separator + "imgUpload";
		String ymdPath =UploadFileUtils.calcPath(imgUploadPath);
		String fileName = null;

		
		if (file != null) {
			fileName = UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath);
		} else {
			fileName = uploadPath + File.separator + "images" + File.separator + "none.png";
		}

		board.setBoardImg(File.separator + "imgUpload" + ymdPath + File.separator + fileName);
		board.setThumbImg(
				File.separator + "imgUpload" + ymdPath + File.separator + "s" + File.separator + "s_" + fileName);
		System.out.println(board.getBoardImg()+","+board.getThumbImg());
		
		model.addAttribute("board",board);
		
		
		
		boardservice.register(board);
		
		//스케쥴 상태 '미작성' -> '작성중' 으로 변경
		scheduleservice.statusupdate(board.getSchNo());

		return "redirect:/board/dtregister?schNo="+board.getSchNo();
	}
	
	
	@ResponseBody
	@RequestMapping(value= "/hidden", method=RequestMethod.POST, produces="application/json")
	public void hidden(BoardVO board) {
		System.out.println(board);
		
		boardservice.updateHidden(board);

	}
	
	
	@GetMapping("/dtregister")
	public void dtregister(BoardVO board,Model model) throws UnsupportedEncodingException {
		
		board=boardservice.getbySchNo(board);
		int schNo= board.getSchNo();
		
		
		model.addAttribute("schedule",scheduleservice.getSchedule(schNo));
		model.addAttribute("Schdt",schdtservice.getSchdtList(schNo));
		
		model.addAttribute("board",board);
		
	}
	
	@PostMapping("/dtregister")
	public String dtregister(BoarddtVO boarddt,RedirectAttributes rttr, MultipartHttpServletRequest mpRequest, @RequestParam(value="newContent", required=false) List<String> newContent) throws Exception{
		log.info("dtregister: "+boarddt);	
		
		BoardVO board= new BoardVO();
		board=boardservice.get(boarddt.getBoardNo());
		
		boarddtservice.write(boarddt, mpRequest,newContent);
		
		//작성중에서 작성으로
		scheduleservice.statusupdate(board.getSchNo());
		
		rttr.addFlashAttribute("registermsg","게시글이 등록되었습니다.");
		return "redirect:/board/list";
	}
	
	
	
	@GetMapping({"/modify"})
	public void modify(@RequestParam("boardNo")int boardNo, @ModelAttribute("cri") Criteria cri, Model model) {
	
		log.info("/modify");
		
		model.addAttribute("board",boardservice.get(boardNo));
	
	}
	
	
	@GetMapping({"/get"})
	public void get(@RequestParam("boardNo")int boardNo, 
			@ModelAttribute("cri") Criteria cri, Model model, HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		int memNo = Integer.parseInt(String.valueOf(session.getAttribute("memNo")));
		
		BoardVO board=boardservice.get(boardNo);
		int schNo=board.getSchNo();
		ScheduleVO schedule = scheduleservice.getSchedule(schNo);
		schedule.setMemNo(memNo);
		
		//pickSCH 테이블에 일정번호 있는지 체크
		if(scheduleservice.checkPick(schedule)) {
			model.addAttribute("pick","picked");
		}
		else {
			model.addAttribute("pick","unpicked");
		}
		
		model.addAttribute("schedule",scheduleservice.getListSchedule(schNo));
		model.addAttribute("boarddt",boarddtservice.get(boardNo));
		model.addAttribute("board",board);
		
		List<Map<String,Object>> fileList = boarddtservice.selectFileList(boardNo);
		
		model.addAttribute("file",fileList);
		
		//model.addAttribute("memNo",memNo);
	
		model.addAttribute("Schdt",schdtservice.getSchdtList(schNo));
	}
	
	
	@GetMapping({"/view"})
	public void view(@RequestParam("boardNo")int boardNo, 
			@ModelAttribute("cri") Criteria cri, Model model, HttpServletRequest request) throws Exception {
		BoardVO board=boardservice.get(boardNo);
		int schNo=board.getSchNo();
		model.addAttribute("schedule",scheduleservice.getListSchedule(schNo));
		model.addAttribute("boarddt",boarddtservice.get(boardNo));
		model.addAttribute("board",board);
		
		List<Map<String,Object>> fileList = boarddtservice.selectFileList(boardNo);
		
		model.addAttribute("file",fileList);
	
		model.addAttribute("Schdt",schdtservice.getSchdtList(schNo));
	}
	
	
	@PostMapping("/modify")
	public String modify(BoardVO board, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr,MultipartFile file) throws Exception {
		log.info("modify:"+board);
		//파일처리 관련 코드
		String imgUploadPath = uploadPath + File.separator + "imgUpload";
		String ymdPath =UploadFileUtils.calcPath(imgUploadPath);
		String fileName = null;
		
		if (file != null) {
			fileName = UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath);
			board.setBoardImg(File.separator + "imgUpload" + ymdPath + File.separator + fileName);
		} else {
			fileName = board.getBoardImg();
			board.setBoardImg(fileName);
		}

		board.setThumbImg(
				File.separator + "imgUpload" + ymdPath + File.separator + "s" + File.separator + "s_" + fileName);
		System.out.println(board.getBoardImg()+","+board.getThumbImg());
		
		if(boardservice.modify(board)) {
			rttr.addFlashAttribute("modifymsg","대표사진이 변경되었습니다.");
			
			rttr.addAttribute("pageNum",cri.getPageNum());
			rttr.addAttribute("amount",cri.getAmount());
		}
		return "redirect:/board/get?boardNo="+board.getBoardNo();
	}
	
	
	@PostMapping("/remove")
	public String remove(@RequestParam("boardNo") int boardNo, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr, HttpSession session) {
		log.info("remove..."+boardNo);
		
		BoardVO board= boardservice.get(boardNo);
		int schNo=board.getSchNo();
		ScheduleVO schedule=scheduleservice.getSchedule(schNo);
		
		int memNo = Integer.parseInt(String.valueOf(session.getAttribute("memNo")));
		PickVO pick= new PickVO();
		pick.setMemNo(memNo);
		pick.setSchNo(schNo);

	    
		//게시물 상세부터 remove
		boarddtservice.remove(boardNo);
		if(boardservice.remove(boardNo)) {

			
			//게시물 상태 '작성' -> '미작성' 으로 변경
			schedule.setSchStatus("BS001");
			scheduleservice.statusupdate(schNo);
			
			//게시글 삭제할 때, 해당 게시글 좋아요 취소
			pickService.remove(pick);
			System.out.println("delete"+pick);
			
			rttr.addFlashAttribute("removemsg","게시글이 삭제되었습니다.");
		}
		rttr.addAttribute("pageNum",cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		
		return "redirect:/board/list";
	}
	
	//파일 다운로드
	@ResponseBody
	@RequestMapping(value="/fileDown")
	public void fileDown(@RequestParam Map<String, Object> map, HttpServletResponse response) throws Exception{
		Map<String, Object> resultMap = boarddtservice.selectFileInfo(map);
		System.out.println(resultMap);
		String storedFileName = (String) resultMap.get("STORED_FILE_NAME");
		String originalFileName = (String) resultMap.get("ORG_FILE_NAME");
		
		// 파일을 저장했던 위치에서 첨부파일을 읽어 byte[]형식으로 변환한다.
		byte fileByte[] = org.apache.commons.io.FileUtils.readFileToByteArray(new File("C:\\upload\\file\\"+storedFileName));
		
		response.setContentType("application/octet-stream");
		response.setContentLength(fileByte.length);
		response.setHeader("Content-Disposition",  "attachment; fileName=\""+URLEncoder.encode(originalFileName, "UTF-8")+"\";");
		response.getOutputStream().write(fileByte);
		response.getOutputStream().flush();
		response.getOutputStream().close();
		
	}
	
	//dtmodify 폼
	@GetMapping(value="/dtmodify")
	public void dtmodify(@RequestParam("boardNo")int boardNo, @ModelAttribute("cri") Criteria cri, Model model, RedirectAttributes rttr) throws Exception {
		log.info("dtmodify");

		BoardVO board = boardservice.get(boardNo);
		int schNo= board.getSchNo();
		
		model.addAttribute("boarddt",boarddtservice.get(boardNo));
		model.addAttribute("board",board);
		
		model.addAttribute("schedule",scheduleservice.getSchedule(schNo));
		model.addAttribute("Schdt",schdtservice.getSchdtList(schNo));
		List<Map<String, Object>> fileList = boarddtservice.selectFileList(boardNo);
		
		model.addAttribute("file",fileList);


	}
	
	
	
	//dt modify
	@PostMapping(value="/dtmodify")
	public String update(BoarddtVO boarddt,@ModelAttribute("cri") Criteria cri, RedirectAttributes rttr,
			@RequestParam(required = false, value="fileNoDel[]") String[] files, @RequestParam(required = false, value="fileNameDel[]") String[] fileNames, @RequestParam(required = false, value="newContent") List<String> newContent
			,@RequestParam(required = false, value="fileContent") List<String> fileContent, @RequestParam(required = false, value="fileNo") List<Integer> fileNo, MultipartHttpServletRequest mpRequest) throws Exception{
		log.info("update dtmodify");

		//내용만 수정된 메소드 만들기
		boarddtservice.updateContent(fileNo,fileContent);

		//새로운 콘텐츠가 있을 때만 실행
		boarddtservice.update(boarddt, files, fileNames, mpRequest, newContent);
		rttr.addFlashAttribute("dtmodifymsg","게시글이 수정되었습니다.");
		rttr.addAttribute("pageNum",cri.getPageNum());
		rttr.addAttribute("amount",cri.getAmount());
		
		return "redirect:/board/get?boardNo="+boarddt.getBoardNo();
	}
	
		//좋아요 취소
	   @ResponseBody
	   @RequestMapping(value = "/deletePick", method = RequestMethod.POST, produces = "application/json")
	   public void deletePickPlace(HttpSession session,PickVO pick) throws Exception {
	      int memNo = Integer.parseInt(String.valueOf(session.getAttribute("memNo")));
	      pick.setMemNo(memNo);
	      System.out.println("delete"+pick);
	      pickService.remove(pick);
	   }
	   
	   //좋아요 추가
	   @ResponseBody
	   @RequestMapping(value = "/insertPick", method = RequestMethod.POST, produces = "application/json")
	   public void insertPickPlace(HttpSession session,PickVO pick) throws Exception {
	      int memNo = Integer.parseInt(String.valueOf(session.getAttribute("memNo")));
	      pick.setMemNo(memNo);
	      System.out.println("insert"+pick);
	      pickService.register(pick);
	   }
	
}

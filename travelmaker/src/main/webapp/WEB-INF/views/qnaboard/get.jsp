<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ include file="../includes/header.jsp" %>

<!-- URL 직접접근 막기 -->
<%
	String strReferer = request.getHeader("referer");
	
		if (strReferer == null) {
		%>
		<script>
			/* swal("비정상 접근", "URL 주소창에 주소를 직접 입력해서 접근하셨습니다.\n\n정상적인 경로를 통해 다시 접근해 주십시오.", "warning"); */
			history.go(-1);
		</script>
		<%
			return;
		}
%>


<link rel="stylesheet" href="/resources/css/qnaboard/common.css">
<link rel="stylesheet" href="/resources/css/qnaboard/register.css">
<link rel="stylesheet" href="/resources/css/qnaboard/get.css">

<!-- 페이징 처리 -->
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">


<div class="full-wrap">
<div class="wrapper">
       
        <div class="contents">
        
            <div class="ct_body">
            				 <div class="header_wrapper">
            <div class="title-head">
	        	<h4>Q&A 게시글 조회</h4>
	        </div>
        </div>
            				<div class="form-group" style="margin-bottom: 1%;">
            					<img alt="eye" src="/resources/img/eye.png" width="18px" height="18px">
            					 : ${board.viewCnt }
            				</div>
            					
                        	<div class="form-group">
                        		<label>제목</label> 
                        		<input style="background-color: white;" class="form-control" name="title"
                        		value='<c:out value="${board.title}" />' readonly="readonly">
                        	</div>
                        	
                        	<div class="form-group">
                        		<label>작성자</label>
                        		<input style="background-color: white;" class="form-control" name='nickname' 
                        		id="boardNickname" value='<c:out value="${board.nickname }"/>' readonly="readonly">
                			</div>
                			
                			<div class="form-group">
                        		<label>작성일</label>
                        		<input style="background-color: white;" class="form-control" name='regDate'
                        		value='<fmt:formatDate value="${board.regDate}" pattern="yyyy-MM-dd (E)"/>' readonly="readonly">
                			</div>
                        	
                        	<div class="form-group">
                        		<label>내용</label>
                        	    <textarea style="background-color: white; resize: none;" class="form-control" 
                        	    rows="3" name='content' readonly="readonly"><c:out value="${board.content}" /></textarea>
                        	</div>
                        	
            <div class="getBtn-wrap" style="text-align: right;">
                <c:if test="${board.memNo == loginMemNo || myGrade == 'MG002' }">	
            	<button data-oper='modify' class="reg-btn">수정하기</button>
            	</c:if>
				<button data-oper='list' class="list-btn">목록</button>
            </div>
				
				<form id='operForm' action="/qnaboard/modify" method="get">
					<input type='hidden' id='bno' name='bno' value='<c:out value="${board.bno}"/>'>
					<input type="hidden" name='pageNum' value='<c:out value="${cri.pageNum }"/>'>
					<input type="hidden" name='amount' value='<c:out value="${cri.amount }"/>'>
					<input type="hidden" name='keyword' value='<c:out value="${cri.keyword }"/>'>
					<input type="hidden" name="type" value='<c:out value="${cri.type }"/>'>
				</form>
				   
            </div>
			<!-- ct_body -->
        </div>
	
	<hr>
	
	<!-- 댓글 창 -->
	<div class="comment">
		<div id="comment-head"><i class="comment-title">
		<img alt="speechbubble" src="/resources/img/speechbubble.png" width="20px" height="20px"> comment</i></div><hr>
		
			<ui class="chat">
				<li class="comment-li" data-rno="">
					   <!-- <div class="comment-wrap">
						<div class ="comment-list">
							<strong class="comment-writer"></strong>
							<samll class="small"></samll>
							<div class="textContent">
								<textarea class='modiText' rows='3' cols='100' style='display: none;'></textarea>
								<button type='button' class='replyModBtn' style='display: none;'>수정완료</button>
							</div>
						</div>
							<p class="comment-reply">아직 등록된 댓글이 없습니다.</p>
					</div>  -->
				</li>
			</ui>
			
				<!-- paging -->
				<div class="w3-bar" align="right" style="padding-right: 100px">
				
				</div>
				<!-- end paging -->
		<hr>
			<div class="replyRegi-wrap">
				<textarea class="replyArea" rows="3" cols="90" id="reply" name="reply"></textarea>
				<input class="replyRegiBtn" type="button" id="replyResigerBtn"  value="댓글등록">
			</div>
	</div>
</div>
</div>

	
<script type="text/javascript" src=/resources/js/reply.js charset="utf-8"></script>
	
<script type="text/javascript" charset="utf-8">

	$(document).ready(function(){
		
		let operForm = $("#operForm");
		
		$("button[data-oper='modify']").on("click", function(e){
			operForm.attr("action", "/qnaboard/modify").submit();
		});
		
		$("button[data-oper='list']").on("click", function(e){
			operForm.find("#bno").remove();
			operForm.attr("action", "/qnaboard/list");
			operForm.submit();
		});
		
		
	 	let bnoValue = $("#bno").val();
		let replyUrl = $(".chat");
		
		showList(1);
		
		// 댓글 등록
		$('#replyResigerBtn').on("click", function(e){
			
			let inputReply = $(".replyArea").val();
			let myNickname = '<%=(String)session.getAttribute("myNickname") %>';
	
				if(replyEmptyCheck(inputReply)){ // 댓글이 공백이면 컷하자
					return;
				}
		
			let reply = {
				reply : $('#reply').val(),
				replyer : myNickname,
				bno : bnoValue
			};
			
			replyService.add(reply, function(result){
				swal( "" , result , "success" );
				showList(-1); // 댓글 등록 후 마지막 페이지로 이동
				$('#reply').val('');
			});
		
		}); // end replyRegister
		
		
}); // end document


	// 댓글 공백 안 됨
	function replyEmptyCheck(inputReply){
		
		if(inputReply.length == 0){
			swal( "", "내용을 입력해주세요", "warning" );
			return true;
		}
		return false;
	}
	
	
	// 댓글 수정버튼 누르면 실행..
	function replyModify(event){
		
		let modiTextArea = event.parentElement.nextElementSibling.children[0]; // 텍스트 에어리어
		let modiTextBtn =  event.parentElement.nextElementSibling.children[1]; // 수정완료 버튼
 		let reply = event.parentElement.nextElementSibling.nextElementSibling.innerText; // 댓글 내용 수정창에 찍기
		let modiPTag =  event.parentElement.nextElementSibling.nextElementSibling; // 댓글 내용
 		let replyModiDiv = event.parentElement.nextElementSibling;
 		
		// 수정 버튼 누르면 텍스트 에어리어가 생긴다.
		modiTextArea.style.display="inline-block"; // 텍스트 에어리어
		modiTextBtn.style.display="inline-block"; // 수정완료 버튼
		modiPTag.style.display = "none"; 		  // 댓글 사라지게..
		modiTextArea.innerText = reply; // modiTextArea에 댓글 내용이 담긴다.
		replyModiDiv.style.display = "";
		
	}
	
	
	// 댓글 삭제 누르면 실행..
	function replyDelete(event){
		
		let rno = event.dataset['rno']; // 내가 선택한 삭제버튼의 rno가 담긴다.
		
		replyService.remove(rno, function(result){
			swal( "" , result , "success" );
			showList(pageNum);
			
		});
	
	}
	
	// 댓글 수정완료 버튼 누르면 실행..
	function replyModiSuccess(event){
		
		let modiTextArea = event.previousSibling.value; // 텍스트 에어리어에 입렫한 값을 저장
		let rnoVal = event.parentElement.previousSibling.parentElement.parentElement.dataset['rno'];
		
		if(modiTextArea.length == 0){
			swal( "" , "내용을 입력해주세요" , "warning" );
			return;
		}
		
		let reply = {rno:rnoVal, reply:modiTextArea}  // 리플번호와 리플내용을 가진 reply 객체
		
		replyService.update(reply, function(result){
			swal( "" , result , "success" );
			showList(pageNum);
		}) // 원래 댓글에 새로운 댓글내용으로 업데이트
		
	}

	
	// 댓글 조회
	function showList(page){
		
		console.log("page : " + page);
		
		let bnoValue = $("#bno").val();
		let replyUrl = $(".chat");
	
		let myNickname = '<%=(String)session.getAttribute("myNickname") %>';
		let myGrade = '${myGrade}';
		console.log("로그인 중인 닉네임 : " + myNickname);
		
		
		replyService.getList({bno:bnoValue, page: page||1}, function(replyCnt, list){
			
			console.log("replyCnt : " + replyCnt);
			console.log("list : " + list);

			if(page == -1){
				pageNum = Math.ceil(replyCnt / 10.0);
				showList(pageNum);
				return;
			}
			
			let str = "";
		
		 	if(list == null || list.length == 0){
		 		let str = "<p class='comment-reply' style='margin-bottom : 2%; text-align: center;'>아직 등록된 글이 없습니다.</p>";
				replyUrl.html(str); // 댓글창 출력
				return;
			}
			 
		
		for(var i=0, len = list.length||0; i<len; i++){
			str += "<li class='comment-li' data-rno='" + list[i].rno + "''>";
			str += "<div class='comment-wrap'><div class='comment-list' style='margin-bottom : 1%;'>" + 
			"<strong class='comment-writer'> " + list[i].replyer + " </strong>";
			str += "<small class='small'>" + replyService.displayTime(list[i].updateDate) + "</small>";
			
			// 내가 작성한 댓글만 수정 가능
			if(myNickname == list[i].replyer || myGrade == 'MG002'){
				str += "<button class='replyBtn_modify' onclick='replyModify(this)' data-rno='" + list[i].rno + "'>수정</button>";
				str += "<button class='replyBtn_delete' onclick='replyDelete(this)' data-rno='" + list[i].rno + "'>삭제</button></div>";
			}
			
			str += "<div class='textContent' style='display : none; margin-top:4%; margin-left:2%;'>";
			str += "<textarea class='modiText' rows='3' cols='120' style='display: none; margin-right: 2px; margin-left: -6%; margin-bottom: 1%;'></textarea>";
			str += "<button class='replyRegiBtn' type='button' class='replyModBtn' style='display: none; margin-bottom : 1%' onclick='replyModiSuccess(this)'>수정완료</button>";
			str += "</div>";
			str += "<p class='comment-reply' style='margin-bottom : 2%; white-space:pre;'>" + list[i].reply+ "</p></div></li>";
			str += "<hr>";
		}
		replyUrl.html(str); // 댓글창 출력
		showReplyPage(replyCnt);
	});
	
		
} // end showList

		

	// 댓글 페이징
	let pageNum = 1;
	let replyPageFooter = $('.w3-bar');
	
		function showReplyPage(replyCnt){
			
			let endNum = Math.ceil(pageNum / 10.0) * 10;
			let startNum = endNum - 9; // 시작은 마지막 번호에서 9를 뺀다.
			
			let prev = startNum != 1; // 이전 (boolean)
			let next = false;		  // 다음 (boolean)
			
			if(endNum * 10 >= replyCnt){
				endNum = Math.ceil(replyCnt/10.0); 
			}
			
			if(endNum * 10 < replyCnt){
				next = true;
			}
			
			let str = "<ul class='paging-wrap'>";
			
			if(prev){
				str += "<li class='w3-button w3-hover-none'> <a href='" + (startNum - 1) + "'>prev</a> </li>";
			}
			
			for(let i=startNum; i<= endNum; i++){
				let active = pageNum == i ? "active" : "";
				
				str += "<li class='w3-button w3-hover-none " + active + " '><a href='"+i+"'>"+ i +"</a></li>"
			}
			
			if(next){
				str += "<li class='w3-button w3-hover-none'><a href='" + (endNum + 1) + "' >next</a>";
			}
			
			str += "</ul></div>";
			
			replyPageFooter.html(str);
		} // end showReplyPage
		
		// 댓글 페이징 번호 누를경우 이벤트 발생(댓글 페이지 이동)
		replyPageFooter.on("click", "li a", function(e){
			e.preventDefault();
			console.log("page click");
			
			let targetPageNum = $(this).attr("href");
			
			console.log("targetPageNum : " + targetPageNum);
			
			pageNum = targetPageNum;
			
			showList(pageNum);
		});

	
		
		
</script>

<%@ include file="../includes/footer.jsp" %>

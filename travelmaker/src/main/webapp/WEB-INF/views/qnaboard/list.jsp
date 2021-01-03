 <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="../includes/header.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>

<!-- 제이쿼리 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<!-- 페이징 처리 -->
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/resources/css/qnaboard/list.css">

<title>Q&A 게시판</title>


</head>

<body>
<div class="full-wrap">
	
	<!-- 메인 타이틀 -->
	<div class="title-wrap"><a href="/qnaboard/list">Q&A 게시판</a></div>

  <table class="board-wrap">
    <thead>
    <tr>
      <th>#게시물번호</th>
	  <th>제목</th>
	  <th>작성자</th>
	  <th>작성일</th>
	  <th>수정일</th>
	  <th>조회수</th>
    </tr>
    </thead>
    <tbody>
      <c:forEach items="${list}" var="board">
			<tr>
				<td><c:out value="${board.bno }" /></td> <!-- 게시물 번호 -->
				
				<td><!-- 게시물 제목 -->
				<a class='move' href='<c:out value="${board.bno }"/>' id="<c:out value='${board.secret }' />">
				
				<!-- 비밀글이라면 자물쇠 표시 -->
				<c:if test="${board.secret eq 'Y' }">
						<img src="/resources/img/lock.png" style="height: 15px" width="15px">
				</c:if>
				
				<c:out value="${board.title }" /> 
				
				<c:if test="${board.replyCnt > 0 }">
					<span style="color: red; font-size: 12px"><c:out value=" [${board.replyCnt }] " /></span> <!-- 댓글 수 -->
				</c:if>
				</a></td>
				
				<td><c:out value="${board.nickname }" /></td> <!-- 닉네임 -->
				<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.regDate }" /></td> <!-- 등록일 -->
				<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.updateDate }" /></td> <!-- 수정일 -->
				<td><c:out value="${board.viewCnt }" /></td> <!-- 조회수 -->
			</tr>
		</c:forEach>
		  
    </tbody>
  
  </table>
  <!-- 글쓰기 버튼 -->
  		<div class="boardRegiBtn-wrap"><a href="/qnaboard/register"><button>WRITE</button> </a></div>
  		
  
		      <!-- 페이징 -->
    <div class="paging">
         <ul class="pagination_bar">
            <c:if test="${pageMaker.prev }">
               <li class="pagination_btn previous"><a href="${pageMaker.startPage-1 }">&laquo;</a></li>
            </c:if>

            <c:forEach var="num" begin="${pageMaker.startPage}"
               end="${pageMaker.endPage}">
               <li class="pagination_btn ${pageMaker.cri.pageNum == num ? 'active':'' }" >
                  <a href="${num}"> ${num }</a>
               </li>
            </c:forEach>

            <c:if test="${pageMaker.next }">
               <li class="pagination_btn next"><a href="${pageMaker.endPage +1 }">&raquo;</a></li>
            </c:if>
         </ul>
      </div>

	
	<!-- 검색기능 -->
		<div class='search' style="padding-top: 20px; margin-left: 10px">
			<div class="serach-wrap">
				
				<form id='searchForm' action="/qnaboard/list" method="get">
					<select name='type'>
						<option value="" 
						<c:out value="${pageMaker.cri.type == null ? 'selected' : '' }"/>>검색조건</option>
						<option value="T" 
						<c:out value="${pageMaker.cri.type eq 'T' ? 'selected' : '' }"/>>제목</option>
						<option value="C" 
						<c:out value="${pageMaker.cri.type eq 'C' ? 'selected' : '' }"/>>내용</option>
						<option value="W" 
						<c:out value="${pageMaker.cri.type eq 'W' ? 'selected' : '' }"/>>작성자</option>
						<option value="TC" 
						<c:out value="${pageMaker.cri.type eq 'TC' ? 'selected' : '' }"/>>제목 or 내용</option>
						<option value="TW" 
						<c:out value="${pageMaker.cri.type eq 'TW' ? 'selected' : '' }"/>>제목 or 작성자</option>
					</select>
						<input type='text' name='keyword' id="searchKeyword" value='<c:out value="${pageMaker.cri.keyword }"/>' />
						<input type='hidden' name='pageNum' value='<c:out value="${pageMaker.cri.pageNum }"/>' />
						<input type='hidden' name='amount' value='<c:out value ="${pageMaker.cri.amount }"/>' />
						<button class="searchBtn">SEARCH</button>
				</form>
			</div>
		</div>
		
		</div>
<!-- end full-wrap -->

		<form id="actionForm" action="/qnaboard/list" method="get">
			<input type="hidden" name='pageNum' value='${pageMaker.cri.pageNum }'>
			<input type="hidden" name='amount' value='${pageMaker.cri.amount }'>
			<input type="hidden" name='type' value='${pageMaker.cri.type }'>
			<input type="hidden" name='keyword' value='${pageMaker.cri.keyword }'>
		</form>
		
</body>

<script type="text/javascript">

		let actionForm = $("#actionForm");
	
		$(document).ready(function(){
			
			$(".pagination_btn a").on("click", function(e){ // 게시글 리스트 페이징
				e.preventDefault();
				actionForm.find("input[name='pageNum']").val($(this).attr("href"));
				actionForm.submit();
			});
		
			$(".move").on("click", function(e){
				e.preventDefault();
				let secret = $(this).attr("id"); // 비밀여부 Y / N
				let boardNickname = $(this).parent().next().text(); // 게시글 작성자를 변수에 저장
				let myNickname = "${loginNickname}"; // 로그인중인 회원의 닉네임
				let grade = "${myGrade}"; // 현재 나의 등급
	
				if(secret == 'Y' && boardNickname != myNickname 
						&& secret == 'Y' && grade != 'MG002'){ // 비밀글이면 본인 또는 관리자만 조회가능 
					swal( "" , "권한이 없습니다." , "warning" );
						
				}else{ // 비밀글이 아니면 편하게 게시물 조회
					actionForm.append("<input type='hidden' name='bno' value='" + $(this).attr("href") + "'>");
					actionForm.attr("action", "/qnaboard/get");
					actionForm.submit();
				}
			});
		
	}); // end document.ready

		// 글 쓰러가기 버튼 클릭 시..
		function moveRegister(){
			location.href = "/qnaboard/register";
		}
		
		// 검색
		let	searchForm = $("#searchForm");
		
		$('#searchForm button').on("click", function(e){
			
			let searchLenVal = $("#searchKeyword").val(); // 검색어 길이
			
			if(!searchForm.find("option:selected").val()){
				swal( "" , "검색조건을 선택해주세요." , "warning" );
				return false;
			}
			
			if(!searchForm.find("input[name='keyword']").val()){
				swal( "" , "검색키워드를 입력하세요" , "warning" );
				return false;
			}
			
			if(!(2 <= searchLenVal.length && searchLenVal.length <= 8)){
				swal( "" , "검색어 길이는 2~8자리 입니다." , "warning" );
				return false;
			}
			
			// 검색 버튼을 클릭하면 페이지의 번호는 1이 된다. 즉 5페이지에서 검색해도 1페이지로 돌아간다.
			searchForm.find("input[name='pageNum']").val("1");
			e.preventDefault();
			searchForm.submit();
		});
		
</script>
</html>

<%@ include file="../includes/footer.jsp" %>


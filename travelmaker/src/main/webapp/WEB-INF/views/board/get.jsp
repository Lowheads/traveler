<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="../includes/jeheader.jsp"%>

<link rel="stylesheet" href="/resources/css/main.css">

<div class="wrapper">
 	
 <div class="header_wrapper">
 	<div class="header">
	<h3> ${board.boardTitle} </h3>
	</div>
</div>
	<div class="contents">

		<div class="ct_body">
		
		<div class="heart" style="float:right;">
			<c:choose>
				<c:when test="${pick eq 'picked' }"> 
						찜하기 <i class="fa fa-heart" data-sch_no="${board.schNo}"
						style="font-size: 24px; color: red;" onclick="likeToggle(this)"></i>
				</c:when>

				<c:when test="${pick eq 'unpicked'}">
						찜하기 <i class="fa fa-heart fa-heart-o" data-sch_no="${board.schNo}"
						style="font-size: 24px; color: red;" onclick="likeToggle(this)"></i>
				</c:when>
			</c:choose>
		</div>	
		
		<div class="form-group">
		<table class="board">
		<thead>
			<tr>
				<th>회원번호</th>
				<th>지역</th>
				<th>기간</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>${schedule.memNo }</td>
				<td>${schedule.schRegion }</td>
				<td>${schedule.fromDate }~ ${schedule.toDate }</td>
			</tr>
		</tbody>
	</table>
	</div>
	<div class="form-group">
	<div>일정 : ${schedule.schTitle }</div>
	<table class="board">
		<thead>
			<tr>
				<th>날짜</th>
				<th>출발지</th>
				<th>도착지</th>
				<th>거리</th>
				<th>이동시간</th>
				<th>이동수단</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${schdtplace}" var="schdtplace">
				<tr>
					<td><c:out value="${schdtplace.schDate }" /></td>
					<td><c:out value="${schdtplace.plcTitle }" /></td>
					<td><c:out value="${schdtplace.plcTitle1 }" /></td>
					<td><c:out value="${schdtplace.distance }" /></td>
					<td><c:out value="${schdtplace.duration }" /></td>
					<td><c:out value="${schdtplace.transit}" /></td>
				</tr>
			</c:forEach>
		</tbody>

	</table>
	</div>
	
	<div>게시글</div>
	<div class="form-group">
	<table class="board">
		<thead>
			<tr>
				<th>게시물번호</th>
				<th>게시물내용</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${boarddt}" var="boarddt"> <!-- 리스트에서 boarddt 객체 하나로 변경하기 -->
				<tr>
					<td><c:out value="${boarddt.boardNo }" /></td>
<%-- 					<td><img class="orgImg"
						src="<c:out value='${boarddt.boarddtImg}'/>" /></td> --%>
					<td><c:out value="${boarddt.boardCon }" /></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	</div>
	
	<div class="form-group">
	<span>사진 목록</span>
	
	<div style="border: 1px solid #dbdbdb;">
		
		
		
		<div class="flex-container">
		<c:forEach var="file" items="${file}">
		<div>
			<a href="#" onclick="fn_fileDown('${file.FILE_NO}'); return false;">${file.ORG_FILE_NAME}</a>(${file.FILE_SIZE}kb)<br>
			<img src="<c:url value="/img/${file.STORED_FILE_NAME}"/>" width="200" height="200"/><br>${file.FILE_CONTENT}<br>
		</div>
		</c:forEach>
		</div>
	</div>
</div>

	<c:choose>
  <c:when test="${memNo eq schedule.memNo}">
    <button id="Btn" data-oper='modify' class="btn btn-default">게시글수정</button>
    <button id="Btn" data-oper='dtmodify' class="btn btn-default">사진목록수정</button>
  </c:when>
</c:choose>
	
	<button id="Btn" data-oper='list' class="btn btn-info">목록으로</button>

	<form name='operForm' id='operForm' action="/board/modify" method="get">
		<input type='hidden' id='boardNo' name='boardNo' value='<c:out value="${board.boardNo }"/>'> 
		<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum }"/>'> 
		<input type='hidden' name='amount' value='<c:out value="${cri.amount }"/>'>
	</form>
	<form name='fileForm' action="/board/fileDown" method="get">
		<input type='hidden' id="FILE_NO" name='FILE_NO' value="">
	</form>
</div>
</div>
</div>

<script type="text/javascript">
$(document).ready(function(){
	

	var operForm = $("#operForm");
	
	$("button[data-oper='modify']").on("click",function(e){
		operForm.attr("action","/board/modify").submit();
	});
	
	$("button[data-oper='dtmodify']").on("click",function(e){
		operForm.attr("action","/board/dtmodify").submit();
	});
	
	$("button[data-oper='list']").on("click",function(e){
		operForm.find("#boardNo").remove();
		operForm.attr("action","/board/list")
		operForm.submit();
	});	
});

function fn_fileDown(fileNo){
	var formObj = $("form[name='fileForm']");
	$("#FILE_NO").attr("value", fileNo);
	formObj.submit();
}

//좋아요
function likeToggle(heart){
   if(heart.className == "fa fa-heart"){
       let sendData = {
            'schNo' : heart.dataset['sch_no'],
         }
         //ajax 기능 추가 
         $.ajax({
            type : 'post',
            url : '/board/deletePick',
            data : sendData,
            success : function(data) {
               heart.classList.toggle("fa-heart-o");
              
             },
            error : function(error){
               alert("에러발생!! 다시시도해주세요"+error);
            }
         });
   }
   
  if(heart.className == "fa fa-heart fa-heart-o"){
      let sendData = {
            'schNo' : heart.dataset['sch_no'],
         }
         //ajax 기능 추가 
         $.ajax({
            type : 'post',
            url : '/board/insertPick',
            data : sendData,
            success : function(data) {
               heart.classList.toggle("fa-heart-o");
              
            },
            error : function(error){
               alert("에러발생!! 다시시도해주세요"+error);
            }
         });
   } 
    
}; 
</script>
	
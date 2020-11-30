<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="../includes/jeheader.jsp"%>


<div class="container">
	<h3>${board.boardTitle } </h3>
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

	<div>${schedule.schNo}: ${schedule.schTitle }</div>
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

	<div>게시물상세</div>

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
	<span>파일 목록</span>
	<div class="form-group" style="border: 1px solid #dbdbdb;">
		<c:forEach var="file" items="${file}">
			<a href="#" onclick="fn_fileDown('${file.FILE_NO}'); return false;">${file.ORG_FILE_NAME}</a>(${file.FILE_SIZE}kb)
			<img src="<c:url value="/img/${file.STORED_FILE_NAME}"/>" width="200" height="200"/><br>
		</c:forEach>
	</div>


	<c:choose>
  <c:when test="${memNo eq schedule.memNo}">
    <button id="Btn" data-oper='modify' class="btn btn-default">Modify</button>
    <button id="Btn" data-oper='dtmodify' class="btn btn-default">dtModify</button>
  </c:when>
</c:choose>
	
	<button id="Btn" data-oper='list' class="btn btn-info">List</button>

	<form name='operForm' id='operForm' action="/board/modify" method="get">
		<input type='hidden' id='boardNo' name='boardNo' value='<c:out value="${board.boardNo }"/>'> 
		<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum }"/>'> 
		<input type='hidden' name='amount' value='<c:out value="${cri.amount }"/>'>
		<input type='hidden' id="FILE_NO" name='FILE_NO' value="">
	</form>
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
	var formObj = $("form[name='operForm']");
	$("#FILE_NO").attr("value", fileNo);
	formObj.attr("action", "/board/fileDown");
	formObj.submit();
}
</script>
	
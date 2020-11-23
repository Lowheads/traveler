<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="../includes/jeheader.jsp"%>

<div class="container">
	<h3>${board.boardTitle }</h3>
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
				<th>게시물사진</th>
				<th>게시물사진내용</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${boarddt}" var="boarddt">
				<tr>
					<td><c:out value="${boarddt.boardNo }" /></td>
					<td><img class="orgImg"
						src="<c:out value='${boarddt.boarddtImg}'/>" /></td>
					<td><c:out value="${boarddt.boardCon }" /></td>

				</tr>
			</c:forEach>
		</tbody>
	</table>

	<button id="Btn" data-oper='modify' class="btn btn-default">Modify</button>
	<button id="Btn" data-oper='list' class="btn btn-info">List</button>

	<form id='operForm' action="/board/modify" method="get">
		<input type='hidden' id='boardNo' name='boardNo'
			value='<c:out value="${boardNo }"/>'> <input type='hidden'
			name='pageNum' value='<c:out value="${cri.pageNum }"/>'> <input
			type='hidden' name='amount' value='<c:out value="${cri.amount }"/>'>

	</form>
</div>

<script type="text/javascript">
$(document).ready(function(){
	var operForm = $("#operForm");
	
	$("button[data-oper='modify']").on("click",function(e){
		operForm.attr("action","/board/modify").submit();
	});
	$("button[data-oper='list']").on("click",function(e){
		operForm.find("#boardNo").remove();
		operForm.attr("action","/board/list")
		operForm.submit();
	});
});

</script>
	
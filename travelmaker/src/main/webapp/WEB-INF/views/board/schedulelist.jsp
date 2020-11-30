<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/jeheader.jsp"%>


<div class="container">
	<div>
		<h1>내일정 공유 </h1>
	</div>
	<div class="table-responsive">
		<table class="table table-striped table-sm">
			<thead>
				<tr>
					<th>일정번호</th>
					<th>일정명</th>
					<th>작성여부</th>

				</tr>
			</thead>

			<c:forEach items="${schedulelist}" var="schedule">
				<tr class="schedulenum">
				<td>
					<c:choose>
					<c:when test="${schedule.schStatus eq '미작성' }"> <!-- 작성이 아닐때로 변경 (not eq ' ') -->
					<a href='/board/register?schNo=<c:out value="${schedule.schNo}"/>'><c:out value="${schedule.schNo}" /></a>
					</c:when>
					
					<c:when test="${schedule.schStatus eq '작성'}">
					<c:out value="${schedule.schNo}" />
					</c:when>
					
					<c:when test="${schedule.schStatus eq '작성중'}">
					<a href='/board/dtregister?schNo=<c:out value="${schedule.schNo}"/>'><c:out value="${schedule.schNo}" /></a>
					</c:when>
					
					</c:choose>
					</td>
					
					<td><c:out value="${schedule.schTitle}" /></td>
					<td><c:out value="${schedule.schStatus }"/></td>
					
				</tr>
			</c:forEach>
		</table>
	</div>
	<div>
		<button id="Btn" onclick="location.href='/board/list'"
			class="btn btn-sm-btn-primary">취소</button>
	</div>
</div>



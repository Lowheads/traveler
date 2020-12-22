<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<style>

.bs001{
  color: black;
  padding: 12px 25px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 13px;
  cursor: pointer;
  border-radius:12px;
}

.bs002, .bs003{
	background-color : #dddddd;
	padding: 12px 25px;
	border-radius: 12px;
	color: black;
 	text-align: center;
  	text-decoration: none;
  	display: inline-block;
  	font-size: 13px;
  	cursor: pointer;
  	border-radius:12px;

}

.schtable{
	border-collapse: separate;
  	border-spacing: 40px 10px;
}

.container{
	text-align: center;
}

</style>





<div class="container">

	<div>
		<table class="schtable">
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
					<c:when test="${schedule.schStatus eq 'BS003' }"> <!-- 작성이 아닐때로 변경 (not eq ' ') -->
					<a class='bs003' href='/board/register?schNo=<c:out value="${schedule.schNo}"/>'><c:out value="${schedule.schNo}" /></a>
					</c:when>
					
					<c:when test="${schedule.schStatus eq 'BS001'}">
					<div class="bs001"><c:out value="${schedule.schNo}" /></div>
					</c:when>
					
					<c:when test="${schedule.schStatus eq 'BS002'}">
					<a class='bs002' target='_parent' href='/board/dtregister?schNo=<c:out value="${schedule.schNo}"/>'><c:out value="${schedule.schNo}" /></a>
					</c:when>
					
					</c:choose>
					</td>
					
					<td><c:out value="${schedule.schTitle}" /></td>
					<td>
					<c:choose>
					<c:when test="${schedule.schStatus eq 'BS001' }"> 작성 </c:when>
					<c:when test="${schedule.schStatus eq 'BS002' }"> 작성중 </c:when>
					<c:when test="${schedule.schStatus eq 'BS003' }"> 미작성 </c:when>
					</c:choose>
					</td>
					
					
				</tr>
			</c:forEach>
		</table>
	</div>

</div>



<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<style>


* { font-family: 'Spoqa Han Sans Neo', 'sans-serif'; }
body{
 margin : 0;
}
.bs001 {
	color: black;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 14px;
	border-radius: 12px;
}

.bs002, .bs003 {
	/* 	background-color : #dddddd; */
	border-radius: 12px;
	color: black;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 14px;
	cursor: pointer;
	border-radius: 12px;
}

.schtable {
	width: 90%;
	/*margin: 0 50px 50px 0;*/
	margin: auto;
	white-space: nowrap;
	border-collapse: collapse;
	font-size: 0.9em;
	/*min-width: auto;*/
	overflow: hidden;
	border-radius: 0 0 0 0;
}

.schtable thead tr {
	color: black;
	text-align: left;
	font-size: 17px;
	font-weight: bold;
	border-bottom: 2px solid #dddddd;
}

.schtable th, .schtable td {
	font-weight: 400;
	text-align: center;
	padding: 12px 23px
}

.schtable tbody tr {
	font-size: 15px;
	border-bottom: 1px solid #dddddd;
	background-color: white;
	height: 70px;
}

.schtable tbody tr:nth-of-type(even) {
	background-color: #fafafa;
}

.schtable tbody tr:last-of-type {
	border-bottom: 1px #dddddd solid;
}

.container {
	display: flex;
	flex-direction: column;
	align-content: center;
	justify-content: center;
}
</style>





<div class="container">

	<div>
		<table class="schtable">
			<thead>
				<tr>
					<th>날짜</th>
					<th>일정명</th>
					<th>작성여부</th>

				</tr>
			</thead>
		<tbody>
			<c:forEach items="${schedulelist}" var="schedule">
				<tr class="schedulenum">
				<td>	
					<c:out value="${schedule.fromDate }"/>~<br><c:out value="${schedule.toDate }"/>
					</td>
				
				<td>
					<c:choose>
					<c:when test="${schedule.schStatus eq 'BS003' }"> <!-- 작성이 아닐때로 변경 (not eq ' ') -->
					<a class='bs003' href='/board/register?schNo=<c:out value="${schedule.schNo}"/>'><c:out value="${schedule.schTitle}" /></a>
					</c:when>
					
					<c:when test="${schedule.schStatus eq 'BS001'}">
					<div class="bs001"><c:out value="${schedule.schTitle}" /></div>
					</c:when>
					
					<c:when test="${schedule.schStatus eq 'BS002'}">
					<a class='bs002' target='_parent' href='/board/dtregister?schNo=<c:out value="${schedule.schNo}"/>'><c:out value="${schedule.schTitle}" /></a>
					</c:when>
					
					</c:choose>
					</td>

					<td>
					<c:choose>
					
					<c:when test="${schedule.schStatus eq 'BS001' }"> <img src="/resources/img/check.png"> </c:when>
					<c:when test="${schedule.schStatus eq 'BS002' }">
					<a class='bs002' target='_parent' href='/board/dtregister?schNo=<c:out value="${schedule.schNo}"/>'>
					<img src="/resources/img/edit.png"></a> </c:when>
					<c:when test="${schedule.schStatus eq 'BS003' }">
					<a class='bs003' href='/board/register?schNo=<c:out value="${schedule.schNo}"/>'>
					<img src="/resources/img/edit.png"></a> </c:when>
					</c:choose>
					</td>
					
					
				</tr>
			</c:forEach>
			</tbody>
		</table>
	</div>

</div>



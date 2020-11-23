<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../includes/header.jsp"%>
<%
	request.setCharacterEncoding("UTF-8");
String paydate = request.getParameter("pay_date");
%>

<div class="wrapper">
	<div class="header">
		<h1>경비 관리</h1>
	</div>

	<table class="board">
		<thead>
			<tr>
				<th>일정 번호</th>
				<th>경비 합계</th>
				<th>결제 횟수</th>
			</tr>
		</thead>

		<tbody>

			<c:forEach items="${list}" var="budget">
				<tr>
					<td><a
						href='/daybud/get?schno=<c:out value="${budget.schno}"/>'> <c:out
								value="${budget.schno}" />
					</a></td>
					<td>₩ <c:out value="${budget.totalpay}" /></td>
					<td><c:out value="${budget.totalcnt}" /> 건</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

</div>

<script type="text/javascript">
	$(document).ready(function() {

		$("#buddtregBtn").on("click", function() {
			self.location = "/buddt/register";
		});

		$("#daybudregBtn").on("click", function() {
			self.location = "/daybud/register";
		});

		$("#budgetRegBtn").on("click", function() {
			self.location = "/budget/register";
		});

	});
</script>

<%@include file="../includes/footer.jsp"%>
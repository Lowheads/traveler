<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header2.jsp"%>

<div>
	<div>
		<h3> <c:out value="${paydate }" /> 경비 내역 </h3>
	</div>

	<div>
		경비 상세 내역
		<button type="button" onclick="location.href='/buddt/register?schno=<c:out value="${schno }"/>'">
			<c:out value="${paydate }" /> 내역 추가
		</button>
	</div>
	
		<table class="board">
			<thead>
				<tr>
					<th>#no</th>
					<th>결제한 날짜</th>
					<th>일정 번호</th>
					<th>가게 이름</th>
					<th>금액</th>
					<th>카테고리</th>
				</tr>
			</thead>

			<tbody>
				<c:forEach items="${buddt}" var="buddt">
					<tr>
						<td><a href='/buddt/modify?no=<c:out value="${buddt.no}"/>&paydate=<c:out value="${buddt.paydate}"/>
							&schno=<c:out value="${buddt.schno}"/>'><c:out value="${buddt.no}" /></a></td>
						<td><c:out value="${buddt.paydate}" /></td>
						<td><c:out value="${buddt.schno}" /></td>
						<td><c:out value="${buddt.store}" /></td>
						<td>₩ <c:out value="${buddt.expense}" /></td>
						<td><c:out value="${buddt.budcate}" /></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>

		<!-- 그래프 -->
		<c:forEach items="${cateCnt}" var="cateCnt">
			<input type='hidden' data-cate="${ cateCnt.budcate}"
				data-cnt="${cateCnt.catecnt }" class="cate">
		</c:forEach>

</div>

<script type="text/javascript">

$(document).ready(

			var operForm = $("#operForm");
			$("button[data-oper='modify']").on("click", function(e) {
				operForm.attr("action", "/buddt/modify").submit();
			});

			$("button[data-oper='list']").on("click", function(e) {
				operForm.find("#bno").remove();
				operForm.attr("action", "/buddt/list")
				operForm.submit();
			});

			$("#buddtRegBtn").on("click", function() {
				self.location = "/buddt/register";
			});

		});
		
</script>
<%@include file="../includes/footer.jsp"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp"%>


<div>
	<div>
		<h1> 일정 번호 <c:out value="${schno }" /> 의 경비 내역 </h1>
	</div>

	<table>
		<thead>
			<tr>
				<!-- <th>test</th> -->
				<th>결제일</th>
				<th>총 결제 금액</th>
				<th>총 결제 횟수</th>
			</tr>
		</thead>

		<tbody>
			<c:forEach items="${daybud}" var="daybud">
				<tr>
					<!-- <td><a href='/buddt/get?paydate=<c:out value="${daybud.paydate}"/>
					&schno=<c:out value="${daybud.schno }"/> '><c:out value="${daybud.paydate }" />
					</a></td> -->
					<td><c:out value="${daybud.paydate}" /></td>
					<td>₩ <c:out value="${daybud.daypay}" /></td>
					<td><c:out value="${daybud.daycnt}" /></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	
	<!-- 아이프레임 -->
	<select onchange="window.open(value,'iframe')">
		<option selected value="/buddt/listAll?schno=<c:out value="${schno }"/>">모든 내역</option>
		<c:forEach items="${daybud}" var="daybud">
			<option value="/buddt/get?paydate=<c:out value="${daybud.paydate}"/>
			&schno=<c:out value="${daybud.schno }"/>"><c:out value="${daybud.paydate}" />
			</option>
		</c:forEach>
	</select> 
	
	&nbsp <button onclick="location.href='/budget/list'">일정 목록으로</button>

	<!-- 아이프레임 출력 화면 -->	
	<iframe src="/buddt/listAll?schno=<c:out value="${schno }"/>"
		scrolling="no" width="100%" height="1200px" frameborder=1 name=iframe></iframe>

<script type="text/javascript">

$(document).ready(function() {

	var operForm = $("#operForm");

	$("button[data-oper='modify']").on("click", function(e) {
	
			operForm.attr("action", "/daybud/modify").submit();

		});

		$("button[data-oper='list']").on("click", function(e) {

			operForm.find("#schno").remove();
			operForm.attr("action", "/daybud/list")
			operForm.submit();

		});

		$("#daybudRegBtn").on("click", function() {

			self.location = "/daybud/register";

		});

	});
	
</script>

<!-- 
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

<script type="text/javascript">

google.charts.load("current", {packages:["corechart"]});

	google.charts.setOnLoadCallback(drawChart);
	
	function drawChart() {
		
	  var data = google.visualization.arrayToDataTable([
	    ['Task', 'Hours per Day'],
	    ['Work',     11],
	    ['Eat',      2],
	    ['Commute',  2],
	    ['Watch TV', 2],
	    ['Sleep',    7]
	  ]);

	  var options = {
	    title: 'My Daily Activities',
	    pieHole: 0.6,
	  };

	  var chart = new google.visualization.PieChart(document.getElementById('donutchart'));
	  chart.draw(data, options);
	}
	
</script> 
-->

<%@include file="../includes/footer.jsp"%>
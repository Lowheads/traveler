<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header2.jsp"%>


<div class="wrapper">
	<div class="header">
		<h3>모든 결제 내역</h3>
	</div>

	<div>
		경비 상세 내역 : 날짜 순으로 출력
		<button type="button"
			onclick="location.href='/buddt/register?schno=<c:out value="${schno }"/>'">결제
			추가</button>
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
			<c:forEach items="${listAll}" var="listAll">
				<tr>
					<td><a
						href='/buddt/modify?no=<c:out value="${listAll.no}"/>&paydate=<c:out value="${listAll.paydate}"/>&schno=<c:out value="${listAll.schno}"/>'>
							<c:out value="${listAll.no}" />
					</a></td>
					<td><c:out value="${listAll.paydate}" /></td>
					<td><c:out value="${listAll.schno}" /></td>
					<td><c:out value="${listAll.store}" /></td>
					<td>₩ <c:out value="${listAll.expense}" /></td>
					<td><c:out value="${listAll.budcate}" /></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

</div>

<script type="text/javascript">
	/* $(document).ready(
			function() {
				var result = '<c:out value="${result}"/>';
				checkModal(result);
				/* history.replaceState({}, null, null); */
				function checkModal(result) {
					if (result === '' || history.state) {
						return;
					}
					if (parseInt(result) > 0) {
						$(".modal-body").html(
								"게시글 " + parseInt(result) + " 번이 등록되었습니다.");
					}
					$("#myModal").modal("show");
				} */

				/* var category = document.getElementsByClassName("cate");
				
				google.charts.load("current", {packages:["corechart"]});
				google.charts.setOnLoadCallback(drawChart);
				
				function drawChart() {

				var data = new google.visualization.DataTable();
				data.addColumn('string','Task');
				data.addColumn('number','Hours per Day');
				
				for(var i=0; i<category.length; i++){
					data.addRows([
						[category[i].dataset["cate"],parseInt(category[i].dataset["cnt"])]
					]);
				}
				
				var options = {
				        'title': '<c:out value="${paydate }"/>',
				        pieHole: 0.4,
				        'width' : 700,
				        'height' : 800
				      };
				
				var chart = new google.visualization.PieChart(document.getElementById('donutchart'));
				chart.draw(data, options);
				} */

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


<!-- <script type="text/javascript">
      google.charts.load("current", {packages:["corechart"]});
      google.charts.setOnLoadCallback(drawChart);
      function drawChart() {
        var data = google.visualization.arrayToDataTable([
          ['Task', 'Hours per Day'],
          ['음식점',     11],
          ['카페',      2],
          ['활동',  2],
          ['Watch TV', 2],
          ['Sleep',    7]
        ]);

        var options = {
          title: '<c:out value="${paydate }"/>',
          pieHole: 0.6,
        };

        var chart = new google.visualization.PieChart(document.getElementById('donutchart'));
        chart.draw(data, options);
      }
    </script> -->
<script type="text/javascript">
	
</script>

<%@include file="../includes/footer.jsp"%>

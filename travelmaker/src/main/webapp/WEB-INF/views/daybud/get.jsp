<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp"%>


<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header"><c:out value="${schno }"/> 의 경비 </h1>
	</div>
	<!-- /.col-lg-12 -->
</div>

<select onchange="window.open(value,'iframe')">
<!-- <option selected>리스트보기</option> -->
<!-- http://localhost:8181/buddt/listAll?schno=1 -->
<option selected value="/buddt/listAll?schno=<c:out value="${schno }"/>">모든 내역</option>
<c:forEach items="${daybud}" var="daybud">
<option value="/buddt/get?paydate=<c:out value="${daybud.paydate}"/>&schno=<c:out value="${daybud.schno }"/>"><c:out value="${daybud.paydate}"/></option>
</c:forEach>
</select> 
&nbsp
<button data-oper='list' class="btn btn-info"
onclick="location.href='/budget/list'">
일정 목록으로
</button>

<iframe src="/buddt/listAll?schno=<c:out value="${schno }"/>" scrolling = "no" width="100%" height="1200px" frameborder=0 name=iframe></iframe>
					
					<select id="inputState" class="form-control" >
						<option selected>a</option>
						<c:forEach items="${box}" var="select">
							<option><c:out value="${select.schno}" /></option>
						</c:forEach>
					</select>
					
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
		
			<div class="panel-heading">
			TEMPORARY<!-- <button id='daybudRegBtn' type="button" class="btn-xs pull-right">하루 더 추가</button> -->
			</div>
			<!-- /.panel-heading -->
			<div class="panel-body">
			                
			                <table width="100%" class="table table-striped table-bordered table-hover" id="dataTables-example">
                                <thead>
                                    <tr>
                                        <th>test</th>
                                        <th>test</th>
                                        <th>test</th>
                                        <th>test</th>
                                    </tr>
                                </thead>
                                
    									<!--  /buddt/get?paydate='2020-11-03'&schno=1001 -->
                                <c:forEach items="${daybud}" var="daybud">
                                <tr>
                                  <td> <c:out value="${daybud.schno}" /></td>
                                  <td><a href='/buddt/get?paydate=<c:out value="${daybud.paydate}"/>&schno=<c:out value="${daybud.schno }"/> '> 
                                  <c:out value="${daybud.paydate }"/></a></td>
                                  <td>₩ <c:out value="${daybud.daypay}" /></td>
                                  <td> <c:out value="${daybud.daycnt}" /></td>
                                </tr>  
                                </c:forEach>
                            </table>
					
					<%-- <div class="form-group">
					  <label>Text area</label>
					  <textarea class="form-control" rows="3" name='content'
					    readonly="readonly"><c:out value="${buddt.content}" /></textarea>
					</div> --%>
					
<%-- 				<form id='operForm' action="/buddt/modify" method="get">
					  <input type='hidden' id='bno' name='bno' value='<c:out value="${buddt.bno}"/>'>
					  <input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum}"/>'>
					  <input type='hidden' name='amount' value='<c:out value="${cri.amount}"/>'>
					  <input type='hidden' name='keyword' value='<c:out value="${cri.keyword}"/>'>
					  <input type='hidden' name='type' value='<c:out value="${cri.type}"/>'>
					</form> --%>
					
			</div>
			<!-- end panel-body -->
			
		</div>
		<!-- end panel-body -->
	</div>
	<!-- end panel -->
</div>

<!-- /.row -->
<script type="text/javascript">
$(document).ready(function() {
	
	var operForm = $("#operForm");
	
	$("button[data-oper='modify']").on("click", function(e){
	
		operForm.attr("action", "/daybud/modify").submit();
		
	});
	
	$("button[data-oper='list']").on("click", function(e){
		
		operForm.find("#schno").remove();
		operForm.attr("action", "/daybud/list")
		operForm.submit();
		
	});
	
	$("#daybudRegBtn").on("click", function() {
		
		self.location = "/daybud/register";
		
	});
	
});
</script>

<!-- <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script> -->
    
    <script type="text/javascript">
      /* google.charts.load("current", {packages:["corechart"]});
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
      } */
    </script>
    
<%@include file="../includes/footer.jsp"%>

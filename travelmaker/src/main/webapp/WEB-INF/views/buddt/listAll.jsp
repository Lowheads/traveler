<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header2.jsp"%>


<div class="row">
	<div class="col-lg-12">
		<h3 class="page-header">모든 결제 내역</h3> <!-- 이거 다시 순서대로 알기 -->
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
		
			<div class="panel-heading">
			경비 상세 내역 : 날짜 순으로 출력 <button id='buddtRegBtn' type="button" class="btn-xs pull-right">결제 추가</button>
			</div>
			<!-- /.panel-heading -->
			<div class="panel-body">
			
                            <table width="100%" class="table table-striped table-bordered table-hover" id="dataTables-example">
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
                                
                                <c:forEach items="${listAll}" var="listAll">
                                <tr>
                                  <td> <a href='/buddt/modify?no=<c:out value="${listAll.no}"/>&paydate=<c:out value="${listAll.paydate}"/>&schno=<c:out value="${listAll.schno}"/>'> 
                                  <c:out value="${listAll.no}"/></a> </td>
                                  <td> <c:out value="${listAll.paydate}" /></td>                
                                  <td> <c:out value="${listAll.schno}" /></td>
                                  <td> <c:out value="${listAll.store}" /></td>
                                  <td>₩ <c:out value="${listAll.expense}" /></td>
                                  <td> <c:out value="${listAll.budcate}" /></td>
                                </tr>
                                </c:forEach>
                            </table>
					
					<%-- <div class="form-group">
					  <label>Text area</label>
					  <textarea class="form-control" rows="3" name='content'
					    readonly="readonly"><c:out value="${buddt.content}" /></textarea>
					</div> --%>
					
					
					<%-- <button data-oper='list' class="btn btn-info"
					onclick="location.href='/buddt/get?schno=<c:out value="${buddt.schno}"/>'">뒤로</button> --%>
					
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
	
	
	$("button[data-oper='modify']").on("click", function(e){
	
		operForm.attr("action", "/buddt/modify").submit();
		
	});
	
	$("button[data-oper='list']").on("click", function(e){
		
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

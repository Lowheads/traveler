<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    
<%@ include file="includes/adminheader.jsp"%>
<div id="dailyChart" style="width: 900px; height: 200px;"></div>
<div id="monthlyChart" style="width: 900px; height: 200px;"></div>
<div id="Table" style="width: 700px; height: 200px;"></div>
 <script type="text/javascript">
      google.charts.load('current', {'packages':['corechart']});
      google.charts.setOnLoadCallback(drawChart);
      google.charts.setOnLoadCallback(drawChart2);      

      function drawChart() {
        var data1 = google.visualization.arrayToDataTable([
          ['daily', '신규 가입자 ','새 글'], ${result1}]);
        
        var option1 = {  title: '일간 차트'};
        
        var chart = new google.visualization.AreaChart(document.getElementById('dailyChart'));
        chart.draw(data1, option1);
      }
      

      function drawChart2() {
        var data2 = google.visualization.arrayToDataTable([
          ['monthly', '신규 가입자','새 글'], ${result2}]);
        
        
        
        var option2 = {  title: '월간 차트'};
        
        var chart2 = new google.visualization.AreaChart(document.getElementById('monthlyChart'));
        chart2.draw(data2, option2);
      }
      
      
   
    google.charts.load('current', {'packages':['table']});
    google.charts.setOnLoadCallback(drawTable);
      
    function drawTable() {
          var data = new google.visualization.DataTable();
          data.addColumn('string', 'daily');
          data.addColumn('number', '가입자 수');
          data.addRows([ ${result} ]);
          

          var table = new google.visualization.Table(document.getElementById('Table'));

          table.draw(data, {showRowNumber: true, width: '100%', height: '100%'});
        }
    
      
</script>





<%@ include file="includes/adminfooter.jsp"%>
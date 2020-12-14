<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    
<%@ include file="includes/adminheader.jsp"%>
<div class="container-fluid">
<div class="row">

            <!-- Earnings (Monthly) Card Example -->
            <div class="col-xl-3 col-md-6 mb-4">
              <div class="card border-left-primary shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">신규 가입자</div>
                      <div class="h5 mb-0 font-weight-bold text-gray-800"></div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-calendar fa-2x text-gray-300"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>
                        <!-- Earnings (Monthly) Card Example -->
            <div class="col-xl-3 col-md-6 mb-4">
              <div class="card border-left-success shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">탈퇴 회원</div>
                      <div class="h5 mb-0 font-weight-bold text-gray-800"></div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-calendar fa-2x text-gray-300"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>
                        <!-- Earnings (Monthly) Card Example -->
            <div class="col-xl-3 col-md-6 mb-4">
              <div class="card border-left-info shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">새 글</div>
                      <div class="h5 mb-0 font-weight-bold text-gray-800"></div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-calendar fa-2x text-gray-300"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>
                        <!-- Earnings (Monthly) Card Example -->
            <div class="col-xl-3 col-md-6 mb-4">
              <div class="card border-left-warning shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">접속자 수 </div>
                      <div class="h5 mb-0 font-weight-bold text-gray-800"></div>
                    </div>
                    <div class="col-auto">
                      <i class="fas fa-calendar fa-2x text-gray-300"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>
</div>
</div>
<div id="dailyChart" style="width: 900px; height: 200px;"></div>
<div id="monthlyChart" style="width: 900px; height: 200px;"></div>
<div id="Table" style="width: 700px; height: 200px;"></div>
 <script type="text/javascript">
      google.charts.load('current', {'packages':['corechart']});
      google.charts.setOnLoadCallback(drawChart);
      google.charts.setOnLoadCallback(drawChart2);      

      function drawChart() {
        let data1 = google.visualization.arrayToDataTable([
          ['daily', '신규 가입자 ','탈퇴 회원', '새 글'], ${dailyLog}]);
        
        let option1 = {  title: '일간 차트'};
        
        let chart = new google.visualization.AreaChart(document.getElementById('dailyChart'));
        chart.draw(data1, option1);
      }
      

      function drawChart2() {
        let data2 = google.visualization.arrayToDataTable([
          ['monthly', '신규 가입자','탈퇴 회원','새 글'], ${monthlyLog}]);
        
        let option2 = {  title: '월간 차트'};
        
        let chart2 = new google.visualization.AreaChart(document.getElementById('monthlyChart'));
        chart2.draw(data2, option2);
      }
      
      
      /*
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
    */
      
</script>
<%@ include file="includes/adminfooter.jsp"%>
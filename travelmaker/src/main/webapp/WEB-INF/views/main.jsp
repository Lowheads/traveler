<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="includes/adminheader.jsp"%>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.bundle.min.js"></script>
	<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"></script>
<!-- 			<h6 class="m-0 font-weight-bold text-primary">dash board</h6>
		</div> -->
<div class="container-fluid">
<div class="row">

            <!-- Earnings (Monthly) Card Example -->
            <div class="col-xl-3 col-md-6 mb-4">
              <div class="card border-left-primary shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">신규 가입자</div>
                      <span>5</span>
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
                      <span>5</span>
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
                      <span>5</span>
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
                      <span>5</span>
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

<!-- <div id="dailyChart" style="width: 900px; height: 200px;"></div>
<div id="monthlyChart" style="width: 900px; height: 200px;"></div> -->
<div class="row">
<div class="col-xl-6 col-lg-7">
<div class="card shadow mb-4">
	<div class="card-header py-3">
		<h6 class="m-0 font-weight-bold text-primary">Chart</h6>
				<div class = "m-0 font-weight-bold chartType">
			<span id="daily">일별 추이	&nbsp / &nbsp </span>
			<span id="monthly">월별 추이 </span></div>		
	</div>
	<div class="card-body chart">
	    <canvas id="myChart" width="470px" height="340px"></canvas>
	</div>
</div>
</div>
<div class="col-xl-6 col-lg-7">
<div class="card shadow mb-4">
	<div class="card-header py-3">
		<h6 class="m-0 font-weight-bold text-primary">인기게시글</h6>
						<div class = "m-0 font-weight-bold postOrder">
			<span id="view">조회수	&nbsp / &nbsp</span>
			<span id="pick">찜한 갯수</span></div>	
	</div>
	<div class="card-body">	
	<table class="table table-hover" width="400px" cellspacing="0">
		<tbody>
			<tr>
				<th>제목</th>
				<th>찜한갯수</th>
				<th>조회수</th>
				<th>등록일</th>
			</tr>
			<tr>
			</tr>
		</tbody>
	</table>
	</div>
</div>
</div>
				<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
					aria-labelledby="myModalLabel" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal"
									aria-hidden="true">&times;</button>
								<h4 class="modal-title" id="myModalLabel"></h4>
							</div>
							<div class="modal-body"></div>
							<div class="modal-footer">
								<button id="modalInBtn" type="button" class="btn btn-primary"
									data-dismiss="modal">확인</button>
								<button id="modalDefaultBtn" type="button"
									class="btn btn-primary" data-dismiss="modal">close</button>


							</div>
						</div>
						<!-- /.modal-content -->
					</div>
					<!-- /.modal-dialog -->
				</div>
				<!-- /.modal -->
</div>
<script type="text/javascript" src="/resources/js/admin.js"></script>
 <script type="text/javascript">
 $(document).ready(function() {
	 
		 makeChart("daily");
		 getPost("view");
	 
		$(".chartType span").on("click",function(){ 
			var type = $(this).attr("id")
				makeChart(type);
		})
		
		$(".postOrder span").on("click",function(){ 
			var type = $(this).attr("id")
			getPost(type);
	})
	
		$("tr").click(function(){
			
			console.log(",,,")
		})
		
		var date = [];	
		
		function test(){
			
			var boardNo = $(this).attr("id")
			
			user.detail(boardNo,function(list){
			
			let str = boardNo+"번 게시글 상세정보 <br>";
			for (let i = 0; i < list.length; i++) {
				
				str+="내용	:	"+list[i].boardCon	+"<br>";
			}
			
			console.log(str);
			showModal(str);
		})
			
		}
		
		function showModal(msg){
			
			$(".modal-body").html(msg);
			$("#myModal").modal("show");
		};
		
		function makeChart(type){
			
			$.getJSON("/admin/getChart/"+type
					,function(data){

				$("#myChart").remove();
				
				let obj = document.createElement('canvas');
				obj.setAttribute("id","myChart")
				obj.setAttribute("style","width:500px, height:340px")

				var chartCanvas = $(".chart");
				chartCanvas.append(obj);
				
				var targetDate = [];
				var cntMember = [];
				var cntPost = [];
				var cntWithdrawUser = [];

							for(var i =0; i<Object.keys(data).length; i++){
								
								targetDate.push(data[i].targetDate);
								cntMember.push(data[i].cntMember);
								cntPost.push(data[i].cntPost);
								cntWithdrawUser.push(data[i].cntWithdrawalMember);
							}
							

							var ctx = document.getElementById('myChart');
							
								var myChart = new Chart(ctx, {
									type: 'line',
									data: {
										labels: targetDate,
										datasets: [{
											label: '신규 회원', //범례
											data:cntMember,
										 	backgroundColor: [
												'rgba(255, 99, 132, 0.2)'
											],
											borderColor: [
							                  'rgba(255, 99, 132, 0.2)'
											],
											borderWidth: 1
							            },
							            {
											label: '탈퇴 회원', //범례
											data:cntWithdrawUser,
										 	backgroundColor: [
												'rgba(30, 150, 255, 0.2)'
											],
											borderColor: [
												'rgba(30, 150, 255, 0.2)'
											],
											borderWidth: 1
							            },{
											label: '게시글 수 ', //범례
											data:cntPost,
										 	backgroundColor: [
												'rgba(255, 228, 0, 0.2)'
											],
											borderColor: [
												'rgba(255, 228, 0, 0.2)'
											],
											borderWidth: 1
							            }
							            ],
							            
									},
									options: {  
										responsive: true,
										scales: {
											yAxes: [{
												ticks: {
													beginAtZero: true
												}
											}]
										},
									}
								});
						}
							).fail(
						function(xhr, status,err){
							if(error){
								error();
							}
						});
		}
		
		function getPost(type){
			
			$.getJSON("/admin/getPostByPopularity/"+type
					,function(data){
				
 				$("tbody").empty()
 				
				for(var i =0; i<Object.keys(data).length; i++){
					
					var date = new Date(data[i].modDate)
					data[i].modDate = date.getMonth()+"-"+date.getDate()
				}
				
				var str = '<tr><th>제목</th><th>찜한갯수</th><th>조회수</th><th>등록일</th></tr>';
				
				
							for(var i =0; i<Object.keys(data).length; i++){
								str+='<tr id= '+data[i].boardNo+'><td>'+data[i].boardTitle+'</td>'
								str+='<td>'+data[i].vcnt+'</td>'
								str+='<td>'+data[i].pickCnt+'</td>'
								str+='<td>'+data[i].modDate+'</td></tr>'
							}
							/* $("tr").append(str) */
							 $("tbody").append(str) 
							 
							 var t = $("tr");
							 for(var i = 0; i<t.length; i++) {
								 t[i].addEventListener("click",test);
								 }
				
			}).fail(
							function(xhr, status,err){
								if(error){
									error();
								}
							});
			
		}
	
 });
</script>
<%@ include file="includes/adminfooter.jsp"%>
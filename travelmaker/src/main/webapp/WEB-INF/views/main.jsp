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
					<!-- Main Content -->



				<!-- Topbar -->
 				<nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

				<li class="nav-item alarm dropdown no-arrow mx-1 status='show'">
						<a class="nav-link dropdown-toggle" href="#" id="alertsDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
							<i class="fas fa-bell fa-fw"></i>
							<!-- Counter - Alerts -->
							<c:forEach items="${qna}" var="qna">
								<span class="badge badge-danger badge-counter">${qna.key}</span>
							</c:forEach>
						</a>
						<!-- Dropdown - Alerts -->
 						<div class="dropdown-list dropdown-menu dropdown-menu-left shadow animated--grow-in" aria-labelledby="alertsDropdown">
							<h6 class="dropdown-header">
								새로 등록된 Q&A
							</h6>
							<c:forEach items="${qna}" var="qna">
								<c:forEach items="${qna.value}" var="post">
									<a href="/qnaboard/get?pageNum=1&amount=18&type=&keyword=&bno=<c:out value='${post.bno }'/>">
									<div class="dropdown-item d-flex align-items-center">
										<div class="small text-gray-500"><fmt:formatDate value = '${post.regDate}' pattern='MM/dd'/>&nbsp</div>
										<span class="font-weight-bold">${post.title}</span></a><br>
									</div>	
								</c:forEach>
							</c:forEach>
							<a class="dropdown-item text-center small text-gray-500" href="/qnaboard/list">Show All Alerts</a>
						</div>
					</li>
				</nav> 
					
				<!-- End of Topbar -->
<div class="row">
            <!-- Earnings (Monthly) Card Example -->
            <div class="col-xl-3 col-md-6 mb-4">
              <div class="card border-left-primary shadow h-100 py-2">
                <div class="card-body">
                  <div class="row no-gutters align-items-center">
                    <div class="col mr-2">
                      <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">신규 가입자</div>
                      <span>${today.cntMember}</span>
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
                      <span>${today.cntWithdrawalMember}</span>
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
                      <span>${today.cntPost}</span>
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
                      <span>${today.cntTraffic}</span>
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
							<h4 class="modal-title" id="myModalLabel"></h4>
								<button type="button" class="close" data-dismiss="modal"
									aria-hidden="true">&times;</button>
							</div>
							<div class="modal-body">
							<div class="img-card"></div>
							</div>
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
			const type = $(this).attr("id")
				makeChart(type);
		})
			
		$(".postOrder span").on("click",function(){ 
			const type = $(this).attr("id")
			getPost(type);
		})
		
		function postDetail(){
			
			const boardNo = $(this).attr("id")
			
			let title = $("td[id="+boardNo+"]")[0].innerText;
			
			user.detail(boardNo,function(list){
				
				$(".modal-title").empty();
				$(".modal-title").append(boardNo+"번 게시글 상세정보 ")
							
				let str = "제목	:	"+title+"<br>";
				
				for (let i = 0; i < list.length; i++) {
					if(list[i].boardCon!=null){
						str+="내용	:	"+list[i].boardCon	+"<br>";
					}else{
						str+="내용없음<br>"
					}
					
					user.getImage(boardNo,function(list){
						
						for(let i =0; i<list.length;i++){

							let img = document.createElement("img")
							img.setAttribute("src","/imgUpload/boarddtFile/"+list[i])
							
							let tag = document.createElement("div");
							tag.setAttribute("class","img-card")
							tag.append(img)
							$(".modal-body").append(tag);
							
						}
						
					},function(fail){console.log(fail);})
			}
			
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

				const chartCanvas = $(".chart");
				chartCanvas.append(obj);
				
				let targetDate = [];
				let cntMember = [];
				let cntPost = [];
				let cntWithdrawUser = [];
				let cntTraffic = [];

				for(let i =0; i<Object.keys(data).length; i++){
					
					targetDate.push(data[i].targetDate);
					cntMember.push(data[i].cntMember);
					cntPost.push(data[i].cntPost);
					cntWithdrawUser.push(data[i].cntWithdrawalMember);
					cntTraffic.push(data[i].cntTraffic);
				}
				

				const ctx = document.getElementById('myChart');
				
					const myChart = new Chart(ctx, {
						type: 'line',
						data: {
							labels: targetDate,
							datasets: [{
								label: '신규 회원',
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
								label: '탈퇴 회원',
								data:cntWithdrawUser,
							 	backgroundColor: [
									'rgba(30, 150, 255, 0.2)'
								],
								borderColor: [
									'rgba(30, 150, 255, 0.2)'
								],
								borderWidth: 1
				            },{
								label: '게시글 수 ',
								data:cntPost,
							 	backgroundColor: [
									'rgba(255, 228, 0, 0.2)'
								],
								borderColor: [
									'rgba(255, 228, 0, 0.2)'
								],
								borderWidth: 1
				            },
				            {
								label: '일일 접속자수',
								data:cntTraffic,
							 	backgroundColor: [
									'rgba(71, 200, 62, 0.2)'
								],
								borderColor: [
									'rgba(71, 200, 62, 0.2)'
								],
								borderWidth: 1
				            }],
				            
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
 				
				for(let i =0; i<Object.keys(data).length; i++){
					
					const date = new Date(data[i].modDate)
					data[i].modDate = date.getMonth()+"-"+date.getDate()
				}
				
				let str = '<tr><th>제목</th><th>조회수</th><th>찜한갯수</th><th>등록일</th></tr>';
				
				
							for(let i =0; i<Object.keys(data).length; i++){
								str+='<tr id= '+data[i].boardNo+'><td id= '+data[i].boardNo+'>'+data[i].boardTitle+'</td>'
								str+='<td >'+data[i].vcnt+'</td>'
								str+='<td>'+data[i].pickCnt+'</td>'
								str+='<td>'+data[i].modDate+'</td></tr>'
							}
							 $("tbody").append(str) 
							 
							 const tr = $("tr");
							 for(let i = 0; i<tr.length; i++) {
								 tr[i].addEventListener("click",postDetail);
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
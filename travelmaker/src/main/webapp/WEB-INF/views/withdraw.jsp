<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="includes/adminheader.jsp"%>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>

<!-- Begin Page Content -->
<div class="container-fluid">

	<!-- DataTales Example -->
	<div class="card shadow mb-4">
		<div class="card-header py-3">
			<h6 class="m-0 font-weight-bold text-primary">탈퇴 회원 관리</h6>
		</div>
		<div class="card-body">
			<div class="form-group row justify-content-center">
			<form id='searchForm' action="/admin/withdraw" method='get'><!-- 
				<div class="w100 input-group custom-search-form" style="padding-right: 10px"> -->
				<div class="w100 input-group custom-search-form">
					<select class="form-control form-control-sm" name="type" id="type">
						<option selected disabled hidden><c:out value="${criteria.type}"/></option>
						<option value="회원번호">회원번호</option>
						<option value="이메일">이메일</option>
						<option value="닉네임">닉네임</option>
					</select>
 							<input type="text" class="form-control form-control-sm" placeholder="키워드를 입력하시오"
							name="keyword" id="keyword" value = '<c:out value="${criteria.keyword}"/>'>
				
				<span class="input-group-btn">
						<button onclick="return search()" class="btn btn-default" type="submit">
						<i class="fa fa-search"></i></button>
					
				</span>
				</div>
				
				<!-- <div>
				<button id = "searchBtn" class="btn btn-sm- btn-primary">검색</button>
				</div>
				 -->
				 </form>

				<div class="table-responsive">
					<table class="table table-hover" id="dataTable" width="100%"
						cellspacing="0">
						<thead>
							<tr>
								<th>MEM_NO</th>
								<th>EMAIL</th>
								<th>NICKNAME</th>
								<th>BIRTH</th>
								<th>GENDER</th>
								<th>STATUS</th>
								<th>REG_DATE</th>
								<th>LATEST LOGIN DATE</th>
								<th>MEM_GRADE</th>
							</tr>
						</thead>
						<tbody id="tableBody">

							<c:forEach items="${users}" var="users">
								<tr name="row" id='<c:out value="${users.memNo}" />'>
									<td id="memNo"><c:out value="${users.memNo}" /></td>
									<td id="email"><c:out value="${users.email}" /></td>
									<td id="nickname"><c:out value="${users.nickname}" /></td>
									<td id="birth"><c:out value="${users.birth}" /></td>
									<td id="gender"><c:out value="${users.gender}" /></td>
									<td id="status"><c:out value="${users.status}" /></td>
									<td id="regDate"><fmt:formatDate pattern="yyyy-MM-dd" value="${users.regDate}" /></td>
									<td id="lastDate"><fmt:formatDate pattern="yyyy-MM-dd" value="${users.lastDate}" /></td>
									<td id="memGrade"><c:out value="${users.memGrade}" /></td>
								</tr>
							</c:forEach>

						</tbody>

					</table>
					<!-- Modal -->
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
							
						<!-- 2nd Modal -->
					<div class="modal fade" id="infoModal" tabindex="-1" role="dialog"
						aria-labelledby="myModalLabel" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal"
										aria-hidden="true">&times;</button>
									<h4 class="modal-title" id="myModalLabel"></h4>
								</div>
								<div class="modal-body">회원정보</div>
								<div name="secret" hidden=true ></div>
								<div class="modal-footer">
									<button id="moveBtn" type="button"
										class="btn btn-primary" data-dismiss="modal">게시글보기</button>
									<button id="modalInBtn" type="button" class="btn btn-primary"
										data-dismiss="modal">확인</button>
								</div>
							</div>
							<!-- /.modal-content -->

						</div>
						<!-- /.modal-dialog -->
					</div>

					
				</div>
			</div>

		</div>

	</div>
	<!-- /.container-fluid -->

</div>
<!-- End of Main Content -->

<script type="text/javascript" src="/resources/js/admin.js"></script>
<script>
$(document).ready(function() {

	$("tr[name=row]").click(function() {

		const id = $(this).attr("id");
		
		const res = $("#"+id)[0].innerText;
		const info =(res.substring(0,res.length)).split("	");

		const output ="회원번호	:	"+info[0]+"<br>"
					+"이메일		:	"+info[1]+"<br>"
					+"닉네임		:	"+info[2]+"<br>"
					+"생년월일		:	"+info[3]+"<br>"
					+"성별		:	"+info[4]+"<br>"
					+"상태		:	"+info[5]+"<br>"
					+"가입일		:	"+info[6]+"<br>"
					+"최근 로그인 날짜		:	"+info[7]+"<br>"
					+"등급		:	"+info[8]

		
		$(".modal-body").html(output);
		$("#infoModal").modal("show");
		
		$("#moveBtn").on('click',function(){
			
			location.href = "/admin/boardList?type=mem_no&keyword="	+ id;
		})
	})
	
	const _sleep = (delay) => new Promise((resolve) => setTimeout(resolve, delay));

	const timer = async () => {
	    await _sleep(1000);
	    $("#dataTable_filter")[0].hidden=true;
	};
	
	timer();
	
})


function search(){
		
		const type = $("select[id=type]").val();
		const keyword = $("input[id=keyword]").val();
		
		let msg="";
		
		if (type == "") {
			msg = "검색할 대상을 선택하세요";
			showModal(msg);
			return false;
		}

		if (keyword == "") {
			msg = "검색할 단어를 입력하세요"
			showModal(msg);
			return false;
		}
		
		if(type =="회원번호"){
			if(isNaN(keyword)){
				msg = "회원번호는 숫자만 입력해주세요"
				showModal(msg);
				return false;
			}
		}
		
		if(keyword.length>100){
			msg = "검색은 100자리 이하만 가능합니다";
			showModal(msg);
			return false;
		}
		
		return true;
	}

	function showModal(msg){
			
			$(".modal-body").html(msg);
			$("#myModal").modal("show");
		};
</script>


<%@ include file="includes/adminfooter.jsp"%>
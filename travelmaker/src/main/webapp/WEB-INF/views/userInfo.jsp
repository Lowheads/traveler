<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="includes/adminheader.jsp"%>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>


<!-- Begin Page Content -->
<div class="container-fluid">

	<!-- Page Heading -->
	<h1 class="h3 mb-2 text-gray-800">Tables</h1>
	<p class="mb-4">
		DataTables is a third party plugin that is used to generate the demo
		table below. For more information about DataTables, please visit the <a
			target="_blank" href="https://datatables.net">official DataTables
			documentation</a>.
	</p>


	<!-- DataTales Example -->
	<div class="card shadow mb-4">
		<div class="card-header py-3">
			<h6 class="m-0 font-weight-bold text-primary">전체 회원 조회하기</h6>
		</div>
		<div class="card-body">
			<div class="form-group row justify-content-center">
				<form id='searchForm' action="/admin/userInfo" method='get'>
				<div class="w100" style="padding-right: 10px">
					<select class="form-control form-control-sm" name="type" id="type">
						<option selected disabled hidden><c:out value="${criteria.type}"/></option>
						<option value="회원번호">회원번호</option>
						<option value="이메일">이메일</option>
						<option value="닉네임">닉네임</option>
					</select>
				</div>
				<div class="w300" style="padding-right: 10px">
							<input type="text" class="form-control form-control-sm"
							name="keyword" id="keyword" value = '<c:out value="${criteria.keyword}"/>'>
				</div>
				<div>
				<button id = "searchBtn" class="btn btn-sm- btn-primary">검색</button>
				</div>
				</form>

				<div class="table-responsive">
					<button type="button" class="btn btn-primary"
						onClick="deleteUser()">강제 탈퇴</button>
					<table class="table table-bordered" id="dataTable" width="100%"
						cellspacing="0">
						<thead>
							<tr>
								<th><input type="checkbox" id="th_checkAll" onclick="checkAll();" /></th>
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
									<td><input type="checkbox" name="ChkBox" id="${users.memNo}"></td>
									<td><c:out value="${users.memNo}" /></td>
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
									<h4 class="modal-title" id="myModalLabel">회원정보</h4>
								</div>
								<div class="modal-body">회원정보</div>
								<div class="modal-footer">
									<button id="moveBtn" type="button" class="btn btn-primary"
										data-dismiss="modal">게시글보기</button>
									<button id="removeBtn" type="button" class="btn btn-primary">강제
										탈퇴</button>
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

		var message = '<c:out value="${message}"/>';

		checkModal(message);

		history.replaceState({}, null, null);

		function checkModal(message) {

			if (message === '' || history.state) {
				return;
			}else{
				$(".modal-body").html("삭제를 완료하였습니다");
				$("#myModal").modal("show");
			}
		}
	})

	function deleteUser() {

		var cnt = 0;
		var txt = "";

		for (var i = 0; i < $("input[name=ChkBox]").length; i++) {
			if ($("input[name=ChkBox]")[i].checked) {
				txt += $("input[name=ChkBox]")[i].id + ", ";
				cnt++;
			}
		}

		if (txt.length == 0) {
			$(".modal-body").html("탈퇴 처리 할 회원을 선택해주세요");
			$("#myModal").modal("show");

		} else {
			var ids = (txt.substring(0, txt.lastIndexOf(","))).split(",");
			$(".modal-body").html(cnt + "명의 회원을 강제로 탈퇴시키겠습니까?");
			$("#myModal").modal("show");

			$("#myModal #modalInBtn").on("click", function(e) {
				
				var tableTD = $("#tableBody");
				
				location.href = "/admin/remove/" + ids;
				
			})
		}

	};

	$("#searchForm button").on("click",function(e) {
		var type = $("#searchForm").find("option:selected").val();
		var keyword = $("#searchForm").find("input[name='keyword']").val();

		if (type == "") {
			$(".modal-body").html("검색할 대상을 선택하세요");
			$("#myModal").modal("show");
			return false;
		}

		if (keyword == "") {
			$(".modal-body").html("검색할 단어를 입력하세요");
			$("#myModal").modal("show");
			return false;
		}
		
		if(type =="회원번호"){
			if(isNaN(keyword)){
				$(".modal-body").html("회원번호는 숫자만 입력해주세요");
				$("#myModal").modal("show");
				return false;
			}
		}
		return true;
	})
	

	$("tr[name=row]").click(function() {
		
			var id = $(this).attr("id");
				
			var res = $("#" + id)[0].innerText;

			var info = (res.substring(1, res.length)).split("	");

			var output = "회원번호   :   " + info[0] + "<br>"
						+ "이메일      :   " + info[1] + "<br>"
						+ "닉네임      :   " + info[2] + "<br>"
						+ "생년월일      :   " + info[3] + "<br>"
						+ "성별      :   " + info[4] + "<br>"
						+ "상태      :   " + info[5] + "<br>"
						+ "가입일      :   " + info[6] + "<br>"
						+ "최근 로그인 날짜      :   " + info[7] + "<br>"
						+ "등급      :   " + info[8]

			$(".modal-body").html(output);
			$("#infoModal").modal("show");

			$("#removeBtn").on('click', function() {
				$(".modal-body").html("해당 회원을 강제로 탈퇴시키겠습니까?");
				$("#infoModal").modal("show");
				$("#infoModal #modalInBtn").on("click", function() {
					location.href = "/admin/remove/" + id;
				})
			})

		$("#moveBtn").on('click',function() {
			location.href = "/admin/boardList?type=회원번호&keyword="	+ id;})

	})

	function checkAll(event) {
		if ($("#th_checkAll").is(':checked')) {
			$("input[name=ChkBox]").prop("checked", true);
		} else {
			$("input[name=ChkBox]").prop("checked", false);
		}
	};
</script>

<%@ include file="includes/adminfooter.jsp"%>
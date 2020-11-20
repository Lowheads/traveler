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
			<h6 class="m-0 font-weight-bold text-primary">DataTables Example</h6>
		</div>
		<div class="card-body">
			<div class="table-responsive">
			
			<form id='searchForm' action="/admin/boardList" method='get'>
							<select name="type" id="type">
							<option selected disabled hidden><c:out value="${criteria.type}"/></option>
							<option value="mem_no">회원번호</option>
							<option value="title">제목</option>
						</select>
						<input type="text" class="form-control form-control-sm"
							name="keyword" id="keyword" placeholder="회원번호를 입력하시오" value = '<c:out value="${criteria.keyword}"/>'>
						<button id = "searchBtn" class="btn btn-sm- btn-primary">검색</button>
				</form>

				<button id="removePost" type="button" class="btn btn-default"
					onClick="deletePost()">delete</button>
				<table class="table table-bordered" id="dataTable" width="100%"
					cellspacing="0">
					<thead>
						<tr>
							<th><input type="checkbox" name="checkAll" id="th_checkAll"
								onclick="checkAll();" /></th>
							<th>NO</th>
							<th>제목</th>
							<th>작성일</th>
							<th>찜한수</th>
							<th>수정일</th>
							<th>조회수</th>
							<th>숨김여부</th>
						</tr>
					</thead>
					<tfoot>
						<tr>
							<th>check</th>
							<th>NO</th>
							<th>제목</th>
							<th>작성일</th>
							<th>찜한수</th>
							<th>수정일</th>
							<th>조회수</th>
							<th>숨김여부</th>
						</tr>
					</tfoot>
					<tbody>
						<c:forEach items="${board}" var="board">
							<tr>
								<td><input type="checkbox" name="ChkBox"
									id="${board.boardNo}"></td>
								<td><c:out value="${board.boardNo}" /></td>
								<td><c:out value="${board.boardTitle}" /></td>
								<td><fmt:formatDate pattern="yyyy-MM-dd"
										value="${board.WDate}" /></td>
								<td><c:out value="${board.pickCnt}" /></td>
								<td><fmt:formatDate pattern="yyyy-MM-dd"
										value="${board.modDate}" /></td>
								<td><c:out value="${board.VCnt}" /></td>
								<td><c:out value="${board.hidden}" /></td>
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
								<h4 class="modal-title" id="myModalLabel">탈퇴</h4>
							</div>
							<div class="modal-body">처리가 완료되었습니다</div>
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
		</div>

	</div>

</div>
<!-- /.container-fluid -->

</div>
<!-- End of Main Content -->

<script>
	$(document).ready(function() {
		
		
		var searchForm = $("#searchForm")
		
		$("#searchForm button").on("click", function(e) {

			if (!searchForm.find("input[name='keyword']").val()) {
				alert("키워드를 입력하시오")
				return false;
			}
			
			e.preventDefault();
		//	actionForm.find("input[name='type']").val($(this).attr("href"));
		//	actionForm.submit();
			searchForm.submit();
			
		})

		var message = '<c:out value="${message}"/>';

		if (message === '') {
			return;
		} else {

			$(".modal-body").html("삭제를 완료하였습니다");
			$("#myModal").modal("show");

		}
	})
	function deletePost() {

		var cnt = 0;

		var txt = "";

		for (var i = 0; i < $("input[name=ChkBox]").length; i++) {
			if ($("input[name=ChkBox]")[i].checked == true) {
				txt += $("input[name=ChkBox]")[i].id + ", ";
				cnt++;
			}
		}

		var result = (txt.substring(0, txt.lastIndexOf(","))).split(",");

		if (txt.length == 0) {
			$(".modal-body").html("삭제할 게시글을 선택해주세요");

		} else {

			$(".modal-body").html(cnt + "개의 게시글을 삭제 시키겠습니까?");

		}

		$("#myModal").modal("show");

		$("#modalInBtn").on("click", function() {
			if (txt.length != 0) {
				var url = "/admin/removeContent?result=" + result;
				self.location = url;
			}

		});
	};
	function test(){
		
		alert(this[0].innerText);
		
	}
	
	
	function checkAll() {
		if ($("#th_checkAll").is(':checked')) {
			$("input[name=ChkBox]").prop("checked", true);
		} else {
			$("input[name=ChkBox]").prop("checked", false);
		}
	}
</script>

<%@ include file="includes/adminfooter.jsp"%>
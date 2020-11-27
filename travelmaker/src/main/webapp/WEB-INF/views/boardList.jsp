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
			<div class="form-group row justify-content-center">
			<form id='searchForm' action="/admin/boardList" method='get'>
				<div class="w100" style="padding-right: 10px">
					<select class="form-control form-control-sm" name="type" id="type">
						<option selected disabled hidden><c:out
								value="${criteria.type}" /></option>
						<option value="회원번호">회원번호</option>
						<option value="닉네임">닉네임</option>
						<option value="제목">제목</option>
					</select>
				</div>
				<div class="w300" style="padding-right: 10px">
					<input type="text" class="form-control form-control-sm"
						name="keyword" id="keyword" placeholder="키워드를 입력하시오"
						value='<c:out value="${criteria.keyword}"/>'>
				</div>
				<div>
					<button id="searchBtn" class="btn btn-sm- btn-primary">검색</button>
				</div>
			</form>
			<div class="table-responsive">
				<button id="removePost" type="button" class="btn btn-primary"
					onClick="deletePost()">게시물 삭제하기</button>
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
					<tbody>
						<c:forEach items="${board}" var="board">
							<tr name="row" id='<c:out value="${board.boardNo}" />'>
								<td><input type="checkbox" name="ChkBox"
									id="${board.boardNo}"></td>
								<td><c:out value="${board.boardNo}" /></td>
								<td><c:out value="${board.boardTitle}" /></td>
								<td><fmt:formatDate pattern="yyyy-MM-dd"
										value="${board.WDate}" /></td>
								<td id=""><c:out value="${board.pickCnt}" /></td>
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
								<h4 class="modal-title" id="myModalLabel"></h4>
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

<script type="text/javascript" src="/resources/js/admin.js"></script>
<script>
	$(document).ready(function() {

		const message = '<c:out value="${message}"/>';

		if (message === '') {
			return;
		} else {

			$(".modal-body").html("삭제를 완료하였습니다");
			$("#myModal").modal("show");
		}

	})

	$("#searchForm button").on("click", function(e) {
		
		const type = $("select[id=type]").val();
		const keyword = $("input[id=keyword]").val();
		//var type = $("#searchForm").find("option:selected").val();
		//var keyword = $("#searchForm").find("input[name='keyword']").val();
		
		let msg="";

		if (type == null) {
			showModal("검색할 대상을 선택하세요");
			return false;
		}

		if (keyword == "") {
			showModal("검색할 단어를 입력하세요");
			return false;
		}
		
		if(type =="회원번호"){
			if(isNaN(keyword)){
				showModal("회원번호는 숫자만 입력해주세요");
				return false;
			}
		}
		
		return true;
		
	})

	function deletePost() {

		let cnt = 0;
		let txt = "";

		for (let i = 0; i < $("input[name=ChkBox]").length; i++) {
			if ($("input[name=ChkBox]")[i].checked == true) {
				txt += $("input[name=ChkBox]")[i].id + ", ";
				cnt++;
			}
		}

		const boardNo = (txt.substring(0, txt.lastIndexOf(","))).split(",");
		
		let msg = "";

		if (txt.length == 0) {
			
			showModal("삭제할 게시글을 선택해주세요")
			return false;

		} else {	
			
			showModal(cnt + "개의 게시글을 삭제하시겠습니까?")
		}

		$("#modalInBtn").on("click", function() {
			
			location.href = "/admin/removeContent/" + boardNo;
		});
	};
	
	$("tr[name=row]").click(function() {
		
		const boardNo = $(this).attr("id");
		
		user.detail(boardNo,function(list){
			
			let str = boardNo+"번 게시글 상세정보 <br>";
			for (let i = 0; i < list.length; i++) {
				
				str+="내용	:	"+list[i].boardCon	+"	num	:	"+list[i].num+"	이미지	:	"+list[i].boarddtImg+"	썸네일 이미지	:	"+list[i].boardThumbImg+"<br>";
			}
			
			showModal(str);
		})
		
	})	
	
	function showModal(msg){
			
			$(".modal-body").html(msg);
			$("#myModal").modal("show");
		};

	function checkAll() {
		if ($("#th_checkAll").is(':checked')) {
			$("input[name=ChkBox]").prop("checked", true);
		} else {
			$("input[name=ChkBox]").prop("checked", false);
		}
	}
</script>

<%@ include file="includes/adminfooter.jsp"%>
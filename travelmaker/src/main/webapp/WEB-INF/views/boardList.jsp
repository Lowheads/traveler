<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="includes/adminheader.jsp"%>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>

			<h6 class="m-0 font-weight-bold text-primary">게시글 관리</h6>
		</div>
		<div class="card-body">
			<div class="form-group row justify-content-center">
				<form id='searchForm' action="/admin/boardList" method='get'>
				<div class="w100 input-group custom-search-form">
					<select class="form-control form-control-sm" name="type" id="type">
						<option selected disabled hidden>
						<c:if test="${criteria.type eq 'NO'}">
						회원번호
						</c:if>
						<c:if test="${criteria.type eq 'T'}">
						제목
						</c:if>
						<c:if test="${criteria.type eq 'N'}">
						닉네임
						</c:if>
						<c:if test="${criteria.type eq 'C'}">
						내용
						</c:if>
						</option>
						<option value="NO">회원번호</option>
						<option value="N">닉네임</option>
						<option value="T">제목</option>
						<option value="C">내용</option>
					</select>
					<input type="text" class="form-control form-control-sm"
						name="keyword" id="keyword" placeholder="키워드를 입력하시오"
						value='<c:out value="${criteria.keyword}"/>'>
					<span class="input-group-btn">
						<button onclick="return search()" class="btn btn-default" type="submit">
						<i class="fa fa-search"></i></button>
					</span>
				</div>
				</form>
			
			<div class="table-responsive">
				<button id="removePost" type="button" class="btn btn-primary float-right"
					onClick="deletePost()">삭제하기</button>
				<table class="table table-hover" id="dataTable" width="100%"
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
								<td name="title"><c:out value="${board.boardTitle}" /></td>
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
							<div class="modal-body">처리가 완료되었습니다
							
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
		</div>

	</div>



<script type="text/javascript" src="/resources/js/admin.js"></script>
<script>
	$(document).ready(function() {
		
		
		const _sleep = (delay) => new Promise((resolve) => setTimeout(resolve, delay));

		const timer = async () => {
		    await _sleep(2000);
		    $("#dataTable_filter")[0].hidden=true;
		};
		
		timer();

		const message = '<c:out value="${message}"/>';
		
		let modalMsg = "";

		if (message === '') {
			return;
		}else if(message === 'success'){
			modalMsg="삭제를 완료하였습니다";
		}else{
			modalMsg="삭제중 오류가 발생했습니다 다시 시도해주세요";
		}
		
		showModal(modalMsg);


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
		
		if(type =="NO"){
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
		
		const target = $(this).children();
		
		const title = target[2].innerText;
		
		let str = "";
		
		user.detail(boardNo,function(list){
			
			str = boardNo+"번 게시글 상세정보 <br>"+"제목	:	"+title+"<br>";
			
			if(list.length!=0&&list[0].boardCon!=null){
				for (let i = 0; i < list.length; i++) {
					
					str+="내용	:	"+list[i].boardCon	+"<br>";
				}
				
			}else{
				str+="내용 없음<br>"}
			
			user.getImage(boardNo,function(list){
				
				for(let i =0; i<list.length;i++){

					let img = document.createElement("img")
					img.setAttribute("src","/imgUpload/boarddtFile/"+list[i])
					
					let tag = document.createElement("div");
					tag.setAttribute("class","img-card")
					tag.append(img)
					$(".modal-body").append(tag);
					
				}
				
			},function(fail){console.log(fail); console.log("ㅜㅜ")})
			
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
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="../includes/jeheader.jsp"%>

<div class="container">    
	<div class="row">
	<div class="col-1g-12">
		<h1 class="page-header">BoardDT Register</h1>
	</div>
	<!-- /.col-1g-12 -->
</div>
<!-- /.row -->

<div class="row">
	<div class="col-1g-12">
		<div class="panel panel-default">
		
		<div class="panel-heading">게시물 상세 등록</div>
		<!-- /.panel-heading -->
		<div class="panel-body">
		
		
			<form role="form" action="/board/dtregister" method="post" enctype="multipart/form-data">
				<table>
					<tbody>
					<tr>
						<td>
							<label>게시물번호</label><input class="form-control" name='boardNo' value='${board.boardNo }' readonly="readonly">
						</td>
					</tr>
					<tr>
						<td>
					<label>게시물 이름</label> <input class="form-control" name='boardTitle' value='${board.boardTitle }' readonly="readonly">
						</td>
					</tr>
					<tr>
						<td id="fileIndex">
						</td>
					</tr>
					<tr>
						<td>
						<label>상세 사진 내용 등록</label><input class="form-control" name='boardCon'>
						</td>
					</tr>
					<tr>
						<td>
						<button id="Btn" type="submit" class="btn btn-default" >게시글 등록</button>
						<button id="Btn" type="button" onclick="location.href='/board/list'" class="btn btn-default">취소</button>	
						<button id="Btn" type="button" class="fileAdd_btn" >파일추가</button>
						</td>
					</tr>			
					</tbody>
				
				</table>
				</form>
		</div>
		<!--  end panel-body -->
		</div>
		<!--  end panel-body -->
	</div>
	<!-- end panel -->
</div>
<!-- /.row -->
</div>

<script type="text/javascript">
$(document).ready(function(){
	fn_addFile();
	function fn_addFile(){
		var fileIndex = 1;
		$(".fileAdd_btn").on("click", function(){
			$("#fileIndex").append("<div><input type='file' style='float:left;' name='file_"+(fileIndex++)+"'>"+"</button>"+"<button type='button' style='float:right;' id='fileDelBtn'>"+"삭제"+"</button></div>");
		});
	
		$(document).on("click","#fileDelBtn", function(){
			$(this).parent().remove();
		
		});
	}
});


</script>
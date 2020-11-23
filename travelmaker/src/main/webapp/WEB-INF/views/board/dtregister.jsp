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
				
				<div class="form-group">
					<label>게시물 번호</label> <input class="form-control" name='boardNo' value='${board.boardNo }' readonly="readonly">
				</div>
								
				<div class="form-group">
					<label>게시물 이름</label> <input class="form-control" name='boardTitle' value='${board.boardTitle }' readonly="readonly">
				</div>
				<!-- 첫번째 사진등록 -->
				<div class="form-group">
					<label for="boarddtImg">상세 사진 등록</label>
					<div class="form-group uploadDiv">
					<input type="file" class="boarddtImg" id="boarddtImg" name="file" required/>
					<div class="select_img"><img src=""/></div>
				</div>
				</div>
				
				<script>
				//사진등록 시 화면에 보여주는 함수
				$("#boarddtImg").change(function() {
					if (this.files && this.files[0]) {
					var reader = new FileReader;
						reader.onload = function(data) {
					$(".select_img img").attr("src", data.target.result)
						.width(500);
					}
					reader.readAsDataURL(this.files[0]);
					}
				});

				</script>
			
						<div class="form-group"><label>상세 사진 내용 등록</label>
							<input class="form-control" name='boardCon'>
						</div>				
				<br>
				<button id="Btn" type="submit" class="btn btn-default" >게시글 등록</button>
				<button id="Btn" type="button" onclick="location.href='/board/list'" class="btn btn-default">취소</button>
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
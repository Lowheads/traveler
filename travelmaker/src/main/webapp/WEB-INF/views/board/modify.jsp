<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="../includes/jeheader.jsp"%>

<div class="container">
	<div class="row">
		<div class="col-1g-12">
			<h1 class="page-header">Board Modify</h1>
		</div>
		<!-- /.col-1g-12 -->
	</div>
	<!-- /.row -->
	<div class="row">
		<div class="col-1g-12">
			<div class="panel panel-default">

				<div class="panel-heading">게시물 수정</div>
				<!-- /.panel-heading -->
				
				

				<div class="panel-body">
					<form role="form" id="modiremoveform" action="/board/modify" method="post" enctype="multipart/form-data">
					<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum }"/>'>
					<input type='hidden' name='amount' value='<c:out value="${cri.amount }"/>'>
						<div class="form-group">
							<label>게시물 번호</label> <input class="form-control" name='boardNo'
								value='<c:out value="${board.boardNo}"/>' readonly="readonly">
						</div>
						<div class="form-group">
							<label>게시물이름</label> <input class="form-control"
								name='boardTitle' value='<c:out value="${board.boardTitle}"/>' >
						</div>

						<div class="form-group">
							<label for="boardimg">대표 사진 업로드</label>
							<div class="form-group uploadDiv">
								<input type="file" id="boardImg" name="file" class="boardImg" >
								<div class="select_img">
									<img src="<c:out value="/resources${board.boardImg}"/>" id="modifyimage" data-image="${board.boardImg }"  />
								</div>
							</div>
						</div>
						<script>
						//사진등록 시 화면에 보여주는 함수
						$("#boardImg").change(function() {
							alert('사진첨부완료');
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
						<div class="form-group">
							<label>공개여부</label> 공개 <input type="radio" name='hidden' value="y" checked> 
							비공개 <input type="radio" name='hidden' value="n">
						</div>

                        <button id="Btn" type="submit" data-oper='modify' class="btn btn-default subbutton">Modify</button>
						<button id="Btn" type="submit" data-oper='remove' class="btn btn-danger subbutton">Remove</button>
						<button id="Btn" data-oper='list' class="btn btn-info subbutton" onclick="location.href='/board/list'">List</button>
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
	var formObj=$("#modiremoveform");
	$('.subbutton').on("click",function(e){
		e.preventDefault();
		
		
		var operation = $(this).data("oper");
		
		if(operation=='modify'){
		var modifyimage = $("#modifyimage");
			if(modifyimage.data("image")==modifyimage.attr("src")){
				alert('수정할 사진을 등록해주세요');
				return;
			}
		}   
		
		else if(operation==='remove'){
			formObj.attr("action","/board/remove");
			
		}else if(operation==='list'){
			//move to list
			formObj.attr("action","/board/list").attr("method","get");
			var pageNumTag = $("input[name='pageNum']").clone();
			var amountTag = $("input[name='amount']").clone();
			formObj.empty();
			formObj.append(pageNumTag);
			formObj.append(amountTag);
			}
			formObj.submit();
			});
		});
</script>  
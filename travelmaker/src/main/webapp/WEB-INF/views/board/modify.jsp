<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="../includes/jeheader.jsp"%>

<link rel="stylesheet" href="/resources/css/main.css">

<div class="wrapper">
	<div class="header_wrapper">
		<div class="header">
			<h3>게시글 수정</h3>
		</div>
	</div>
	
	<div class="contents">
		<div class="ct_head">
				<div class="ct_body">
					<form role="form" id="modiremoveform" action="/board/modify" method="post" enctype="multipart/form-data">
					<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum }"/>'>
					<input type='hidden' name='amount' value='<c:out value="${cri.amount }"/>'>
						
						<div class="form-group">
						 <input type="hidden" class="form-control" name='boardNo' value='<c:out value="${board.boardNo}"/>' readonly="readonly">
						</div>
					
						<div class="form-group">
						<input type="file" id="boardImg" name="file" class="boardImg" accept='image/jpg, image/png, image/jpeg, image/gif' />
							<label for="boardImg">대표 사진 수정</label>
								<input type="hidden" name="boardImg" value="${board.boardImg }">
 								<div class="select_img">
									<img src="<c:out value="/resources${board.boardImg}"/>" id="modifyimage" data-image="${board.boardImg }" 
									width="500px" height="300px" />
								</div> 
						</div>
						<script>
						//사진등록 시 화면에 보여주는 함수
						$("#boardImg").change(function() {
							if (this.files && this.files[0]) {
							var reader = new FileReader;
								reader.onload = function(data) {
							$(".select_img img").attr("src", data.target.result)
								.width(500)
								.height(300);
							}
							reader.readAsDataURL(this.files[0]);
							}
						});
						</script>
					
					
						<div class="form-group">
							<label>게시글 제목</label> <input class="form-control" name='boardTitle' value='<c:out value="${board.boardTitle}"/>' >
						</div>				
						
							<label>공개여부</label> 공개 <input type="radio" name='hidden' value="y" checked> 
							비공개 <input type="radio" name='hidden' value="n"><br>

                        <button id="Btn" type="submit" data-oper='modify' class="btn btn-default subbutton">수정</button>
						<button id="Btn" type="submit" data-oper='remove' class="btn btn-danger subbutton">삭제</button>
						<button id="Btn" data-oper='list' class="btn btn-info subbutton" >취소</button>
					</form>
				</div>
		</div>
	</div>
</div>

<style>
#boardImg{
    width: 0.1px;
	height: 0.1px;
	opacity: 0;
	overflow: hidden;
	position: absolute;
	z-index: -1;
}

#boardImg + label {
    border: 1px solid #d9e1e8;
    background-color: #fff;
    color: #2b90d9;
    border-radius: 2rem;
    padding: 8px 17px 8px 17px;
    font-weight: 500;
    font-size: 15px;
    box-shadow: 1px 2px 3px 0px #f2f2f2;
    outline: none;
}

#boardImg:focus + label,
#boardImg + label:hover {
    cursor: pointer;
}

</style>

<script type="text/javascript">




$(document).ready(function(){
	var formObj=$("#modiremoveform");
	$('.subbutton').on("click",function(e){
		e.preventDefault();
		
		
		var operation = $(this).data("oper");
		
		if(operation==='modify'){
			formObj.attr("action","/board/modify");
			
		var fileCheck=$("#boardImg").val();

		if(fileCheck==""){
			$('.boardImg').prop("type","text");

		}

		}   
		
		else if(operation==='remove'){
			formObj.attr("action","/board/remove");
			
		}else if(operation==='list'){
			//move to list
			formObj.attr("action","/board/get").attr("method","get");
			var boardNo= $("input[name='boardNo']").clone();
			var pageNumTag = $("input[name='pageNum']").clone();
			var amountTag = $("input[name='amount']").clone();
			formObj.empty();
			formObj.append(boardNo);
			formObj.append(pageNumTag);
			formObj.append(amountTag);
			}
			formObj.submit();
			});
		});
</script>  
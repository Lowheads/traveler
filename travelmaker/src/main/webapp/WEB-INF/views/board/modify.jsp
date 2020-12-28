<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<style>

.orgImg {
	width: 100px;
	height: 100px;
}

.select_img{
	text-align:center;
}
.select_img img {
	margin: 20px 0;
}

#boardImg{
    width: 0.1px;
	height: 0.1px;
	opacity: 0;
	overflow: hidden;
	position: absolute;
	z-index: -1;
	margin-left: 10px;
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
    display: inline-block;
}
#boardImg:focus + label,
#boardImg + label:hover {
    cursor: pointer;
}

.btn { 
	font-size:15px;
	color: black;
	margin-bottom: 30px;
	background-color:white;
	border: 1px solid gray;
	border-radius: 14px;
	padding: 5px 20px 5px 20px;
	float: right;
}
.btn:hover{
   background-color: #ff8b3d;
   color:white;
   border: 1px solid #ff8b3d;	
}

.form-control, select, textarea {
  width: 100%;
  padding: 12px;
  border: 1px solid #ccc;
  border-radius: 4px;
  resize: vertical;
  margin-top:10px
}

.form-group label {
    font-weight: bold;
    font-size: 16px;
}

.modifyimg{
	text-align:center;

}
</style>



<form role="form" id="modiremoveform" name="content_form" action="/board/modify" method="post" enctype="multipart/form-data">
	<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum }"/>'> <input type='hidden'
		name='amount' value='<c:out value="${cri.amount }"/>'>

		<input type="hidden" class="form-control" name='boardNo' value='<c:out value="${board.boardNo}"/>' readonly="readonly">

	<div class="modifyimg">
		<input type="file" id="boardImg" name="file" class="boardImg" accept='image/jpg, image/png, image/jpeg, image/gif' /> 
		<label for="boardImg">대표 사진 변경</label> <input type="hidden" name="boardImg" value="${board.boardImg }">
		<div class="select_img">
			<img src="<c:out value="/resources${board.boardImg}"/>"
				id="modifyimage" data-image="${board.boardImg }" width="500px" height="300px" />
		</div>
	</div>
	<script>
		//사진등록 시 화면에 보여주는 함수
		$("#boardImg").change(
				function() {
					if (this.files && this.files[0]) {
						var reader = new FileReader;
						reader.onload = function(data) {
							$(".select_img img")
									.attr("src", data.target.result).width(500)
									.height(300);
						}
						reader.readAsDataURL(this.files[0]);
					}
				});
	</script>


	<div class="form-group">
		<label>게시글 제목</label> 
		<input class="form-control" id='boardTitle' name='boardTitle' value='<c:out value="${board.boardTitle}"/>'>
	</div><br>

	<label>공개여부</label> 공개 <input type="radio" name='hidden' value="y" checked> 비공개 <input type="radio" name='hidden' value="n"><br>
	<button id="modifybtn" type="submit" data-oper='modify'class="btn btn-default subbutton">수정</button>

</form>


<script type="text/javascript">
$(document).ready(function(){
	var formObj=$("#modiremoveform");
	$('.subbutton').on("click",function(e){
		e.preventDefault();
		
		
		var operation = $(this).data("oper");
		
		if(operation==='modify'){
			
			var boardTitle = document.getElementById('boardTitle').value;
			if(boardTitle==""){
				alert('게시글 제목을 입력하세요');
				return;
			}
			document.content_form.target="_parent";
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
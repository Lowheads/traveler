<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%
	request.setCharacterEncoding("UTF-8");
	String schNo=request.getParameter("boardNo");
%>

<%@include file="../includes/header.jsp"%>


<div class="container">    
	<div class="row">
	<div class="col-1g-12">
		<h1 class="page-header">Board Register</h1>
	</div>
	<!-- /.col-1g-12 -->
</div>
<!-- /.row -->

<div class="row">
	<div class="col-1g-12">
		<div class="panel panel-default">
		
		<div class="panel-heading">게시물 등록</div>
		<!-- /.panel-heading -->
		<div class="panel-body">
		
			<form role="form" id="registerform" action="/board/register" method="post" enctype="multipart/form-data">
				<div class="form-group">
					<label>일정번호</label> <input class="form-control" name='schNo' id='schNo' value='${schNo }' readonly="readonly">
				</div>
				
				<div class="form-group">
					<label>게시글이름</label>
					<input class="form-control" name='boardTitle' id='boardTitle'>
				</div>
						<div class="form-group"><label for="boardimg">대표 사진 업로드</label>
							<div class="form-group uploadDiv" >
								<input type="file" id="boardImg" name="file" class="boardImg" required>
								<div class="select_img"><img src=""/></div>
							</div>
						</div>
						<script>
						//사진등록 시 화면에 보여주는 함수
						$("[name=boardTitle]").attr("required",true);
						$("#boardImg").change(function() {
							alert('사진등록');
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
					<label>공개여부</label> 
					공개<input type="radio" name='hidden' value="y" required checked> 
					비공개<input type="radio" name='hidden' value="n">
				</div>
				<br>
				<button type="button" class="btn btn-default" id="dtregister">게시글 상세 등록</button>
				<button type="button" onclick="location.href='/board/list'" class="btn btn-default">취소</button>
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
	//같은 일정번호의 게시물명 중복일 때 알람창 ajax
 	$('#dtregister').on("click",function(e){
		e.preventDefault();
		var formObj = $("#registerform");
		var sendData = {'boardTitle' : document.getElementById('boardTitle').value, 'schNo' : document.getElementById('schNo').value }
		 
  		$.ajax({
			type : 'post',
			url : '/board/titlecheck',
			data : sendData,
			success : function(data){
				if(data==true)
					alert('게시물이 중복입니다');
				else
					formObj.submit();
			}		
	});   
		
	});

</script>

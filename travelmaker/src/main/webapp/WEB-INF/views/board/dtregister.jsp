<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="../includes/jeheader.jsp"%>

<link rel="stylesheet" href="/resources/css/main.css">

<style>
.left-box {
  background: white;
  float: left;
  width: 50%;
}
.right-box {
  background: white;
  float: right;
  width: 50%;
}
.transit, .distance{
 font-size: 13px;
}
.schdt{
  background-color: white; /* Green */
  border: none;
  border-radius: 8px;
  padding: 13px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 15px;
 
}

.place{
 boarder: solid;
 background-color:#FFEFD5;
 text-align: center;
 padding: 10px;
 border-radius: 8px;
 display: inline-block;
 font-size : 14px;
 width: 85px;
}
</style>



<div class="wrapper">    
	<div class="header_wrapper">
	<div class="header">
		<h3>사진 추가</h3>
	</div>
</div>
<div class="contents">
<div class='left-box'>
		<div class="ct_body">	
			<form role="form" action="/board/dtregister" method="post" enctype="multipart/form-data">
			<div class="form-group">
				<label>게시물번호</label>
				<input class="form-control" name='boardNo' value='${board.boardNo }' readonly="readonly">
			</div>
			
			<div class="form-group">
				<label>게시물 이름</label> <input class="form-control" name='boardTitle' value='${board.boardTitle }' readonly="readonly">
			</div>
			
	

			<div class="form-group">
					<label>게시글 설명</label>
					<input class="form-control" name='boardCon'>
			</div>
			<div class="form-group">
			<div style="border: 1px solid #dbdbdb;">
				<div class="flex-container">
						<span id="fileIndex"></span>
				</div>
			</div>
			</div>
			<br>
						<button id="Btn" type="submit" class="btn btn-default" >게시글 등록</button>
						<button id="Btn" type="button" onclick="location.href='/board/list'" class="btn btn-default">취소</button>	
						<button type="button" class="fileAdd_btn btn" >사진추가</button>
	
				</form>
				</div>
			
	</div>
<div class='right-box'>
<div class="ct_body">

	<div style="display:flex; margin:auto; text-align:center">
	<c:forEach items="${schdtplace}" begin="0" end="${schdtplace.size() }" var="schdt1" varStatus="schdtstatus1">
		<c:if test="${schdtplace[schdtstatus1.index].schDate ne schdtplace[schdtstatus1.index-1].schDate}">
		<div class="schdt">
		<c:set var = "count" value="${count+1 }"/>
		<c:out value="${count}"/>일차<br><br>
			<c:forEach items="${schdtplace}" begin="0" end="${schdtplace.size() }" var="schdt2" varStatus="schdtstatus2">
				<c:if test="${schdtplace[schdtstatus1.index].schDate eq schdt2.schDate }">
				<c:choose>
					<c:when test="${schdtplace[schdtstatus2.index-1].schDate ne schdt2.schDate}">
					<%-- <c:out value="${schdt2.schDate }"/><br> --%>
					<span class="place"><c:out value="${schdt2.plcTitle }"/></span><br>
					<span class="transit"><c:out value="${schdt2.transit }"/></span>
					<span class="distance"><c:out value="${schdt2.distance }"/>km</span><br>
					<span class="place"><c:out value="${schdt2.plcTitle1 }"/></span><br>
					</c:when>
					
					<c:when test="${schdtplace[schdtstatus2.index-1].schDate eq schdt2.schDate}">
					<span class="transit"><c:out value="${schdt2.transit }"/></span>
					<span class="distance"><c:out value="${schdt2.distance }"/>km</span><br>
					<span class="place"><c:out value="${schdt2.plcTitle1 }"/></span><br>
					</c:when>
					</c:choose>
				</c:if>	
			</c:forEach>
		</div>
		</c:if>
	</c:forEach>
</div>
</div>
</div>
</div>

</div>


<script type="text/javascript">
$(document).ready(function(){
	fn_addFile();
	function fn_addFile(){
		var fileIndex = 1;
		var contentIndex= 1;
		$(".fileAdd_btn").on("click", function(){
			$("#fileIndex").append("<div><input type='file' id='boarddtImg' name='file_"+(fileIndex++)+"'>"
			+"<div class='select_img'><img src=''/></div>"		
			+"<br><input type='text' name='newContent'/>"
			+"<button type='button' style='float:right;' id='fileDelBtn'>"+"삭제"+"</button></div>");
		});

	
 		$(document).on("change","#boarddtImg",function(){
 			
 			
 			var tmp = $(this);
			if (this.files && this.files[0]) {
				var reader = new FileReader;
					reader.onload = function(data) {
				tmp.next().children().attr("src", data.target.result)
					.width(500);
				}
				reader.readAsDataURL(this.files[0]);
				}
			
		}); 
		
		$(document).on("click","#fileDelBtn", function(){
			$(this).parent().remove();
		
		});
	}
});

</script>
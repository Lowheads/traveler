<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="../includes/jeheader.jsp"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

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

<script type="text/javascript">
		$(document).ready(function(){
			var formObj = $("form[name='updateForm']");
			
			$(document).on("click","#fileDel", function(){
				$(this).parent().remove();
			})
			
			fn_addFile();
			
			$(".cancel_btn").on("click", function(){
				event.preventDefault();
				location.href = "/board/get?boardNo=${board.boardNo }"
						+"&pageNum=${cri.pageNum}"
						+"&amount=${cri.amount}";
			})
			
			$(".update_btn").on("click", function(){
				if(fn_valiChk()){
					return false;
				}
				
				formObj.attr("action", "/board/dtmodify");
				formObj.attr("method", "post");
				formObj.submit();
			})
		})
			
		function fn_valiChk(){
			var updateForm = $("form[name='updateForm'] .chk").length;
			for(var i = 0; i<updateForm; i++){
				if($(".chk").eq(i).val() == "" || $(".chk").eq(i).val() == null){
					alert($(".chk").eq(i).attr("title"));
					return true;
				}
			}
		}
 		function fn_addFile(){
			var fileIndex = 1;
			var i=0;
			$(".fileAdd_btn").on("click", function(){
				$("#fileIndex").append("<div><input type='file' id='boarddtImg' style='float:left;' name='file_"+(fileIndex++)+"'>"+"</button>"
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
 		var fileNoArry = new Array();
 		var fileNameArry = new Array();
 		function fn_del(value, name){
 			
 			fileNoArry.push(value);
 			fileNameArry.push(name);
 			$("#fileNoDel").attr("value", fileNoArry);
 			$("#fileNameDel").attr("value", fileNameArry);
 		}
 		
 		
</script>

<div class="wrapper">
	<div class="header_wrapper">
		<div class="header">
			<h3>사진 수정</h3>
		</div>
	</div>

	<div class="contents">
	<div class='left-box'>
			<div class="ct_body">
				<form:form modelAttrivute="MpFileVO" name="updateForm" role="form"
					method="post" action="/board/dtmodify"
					enctype="multipart/form-data">
					
					<input type='hidden' id='boardNo' name='boardNo' value='<c:out value="${boarddt.boardNo }"/>'>
					<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum }"/>'> 
					<input type='hidden' name='amount' value='<c:out value="${cri.amount }"/>'> 

					<input type="hidden" id="fileNoDel" name="fileNoDel[]" value="">
					<input type="hidden" id="fileNameDel" name="fileNameDel[]" value="">

					<div class="form-group">
						<label>게시물번호</label><input class="form-control" name='boardNo'
							value='${boarddt.boardNo }' readonly="readonly">
					</div>

					<div class="form-group">
					<label>게시물 이름</label> <input class="form-control" name='boardTitle' value='${board.boardTitle }' readonly="readonly">
					</div>
					
					<div class="form-group">
						<label>상세 사진 내용 등록</label><input class="form-control"
							name='boardCon' value='${boarddt.boardCon }'>
					</div>	
					
						<div class="form-group">
						<div class="flex-container">
						<c:forEach var="file" items="${file}" varStatus="var">
							<div style="width:180px">
							<input type="hidden" id="FILE_NO" name="FILE_NO_${var.index}" value="${file.FILE_NO }">
							<input type="hidden" name="fileNo" value="${file.FILE_NO }">
							<input type="hidden" id="FILE_NAME" name="FILE_NAME" value="FILE_NO_${var.index}">
							
							<a href="#" id="fileName" onclick="return false;">${file.ORG_FILE_NAME}</a>(${file.FILE_SIZE}kb)
							<button id="fileDel" onclick="fn_del('${file.FILE_NO}','FILE_NO_${var.index}');">삭제</button><br>
							<img src="<c:url value="/img/${file.STORED_FILE_NAME} "/>"" width="200px" height="200px"/>
							<input type='text' id='content' name='fileContent' value='<c:out value="${file.FILE_CONTENT }"/>'>
							<br>
						</div>
						</c:forEach>
						</div>
					</div>
					
					<div class="form-group">
						<span id="fileIndex"></span>
					</div>	

					<div>
						<button type="button" class="update_btn btn">저장</button>
						<button type="button" class="cancel_btn btn">취소</button>
						<button type="button" class="fileAdd_btn btn">파일추가</button>
					</div>
				</form:form>
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
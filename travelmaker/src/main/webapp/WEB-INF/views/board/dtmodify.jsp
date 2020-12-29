<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
 <%@ include file="../includes/header.jsp" %> 

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css"> -->

<style>
.transit, .distance{
 font-size: 13px;
}

.contents{
	width: 70%;
	margin-top: 50px;
	margin-bottom: 100px;
	margin-left: auto;
	margin-right: auto;

}
.ct_body{
	padding: 30px;
	/* background-image: url('/resources/imgUpload/2020/12/10/ff752342-efbc-4691-b3f5-7d6d5ef9c2fe_다운로드.jpg');  */
	height: 270px;
	background-repeat: no-repeat;
  	background-size: cover;
  	background-position:center center;
  	margin-bottom:10px;
}

.col-25{
  float: left;
  width: 25%;
  margin-top: 6px;

}

.col-75{
  float: left;
  width: 75%;
  margin-top: 6px;


}
/* Clear floats after the columns */
.row:after {
  content: "";
  display: table;
  clear: both;
}

.boardcontainer{
  border-radius: 5px;
  background-color: #f2f2f2;
  padding: 30px 30px 50px 30px;

}
@media screen and (max-width: 600px) {
  .col-25, .col-75 {
    width: 100%;
    margin-top: 0;
  }
}


.form-control, select, textarea {
  width: 100%;
  padding: 12px;
  border: 1px solid #ccc;
  border-radius: 4px;
  resize: vertical;
}


.board_contents{
	width: 100%;
	height: auto;
	background-color: white;
	display:flex;
}

.mainMsg{
	margin-left: 5%;
}

.mainMsg b{
	font-size:30px;
	color:white;

}


/*스케쥴 */
.schedule_dt_box {
   width: 63%;
}

.schdt_top{
   height: 70px;
   display: flex;
}

.dt_top_left{
   width: 15%;
   background-color: #203341;
   color:white;
    text-align: center;
   line-height: 70px;    
   border-right: 1px solid gray;
}

.dt_top_right{
   border-top: 1px solid gray;
   border-right: 1px solid gray;
   padding-left: 10px;
   width: 85%;
   display: flex;
   justify-content: space-between;
}
.daily_date{
   margin-top: auto;
   margin-bottom: auto;
}

.schdt_bottom{
   height: 100px;
   display:flex;
}
.dt_bottom_left{
   width: 15%;
   text-align: center;
   border-top: 1px solid gray;
   border-left: 1px solid gray;
   border-right: 1px solid gray;
   padding-top: 40px;
}

.daily_count{
   font-size:14px;   
   margin-left:auto;
   margin-right:auto;
   color:white;
   background-color:#203341;
   border-radius: 50%;
   width: 20px;
    height: 20px;
    text-align: center;
}

.dt_bottom_right{
   padding-left: 10px;
   width: 85%;
   line-height: 100px;  
   border-right: 1px solid gray;
   border-top: 1px solid gray;
}
.dt_bottom_right img{
   width: 75px;
   height: 75px;
}   
.dt_box_footer{
   display:flex;
   background-color: #e6e6e6;
   border:1px solid gray;
}
.dt_footer_left{
   width: 15%;
   text-align: center;
}

.dt_footer_right{
   width: 85%;
}

#customers {
  font-family: Arial, Helvetica, sans-serif;
  border-collapse: collapse;
  width: 100%;
  table-layout:fixed;
  overflow: hidden;
  border-radius: 15px;
}

#customers td, #customers th {
  border: 1px solid #ddd;
  padding: 8px;
}

#customers tr:nth-child(even){background-color: #f2f2f2;}

#customers tr:hover {background-color: #ddd;}

#customers th {
  padding-top: 12px;
  padding-bottom: 12px;
  text-align: left;
  background-color: #ff8b3d;
  color: white;
}
#tabletitle{

   text-align:center;
}

.left {
     width: 46%;
     margin-right : 4%;

}

.right {
     width: 50%;

}

.fileAdd_btn { 
	font-size: 15px;
    color: black;
    background-color: white;
    border: 1px solid gray;
    border-radius: 14px;
    padding: 5px 10px 5px 10px;
    float:right;
    outline: 0;
}

.btn:hover, .update_btn:hover , .fileAdd_btn:hover{
   background-color: #ff8b3d;
   color:white;
   border: 1px solid #ff8b3d;	
}

.cancel_btn:hover, #fileDel:hover, #fileDelBtn:hover{
   background-color: #A9A9A9;
   color:balck;
   border: 1px solid #A9A9A9;	
}


.cancel_btn{
	font-size:15px;
	margin-bottom: 10px;
	background-color:#e9e9e9;
	border: 1px solid #e9e9e9;
	border-radius: 7px; 
	padding: 5px 20px 5px 20px;
	float: right;
	outline: 0;
}

.update_btn{
	font-size:15px;
	margin-bottom: 10px;
	background-color:#ff8b3d;
	color: white;
	border: 1px solid #ff8b3d;
	border-radius: 7px; 
	padding: 5px 20px 5px 20px;
	float: right;
	outline: 0;
}


.flex-container{
	margin-top: 10px;
	border-radius : 5px;
	background-color: white;
	padding: 50px;

}

/* 파일  */

.orgfilecontent{
 	text-align: right;
 	margin-bottom:20px;
}

.orgfilecontent input{
	margin-top:10px;
}
.filecontent{
	width:100%;
	position: relative;
    overflow: hidden;
}
.filecontent input[type=file]{
	position: absolute;
    top: 0;
    right: 0;
    min-width: 100%;
    min-height: 100%;
    font-size: 100px;
    text-align: right;
    filter: alpha(opacity=0);
    opacity: 0;
    outline: none;
    background: white;
    cursor: inherit;
    display: none;


}

#fileName{
	font-size:13px;
}


/* 
.orgimg img{
	width:100%;
	height:250px;
	margin-top:10px;
	margin-bottom:10px;
} */

#fileDel {
	font-size: 15px;
    color: black;
    background-color: #e9e9e9;
    border: 1px solid #e9e9e9;
    border-radius: 7px;
    padding: 5px 10px 5px 10px;
    outline: 0;
}

.fileDelBtn{
	font-size: 15px;
    color: black;
    background-color: #e9e9e9;
    border: 1px solid #e9e9e9;
    border-radius: 7px;
    padding: 5px 10px 5px 10px;
    margin-top:10px;
    float:right;
    outline: 0;

}

.select_img{
	text-align:center;
	display:inline-block;
}

.select_img img{
	width:100%;
	height:200px;
	margin-top:10px;
	margin-bottom:10px;
	
}



</style>

<div class="contents">
<!--상단 -->

	<div class="board_contents">
	<div class='left'>
			<div class="boardcontainer">
			
				<form:form modelAttrivute="MpFileVO" name="updateForm" role="form" method="post" action="/board/dtmodify"
					enctype="multipart/form-data">
					
					<input type='hidden' id='boardNo' name='boardNo' value='<c:out value="${boarddt.boardNo }"/>'>
					<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum }"/>'> 
					<input type='hidden' name='amount' value='<c:out value="${cri.amount }"/>'>
					<input type="hidden" name='keyword' value='<c:out value="${cri.keyword }"/>'>
					<input type="hidden" name="type" value='<c:out value="${cri.type }"/>'>

					<input type="hidden" id="fileNoDel" name="fileNoDel[]" value="">
					<input type="hidden" id="fileNameDel" name="fileNameDel[]" value="">

					<div class="row">
					<div class="col-25">
					<label>게시글 제목</label>
					</div>
					<div class="col-75">
					 <input class="form-control"  name='boardTitle' value='${board.boardTitle }' readonly="readonly">
					</div>
					</div>
		

					<div class="row">
					<div class="col-25">
						<label>일정명</label>
						</div>
						<div class="col-75">
						<input class="form-control"  value='${schedule.schTitle }' readonly="readonly">
					</div>
					</div>
			
					
					<div class="row">
					<div class="col-25">
						<label>게시글 내용</label>
						</div>
						<div class="col-75">
						<textarea id="boardCon" name='boardCon' style='height:200px'>${boarddt.boardCon }</textarea>
					</div>
					</div>	
					
						<br>
						사진목록
						<div class="flex-container">
						<c:forEach var="file" items="${file}" varStatus="var">
							<div class="orgfilecontent">
							<input type="hidden" id="FILE_NO" name="FILE_NO_${var.index}" value="${file.FILE_NO }">
							<input type="hidden" name="fileNo" value="${file.FILE_NO }">
							<input type="hidden" id="FILE_NAME" name="FILE_NAME" value="FILE_NO_${var.index}">
							
							<a href="#" id="fileName" onclick="return false;">${file.ORG_FILE_NAME}</a><%-- (${file.FILE_SIZE}kb) --%>
							<button id="fileDel" onclick="fn_del('${file.FILE_NO}','FILE_NO_${var.index}');">삭제</button><br>
							<img src="<c:url value="/img/${file.STORED_FILE_NAME} "/>" style='width:100%; height:250px; margin-top:10px; margin-bottom:10px;'/>
							<input type='text' id='content' class='form-control' name='fileContent' value='<c:out value="${file.FILE_CONTENT }"/>'>
							<br>
						</div>
						</c:forEach>

					
					<div class="form-group">
						<button type="button" class="fileAdd_btn">사진추가</button>
						<span id="fileIndex"></span>
					</div>	
						</div>

					<div><br>
						<button type="button" class="cancel_btn">취소</button>
						<button type="button" class="update_btn">수정완료</button>
					</div>
				</form:form>
			</div>
			</div>
			
	<div class='right'>
		<div class="content_wrap">


<table id="customers">
   <tr id="tabletitle">
      <th><i class="fa fa-calendar"></i>날짜</th>
      <th><i class="fa fa-globe"></i>&nbsp도시</th>
      <th><i class="fa fa-thumb-tack"></i>&nbsp일정</th>
      <th><i class="fa fa-car"></i>&nbsp교통</th>
      <!-- <th><i class="fa fa-bed"></i>&nbsp숙소</th> -->
   </tr>
   
   <c:set var="count" value="0"></c:set>
   <c:forEach items="${Schdt}" begin="0" end="${Schdt.size() }" var="schdt" varStatus="status">
       <c:if test="${Schdt[status.index].SCH_DATE ne Schdt[status.index-1].SCH_DATE  }">
       
          <c:set var="count" value="${count+1 }"/>
          
      <tr>
         <td style="text-align:center;"><fmt:formatDate value="${schdt.SCH_DATE}" type="date" dateStyle="full" /><br>
         DAY<c:out value="${count}"/></td>
         <td><i class="fa fa-map-marker"></i>제주도<br>jeju</td>
         <td>
         <c:set var="dtCnt" value="0"/>
         <c:forEach items="${Schdt }" begin="0" end="${Schdt.size() }" var="dt" varStatus="vs">   
            <c:if test="${schdt.SCH_DATE eq dt.SCH_DATE }">
                      <c:if test="${schdt.SCH_DATE eq dt.SCH_DATE}">
                      <c:set var="dtCnt" value="${dtCnt+1 }"/>
                     <c:out value="${dtCnt }"/>.<c:out value="${dt.FROMTITLE }"/><br>
               </c:if>
               
               <!-- 마지막  -->
            <c:if test="${Schdt[status.index].SCH_DATE ne Schdt[vs.index+1].SCH_DATE}">
            <c:out value="${dtCnt+1}"/>.<c:out value="${dt.TOTITLE }"/>
            
            </c:if>
            </c:if>
         </c:forEach>
         </td>
      <td><c:out value="${schdt.TRANSIT }"/></td>
      <!-- <td></td> -->
      </tr>
   
   </c:if>
   </c:forEach>
</table>
</div>
</div>		

</div>

</div>
<%@ include file="../includes/footer.jsp" %>

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
				$("#fileIndex").append("<div class='filebox'><label class='filecontent'><input type='file' id='boarddtImg' style='float:left;' name='file_"+(fileIndex++)+"'>"
				+"<div class='select_img'><img src='/resources/img/plusimg.JPG'/></div></label>"	
				+"<input type='text' class='form-control' name='newContent'/>"
				+"<button type='button' class='fileDelBtn' id='fileDelBtn'>"+"삭제"+"</button></div><br>");
			});
			
	 		$(document).on("change","#boarddtImg",function(){
	 			
	 			
	 			var tmp = $(this);
				if (this.files && this.files[0]) {
					var reader = new FileReader;
						reader.onload = function(data) {
					tmp.next().children().attr("src", data.target.result);
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
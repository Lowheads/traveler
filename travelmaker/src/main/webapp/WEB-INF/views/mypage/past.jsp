<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
    <%@ include file="../includes/header.jsp" %>
<!DOCTYPE html>
<html lang="en">

<head>
   <script
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- HeartEmoji -->
<link rel="stylesheet"
   href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>Document</title>

   <style>
     
   /* 페이징 */
.pagination_bar{
	font-size: 8pt;
  font-weight: 400;
  font-family: 'Open Sans', 'Source Sans Pro', Roboto, 'HelveticaNeue-Light', 'Helvetica Neue Light', 'Helvetica Neue', 'Myriad Pro', 'Segoe UI', Myriad, Helvetica, 'Lucida Grande', 'DejaVu Sans Condensed', 'Liberation Sans', 'Nimbus Sans L', Tahoma, Geneva, Arial, sans-serif;
  -webkit-text-size-adjust: 100%;
  margin: 1em auto;
  text-align: center;
  transition: font-size .2s ease-in-out;
}
.pagination_bar{
 list-style-type: none;
  display: inline;
  font-size: 100%;
  margin: 0;
  padding: .5em;
  }
  
.pagination_btn{
	display: inline-block;
  font-size: 100%;
  width: auto;
  border-radius: 3px;
  cursor: pointer;
}

.pagination_btn a{
	color: #777;
 	font-size: 140%;
 	padding: .5em;
}

.pagination_btn a:hover{
	color: #f60;
}

.pagination_bar .active a{
	color: #f60;
}
a {
   text-decoration: none;
}

body {
   margin: 0;
}

.pick_plan_content {
   width: 100%;
   margin-bottom: 50px;
}

.coverBanner {
  width: 100%;
   height: 450px;
   background: linear-gradient(
            to right,
            rgba(20, 20, 20, 0.8) 1%,
            rgba(20, 20, 20, 0.4) 35%,
            rgba(20, 20, 20, 0.1) 50%,
            rgba(20, 20, 20, 0) 100%
          ), url("/resources/img/mypagebg2.jpg");
   background-size: cover;
   color: white;
   padding-top: 200px;
   padding-bottom: 100px;
   font-size: 50px;
}
.coverBanner b{
 text-shadow: 4px 2px 10px black;
 margin-left:10%;
}
.coverBanner div{
 text-shadow: 4px 2px 10px black;
 margin-left:10%;
 font-size: 18px;
 padding-left: 4px;
}
.pickNav_bar {
   width: 100%;
   height: 50px;
   background-color: white;
   box-shadow: rgba(0, 0, 0, 0.08) 0px 1px 12px;
}

.pickNav_mnu {
   width: 70%;
   height: 100%;
   margin-left: 15%;
   margin-right: 15%;
   display: flex;
   background-color: white;
}

.mnu_box {
   padding: 10px 20px 0 20px;
   text-align: center;
   cursor: pointer;
}

.mnu_box.active {
   padding: 10px 20px 0 20px;
   text-align: center;
   color: white;
   background-color: #ff8b3d;
}

.mnu_box:hover {
   background-color: #ff8b3d;
   color:white;
}

.content_wrap {
   width: 70%;
   margin-left: 15%;
   margin-right: 15%;
}

.content_tap {
  width: 90%;
   height: 100px;
   display: flex;
   font-size: 12px;
   margin-left: auto;
   margin-right:auto;
}

.sch_tap {
   padding-right: 15px;
   margin-right: 15px;
   margin-top: auto;
   margin-bottom: auto;
   border-right: 1px solid gray;
}

.contents {
   padding: 20px;
   width: 100%;
   display: flex;
   flex-wrap: wrap;
   justify-content: start;
}

.card_sch {
   width: 330px;
   height: 270px;
   margin-bottom: 20px;
   margin-left:15px;
   border: 1px solid gray;
}

.sch_Img {
       width: 100%;
    height: 80%;
    background-size: cover;
    text-shadow: 2px 2px 2px grey;
}

.sch_Img_content {
   color: white;
   padding-left: 15px;
   padding-top: 130px;
}

.sch_Img_content b {
   font-size: 20px;
}

.sch_content {
   width: 100%;
   height: 20%;
   background-color: white;
}

.sch_title {
   margin-left: 15px;
   margin-top: auto;
   margin-bottom: auto;
}
</style>
</head>

<body>
   <div class="pick_plan_content">
      <div class="coverBanner">
        <b>여행일정</b>
        <div>계획한 일정들을 확인해보세요</div>
      </div>
      <div class="pickNav_bar">
        <div class="pickNav_mnu">
            <div class="mnu_box " onclick="location.href='/mypage/pickPL'">
               <b>찜한목록</b>
            </div>

            <div class="mnu_box active" onclick="location.href='/mypage/upcoming'">
               <b>여행일정</b>
            </div>
         </div>
      </div>
      <div class="content_wrap">
         <div class="content_tap">
             <div class="sch_tap">
                  <a href="/mypage/upcoming" style="color: black;">계획중인 일정</a>
               </div>
               <div class="sch_tap">
                  <a href="/mypage/past" style="color: #3099dd;"><b>지나간 일정</b></a>
               </div>
         </div>
         <div class="contents">
            <!-- 카드게시물 -->
            <c:forEach items="${list }" var="sch">
            <a href="/mypage/past/get?pageNum=${pageMaker.cri.pageNum }&schNo=${sch.schNo }">
               <div class="card_sch">
                  <div class="sch_Img">
                   <%--   <div class="sch_Img_content">
                        <!-- SCHFROMDATE -->
                        <c:out value="${sch.fromDate }"/>
                        <!-- SCH_TITLE --><br>
                        <b><c:out value="${sch.schTitle }"/></b>
                     </div> --%>
                  </div>
             <div class="sch_content">
                        <div class="sch_title">
                          <!-- SCHFROMDATE -->
                         <c:out value="${sch.fromDate }"/> ~ <c:out value="${sch.toDate }"/>
                        <!-- SCH_TITLE --><br>
                        <b><c:out value="${sch.schTitle }"/></b>
                        </div>
                     </div> 
            </div>
         </a>
            </c:forEach>
         </div>
         
           <div style="text-align: center;">
         <ul class="pagination_bar">
            <c:if test="${pageMaker.prev }">
               <li class="pagination_btn" num="${pageMaker.startPage-1 }"><a>&laquo;</a></li>
            </c:if>

            <c:forEach var="num" begin="${pageMaker.startPage}"
               end="${pageMaker.endPage}">
               <li class="pagination_btn ${pageMaker.cri.pageNum == num ? 'active':'' }" num="${num}">
                  <a> ${num }</a>
               </li>
            </c:forEach>

            <c:if test="${pageMaker.next }">
               <li class="pagination_btn" num="${pageMaker.endPage +1 }"><a>&raquo;</a></li>
            </c:if>
         </ul>
      </div>
      </div>
   </div>
   <form id='actionForm' action="/mypage/past" method='get'>
   <input type='hidden' name='pageNum' value = '${pageMaker.cri.pageNum }'>
</form>
</body>
<%@ include file="../includes/footer.jsp" %>
<script type="text/javascript">
   let actionForm = $("#actionForm");

   $(".pagination_btn").on("click", function(e) {

      e.preventDefault();

      actionForm.find("input[name='pageNum']").val($(this).attr("num"));
      actionForm.submit();
   });

   $(document).ready(function() {
		let imgArr = [
				'https://t1.daumcdn.net/cfile/tistory/993B303359E8954A18',
				'https://t1.daumcdn.net/cfile/tistory/99C0A13359E895480A',
				'https://t1.daumcdn.net/cfile/tistory/997F013359E8954528',
				'https://t1.daumcdn.net/cfile/tistory/993E693359E8954417',
				'https://t1.daumcdn.net/cfile/tistory/99FB8A3359E895421E',
				'https://t1.daumcdn.net/cfile/tistory/99D7EF3359E8954035',
				'https://t1.daumcdn.net/cfile/tistory/99AB833359E8953E0C',
				'https://t1.daumcdn.net/cfile/tistory/99936B3359E8953C27',
				'https://t1.daumcdn.net/cfile/tistory/998E003359E8953828' ]

		let divBg = document.getElementsByClassName('sch_Img');
		for (let i = 0; i < divBg.length; i++) {
			let num = Math.random();

			divBg[i].style.backgroundImage = "url("
					+ imgArr[Math.floor(num * 9)] + ")";
		}

	})
</script>
</html>
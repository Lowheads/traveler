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
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
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

/* 좋아요버튼 test */
.btn_like {
  position: absolute;
  display: block;
  width: 44px;
  height: 44px;
  border: 1px solid #e8e8e8;
  border-radius: 44px;
  font-family: notokr-bold,sans-serif;
  font-size: 14px;
  line-height: 16px;
  background-color: #fff;
  color: #DD5D54;
  box-shadow: 0 2px 2px 0 rgba(0,0,0,0.03);
  transition: border .2s ease-out,box-shadow .1s ease-out,background-color .4s ease-out;
  cursor: pointer;
}

.btn_like:hover {
  border: 1px solid rgba(228,89,89,0.3);
  box-shadow: 0 2px 4px 0 rgba(228,89,89,0.2);
}

.btn_unlike .img_emoti {
    background-position: -30px -120px;
}
.btn_like:focus{
   border: 0;
   outline: 0;
}
.img_emoti {
    display: inline-block;
    overflow: hidden;
    font-size: 0;
    line-height: 0;
    background: url(https://mk.kakaocdn.net/dn/emoticon/static/images/webstore/img_emoti.png?v=20180410) no-repeat;
    text-indent: -9999px;
    vertical-align: top;
    width: 20px;
    height: 17px;
    margin-top: 1px;
    background-position: 0px -120px;
    text-indent: 0;
}

.btn_like .ani_heart_m {
    margin: -63px 0 0 -63px;
}

.ani_heart_m {
    display: block;
    position: absolute;
    top: 50%;
    left: 50%;
    width: 125px;
    height: 125px;
    margin: -63px 0 0 -63px;
    pointer-events: none;
}

.ani_heart_m.hi {
    background-image: url(https://mk.kakaocdn.net/dn/emoticon/static/images/webstore/retina/zzim_on_m.png);
    -webkit-background-size: 9000px 125px;
    background-size: 9000px 125px;
    animation: on_m 1.06s steps(72);
}

.ani_heart_m.bye {
    background-image: url(https://mk.kakaocdn.net/dn/emoticon/static/images/webstore/retina/zzim_off_m.png);
    -webkit-background-size: 8250px 125px;
    background-size: 8250px 125px;
    animation: off_m 1.06s steps(66);
}

@keyframes on_m {
  from { background-position: 0 }
  to { background-position: -9000px }
}

@keyframes off_m {
  from { background-position: 0 }
  to { background-position: -8250px }
}
/* 좋아요버튼 */

      .pick_plan_content {
         width: 100%;

      }

      .coverBanner {
         width: 100%;
         height: 20%;
         background-image: url("https://free4kwallpapers.com/uploads/originals/2019/10/15/ocean-sunset-wallpaper.jpg");
         background-size: cover;
         text-align: center;
         color:white;
         padding-top:100px;
         padding-bottom: 100px;
         font-size: 50px;
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
   background-color:#ff8b3d;
     color:white;
}
      .content_wrap {
         width: 70%;
         margin-left: 15%;
         margin-right: 15%;
         
      }

      .content_tap {
         width: 100%;
         height: 100px;
         display: flex;
         font-size: 12px;
         justify-content: space-between;
      }
      
      .tap_box{
         display:flex;
      }
      
      .sch_tap{
         padding-right: 15px;
         margin-right: 15px;
         margin-top: auto;
         margin-bottom: auto;
         border-right:1px solid gray;
      }

      .contents {
         padding: 20px;
         width: 100%;
         display:flex;
         flex-wrap: wrap;
         justify-content: space-around;
      }
      .card_sch{
         width: 330px;
         height: 270px;
         margin-bottom: 20px;
         border: 1px solid gray;
      }
   
.sch_Img {
   width: 100%;
   height: 70%;
   overflow:hidden;
   background-color: black;
}
.sch_Imgbg{
   background-size:cover; 
   background-repeat: no-repeat; 
   background-position:center cetner; 
   width:100%; 
   height:100%; 
   cursor: pointer;
}
.sch_Img:hover .sch_Imgbg{
     transform: scale(1.3);
     transition: all 3s;
     opacity: 0.5;
}

.white_layer{
   height: 34px;
   position: absolute;
   opacity: 0;
   padding: 15px;
}

.sch_Img:hover .white_layer{
   opacity: 1;
}

.sch_Img:hover .btn_like{
   z-index:100000;
}

      .sch_content{
         width: 100%;
         height: 30%;
         background-color: white;
      }
      .sch_title{
         margin-left: 15px;
         padding-top: 10px;
      }
      
      .sch_title_text{
         font-weight:bold;
         font-size: 23px;
      }

   </style>
</head>

<body>
   <div class="pick_plan_content">
      <div class="coverBanner">
         <b>여행일정</b>
      </div>
      <div class="pickNav_bar">
         <div class="pickNav_mnu">
         <div class="mnu_box" onclick="location.href='/mypage/pickPL'">
               <b>찜한장소</b>
            </div>

            <div class="mnu_box active" onclick="location.href='/mypage/pickSch'">
               <b>여행일정</b>
            </div>
         </div>
      </div>
      <div class="content_wrap">
         <div class="content_tap">
            <div class="tap_box">
               <div class="sch_tap" style="margin-left: 20px">
                  <a href="/mypage/pickSch" style="color: #3099dd"><b>찜한 일정</b></a>
               </div>
               <div class="sch_tap">
                  <a href="/mypage/upcoming" style="color: black;">계획중인 일정</a>
               </div>
               <div class="sch_tap">
                  <a href="/mypage/past" style="color: black;">지나간 일정</a>
               </div>
            </div>
            <select id="listSort" style="align-self: center;">
               <option hidden selected disabled></option>
               <option value="like">좋아요 순</option>
               <option value="new">최근에 찜한 순</option>
               <option value="old">오래전에 찜한 순</option>
            </select>
         </div>


         <div class="contents">
            <!-- 카드게시물 -->
            <c:forEach items="${list }" var="sch">
               <div class="card_sch">
                     <div class="sch_Img">
                        <div class="white_layer">
                           <button type="button" class="heartbtn btn_like btn_unlike"
                              data-sch_no="${sch.SCH_NO}">
                              <span class="img_emoti">좋아요</span> <span class="ani_heart_m"></span>
                           </button>
                        </div>
                        <!-- 스케줄썸네일임 원래는 -->
                        <div class="sch_Imgbg" num="${pageMaker.cri.pageNum }" data-sch_no="${sch.SCH_NO}"
                           style="background-color: gray;"></div>
                     </div>
                  <div class="sch_content">
                        <!-- USER_NICKNAME -->
                     
                     <div class="sch_title">
                  <a href="/mypage/pickSch/get?pageNum=${pageMaker.cri.pageNum }&schNo=${sch.SCH_NO}" class="sch_title_text"><c:out value="${sch.SCH_TITLE }"/></a><br>
                        <i class="fa fa-user-o" aria-hidden="true" style="color: black;"></i> <c:out value="${sch.NICKNAME }"/>
                        <span style="float:right; margin-right: 10px;"><i class="fa fa-heart-o" aria-hidden="true"></i>
                         <span style="font-size: 12px;">${sch.PICK_CNT}</span></span><br> 
                     </div>

                  </div>
               </div>
            </c:forEach>
         </div>
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
   
   
   <form id='actionForm' action="/mypage/pickSch" method='get'>
   <input type='hidden' name='pageNum' value = '${pageMaker.cri.pageNum }'>
   <input type='hidden' name='selected' value = <%= request.getParameter("selected") %>>
</form>


</body>
<script type="text/javascript">
   $(document).ready(function() {

      selectVal();

   });
   
   
   let actionForm = $("#actionForm");

   $(".pagination_btn").on("click", function(e) {

      e.preventDefault();

      actionForm.find("input[name='pageNum']").val($(this).attr("num"));
      actionForm.submit();
   });

   //조와요
   $(".heartbtn").click(function(){
      
      let heartbtn = $(this);
      
      let sendData = {
               'schNo' : heartbtn.data('sch_no'),
               }
       
      if(heartbtn.hasClass('btn_unlike')){
         //ajax 기능 추가 
         $.ajax({
                  type : 'post',
                  url : '/mypage/deletePick',
                  data : sendData,
                  success : function(data) {
                     heartbtn.removeClass('btn_unlike');
                     heartbtn.children().last().removeClass('hi');
                     heartbtn.children().last().addClass('bye');
                     heartbtn.parent().parent().parent().children().children().children('span').children('span')
                     .text(heartbtn.parent().parent().parent().children().children().children('span').children('span').text()-1)
                  },
                  error : function(error) {
                     alert("에러발생!! 다시시도해주세요" + error);
                  }
               }); 
      } 
       else{
         //ajax 기능 추가 
         $.ajax({
                  type : 'post',
                  url : '/mypage/insertPick',
                  data : sendData,
                  success : function(data) {
                     heartbtn.addClass('btn_unlike');
                     heartbtn.children().last().addClass('hi');
                     heartbtn.children().last().removeClass('bye');
                     heartbtn.parent().parent().parent().children().children().children('span').children('span')
                     .text(Number(heartbtn.parent().parent().parent().children().children().children('span').children('span').text())+1)
                  },
                  error : function(error) {
                     alert("에러발생!! 다시시도해주세요" + error);
                  }
               }); 
               
      }
   });
   
   
$("#listSort").change(function() {
   location.replace("/mypage/pickSch?selected=" + this.value);
});


$(".sch_Imgbg").on("click",function(){
   
   location.href = "/mypage/pickSch/get?pageNum="+$(this).attr('num')+"&"+"schNo="+$(this).data('sch_no');
})

//셀렉트 value 값 설정
function selectVal() {
   var selVal = document.location.href.split("selected=");

   var selArr = $("#listSort option");
   if (selVal[1] == undefined || selVal[1] == 'null') {
      selArr[0].innerHTML = "정렬 기준";
   }
   if (selVal[1] == "like") {
      selArr[0].innerHTML = "좋아요 순";
   }
   ;
   if (selVal[1] == "new") {
      selArr[0].innerHTML = "최근에 찜한 순";
   }
   ;
   if (selVal[1] == "old") {
      selArr[0].innerHTML = "오래전에 찜한 순";
   }
   ;
}
</script>
</html>
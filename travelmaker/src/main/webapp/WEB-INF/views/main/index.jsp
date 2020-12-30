<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
 <%@ include file="../includes/header.jsp" %>
<%String mem= String.valueOf(session.getAttribute("memNo")); %>
<!--  <link rel="stylesheet" href="/resources/css/main.css">  -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href='//spoqa.github.io/spoqa-han-sans/css/SpoqaHanSansNeo.css' rel='stylesheet' type='text/css'>
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<script
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript"
   src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
<script type="text/javascript"
   src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
   <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
<link rel="stylesheet"
   href="http://code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css" />
<script type="text/javascript"
    src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
    <link rel="stylesheet" type="text/css"
        href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />   

<meta http-equiv="Content-Type" content="text/html" charset="UTF-8">

<style>
button{
	outline: 0;
}
/* 좋아요버튼 test */
.btn_like {
  right:10%;
  position: absolute;
  /* display: block; */
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

/* daterangepicker 디자인 수정 */
 .daterangepicker{
position: absolute;
    border-radius: 20px;
    padding: 18px;
} 
/* .opensright{
	width:42%;
} */
.daterangepicker .calendar-table table{
	border-collapse: inherit;
	font-size:12px;
	text-align:center;
}
.daterangepicker .calendar-table th, .daterangepicker .calendar-table td{
	font-size:13px;
	height: auto;
}


.daterangepicker:before, .daterangepicker:after{
	  all: unset;
}

.daterangepicker:before, .daterangepicker:after{
	 position: absolute;
  display: inline-block;
  border-bottom-color: rgba(0, 0, 0, 0.2);
}

.daterangepicker td.active, .daterangepicker td.active:hover {
    background-color: #ff8b3d;
    border-color: transparent;
    color: #fff;
}
.daterangepicker .calendar-table {
	padding: 10px;
	}
	
.table-condensed{
	border-spacing:10px;
}
/* daterangepicker 디자인 끝 */
.btn{
	width: 130px;
    height: 35px;
    text-align: center;
    background-color: #ff8b3d;
    color: white;
    border: 1px solid white;
}
.cancelBtn{
    font-size: 17px;
    font-weight: bold;
    margin: 2%;
}
/* 날씨 */
 .weather {
      position: relative;
      float:right;
      display: flex;
      color: white;
    }
    .weather div {
      width: 50px;
      text-align: center;
    }
    .City {
     color: black;
    }
    .weatherContent {
      color: white;
    }
    .day {
      font-size: 10px;
    }
    .Icon,
    .Temp {
      font-size: 10px;
    }
    .Icon {
      margin-right: 2px;
    }
/*  */
/* test style */
        /* 모달창 */
 #modal {
   display: none;
   width: 500px;
   height: 700px;
   /* background-image: url("/resources/img/test_bg.png");
            background-size:cover; */
   border: 1px solid #888;
   border-radius: 15px;
   background-color: rgb(244, 246, 250);
}
/* 닫는버튼 */
#modal .modal_close_btn {
   float: right;
   border: none;
   border-radius: 15px;
   background-color: rgb(244, 246, 250);
}
#test {
   width: 100%;
   height: 100%;
   padding: 20px;
   border-radius: 15px;
}
.progbarbg {
   background: #f0f0f0;
   height: 10px;
   width: 100%;
   border-radius: 10px;
   margin-top: 40px;
   margin-bottom: 40px;
}
.progbar {
   background: #00F260; /* fallback for old browsers */
   background: -webkit-linear-gradient(to left, #0575E6, #00F260);
   /* Chrome 10-25, Safari 5.1-6 */
   background: linear-gradient(to left, red,orange);
   /* W3C, IE 10+/ Edge, Firefox 16+, Chrome 26+, Opera 12+, Safari 7+ */
   height: 10px;
   width: 0%;
   border-radius: 10px;
   transition: width 400ms;
}
#question {
   text-align: center;
   font-size: 25px;
   font-weight: bold;
   height: 15%;
}

#result {
   text-align: center;
   display: none;
}

.answer {
   text-align: center;
   width: 100%;
   height: 100px;
   background-color: #e8ecf1;
   padding: 10px;
   border-radius: 40px;
   margin-top: 30px;
   font-weight: bold;
   padding: 40px 0;
}

.yourList {
   width: 100%;
   text-align: left;
   padding: 2%;
}

.resultplacedt {
   display: flex;
}

.resultplacedt h6 {
   margin-top: auto;
   margin-bottom: auto;
   margin-left: 15px;
}
/* test 스타일 끝 */
body{
   margin: 0;
}
a{text-decoration: none}
.ct_body{
   padding: 30px;
   background-image: url('https://images.unsplash.com/photo-1593182440709-4b7b56482c55?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=1050&q=80');
   height: 700px;
   background-repeat: no-repeat;
     background-size: cover;
     margin-bottom:50px; 
}
#mainNav{
    box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
   text-align:center;
   margin-top: 100px;
   margin-left:auto;
   margin-right:auto;
   margin-bottom: 150px;
   width: 60%;
   height: 12%;
   background-color:white;
   border-radius: 40px;
   display:flex;
   justify-content: flex-start;            
   flex-grow: 1;
}
.navContent{
   padding-top:15px;
   height:100%;
   flex-basis: 35%;
}
.navContent:hover{
   background-color: rgb(128,128,128,0.1);
   border-radius: 40px;
}
.navDateBtn{
   padding-top:15px;
   height:100%;
   flex-basis: 30%;
}
.navDateBtn:hover{
   background-color: rgb(128,128,128,0.1);
   border-radius:40px;
}
.navDateBtn:hover .selectContent{
   border:none;
}
.navDateBtn .selectContent{
   border-left: 1px solid rgb(128,128,128,0.3);
}
.navSearchBtn{
   padding-top:15px;
   height:100%;
}
.selectContent{
   margin-top:auto;
   margin-bottom:auto;
   text-align: left;
   color: gray;
}
.selectContent b{
   color:black;
   font-size: 12px;
   text-align: left;
}
.selectRegionBox{
   position: absolute;
   display:none;
   width: 500px;
   height: 200px;
   background-color: white;
   border-radius: 40px;
   margin-top: 1.3%;
   box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19); 
   padding: 30px;
   flex-wrap: wrap;
   align-content:flex-end;
}
.region{
   height:45px;
   border-radius:10px;
   margin-right: 10px;
   padding:10px;
   border:1px solid rgb(128,128,128,0.2);
   margin-top:20px;
}
.region:hover{
   color: white;
    background-color: #ff8b3d;
}
.datepickerBox{
   position:absolute;
   bottom:60px;
   left:20%;
   height:400px;
   width: 900px;
   background-color: white;
   border-radius: 40px;
   box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19); 
   display:none;
}
#goNext{
   background-color: #ff8b3d;
   border-radius: 50%;
   height: 50px;
   width: 50px;
}
.material-icons{
   color:white;
   margin: 10px;
   font-size: 10px;
}
.mainMsg{
   margin-left: 7%;
}
.mainMsg b{
   font-size:50px;
   color:white;
   text-shadow: 2px 2px gray;
}
#popup_open_btn{
   font-size:12px;
   margin-right: 1%;
   margin-bottom: 50px;
   background-color:white;
   border: 1px solid gray;
   border-radius: 10px;
   padding: 7px 10px 7px 10px;
   box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
}
#goList{
  float:right;
   font-size:15px;
   margin-right: 3%;
   margin-bottom: 50px;
   background-color:white;
   border: 1px solid gray;
   border-radius: 14px;
   padding: 5px 20px 5px 20px;
}
#goList:hover{
    background-color:#ff8b3d;
   color:white;
   border: 1px solid #ff8b3d;
   border-radius: 14px;
}
.boardContents{
   width: 100%;
   height: auto;
   background-color: white;
   display:inline-block;
}
.gallery {
   width: 100%;
   height: 100%;
   display : flex;
   justify-content: center;
   flex-wrap: wrap;
   margin : 0 auto;
}
.card-contents{
   width: 15%;
   height: 450px;
   position: relative;
    z-index: 1;
     display: block;
    margin-right: 15px;
     margin-bottom: 10px;
     border-radius: 10px;
}
.card-Img{
   position : relative;
   background-size: cover;
   width: 100%;
   height: 70%;
   border-radius: 10px;
   background-position: center; 
   background-repeat: no-repeat; 
   background-size: cover;
}
/* .card-Img Img{
   width: 100%;
   height: 100%;
   border-radius: 10px;
   
} */
.card-desc{
   margin: 10px;
   height: auto;
   font-size: 15px;
}
.desc_bottom{
    font-size : 12px;
}
/* .card-Title{
   margin-top: 10px;
   height: auto;
   font-size: 15px;
} */
/* selectbox */
</style>


<body>
      <div class="contents">
      
      
      <!-- 상단 -->
      <div class="ct_body">
      
      <!--날씨 -->
          <div class='weather'>
  </div>
         <div id="mainNav">
            <div class="navContent navBtnNodeList"  style="text-align: center;">

               <div class="selectContent navBtnNodeList" style="margin-left:40px;">
                  <div><b class="navBtnNodeList">위치</b></div>
                  <div class="navBtnNodeList">어디로 여행가세요?</div>
               <div class="selectRegionBox">
                     <div class="region" data-region-no="1">제주시</div>
                     <div class="region" data-region-no="2">서귀포시</div>
                     <div class="region">속초시</div>
                     <div class="region">여수시</div>
                     <div class="region">부산광역시</div>
                     <div class="region">광주광역시</div>
                     <div class="region">경주시</div>
                     <div class="region">대구광역시</div>
               </div>
               </div>

            </div>
            <div class="navDateBtn dateNodeList dateSelectBox">
               <!-- <input type="text" name="daterange" class="data-range-picker" style="border:none; width:220px"; /> -->
               <div class="selectContent dateNodeList"
                  style="margin-left: 30px; padding-left: 30px;">
                  <div class="dateNodeList">
                     <b class="dateNodeList">출발일</b>
                  </div>
                  <div class="dateNodeList">날짜추가</div>
                     <div class="datepickerBox dateNodeList">
                     </div>
               </div>
            
            </div>

            <div class="navDateBtn datedateBtn">
               <div class="selectContent dateNodeList" 
                  style="margin-left: 30px; padding-left: 30px;">
                  <div class="dateNodeList">
                     <b class="dateNodeList">도착일</b>
                  </div>
                  <div class="dateNodeList">날짜추가</div>
               </div>
            </div>


            <div class="navSearchBtn" style="display:flex; justify-content: space-between;">
            <div></div>
               <div id="goNext" style="float:right; margin-right:10px;"><i class="fa fa-search" style="color:white; margin-top:15px; margin-bottom: 15px; cursor:pointer; " aria-hidden="true"></i>
            </div></div>
         
         </div>
         
         <div class="mainMsg">
         <b>이제, 여행은 <br>
         가까운 곳에서</b>
         <br><br>
         <button id="popup_open_btn">여행성향검사</button>
         
<!--  test 모달창 -->
    <div id="modal">

        <div id="test">
        <!-- 닫는버튼 -->
        <button class="modal_close_btn">X</button>
            <div id="result">

            </div>
            <div id="progbar"></div>
            <div id="question"></div>
            <div id="answers">
                <div class="answer"></div>
                <div class="answer"></div>
            </div>
        </div>

    </div>
         
         </div>
      </div>




      <!-- 관리자 게시판리스트 출력 -->
   
         <button id="goList" onclick="location.href='/board/list'">더보기</button>
   
         <div class="boardContents">
            <div class="gallery">
               <c:forEach items="${adminlist }" var="adminlist">
                  <div class="card-contents">
					<c:set var="mem" value="<%=mem %>"/>
                     <c:set var="coverimg" value="${fn:replace(adminlist.boardImg, '\\\\', '/')}" />
                     
                    <c:choose>
					<c:when test="${mem eq 'null'}">
                     <a href='/board/view?boardNo=<c:out value="${adminlist.boardNo }"/>'>
                     </c:when>
     
                     <c:otherwise>
                     <a href='/board/get?boardNo=<c:out value="${adminlist.boardNo }"/>'>
                     </c:otherwise>
                     </c:choose>
                                   
                     <div class="card-Img" style="background-image: url(/resources${coverimg});" >
                     </div>
                        </a>
                        <div class="card-desc">
                           <b><a href='/board/get?boardNo=<c:out value="${adminlist.boardNo }"/>'>
                           <c:out value="${adminlist.boardTitle }" /></a></b>
                           <div class="desc_bottom">
                              <i class="fa fa-eye"></i>&nbsp<c:out value="${adminlist.VCnt }"/>
                              <i class="fa fa-heart-o"></i>&nbsp<c:out value="${adminlist.pickCnt }"/>
                              <div style="float:right;"><i class="fa fa-pencil-square-o" ></i>&nbsp<c:out value="${adminlist.writer }"/></div>
                           
                           </div>
                           
                        </div>
                  </div>
               </c:forEach>

            </div>
            <!-- 갤러리끝 -->
         </div>
         <!-- 게시판끝 -->
      </div>
</body>


<script type="text/javascript">
   var startDate;
   var endDate;
   $(function() {
      $('.dateSelectBox').daterangepicker({
         startDate : moment(),
         endDate : moment(),
         minDate : moment(),
         locale : {
            format : 'YYYY-MM-DD'
         },
      }, function(start, end, label) {
         /* console.log("A new date selection was made: " + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD')); */
         startDate = start.format('YYYY-MM-DD');
         endDate = end.format('YYYY-MM-DD');
         document.getElementsByClassName("dateNodeList")[4].innerHTML = "<b style=font-size:15px;color:black;>"+start.format('MM월 DD일')+"</b>";
         document.getElementsByClassName("dateNodeList")[9].innerHTML = "<b style=font-size:15px;color:black;>"+end.format('MM월 DD일')+"</b>";
      });
      document.getElementById("goNext").addEventListener("click", submitData);
      initDate();
   });
   function initDate() {
      let datePicker = document.getElementsByClassName("data-range-picker")[0];
      let dateList = datePicker.value.split(' - ');
      startDate = dateList[0];
      endDate = dateList[1];
   }
   function submitData() {
      let optionRegionNo =document.getElementsByClassName("navBtnNodeList")[4].dataset['regionno'];
      console.log(startDate);
      console.log(endDate);
      let form = document.createElement('form');
      let objs1;
      objs1 = document.createElement('input');
      objs1.setAttribute('type', 'hidden');
      objs1.setAttribute('name', 'schRegion'); // 받을 네이밍
      objs1.setAttribute('value', optionRegionNo);
      form.appendChild(objs1);
      let objs2;
      objs2 = document.createElement('input');
      objs2.setAttribute('type', 'hidden');
      objs2.setAttribute('name', 'toDate'); // 받을 네이밍
      objs2.setAttribute('value', endDate);
      form.appendChild(objs2);
      let objs3;
      objs3 = document.createElement('input');
      objs3.setAttribute('type', 'hidden');
      objs3.setAttribute('name', 'fromDate'); // 받을 네이밍
      objs3.setAttribute('value', startDate);
      form.appendChild(objs3);
      form.setAttribute('method', 'post');
      form.setAttribute('action', "/main/theme"); // URL
      document.body.appendChild(form);
      form.submit();
   }
   
   
    function modal(id) {
        
        var zIndex = 9999;
        var modal = document.getElementById(id);
        // 모달 div 뒤에 희끄무레한 레이어
        var bg = document.createElement('div');
        bg.setStyle({
            position: 'fixed',
            zIndex: zIndex,
            left: '0px',
            top: '0px',
            width: '100%',
            height: '100%',
            overflow: 'auto',
            // 레이어 색갈은 여기서 바꾸면 대
            backgroundColor: 'rgba(0,0,0,0.4)'
        });
        document.body.append(bg);
        // 닫기 처리
        modal.querySelector('.modal_close_btn').addEventListener('click', function () {
            init();
            bg.remove();
            modal.style.display = 'none';
        });
        modal.setStyle({
            position: 'fixed',
            display: 'block',
            boxShadow: '0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19)',
            // 시꺼먼 레이어 보다 한칸 위에 보이기
            zIndex: zIndex + 1,
            // 모달 가운데 이쁘게
            top: '50%',
            left: '50%',
            transform: 'translate(-50%, -50%)',
            msTransform: 'translate(-50%, -50%)',
            webkitTransform: 'translate(-50%, -50%)'
        });
    };
    // 이건 먼지모르겟음..
    Element.prototype.setStyle = function (styles) {
        for (var k in styles) this.style[k] = styles[k];
        return this;
    };
    // 모달창 띄우기
    document.getElementById('popup_open_btn').addEventListener('click', function () {
        modal('modal');
    });
    function init() {
        var cnt = 0;
        aCnt = 0;
        qCnt = 0;
        pI = 0;
        pE = 0;
        pF = 0;
        pT = 0;
        pS = 0;
        pN = 0;
        prog = 0;
        $('.progbar').width('0%')
        $('#result').hide().empty();
        $('#answers').show()
        $("#question").text("1." + question[0]).show()
        $('#progbar').show()
        answer[0].innerText = answers[0][0];
        answer[0].removeEventListener("click",atest);
        answer[1].innerText = answers[0][1];
        answer[1].removeEventListener("click",atest);
    }
    let question = [
        "나에게 ... 여행이란?",
        "누구와 함께?",
        "무언가를 시도할때 나는?",
        "사장님이 이틀포상 휴가를 줬을 때, 당신의 선택은?",
        "숙소를 구할때 나는?",
        "같이 여행가기로한 친구가 여행 계획을 짜왔을때 당신의 반응은?",
        "나는 여행지를 선택할때 주로?",
        "나는 여행지에 대한 감상을?",
        "화려한 건축물을 보며 드는 생각은?",
        "친구가 쓸데없는 기념품을 살때?",
        "여행을 갈때 계획은?",
        "여행지에서 길을 잃었을때?",
        "여행 경비는?",
        "여행지에서 식사할때?",
        "여행가서 아침에 늦잠을 잔 친구에게 당신이 건넨 말?"
    ]
    let answers = [
    ["아무것도 하지않고 쉬는것도 여행이라고 생각한다.", "일분일초를 의미있게 보내야 그것이 비로소 여행이다."], //IE
        ["역시 혼자 자유로운게 좋아", "무엇을 하는지 보다 누구와 함께하는지가 중요하다."], //IE
        ["마음에 안정감을 주는 익숙한 것들이 좋다", "새로운 경험을 하고 새로운 사람을 만나는 일이 즐겁다."], //IE
        ["집순이, 집돌이", "밖순이, 밖돌이"], //IE
        ["조용하고 아늑한 곳", "저녁에 바비큐 파티를 여는 곳"], //IE
        ["친구가 얼마나 고민했을지 생각해서라도 그대로 따른다", "맘에 안드는 부분이있으면 바로 말한다"], //TF
        ["나무가 많은 자연으로", "사람이 많은 도시로"],  //TF
        ["내 마음속에 저장, 마음에 담고 느낀다", "말로 내뱉어야 직성이 풀린다"],   //TF
        ["와 멋있다... 감탄한다", "어떤 방법으로 지었을까? 생각에 빠진다"],   //TF
        ["그래 니가 행복하다면야..", "그거 결국 쓰레기된다.."],    //TF
        ["내가 걷는 길이 여행코스", "계획은 필수"],  //SN
        ["자꾸 걸어가면 길이 있겠지, 지구는 둥그니까", "왔던길로 돌아가는 헨젤과 그레텔 st."],  //SN
        ["당장 국제거지만 안되면 되지", "걸어다니는 계산기로 변신"],   //SN
        ["처음본순간 사랑에 빠진 길거리가게", "유~명한 맛집헌터"],   //SN
        ["쉬는것도 여행의 일부지 서두르지 말자", "잘 시간이 어딨어! 계획에서 어긋나면 안돼"]   //SN
    ]
    let personalityDt = [
        "독창적인 세계관이 있으며 반복되는 일상에 무료함을 느끼고 있습니다.<br> 현실에 구애받지 않는 자유로운 성격이기도 합니다",
        "빠른 판단력을 가진 사람입니다.<br> 끈기가 넘치고 의지가 강한 성격입니다",
        "감성적이고 따뜻한 사람이에요.<br> 화려한 풍경속의 고독을 즐기는 성격이네요",
        "안정감있는 상황을 좋아하는 성격입니다.<br> 주변사람들로부터 성실하고 다정하다는 소리를 자주 듣곤 합니다.",
        "활동적이고 에너지가 넘치는 성격이네요.<br> 아이디어가 넘치는 타입",
        "활력이 넘치는 성격이에요.<br> 호불호가 확실하고 애매모호한 것을 싫어해요 ",
        "인싸기질이 타고났어요.<br> 또한 낙천적인 성격이며 매사에 열정적인 타입입니다",
        "겉보기와 달리 마음이 여린 성격이에요.<br> 주변에 사랑을 퍼주는 사람입니다"
    ]
    $(document).ready(function () {
       $("#progbar").html("<div class='progbarbg'><div class='progbar' style='width:0%; text-align:center;'></div></div></div>")
        $("#question").html("1." + question[0])
        let answer = document.getElementsByClassName("answer");
        answer[0].innerText = answers[0][0];
        answer[1].innerText = answers[0][1];
    });
    
    let aCnt = 0;   
    let qCnt = 0;
    let pI = 0;
    let pE = 0;
    let pF = 0;
    let pT = 0;
    let pS = 0;
    let pN = 0;
    let answer = document.getElementsByClassName("answer");
   let prog = 0;
    $('.answer').on("click", function () {
       prog+=6.7;
       progMove(prog);
        let result = this.innerText;
        if (0 <= qCnt && qCnt <= 4) {
            if (result == answers[aCnt][0]) pI++;
            if (result == answers[aCnt][1]) pE++;
        }
        if (5 <= qCnt && qCnt <= 9) {
            if (result == answers[aCnt][0]) pF++;
            if (result == answers[aCnt][1]) pT++;
        }
        if (10 <= qCnt && qCnt <= 14) {
            if (result == answers[aCnt][0]) pS++;
            if (result == answers[aCnt][1]) pN++;
        }
        if(qCnt<=13){
        $("#question").text(qCnt + 2+ "." + question[qCnt + 1])
        // console.log(count)
        answer[0].innerHTML = answers[aCnt + 1][0];
        answer[1].innerHTML = answers[aCnt + 1][1];
        qCnt += 1;
        aCnt += 1;
        if (answer[0].innerText == answers[answers.length - 1][0]) {
            answer[0].addEventListener("click", atest);
            answer[1].addEventListener("click", atest);
            // db 에 닉네임값 저장하고 결과 띄워주기
        }
        }
    })
    //결과 띄워주고 디비에 인서트하는 함수
    function atest() {
        let resultA,resultB,resultC;
        if(pI<pE){
            resultA = 'E';
        }
        if(pI>pE){
            resultA = 'I';
        }
        if(pF<pT){
            resultB = 'T';
        }
        if(pF>pT){
            resultB = 'F';
        }
        if(pS<pN){
            resultC = 'N';
        }
        if(pS>pN){
            resultC = 'S';
        }

        let yourType = resultA+resultB+resultC,
        typeDt;
        if(yourType=='ITS'){
            typeDt = personalityDt[0]
            yourType = '자연여행'
        }
        if(yourType=='ITN'){
            typeDt = personalityDt[1]
            yourType = '문화여행'
        }
        if(yourType=='IFS'){
            typeDt = personalityDt[2]
            yourType = '감성여행'
        }
        if(yourType=='IFN'){
            typeDt = personalityDt[3]
            yourType = '힐링여행'
        }
        if(yourType=='ETS'){
            typeDt = personalityDt[4]
            yourType = '레져여행'
        }
        if(yourType=='ETN'){
            typeDt = personalityDt[5]
            yourType = '음식여행'
        }
        if(yourType=='EFS'){
            typeDt = personalityDt[6]
            yourType = '레져여행'
        }
        if(yourType=='EFN'){
            typeDt = personalityDt[7]
            yourType = '감성여행'
        }
        
        $('#result').show()
        $('#question').hide()
        $('#answers').hide()
          $('#progbar').hide()
        
        let sendData = {
           'type' : yourType
          }
       
        $.ajax({
        type : 'post',
        url : '/mypage/testResult',
        data : sendData,
        success : function(data) {
           
               let tag = "<h2 style='font-family:Spoqa Han Sans Neo,sans-serif;'>당신에게 추천하는 여행테마는?<hr><b style='border-radius:20px;padding:5px 10px 5px 10px;font-family:Spoqa Han Sans Neo,sans-serif;font-size:30px;background-color:#ff8b3d;color:white;text-shadow:none;'> "+yourType+"</b></h2>"+"<p style='font-size:20px;'>"+typeDt+"</p><hr>"
               let divTag = document.createElement("div");
               divTag.className = 'yourList'
               divTag.innerHTML = "<h5 style='font-family:Spoqa Han Sans Neo,sans-serif;text-align:center;'>당신에게 추천하는 장소</h5>";
               
              for (let i = 0; i < data.length; i++) {

               let divTag1 = document.createElement("div");
               
               divTag1.className = 'resultplacedt';
               divTag1.style.marginTop = '10px';
               divTag1.style.border = "1px solid rgb(128,128,128,0.1)";
               divTag1.style.borderRadius = "20px";
               divTag1.style.backgroundColor = "white";
               let aTag = document.createElement("a");
               aTag.setAttribute('href','https://place.map.kakao.com/'+data[i].PLC_NO);
               aTag.setAttribute('target','_blank');
               
               let imgTag = document.createElement("img");
               imgTag.style.width = '120px';
               imgTag.style.height = '90px';
               imgTag.setAttribute('src',data[i].PLC_IMG);
               
               let aTag2 = document.createElement("a");
               aTag2.setAttribute('href','https://place.map.kakao.com/'+data[i].PLC_NO);
               aTag2.setAttribute('target','_blank');
               aTag2.style.fontFamily = "Spoqa Han Sans Neo,sans-serif";
               let hTag = document.createElement("h6");
               aTag2.innerText = data[i].PLC_TITLE;
               
               let divTag2 = document.createElement("button");
               divTag2.className = data[i].CHECKED;
               divTag2.setAttribute('data-plc_no',data[i].PLC_NO);
               divTag2.setAttribute('onclick','likeToggle(this)');
               let sTag1 = document.createElement("span");
               sTag1.className = "img_emoti";
               sTag1.innerText = "좋아요";
               let sTag2 = document.createElement("span");
               if(data[i].CHECKED=="heartbtn btn_like"){
            
               sTag2.className = "ani_heart_m bye";
               }
               else{
               sTag2.className = "ani_heart_m hi";
               }
               divTag.appendChild(divTag1);
               divTag1.appendChild(aTag);
               aTag.appendChild(imgTag);
               hTag.appendChild(aTag2);
               divTag1.appendChild(hTag);
               hTag.appendChild(divTag2);
               divTag2.appendChild(sTag1);
               divTag2.appendChild(sTag2);
                
              }
              $("#result").append(tag);
              $("#result").append(divTag);
        },
        error : function(error){
           alert("에러발생!! 다시시도해주세요"+error);
        }
     });
    }
    
    
    
  //조와요
  function likeToggle(heart){
          let sendData = {
            'plcNo' : heart.dataset['plc_no'],
         }
      if(heart.classList.contains('btn_unlike')){
         //ajax 기능 추가 
         $.ajax({
                  type : 'post',
                  url : '/mypage/deletePick',
                  data : sendData,
                  success : function(data) {
                	  heart.classList.remove('btn_unlike');
                	  heart.lastChild.classList.remove('hi');
                      heart.lastChild.classList.add('bye');
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
                	  heart.classList.add('btn_unlike');
                	  heart.lastChild.classList.add('hi');
                	  heart.lastChild.classList.remove('bye');
                  },
                  error : function(error) {
                     alert("에러발생!! 다시시도해주세요" + error);
                  }
               }); 
               
      }
   };
  
  
  function progMove(prog){
   
      if(prog>=100){
      return;
         }
      $('.progbar').width(prog + '%');
  }
  
  
  /* 날씨api */
    // var apiURI = "http://api.openweathermap.org/data/2.5/weather?q="+city+"&appid="+"dfb19fd20ff326431f940b75f34778da";
    var apiURI = "https://api.openweathermap.org/data/2.5/onecall?lat=37.537623499999995&lon=127.1580072&exclude=current,minutely,hourly,alerts&appid=f8af762b9aae8076bdab55c83501d7d3&lang=kr&units=metric";
    // let city = 'jeju';
    // var apiURI = "https://api.openweathermap.org/data/2.5/onecall?lat=33.3819233&lon=126.5617798&exclude=current,minutely,hourly,alerts&appid=f8af762b9aae8076bdab55c83501d7d3&lang=kr&units=metric";
    // let city = 'London';
    // var apiURI = "https://api.openweathermap.org/data/2.5/onecall?lat=51.5285582&lon=-0.2416812&exclude=current,minutely,hourly,alerts&appid=f8af762b9aae8076bdab55c83501d7d3&lang=kr&units=metric";
    $.ajax({
      url: apiURI,
      dataType: "json",
      type: "GET",
      async: "false",
      success: function(resp) {
        for (let idx in resp.daily) {
          let tmp = '<div class="weatherContent">';
          let days = new Date();
          days.setTime(resp.daily[idx].dt * 1000);
          const today = moment(days);
          tmp += '<div class="day">' + today.format('MM / DD') + '<div>';
          tmp += '<div class="Temp">' + Math.floor(resp.daily[idx].temp.min) + '&ordm/' + Math.floor(resp.daily[idx].temp.max) + '&ordm<div>';
          tmp += '<div class="Temp">' + Math.floor(resp.daily[idx].pop*100.0) + '%<div>';
          //맑음
          if(resp.daily[idx].weather[0].icon=='01d' || resp.daily[idx].weather[0].icon=='01n'){
            imgURL = '/resources/design/line/animation-ready/clear-day.svg';
          }
          //맑고 구름
          if(resp.daily[idx].weather[0].icon=='02d' || resp.daily[idx].weather[0].icon=='02n'){
            imgURL = '/resources/design/line/animation-ready/partly-cloudy-day.svg';
          }
          //구름
          if(resp.daily[idx].weather[0].icon=='03d' || resp.daily[idx].weather[0].icon=='03n'){
            imgURL = '/resources/design/line/animation-ready/cloudy.svg';
          }
          //먹구름
          if(resp.daily[idx].weather[0].icon=='04d' || resp.daily[idx].weather[0].icon=='04n'){
            imgURL = '/resources/design/line/animation-ready/cloudy.svg';
          }
          //소나기
          if(resp.daily[idx].weather[0].icon=='09d' || resp.daily[idx].weather[0].icon=='09d'){
            imgURL = '/resources/design/line/animation-ready/rain.svg';
          }
          //비
          if(resp.daily[idx].weather[0].icon=='10d' || resp.daily[idx].weather[0].icon=='10n'){
            imgURL = '/resources/design/line/animation-ready/rain.svg';
          }
          //번개
          if(resp.daily[idx].weather[0].icon=='11d' || resp.daily[idx].weather[0].icon=='11n'){
            imgURL = '/resources/design/line/animation-ready/thunderstorms.svg';
          }
          //눈
          if(resp.daily[idx].weather[0].icon=='13d' || resp.daily[idx].weather[0].icon=='13n'){
            imgURL = '/resources/design/line/animation-ready/snow.svg';
          }
          //안개
          if(resp.daily[idx].weather[0].icon=='50d' || resp.daily[idx].weather[0].icon=='50n'){
            imgURL = '/resources/design/line/animation-ready/mist.svg';
          }
        // imgURL = "http://openweathermap.org/img/w/" + resp.daily[idx].weather[0].icon + ".png";
          tmp += '<div class="Icon">' + "<img src=" + imgURL + ">" + '<div>';
          tmp += "</div>"
          $('.weather').append(tmp);
        }
      }
    })
    
    $(".navContent").on('click',function(){
       
       $(".selectRegionBox").css("display","flex");
    })
    
       window.onclick = function(event) {
    	  if (!event.target.matches('.header__nav__button-account') && !event.target.matches('.accountImg')) {
     	     let dropdowns = document.getElementsByClassName("header__drop__menu");
     	       if (dropdowns[0].classList.contains('active')) {
     	    	   dropdowns[0].classList.remove('active');
     	     }
     	   }
          if (!event.target.matches('.navBtnNodeList')) {
             $(".selectRegionBox").hide();
          }
          
          if(!event.target.matches('.dateNodeList'))
             $(".datepickerBox").hide();
        } 
    $(".region").on("click",function(){
       document.getElementsByClassName("navBtnNodeList")[3].innerHTML = "<b class='navBtnNodeList' data-regionNo="+$(this).data('regionNo')+" style=color:black;font-size:15px;>"+$(this).text()+"</b>"
       $(".navDateBtn").first().click();
       $(".datepickerBox").show();
    })
    
    $(".datedateBtn").on("click",function(){
    	$(".dateSelectBox").click();
    })
    
</script>
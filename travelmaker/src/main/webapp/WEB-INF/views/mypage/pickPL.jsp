<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
    <%@ include file="../includes/header.jsp" %>
<!DOCTYPE html>
<html lang="en">

<head>
<script type="text/javascript"
   src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9eb973825ac1960ebb20d660fdf86341"></script>

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

/* modal */
.modal_wrap {
   display: none;
   width: 70%;
   position: fixed;
   height: 500px;
   top: 50%;
   left: 15%;
   margin: -250px 0 0 0;
   background: #eee;
   z-index: 2;
}

.modal_close {
   width: 26px;
   height: 26px;
   position: absolute;
   top: -30px;
   right: 0;
}

.modal_close>a {
   display: block;
   width: 100%;
   height: 100%;
   background: url(https://img.icons8.com/metro/26/000000/close-window.png);
   text-indent: -9999px;
}

.black_bg {
   display: none;
   position: fixed;
   width: 100%;
   height: 100%;
   overflow: auto;
   background-color: rgba(0, 0, 0, 0.5);
   top: 0;
   left: 0;
   z-index: 1;
}

/* 지도관련 css */

#map {
   width: 100%;
   height: 100%;
}
.map_wrap, .map_wrap * {
   margin: 0;
   padding: 0;
   font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;
   font-size: 12px;
}

.map_wrap a, .map_wrap a:hover, .map_wrap a:active {
   color: #000;
   text-decoration: none;
}

.map_wrap {
   position: relative;
   width: 100%;
   height: 500px;
}

#menu_wrap {
   position: absolute;
   top: 0;
   left: 0;
   bottom: 0;
   width: 250px;
   margin: 10px 0 30px 10px;
   padding: 5px;
   overflow-y: auto;
   background: rgba(255, 255, 255, 0.7);
   z-index: 1;
   font-size: 12px;
   border-radius: 10px;
}

.bg_white {
   background: #fff;
}

#menu_wrap hr {
   display: block;
   height: 1px;
   border: 0;
   border-top: 2px solid #5F5F5F;
   margin: 3px 0;
}

#menu_wrap .option p {
   margin: 10px 0;
}

#menu_wrap .option button {
   margin-left: 5px;
}

#placesList {
   padding-left: 0px;
}

#placesList li {
   list-style: none;
}

#placesList .item {
   position: relative;
   border-bottom: 1px solid #888;
   overflow: hidden;
   cursor: pointer;
   min-height: 65px;
}

#placesList .item span {
   display: block;
   margin-top: 4px;
}

#placesList .item h5, #placesList .item .info {
   text-overflow: ellipsis;
   overflow: hidden;
   white-space: nowrap;
}

#placesList .item .info {
   padding: 10px 0 10px 55px;
}

#placesList .info .gray {
   color: #8a8a8a;
}

#placesList .info .jibun {
   padding-left: 26px;
}

#placesList .info .tel {
   color: #009900;
}

#placesList .item .markerbg {
   float: left;
   position: absolute;
   width: 36px;
   height: 37px;
   margin: 10px 0 0 10px;
   background:
      url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png)
      no-repeat;
}

#placesList .item .marker_1 {
   background-position: 0 -10px;
}

#placesList .item .marker_2 {
   background-position: 0 -56px;
}

#placesList .item .marker_3 {
   background-position: 0 -102px
}

#placesList .item .marker_4 {
   background-position: 0 -148px;
}

#placesList .item .marker_5 {
   background-position: 0 -194px;
}

#placesList .item .marker_6 {
   background-position: 0 -240px;
}

#placesList .item .marker_7 {
   background-position: 0 -286px;
}

#placesList .item .marker_8 {
   background-position: 0 -332px;
}

#placesList .item .marker_9 {
   background-position: 0 -378px;
}

#placesList .item .marker_10 {
   background-position: 0 -424px;
}

#placesList .item .marker_11 {
   background-position: 0 -470px;
}

#placesList .item .marker_12 {
   background-position: 0 -516px;
}

#placesList .item .marker_13 {
   background-position: 0 -562px;
}

#placesList .item .marker_14 {
   background-position: 0 -608px;
}

#placesList .item .marker_15 {
   background-position: 0 -654px;
}

body {
   margin: 0;
}

.pick_plan_content {
   width: 100%;
}

.coverBanner {
   width: 100%;
   height: 20%;
   background-image: url("https://free4kwallpapers.com/uploads/originals/2019/10/15/ocean-sunset-wallpaper.jpg");
   background-size: cover;
   text-align: center;
   color: white;
   padding-top: 100px;
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
   cursor:pointer;
   padding: 10px 20px 0 20px;
   text-align: center;
}

.mnu_box.active {
   padding: 10px 20px 0 20px;
   text-align: center;
   color: #0b1322;
   background-color: rgb(255, 194, 34);
}

.mnu_box:hover {
   background-color: rgb(255, 194, 34);
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

.tap_box {
   display: flex;
}

.sch_tap {
   padding-right: 15px;
   margin-right: 15px;
   margin-top: auto;
   margin-bottom: auto;
   border-right: 1px solid gray;
}

.viewMap{
   width: 100%;
   display: flex;
   justify-content: space-between;
}

#viewMap_btn{
   padding: 2px 13px 2px 13px;
   background-color: white;
   border: 1px solid gray;
   border-radius: 14px;
   text-align: center;
   font-size: 15px;
}

#viewMap_btn:hover{
   background-color: gray;
   color: white;   
}

.contents {
   padding: 20px;
   width: 100%;
   display: flex;
   flex-wrap: wrap;
   justify-content: space-around;
}

.card_sch {
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

.sch_content {
   width: 100%;
   height: 30%;
   background-color: white;
   line-height: 10px;
}

.sch_title {
   margin-left: 15px;
   
}
.sch_title p{
	margin: 0;
   	font-size: 6px;
   }
</style>
</head>

<body>
   <div class="pick_plan_content">
      <div class="coverBanner">
         <b>찜한장소</b>
      </div>
      <div class="pickNav_bar">
         <div class="pickNav_mnu">
            <div class="mnu_box active" onclick="location.href='/mypage/pickPL'">
               <b>찜한장소</b>
            </div>

            <div class="mnu_box" onclick="location.href='/mypage/pickSch'">
               <b>여행일정</b>
            </div>
         </div>
      </div>
      <div class="content_wrap">
         <div class="content_tap">
            <div class="tap_box">
            
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
            <c:forEach items="${list }" var="place">
               <div class="card_sch">
                     <div class="sch_Img">
                           <div class="white_layer">
                                 <button type="button" class="heartbtn btn_like btn_unlike" data-plc_no="${place.plcNo }">
      <span class="img_emoti">좋아요</span>
      <span class="ani_heart_m"></span>
     </button>
                           </div>
                        <div class="sch_Imgbg"  data-plc_no="${place.plcNo}"
                           style="background-image: url(${place.plcImg});">
                        </div>
                     </div>
                  <div class="sch_content">
                     <br>
                     <div class="sch_title">
                      
                      <input type="hidden" data-plc_no="${place.plcNo }" data-plc_dt="${place.addressDt}" data-lat="${place.lat }" 
                      data-lng="${place.lng }" data-title="${place.plcTitle }" class="markerlatlng">
                        <h6 style="margin: 5px 0;">
                        <i class="fa fa-map-marker" aria-hidden="true"></i><b><a href="https://place.map.kakao.com/${place.plcNo }" target="_blank">
                         <c:out value="${place.plcTitle }" /></a></b>
                         </h6>
                         <span style="float:right; margin-right: 10px;"><i class="fa fa-heart-o" aria-hidden="true"></i>
                         <span style="font-size: 12px;">${place.likeCnt }</span></span>
                        <p style="margin-bottom:3px;"><i class="fa fa-map-o" aria-hidden="true"></i> <c:out value="${place.addressDt }"/></p>
                        <p style="margin-bottom:3px;"><c:if test="${place.holiday ne null }">
                        <i class="fa fa-calendar-check-o" aria-hidden="true"></i> 휴무일 :
                        </c:if>
                        <c:out value="${place.holiday }" /></p>
                        <p style="margin-bottom:3px;"><c:if test="${place.openingH ne null }">
                              <i class="fa fa-clock-o" aria-hidden="true"></i> 영업시간 :
                              </c:if>
                        <c:out value="${place.openingH}" /></p>
                     </div>

                  </div>
               </div>
               
            </c:forEach>
               <div class="viewMap"><div></div><button id="viewMap_btn">지도에서 보기</button></div>
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


   <!-- 모달 클릭시 뒷 배경 -->
   <div class="black_bg"></div>

   <div class="modal_wrap">
      <div class="modal_close">
         <a href="#">close</a>
      </div>
      <!-- Map -->
      <div id="map" style="position: relative; overflow: hidden;"></div>
      <div id="menu_wrap" class="bg_white">
         <div class="option">
            <ul id="placesList"></ul>

            <div id="pagination"></div>
         </div>
      </div>
   </div>
   <form id='actionForm' action="/mypage/pickPL" method='get'>
      <input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum }'>
      <input type='hidden' name='selected'
         value=<%= request.getParameter("selected") %>>
   </form>
</body>

<script type="text/javascript">
   $(document).ready(function() {

      selectVal();

   });

   let actionForm = $("#actionForm");
   let markers = [];
   //마커의 좌표값 얻어오기
   let markerlatlng = document.getElementsByClassName("markerlatlng");
   let infowindow = new kakao.maps.InfoWindow({
      zIndex : 1
   });
   /* alert($(".markerlatlng").attr("lat")+""+$(".markerlatlng").attr("lng")); */
   //모달 보여지는 메서드
   function modalShow() {
      document.querySelector('.modal_wrap').style.display = 'block';
      document.querySelector('.black_bg').style.display = 'block';

      //지도 생성
      let mapContainer = document.getElementById('map'), // 지도를 표시할 div 
      mapOption = {
         center : new kakao.maps.LatLng(33.529252, 126.589699), // 지도의 중심좌표
         level : 3
      // 지도의 확대 레벨
      };
      let map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
      // 지도를 재설정할 범위정보를 가지고 있을 LatLngBounds 객체를 생성합니다
      let bounds = new kakao.maps.LatLngBounds();
      let i, marker;
      let listEl = document.getElementById('placesList'), menuEl = document
            .getElementById('menu_wrap'), fragment = document
            .createDocumentFragment(), listStr = '';

      //장소 NodeList 받아옴
      let itemVal = document.querySelectorAll(".item");

      $("#placesList").children().remove();

      for (i = 0; i < markerlatlng.length; i++) {

         // 배열의 좌표들이 잘 보이게 마커를 지도에 추가합니다
         let placePosition = new kakao.maps.LatLng(
               (markerlatlng[i].dataset["lat"]),
               (markerlatlng[i].dataset["lng"])), marker = addMaker(placePosition), itemEl = getListItem(
               i, markerlatlng[i], markerlatlng[i].dataset["title"],
               markerlatlng[i].dataset["plc_dt"]);

         fragment.appendChild(itemEl);
         // LatLngBounds 객체에 좌표를 추가합니다
         bounds.extend(placePosition);
         //지도 중심좌표 변경
         map.setBounds(bounds);
         (function(marker, title, plc_no) {
            itemEl.onmouseover = function() {
               displayInfowindow(marker, title);
            };

            itemEl.onmouseout = function() {
               infowindow.close();
            };
            itemEl.onclick = function() {
               openPlaceDt(marker, title, plc_no);
            };
            kakao.maps.event.addListener(marker, 'mouseover', function() {
               displayInfowindow(marker, title);
            });

            kakao.maps.event.addListener(marker, 'mouseout', function() {
               infowindow.close(marker, title);
            });
            kakao.maps.event.addListener(marker, 'click', function() {
               openPlaceDt(marker, title, plc_no);
            });

         })(marker, markerlatlng[i].dataset["title"],
               markerlatlng[i].dataset["plc_no"]);

      }

      listEl.appendChild(fragment);
      menuEl.scrollTop = 0;
      function getListItem(index, places, title, dt) {

         let el = document.createElement('li'), itemStr = '<span class="markerbg marker_'
               + (index + 1)
               + '"></span>'
               + '<div class="info">'
               + '   <h5>' + title + '</h5>';
         itemStr += '<span>' + dt + '</span>';

         el.innerHTML = itemStr;
         el.className = 'item';

         //el 값
         return el;
      }
      function setBounds() {
         // LatLngBounds 객체에 추가된 좌표들을 기준으로 지도의 범위를 재설정합니다
         // 이때 지도의 중심좌표와 레벨이 변경될 수 있습니다
         map.setBounds(bounds);
      }
      function openPlaceDt(marker, title, plc_no) {

         window.open('https://place.map.kakao.com/' + plc_no, '_blank');
      }
      function addMaker(position) {
         marker = new kakao.maps.Marker({
            position : position, // 마커의 위치
         });
         marker.setMap(map); // 지도 위에 마커를 표출합니다
         markers.push(marker); // 배열에 생성된 마커를 추가합니다
         return marker;
      }
      function displayInfowindow(marker, title) {
         let content = '<div style="padding:5px;z-index:1; font-size: 13px;">'
               + title + '</div>';

         let moveLatLon = new kakao.maps.LatLng(marker.getPosition()
               .getLat(), marker.getPosition().getLng());
         infowindow.setContent(content);
         infowindow.open(map, marker);

         // 지도 중심을 부드럽게 이동시킵니다
         map.panTo(moveLatLon);
      }
   }
   //모달 사라지는 메서드
   function modalClose() {
      document.querySelector('.modal_wrap').style.display = 'none';
      document.querySelector('.black_bg').style.display = 'none';
   }

   document.getElementById('viewMap_btn').addEventListener('click', modalShow);
   document.querySelector('.modal_close')
         .addEventListener('click', modalClose);

   //셀렉트 value 값 설정
   function selectVal() {
      let selVal = document.location.href.split("selected=");

      let selArr = $("#listSort option");
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

   //리스트 정렬기준 설정
   $("#listSort").change(function() {

      location.replace("/mypage/pickPL?selected=" + this.value);
   });

   //페이지정보 보내는 function
   $(".pagination_btn").on("click", function(e) {

      e.preventDefault();

      actionForm.find("input[name='pageNum']").val($(this).attr("num"));
      actionForm.submit();
   });

   
   $(".sch_Imgbg").on("click",function(){
      
      window.open('https://place.map.kakao.com/' + $(this).data('plc_no'), '_blank');
   })
   
   $(".heartbtn").click(function(){
      
      let heartbtn = $(this);
      if(heartbtn.hasClass('btn_unlike')){
          let sendData = {
            'plcNo' : heartbtn.data('plc_no'),
         }
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
          let sendData = {
                'plcNo' : heartbtn.data('plc_no'),
         }
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


   /* 바뀐좋아요 버튼 액션
   $('button').click(function(){
     if($(this).hasClass('btn_unlike')){
       $(this).removeClass('btn_unlike');
       $('.ani_heart_m').removeClass('hi');
       $('.ani_heart_m').addClass('bye');
     }
     else{
       $(this).addClass('btn_unlike');
       $('.ani_heart_m').addClass('hi');
       $('.ani_heart_m').removeClass('bye');
     }
   }); */
   
   
   $(".black_bg").on("click", function() {

      document.querySelector('.modal_wrap').style.display = 'none';
      document.querySelector('.black_bg').style.display = 'none';

   });
</script>
</html>
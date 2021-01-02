<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../../includes/header.jsp" %>
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
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<style>
/*지은스타일 */
#customers {
  font-family: Arial, Helvetica, sans-serif;
  border-collapse: collapse;
  width: 100%;
  table-layout:fixed;
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
  background-color:#ff8b3d;
  color: white;
}
#tabletitle{

   text-align:center;
}

/*지은스타일 끝 */
.plan_content {
   margin-left: auto;
   margin-right: auto;
       margin-bottom: 50px;
}
.contentTitle{
   width:100%;
   height: 200px;
   color:black;
 	padding:15px 10% 15px 10%;
 	background-color: antiquewhite;
}

.plan_mnu_box {
   background-color:white;
   display: flex;
   margin-bottom: 50px;
   box-shadow: rgba(0, 0, 0, 0.08) 0px 1px 12px;
   padding-left: 10%;
   padding-right: 10%;
}

.plan_mnu {
   text-align: center;
   height: 60px;
   padding-right: 35px;
   padding-left: 35px;
   font-weight: bold;
}

.plan_mnu:hover{
    background-color: rgb(128,128,128,0.2);
}



.content_wrap{
	width: 80%;
	margin-left:auto;
	margin-right:auto;
}

.sticky {
  position: fixed;
  top: 0;
}
.stickyMap{
   position: fixed;
   right: 10%;
   top: 110px;
}
.plan_mnu a {
   line-height: 60px;
}
.plan_mnu.active{
   font-weight: bold;
   color: #3099dd;
}


.plan_mnu_btn{
   margin-left: auto;
   height: 60px;
   margin-right: 15px;
   display:flex;
   justify-content: space-between;
}

#gotoList{
   height:30px;
   margin-top:15px;
   background-color:#ff8b3d;
   color:white;
   padding: 3px 8px 0 8px;
   margin-right: 15px;
   text-align: center;
   cursor: pointer;
}

#gotoList:hover{
	background-color: #d8702a;
}
#sch_remove_btn{
   height:30px;
   margin-top:15px;
   background-color: #ff6666;
   color:white;
   padding: 3px 8px 0 8px;
   margin-right: 15px;
   text-align: center;
}

#sch_remove_btn:hover{
	background-color: #c33e3e;
}

.schedule_dt_content {
   display: flex;
   flex-wrap: nowrap;
   width: 100%;
   height: auto;
   justify-content: space-between;
}

.schedule_dt_box {
   width: 63%;
}

.schedule_dt{
   width:100%;
}
.schdt_top{
   height: 70px;
   display: flex;
}

.dt_top_left{
   width: 15%;
   background-color:#ff8b3d;
   color:white;
    text-align: center;
   line-height: 70px;    
   border-right: 1px solid rgb(128,128,128,0.2);
}

.dt_top_right{
   border-top: 1px solid rgb(128,128,128,0.2);
   border-right: 1px solid rgb(128,128,128,0.2);
   padding-left: 10px;
   width: 85%;
   display: flex;
   justify-content: space-between;
}
.daily_date{
   margin-top: auto;
   margin-bottom: auto;
}
.showMap{
   margin-right: 15px;
   border: 1px solid rgb(128,128,128,0.2);
   margin-top: auto;
   margin-bottom: auto;
   border-radius: 10px;
   padding-left: 10px;
   padding-right: 10px;
   cursor: pointer;
}
.showMap:hover{
   background-color: rgb(128,128,128,0.2);
}
.schdt_bottom{
   height: 100px;
   display:flex;
}
.dt_bottom_left{
   width: 15%;
   text-align: center;
   border-top: 1px solid rgb(128,128,128,0.2);
   border-left: 1px solid rgb(128,128,128,0.2);
   border-right: 1px solid rgb(128,128,128,0.2);
   padding-top: 40px;
}

.daily_count{
   font-size:14px;   
   margin-left:auto;
   margin-right:auto;
   color:white;
   background-color:#ff8b3d;
   border-radius: 50%;
   width: 20px;
    height: 20px;
    text-align: center;
}

.dt_bottom_right{
   padding-left: 10px;
   width: 85%;
   line-height: 100px;  
   border-right: 1px solid rgb(128,128,128,0.2);
   border-top: 1px solid rgb(128,128,128,0.2);
}
.dt_bottom_right img{
   width: 75px;
   height: 75px;
}   
.dt_box_footer{
   display:flex;
   background-color: #faf3ea;
   border:1px solid rgb(128,128,128,0.2);
}
.dt_footer_left{
   width: 15%;
   text-align: center;
}

.dt_footer_right{
   width: 85%;
}

.map_wrap {
   width: 400px;
   height: 350px;
}
/* 지도 css */
.marker {
   margin-top: 20px;
   margin-bottom: 20px;
}

#map {
   width: 100%;
   height: 100%;
}

#places{
   border: 1px solid rgb(128,128,128,0.2);
   padding: 15px;
   font-size: 15px;
   text-align: center;
   background-color: white;
}


.map_wrap a, .map_wrap a:hover, .map_wrap a:active {
   color: #000;
   text-decoration: none;
}

/* 삭제모달 */
#remove_modal {
   display: none;
   width: 300px;
   padding: 20px 30px;
   background-color: #fefefe;
   border: 1px solid #888;
   border-radius: 3px;
}

#remove_modal .modal_close_btn {
   width: 40%;
   margin-right: 10%;
   background-color: white;
   color: black;
   border: 1px solid gray;
   border-radius: 5px;
   outline: none;
}


#remove_modal .remove_btn {
   width: 40%;
   background-color: #ff6d70;
   color: white;
   border: 1px solid gray;
   border-radius: 5px;
}
#gotoTop {
  position: fixed;
  bottom: 20px;
  right: 30px;
  z-index: 99999;
  font-size: 18px;
  border: none;
  outline: none;
  background-color: white;
  color: black;
  cursor: pointer;
  padding: 0px 10px 0px 10px;
  border-radius: 4px;
  border: 1px solid rgb(128,128,128,0.2);
}
.modal-content{
overflow-y: initial !important
}

.modal-header{
	height: 10%;
}
.modal-body{
height: 90%;
}
#schedulelist_modal{
   display: none;
   width: 35%;
   height: 90%;
   padding: 20px;
   background-color: #fefefe;
   border: 1px solid #888;
   border-radius: 3px;
   text-align : center;
}
/* 닫는버튼 */
#schedulelist_modal .modal_close_btn{
	position:absolute;
	right:15px;
   background-color: white;
   color: black;
   border: none;
   border-radius: 5px;
   font-size: 25px;
    outline: none;
}

#gotoTop:hover {
   background-color: black;
   color:white;
}
.sharebtnbox{
	border-radius: 50%;
	background-color: white;
	width: 47px;
	height: 47px;
	text-align: center;
	padding-top: 8px;
	position: absolute;
	right: 10%;
	top:100px;
}

.register_open_btn:hover .sharebtnbox{
	background-color: rgb(200,200,200);
}
.register_open_btn:hover .sharebtnbox img{
	opacity: 0.7;
}
</style>
</head>

<body>
   <div class="plan_content">
   <div class="contentTitle">
      <!-- schTitle -->
      <div><h1><b><c:out value="${schedule[0].SCH_TITLE}"/></b></h1>
      <!-- schDate -->
      <h4><b><fmt:formatDate value="${schedule[0].FROM_DATE}" type="date" dateStyle="full" /> ~ 
      <fmt:formatDate value="${schedule[0].TO_DATE}" type="date" dateStyle="full" /></b></h4></div>
  <a href='/board/register?schNo=${schedule[0].SCH_NO }' target="schedulelist" class="register_open_btn">
  <div class="sharebtnbox"> <img src="/resources/img/shareboardbtn.png"></div></a>
   </div>
      <!-- nav -->
      <div class="plan_mnu_box" id="planNav">
         <!-- 개요 -->
         <div class="plan_mnu active" num="0">
            <a>개요</a>
         </div>
         <!-- 일정표 -->
         <div class="plan_mnu" num="1">
            <a>일정표</a>
         </div>
         <div class="plan_mnu_btn">
             <div id="gotoList" data-oper='list'>목록으로</div>
            <div id="sch_remove_btn">일정삭제</div>
         </div>
      </div>
<div class="content_wrap">
      <div class="schedule_dt_content">

         <!-- schdt -->
         <div class="schedule_dt_box">
            <c:set var="count" value="0"></c:set>
            <c:forEach items="${Schdt }" begin="0" end="${Schdt.size() }" var="schdt" varStatus="status">
            <c:if test="${Schdt[status.index].SCH_DATE ne Schdt[status.index-1].SCH_DATE  }">
            <c:set var="count" value="${count+1 }"/>
            <div class="schedule_dt">
               <div class="schdt_top">
                  <div class=dt_top_left>DAY<c:out value="${count }"/></div>
                  <div class=dt_top_right>
                  <div class="daily_date"><fmt:formatDate value="${schdt.SCH_DATE}" type="date" dateStyle="full" /></div>
                   <div class="showMap" onclick="showMap(${count})">지도에서보기</div></div>
               </div>
                           <c:set var="dtCnt" value="0"/>
               
                  <c:forEach items="${Schdt }" begin="0" end="${Schdt.size() }" var="dt" varStatus="vs">
                           <!-- 처음~막전 -->
                           <c:if test="${schdt.SCH_DATE eq dt.SCH_DATE }">
                           
                              <c:if test="${schdt.SCH_DATE eq dt.SCH_DATE}">
                              <c:set var="dtCnt" value="${dtCnt+1 }"/>
                              <div class="schdt_bottom">
                                 <div class="dt_bottom_left">
                                    <div class="daily_count">${dtCnt }</div>
                                 </div>
                                 <div class="dt_bottom_right">
                                 <a href="http://place.map.kakao.com/${dt.FROM_PLC }" target="_blank">
                                    <img class="plcImg plcImg_${count}" data-plc_no="${dt.FROM_PLC}" data-plc_dt="${dt.FROMADT}" data-lat="${dt.FROMLAT}" data-lng="${dt.FROMLNG}" data-title="${dt.FROMTITLE}" alt="place" src='<c:out value="${dt.FROMIMG }"/>'>
                                    </a>
                                    <a href="http://place.map.kakao.com/${dt.FROM_PLC }" target="_blank">
                                    <c:out value="${dt.FROMTITLE }"/>
                                 </a>
                                 <a href="http://place.map.kakao.com/${dt.TO_PLC }" style="float:right; margin-right: 30px;" target="_blank">
                                    <i class="fa fa-info-circle fa-1x" aria-hidden="true"></i>
                                    </a>
                                    <b style="float:right; font-size: 8px; margin-right: 10px;"><c:out value="${dt.FROMADT }"/></b>
                                 </div>
                              </div>

                              <!-- distance -->
                              <div class="dt_box_footer">
                                 <div class="dt_footer_left"></div>
                                 <div class="dt_footer_right">-> 이동거리 ${dt.DISTANCE }</div>
                              </div>
                           </c:if>
                           
                           <!-- 마지막 -->
                           <c:if test="${Schdt[status.index].SCH_DATE ne Schdt[vs.index+1].SCH_DATE}">
                           <div class="schdt_bottom" style="margin-bottom: 50px; border-bottom: 1px solid rgb(128,128,128,0.2);">
                                 <div class="dt_bottom_left">
                                    <div class="daily_count">${dtCnt+1}</div>
                                 </div>
                                 <div class="dt_bottom_right">
                                 <a href="http://place.map.kakao.com/${dt.FROM_PLC }" target="_blank">
                                    <img class="plcImg plcImg_${count}" data-plc_no="${dt.TO_PLC}" data-plc_dt="${dt.TOADT}" data-lat="${dt.TOLAT}" data-lng="${dt.TOLNG}" data-title="${dt.TOTITLE}" alt="place" src='<c:out value="${dt.TOIMG }"/>'>
                                    </a>
                                    <a href="http://place.map.kakao.com/${dt.FROM_PLC }" style="margin-left: 10px;"  target="_blank">
                                    <c:out value="${dt.TOTITLE }"/>
                                    </a>
                                    <a href="http://place.map.kakao.com/${dt.FROM_PLC }" style="float:right; margin-right: 30px;" target="_blank">
                                    <i class="fa fa-info-circle fa-1x" aria-hidden="true"></i>
                                    </a>
                                    <b style="float:right; font-size: 8px; margin-right: 10px;"><c:out value="${dt.TOADT }"/></b>
                                 </div>
                              </div>
                           </c:if>
                           </c:if>
                        </c:forEach>
               </div>
               </c:if>
            </c:forEach>
         </div>


         <!-- Map -->
         <div class="map_wrap" id="map_wrapper">
            <div id="map" style="position: relative; overflow: hidden;"></div>
            <div id="places"><b>지도에서 보기를 눌러주세요</b></div>
         </div>
      </div>
</div>





<div class="content_wrap">


<table id="customers">
   <tr id="tabletitle">
      <th><i class="fa fa-calendar"></i>날짜</th>
      <th><i class="fa fa-globe"></i>&nbsp도시</th>
      <th><i class="fa fa-thumb-tack"></i>&nbsp일정</th>
      <th><i class="fa fa-car"></i>&nbsp교통</th>
      <th><i class="fa fa-bed"></i>&nbsp숙소</th>
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
      <td></td>
      </tr>
   
   </c:if>
   </c:forEach>
</table>

</div>
<!-- Schedulelist Modal -->
   <div id="schedulelist_modal" class="modal-content">
   <button class="modal_close_btn"> X </button>
   <div class="modal-header"><h3>내일정 공유 </h3></div>
   <div class="modal-body">
      <iframe name="schedulelist" title="schedulelist" width=100% height=100% frameBorder="0">
      </iframe>
   </div>
</div>
  
   <!-- gotop -->
   <a id="gotoTop">▲</a>

   </div>
<input type='hidden' id='sch_no' name='sch_no' value="${schedule[0].SCH_NO}">
      <input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum}"/>'>

</body>
<%@ include file="../../includes/footer.jsp" %>
<!-- /.col-lg-9 -->
<script type="text/javascript"
   src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9eb973825ac1960ebb20d660fdf86341"></script>
<script type="text/javascript">

window.onscroll = function() {myFunction()};

var header = document.getElementById("planNav"); 
var mapWrapper = document.getElementById("map_wrapper");
var sticky = header.offsetTop;
function myFunction() {
	 if (window.pageYOffset > sticky) {
  header.classList.add("sticky");
  header.style.width = "100%";
  mapWrapper.classList.add("stickyMap");
			    if(window.pageYOffset >= document.getElementsByTagName('footer')[0].offsetTop - 800){
			    mapWrapper.classList.remove("stickyMap");
			    }
} 

  else{
    header.classList.remove("sticky");
    header.style.width = "auto";
    header.style.zIndex = "9999";
    
    mapWrapper.classList.remove("stickyMap");
  }
}


   $(document).ready(function() {
      document.getElementsByClassName("content_wrap")[1].style.display = 'none';
      //지도 생성
      let mapContainer = document.getElementById('map'), // 지도를 표시할 div 
      mapOption = {
         center : new kakao.maps.LatLng(33.529252, 126.589699), // 지도의 중심좌표
         level : 3
      // 지도의 확대 레벨
      };
      let map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
   });

   let operForm = $("#operForm");

   $("#gotoList").on("click", function(e) {
	   location.href = "/mypage/past?pageNum="
           + $('input[name=pageNum]').val();
   });

   function modal(id) {
      var zIndex = 9999;
      var modal = document.getElementById(id);

      // 모달 div 뒤에 희끄무레한 레이어
      var bg = document.createElement('div');
      bg.setStyle({
         position : 'fixed',
         zIndex : zIndex,
         left : '0px',
         top : '0px',
         width : '100%',
         height : '100%',
         overflow : 'auto',
         // 레이어 색갈은 여기서 바꾸면 됨
         backgroundColor : 'rgba(0,0,0,0.4)'
      });
      document.body.append(bg);

      // 닫기 버튼 처리, 시꺼먼 레이어와 모달 div 지우기
      modal.querySelector('.modal_close_btn').addEventListener('click',
            function() {
               bg.remove();
               modal.style.display = 'none';
            });

      modal.setStyle({
               position : 'fixed',
               display : 'block',
               boxShadow : '0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19)',

               // 시꺼먼 레이어 보다 한칸 위에 보이기
               zIndex : zIndex + 1,

               // div center 정렬
               top : '50%',
               left : '50%',
               transform : 'translate(-50%, -50%)',
               msTransform : 'translate(-50%, -50%)',
               webkitTransform : 'translate(-50%, -50%)'
            });
   };

   // Element 에 style 한번에 오브젝트로 설정하는 함수 추가
   Element.prototype.setStyle = function(styles) {
      for ( var k in styles)
         this.style[k] = styles[k];
      return this;
   };

   document.getElementById('sch_remove_btn').addEventListener('click',
         function() {
            // 모달창 띄우기
           /*  modal('remove_modal'); */
        	  swal({
        		   title: "정말 삭제하시겠습니까?",
        		   text: "일정이 삭제되면 복구할 수 없습니다. ",
        		   icon: "warning",
        		   buttons: ["취소","삭제"],
        		   dangerMode: true,
        		 })
        		 .then((willDelete) => {
        		   if (willDelete) {
        			   let schNo = {
        		               "schNo" : $('input[name=sch_no]').val()
        		            };

        		            $.ajax({
        		               type : 'post',
        		               url : '/mypage/deleteSchedule',
        		               data : schNo,
        		               success : function(data) {

        		            	   swal("일정이 정상적으로 삭제되었습니다.", {
        		        		       icon: "success",
        		        		     }).then((value)=>{
        		        		    	 location.href = "/mypage/past?pageNum="
        		                             + $('input[name=pageNum]').val();
        		        		     });
        		               },
        		               error : function(xhr) {

        		            	   swal({
        		            		   title: "삭제 실패!",
        		            		   text: "잠시 후 다시 시도해 주세요",
        		            		   icon: "warning",
        		            		   button: "확인",
        		            		 });
        		               }

        		            });
        		    
        		     
        		   }
        		 });
        	   
        	   
         });

   
   /* 공유기능 추가할지는 생각 */
   function shareBtn() {
      document.getElementById("shareBtn").style.display = "block";
   }

   function shareBtnClose() {
      document.getElementById("shareBtn").style.display = "none";
   }

   let markers = [];
   //마커의 좌표값 얻어오기
   let infowindow = new kakao.maps.InfoWindow({
      zIndex : 1
   });
   /* alert($(".markerlatlng").attr("lat")+""+$(".markerlatlng").attr("lng")); */
   //모달 보여지는 메서드
   function showMap(count) {
      let markerlatlng = document.getElementsByClassName("plcImg_" + count);

      
      document.getElementById("places").style.textAlign = "left";
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

         $("#places").empty()
         
      for (i = 0; i < markerlatlng.length; i++) {
         
         let pTag = "<div style='margin: 0 15px 15px 0;text-align:center; display:inline-block; width:20px; height:20px; border-radius:50%; background-color:#ff8b3d; color:white;'>"+(i+1)+"</div><a href=https://place.map.kakao.com/"+markerlatlng[i].dataset["plc_no"]+" target=_blank>"+markerlatlng[i].dataset["title"] + "</a><br>";
         
         $("#places").append(pTag)
         
         // 배열의 좌표들이 잘 보이게 마커를 지도에 추가합니다
         let placePosition = new kakao.maps.LatLng(
               (markerlatlng[i].dataset["lat"]),
               (markerlatlng[i].dataset["lng"])), marker = addMaker(placePosition);

         // LatLngBounds 객체에 좌표를 추가합니다
         bounds.extend(placePosition);
         //지도 중심좌표 변경
         map.setBounds(bounds);
         (function(marker, title, plc_no) {
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
   
   $(".plan_mnu").on("click",function(){
      let contentwrap = document.getElementsByClassName("content_wrap")
      let planMenuBtn = document.getElementsByClassName("plan_mnu")
      
      for (let i = 0; i < contentwrap.length; i++) {
         if(i==$(this).attr("num")){
         planMenuBtn[i].classList.add("active");
         contentwrap[i].style.display = "block";
         }
         else{
            planMenuBtn[i].classList.remove("active");
            contentwrap[i].style.display = "none";
         }
      }
   })
   
     $('#gotoTop').on('click',function(){
	 	document.documentElement.scrollTop = 0;  
   })
   
      //register 모달 띄우기
   $('.register_open_btn').on("click", function() {
            $('.schedulelistbg').hide();
            modal('schedulelist_modal');
         });
</script>
</html>
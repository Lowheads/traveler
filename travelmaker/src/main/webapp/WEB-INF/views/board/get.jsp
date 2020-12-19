<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>


<!DOCTYPE html>
<html>
<link rel="stylesheet"
   href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<head>

<style>

.contents{
	width: 80%;
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

.boardContents{
	width: 100%;
	height: auto;
	background-color: white;
	display:flex;
}

.gallery {
	width: 100%;
	height: 100%;
	display : flex;
	justify-content: space-around;
	flex-wrap: wrap;
	margin: 0 auto;
}

.card-contents{
	width: 250px;
	height: 200px;
	margin-bottom: 50px;
}

.card-img{
	width: 100%;
	height: 85%;
	
}

  .card-img Img{
	width: 100%;
	height: 100%;
	border-radius: 10px;
	
} 

.card-desc{
	margin-top: 30px;
	height: auto;
	font-size: 15px;
}

.paging{
	
	bottom: 0;
	width:100%;
}

.mainMsg{
	margin-left: 5%;
}

.mainMsg a{
	text-decoration:none;
}

.mainMsg b{
	font-size:20px;
	color:white;

}

.heart{
	color:white;
	float:right;
}

.left {
     width: 50%;

}

.right {
     width: 50%;

}

#modify_btn{
	font-size:15px;
	margin-bottom: 50px;
	background-color:white;
	border: 1px solid gray;
	border-radius: 14px;
	padding: 5px 20px 5px 20px;
}

#dtmodify_btn, #list_btn{
	font-size:15px;
	margin-top: 10px;
	margin-bottom: 10px;
	background-color:white;
	border: 1px solid gray;
	/* border-radius: 14px; */
	padding: 5px 20px 5px 20px;
	float: left;

}

#remove_btn{
	font-size:15px;
	margin-top: 10px;
	margin-bottom: 10px;
	background-color:white;
	border: 1px solid gray;
	/* border-radius: 14px; */
	padding: 5px 20px 5px 20px;
	float: right;

}

.modal-content{
overflow-y: initial !important
}

.modal-body{
height: 550px;
overflow-y: auto;
}


/*모달 */
#modify_modal{
	display: none;
	width: 600px;
	height: 600px;
	padding: 10px;
	background-color: #fefefe;
	border: 1px solid #888;
	border-radius: 3px;
	text-align : center;
}


/*순규스타일 */

.schedule_dt_content {
   display: flex;
   flex-wrap: nowrap;
   width: 100%;
   height: auto;
   justify-content: space-between;
}

.schedule_dt_box {
   width: 100%;
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
.showMap{
   margin-right: 15px;
   border: 1px solid gray;
   margin-top: auto;
   margin-bottom: auto;
   border-radius: 10px;
   padding-left: 10px;
   padding-right: 10px;
}
.showMap:hover , #dtmodify_btn:hover, #list_btn:hover, #modify_btn:hover, #remove_btn:hover{
   background-color: #203341;
   color:white;
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


/*map*/
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

.modal_close_btn{
	width: 20%;
	margin-right: 10%;
	background-color: white;
	color: black;
	border: none;
	border-radius: 5px;
	text-align : right;

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
</style>


</head>
   <!-- 모달 클릭시 뒷 배경 -->
   <div class="black_bg"></div>
<!--지도 모달-->
 <div class="modal_wrap" style="top: '50%'; left: '50%';">
    <div class="modal_close"><a href="#">close</a></div>
    
    <div id="map" style="position:relative;overflow:hidden;"></div>
        <div id="menu_wrap" class="bg_white">
        <div class="option">
        <ul id="placesList"></ul>
        
         <div id="pagination"></div>
    </div>
    </div>
</div> 

<!--대표사진 수정 모달 -->
	<div id="modify_modal" class="modal-content">
		<div class="modal-body" style="overflow-x:hidden; overflow-y:hidden">
		<iframe name="modify" title="modify" width=100% height=100% frameBorder="0" scrolling="no">
		</iframe>
		</div>
		<button class="modal_close_btn"> 취소 </button>
	</div>



<body>
<div class="contents">


<!--상단 -->
<c:set var="coverimg" value="${fn:replace(board.boardImg, '\\\\', '/')}" />
	<div class="ct_body" style="background-image: url(${coverimg});">
		<div class="mainMsg">
		<b>${board.boardTitle}</b>	
		<br>
		<br>
		<c:choose>
		  <c:when test="${memNo eq schedule.memNo}">
		 <a href='/board/modify?boardNo=<c:out value="${board.boardNo}"/>&pageNum=<c:out value="${cri.pageNum}"/>&amount=<c:out value="${cri.amount}"/>' 
		 id="modify_btn" target='modify' class='modify_open_btn'>대표사진 변경</a>
		 </c:when>
		 </c:choose>
		 
		<!--mainMsg끝 -->
		</div>
		<div class="heart">
			<c:choose>
				<c:when test="${pick eq 'picked' }"> 
						<b>찜하기 <i class="fa fa-heart" data-sch_no="${board.schNo}"
						style="font-size: 24px; color: red;" onclick="likeToggle(this)"></i></b>
				</c:when>

				<c:when test="${pick eq 'unpicked'}">
						<b>찜하기 <i class="fa fa-heart fa-heart-o" data-sch_no="${board.schNo}"
						style="font-size: 24px; color: red;" onclick="likeToggle(this)"></i></b>
				</c:when>
			</c:choose>
		</div>	
	
	<!--상단 끝 -->
	</div>
		<c:choose>
  <c:when test="${memNo eq schedule.memNo}">
    <button id="dtmodify_btn" data-oper='dtmodify' class="btn btn-default">사진목록수정</button>
  </c:when>
</c:choose>
	
	<button id="list_btn" data-oper='list' class="btn btn-info">목록으로</button>
	
	<form id='actionForm' action="/board/remove" method='post'>
	<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum }"/>'>
	<input type='hidden' name='amount' value='<c:out value="${cri.amount }"/>'>
	<input type="hidden" name='boardNo' value='<c:out value="${board.boardNo}"/>' readonly="readonly">
	<button id="remove_btn" type="submit" class="btn btn-danger subbutton">삭제</button>
	</form>
		

	<!--사진리스트 출력 -->
	<div class="boardContents">
		<!--좌측 사진갤러리 -->
		<div class="left">
	
	 	<div class="gallery">
		<c:forEach var="file" items="${file}">
		<div class="card-contents">
		<div class="card-img">
			<a href="#" onclick="fn_fileDown('${file.FILE_NO}'); return false;">${file.ORG_FILE_NAME}</a>(${file.FILE_SIZE}kb)<br>
			<img src="<c:url value="/img/${file.STORED_FILE_NAME}"/>"/>
		</div>
		<div class="card-desc">
			${file.FILE_CONTENT}
		</div>
		</div>
		</c:forEach>
	</div>
	</div>
	
	<div class="right">

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
                                    <i class="fa fa-info-circle fa-2x" aria-hidden="true"></i>
                                    </a>
                                 </div>
                              </div>

                              <!-- distance -->
                              <div class="dt_box_footer">
                                 <div class="dt_footer_left"></div>
                                 <div class="dt_footer_right">-> 이동거리 ${dt.DISTANCE } km</div>
                              </div>
                           </c:if>
                           
                           <!-- 마지막 -->
                           <c:if test="${Schdt[status.index].SCH_DATE ne Schdt[vs.index+1].SCH_DATE}">
                           <div class="schdt_bottom" style="margin-bottom: 50px; border-bottom: 1px solid gray;">
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
                                    <i class="fa fa-info-circle fa-2x" aria-hidden="true"></i>
                                    </a>
                                 </div>
                              </div>
                           </c:if>
                           </c:if>
                        </c:forEach>
               </div>
               </c:if>
            </c:forEach>
         </div>
	
	</div>
	<!--contents 끝 -->
</div>

<!--contents 끝 -->
</div>


	<form name='operForm' id='operForm' action="/board/modify" method="get">
		<input type='hidden' id='boardNo' name='boardNo' value='<c:out value="${board.boardNo }"/>'> 
		<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum }"/>'> 
		<input type='hidden' name='amount' value='<c:out value="${cri.amount }"/>'>
	</form>
	<form name='fileForm' action="/board/fileDown" method="get">
		<input type='hidden' id="FILE_NO" name='FILE_NO' value="">
	</form>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9eb973825ac1960ebb20d660fdf86341"></script>
<script type="text/javascript">
$(document).ready(function(){
	

	var operForm = $("#operForm");
	
/* 	$("button[data-oper='modify']").on("click",function(e){
		operForm.attr("action","/board/modify").submit();
	}); */
	
	$("button[data-oper='dtmodify']").on("click",function(e){
		operForm.attr("action","/board/dtmodify").submit();
	});
	
	$("button[data-oper='list']").on("click",function(e){
/* 		operForm.find("#boardNo").remove();
		operForm.attr("action","/board/list")
		operForm.submit(); */
		
		window.history.back();
	});	
});

function fn_fileDown(fileNo){
	var formObj = $("form[name='fileForm']");
	$("#FILE_NO").attr("value", fileNo);
	formObj.submit();
}

//좋아요
function likeToggle(heart){
   if(heart.className == "fa fa-heart"){
       let sendData = {
            'schNo' : heart.dataset['sch_no'],
         }
         //ajax 기능 추가 
         $.ajax({
            type : 'post',
            url : '/board/deletePick',
            data : sendData,
            success : function(data) {
               heart.classList.toggle("fa-heart-o");
              
             },
            error : function(error){
               alert("에러발생!! 다시시도해주세요"+error);
            }
         });
   }
   
  if(heart.className == "fa fa-heart fa-heart-o"){
      let sendData = {
            'schNo' : heart.dataset['sch_no'],
         }
         //ajax 기능 추가 
         $.ajax({
            type : 'post',
            url : '/board/insertPick',
            data : sendData,
            success : function(data) {
               heart.classList.toggle("fa-heart-o");
              
            },
            error : function(error){
               alert("에러발생!! 다시시도해주세요"+error);
            }
         });
   } 
    
}; 

//modify모달 띄우기
	$('.modify_open_btn').on("click", function() {
				modal('modify_modal');
			});



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
        // 레이어 색갈은 여기서 바꾸면 됨
        backgroundColor: 'rgba(0,0,0,0.4)'
    });
    document.body.append(bg);

    // 닫기 버튼 처리, 시꺼먼 레이어와 모달 div 지우기
    modal.querySelector('.modal_close_btn').addEventListener('click', function() {
        bg.remove();
        modal.style.display = 'none';
    });

    modal.setStyle({
        position: 'fixed',
        display: 'block',
        boxShadow: '0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19)',

        // 시꺼먼 레이어 보다 한칸 위에 보이기
        zIndex: zIndex + 1,

        // div center 정렬
        top: '50%',
        left: '50%',
        transform: 'translate(-50%, -50%)',
        msTransform: 'translate(-50%, -50%)',
        webkitTransform: 'translate(-50%, -50%)'
    });
};

// Element 에 style 한번에 오브젝트로 설정하는 함수 추가
Element.prototype.setStyle = function(styles) {
    for (var k in styles) this.style[k] = styles[k];
    return this;
};

 
let markers = [];
	//마커의 좌표값 얻어오기
	let infowindow = new kakao.maps.InfoWindow({zIndex:1});
	/* alert($(".markerlatlng").attr("lat")+""+$(".markerlatlng").attr("lng")); */
	//모달 보여지는 메서드
	function showMap(count) {
	let markerlatlng = document.getElementsByClassName("plcImg_"+count);
		document.querySelector('.modal_wrap').style.display = 'block';
		document.querySelector('.black_bg').style.display = 'block';
		
		//지도 생성
		let mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center : new kakao.maps.LatLng(33.529252,126.589699), // 지도의 중심좌표
			level : 3
		// 지도의 확대 레벨
		};
		let map = new kakao.maps.Map(mapContainer,
				mapOption); // 지도를 생성합니다
		// 지도를 재설정할 범위정보를 가지고 있을 LatLngBounds 객체를 생성합니다
		let bounds = new kakao.maps.LatLngBounds();
		let i, marker;
		let listEl = document.getElementById('placesList'), 
	    menuEl = document.getElementById('menu_wrap'),
	    fragment = document.createDocumentFragment(), 
		listStr = '';
		
		//장소 NodeList 받아옴
		let itemVal = document.querySelectorAll(".item");
		
		$("#placesList").children().remove();
		
		for (i = 0; i < markerlatlng.length; i++) {
			
			// 배열의 좌표들이 잘 보이게 마커를 지도에 추가합니다
			let placePosition = new kakao.maps.LatLng(
					(markerlatlng[i].dataset["lat"]),
					(markerlatlng[i].dataset["lng"])),
			marker = addMaker(placePosition),
			itemEl = getListItem(i,markerlatlng[i],markerlatlng[i].dataset["title"],markerlatlng[i].dataset["plc_dt"]);

			fragment.appendChild(itemEl);
			// LatLngBounds 객체에 좌표를 추가합니다
			bounds.extend(placePosition);
			//지도 중심좌표 변경
			map.setBounds(bounds);
			 (function(marker, title,plc_no) {
				 itemEl.onmouseover =  function () {
		                displayInfowindow(marker, title);
		            };

		            itemEl.onmouseout =  function () {
		                infowindow.close();
		            };
		            itemEl.onclick = function(){
		            	openPlaceDt(marker,title,plc_no);
		            };
			kakao.maps.event.addListener(marker, 'mouseover', function() {
             displayInfowindow(marker, title);
         });

         kakao.maps.event.addListener(marker, 'mouseout', function() {
         	infowindow.close(marker,title);
         });
         kakao.maps.event.addListener(marker, 'click', function() {
         	openPlaceDt(marker,title,plc_no);
         });
         
			 })(marker, markerlatlng[i].dataset["title"],markerlatlng[i].dataset["plc_no"]);
			 
		}
		
		 listEl.appendChild(fragment);
		    menuEl.scrollTop = 0;
		function getListItem(index,places,title,dt) {

		    let el = document.createElement('li'),
		    itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
		                '<div class="info">' +
		                '   <h5>' + title + '</h5>';
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
		function openPlaceDt(marker,title,plc_no){
			
			window.open('https://place.map.kakao.com/'+plc_no, '_blank');
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
			  let content = '<div style="padding:5px;z-index:1; font-size: 13px;">' + title + '</div>';

			    let moveLatLon = new kakao.maps.LatLng(marker.getPosition().getLat(),marker.getPosition().getLng());
			    infowindow.setContent(content);
			    infowindow.open(map, marker);
			    
			    // 지도 중심을 부드럽게 이동시킵니다
			    map.panTo(moveLatLon);
				}
	}
	
	function modalClose() {
	document.querySelector('.modal_wrap').style.display = 'none';
		document.querySelector('.black_bg').style.display = 'none';
	}

	document.querySelector('.modal_close').addEventListener('click', modalClose);
	
$(".black_bg").on("click",function(){
		
		document.querySelector('.modal_wrap').style.display = 'none';
		document.querySelector('.black_bg').style.display = 'none';
		
	});
</script>

</body>
</html>
	
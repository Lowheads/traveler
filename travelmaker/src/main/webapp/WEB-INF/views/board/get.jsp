<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="../includes/jeheader.jsp"%>

<link rel="stylesheet" href="/resources/css/main.css">

<div class="modal_wrap" style="top: '50%'; left: '50%';">
    <div class="modal_close"><a href="#">close</a></div>
    <!-- Map -->
    <div id="map" style="position:relative;overflow:hidden;"></div>
        <div id="menu_wrap" class="bg_white">
        <div class="option">
        <ul id="placesList"></ul>
        
         <div id="pagination"></div>
    </div>
    </div>
    
</div>

<div class="wrapper">
 	
 <div class="header_wrapper">
 	<div class="header">
	<h3> ${board.boardTitle} </h3>
	</div>
</div>
	<div class="contents">

		<div class="ct_body">
		
		<div class="heart" style="float:right;">
			<c:choose>
				<c:when test="${pick eq 'picked' }"> 
						찜하기 <i class="fa fa-heart" data-sch_no="${board.schNo}"
						style="font-size: 24px; color: red;" onclick="likeToggle(this)"></i>
				</c:when>

				<c:when test="${pick eq 'unpicked'}">
						찜하기 <i class="fa fa-heart fa-heart-o" data-sch_no="${board.schNo}"
						style="font-size: 24px; color: red;" onclick="likeToggle(this)"></i>
				</c:when>
			</c:choose>
		</div>	
		
		<div class="form-group">
		<table class="board">
		<thead>
			<tr>
				<th>회원번호</th>
				<th>지역</th>
				<th>기간</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>${schedule.memNo }</td>
				<td>${schedule.schRegion }</td>
				<td>${schedule.fromDate }~ ${schedule.toDate }</td>
			</tr>
		</tbody>
	</table>
	</div>
	
<%-- 	<div class="form-group">
	<div>일정 : ${schedule.schTitle }</div>
	<table class="board">
		<thead>
			<tr>
				<th>날짜</th>
				<th>출발지</th>
				<th>도착지</th>
				<th>거리</th>
				<th>이동시간</th>
				<th>이동수단</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${schdtplace}" var="schdtplace">
				<tr>
					<td><c:out value="${schdtplace.schDate }" /></td>
					<td><c:out value="${schdtplace.plcTitle }" /></td>
					<td><c:out value="${schdtplace.plcTitle1 }" /></td>
					<td><c:out value="${schdtplace.distance }" /></td>
					<td><c:out value="${schdtplace.duration }" /></td>
					<td><c:out value="${schdtplace.transit}" /></td>
				</tr>
			</c:forEach>
		</tbody>

	</table>
	</div> --%>
	
 			<!-- 상세일정 출력 -->
 			<div class="contentAll">
				<c:set var="count" value="0"></c:set>
			<c:forEach items="${Schdt }" begin="0" end="${Schdt.size() }" var="schdt" varStatus="status">
				<c:if test="${Schdt[status.index].SCH_DATE ne Schdt[status.index-1].SCH_DATE  }">
				<div class="dayDt">
					<c:set var="count" value="${count+1 }"/>
						<div class="leftDate">
						<img alt="" src="/resources/img/pngwave.png" width="50px" height="50px;">
						<br>
						<h4>${ count}일차</h4>
						<p><fmt:formatDate value="${schdt.SCH_DATE}" type="date" dateStyle="full" /></p>
						<button class="viewMap" type="button" onclick="showMap(${count})">지도에서 보기</button>
						</div>
					<div class="dayDate">
						<c:forEach items="${Schdt }" begin="0" end="${Schdt.size() }" var="dt" varStatus="vs">
									
							<c:if test="${schdt.SCH_DATE eq dt.SCH_DATE }">
								<div class="dailyscheduleDT">
								<c:if test="${schdt.SCH_DATE eq dt.SCH_DATE}">
									<%-- <c:out value="${dt.FROM_PLC }" /> --%>
									<c:choose>
									<c:when test="${vs.index % 2.0 != 1 }">
									<a href="http://place.map.kakao.com/${dt.FROM_PLC }" target="blank">
									<img class="plcImg plcImg_${count}" alt="" src="${dt.FROMIMG }" height="100px;" width="100px;" data-plc_no="${dt.FROM_PLC}" data-plc_dt="${dt.FROMADT}" data-lat="${dt.FROMLAT}" data-lng="${dt.FROMLNG}" data-title="${dt.FROMTITLE}">
									<div class="overlay">
  									  <div class="text"><c:out value="${dt.FROMTITLE }"/></div>
 									 </div>
									</a>
								<%-- 	data-plc_no="${place.plcNo }" data-plc_dt="${place.addressDt}" data-lat="${place.lat }" data-lng="${place.lng }" data-title="${place.plcTitle }" --%>
								<div class="directionAll">
								<c:choose>
								<c:when test="${schdt.SCH_DATE eq Schdt[vs.index-1].SCH_DATE}"><div class="direction"><div class="dango" style="width: 100%; height: 10%;">
								<p style="font-size: 12px;"><c:out value="${dt.DISTANCE }" />km</p></div></div>
								</c:when>
								<c:when test="${schdt.SCH_DATE ne Schdt[vs.index-1].SCH_DATE}"><div class="direction"></div>
								</c:when>
								</c:choose>
								<div class="direction"><div class="dango" style="border-radius:50%; width: 100%; height: 100%;">
								<c:choose>
								<c:when test="${dt.FROMCATE eq 'CT1' }">
								<img alt="" src="https://www.flaticon.com/svg/static/icons/svg/236/236981.svg">
								</c:when>
								<c:when test="${dt.FROMCATE eq 'PO3' }">
								<img alt="" src="https://www.flaticon.com/svg/static/icons/svg/236/236956.svg">
								</c:when>
								<c:when test="${dt.FROMCATE eq 'AT4' }">
								<img alt="" src="https://www.flaticon.com/svg/static/icons/svg/236/236986.svg">
								</c:when>
								<c:when test="${dt.FROMCATE eq 'AD5' }">
								<img alt="" src="https://www.flaticon.com/svg/static/icons/svg/236/236980.svg">
								</c:when>
								<c:when test="${dt.FROMCATE eq 'FD6' }">
								<img alt="" src="https://www.flaticon.com/svg/static/icons/svg/272/272868.svg">
								</c:when>
								<c:when test="${dt.FROMCATE eq 'CE7' }">
								<img alt="" src="https://www.flaticon.com/svg/static/icons/svg/1205/1205743.svg" style="transform:rotate(-45deg);">
								</c:when>
								<c:when test="${dt.FROMCATE eq 'HP8' }">
								<img alt="" src="https://www.flaticon.com/svg/static/icons/svg/3209/3209074.svg">
								</c:when>
								<c:when test="${dt.FROMCATE eq 'ET1' }">
								<img alt="" src="https://www.flaticon.com/svg/static/icons/svg/237/237004.svg">
								</c:when>
								
								</c:choose>								
								</div></div>
								<div class="direction"><div class="dango" style="width: 100%; height: 10%;"><p style="font-size: 12px;"><c:out value="${dt.DURATION }" />시간</p></div></div>
								</div>
								<div style="height: 100px; width: 100px"></div>
									</c:when>
									<c:when test="${vs.index % 2.0 == 1 }">
									<div style="height: 100px; width: 100px"></div>
								<div class="directionAll">
									<c:choose>
								<c:when test="${schdt.SCH_DATE eq Schdt[vs.index-1].SCH_DATE}"><div class="direction">
								<div class="dango" style="width: 100%; height: 10%;">
								<p style="font-size: 12px;"><c:out value="${dt.DISTANCE }" />km</p>
								</div></div>
								</c:when>
								<c:when test="${schdt.SCH_DATE ne Schdt[vs.index-1].SCH_DATE}"><div class="direction"></div>
								</c:when>
								</c:choose>
								<div class="direction"><div class="dango" style="border-radius:50%; width: 100%; height: 100%">
								<c:choose>
								<c:when test="${dt.FROMCATE eq 'CT1' }">
								<img alt="" src="https://www.flaticon.com/svg/static/icons/svg/236/236981.svg">
								</c:when>
								<c:when test="${dt.FROMCATE eq 'PO3' }">
								<img alt="" src="https://www.flaticon.com/svg/static/icons/svg/236/236956.svg">
								</c:when>
								<c:when test="${dt.FROMCATE eq 'AT4' }">
								<img alt="" src="https://www.flaticon.com/svg/static/icons/svg/236/236986.svg">
								</c:when>
								<c:when test="${dt.FROMCATE eq 'AD5' }">
								<img alt="" src="https://www.flaticon.com/svg/static/icons/svg/236/236980.svg">
								</c:when>
								<c:when test="${dt.FROMCATE eq 'FD6' }">
								<img alt="" src="https://www.flaticon.com/svg/static/icons/svg/272/272868.svg">
								</c:when>
								<c:when test="${dt.FROMCATE eq 'CE7' }">
								<img alt="" src="https://www.flaticon.com/svg/static/icons/svg/2578/2578645.svg" style="transform:rotate(-45deg)">
								</c:when>
								<c:when test="${dt.FROMCATE eq 'HP8' }">
								<img alt="" src="https://www.flaticon.com/svg/static/icons/svg/3209/3209074.svg">
								</c:when>
								<c:when test="${dt.FROMCATE eq 'ET1' }">
								<img alt="" src="https://www.flaticon.com/svg/static/icons/svg/237/237004.svg">
								</c:when>
								
								</c:choose>
								</div></div>
								<div class="direction"><div class="dango" style="width: 100%; height: 10%; "><p style="font-size: 12px;"><c:out value="${dt.DURATION }" />시간</p></div></div>
								</div>
								<a href="http://place.map.kakao.com/${dt.FROM_PLC }" target="blank">
									<img class="plcImg plcImg_${count}" alt="" src="${dt.FROMIMG }" height="100px;" width="100px;" data-plc_no="${dt.FROM_PLC}" data-plc_dt="${dt.FROMADT}" data-lat="${dt.FROMLAT}" data-lng="${dt.FROMLNG}" data-title="${dt.FROMTITLE}">
									<div class="overlay">
  									  <div class="text"><c:out value="${dt.FROMTITLE }"/></div>
 									 </div>
									</a>
									</c:when>
									</c:choose>
									<%-- 나중에 쓸거 
									<c:out value="${dt.DISTANCE }" />
									<c:out value="${dt.DURATION }" />
									<c:out value="${dt.TRANSIT }" /> --%>
									</c:if>
								</div>
								
								<c:if test="${Schdt[status.index].SCH_DATE ne Schdt[vs.index+1].SCH_DATE}">
								<div class="dailyscheduleDT">
								<c:choose>
									<c:when test="${vs.index % 2.0 == 1 }">
									<a href="http://place.map.kakao.com/${dt.TO_PLC }" target="blank">
									<img class="plcImg plcImg_${count}" alt="" src="${dt.TOIMG }" height="100px;" width="100px;" data-plc_no="${dt.TO_PLC}" data-plc_dt="${dt.TOADT}" data-lat="${dt.TOLAT}" data-lng="${dt.TOLNG}" data-title="${dt.TOTITLE}">
									<div class="overlay">
  									  <div class="text"><c:out value="${dt.TOTITLE }"/></div>
 									 </div>
									</a>
								<div class="directionAll">
								<div class="direction"><div class="dango" style="width: 100%; height: 10%; "><p style="font-size: 12px;"><c:out value="${dt.DISTANCE }" />km</p></div></div>
								<div class="direction"><div class="dango" style="border-radius:50%; width: 100%; height: 100%">
								<c:choose>
								<c:when test="${dt.TOCATE eq 'CT1' }">
								<img alt="" src="https://www.flaticon.com/svg/static/icons/svg/236/236981.svg">
								</c:when>
								<c:when test="${dt.TOCATE eq 'PO3' }">
								<img alt="" src="https://www.flaticon.com/svg/static/icons/svg/236/236956.svg">
								</c:when>
								<c:when test="${dt.TOCATE eq 'AT4' }">
								<img alt="" src="https://www.flaticon.com/svg/static/icons/svg/236/236986.svg">
								</c:when>
								<c:when test="${dt.TOCATE eq 'AD5' }">
								<img alt="" src="https://www.flaticon.com/svg/static/icons/svg/236/236980.svg">
								</c:when>
								<c:when test="${dt.TOCATE eq 'FD6' }">
								<img alt="" src="https://www.flaticon.com/svg/static/icons/svg/272/272868.svg">
								</c:when>
								<c:when test="${dt.TOCATE eq 'CE7' }">
								<img alt="" src="https://www.flaticon.com/svg/static/icons/svg/2578/2578645.svg" style="transform:rotate(-45deg)">
								</c:when>
								<c:when test="${dt.TOCATE eq 'HP8' }">
								<img alt="" src="https://www.flaticon.com/svg/static/icons/svg/3209/3209074.svg">
								</c:when>
								<c:when test="${dt.TOCATE eq 'ET1' }">
								<img alt="" src="https://www.flaticon.com/svg/static/icons/svg/237/237004.svg">
								</c:when>
								</c:choose>
								</div></div>
								<div class="direction"></div>
								</div>
								<div style="height: 100px; width: 100px"></div>
									</c:when>
									<c:when test="${vs.index % 2.0 != 1 }">
									<div style="height: 100px; width: 100px"></div>	
								<div class="directionAll">
								<div class="direction"><div class="dango" style="width: 100%; height: 10%;"><p style="font-size: 12px;"><c:out value="${dt.DISTANCE }" />km</p></div></div>
								<div class="direction"><div class="dango" style="border-radius:50%;  width: 100%; height: 100%">
									<c:choose>
								<c:when test="${dt.TOCATE eq 'CT1' }">
								<img alt="" src="https://www.flaticon.com/svg/static/icons/svg/236/236981.svg">
								</c:when>
								<c:when test="${dt.TOCATE eq 'PO3' }">
								<img alt="" src="https://www.flaticon.com/svg/static/icons/svg/236/236956.svg">
								</c:when>
								<c:when test="${dt.TOCATE eq 'AT4' }">
								<img alt="" src="https://www.flaticon.com/svg/static/icons/svg/236/236986.svg">
								</c:when>
								<c:when test="${dt.TOCATE eq 'AD5' }">
								<img alt="" src="https://www.flaticon.com/svg/static/icons/svg/236/236980.svg">
								</c:when>
								<c:when test="${dt.TOCATE eq 'FD6' }">
								<img alt="" src="https://www.flaticon.com/svg/static/icons/svg/272/272868.svg">
								</c:when>
								<c:when test="${dt.TOCATE eq 'CE7' }">
								<img alt="" src="https://www.flaticon.com/svg/static/icons/svg/2578/2578645.svg" style="transform:rotate(-45deg)">
								</c:when>
								<c:when test="${dt.TOCATE eq 'HP8' }">
								<img alt="" src="https://www.flaticon.com/svg/static/icons/svg/3209/3209074.svg">
								</c:when>
								<c:when test="${dt.TOCATE eq 'ET1' }">
								<img alt="" src="https://www.flaticon.com/svg/static/icons/svg/237/237004.svg">
								</c:when>
								</c:choose>
								</div></div>
								<div class="direction"></div>
								</div>		
								<a href="http://place.map.kakao.com/${dt.TO_PLC }" target="blank">
									<img class="plcImg plcImg_${count}" alt="" src="${dt.TOIMG }" height="100px;" width="100px;" data-plc_no="${dt.TO_PLC}" data-plc_dt="${dt.TOADT}" data-lat="${dt.TOLAT}" data-lng="${dt.TOLNG}" data-title="${dt.TOTITLE}">
									<div class="overlay">
  									  <div class="text"><c:out value="${dt.TOTITLE }"/></div>
 									 </div>
									</a>
									</c:when>
									</c:choose>
									<%-- <c:out value="${dt.TO_PLC }" /> --%>
									<%-- <c:out value="${dt.DURATION }" /> --%>
									</div>
									</c:if>
							</c:if>
						</c:forEach> 
					</div>
					<br>
			</div>
				</c:if>
			</c:forEach>
		</div>
		<!-- 상세일정 끝 -->	
	
	<div>게시글</div>
	<div class="form-group">
	<table class="board">
		<thead>
			<tr>
				<th>게시물번호</th>
				<th>게시물내용</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${boarddt}" var="boarddt"> <!-- 리스트에서 boarddt 객체 하나로 변경하기 -->
				<tr>
					<td><c:out value="${boarddt.boardNo }" /></td>
<%-- 					<td><img class="orgImg"
						src="<c:out value='${boarddt.boarddtImg}'/>" /></td> --%>
					<td><c:out value="${boarddt.boardCon }" /></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	</div>
	
	<div class="form-group">
	<span>사진 목록</span>
	
	<div style="border: 1px solid #dbdbdb;">
		
		
		
		<div class="flex-container">
		<c:forEach var="file" items="${file}">
		<div>
			<a href="#" onclick="fn_fileDown('${file.FILE_NO}'); return false;">${file.ORG_FILE_NAME}</a>(${file.FILE_SIZE}kb)<br>
			<img src="<c:url value="/img/${file.STORED_FILE_NAME}"/>" width="200" height="200"/><br>${file.FILE_CONTENT}<br>
		</div>
		</c:forEach>
		</div>
	</div>
</div>

	<c:choose>
  <c:when test="${memNo eq schedule.memNo}">
    <button id="Btn" data-oper='modify' class="btn btn-default">게시글수정</button>
    <button id="Btn" data-oper='dtmodify' class="btn btn-default">사진목록수정</button>
  </c:when>
</c:choose>
	
	<button id="Btn" data-oper='list' class="btn btn-info">목록으로</button>

	<form name='operForm' id='operForm' action="/board/modify" method="get">
		<input type='hidden' id='boardNo' name='boardNo' value='<c:out value="${board.boardNo }"/>'> 
		<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum }"/>'> 
		<input type='hidden' name='amount' value='<c:out value="${cri.amount }"/>'>
	</form>
	<form name='fileForm' action="/board/fileDown" method="get">
		<input type='hidden' id="FILE_NO" name='FILE_NO' value="">
	</form>
</div>
</div>
</div>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9eb973825ac1960ebb20d660fdf86341"></script>
<script type="text/javascript">
$(document).ready(function(){
	

	var operForm = $("#operForm");
	
	$("button[data-oper='modify']").on("click",function(e){
		operForm.attr("action","/board/modify").submit();
	});
	
	$("button[data-oper='dtmodify']").on("click",function(e){
		operForm.attr("action","/board/dtmodify").submit();
	});
	
	$("button[data-oper='list']").on("click",function(e){
		operForm.find("#boardNo").remove();
		operForm.attr("action","/board/list")
		operForm.submit();
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
	
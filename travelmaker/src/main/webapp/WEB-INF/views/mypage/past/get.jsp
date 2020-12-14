<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ include file="../../includes/mypageheader.jsp" %>
<!-- 경고창 -->
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
     <!-- End Map -->
 <div id="remove_modal">
           <h4>정말 삭제하시겠습니까?</h4><br>
           
            <button class="modal_close_btn">취소</button>
            <button class="remove_btn">삭제</button>
        </div>
  <!-- Page Content -->

       <div class="leftNav">

        <div class="list-group">	
        <ul>
  <li><a href="/mypage/pickPL" class="list-group-item">찜한장소</a></li>
  <li><a href="/mypage/pickSch" class="list-group-item">찜한일정</a></li>
  <li><a href="/mypage/past" class="list-group-item">지나간여행</a></li>
  <li><a href="/mypage/upcomming" class="list-group-item">다가올여행</a></li>
</ul>
        </div>
        </div>
      <!-- /.col-lg-3 -->
 <div class="content-mypage" style="padding-top: 20px;" >
        <div class="row" style="flex-wrap: inherit;">
    <div style="display:block;" >
                <h2><c:out value="${board[0].SCH_TITLE }"/></h2>
 <div style="font-size: 10px; color: gray;"> <i class="fa fa-clock-o" aria-hidden="true"></i> 
 작성일 : <fmt:formatDate value="${board[0].SCH_REG_DATE}" type="date" dateStyle="full" /> | 
 <c:out value="${board[0].SCH_REGION }"/> | 
 <%-- <c:out value="${ }"/> --%>
 좋아요 <b style="color: red"><c:out value="${board[0].V_CNT }"/></b>개 | 
조회수 <c:out value="${board[0].PICK_CNT }"/>개
<div style="float:right; display:inline;" onclick="shareBtn()">
<i class="fa fa-share fa-2x"></i>
<b style=" font-size: 15px;">공유하기</b>
</div>
<div style="display:inline; float: right; width: 200px; height: 100px" >
<div id="shareBtn" style="background-color:white; text-align:center; font-size:15px; display:none; position: relative; top:25px; right:-75px; border: 1px solid gray; width: 100%; height: 40px;" >
<a onmouseout="shareBtnClose()" href="/board/register?schNo=${board[0].SCH_NO }">게시판에 공유하기</a></div>
</div>
 </div>
 <!-- 게시물 작성안했으면 출력이 불가능한 항목들이 너무 많음 . 보완해야할부분 -->
                <hr>
   <div>여행기간: <fmt:formatDate value="${board[0].FROM_DATE}" type="date" dateStyle="full" /> ~ 
   <fmt:formatDate value="${board[0].TO_DATE}" type="date" dateStyle="full" /></div>
  
 <div>메모: <c:out value="${board[0].MEMO}"/></div>
  
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

      <button data-oper='list' style="margin: 100px 0 100px 0">목록으로</button>
      <div class="pull-right" style="margin: 100px 0 100px 0">
      <button id="modify_btn">수정</button>
      <button id="popup_open_btn">삭제</button>
      </div>
</div>
</div>
	<form id='operForm' action="/mypage/past" method="get">
      <input type='hidden' id='sch_no' name='sch_no' value='<c:out value="${board[0].SCH_NO}"/>'>
      <input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum}"/>'>
	</form>
      <!-- /.col-lg-9 -->
      <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9eb973825ac1960ebb20d660fdf86341"></script>
      <script type="text/javascript">
    	  
var operForm = $("#operForm");
      
      $("button[data-oper='list']").on("click",function(e){
    	
    	  operForm.find("#sch_no").remove();
    	  operForm.attr("action","/mypage/past").submit();
    	  operForm.submit();
      });
      
      $(".remove_btn").on("click",function(){

    	  
    	  let schNo = {
    			  "schNo" : $('input[name=sch_no]').val()
    	  };
    	  
    	  $.ajax({
				type : 'post',
				url : '/mypage/deleteSchedule',
				data : schNo,
				success : function(data) {
					
					alert("목록에서 삭제되었습니다.");
					location.href="/mypage/past?pageNum="+$('input[name=pageNum]').val();
				},
    	 		error : function (xhr){
    		  		
    	 			alert("삭제실패");
    			 }
    	 
     		 });
      });
      
      $("#modify_btn").on("click",function(){
    	
    	  alert("수정버튼 개발중");
      })
      
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

      document.getElementById('popup_open_btn').addEventListener('click', function() {
          // 모달창 띄우기
          modal('remove_modal');
      });
      
       function shareBtn(){
    	  document.getElementById("shareBtn").style.display="block";
      } 
       
       function shareBtnClose(){
    	   document.getElementById("shareBtn").style.display="none";
       }
       
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
<%@include file="../../includes/footer.jsp" %>
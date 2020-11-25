<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ include file="../includes/mypageheader.jsp" %>

  <!-- Page Content -->
      <!-- sort -->
<select id="listSort" style="float:right; margin-right:10%;" > 
<option hidden selected disabled ></option>
<option value="like">좋아요 순</option>
<option value="new">최근에 찜한 순</option>
<option value="old">오래전에 찜한 순</option>
</select>
      <div class="leftNav">

        <div class="list-group">	
        <ul>
  <li><a href="/mypage/pickPL" class="list-group-item">찜한장소</a></li>
  <li><a href="/mypage/pickSch" class="list-group-item">찜한일정</a></li>
  <li><a href="/mypage/past" class="list-group-item">지나간여행</a></li>
  <li><a href="/mypage/upcomming" class="list-group-item">다가올여행</a></li>
</ul>
        </div>

<div class="modal_wrap">
    <div class="modal_close"><a href="#">close</a></div>
    <!-- Map -->
    <div id="map" style="position:relative;overflow:hidden;"></div>
        <div id="menu_wrap" class="bg_white">
        <div class="option">
        <ul id="placesList"></ul>
        
         <div id="pagination"></div>
    </div>
    </div>
     <!-- End Map -->
    
</div>
      </div>

      <div class="content-mypage" style="padding-top: 20px;" >

        <div class="row" id="new">

<c:forEach items="${list }" var="place">
            <div class="card h-100" id="resultcard">
           <a href='https://place.map.kakao.com/${place.plcNo}' target="_blank">
           <img class="card-img-top" src="" alt=""></a>
           <input type="hidden" value='${place.plcNo }' id='plc_no'>
           <input type="hidden" data-plc_no="${place.plcNo }" data-plc_dt="${place.addressDt}" data-lat="${place.lat }" data-lng="${place.lng }" data-title="${place.plcTitle }" class="markerlatlng">
              <div class="card-body">
                <h4 class="card-title">
                   <a href='https://place.map.kakao.com/${place.plcNo}' target="_blank">
                   <c:out value="${place.plcTitle }"></c:out></a>
                     <!-- Like  -->
     <div style="float:right;" class="heart">
       <a plc_no='${place.plcNo }'>
          <i id="heart"  class="fa fa-heart" style="font-size:24px;color:red"></i>
       </a>
   </div>          
             <!-- Like end -->
                </h4>
           
              </div>
            </div>
</c:forEach>

<form id='actionForm' action="/mypage/pickPL" method='get'>
	<input type='hidden' name='pageNum' value = '${pageMaker.cri.pageNum }'>
	<input type='hidden' name='selected' value = <%= request.getParameter("selected") %>>
</form>
        </div>
        <!-- /.row -->
        <div style="text-align: center;" class="w3-center">
<ul class="w3-bar">
<c:if test="${pageMaker.prev }">
<li class="w3-button" num="${pageMaker.startPage-1 }"><a>&laquo;</a></li>
</c:if>

<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
<li class="w3-button" "${pageMaker.cri.pageNum == num ? "'active' style='background-color:gray; color:white;'":"" }" num="${num}">
<a> ${num }</a></li>
</c:forEach>

<c:if test="${pageMaker.next }">
<li class="w3-button" num="${pageMaker.endPage +1 }">
<a>&raquo;</a></li>
</c:if>
</ul>

<button type='button' id="modal_btn" class="pull-right" style="float:right">지도에서 보기</button>
</div>
<!-- modal -->


      </div>
      <!-- /.col-lg-9 -->

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9eb973825ac1960ebb20d660fdf86341"></script>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

<script type="text/javascript">
	$(document).ready(function() {
		
					selectVal();
					
					});
	
	var actionForm = $("#actionForm");
	var markers = [];
	//마커의 좌표값 얻어오기
	var markerlatlng = document.getElementsByClassName("markerlatlng");
	var infowindow = new kakao.maps.InfoWindow({zIndex:1});
	/* alert($(".markerlatlng").attr("lat")+""+$(".markerlatlng").attr("lng")); */
	//모달 보여지는 메서드
	function modalShow() {
		document.querySelector('.modal_wrap').style.display = 'block';
		document.querySelector('.black_bg').style.display = 'block';
		
		//지도 생성
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center : new kakao.maps.LatLng(33.529252,126.589699), // 지도의 중심좌표
			level : 3
		// 지도의 확대 레벨
		};
		var map = new kakao.maps.Map(mapContainer,
				mapOption); // 지도를 생성합니다
		// 지도를 재설정할 범위정보를 가지고 있을 LatLngBounds 객체를 생성합니다
		var bounds = new kakao.maps.LatLngBounds();
		var i, marker;
		var listEl = document.getElementById('placesList'), 
	    menuEl = document.getElementById('menu_wrap'),
	    fragment = document.createDocumentFragment(), 
		listStr = '';
		
		//장소 NodeList 받아옴
		var itemVal = document.querySelectorAll(".item");
		
		$("#placesList").children().remove();
		
		for (i = 0; i < markerlatlng.length; i++) {
			
			// 배열의 좌표들이 잘 보이게 마커를 지도에 추가합니다
			var placePosition = new kakao.maps.LatLng(
					(markerlatlng[i].dataset["lat"]),
					(markerlatlng[i].dataset["lng"])),
			marker = addMaker(placePosition),
			itemEl = getListItem(i,markerlatlng[i],markerlatlng[i].dataset["title"],markerlatlng[i].dataset["plc_dt"]);
			/* if(itemVal[i] !== null || itemVal[i] !== undefined) {
				
			} */
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

		    var el = document.createElement('li'),
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
			  var content = '<div style="padding:5px;z-index:1; font-size: 13px;">' + title + '</div>';

			    var moveLatLon = new kakao.maps.LatLng(marker.getPosition().getLat(),marker.getPosition().getLng());
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

		document.getElementById('modal_btn').addEventListener('click', modalShow);
		document.querySelector('.modal_close').addEventListener('click', modalClose);

	//셀렉트 value 값 설정
	function selectVal(){
			var selVal = document.location.href.split("selected=");
			
			var selArr = $("#listSort option");
			if(selVal[1]==undefined || selVal[1] == 'null'){
			selArr[0].innerHTML = "정렬 기준";
			}
			if(selVal[1]=="like"){
			selArr[0].innerHTML = "좋아요 순";
			};
			if(selVal[1]=="new"){
				selArr[0].innerHTML = "최근에 찜한 순";
			};
			if(selVal[1]=="old"){
				selArr[0].innerHTML = "오래전에 찜한 순";
			};
		}
		
		
		
		//리스트 정렬기준 설정
	$("#listSort").change(function(){

		location.replace("/mypage/pickPL?selected="+this.value);
	});
		
	
		//페이지정보 보내는 function
		$(".w3-button").on("click",function(e) {

					e.preventDefault();

					actionForm.find("input[name='pageNum']")
							.val($(this).attr("num"));
					actionForm.submit();
				});

		//좋아요 취소하는 버튼
		$(".heart a").on("click", function() {
			$(this).hide(5);
			var sendData = {
				'plcNo' : $(this).attr('plc_no'),
			}
			//ajax 기능 추가 
			$.ajax({
				type : 'post',
				url : '/mypage/heart',
				data : sendData,
				success : function(data) {
					
					alert("목록에서 삭제되었습니다.")
					location.reload();
				}
			});
		});
		

</script>
<%@include file="../includes/footer.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="false"%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css"
	rel="stylesheet">
	<link href="/resources/css/modal.css" rel="stylesheet">
    <style>
    .map_wrap {position:relative;width:100%;height:350px;}
    .title {font-weight:bold;display:block;}
    .hAddr {position:absolute;left:10px;top:10px;border-radius: 2px;background:#fff;background:rgba(255,255,255,0.8);z-index:1;padding:5px;}
    #centerAddr {display:block;margin-top:2px;font-weight: normal;}
    .bAddr {padding:5px;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
</style>
</head>
<body>
	<!-- /.panel-heading -->
	<div class="panel-body">
		<!-- start place List 지금은 굳이 상관안해도 되고 나중에 이름 바꿀때 right side bar nav -->
		<div class="date-wrapper">일정 작성
		<p><input type="date" onchange="dateOnchange()" id="calendar_s" class="start-date" value='<c:out value="${schDto.fromDate}"></c:out>' />
		<input type="date" onchange="dateOnchange()" id="calendar_e" class="end-date" value='<c:out value="${schDto.toDate}"></c:out>' /></p>
		</div>
		<ul class="left-date-list" id="left-date-list">
		<!-- 일자별 모든 녀석들 출력하는 리스트 -->
		</ul> 
		
		<button class="btn-rec-place" onclick="showRecPlace()">추천 장소</button>
		<ul class="left-place-list" id="left-place-list">
			<li class="left clearfix" id="rec-place">
			<c:forEach items="${places}" var="list">
				<div class="rec-place" data-title="${list.plcTitle}" data-plc-no="${list.plcNo}">
				<c:out value="${list.plcTitle}"></c:out>
				</div>
				</c:forEach>
				</li>
		</ul>
	</div>
	<!-- end place list -->

<!-- 맵 시작 -->
	<div id="map" style="width: 100%; height: 350px;"></div>
<!-- 맵 끗 -->

		<!-- 검색 창의 시작  -->
		<form name="searchForm" id="searchForm" onSubmit="return false">
			<i class="fa fa-map-marker"></i> 
				<input type="text" id="search-value" /><br>
				<button id="search" type="button" type="button" onclick="searchAction()">
				<i class="fas fa-search"></i>
			</button>
		</form>
		<!-- 검색 창의 끝 -->
	<!-- /.panel-heading -->
	<div class="panel-body" style="border: 1px;">
		<!-- start place List 지금은 굳이 상관안해도 되고 나중에 이름 바꿀때 right side bar nav -->
		<ul class="right-place-list">
		</ul>
	</div>
	<!-- end place list -->
	
	<button class="btn-make-schedule">일정생성</button>
	
	<!-- 모달 클릭시 뒷 배경 -->
    <div class="black_bg"></div>
    <!-- Modal -->
    <div class="modal_wrap">
        <!-- 닫기버 버튼 -->
        <div class="modal_close"><a href="#">close</a></div>
    </div>

<br><br><br><br><br><br><br><br><br><br><br>



    <div id="transit-container" class="transit-container" data-transit="car"></div>
    <button type='button' id="transit-btn-car" data-transit="car">차</button>
    <button type='button' id="transit-btn-transit" data-transit="transit">대중교통</button>

	<script type="text/javascript" src="/resources/js/place.js"></script>
	<script type="text/javascript"
			src="//dapi.kakao.com/v2/maps/sdk.js?appkey=5f94b63952e978262a005cd52fcc313b&libraries=services"></script>
	<script type="text/javascript">
	
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = {
	       center : new kakao.maps.LatLng(33.529252,126.589699), // 지도의 중심좌표
	       level : 4
	    // 지도의 확대 레벨
	    };
	    var map = new kakao.maps.Map(mapContainer,
	          mapOption); // 지도를 생성합니다
	   computeDate();
	          
	   //모달보는 버튼에 이벤트 추가
	    document.querySelector('#transit-btn-car').addEventListener('click', modalShow);
	    document.querySelector('#transit-btn-car').addEventListener('click', function(e) {
	    	console.log(this.dataset["transit"]);
	    	document.getElementById("transit-container").setAttribute("data-transit", this.dataset["transit"]);
	    	console.log(document.getElementById("transit-container").getAttribute("data-transit")); // 맞게 바뀐지 확인용
	    });
	    
	    
	    document.querySelector('#transit-btn-transit').addEventListener('click', modalShow);
		document.querySelector('#transit-btn-transit').addEventListener('click', function(e) {
			console.log(this.dataset["transit"])
        	document.getElementById("transit-container").setAttribute("data-transit",this.dataset["transit"]); 
			console.log(document.getElementById("transit-container").getAttribute("data-transit")); // 디버깅용임
	    });
		
	    document.querySelector('.modal_close').addEventListener('click', modalClose);

	    

	    //모달 보여지는 메서드
	    function modalShow(e) {
	    	document.querySelector('.modal_wrap').style.display = 'block';
	        document.querySelector('.black_bg').style.display = 'block';
	    };

	    //모달 사라지는 메서드
	    function modalClose() {
	        document.querySelector('.modal_wrap').style.display = 'none';
	        document.querySelector('.black_bg').style.display = 'none';
	    }

	    function computeDate() {
	    	var edt = document.getElementById("calendar_e").value;
		   	var sdt = document.getElementById("calendar_s").value;
		   	var edtD = new Date(edt);
		   	var sdtD = new Date(sdt);
		    var dateDiff = Math.ceil((edtD.getTime()-sdtD.getTime())/(1000*3600*24))+1;
		    var idx =1;
		    var totalPlace = document.getElementById("left-date-list");
		    totalPlace.innerHTML = null;
		   for(idx; idx<=dateDiff; idx++ ){
			   var objs;
			    objs = document.createElement('button');
		        objs.setAttribute('class', 'daily-place-btn');
		        objs.innerText=idx+"일차";
		        totalPlace.appendChild(objs);
		   }
	    }
	    
	    function dateOnchange() {
	    	computeDate();
	    }
	    
	    function showRecPlace() {
	    	var recPlace = document.querySelectorAll('.rec-place');
	    	var len = recPlace.length;
	    	for (var i = 0; i < len; i++) {
	    		recPlace[i].style.display = 'block';
			}
	    	
	    }
	    
	    
	    
		function searchAction() {
			
			var placeValue = $("#search-value").val();
			var placeList = $(".right-place-list");
			

			let tagStr = "";
			placeService.getList({title : placeValue},
					function(list) {
						for (var i = 0, len = list.length || 0; i < len; i++) {
							var str = "";
							str += "<li class='right clearfix'>"; // 굳이 없어도 되는 부분이긴 한데... 
							str += "<div class='hoverable-place'  data-title='"+list[i].plcTitle+"' data-region-id='"+list[i].regionId+"' data-plc-dt='"+list[i].plcDt+"' data-plc-no='"+list[i].plcNo+"' data-holiday='"+list[i].holiday+"' data-lat='"+list[i].lat+"' data-p-cate='"+list[i].pCate+"' data-opening-h='"+list[i].openingH+"' data-lng='"+list[i].lng+"' onmouseenter='placeOver(this)'>"
									+ list[i].plcTitle + " ";
							str += "<button class='add-button' onclick='moveToLeft(this)'><i class='fas fa-plus'></i></button>";
							str += "<button class='detail-button' onclick='placeDetail(this)'><i class='fas fa-search-plus'></i></button></div></li>";
							tagStr += str;
							
						}
						placeList.html(tagStr);
						
					})
			return;
		}
		
		function deleteInLeft(e) {
			var e = e.parentElement;
			var eData = e.dataset;
			e.parentElement.remove(); 
			}

		function moveToLeft(e) {
			var index = document.getElementsByClassName("left-place")
			var parentE = e.parentElement.dataset;
			
			var leftPlace = document.getElementsByClassName("selected-place");
			if(leftPlace.length ||0){
			for (var i = 0; i < leftPlace.length; i++) {
				if(leftPlace[i].dataset['title'] == parentE['title']){		
					alert("이미 일정에 추가하셨습니다.");
					return;
				}
			}
			}
			
			var str ="";
			str += "<li class='left clearfix'>"; 
			str += "<div class='selected-place'  data-title='"+parentE['title']+"' data-region-id='"+parentE['regionId']+"' data-plc-dt='"+parentE['plcDt']+"' data-plc-no='"+parentE['plcNo']+"' data-holiday='"+parentE['holiday']+"' data-lat='"+parentE['lat']+"' data-p-cate='"+parentE['pCate']+"' data-opening-h='"+parentE['openingH']+"' data-lng='"+parentE['lng']+"'>"
			+ parentE['title'];
			str += "<button class='delete-button' onclick='deleteInLeft(this)'><i class='fas fa-times'></i></button>";
			var placeList = $(".left-place-list");
			placeList.append(str);
		 	e.parentElement.parentElement.remove();
		}
		
		function placeDetail(e) {
			var placeNo = e.parentElement.dataset["plcNo"];
			var URL = "https://place.map.kakao.com/"+placeNo;
			window.open(URL, "카카오 지도", "width=800, height=700, toolbar=no, menubar=no, scrollbars=no, resizable=yes" );
		}
		
		function placeOver(e) {
		       // 지도를 재설정할 범위정보를 가지고 있을 LatLngBounds 객체를 생성합니다
		       var bounds = new kakao.maps.LatLngBounds();
		       var marker;
		       var markers = [];
		      /*  for (var i = 0; i < markers.length||0; i++) {
		        	  
					 markers[i].remove(); 
					   굳이 marker배열을 쓸 필요가 없으면 필요없을거 같기도 하다.
					
				} */
		          // 배열의 좌표들이 잘 보이게 마커를 지도에 추가합니다
		          var placePosition = new kakao.maps.LatLng(
		                (e.dataset["lat"]),
		                (e.dataset["lng"])),
		          marker = addMaker(placePosition);
		          panTo(marker);
		          
		          e.addEventListener("mouseout",function(){
		        	  marker.setMap(null);
		          }) 
		          
		       function addMaker(position) {
		          marker = new kakao.maps.Marker({
		             position : position, // 마커의 위치
		          });
		          
		          markers.push(marker); 
		          marker.setMap(map); // 지도 위에 마커를 표출합니다
		          return marker;
		          
		       }
		          
			function panTo(marker) {
	    	    // 이동할 위도 경도 위치를 생성합니다 
	    	    var moveLatLon = new kakao.maps.LatLng(marker.getPosition().getLat(),marker.getPosition().getLng());
	    	    // 지도 중심을 부드럽게 이동시킵니다
	    	    // 만약 이동할 거리가 지도 화면보다 크면 부드러운 효과 없이 이동합니다
	    	    map.setProportion
	    	    map.panTo(moveLatLon);            
	    	}
		}
		
		
	</script>
</body>
</html>

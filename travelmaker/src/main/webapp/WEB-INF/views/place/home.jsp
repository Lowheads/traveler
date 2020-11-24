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
	<script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
	<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
	<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
	<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css" />
	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" rel="stylesheet">
	<link href="/resources/css/home.css" rel="stylesheet">
</head>
<body>
	<!-- /.panel-heading -->
	<div class="panel-body">
		<!-- start place List 지금은 굳이 상관안해도 되고 나중에 이름 바꿀때 right side bar nav -->
		<div class="date-wrapper">일정 작성
			<p>
				<input type="text" name="daterange" class="data-range-picker" data-init-todate='<c:out value="${schDto.toDate}" />' data-init-fromdate='<c:out value="${schDto.fromDate}" />' />
			</p>
		</div>
		
		
		
		<ul class="left-date-list" id="left-date-list">
		<!-- 일자별 모든 녀석들 출력하는 리스트 -->
		</ul> 
		
		<button class="btn-rec-place">추천 장소</button>
		<ul class="left-place-rec-list">
		<li class="left clearfix" id="rec-place">
				<c:forEach items="${places}" var="list">
					<div class="rec-place" data-title="${list.plcTitle}" data-plc-no="${list.plcNo}">
						<c:out value="${list.plcTitle}"></c:out>
					</div>
				</c:forEach>
			</li>
		</ul>
		<ul class="left-place-list" id="left-place-list">
			
		</ul>
	</div>
	<!-- end place list -->

<!-- 맵 시작 -->
	<div id="map" style="width: 100%; height: 350px;"></div>
<!-- 맵 끗 -->

		<!-- 검색 창의 시작  -->
		<form name="searchForm" id="searchForm">
			<i class="fa fa-map-marker"></i> 
				<input type="text" id="search-value" onkeypress="return false" /><br>
				<button class="search-button" type="button">
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
        <!-- 닫기 버튼 -->
        <div class="modal_close"><a href="#">close</a></div>
    </div>
    
    <div id="transit-container" class="transit-container" data-transit="car"></div>
    <button type='button' id="transit-btn-car" data-transit="car">차</button>
    <button type='button' id="transit-btn-transit" data-transit="transit">대중교통</button>

	<script type="text/javascript" src="/resources/js/place.js"></script>
	<script type="text/javascript"
			src="//dapi.kakao.com/v2/maps/sdk.js?appkey=5f94b63952e978262a005cd52fcc313b&libraries=services"></script>
	<script type="text/javascript">
	
	
		var markers =[];
		var marker;
		
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = {
	       center : new kakao.maps.LatLng(33.529252,126.589699), // 지도의 중심좌표
	       level : 4
	    // 지도의 확대 레벨
	    };
	    var map = new kakao.maps.Map(mapContainer,
	          mapOption); // 지도를 생성합니다
	   
	          
	   $(document).ready(function(){ // document readty, datepicker의 초기값과 이벤트 등록 전담
		   
		   let datePicker = document.getElementsByClassName("data-range-picker")[0];
		   let fromDate = datePicker.dataset["initFromdate"];
		   let toDate = datePicker.dataset["initTodate"];
		   
		   $('input[name="daterange"]').daterangepicker({
				startDate: fromDate,
				endDate: toDate, 
				minDate: moment(),
				locale: {
					format: 'YYYY-MM-DD'
				}
			  }, function(start, end, label) {
			     console.log("A new date selection was made: " + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD')); 
			  });
		   
		   $('input[name="daterange"]').on('apply.daterangepicker', (e, picker) => {
			   computeDate(); 
		      }); 
		   
		   
		   
		   
			init();
		})
		
		function init() { //이벤트 등록 전담용 initial
		   computeDate();
		 //모달보는 버튼에 이벤트 추가
		    document.querySelector('#transit-btn-car').addEventListener('click', modalShow);
		    document.querySelector('#transit-btn-car').addEventListener('click', function(e) {
		    	document.getElementById("transit-container").setAttribute("data-transit", this.dataset["transit"]);
		    	console.log(document.getElementById("transit-container").getAttribute("data-transit")); // 맞게 바뀐지 확인용
		    });
		    
		    
		    document.querySelector('#transit-btn-transit').addEventListener('click', modalShow);
			document.querySelector('#transit-btn-transit').addEventListener('click', function(e) {
	        	document.getElementById("transit-container").setAttribute("data-transit",this.dataset["transit"]); 
				console.log(document.getElementById("transit-container").getAttribute("data-transit")); // 디버깅용임
		    });
			
		    document.querySelector('.modal_close').addEventListener('click', modalClose);
		    
			document.querySelector('.search-button').addEventListener('click', searchAction);
			document.querySelector('.btn-rec-place').addEventListener('click', showRecPlace);
			document.querySelector('.daily-place-list').style.display ='block';
			
	    }
	          
	          
	   
	    

	    //모달 보여지는 메서드
	    function modalShow() {
	    	document.querySelector('.modal_wrap').style.display ='block';
	        document.querySelector('.black_bg').style.display ='block';
	    };

	    //모달 사라지는 메서드
	    function modalClose() {
	        document.querySelector('.modal_wrap').style.display ='none';
	        document.querySelector('.black_bg').style.display ='none';
	    }
	    
	    function showDailyPlaceList(event) {
	    	let currTarget = event.currentTarget;
	    	let btnList = document.getElementsByClassName("daily-place-btn")
	    	let i;
	    	let dailyPlaceList = document.querySelectorAll('.daily-place-list')
	    	for (i = 0; i < btnList.length; i++) {
				if(btnList[i] == currTarget) {
					dailyPlaceList[i].style.display='block';
				}
				else{
					dailyPlaceList[i].style.display='none';
				}
			}
	    }

	    function computeDate() { // date picker apply 이벤트랑, 초기값 계산해서 button 생성하는 function
	    	let datePicker = document.getElementsByClassName("data-range-picker")[0];
	    	let dateList = datePicker.value.split(' - ');
			let fromDate = new Date(dateList[0]);
			let toDate = new Date(dateList[1]);
	    	let dateDiff = Math.ceil((toDate.getTime()-fromDate.getTime())/(1000*3600*24));
		    let idx =0;
		    let totalDate = document.getElementById("left-date-list");
		    let totalPlace = document.getElementById("left-place-list");
		    totalDate.innerHTML = null;
		    totalPlace.innerHTML = null; // 수정되면 초기화 작업
		   for(idx; idx<=dateDiff; idx++ ){
			   let objs;
			    objs = document.createElement('button');
		        objs.setAttribute('class', 'daily-place-btn');
		        objs.innerText=idx+1+"일차";
		        objs.addEventListener('click', showDailyPlaceList);
		        totalDate.appendChild(objs);
		        
		       let liobjs
		       liobjs = document.createElement('li');
		       liobjs.setAttribute('class', 'daily-place-list');
		       liobjs.setAttribute('style','display:none');
		       liobjs.innerText=idx+1+"일차 장소리스트 on";
		       totalPlace.appendChild(liobjs);
		       
		   }
		   document.querySelector('.daily-place-list').style.display='block';
	    }
	    
	    function showRecPlace() { // 추천장소 버튼을 누르면 장소들 등장, button을 추가할지 말진 모르겠다.
	          let recPlace = document.querySelectorAll('.rec-place');
	          let len = recPlace.length;
	          let i;
	          for (i = 0; i < len; i++) {
	             recPlace[i].style.display='block';
	         }
	          
	       }
	    
	    
	    
	    function searchAction() {
			let placeValue = $("#search-value").val();
			let placeList = $(".right-place-list");
			let leftPlace = document.getElementsByClassName("selected-place");
			placeList.empty();
			let i,j;
			let tmplist = [];
			placeService.getList({title : placeValue},
					function(list) {
						let len = list.length;
						let leng = leftPlace.length;
						for (i= 0, len||0; i<len-leng; i++) {
							for (j = 0; j < leng||0; j++) {
									if(leftPlace[j].dataset["title"]==list[i].plcTitle){
										tmplist.push(list[i]);
										list.splice(i,1);
									}
							}
						}
						console.log(tmplist); // 디버깅용 tmplist
						
						for (i = 0, len|| 0; i < len-leng; i++) {
							let liobj = document.createElement("li");	
							liobj.setAttribute('class', 'left clearfix');
							
							let objs1 = document.createElement("div");
							objs1.setAttribute('class','hoverable-place');
							objs1.setAttribute('data-title',list[i].plcTitle);
							objs1.setAttribute('data-region-id',list[i].regionId);
							objs1.setAttribute('data-plc-dt',list[i].plcDt);
							objs1.setAttribute('data-plc-no',list[i].plcNo);
							objs1.setAttribute('data-holiday',list[i].holiday);
							objs1.setAttribute('data-lat',list[i].lat);
							objs1.setAttribute('data-lng',list[i].lng);
							objs1.setAttribute('data-opening-h',list[i].openingH);
							objs1.setAttribute('data-p-cate',list[i].pCate);
							objs1.innerText=list[i].plcTitle + " ";
							objs1.addEventListener('mouseover',placeOver);
							
							let btnobj1 = document.createElement("button");
							btnobj1.setAttribute('class', 'add-button');
							let iconobj1 = document.createElement("i");
							iconobj1.setAttribute('class', 'fas fa-plus');
							iconobj1.addEventListener('click',moveToLeft);
							btnobj1.appendChild(iconobj1);
							
							let btnobj2 = document.createElement("button");
							btnobj2.setAttribute('class', 'detail-button');
							let iconobj2 =document.createElement("i");
							iconobj2.setAttribute('class', 'fas fa-search-plus');
							iconobj2.addEventListener('click',placeDetail);
							btnobj2.appendChild(iconobj2);

							objs1.appendChild(btnobj1);
							objs1.appendChild(btnobj2);
							liobj.appendChild(objs1);
							placeList.append(liobj);
						}
						
					})
			return;
		}
		
		function deleteInLeft(event) {
			let deleteElement = event.currentTarget;
			deleteElement.parentElement.parentElement.remove(); 
			}
		
		function getActiveDay(){
			let dateList = document.getElementsByClassName("daily-place-list");
			console.log(dateList);
			let idx, i;
			for (i = 0; i < dateList.length; i++) {
				
				if(dateList[i].style.display=="block"){
					idx = i;
				}
			}
			console.log(idx);
			return idx;
		}

		function moveToLeft(event) {
			let clickedBtn = event.currentTarget;
			let index = document.getElementsByClassName("left-place-list")
			let parentE = clickedBtn.parentElement.parentElement.dataset;
			let placeList = $(".left-place-list");
			let leftPlace = document.getElementsByClassName("selected-place");
			let dailyPlaceList = document.getElementsByClassName("daily-place-list");
			let idx = getActiveDay(); // idx 를 얻었다.
			let currentList = dailyPlaceList[idx];
			
							
							let objs1 = document.createElement("div");
							objs1.setAttribute('class','selected-place');
							objs1.setAttribute('data-title',parentE['title']);
							objs1.setAttribute('data-region-id',parentE['regionId']);
							objs1.setAttribute('data-plc-dt',parentE['plcDt']);
							objs1.setAttribute('data-plc-no',parentE['plcNo']);
							objs1.setAttribute('data-holiday',parentE['holiday']);
							objs1.setAttribute('data-lat',parentE['lat']);
							objs1.setAttribute('data-lng',parentE['lng']);
							objs1.setAttribute('data-opening-h',parentE['openingH']);
							objs1.setAttribute('data-p-cate',parentE['pCate']);
							objs1.innerText=parentE['title'] + " ";
						

							let btnobj1 = document.createElement("button");
							btnobj1.setAttribute('class', 'delete-button');
							let iconobj1 = document.createElement("i");
							iconobj1.setAttribute('class', 'fas fa-times');
							iconobj1.addEventListener('click',deleteInLeft);
							btnobj1.appendChild(iconobj1);
							objs1.appendChild(btnobj1);
							currentList.append(objs1);
							
			
			if(markers.length||0){
				markers[0].setMap(null);
				markers.pop();
			}
			clickedBtn.parentElement.parentElement.parentElement.remove();
		}
		
		function placeDetail(event) { // 상세 정보 보기 페이지 URL + palceNo로 이루어져있다
			let clickedBtn = event.currentTarget;
			let placeNo = clickedBtn.parentElement.parentElement.dataset["plcNo"];
			let URL = "https://place.map.kakao.com/"+placeNo;
			window.open(URL, "카카오 지도", "width=800, height=700, toolbar=no, menubar=no, scrollbars=no, resizable=yes" ); 
		}
		
		function placeOver(event) {
			   let currTarget = event.currentTarget;
		       // 지도를 재설정할 범위정보를 가지고 있을 LatLngBounds 객체를 생성합니다
		       var bounds = new kakao.maps.LatLngBounds();
		      
		       /*  for (var i = 0; i < markers.length||0; i++) {
					//  굳이 marker배열을 쓸 필요가 없으면 필요없을거 같기도 하다.
					
				} */
		          var placePosition = new kakao.maps.LatLng(
		                (currTarget.dataset["lat"]),
		                (currTarget.dataset["lng"])),
		          marker = addMaker(placePosition);
		          panTo(marker);
		          
		          currTarget.addEventListener("mouseout",function(){
		        	  marker.setMap(null);
		        	  markers.pop();
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
	    	    map.setProportion;
	    	    map.panTo(moveLatLon);            
	    	}
		}
		
		
	</script>
</body>
</html>

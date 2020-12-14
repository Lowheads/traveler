<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ include file="../includes/mypageheader.jsp" %>

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
    
</div>
     <!-- End Map -->
      </div>

      <div class="content-mypage" style="padding-top: 20px;" >
     <!-- sort -->
<select id="listSort" style="float:right; display:block; margin-right:7%;" > 
<option hidden selected disabled ></option>
<option value="like">좋아요 순</option>
<option value="new">최근에 찜한 순</option>
<option value="old">오래전에 찜한 순</option>
</select><br>
        <div class="row" id="new">

<c:forEach items="${list }" var="place">
            <div class="card h-100" id="resultcard">
           <a href='https://place.map.kakao.com/${place.plcNo}' target="_blank">
           <img class="card-img-top" src="${place.plcImg}" alt=""></a>
     <div class="heart">
          <i class="fa fa-heart" data-plc_no="${place.plcNo }" style="font-size:24px;color:red" onclick="likeToggle(this)"></i><br>
          <!-- 빈하트 -->
          <!-- <i class="fa fa-heart-o" style="font-size:24px; color:red"></i> -->
   </div>
   <p style="font-size:3px;	">좋아요 <b><c:out value="${place.likeCnt }"/></b>개
      </p>
           <input type="hidden" value='${place.plcNo }' id='plc_no'>
           <input type="hidden" data-plc_no="${place.plcNo }" data-plc_dt="${place.addressDt}" data-lat="${place.lat }" data-lng="${place.lng }" data-title="${place.plcTitle }" class="markerlatlng">
              <div class="card-body">
                <h5 class="card-title">
                   <a href='https://place.map.kakao.com/${place.plcNo}' target="_blank">
                   <c:out value="${place.plcTitle }"></c:out></a>
                     <!-- Like  -->
       <!-- Like end -->
                </h5>
               	<c:if test="${place.holiday ne null }">
               	휴무일 :
               	</c:if>
                <c:out value="${place.holiday }"/><br>
                  	<c:if test="${place.openingH ne null }">
               	영업시간 :
               	</c:if>
                <c:out value="${place.openingH}"/>
           
              </div>
            </div>
</c:forEach>

<form id='actionForm' action="/mypage/pickPL" method='get'>
	<input type='hidden' name='pageNum' value = '${pageMaker.cri.pageNum }'>
	<input type='hidden' name='selected' value = <%= request.getParameter("selected") %>>
</form>


        </div>
<button type='button' id="modal_btn" class="pull-right" style="float:right; display:block; margin-right:7%;">지도에서 보기</button>
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

</div>
<!-- modal -->

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9eb973825ac1960ebb20d660fdf86341"></script>


<script type="text/javascript">
	$(document).ready(function() {
		
					selectVal();
					
					});
	
	let actionForm = $("#actionForm");
	let markers = [];
	//마커의 좌표값 얻어오기
	let markerlatlng = document.getElementsByClassName("markerlatlng");
	let infowindow = new kakao.maps.InfoWindow({zIndex:1});
	/* alert($(".markerlatlng").attr("lat")+""+$(".markerlatlng").attr("lng")); */
	//모달 보여지는 메서드
	function modalShow() {
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
	//모달 사라지는 메서드
	function modalClose() {
		document.querySelector('.modal_wrap').style.display = 'none';
			document.querySelector('.black_bg').style.display = 'none';
		}

		document.getElementById('modal_btn').addEventListener('click', modalShow);
		document.querySelector('.modal_close').addEventListener('click', modalClose);

	//셀렉트 value 값 설정
	function selectVal(){
			let selVal = document.location.href.split("selected=");
			
			let selArr = $("#listSort option");
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

		//조와요
		function likeToggle(heart){
			if(heart.className == "fa fa-heart"){
				let sendData = {
						'plcNo' : heart.dataset['plc_no'],
					}
					//ajax 기능 추가 
					$.ajax({
						type : 'post',
						url : '/mypage/deletePick',
						data : sendData,
						success : function(data) {
							heart.classList.toggle("fa-heart-o");
							heart.parentElement.nextElementSibling.firstElementChild.innerText = 
								Number(heart.parentElement.nextElementSibling.firstElementChild.innerText)-1;
					 	},
						error : function(error){
							alert("에러발생!! 다시시도해주세요"+error);
						}
					});
			}
			
			if(heart.className == "fa fa-heart fa-heart-o"){
				let sendData = {
						'plcNo' : heart.dataset['plc_no'],
					}
					//ajax 기능 추가 
					$.ajax({
						type : 'post',
						url : '/mypage/insertPick',
						data : sendData,
						success : function(data) {
							heart.classList.toggle("fa-heart-o");
							heart.parentElement.nextElementSibling.firstElementChild.innerText = 
								Number(heart.parentElement.nextElementSibling.firstElementChild.innerText)+1;
						},
						error : function(error){
							alert("에러발생!! 다시시도해주세요"+error);
						}
					});
			}
			
		}; 
		
		$(".black_bg").on("click",function(){
			
			document.querySelector('.modal_wrap').style.display = 'none';
			document.querySelector('.black_bg').style.display = 'none';
			
		});

</script>
<%@include file="../includes/footer.jsp" %>
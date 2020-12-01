<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <style>
.map_wrap, .map_wrap * {margin:0;padding:0;font-family:'Malgun Gothic',dotum,'돋움',sans-serif;font-size:12px;}
.map_wrap a, .map_wrap a:hover, .map_wrap a:active{color:#000;text-decoration: none;}
.map_wrap {position:relative;width:100%;height:500px;}
#menu_wrap {position:absolute;top:0;left:0;bottom:0;width:250px;margin:10px 0 30px 10px;padding:5px;overflow-y:auto;background:rgba(255, 255, 255, 0.7);z-index: 1;font-size:12px;border-radius: 10px;}
.bg_white {background:#fff;}
#menu_wrap hr {display: block; height: 1px;border: 0; border-top: 2px solid #5F5F5F;margin:3px 0;}
#menu_wrap .option{text-align: center;}
#menu_wrap .option p {margin:10px 0;}  
#menu_wrap .option button {margin-left:5px;}
#placesList li {list-style: none;}
#placesList .item {position:relative;border-bottom:1px solid #888;overflow: hidden;cursor: pointer;min-height: 65px;}
#placesList .item span {display: block;margin-top:4px;}
#placesList .item h5, #placesList .item .info {text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
#placesList .item .info{padding:10px 0 10px 55px;}
#placesList .info .gray {color:#8a8a8a;}
#placesList .info .jibun {padding-left:26px;background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png) no-repeat;}
#placesList .info .tel {color:#009900;}
#placesList .item .markerbg {float:left;position:absolute;width:36px; height:37px;margin:10px 0 0 10px;background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png) no-repeat;}
#placesList .item .marker_1 {background-position: 0 -10px;}
#placesList .item .marker_2 {background-position: 0 -56px;}
#placesList .item .marker_3 {background-position: 0 -102px}
#placesList .item .marker_4 {background-position: 0 -148px;}
#placesList .item .marker_5 {background-position: 0 -194px;}
#placesList .item .marker_6 {background-position: 0 -240px;}
#placesList .item .marker_7 {background-position: 0 -286px;}
#placesList .item .marker_8 {background-position: 0 -332px;}
#placesList .item .marker_9 {background-position: 0 -378px;}
#placesList .item .marker_10 {background-position: 0 -423px;}
#placesList .item .marker_11 {background-position: 0 -470px;}
#placesList .item .marker_12 {background-position: 0 -516px;}
#placesList .item .marker_13 {background-position: 0 -562px;}
#placesList .item .marker_14 {background-position: 0 -608px;}
#placesList .item .marker_15 {background-position: 0 -654px;}
#pagination {margin:10px auto;text-align: center;}
#pagination a {display:inline-block;margin-right:10px;}
#pagination .on {font-weight: bold; cursor: default;color:#777;}
table, th, td {
  border: 1px solid black;
  border-collapse: collapse;
}

</style>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>loginform</title>
</head>
<body>
<h1>관리자 로그인</h1>
<br><br>
${errorMessage}<br>
<form method="post" action="login">
	암호 : <input type="password" name="passwd"><br>
	<input type="submit">
</form>


<div class="map_wrap">
    <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>

    <div id="menu_wrap" class="bg_white">
        <div class="option">
            <div>
                <form onsubmit="searchPlaces(); return false;">
                    키워드 : <input type="text" value="제주도테마파크" id="keyword" size="15"> 
                    <button type="submit" id="search">긁어오기</button> 
                </form>
            </div>
        </div>
        <hr>
        <ul id="placesList"></ul>
        <div id="pagination"></div>
    </div>
</div>
<h1>제주도 DB</h1>

<table id="dbtable">
  <tr>
    <th>장소명</th>
    <th>장소번호</th>
    <th>카테고리명</th>
    <th>위도</th>
    <th>경도</th>
    <th>카테고리그룹명</th>
    <th>카테고리</th>
  </tr>
  <tr>
    <td>ex1</td>
    <td>ex2</td>
    <td>ex3</td>
    <td>ex4</td>
    <td>ex5</td>
    <td>ex6</td>
    <td>ex7</td>
  </tr>
</table>
	
<!-- 
        // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
        infowindow.setContent('<div style="padding:5px;font-size:12px;">' 
        + place.place_name + "<br>" 
        + place.id+ "<br>" 
        + place.category_name + "<br>"
        + place.x + "<br>" 
        + place.y+ "<br>" 
        + place.category_group_name + "<br>" 
        + place.address_name+ "<br>"
        + place.category_group_code + "<br>"
        + '</div>');
        infowindow.open(map, marker); -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9eb973825ac1960ebb20d660fdf86341&libraries=services,clusterer,drawing"></script>
</body>
	<script type="text/javascript">
	
	// 마커를 담을 배열입니다
	var markers = [];
	
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = {
	        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };  
	
	// 지도를 생성합니다    
	var map = new kakao.maps.Map(mapContainer, mapOption); 
	
	// 장소 검색 객체를 생성합니다
	var ps = new kakao.maps.services.Places();  
	
	// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
	var infowindow = new kakao.maps.InfoWindow({zIndex:1});
	
	// 키워드로 장소를 검색합니다
	searchPlaces();
	
	// 키워드 검색을 요청하는 함수입니다
	function searchPlaces() {
	
	    var keyword = document.getElementById('keyword').value;
	
	    var word = ['건입동 테마파크','구좌읍 테마파크','내도동 테마파크','노형동 테마파크','도남동 테마파크','도두동 테마파크',
	    	'도두이동 테마파크','도두일동 테마파크',
	    	'도련이동 테마파크','도련일동 테마파크',
	    	'도평동 테마파크','봉개동 테마파크',
	    	'삼도1동 테마파크','삼도2동 테마파크',
	    	'삼도이동 테마파크','삼도1동 테마파크',
	    	'제주시 삼양동 테마파크','제주시 삼양삼동 테마파크',
	    	'제주시 삼양이동 테마파크','제주시 삼양일동 테마파크',
	    	'제주시 아라동 테마파크','제주시 아라이동 테마파크',
	    	'제주시 아라일동 테마파크','제주시 애월읍 테마파크',
	    	'제주시 연동 테마파크','제주시 영평동 테마파크',
	    	'제주시 오등동 테마파크','제주시 오라동 테마파크',
	    	'오라삼동 테마파크','오라이동 테마파크','오라일동 테마파크',
	    	'외도동 테마파크','외도이동테마파크','외도일동테마파크',
	    	'제주 용강동테마파크','제주시 용담1동 테마파크',
	    	'제주시 용담2동 테마파크','제주시 용담삼동 테마파크',
	    	'제주시 용담일동 테마파크','제주시 우도면 테마파크',
	    	'제주시 월평동 테마파크','제주시 이도1동 테마파크',
	    	'제주시 이도이동테마파크','제주시 이호동 테마파크',
	    	'제주시 이호이동 테마파크','제주시 이호일동 테마파크',
	    	'제주시 일도1동테마파크','제주시 일도2동 테마파크',
	    	'제주시 일도이동 테마파크','제주시 일도일동 테마파크',
	    	'제주시 조천읍 테마파크','제주시 추자면 테마파크',
	    	'제주시 한경면 테마파크','제주시 한림읍 테마파크',
	    	'제주시 해안동 테마파크','제주시 해안동 테마파크',
	    	'제주시 화북동 테마파크','제주시 화북이동 테마파크',
	    	'제주시 화북일동 테마파크','제주시 회천동 테마파크',
	    	'서귀포시 강정동 테마파크', '서귀포시 남원읍 테마파크', '서귀포시 대륜동 테마파크', '서귀포시 대정읍 테마파크', '서귀포시 대천동 테마파크', '서귀포시 대포동 테마파크', '서귀포시 도순동 테마파크', '서귀포시 동홍동 테마파크',
	    	'서귀포시 법환동 테마파크', '서귀포시 상예동 테마파크', '서귀포시 상효동 테마파크', '서귀포시 색달동 테마파크', '서귀포시 서귀동 테마파크', '서귀포시 서호동 테마파크', '서귀포시 서홍동 테마파크', '서귀포시 성테마파크읍 테마파크',
	    	'서귀포시 송테마파크동 테마파크', '서귀포시 신효동 테마파크', '서귀포시 안덕면 테마파크', '서귀포시 영남동 테마파크', '서귀포시 영천동 테마파크', '서귀포시 예래동 테마파크', '서귀포시 월평동 테마파크', '서귀포시 정방동 테마파크',
	    	'서귀포시 중문둥 테마파크', '서귀포시 중앙동 테마파크', '서귀포시 천지동 테마파크', '서귀포시 토평동 테마파크', '서귀포시 표선면 테마파크', '서귀포시 하예동 테마파크', '서귀포시 하원동 테마파크', '서귀포시 하효동 테마파크',
	    	'서귀포시 호근동 테마파크', '서귀포시 회수동 테마파크', '서귀포시 효돈동 테마파크', '서귀포시 보목동 테마파크'];
	    
	    if (!keyword.replace(/^\s+|\s+$/g, '')) {
	        alert('키워드를 입력해주세요!');
	        return false;
	    }
	
	/*     alert(word[0]); */
	    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
			for (let i = 0; i < word.length; i++) {
				
	    ps.keywordSearch( word[i], placesSearchCB); 
			}
	}
	
	// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
	function placesSearchCB(result, status,pagination) {
	    if (status === kakao.maps.services.Status.OK) {
	
	        // 정상적으로 검색이 완료됐으면
	        // 검색 목록과 마커를 표출합니다
	        
	        displayPlaces(result);
				
	        displayPagination(pagination); 
	        //객체가 날아옴 장소객체
	        for (let i = 1; i <= pagination.last; i++) {
				
	        
	        pagination.nextPage();
			}
	    }
	    else if (status === kakao.maps.services.Status.ZERO_RESULT) {
	
	        alert('검색 결과가 존재하지 않습니다.');
	        return;
	
	    } else if (status === kakao.maps.services.Status.ERROR) {
	
	        alert('검색 결과 중 오류가 발생했습니다.');
	        return;
	
			}

	
	}
	
	// 검색 결과 목록과 마커를 표출하는 함수입니다
	function displayPlaces(places) {
	
	    var listEl = document.getElementById('placesList'), 
	    menuEl = document.getElementById('menu_wrap'),
	    dblist = document.getElementById('dbtable'),
	    fragment = document.createDocumentFragment(), 
	    bounds = new kakao.maps.LatLngBounds(), 
	    listStr = '';
	    
	    // 검색 결과 목록에 추가된 항목들을 제거합니다
	    removeAllChildNods(listEl);
	
	    // 지도에 표시되고 있는 마커를 제거합니다
	    removeMarker();
	    
	    for ( var i=0; i<places.length; i++ ) {
	
	    	var sendData = {
					'plcNo' : places[i].id,
					'plcTitle' : places[i].place_name,
					/* 'category_name' : places[i].category_name, */
					'lat' : places[i].y,
					'lng' : places[i].x,
					/* 'category_group_name' : places[i].category_group_name, */
					'addressDt' : places[i].address_name,
					'pCate' : places[i].category_group_code
				}
	    	
	    	console.log(sendData);
	    	$.ajax({
				type : 'post',
				url : '/mypage/getDB',
				data : sendData,
				success : function(result) {
					console.log(result);
				}
			});
	    	
	        // 마커를 생성하고 지도에 표시합니다
	        var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
	            marker = addMarker(placePosition, i), 
	            itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다
	
	        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
	        // LatLngBounds 객체에 좌표를 추가합니다
	        bounds.extend(placePosition);
	
	        // 마커와 검색결과 항목에 mouseover 했을때
	        // 해당 장소에 인포윈도우에 장소명을 표시합니다
	        // mouseout 했을 때는 인포윈도우를 닫습니다
	        (function(marker, title) {
	            kakao.maps.event.addListener(marker, 'mouseover', function() {
	                displayInfowindow(marker, title);
	            });
	
	            kakao.maps.event.addListener(marker, 'mouseout', function() {
	                infowindow.close();
	            });
	
	            itemEl.onmouseover =  function () {
	                displayInfowindow(marker, title);
	            };
	
	            itemEl.onmouseout =  function () {
	                infowindow.close();
	            };
	        })(marker, places[i].place_name);
	
	        fragment.appendChild(itemEl);
	    }
	
	    // 검색결과 항목들을 검색결과 목록 Elemnet에 추가합니다
	    listEl.appendChild(fragment);
	    menuEl.scrollTop = 0;
	
	    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
	    map.setBounds(bounds);
	}
	
	// 검색결과 항목을 Element로 반환하는 함수입니다
	function getListItem(index, places) {
	
	    var el = document.createElement('li'),
	    itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
	                '<div class="info">' +
	                '   <h5>' + places.place_name + '</h5>';
	
	                
	    
	    if (places.road_address_name) {
	        itemStr += '    <span>' + places.road_address_name + '</span>' +
	                    '   <span class="jibun gray">' +  places.address_name  + '</span>';
	    } else {
	        itemStr += '    <span>' +  places.address_name  + '</span>'; 
	    }
	                 
	      itemStr += '  <span class="tel">' + places.phone  + '</span>' +
	                '</div>';           
	
	    el.innerHTML = itemStr;
	    el.className = 'item';
	
	    return el;
	}
	
	function getListItem2(index, places) {
		  //리스트만들기
	    var tr = documen.createElement('tr'),
	    tdStr = '<td>'+places.place_name+'</td>'+
	    '<td>'+places.id+'</td>'+
	    '<td>'+places.category_name+'</td>'+
	    '<td>'+places.x+'</td>'+
	    '<td>'+places.y+'</td>'+
	    '<td>'+places.category_group_name+'</td>'+
	    '<td>'+places.address_name+'</td>'+
	    '<td>'+places.category_group_code+'</td>';
	    
	    tr.innerHTML = tbStr;
	    tr.className = 'dblist';
	    
	    return tr
	}
	// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
	function addMarker(position, idx, title) {
	    var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
	        imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
	        imgOptions =  {
	            spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
	            spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
	            offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
	        },
	        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
	            marker = new kakao.maps.Marker({
	            position: position, // 마커의 위치
	            image: markerImage 
	        });
	
	    marker.setMap(map); // 지도 위에 마커를 표출합니다
	    markers.push(marker);  // 배열에 생성된 마커를 추가합니다
	
	    return marker;
	}
	
	// 지도 위에 표시되고 있는 마커를 모두 제거합니다
	function removeMarker() {
	    for ( var i = 0; i < markers.length; i++ ) {
	        markers[i].setMap(null);
	    }   
	    markers = [];
	}
	
	// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
	function displayPagination(pagination) {
	    var paginationEl = document.getElementById('pagination'),
	        fragment = document.createDocumentFragment(),
	        i; 
	
	    // 기존에 추가된 페이지번호를 삭제합니다
	    while (paginationEl.hasChildNodes()) {
	        paginationEl.removeChild (paginationEl.lastChild);
	    }
	
	    for (i=1; i<=pagination.last; i++) {
	        var el = document.createElement('a');
	        el.href = "#";
	        el.innerHTML = i;
	
	        if (i===pagination.current) {
	            el.className = 'on';
	            
	        } else {
	        	   /* var schbtn = document.getElementById('search');
		        schbtn.onclick */
	        	
	             el.onclick = (function(i) {
	                return function() {
	                    pagination.gotoPage(i);
/* 						alert(pagination.current[2]); */
	                }
	            })(i);
	        }
	
	        fragment.appendChild(el);
	    }
	    paginationEl.appendChild(fragment);
	}
	
	// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
	// 인포윈도우에 장소명을 표시합니다
	function displayInfowindow(marker, title) {
	    var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';
	
	    infowindow.setContent(content);
	    infowindow.open(map, marker);
	}

 // 검색결과 목록의 자식 Element를 제거하는 함수입니다
function removeAllChildNods(el) {   
    while (el.hasChildNodes()) {
        el.removeChild (el.lastChild);
    }
}
 
</script>
</html>
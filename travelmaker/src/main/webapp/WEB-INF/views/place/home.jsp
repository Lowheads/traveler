<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page session = "true" %>
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
   <style>
.daily-place-list {
   list-style-type: none;
   margin: 0;
   padding: 0;
   width: 60%;
}

.daily-place-list li {
   margin: 0 3px 3px 3px;
   padding: 0.4em;
   width: auto;
   font-size: 15px;
}

.daily-place-list li span {
   position: absolute;
   margin-left: -1.3em;
}

.mainContainer {
   display: flex;
   align-content: space-between;
}

.menu {
   flex-basis: 0;
   flex-grow: 1;
   height: 750px;
}

.left-menu {
   flex: 0 0 18%;
   display: flex;
}

.left-date {
   flex: 0 0 25%;
   border-right-style: solid;
}

.left-date ul {
   padding: 0;
}

.left-place-list {
   padding: 0 5px 0 5px;
}

.container {
   flex: 0 0 70%;
}

.daily-place-all {
   border-style: groove;
   width: 200px;
}

ul {
   list-style: none;
   padding: 0;
}

#show {
   position: absolute;
   top: 10px;
   left: 10px;
   width: 42px;
   height: 42px;
   z-index: 1;
   cursor: pointer;
}

#Allschedule {
   display: flex;
}

#showAll {
   display: none;
   width: 70%;
   height: 80%;
   padding: 20px 30px;
   background-color: #fefefe;
   border: 1px solid #888;
   border-radius: 3px;
}

.daily-all-place {
   border: 1px solid #888;
}
</style>
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  <script>
  var dnd = $.noConflict(true);
  </script>
</head>
<body>
   <!-- /.panel-heading -->
   
    <div id="showAll">
    <div id="Allschedule"></div>
               <button class="modal_close_btn" style="float:right;">닫기</button>
        </div>
      <!-- start place List 지금은 굳이 상관안해도 되고 나중에 이름 바꿀때 right side bar nav -->
      <div class="mainContainer">
      <div class="left-menu">
      <div class="left-date">
      
      <ul class="left-date-list" id="left-date-list">
      
      <!-- 일자별 모든 녀석들 출력하는 리스트 -->
      </ul> 
      </div>
      
      <div class="left-place-list">
      <div class="date-wrapper">일정 작성
      <button id="hide" style="float:right;"> << </button>
         <p>
            <input type="text" name="daterange" class="data-range-picker" data-region-no='<c:out value="${schDto.schRegion}" />' data-init-todate='<c:out value="${schDto.toDate}" />' data-init-fromdate='<c:out value="${schDto.fromDate}" />' />
         </p>
      </div>
      
      
      <button class="btn-rec-place">추천 장소</button>
      <div class="left-place-rec-list">
         <ul class="left clearfix" id="rec-place">
         <c:forEach items="${places}" var="list">
         <li class="rec-place" data-title="${list.plcTitle}" data-plc-no="${list.plcNo}" data-lat="${list.lat }" data-lng="${list.lng}" data-opening-h="${list.openingH }" data-holiday="${list.holiday}" data-address-dt="${list.addressDt}" data-region-no="${list.regionNo}">
                  <c:out value="${list.plcTitle}"></c:out>
                  <img src='<c:out value="${list.plcImg}"></c:out>' style="width:50px;height:60px">
                  <button class="rec-add-button" type="button">
                  <i class="fas fa-plus"></i>
                  </button>
            </li>
            </c:forEach>
         </ul>
      </div>
      <div class="left-place-list" id="left-place-list">
            
      </div>
   </div>
   </div>
   <!-- end place list -->
<!-- 맵 시작 -->
<div class="container">
     <div id="mapWrapper">
        <div id="map" style="width:100%;height:100%"></div> <!-- 지도를 표시할 div 입니다 -->
        <div id="show" style="display:none;"><button>>></button></div>
    </div>
   </div>
<!-- 맵 끗 -->
<div class="right menu">
      <!-- 검색 창의 시작  -->
      <form name="searchForm" id="searchForm">
         <i class="fa fa-map-marker"></i> 
            <input type="text" id="search-value"/><br>
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
    <div class="right-paging-bar"></div>
    
    <div id="transit-container" class="transit-container" data-transit="car"></div>
    <button type='button' id="transit-btn-car" data-transit="car">차</button>
    <button type='button' id="transit-btn-transit" data-transit="traffic">대중교통</button>
</div>
</div>
  <button onclick="makeSchedule()">거리 계산해오기</button>
 <button onclick="insertSchedule()">일정 넣기</button>
 <button id="test">좌표변환계</button>
   <script type="text/javascript" src="/resources/js/place.js"></script>
   <script type="text/javascript"
         src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9eb973825ac1960ebb20d660fdf86341&libraries=services"></script>
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
                   mapContainer.style.width = '100%';
                  mapContainer.style.height = '100%';
                  
                   map.relayout();
      
                   $("#hide").click(function(){
                       $(".left-menu").hide();
                       document.querySelector('#show').style.display = 'block';
                       document.querySelector('.container').style.flex = '0 0 88%';
                    })
                    
                    $("#show").click(function(){
                       $(".left-menu").show();
                       document.querySelector('#show').style.display = 'none';
                       document.querySelector('.container').style.flex = '0 0 70%';
                       
                    })
                    
                    
                 //전체보기
      function showAll() {
          let zIndex = 9999;
          let modal = document.getElementById('showAll');
          let listAll = document.getElementById('Allschedule');
          let dpList = document.getElementsByClassName('daily-place-list');
          
          for (let i = 0; i < dpList.length; i++) {
             
            let objs = document.createElement('ul');
            objs.setAttribute('class','daily-place-all');
            objs.style.display = 'inline';
             objs.innerText=i+1+"일차";
             
             listAll.appendChild(objs);

             for (let j = 0; j < dpList[i].getElementsByTagName('li').length; j++) {
             let daliyplace = document.createElement('li');
             daliyplace.setAttribute('class','daily-all-place');
             daliyplace.innerText = dpList[i].getElementsByTagName('li')[j].dataset['title'];
             
             objs.appendChild(daliyplace);
         }
       }
          
          // 모달 div 뒤에 희끄무레한 레이어
          let bg = document.createElement('div');
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
                  //자식 노드 초기화a
         $("#Allschedule").empty();
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
                   
      $(document).ready(function(){ // document ready, datepicker의 초기값과 이벤트 등록 전담
         
                   
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
             // console.log("A new date selection was made: " + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD')); 
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
          });
          
          
          document.querySelector('#transit-btn-transit').addEventListener('click', modalShow);
         document.querySelector('#transit-btn-transit').addEventListener('click', function(e) {
              document.getElementById("transit-container").setAttribute("data-transit",this.dataset["transit"]); 
          });
         
          document.querySelector('.modal_close').addEventListener('click', modalClose);
          
         document.querySelector('.search-button').addEventListener('click', searchAction);
         document.querySelector('.btn-rec-place').addEventListener('click', showRecPlace);
         document.querySelector('.daily-place-list').style.display ='block';
         let recPlaceBtn = document.getElementsByClassName("rec-add-button");
         for (var i = 0; i < recPlaceBtn.length; i++) {
            recPlaceBtn[i].addEventListener('click', addRecPlace);
         }
         document.querySelector('.btn-make-schedule').addEventListener('click', makeSchedule)
         document.querySelector('#test').addEventListener('click', test); 
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
          /* if(!!($('#search-value').val())){
          searchAction();
          } */
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
          
          let objs = document.createElement('button');
          objs.setAttribute('class', 'showAllBtn');
          objs.innerText="전체보기";
          //전체보기 이벤트생성
          objs.addEventListener('click', showAll);
          
          totalDate.appendChild(objs);
          
         for(idx; idx<=dateDiff; idx++ ){
            let objs;
            objs = document.createElement('button');
             objs.setAttribute('class', 'daily-place-btn');
             objs.innerText=idx+1+"일차";
             objs.addEventListener('click', showDailyPlaceList);
             totalDate.appendChild(objs);
              
             let liobjs
             liobjs = document.createElement('ul');
             liobjs.setAttribute('class', 'daily-place-list');
             liobjs.setAttribute('style','display:none');
             liobjs.innerText=idx+1+"일차 장소리스트 on";
             totalPlace.appendChild(liobjs);
             
         }
         document.querySelector('.daily-place-list').style.display='block';
       }
       
       function showRecPlace() { // 추천장소 버튼을 누르면 장소들 등장, button을 추가할지 말진 모르겠다.
             let recPlace = document.querySelectorAll('.rec-place')
             let i;
             for (i= 0; i < recPlace.length; i++) {
                if(recPlace[i].style.display=='' || recPlace[i].style.display==='none' ){
                   recPlace[i].style.display='block';
                    }
                else if(recPlace[i].style.display==='block'){
                    recPlace[i].style.display='none';
                 }
                }
          }
       
       function addRecPlace(event) {
         let index = getActiveDay();
         let leftPlaceList = document.getElementsByClassName("daily-place-list");
         let activePlaceList = leftPlaceList[index];
         let compPlaceList = activePlaceList.children
         let currTarget = event.currentTarget.parentElement;
         let targetText = currTarget.innerText;
          let curClone = currTarget.cloneNode(true);
          curClone.setAttribute("class", "selected-place");
          let innerText = document.createTextNode(targetText);
             for (var i = 0; i < compPlaceList.length; i++) {
               if(curClone.dataset["plcNo"]==compPlaceList[i].dataset["plcNo"]){
                  return;
               }               
            }
         let child = curClone.children;
         child[1].remove()
         let btnobj1 = document.createElement("button");
         btnobj1.setAttribute('class', 'delete-button');
         let iconobj1 = document.createElement("i");
         iconobj1.setAttribute('class', 'fas fa-times');
         btnobj1.addEventListener('click',deleteInLeft);
         btnobj1.appendChild(iconobj1);
         
         curClone.appendChild(innerText);
         curClone.appendChild(btnobj1);
         activePlaceList.appendChild(curClone);
       }
       
       function makeSchedule() {
          let transit = document.getElementsByClassName("transit-container")[0].dataset["transit"];
          let i,j;
          let tmpAllList =[];
          let tmpList;
          let placeList = document.getElementsByClassName("daily-place-list");
          let len = placeList.length;
          
          for (i = 0; i < len; i++) {
             let tmpSchList = [];
            tmpList = placeList[i].children;
            tmplen = tmpList.length;
            for (j = 0; j < tmplen-1; j++) {
               let tmp = { 
                     schDate:i, // 1일차, 2일차, 3일차
                     fromPlc:tmpList[j].dataset["plcNo"],
                     fromPlcLat:tmpList[j].dataset["lat"],
                     fromPlcLng:tmpList[j].dataset["lng"],
                     fromPlcTitle:tmpList[j].dataset["title"],
                     toPlc:tmpList[j+1].dataset["plcNo"],
                     toPlcLat:tmpList[j+1].dataset["lat"],
                     toPlcLng:tmpList[j+1].dataset["lng"],
                     toPlcTitle:tmpList[j+1].dataset["title"],
                     transit:transit
               }
               tmpSchList.push(tmp);
            }
         tmpAllList.push(tmpSchList);
         }
         let sendJSON = JSON.stringify(tmpAllList);
          $.ajax({
              traditional : true,
               url: "/place/test",
               type: "POST",
               data: sendJSON,
               contentType: "application/json; charset=utf-8;",
               success: function(data){
                   alert("success : "+data);
               },
               error: function(){
                   alert("restController err");
               }
           });
       };
       
       function insertSchedule() {
    	  
    	   let datePicker = document.getElementsByClassName("data-range-picker")[0];
           let dateList = datePicker.value.split(' - ');
           let fromDate = new Date(dateList[0]);
           let toDate = new Date(dateList[1]);
           
           let addDays = function(date, days) { // 일을 증가시키는 메소드
	   		    let rdate= date.setDate(date.getDate() + days);
	   		    return rdate; 
   			}
           let transit = document.getElementsByClassName("transit-container")[0].dataset["transit"];
           let i,j;
           let tmpAllList =[];
           let tmpList;
           let placeList = document.getElementsByClassName("daily-place-list");
           let len = placeList.length;
           let memNo = sessionStorage.getItem("memNo");
           let scheduleVO = {
        		   // schNo: , // 스케쥴로 하는게 아니라 나중에 db에서 하는거임
        		   memNo:memNo,
        		   schTitle:"입력받은 그값",
        		   fromDate:fromDate,
        		   toDate:toDate,
        		   img:"hello",
        		   schStatus:"미완성",
        		   memo:"아직 테스트중이여요",	   
        		   schRegion:"지역이라는데 뭐지 이거"
           }
           for (i = 0; i < len; i++) {
        	   
             let tmpSchList = [];
             tmpList = placeList[i].children;
             tmplen = tmpList.length;
             for (j = 0; j < tmplen-1; j++) {
            	let daycount = addDays(fromDate,i)
                let tmp = { 
                	  schNo:null,
                      schDate:daycount, // 1일차, 2일차, 3일차
                      fromPlc:tmpList[j].dataset["plcNo"],
                      toPlc:tmpList[j+1].dataset["plcNo"],
                      distance:1,
                  	  duration:"1",
                      transit:transit,
                      num:j
                }
                tmpSchList.push(tmp);
             }
          tmpAllList.push(tmpSchList);
          }
           let sendData = {
        		   scheduleVO:scheduleVO,
        		   schdtVOs:tmpAllList
           }
          let sendJSON = JSON.stringify(sendData);
           $.ajax({
                url: "/place/put/sch",
                type: "POST",
                data: sendJSON,
                contentType: "application/json; charset=utf-8;",
                dataType: "text",
                success:function(data){
                	location.href = data;
                },
                error: function(data){
                	alert("error : "+data);
                }
            });  
           
        };
       
       
       function searchAction(event) {
         let placeValue = $("#search-value").val();
         if(placeValue==""){
            alert("검색어를 입력해주세요");
            return;
         }
         let placeList = $(".right-place-list");
         let currTarget = event.currentTarget;
       let pageNum;        
         if(currTarget.getAttribute("class")=="search-button"){
            pageNum = 1;
         }
         else{
            pageNum = event.currentTarget.dataset["num"];
         }
         let regionNo = document.getElementsByClassName("data-range-picker")[0].dataset["regionNo"];
         /* let pageNum = document.getElementsByClassName(); */
         
         let leftPlace = document.getElementsByClassName("selected-place");
         let index = getActiveDay();
         let leftPlaceList = document.getElementsByClassName("daily-place-list");
         let activePlaceList = leftPlaceList[index].children;
         placeList.empty();
         let i,j;
         let tmplist = [];
         
         placeService.getList({title:placeValue,
            regionNo:regionNo,
            pageNum:pageNum},
            function(map) {
                 let list = map["list"];
                 let pageMaker = map["pageMaker"];
                  let len = list.length||0;
                  let leng = activePlaceList.length;
                  
                  for (i= 0; i<len-leng; i++) {
                     for (j = 0; j < leng||0; j++) {
                           if(activePlaceList[j].dataset["title"]==list[i].plcTitle){
                              list.splice(i,1);
                        }
                     }
                  }
                  pagingWithpageMaker(pageMaker);
                  // 리뷰 template Literal 써서 자리 만들어서 채우기
                  // str ++ 하는거 같지 않은 세련된 방법이다.
                  // ` ` 백틱 문자를 사용해서 문자열이 아니라 str 그대로 들어간다.
                  for (i = 0; i < len; i++) {
                     let liobj = document.createElement("li");   
                     liobj.setAttribute('class', 'left clearfix');
                     let objs1 = document.createElement("div");
                     objs1.setAttribute('class','hoverable-place');
                     objs1.setAttribute('data-title',list[i].plcTitle);
                     objs1.setAttribute('data-region-no',list[i].regionNo);
                     objs1.setAttribute('data-address-dt',list[i].addressDt);
                     objs1.setAttribute('data-plc-no',list[i].plcNo);
                     objs1.setAttribute('data-holiday',list[i].holiday);
                     objs1.setAttribute('data-lat',list[i].lat);
                     objs1.setAttribute('data-lng',list[i].lng);
                     objs1.setAttribute('data-opening-h',list[i].openingH);
                     objs1.setAttribute('data-p-cate',list[i].pCate);
                     objs1.setAttrit
                     objs1.innerText=list[i].plcTitle + " ";
                     objs1.addEventListener('mouseover',placeOver);
                     let objs1img = document.createElement('img');
                     objs1img.setAttribute('src',list[i].plcImg);
                     objs1img.setAttribute('style','width:50px;height:60px');
                     
                     
                     let btnobj1 = document.createElement("button");
                     btnobj1.setAttribute('class', 'add-button');
                     let iconobj1 = document.createElement("i");
                     iconobj1.setAttribute('class', 'fas fa-plus');
                     btnobj1.addEventListener('click',moveToLeft);
                     btnobj1.appendChild(iconobj1);
                     
                     let btnobj2 = document.createElement("button");
                     btnobj2.setAttribute('class', 'detail-button');
                     let iconobj2 =document.createElement("i");
                     iconobj2.setAttribute('class', 'fas fa-search-plus');
                     btnobj2.addEventListener('click',placeDetail);
                     btnobj2.appendChild(iconobj2);

                     objs1.appendChild(objs1img);
                     objs1.appendChild(btnobj1);
                     objs1.appendChild(btnobj2);
                     liobj.appendChild(objs1);
                     placeList.append(liobj);
                     
                  }
               })
         return;
      }
       
      function pagingWithpageMaker(pageMaker) {
           let pagingBar = document.getElementsByClassName("right-paging-bar")[0];
           pagingBar.innerHTML = null;
           let wrapperDiv = document.createElement("div");
         let k = 1;
         let endPage = pageMaker.endPage;
         let startPage = pageMaker.startPage;
         if(pageMaker.prev) {
            let btnObj = document.createElement("button");
            btnObj.setAttribute("type", "button");
            btnObj.setAttribute("data-num", startPage-1);
            btnObj.innerText ="이전";
            btnObj.addEventListener('click',searchAction);
            pagingBar.appendChild(btnObj);
         }
         
         for (k = startPage; k <= endPage; k++) {
            let pageObj = document.createElement("div");
            pageObj.setAttribute("data-num", k);
            pageObj.innerText = k;
            pageObj.addEventListener('click',searchAction);
            wrapperDiv.appendChild(pageObj);
         }
         pagingBar.appendChild(wrapperDiv);
         if(pageMaker.next) {
            let btnObj = document.createElement("button");
            btnObj.setAttribute("type", "button");
            btnObj.setAttribute("data-num", endPage+1);
            btnObj.addEventListener('click',searchAction);
            btnObj.innerText ="다음";
            pagingBar.appendChild(btnObj);
         }
      }
      
      function deleteInLeft(event) {
         let deleteElement = event.currentTarget;
         deleteElement.parentElement.remove(); 
         }
      
      function getActiveDay(){
         let dateList = document.getElementsByClassName("daily-place-list");
         let idx, i;
         for (i = 0; i < dateList.length; i++) {
            
            if(dateList[i].style.display=="block"){
               idx = i;
            }
         }
         return idx;
      }

      function moveToLeft(event) {
         let clickedBtn = event.currentTarget;
         let index = document.getElementsByClassName("left-place-list")
         let parentE = clickedBtn.parentElement.dataset;
         let parentI = (clickedBtn.parentElement.children)[0];
         let currTarget = clickedBtn.parentElement;
         let dailyPlaceList = document.getElementsByClassName("daily-place-list");
         let idx = getActiveDay(); // idx 를 얻었다.
         let i;
         let currentList = dailyPlaceList[idx];
         let currentPlaceList = currentList.children;
         for (i = 0; len = currentPlaceList.length ,i < len; i++) {
            if(currTarget.dataset["plcNo"]==currentPlaceList[i].dataset["plcNo"]){
               return;
            }
         }
                     
                     let objs1 = document.createElement("li");
                     objs1.setAttribute('class','selected-place');
                     objs1.setAttribute('data-title',parentE['title']);
                     objs1.setAttribute('data-region-no',parentE['regionNo']);
                     objs1.setAttribute('data-address-dt',parentE['addressDt']);
                     objs1.setAttribute('data-plc-no',parentE['plcNo']);
                     objs1.setAttribute('data-holiday',parentE['holiday']);
                     objs1.setAttribute('data-lat',parentE['lat']);
                     objs1.setAttribute('data-lng',parentE['lng']);
                     objs1.setAttribute('data-opening-h',parentE['openingH']);
                     objs1.setAttribute('data-p-cate',parentE['pCate']);
                     objs1.innerText=parentE['title'];
                     objs1.append(parentI);
                  

                     let btnobj1 = document.createElement("button");
                     btnobj1.setAttribute('class', 'delete-button');
                     let iconobj1 = document.createElement("i");
                     iconobj1.setAttribute('class', 'fas fa-times');
                     btnobj1.addEventListener('click',deleteInLeft);
                     btnobj1.appendChild(iconobj1);
                     objs1.appendChild(btnobj1);
                     currentList.append(objs1);
                     
         
         if(markers.length||0){
            markers[0].setMap(null);
            markers.pop();
         }
         clickedBtn.parentElement.parentElement.remove();
         

         dnd( function() {
            dnd( ".daily-place-list" ).sortable();
            dnd( ".daily-place-list" ).disableSelection();
            } );
      }
      
      function placeDetail(event) { // 상세 정보 보기 페이지 URL + palceNo로 이루어져있다
         let clickedBtn = event.currentTarget;
         let placeNo = clickedBtn.parentElement.dataset["plcNo"];
         let URL = "https://place.map.kakao.com/"+placeNo;
         window.open(URL, "카카오 지도", "width=800, height=700, toolbar=no, menubar=no, scrollbars=no, resizable=yes" ); 
      }
      
      function placeOver(event) {
            let currTarget = event.currentTarget;
             // 지도를 재설정할 범위정보를 가지고 있을 LatLngBounds 객체를 생성합니다
             var bounds = new kakao.maps.LatLngBounds();
            
             /*  for (var i = 0; i < markers.length||0; i++) {
               //  굳이 marker배열을   쓸 필요가 없으면 필요없을거 같기도 하다.
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
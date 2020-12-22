<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../includes/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>추천여행지</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</head>
<body>
	<!-- 달력 객체와 region no를 불러왔다. 값이 제대로 넘어 왔는지 확인하는 용도 -->
<%-- 	<div class="scheduledto"
		data-sch-region='<c:out value="${schDto.schRegion }" />'
		data-to-date='<c:out value="${schDto.toDate }" />'
		data-from-date='<c:out value="${schDto.fromDate }" />'>
		<span>RegionNum=<c:out value="${schDto.schRegion }" /></span> <span>fromDate=<c:out
				value="${schDto.fromDate }" /></span> <span>toDate=<c:out
				value="${schDto.toDate }" /></span>
	</div> --%>

	<!-- image slide -->
	<div clas="wrapper">
 	<div class="slideshow-container">
	 	<!-- 비오는날 보이는 테마 -->
		<div class="mySlides" id="rainydayRec" >
				<div class='themeImage'>
					<div class="dots">
						<span class="dot" onclick="currentSlide(1)"></span> 
						<span class="dot" onclick="currentSlide(2)"></span> 
						<span class="dot" onclick="currentSlide(3)"></span> 
						<span class="dot" onclick="currentSlide(4)"></span> 
						<span class="dot" onclick="currentSlide(5)"></span> 
						<span class="dot" onclick="currentSlide(6)"></span>
					</div>
				</div>
 		<div class="travel-theme"><span>비오는날 추천하는 장소</span></div>
 		<div class="placeList">
  			<div class="text themeNo" name = "themeNo" id = '${place.themeNo}'>
				<c:forEach items="${rainydayRec}" var="place" varStatus="status">
	  					<input class="place-box" type="checkbox"
							data-plc-no="<c:out value='${place.plcNo}' />">
						<span class="placeVO-title"><c:out
							value='${place.plcTitle }' /></span>
	  			</c:forEach>
  			</div>
		</div><!-- end of placelist  -->
		</div><!-- end of myslides --> 
				
  		<c:forEach items="${themeList}" var="themeList" varStatus="status">
  		<div class="mySlides" id="theme_place_list<c:out value='${themeList.key}' />">
  		<div class='themeImage'>
		  	 <div class="dots">
				<span class="dot" onclick="currentSlide(1)"></span> 
				<span class="dot" onclick="currentSlide(2)"></span> 
				<span class="dot" onclick="currentSlide(3)"></span> 
				<span class="dot" onclick="currentSlide(4)"></span> 
				<span class="dot" onclick="currentSlide(5)"></span> 
				<span class="dot" onclick="currentSlide(6)"></span>
			 </div>
  		</div>
	    	<c:forEach items="${themeList.value}" var="place" varStatus="status">
  				<c:if test="${status.first}" >
	  				<div class="travel-theme"><span class="placeVO-title"><c:out value='${place.themeName}' /></span></div>
	  				<div class="placeList">
  				<div class="text themeNo" name = "themeNo" id = '${place.themeNo}'>
  				</c:if>
  				<input class="place-box" type="checkbox"
					data-plc-no="<c:out value='${place.plcNo}' />">
				<span class="placeVO-title"><c:out
						value='${place.plcTitle }' /></span>
  			</c:forEach>
			</div>
			</div><!-- end of placelist -->
		</div>
		</c:forEach>
  
</div><!--end of slide container  -->			

	<button class="button-btn-submit">다 골랐어요</button>
</div>
<script type="text/javascript">
var slideIndex = 1;


	function currentSlide(n) {
		showDivs(slideIndex = n);
	}
	
	function plusDivs(n) {
	  showDivs(slideIndex += n);
	}

	function currentSlide(n) {
		showDivs(slideIndex = n);
	}

	function showDivs(n) {

		const x = document.getElementsByClassName("mySlides");
	  const placeList = document.getElementsByClassName("placeList");	
	  
	  if (n > x.length) {slideIndex = 1}
	  if (n < 1) {slideIndex = x.length}
	  
	  for (let i = 0; i < x.length; i++) {
	    x[i].style.display = "none";  
	    placeList[i].style.display = "none";  
	  }
	  
		x[slideIndex-1].style.display = "block";  
		placeList[slideIndex-1].style.display = "block";
		  
	}
	
		$(document).ready(function(){
			
			showDivs(slideIndex);
			
			init();
					
			let list=[];
					
			//테마이미지 가져와서 띄워주기
			for(let i =1;i<6;i++){(function() {
							
				$.getJSON("/admin/getAttachment", {
							themeNo : $("div .themeNo")[i].id}, 
							function(image) {
								
								let str = "";
								
								if(image==null){
									str = "<img src='/resources/img/default.jpg'>";
								}else{
									const fileCallPath = encodeURIComponent(image.uuid+ "_" + image.fileName);
									str += "<img src='/admin/display?fileName="
											+ fileCallPath + "'>";
								}
								$("#theme_place_list" + (i-1)+" .themeImage").append(str);
								
							}).fail(function(result){
								const str = "<img src='/resources/img/default.jpg'>";
								//$("#theme_place_list" + i + " ul").html(str);
								$("#theme_place_list" + (i-1)+" .themeImage").append(str);
							})
						})();
				}
			
			if(true){
				
				//ajax로 보내서 rainyday rec 장소들을 json으로 가져온다 
				
				let themeNo="";
				
				if(${schDto.schRegion}==1){
					themeNo = 6				
				}else{
					themeNo = 12
					}
				
				$.getJSON("/main/getWeatherRec/"+${schDto.schRegion}, function(data){
					
						let tag="";
						
						for(let i =0; i<Object.keys(data).length; i++){
							
							tag+='<input class="place-box" type="checkbox" data-plc-no='+data[i].plcNo+'>'
							tag+='<span class="placeVO-title">'+data[i].plcTitle+'</span>'
						}
						
						$("#rainydayRec .placeList").append(tag);
						
				$.getJSON("/admin/getAttachment", {themeNo :themeNo},  function(data){
							
						if(data==null){
							let str = "<img src='/resources/img/default.jpg'>";
							$("#rainydayRec .themeImage").append(str);
							return;
						}
						
						let str = "";
						const fileCallPath = encodeURIComponent(data.uuid + "_" + data.fileName);
						str += "<img src='/admin/display?fileName="
								+ fileCallPath + "'>";
						$("#rainydayRec .themeImage").append(str);
						
					}).fail(function(result){

						const str = "<img src='/resources/img/default.jpg'>";
						$("#rainydayRec .themeImage").append(str);
					})
						
					
				}).fail(function(result){
					console.log("failed TT")
				})
				
				$(".slideshow-container").prepend();
			}
			

			function init() {
				let submitBtn = document.getElementsByClassName("button-btn-submit");
				submitBtn[0].addEventListener("click", submitPlace);
			}

			function submitPlace() {
				let placeBox = document.getElementsByClassName("place-box");
				let schDto = document.getElementsByClassName("scheduledto")[0];
	
				let list = [];
				let str = "";
				let i;
				for (i = 0; i < placeBox.length; i++) {
					if (placeBox[i].checked) {
						list.push(placeBox[i].dataset["plcNo"]);
					}
				}
	
				let objs1;
				let form = document.createElement('form');
				objs1 = document.createElement('input');
				objs1.setAttribute('type', 'hidden');
				objs1.setAttribute('name', 'places'); // 받을 네이밍
				objs1.setAttribute('value', list); // 넘길 파라메터
				form.appendChild(objs1);
	
				let objs2;
				objs2 = document.createElement('input');
				objs2.setAttribute('type', 'hidden');
				objs2.setAttribute('name', 'schRegion'); // 받을 네이밍
				objs2.setAttribute('value', schDto.dataset["schRegion"]);
				form.appendChild(objs2);
	
				let objs3;
				objs3 = document.createElement('input');
				objs3.setAttribute('type', 'hidden');
				objs3.setAttribute('name', 'fromDate'); // 받을 네이밍
				objs3.setAttribute('value', schDto.dataset["fromDate"]);
				form.appendChild(objs3);
	
				let objs4;
				objs4 = document.createElement('input');
				objs4.setAttribute('type', 'hidden');
				objs4.setAttribute('name', 'toDate'); // 받을 네이밍
				objs4.setAttribute('value', schDto.dataset["toDate"]);
				form.appendChild(objs4);
	
				form.setAttribute('method', 'post');
				form.setAttribute('action', "/place/"); // URL
	
				document.body.appendChild(form);
	
				form.submit();
		}
		
		});
	</script>
</body>

	
</html>
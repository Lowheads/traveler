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
 	<div class="scheduledto"
		data-sch-region='<c:out value="${schDto.schRegion }" />'
		data-to-date='<c:out value="${schDto.toDate }" />'
		data-from-date='<c:out value="${schDto.fromDate }" />' style="display:none">
		<span>RegionNum=<c:out value="${schDto.schRegion }" /></span>
	</div> 
        	
	<!-- image slide -->	
	<div class="slideWrapper">
 	<!-- 비오는날 보이는 테마 -->
 <!-- 	 <div class="button-btn-submit">선택완료</div>  -->
  		<div class="dots">
            <span class="dot" id = "1" onclick="currentSlide(1)"></span> 
            <span class="dot" id = "2" onclick="currentSlide(2)"></span> 
            <span class="dot" id = "3" onclick="currentSlide(3)"></span> 
            <span class="dot" id = "4" onclick="currentSlide(4)"></span> 
            <span class="dot" id = "5" onclick="currentSlide(5)"></span> 
            <span class="dot" id = "6" onclick="currentSlide(6)"></span>
            <span class="dot" id = "6" onclick="currentSlide(7)"></span>
        </div> 
	 <div class="mySlides" id="rainydayRec" >
				<div class='themeImage'>
					 	 <div class="button-btn-submit">선택완료</div> 
		<a class="prev" onclick="plusDivs(-1)">❮</a>
		<a class="next" onclick="plusDivs(1)">&#10095;</a>
				</div>
 		<div class="travel-theme"><span>우산여행</span></div>
 		<div class="placeList" id = '${place.themeNo}'>
				<c:forEach items="${rainydayRec}" var="place" varStatus="status">
						<span class="recPlace" id='${place.plcNo}' >${place.plcTitle}</span>
	  			</c:forEach>
		</div>
		</div><!-- end of myslides --> 
  		<c:forEach items="${themeList}" var="themeList" varStatus="status">
  		<div class="mySlides" id="theme_place_list<c:out value='${themeList.key}' />">
  		<div class='themeImage'>
  			 	 <div class="button-btn-submit">선택완료</div> 
		<a class="prev" onclick="plusDivs(-1)">❮</a>
		<a class="next" onclick="plusDivs(1)">&#10095;</a>
  		</div>
	    	<c:forEach items="${themeList.value}" var="place" varStatus="status">
  				<c:if test="${status.first}" >
	  				<div class="travel-theme" id = '${place.themeNo}'><span class="placeVO-title"><c:out value='${place.themeName}' /></span></div>
	  		<div class="placeList">
  				</c:if>
  				<span class="recPlace" id='${place.plcNo}'>${place.plcTitle}</span>
  			</c:forEach>
  				</div>
  				</div>
		</c:forEach>  
  </div>
  
<!--end of slide container  -->	
	
	<script type="text/javascript">
	
	let slideIndex = 1;
	
	showDivs(slideIndex);
	
	function plusDivs(n) {
		  showDivs(slideIndex += n);
		}

	function currentSlide(n) {
		showDivs(slideIndex = n);
	}
	
	function showDivs(n) {
		
	  let i;
	  let x = document.getElementsByClassName("mySlides");
	  let placeList = document.getElementsByClassName("placeList");	
	  
	  if (n > x.length) {slideIndex = 1}
	  if (n < 1) {slideIndex = x.length}
	  
	  for (i = 0; i < x.length; i++) {
	    x[i].style.display = "none";  
	    placeList[i].style.display = "none";  
	  }
	  
	  x[slideIndex-1].style.display = "block";  
	  placeList[slideIndex-1].style.display = "inline-block";
	  
	  for(let i =0;i<7;i++){
		  $(".dot[id="+i+"]").removeClass("current");
	  }
	  
	  $(".dot[id="+n+"]").addClass("current");
	  
	}	
	
	$(document).ready(function() {
		
		$("button[id='btn']").click(function(){
			console.log(selectedPlace);	
			console.log(selectedPlace.length);
			
		})
	
		
        let selectedPlace = [];


        
          $(".recPlace").each(function(){
        	 
        	}).click(function(){
        		
            var isClicked= ($(this).attr("class").includes("clicked"))
            
            var index = $(this).attr("id")

            if(isClicked){
                $("span[id="+index+"]").removeClass("clicked")
                
                var target = selectedPlace.indexOf(index);
                
                if(target!=-1){
                	
                	selectedPlace.splice(target,1);
                }

            }else{
                $("span[id="+index+"]").addClass("clicked")
                selectedPlace.push(index);
            }
            
        })

        init();
					
			var list=[];
					

			
			//테마이미지 가져와서 띄워주기
			for(let i =1;i<7;i++){(function() {
							
				$.getJSON("/admin/getAttachment", {
							themeNo : $("div .travel-theme")[i].id}, 
							function(image) {
								
								let str = "";
								if(image==null){
									str = "<img src='/resources/img/default.jpg'>";
								}else{
									let fileCallPath = encodeURIComponent(image.uuid+ "_" + image.fileName);
									str += "<img src='/admin/display?fileName="
											+ fileCallPath + "'>";
								}
								$("#theme_place_list" + (i-1)+" .themeImage").append(str);
								
							}).fail(function(result){
								let str = "<img src='/resources/img/default.jpg'>";
								//$("#theme_place_list" + i + " ul").html(str);
								$("#theme_place_list" + (i-1)+" .themeImage").append(str);
							})
						})();
				}
			
			let themeNo="";
			
			if(${schDto.schRegion}==1){
				themeNo = 6				
			}else{
				themeNo = 12
				}
			
			$.getJSON("/admin/getAttachment", {
				themeNo :themeNo}, 
				function(data){
					
					if(data==null){
						let str = "<img src='/resources/img/default.jpg'>";
						$("#rainydayRec .themeImage").append(str);
						return;
					}
					let str = "";
					let fileCallPath = encodeURIComponent(data.uuid + "_" + data.fileName);
					str += "<img src='/admin/display?fileName="
							+ fileCallPath + "'>";
					$("#rainydayRec .themeImage").append(str);
					}).fail(function(result){
						console.log("fail TT");
					console.log(result);
					let str = "<img src='/resources/img/default.jpg'>";
					
					console.log(str)
					
					$("#rainydayRec .themeImage").append(str);
				})
			
		
  			function init() {
			let submitBtn = document
					.getElementsByClassName("button-btn-submit");
			for(let i =0; i<submitBtn.length;i++){
				submitBtn[i].addEventListener("click", submitPlace);
			}
			
		}  

		function submitPlace() {
			
 			//let placeBox = document.getElementsByClassName("place-box"); 
			
 			let placeBox = $(".clicked")
 			let schDto = document.getElementsByClassName("scheduledto")[0];
			
			let str = "";
			
			let objs1;
			let form = document.createElement('form');
			objs1 = document.createElement('input');
			objs1.setAttribute('type', 'hidden');
			objs1.setAttribute('name', 'places'); // 받을 네이밍
			objs1.setAttribute('value', selectedPlace); // 넘길 파라메터
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
			form.setAttribute('action', "/place/home"); // URL

			document.body.appendChild(form);

			form.submit();
		}
		

		});
	</script>

</body>
</html>
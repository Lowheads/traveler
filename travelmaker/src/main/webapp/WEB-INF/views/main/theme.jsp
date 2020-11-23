<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../includes/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</head>
<body>
	<h1>hi my name is Theme</h1>
	
	<!-- 달력 객체와 region no를 불러왔다. 값이 제대로 넘어 왔는지 확인하는 용도 -->
	<div class="scheduledto" data-sch-region='<c:out value="${schDto.schRegion }" />' data-to-date='<c:out value="${schDto.toDate }" />' data-from-date='<c:out value="${schDto.fromDate }" />'>
		<span>RegionNum=<c:out value="${schDto.schRegion }" /></span>
		<span>fromDate=<c:out value="${schDto.fromDate }" /></span>
		<span>toDate=<c:out value="${schDto.toDate }" /></span>
	</div>
	
	<div class="place-list-theme1">
		<c:forEach items="${theme1}" var="placeList">
			<input class="place-box" type="checkbox" data-plc-no="<c:out value='${placeList.plcNo}' />">
			<span class="placeVO-title"><c:out value='${placeList.plcTitle }' /></span>
		</c:forEach>
	</div>
	
	<div class="place-list-theme2" style="display:none;">
		<c:forEach items="${theme2}" var="placeList">
			<input class="place-box" type="checkbox" data-plc-no="<c:out value='${placeList.plcNo}' />">
			<span class="placeVO-title"><c:out value='${placeList.plcTitle }' /></span>
		</c:forEach>
	</div>
	<div class="place-list-theme3" style="display:none;">
		<c:forEach items="${theme3}" var="placeList">
			<input class="place-box" type="checkbox" data-plc-no="<c:out value='${placeList.plcNo}' />">
			<span class="placeVO-title"><c:out value='${placeList.plcTitle }' /></span>
		</c:forEach>
	</div>
	<div class="place-list-theme4" style="display:none;">
		<c:forEach items="${theme4}" var="placeList">
			<input class="place-box" type="checkbox" data-plc-no="<c:out value='${placeList.plcNo}' />">
			<span class="placeVO-title"><c:out value='${placeList.plcTitle }' /></span>
		</c:forEach>
	</div>
	<div class="place-list-theme5" style="display:none;">
		<c:forEach items="${theme5}" var="placeList">
			<input class="place-box" type="checkbox" data-plc-no="<c:out value='${placeList.plcNo}' />">
			<span class="placeVO-title"><c:out value='${placeList.plcTitle }' /></span>
		</c:forEach>
	</div>
	
	<div class="place-list-theme6" style="display:none;">
		<c:forEach items="${theme6}" var="placeList">
			<input class="place-box" type="checkbox" data-plc-no="<c:out value='${placeList.plcNo}' />">
			<span class="placeVO-title"><c:out value='${placeList.plcTitle }' /></span>
		</c:forEach>
	</div>
	
	

	<button class="button-btn-submit">다 골랐어요</button>

	<script type="text/javascript">
	$(document).ready(function(){
		init();
	})
	
	function init() {
		let submitBtn =  document.getElementsByClassName("button-btn-submit");
		submitBtn[0].addEventListener("click", submitPlace);
	}	
	
	
	function submitPlace() {
		let placeBox = document.getElementsByClassName("place-box");
		let schDto = document.getElementsByClassName("scheduledto")[0];
		
		let list = [];
		let str = "";
		let i;
		for (i = 0; i < placeBox.length; i++) {
			if(placeBox[i].checked){
				list.push(placeBox[i].dataset["plcNo"]); 
		}}
		
		
        let objs1;
        let form = document.createElement('form');
        objs1 = document.createElement('input');
        objs1.setAttribute('type', 'hidden');
        objs1.setAttribute('name', 'places');      // 받을 네이밍
        objs1.setAttribute('value', list);       // 넘길 파라메터
        form.appendChild(objs1);
        
        let objs2;
        objs2 = document.createElement('input');
        objs2.setAttribute('type', 'hidden');
        objs2.setAttribute('name', 'schRegion');      // 받을 네이밍
        objs2.setAttribute('value', schDto.dataset["schRegion"]);
        form.appendChild(objs2);
        
        let objs3;
        objs3 = document.createElement('input');
        objs3.setAttribute('type', 'hidden');
        objs3.setAttribute('name', 'fromDate');      // 받을 네이밍
        objs3.setAttribute('value', schDto.dataset["fromDate"]);
        form.appendChild(objs3);
        
        let objs4;
        objs4 = document.createElement('input');
        objs4.setAttribute('type', 'hidden');
        objs4.setAttribute('name', 'toDate');      // 받을 네이밍
        objs4.setAttribute('value', schDto.dataset["toDate"]);
        form.appendChild(objs4);
        
        form.setAttribute('method', 'post');
        form.setAttribute('action', "/place/");      // URL
        
        document.body.appendChild(form);

        form.submit();
}		
	</script>
	
</body>
</html>
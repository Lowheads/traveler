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
	<!-- 달력 객체와 region no를 불러왔다. 다시 던지자. -->
	<div id="schDto" class="scheduleDto" data-sch-region='<c:out value="${schDto.schRegion }" />' data-to-date='<c:out value="${schDto.toDate }" />' data-from-date='<c:out value="${schDto.fromDate }" />'>
</div>
	<c:out value="${schDto.schRegion }" />
	
	<div class="placeListTheme1">
	<c:forEach items="${theme1}" var="placeList">
	<input class="placeBox" type="checkbox" data-plc-no="<c:out value='${placeList.plcNo}' />">
	<%-- <span class="placeVO-plcNo"><c:out value='${placeList.plcNo}' /></span> --%>
	<span class="placeVO-title"><c:out value='${placeList.plcTitle }' /></span>
	</c:forEach>
	</div>
	
	
	
	<button class="button btn-submit" onclick="submitPlace()" >버튼</button>
	<script type="text/javascript">
	
	function submitPlace() {
/* 		var v = document.getElementsByClassName("placeBox-plc-no"); */
		var vInput = document.getElementsByClassName("placeBox");
		var h = document.getElementById("schDto");
		
		var list = [];
		var str = "";
		for (let i = 0; i < vInput.length; i++) {
			if(vInput[i].checked){
				list.push(vInput[i].dataset["plcNo"]); 
		}}
		
		var form = document.createElement('form');
        var objs1;
        objs1 = document.createElement('input');
        objs1.setAttribute('type', 'hidden');
        objs1.setAttribute('name', 'places');      // 받을 네이밍
        objs1.setAttribute('value', list);       // 넘길 파라메터
        form.appendChild(objs1);
        
        var objs2;
        objs2 = document.createElement('input');
        objs2.setAttribute('type', 'hidden');
        objs2.setAttribute('name', 'schRegion');      // 받을 네이밍
        objs2.setAttribute('value', h.dataset["schRegion"]);
        form.appendChild(objs2);
        
        var objs3;
        objs3 = document.createElement('input');
        objs3.setAttribute('type', 'hidden');
        objs3.setAttribute('name', 'fromDate');      // 받을 네이밍
        objs3.setAttribute('value', h.dataset["fromDate"]);
        form.appendChild(objs3);
        
        var objs4;
        objs4 = document.createElement('input');
        objs4.setAttribute('type', 'hidden');
        objs4.setAttribute('name', 'toDate');      // 받을 네이밍
        objs4.setAttribute('value', h.dataset["toDate"]);
        form.appendChild(objs4);
        
        form.setAttribute('method', 'post');
        form.setAttribute('action', "/place/");      // URL
        
        document.body.appendChild(form);

        form.submit();
}		
	</script>
	
</body>
</html>
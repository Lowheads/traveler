<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../includes/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
	<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
	<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
	<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css" />
	<link href="/resources/css/index.css" rel="stylesheet">
	<meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
	<title>Main Index Page</title>
</head>
<body>
	<h1>Main Index Page</h1>
	<select name="region" class="select-box">
		<c:forEach items="${list }" var="region">
			<option class="option-box" data-region-no="<c:out value='${region.regionNo }' />">
				<c:out value="${region.si }" />	
			</option>
		</c:forEach>
	</select>
	<input type="text" name="daterange" class="data-range-picker" />
	<button id="goNext" onclick="submitData()">click me</button>
	
</body>	
	<script type="text/javascript">
	
	var startDate;
	var endDate;
	
	$(function(){
		
		$('input[name="daterange"]').daterangepicker({
			startDate: moment(),
			endDate: moment(),
			minDate: moment(),
			locale: {
				format: 'YYYY-MM-DD'
			},
		  }, function(start, end, label) {
		    /* console.log("A new date selection was made: " + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD')); */
		    startDate = start.format('YYYY-MM-DD');
		  	endDate = end.format('YYYY-MM-DD');
		  });
		
		initDate();
		
	});
	
	
		function initDate() {
			let datePicker = document.getElementsByClassName("data-range-picker")[0];
			let dateList = datePicker.value.split('-');
			startDate = addDays(new Date(dateList[0]),1).toISOString().split('T')[0];
			endDate = addDays(new Date(dateList[1]),1).toISOString().split('T')[0];
		}
	
		function addDays(date, days) {
		    let result = new Date(date);
		    result.setDate(result.getDate() + days);
		    return result; 
		}
	
		function submitData() {
			
			let $optionRegionNo = $(".option-box:selected").get(0).dataset["regionNo"];
			console.log($optionRegionNo);

			console.log(startDate);
			console.log(endDate);
			let form = document.createElement('form');
			
	        let objs1;
	        objs1 = document.createElement('input');
	        objs1.setAttribute('type', 'hidden');
	        objs1.setAttribute('name', 'schRegion');      // 받을 네이밍
	        objs1.setAttribute('value', $optionRegionNo);
	        form.appendChild(objs1);

	        let objs2;
	        objs2 = document.createElement('input');
	        objs2.setAttribute('type', 'hidden');
	        objs2.setAttribute('name', 'toDate');      // 받을 네이밍
	        objs2.setAttribute('value', endDate);
	        form.appendChild(objs2);
	        
	        let objs3;
	        objs3 = document.createElement('input');
	        objs3.setAttribute('type', 'hidden');
	        objs3.setAttribute('name', 'fromDate');      // 받을 네이밍
	        objs3.setAttribute('value', startDate);
	        form.appendChild(objs3);
	        
			form.setAttribute('method', 'post');
	        form.setAttribute('action', "/main/theme");      // URL
	        document.body.appendChild(form);

	      	form.submit(); 
			   
		}
	</script>
</html>
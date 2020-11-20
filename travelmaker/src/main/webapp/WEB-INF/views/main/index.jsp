<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ include file="../includes/header.jsp" %>
<link rel="stylesheet"
	href="http://code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css" />

<h1>Main Index Page</h1>
<div class="accordion-bar">
<c:forEach items="${list }" var="region">
<div id="schRegion" class="schRegion" data-region-no='<c:out value="${region.regionNo }" />' data-title='<c:out value="${region.si }" />'>
	<c:out value="${region.si }" />
	</div>
</c:forEach>
<button id="goNext" onclick="submitData()">click me</button>
</div>

	오늘 날짜 :
	<span id="today"></span>
	<form>
		<label for="fromDate">시작일</label> <input type="text" name="fromDate"
			id="fromDate"> ~ <label for="toDate">종료일</label> <input
			type="text" name="toDate" id="toDate">
	</form>
	<script>
		$(function() {
			
			//오늘 날짜를 출력
			$("#today").text(new Date().toLocaleDateString());

			//datepicker 한국어로 사용하기 위한 언어설정
			$.datepicker.setDefaults($.datepicker.regional['ko']);

			// 시작일(fromDate)은 종료일(toDate) 이후 날짜 선택 불가
			// 종료일(toDate)은 시작일(fromDate) 이전 날짜 선택 불가

			//시작일.
			$('#fromDate').datepicker({
				showOn : "both", // 달력을 표시할 타이밍 (both: focus or button)
				buttonText : "날짜선택", // 버튼의 대체 텍스트
				dateFormat : "yy-mm-dd", // 날짜의 형식
				changeMonth : true, // 월을 이동하기 위한 선택상자 표시여부
				minDate: 0,                       // 선택할수있는 최소날짜, ( 0 : 오늘 이전 날짜 선택 불가)
				onClose : function(selectedDate) {
					// 시작일(fromDate) datepicker가 닫힐때
					// 종료일(toDate)의 선택할수있는 최소 날짜(minDate)를 선택한 시작일로 지정
					$("#toDate").datepicker("option", "minDate", selectedDate);
				}
			});

			//종료일
			$('#toDate').datepicker(
					{
						showOn : "both",
						buttonText : "날짜선택",
						dateFormat : "yy-mm-dd",
						changeMonth : true,
						//minDate: 0, // 오늘 이전 날짜 선택 불가
						onClose : function(selectedDate) {
							// 종료일(toDate) datepicker가 닫힐때
							// 시작일(fromDate)의 선택할수있는 최대 날짜(maxDate)를 선택한 종료일로 지정 
							$("#fromDate").datepicker("option", "maxDate",
									selectedDate);
						}
					});
		});
		function submitData() {
			var regionNo = document.getElementById("schRegion").dataset["regionNo"];
			var fromDate = document.getElementById("fromDate").value;
			var toDate = document.getElementById("toDate").value;
			var form = document.createElement('form');
			
	        var objs1;
	        objs1 = document.createElement('input');
	        objs1.setAttribute('type', 'hidden');
	        objs1.setAttribute('name', 'schRegion');      // 받을 네이밍
	        objs1.setAttribute('value', regionNo);
	        form.appendChild(objs1);
	        
	        var objs2;
	        objs2 = document.createElement('input');
	        objs2.setAttribute('type', 'hidden');
	        objs2.setAttribute('name', 'toDate');      // 받을 네이밍
	        objs2.setAttribute('value', toDate);
	        form.appendChild(objs2);
	        
	        var objs3;
	        objs3 = document.createElement('input');
	        objs3.setAttribute('type', 'hidden');
	        objs3.setAttribute('name', 'fromDate');      // 받을 네이밍
	        objs3.setAttribute('value', fromDate);
	        form.appendChild(objs3);
	        
			form.setAttribute('method', 'post');
	        form.setAttribute('action', "/main/theme");      // URL
	        document.body.appendChild(form);

	        form.submit();
			
		}
	</script>
</body>
</html>

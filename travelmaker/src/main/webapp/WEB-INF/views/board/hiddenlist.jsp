<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<style>
/* toggle */
.switch {
	position: relative;
	display: inline-block;
	width: 60px;
	height: 34px;
}
.switch input {
	opacity: 0;
	width: 0;
	height: 0;
}
.slider {
	position: absolute;
	cursor: pointer;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	background-color: #ccc;
	-webkit-transition: .4s;
	transition: .4s;
}
.slider:before {
	position: absolute;
	content: "";
	height: 26px;
	width: 26px;
	left: 4px;
	bottom: 4px;
	background-color: white;
	-webkit-transition: .4s;
	transition: .4s;
}
input:checked+.slider {
	background-color: #2196F3;
}
input:focus+.slider {
	box-shadow: 0 0 1px #2196F3;
}
input:checked+.slider:before {
	-webkit-transform: translateX(26px);
	-ms-transform: translateX(26px);
	transform: translateX(26px);
}
/* Rounded sliders */
.slider.round {
	border-radius: 34px;
}
.slider.round:before {
	border-radius: 50%;
}

.hiddentable{
	border-collapse: separate;
  	border-spacing: 10px 10px;
  	
  	}



</style>
<div class="container">

	<div class="table-responsive">
		<table class="hiddentable">
			<thead>
				<tr>
					<th>일정번호</th>
					<th>일정명</th>
					<th>게시물제목</th>
					<th>공개여부</th>

				</tr>
			</thead>

			<c:forEach items="${hiddenlist}" var="hiddenlist">
				<tr>
					<td><c:out value="${hiddenlist.SCHNO }"/></td>
					<td><c:out value="${hiddenlist.SCHTITLE}" /></td>
					<td><c:out value="${hiddenlist.BOARDTITLE}" /></td>
					<td>
					<label class="switch"> 
					<input type="checkbox" ${hiddenlist.HIDDEN eq 'y'? "checked":"" }> <span class="slider round" data-hidden="${hiddenlist.HIDDEN }" data-schno="${hiddenlist.SCHNO }"></span>
					</label></td>
					
				</tr>
			</c:forEach>
		</table>
	</div>

</div>
<script type="text/javascript">

		
	$(".round").on("click",function(){
		
		let sendData = {
				
				"hidden" : $(this).data("hidden"),
				"schNo" : $(this).data("schno")
		};
		$.ajax({
			type : 'post',
			url : '/board/hidden',
			data : sendData,
			
			success : function(data){
			}		
			
		});
		
	});

</script>



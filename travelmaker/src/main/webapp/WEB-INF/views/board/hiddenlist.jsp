<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../includes/jeheader.jsp"%>


<div class="container">
	<div>
		<h1>공개/비공개 설정</h1>
	</div>
	<div class="table-responsive">
		<table class="table table-striped table-sm">
			<thead>
				<tr>
					<th>일정번호</th>
					<th>일정명</th>
					<th>공개여부</th>

				</tr>
			</thead>

			<c:forEach items="${hiddenlist}" var="hiddenlist">
				<tr>
					<td><c:out value="${hiddenlist.schNo }"/></td>
					<td><c:out value="${hiddenlist.schTitle}" /></td>
					<td>
					<label class="switch"> 
					<input type="checkbox" ${hiddenlist.hidden eq 'y'? "checked":"" }> <span class="slider round" data-hidden="${hiddenlist.hidden }" data-schno="${hiddenlist.schNo }"></span>
					</label></td>
					
				</tr>
			</c:forEach>
		</table>
	</div>
	<div>
		<button id="Btn" onclick="location.href='/board/list'"
			class="btn btn-sm-btn-primary">취소</button>
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



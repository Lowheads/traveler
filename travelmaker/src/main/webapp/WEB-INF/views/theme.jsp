<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="includes/adminheader.jsp"%>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>

			<h6 class="m-0 font-weight-bold text-primary">테마 관리</h6>
		</div>
<div class="card-body">
<div class="form-group row justify-content-center">

<div class="table-responsive">
	<table class="table table-hover" style="width:100%">
		<thead>
			<tr>
				<th>테마번호</th>
				<th>장소번호</th>
				<th>테마명</th>
				<th>등록일</th>
				<th>수정일</th>
			</tr>
		</thead>
			<tbody>
			<c:forEach items="${list}" var="list">
				<tr id = <c:out value="${list.THEME_NO}"/>>
					<td><c:out value="${list.THEME_NO}" /></td>
					<c:if test="${list.REGION_NO eq '1'}">
						<td>제주시</td>
					</c:if>
					<c:if test="${list.REGION_NO eq '2'}">
						<td>서귀포시</td>
					</c:if>
					<td><c:out value="${list.THEME_CODE}" /></td>
					<td><fmt:formatDate pattern="yyyy-MM-dd"
							value="${list.REG_DATE}" /></td>
					<td><fmt:formatDate pattern="yyyy-MM-dd"
							value="${list.MOD_DATE}" /></td>
				</tr>
			</c:forEach>
		</tbody> 
	</table>
</div></div></div>
<script>

$(document).ready(function() {
	
	$("table tr").click(function(){
		
		let key = $(this).attr("id");
		
		console.log(key)
		
		location.href= "/admin/themeInfo/"+key
		
	});
	
	
});


</script>

<%@ include file="includes/adminfooter.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="includes/adminheader.jsp"%>

<div class="table-responsive">


<table  class="table table-bordered" id="dataTable" style="width:70%">
<thead>
<tr>
	<th>테마번호</th>
	<th>장소번호</th>
	<th>테마명</th>
	<th>등록일</th>
	<th>수정일</th>
	<th>이미지</th>
</tr>
</thead> 	
<tbody>
<c:forEach items="${list}" var="list">
	<tr onClick = "location.href='/admin/themeInfo/<c:out value="${list.THEME_NO}"/>'">
	<td><c:out value="${list.THEME_NO}" /></td>
	<td><c:out value="${list.REGION_NO}" /></td>
	<td><c:out value="${list.THEME_CODE}" /></td>
	<td><fmt:formatDate pattern="yyyy-MM-dd" value="${list.REG_DATE}" /></td>
	<td><fmt:formatDate pattern="yyyy-MM-dd" value="${list.MOD_DATE}" /></td>
	<td><c:out value="${list.THEME_IMG}" /></td>			
	</tr>
</c:forEach>
</tbody>
</table>
</div>

<%@ include file="includes/adminfooter.jsp"%>
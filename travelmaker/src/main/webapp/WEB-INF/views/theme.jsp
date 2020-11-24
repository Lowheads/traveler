<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<%@ include file="includes/adminheader.jsp"%>
<table  class="table table-bordered" id="dataTable">
<thead>
<tr>
	<th>장소번호</th>
	<th>테마번호</th>
</tr>
</thead> 	
<tbody>
<c:forEach items="${list}" var="list">
	<tr onClick = "location.href='/admin/themeInfo/<c:out value="${list.REGION_NO}"/>/<c:out value="${list.THEME_CODE}"/>'">
	<td><c:out value="${list.REGION_NO}" /></td>
	<td><c:out value="${list.THEME_CODE}" /></td>
	</tr>
</c:forEach>
</tbody>
</table>

<%@ include file="includes/adminfooter.jsp"%>
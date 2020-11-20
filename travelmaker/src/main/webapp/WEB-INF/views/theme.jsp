<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<%@ include file="includes/adminheader.jsp"%>
<table>
<tr>
	<th>장소번호</th>
	<th>테마번호</th>
</tr>

<c:forEach items="${list}" var="list">
	<tr onClick = "location.href='/admin/themeInfo/<c:out value="${list.REGION_ID}"/>/<c:out value="${list.THEME_CODE}"/>'">
	<td><c:out value="${list.REGION_ID}" /></td>
	<td><c:out value="${list.THEME_CODE}" /></td>
	</tr>
</c:forEach>
</table>

<%@ include file="includes/adminfooter.jsp"%>
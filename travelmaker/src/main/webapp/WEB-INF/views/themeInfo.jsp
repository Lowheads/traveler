<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="includes/adminheader.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<table>
<tr>
	<th>장소</th>
</tr>

<c:forEach items="${list}" var="list">
	<tr>
	<td><c:out value="${list}" /></td>
	</tr>
</c:forEach>
</table>

<%@ include file="includes/adminfooter.jsp"%>
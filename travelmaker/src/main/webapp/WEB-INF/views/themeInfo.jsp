<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="includes/adminheader.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>



<table>
<tr>
	<th>장소번호</th>
	<th>장소명</th>
</tr>

<c:forEach items="${list}" var="list">
	<tr name = row id = '<c:out value="${list.PLC_NO}" />'>
	<td><c:out value="${list.PLC_NO}" /></td>
		<td><c:out value="${list.PLC_TITLE}" /></td>
	</tr>
</c:forEach>
</table>


<script>

$(document).ready(function() {
$("tr[name=row]").click(function(){
	
	const plcNum = $(this).attr("id");

	let URL = "https://place.map.kakao.com/"+plcNum;
	
	window.open(URL, "카카오 지도", "width=800, height=700, toolbar=no, menubar=no, scrollbars=no, resizable=yes");
	
})

})

</script>

<%@ include file="includes/adminfooter.jsp"%>
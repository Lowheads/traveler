<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="includes/adminheader.jsp"%>
<form action = 'registerAction' >
	<select name = 'theme' id='theme'>
		<option>치킨</option>
		<option>패스트푸드</option>
		<option>기타</option>
	</select>
	<input type="text" name="place" keyword="place">
	<button type="submit" id=insertBtn></button>
</form>


<%@ include file="includes/adminfooter.jsp"%>	
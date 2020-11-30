<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<!-- JQuery-->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<title>travel 입니다</title>
</head>
<body>

	<h1>Member Join Success</h1>
	<h3><%=session.getAttribute("email") %>님 환영합니다</h3>
	<h3>memNo : <%=session.getAttribute("memNo") %></h3>
	<p><a href="/member/main">홈으로</a></p>
	
</body>
</html>
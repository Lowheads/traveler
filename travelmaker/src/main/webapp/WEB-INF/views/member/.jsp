<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h1><%=session.getAttribute("email") %> 님의 개인정보 수정</h1>

	<form action="/member/logout" method="post">
		<p>${email }</p>
		


	</form>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" import="java.util.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ErrorPage</title>
</head>

<style>
.img-wrap{ /* 이미지 */
	text-align: center;
}

h3{ /* 메인 문구 */
	color: #4169E1;
	text-align: center;
}

p{ /* 내용 */
	text-align: center;
	color: #708090;
	margin: 9px;
}
</style>

<body>


	<div class="img-wrap">
		<img id="img" src="/resources/img/500error.png" style="width: 700px" height="550px"> 
	</div>
	
	
	<h3>잘못된 요청입니다.</h3>
	<p>서비스 이용에 불편을 드려 죄송합니다.</p>
	
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>

    	<!-- JQuery-->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<script>
	
	function inputCheck(){ // 입력 널 체크
		
		var email = $("#email").val();    // 이메일
		
		// 이메일을 입력 안했다면..
		if(email.length == ""){
			document.getElementById("spanEmail").innerHTML = "이메일을 입력해주세요";
			spanEmail.style.color = 'red';
	        return false;
		}
		return true;
	}
</script>

</head>
<body>


	<h2 align="center">비밀번호 찾기</h2>
	<div align="center">
		<p>이메일 주소를 입력해 주세요.</p>
			<form action="/search/sendPwd" method="post">
			
			<h1>비밀번호 찾기</h1>
			<p><input type="email" id="email" name="email"></p>
			<p><span id="spanEmail"></span></p>
			<input type="submit" onclick="return inputCheck()" value="비밀번호 찾자..">
			</form>
			<!-- 이메일이 맞으면 임시비밀번호 보냈다는 메세지 출력 -->
		<c:if test="${flag == false }"><p><script>alert('<c:out value="${msg}"/>');</script></p></c:if>
	</div>
	<p align="center">메인 페이지로 가시려면 <a href="/member/main">여기</a>를 클릭하세요.</p>
	
</body>

</html>
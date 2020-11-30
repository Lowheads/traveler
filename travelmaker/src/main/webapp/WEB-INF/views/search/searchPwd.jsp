<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
    <%@ include file="../includes/header.jsp" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>

    	<!-- JQuery-->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<script>
	
	function inputCheck(){ // 입력 널 체크
		
		let searchEmail = $("#serachEmail").val();    // 이메일
		
		// 이메일을 입력 안했다면..
		if(searchEmail.length == 0){
			alert("이메일을 입력해주세요");
	        return false;
		}
		return true;
	}
	
/* 	// 컨트롤러 msg 전달
	$(function(){
	    var responseMessage = "<c:out value='${msg}' />";
	    if(responseMessage != ""){
	        alert(responseMessage)
	    }
	})  */
	
</script>

</head>
<body>


	<h2 align="center">비밀번호 찾기</h2>
	<div align="center">
		<p>이메일 주소를 입력해 주세요.</p>
			<form action="/search/sendPwd" method="post">
			
			<p><input type="text" id="serachEmail" name="email"></p>
			<p><span id="spanEmail"></span></p>
			<input type="submit" onclick="return inputCheck()" value="메일 보내기">
			</form>

	</div>
	<p align="center">메인 페이지로 가시려면 <a href="/member/main">여기</a>를 클릭하세요.</p>
	
</body>

</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
		<%@ include file="../includes/header.jsp" %>
<html>
<head>
<title> 네이버 로그인 성공</title>

<script type="text/javascript"
	src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.2.js"
	charset="utf-8"></script>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-1.11.3.min.js"></script>

<style type="text/css">
html, div, body, h3 {
    margin: 0;
    padding: 0;
}
 
h3 {
    display: inline-block;
    padding: 0.6em;
}
</style>
<script type="text/javascript">
    $(document).ready(function() {
    	
    	let id = ${result}.response.id;
        let mail = ${result}.response.email;
        let nickName = ${result}.response.nickname;
        let gender = ${result}.response.gender;
       
        $("#mail").html("환영합니다. "+mail+"님");
        $("#nickName").html("닉네임 : " + nickName);
        $("#id").html("애플리케이션 ID : " + id);
        $("#gender").html("성별 : " + gender);
        /* $("#test").html(email); */
        
      });
</script>

</head>
<body>
	<br>
	
	<div
        style="background-color: #15a181; width: 100%; height: 50px; text-align: center; color: white;">
        <h3>SIST Naver_Login Success</h3>
    </div>
    <br><br>
	<h2 style="text-align: center" id="mail"></h2>    
    <br>
    <h4 style="text-align: center" id="nickName"></h4>
    <br>
    <h4 style="text-align: center" id="id"></h4>
    <br>
    <h4 style="text-align: center" id="gender"></h4>
    
    <p><a href="/member/main">홈으로</a></p>
    
</body>
</html>
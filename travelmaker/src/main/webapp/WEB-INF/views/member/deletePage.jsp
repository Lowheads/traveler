<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>
    

<!DOCTYPE html>
<html>
<head>
    	<!-- JQuery-->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> 

<meta charset="UTF-8">
<title>회원 탈퇴</title>

<style>
.wrap-main{
	padding: 10px;
	margin-top: 20px;
}

.center {
	text-align: center;
	padding: 4px;
}

#button {
	width: 90px;
	height: 30px;
	text-align: center;
	background-color: orange;
	color: white;
	border: 1px solid #4e266d;
	border-radius: 12px;
}
</style>

<script>
//deletePage에서 사용되는 스크립트

//탈퇴하기 누르면 비밀번호 입력여부만 체크
function inputCheck(){
	
	let pwdChk =  $("#pwd").val(); // 비밀번호
	let pwdCfm =  $("#pwdCfm").val(); // 비밀번호 확인
	
	if(pwdChk.length == 0){
		//입력 안하면
		alert("비밀번호를 입력해주세요!");
		return false;
	}
	
	if(pwdChk != pwdCfm){
		// 비밀번호가 일치하지 않으면...
		alert("비밀번호가 일치하지 않습니다.");
		return false;
	}
	
	alert("정상적으로 탈퇴되었습니다. 이용해주셔서 감사합니다!");
	return true;
}


function pwdCheck(){
	
	let pwdChk =  $("#pwd").val(); // 비밀번호
	let pwdCfm =  $("#pwdCfm").val(); // 비밀번호 확인
	
	// 비밀번호 일치여부만 확인..
	if(pwdChk != pwdCfm){
		document.getElementById("spanPwd").innerHTML = "비밀번호가 일치하지 않습니다.";
		spanPwd.style.color = 'red';
	}else if(pwdChk == pwdChm){
		document.getElementById("spanPwd").innerHTML = "비밀번호가 일치합니다!";
		spanPwd.style.color = 'blue';
	}
}

//end deletePage
</script>


</head>
<body>

	<div class="wrap-main">
	<h1 style="text-align: center;">회원 탈퇴하기 ㅠㅠ..</h1>
	
	<form action="/member/deleteMember" method="get">
	
	<div class="center">회원 이메일 : <%=session.getAttribute("email")%></div>
	<div class="center">현재 비밀번호 : <input type="password" id="pwd"  name="pwd" placeholder="현재 비밀번호"></div>
	<div class="center">비밀번호 확인 : <input type="password" id="pwdCfm" placeholder="비밀번호 확인" onblur="pwdCheck()">
	<div class="center"><span id="spanPwd"></span></div></div>
	<!-- mapper에 전달할 email은 히든으루.. -->
	<p><input type="hidden" id="email" name='email' value="<%=session.getAttribute("email")%>"></p>
		<div class="center"><button type="submit" id="button" onclick="return inputCheck()">회원탈퇴하기</button></div>	
	</form>
	</div>
	
	<p><a href="/member/main">홈으로</a></p>

</body>
</html>
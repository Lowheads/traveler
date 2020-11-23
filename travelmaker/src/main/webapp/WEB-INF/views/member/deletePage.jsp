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

	//탈퇴하기 누르면 비밀번호 입력여부만 체크
	function memberDeleteValid(){
		
		let pwdChk =  $("#deletePwd").val(); // 비밀번호
		let pwdCfm =  $("#deletePwdCfm").val(); // 비밀번호 확인
		
		if(pwdChk.length == 0){
			//입력 안하면
			alert("비밀번호를 입력해주세요");
			return false;
		}
		
		if(pwdChk != pwdCfm){
			// 비밀번호가 일치하지 않으면...
			alert("비밀번호가 일치하지 않습니다.");
			return false;
		}
		
		return true;
	}

	
	// 탈퇴 전 한번 더 묻기
	function deleteAsk() {
		if (confirm("정말 탈퇴하시겠습니까??") == true) { //확인
			document.form.submit();
		} else { //취소
			return false;
		}
	} 
	
	// 컨트롤러 msg 전달
	$(function(){
	    var responseMessage = "<c:out value='${msg}' />";
	    if(responseMessage != ""){
	        alert(responseMessage)
	    }
	}) 
	
</script>


</head>
<body>

	<div class="wrap-main">
	<h1 style="text-align: center;">회원 탈퇴하기 ㅠㅠ..</h1>
	
	<form action="/member/deleteMember" method="post" onsubmit="return deleteAsk();">
	
	
	<div class="center">회원 이메일 : <%=session.getAttribute("email")%> </div>
	<input type="hidden" name="email" value="<%=session.getAttribute("email")%>" readonly="readonly">
	<div class="center">현재 비밀번호 : <input type="password" id="deletePwd"  name="pwd" placeholder="현재 비밀번호"></div>
	<div class="center">비밀번호 확인 : <input type="password" id="deletePwdCfm" placeholder="비밀번호 확인" onblur="pwdCheck()"></div>
	<div class="center"><button type="submit" id="button" onclick="return memberDeleteValid();">탈퇴하기</button></div>
	</form>
	</div>
	
	
	<p><a href="/member/main">홈으로</a></p>

</body>
</html>
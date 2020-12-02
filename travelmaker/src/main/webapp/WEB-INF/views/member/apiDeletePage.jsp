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

.button {
	width: 120px;
	height: 40px;
	text-align: center;
	background-color: orange;
	color: white;
	border: 1px solid #4e266d;
	border-radius: 12px;
	font-size: 15px;
}
</style>

</head>

<script type="text/javascript">

// 탈퇴 인증메일 발송
$(function() {
	
	let result; // 인증번호를 담을 Global변수

	$("#sendEmailBtn").click(function() {
		
		alert("인증메일은 5초정도 소요됩니다. 잠시만 기다려주세요");
		
				let email = $("#deleteEmail").val();  // 내 이메일
				let certNum = Math.floor(Math.random()*99999999); // 메일로 보낼 인증번호 생성(local변수)
				let sendDate = {'email' : email, 'certNum' : certNum}
				
				result = certNum; // Global변수에 local변수값 저장
				
				$.ajax({
					type : 'POST',
					data : sendDate, // sendDate 함수를 contrlr에 보냄
					url : "/search/sendEmail",
					success : function(data) {
						if ($.trim(data) == 1) {
							alert("메일로 인증번호가 발송되었습니다.");
							return 
						} else {
							alert("다시 요청해주세요");
						}
	 				}
			});
		});
				
	$("#isNumcheck").click(function() {
		let input = $("#inputNum").val();
		let deleteForm = $("#deleteForm");
		
		if(input != result){
			alert("인증번호가 일치하지 않습니다.");
			return false;
		}
		deleteForm.submit();
	});
	
});
	

	// 컨트롤러 msg 전달
	$(function(){
	    var responseMessage = "<c:out value='${msg}' />";
	    if(responseMessage != ""){
	        alert(responseMessage)
	    }
	}) 
</script>
<body>

<div class="wrap-main">
	<h1 style="text-align: center;">회원 탈퇴하기 ㅠㅠ..</h1>
	<br>
	
	
	<h4 style="text-align: center;">탈퇴하시려면 현재 메일로 인증번호를 받아 일치해야 탈퇴하실 수 있습니다.</h4>
	<h4 style="text-align: center;">인증 메일을 보내실건가요?</h4>
	<br>
	
	<form id="deleteForm" action="/member/deleteApiMember" method="post">
	
	
		<div class="center" style="font-size: 25px; color:green;">회원 이메일 : <%=session.getAttribute("email")%> 
		<input type="hidden" name="email" id="deleteEmail" value="<%=session.getAttribute("email")%>" readonly="readonly">
			<button class="button" type="button" id="sendEmailBtn">인증메일 보내기</button></div>
		<div class="center">인증번호 입력 : <input type="text" id="inputNum"></div>	
			<div class="center"><button class="button" id="isNumcheck" type="button">탈퇴하기</button></div>
		
		</form>
		</div>
	
	<p><a href="/member/main">홈으로</a></p>
	

</body>
</html>
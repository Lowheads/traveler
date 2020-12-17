<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ include file="../includes/header.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 정보 조회</title>
	<!-- JQuery-->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> 

<style type="text/css">
.modal_wrap{ /* 비번 바꾸기 창*/
        display: none;
        width: 450px;
        height: 380px;
        position: absolute;
        top:50%;
        left: 30%;
        margin: -180px 0 0 400px; /* 모달 위치조절 */
        background:#eee;
        background-color:#7FFFD4;
        z-index: 2;
        border-radius: 12px;
    }
    .black_bg{
        display: none;
        position: absolute;
        content: "";
        width: 100%;
        height: 100%;
        background-color:rgba(0, 0,0, 0.5);
        top:0;
        left: 0;
        z-index: 1;
    }
    .modal_close{
        width: 26px;
        height: 26px;
        position: absolute;
        top: -30px;
        right: 0;
    }
    .modal_close> a{
        display: block;
        width: 100%;
        height: 100%;
        background:url(https://img.icons8.com/metro/26/000000/close-window.png);
        text-indent: -9999px;
    }
    
.wrap-main{
	padding: 10px;
}

.center {
	text-align: center;
	padding: 4px;
}

#button {
	width: 80px;
	height: 30px;
	text-align: center;
	background-color: orange;
	color: white;
	border: 1px solid #4e266d;
	border-radius: 12px;
}

.button {
	width: 130px;
	height: 30px;
	text-align: center;
	background-color: orange;
	color: white;
	border: 1px solid #4e266d;
	border-radius: 12px;
}

.pwd-change{
	padding: 5px;
	padding-left: 13px;
	text-align: center;
}

.pwd-pwd{ // /* 비번 바꾸기 버튼 */
	width: 130px;
	height: 30px;
	text-align: center;
	background-color: orange;
	color: white;
	border: 1px solid #4e266d;
	border-radius: 12px;
}

</style>

<script>

	//모달 기능(accountInfo)
	window.onload = function() {

		function onClick() {
			document.querySelector('.modal_wrap').style.display = 'block';
			document.querySelector('.black_bg').style.display = 'block';
		}
		function offClick() {
			document.querySelector('.modal_wrap').style.display = 'none';
			document.querySelector('.black_bg').style.display = 'none';
		}

		document.getElementById('modal_btn').addEventListener('click', onClick);
		document.querySelector('.modal_close').addEventListener('click',
				offClick);

	};

	//닉네임 변경
	$(function() {

		$("#apiInfoNicknameCheck").click(function() {

			let nickname = $("#apiInfoNickname").val();
			let sendDate = {'nickname' : nickname}
			
			let jNname = /^[ㄱ-ㅎ|가-힣|a-z|A-Z|0-9|\*]+$/; // 닉네임은 문자 제한없이 2~8자리

					// 현재 닉네임 체크
				if (nickname == "${member.nickname}") {
					document.getElementById("infoSpanNickname").innerHTML = "현재 닉네임입니다.";
					infoSpanNickname.style.color = 'green';
					return false;
				}

					// 닉네임 유효성 체크
				if (false === jNname.test(nickname)) {
					document.getElementById("infoSpanNickname").innerHTML = "닉네임은 한글/영문/숫자만!!";
					infoSpanNickname.style.color = 'red';
					return;
				}

					$.ajax({
						type : 'POST',
						data : sendDate, // sendDate 함수를 contrlr에 보냄
						url : "/member/hasNickname",
						success : function(data) {
						if ($.trim(data) == 1) {
							document.getElementById("infoSpanNickname").innerHTML = "중복된 닉네임입니다. 다른 닉네임을 선택해주세요";
							infoSpanNickname.style.color = 'red';
							return false;
						} else {
							document.getElementById("infoSpanNickname").innerHTML = "사용할 수 있는 닉네임입니다.";
							infoSpanNickname.style.color = 'blue';
						}
						}
					});
			});
	});

	function apiInfoNickSaveCheck() {

		let jNname = /^[ㄱ-ㅎ|가-힣|a-z|A-Z|0-9|\*]+$/; // 닉네임은 문자 제한없이 2~8자리
		let myNickname = $("#apiInfoNickname").val(); // 닉네임

		// 공백확인
		if (myNickname.length == 0) {
			alert("닉네임은 공백일 수 없습니다");
			return false;
		}

		// 닉네임은 2~8자리까지만
		if (!(myNickname.length >= 2 && myNickname.length <= 8)) {
			alert("닉네임을 입력해주세요 2~8글자여야 합니다!");
			$("#nickname").focus();
			return false;
		}

		// 공백 포함 X
		if (myNickname.search(/\s/) != -1) {
			alert("닉네임에는 공백이 포함될 수 없어요!");
			return false;
		}

		// 닉네임은 한글/영문/숫자만!!
		if (false === jNname.test(myNickname)) {
			alert('닉네임은 한글/영문/숫자만!!');
			$("#nickname").focus();
			return false;
		}

		// 정상 입력? 저장하자
		return true;

	} // end nickSaveCheck

	//rttr 창띄우기
	$(function() {

		var responseMessage = '<c:out value="${msg}" />';

		if (responseMessage != "") {
			alert(responseMessage);
		}

	});
</script>

</head>
<body>
	
	
		<p style="text-align: center; font-size: 30px"><%=session.getAttribute("email")%>님의 프로필</p>
	
	<div class="wrap-main">
	
		<div class="center">아이디(이메일) : ${member.email }</div> 
		
		<!-- 닉네임 저장 폼 -->
	<form action="/member/modifyNickname" method="post">
		 <div class="center">닉네임 <input type="text" id="apiInfoNickname" name="nickname" value="${member.nickname }">
		 <input type="hidden" id="email" name='email' value="<%=session.getAttribute("email")%>">
		 	<button type="button" class="btn" id="apiInfoNicknameCheck">중복 체크</button>
			<button type="submit" id="button" onclick="return apiInfoNickSaveCheck()">저장하기</button>
		 <p><span id="infoSpanNickname"></span></p></div>
	</form>
		 <!-- end 닉네임 저장 폼 -->
		
		<div class="center">생년월일 ${member.birth }</div>
	
	<div class="center">가입일 : <fmt:formatDate value="${member.regDate }" type="both" pattern="yyyy-MM-dd"/></div>
	<div class="center">최종로그인 : <fmt:formatDate value="${member.lastDate }" type="both" pattern="yyyy-MM-dd"/></div>
		
		</div>
		
	<p><a href="/member/main" class="btn">홈으로</a></p>
	
	   <!-- 회원탈퇴 (내 정보를 출력해야하므로, 폼으로 처리)-->
      <div>
         <form action="/member/apiDeletePage" method="post">
            <input type="hidden" id="modi_email" name='email' value="<%=session.getAttribute("email")%>">
            <p><button type='submit' class="btn">회원탈퇴</button></p>
            <br>
         </form> 
      </div>
	
</body>


</html>
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

	//비밀번호 입력 확인(수정)
	function infoPwdCheck() {

		let jPwd = /^(?=.*?[a-zA-Z])(?=.*?[#?!@$%^&*-]).{8,}$/; // 숫자/대문자/소문자/특수문자 1개씩은 포함해서 8자리
		let realPwd = $("#realPwd").val(); // 현재 비밀번호
		let realPwdCfm = $("#realPwdCfm").val(); // 현재 비밀번호 히든 값
		let myPwd = $("#infoPwd").val(); // 비밀번호
		let myPwdCfmm = $("#infoPwdCfm").val(); // 비밀번호 확인

		// 현재 패스워드 입력
		if (realPwd.length == 0) {
			alert("현재 비밀번호를 입력해 주세요");
			$("#realPwd").focus();
			return false;
		}

		// 현재 비밀번호 확인
		if (realPwd != realPwdCfm) {
			alert("현재 비밀번호와 일치하지 않아요");
			$("#realPwd").focus();
			return false;
		}

		// 패스워드 입력
		if (myPwd.length == 0) {
			alert("비밀번호를 입력해 주세요");
			$("#pwd").focus();
			return false;
		}

		// 숫자/대문자/소문자/특수문자 1개씩은 포함해서 8자리
		if (false === jPwd.test(myPwd)) {
			alert('비밀번호는 8자리 이상이며, 영문/숫자/특수문자를 포함해야합니다.');
			return false;
		}

		// 패스워드 확인
		if (myPwd != myPwdCfmm) {
			alert("비밀번호가 서로 다릅니다. 비밀번호를 확인해 주세요.");
			return false;
		}

		// 비밀번호는 공백없이!!
		if (myPwd.search(/\s/) != -1) {
			alert('비밀번호는 공백없이!!');
			return false;
		}

		// 비밀번호 변경이 성공적이면 변경한다.
		alert("비밀번호를 변경하였습니다");
		return true;

	} // end infoPwdCheck

	//닉네임 변경
	$(function() {

		$("#infoNicknameCheck").click(function() {

					let nickname = $("#infoNickname").val();
					let sendDate = {'nickname' : nickname}
					
					let jNname = /^[ㄱ-ㅎ|가-힣|a-z|A-Z|0-9|\*]+$/;; // 닉네임은 문자 제한없이 2~8자리

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

	function infoNickSaveCheck() {

		let jNname = /^[ㄱ-ㅎ|가-힣|a-z|A-Z|0-9|\*]+$/; // 닉네임은 문자 제한없이 2~8자리
		let myNickname = $("#infoNickname").val(); // 닉네임

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
		 <div class="center">닉네임 <input type="text" id="infoNickname" name="nickname" value="${member.nickname }">
		 <input type="hidden" id="email" name='email' value="<%=session.getAttribute("email")%>">
		 	<button type="button" class="btn" id="infoNicknameCheck">중복 체크</button>
			<button type="submit" id="button" onclick="return infoNickSaveCheck()">저장하기</button>
		 <p><span id="infoSpanNickname"></span></p></div>
	</form>
		 <!-- end 닉네임 저장 폼 -->
		
		<div class="center">생년월일 ${member.birth }</div>
		
		<div class="center">비밀번호 : <input type="hidden" id="realPwdCfm" value="${member.pwd }">
		<button type='button' id="modal_btn" class="button">비밀번호 변경</button></div>
	
		<!-- 비밀번호 변경 모달 -->
	<div class="modal_wrap">
		<div class="modal_close"><a href="#">close</a></div>
	<div>
			<!-- 비밀번호 -->
		<form action="/member/modifyPwd" method="post">
			<div class="pwd-change"><h4 style="font-weight: bold;">비밀번호 변경하기</h4></div>
			<div class="pwd-change"><input class="pwd-change" type="password" name="realPwd" id="realPwd" placeholder="현재 비밀번호">
			<p>현재 비밀번호를 입력해주세요!</p></div>
			<div class="pwd-change"><input class="pwd-change" type="password" name="pwd" id="infoPwd" placeholder="변경할 비밀번호">
			<p>비밀번호는 숫자/영문자/특수문자를 모두 포함해야 합니다</p></div>
			<!-- 비밀번호 확인 -->
			<div class="pwd-change"><input class="pwd-change" type="password" name="pwdCfmm" id="infoPwdCfm" placeholder="비밀번호 확인">
			<p>비밀번호는 숫자/영문자/특수문자를 모두 포함해야 합니다</p></div>
			<p><input type="hidden" id="email" name='email' value="<%=session.getAttribute("email")%>"></p>
			<div class="center"><button type="submit" class="pwd-pwd" onclick="return infoPwdCheck();">비밀번호 변경하기</button></div>
			
			</form>
		</div>
	</div>

	<div class="center">가입일 : <fmt:formatDate value="${member.regDate }" type="both" pattern="yyyy-MM-dd"/></div>
	<div class="center">최종로그인 : <fmt:formatDate value="${member.lastDate }" type="both" pattern="yyyy-MM-dd"/></div>
		
		</div>
		
	<p><a href="/member/main" class="btn">홈으로</a></p>
	
	   <!-- 회원탈퇴 (내 정보를 출력해야하므로, 폼으로 처리)-->
      <div>
         <form action="/member/deletePage" method="post">
            <input type="hidden" id="modi_email" name='email' value="<%=session.getAttribute("email")%>">
            <p><button type='submit' class="btn">회원탈퇴</button></p>
            <br>
         </form> 
      </div>
	
</body>


</html>
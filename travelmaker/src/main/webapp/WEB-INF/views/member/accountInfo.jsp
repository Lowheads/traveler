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
.modal_wrap{
        display: none;
        width: 250px;
        height: 180px;
        position: absolute;
        top:50%;
        left: 30%;
        margin: -180px 0 0 480px; /* 모달 위치조절 */
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
    document.querySelector('.modal_wrap').style.display ='block';
    document.querySelector('.black_bg').style.display ='block';
}   
function offClick() {
    document.querySelector('.modal_wrap').style.display ='none';
    document.querySelector('.black_bg').style.display ='none';
}

document.getElementById('modal_btn').addEventListener('click', onClick);
document.querySelector('.modal_close').addEventListener('click', offClick);

};

//AccountInfo에서 사용되는 스크립트

// 닉네임 중복체크
$(function(){
	$(".nicknameCheck").click(function(){
		
		let nickname = $("#nickname").val();
		let sendDate = {'nickname' : nickname}
		
 	if(nickname == "${member.nickname}"){
			document.getElementById("spanNickname").innerHTML = "현재 닉네임입니다.";
			spanNickname.style.color ='green';
			return;
		}
		
		 $.ajax({
			type : 'POST',
			data : sendDate, // sendDate 함수를 contrlr에 보냄
			url : "/member/nicknameDuplCheck",
			success : function(data){
				if(data > 0){ 
					document.getElementById("spanNickname").innerHTML = "중복된 닉네임입니다. 다른 닉네임을 선택해주세요";
					spanNickname.style.color ='red';
					return false;
				}else{
					document.getElementById("spanNickname").innerHTML = "사용할 수 있는 닉네임입니다.";
					spanNickname.style.color = 'blue';
				} 
			}
		}); 
	});
});

//비밀번호 입력 확인
function pwdCheck(){

	let jPwd = /^(?=.*?[a-zA-Z])(?=.*?[#?!@$%^&*-]).{8,}$/; // 숫자/대문자/소문자/특수문자 1개씩은 포함해서 8자리
	let mdPwd = $("#pwd").val(); 	   // 비밀번호1
	let mdpwdCfm = $("#pwdCfm").val(); 	   // 비밀번호2

	 // 패스워드 입력
	if(mdPwd.length == 0){
	    alert("비밀번호를 입력해 주세요"); 
	    $("#pwd").focus();
	    return false;
	}

	 // 숫자/대문자/소문자/특수문자 1개씩은 포함해서 8자리
	if(false === jPwd.test(mdPwd) || mPwd.search(/\s/) != -1) {
	    alert('비밀번호는 8자리 이상이며, 영문/숫자/특수문자를 포함해야합니다. 공백없이!!');
	    return false;
	}
	
	// 패스워드 확인1	
	if(mdPwd != mdpwdCfm){
	    alert("비밀번호가 서로 다릅니다. 비밀번호를 확인해 주세요."); 
	    $("#pwdCfm").focus();
	    return false; 
	}

	// 비밀번호 변경이 성공적이면 변경한다.
	alert("비밀번호를 성공적으로 변경하였습니다.");
	return true;

} // end pwdCheck

function saveName() {
	alser("${msg }");
}

</script>

</head>
<body>
	
	
	<p style="text-align: center; font-size: 30px"><%=session.getAttribute("email")%>님의 프로필</p>
	
	<div class="wrap-main">
	
		<div class="center">아이디(이메일) : ${member.email }</div> 
		
		<!-- 닉네임 저장 폼 -->
	<form action="/member/nNameModify" method="post">
		 <div class="center">닉네임 <input type="text" id="nickname" name="nickname" value="${member.nickname }">
		 <input type="hidden" id="email" name='email' value="<%=session.getAttribute("email")%>">
		 <button type="button" class="nicknameCheck" id="button">중복 체크</button>
		 <button type="submit" id="button">저장하기</button>
		 <p><span id="spanNickname"></span></p></div>
	</form>
		 <!-- end 닉네임 저장 폼 -->
		
		<div class="center">생년월일 ${member.birth }</div>
		
		<div class="center">비밀번호 : ${member.pwd }
		<button type='button' id="modal_btn" class="button">비밀번호 변경</button></div>
	
		<!-- 비밀번호 변경 모달 -->
	<div class="modal_wrap">
		<div class="modal_close"><a href="#">close</a></div>
	<div>
			<!-- 비밀번호 -->
		<form action="/member/pwdModify" method="post">

			<div class="pwd-change"><input class="pwd-change" type="password" name="pwd" id="pwd" placeholder="비밀번호"></div>
			<!-- 비밀번호 확인 -->
			<div class="pwd-change"><input class="pwd-change" type="password" name="pwdCfm" id="pwdCfm" placeholder="비밀번호 확인"></div>
			<p><input type="hidden" id="email" name='email' value="<%=session.getAttribute("email")%>"></p>
			<div class="center"><button type="submit" class="pwd-pwd" onclick="return pwdCheck();">비밀번호 변경하기</button></div>
			
			</form>
		</div>
	</div>

	<div class="center">가입일 : <fmt:formatDate value="${member.regDate }" type="both" pattern="yyyy-MM-dd"/></div>
	<div class="center">최종로그인 : <fmt:formatDate value="${member.lastDate }" type="both" pattern="yyyy-MM-dd"/></div>
		
		</div>
		
	<p><a href="/member/main">홈으로</a></p>
	     <!-- 회원탈퇴 (내 정보를 출력해야하므로, 폼으로 처리)-->
      <div>
         <form action="/member/deletePage" method="get">
            <input type="hidden" id="modi_email" name='email' value="<%=session.getAttribute("email")%>">
            <p><button type='submit'>회원탈퇴</button></p>
            <br>
         </form> 
      </div>
	
	
	<!-- 입력이 틀린경우 출력할 메세지들... -->
<c:if test="${flag == false }"><p><script>alert('<c:out value="${msg}"/>');</script></p>	</c:if>
	<c:if test="${msg == false }">닉네임이 중복됩니다.</c:if>

</body>


</html>
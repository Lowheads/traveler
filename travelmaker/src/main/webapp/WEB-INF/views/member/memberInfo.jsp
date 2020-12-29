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

<link rel="stylesheet" href="/resources/css/member/memberInfo.css">

</head>
<body>

<!-- 전체 div -->
<div class="container-info">
	<!-- 정보 div -->
	<div class="info-wrap">	
		<!-- 내정보 div -->
		<div class="info-head">내 정보</div>

			<%-- <p style="text-align: center; font-size: 30px"><%=session.getAttribute("email")%>님의 프로필</p> --%>
		
			<!-- 정보 출력 div  -->
			<div class="main-wrap">
				<!-- 이메일 -->
				<div class="info-content">
					<div class="content-name">이메일</div>
					<div class="content-proper">${member.email }</div> 
				</div>
			
			<!-- 닉네임 중복체크 -->
			 <div class="info-content">
			 	<div class="content-name">닉네임</div>
				<div class="content-proper">
				 <form id="saveForm" action="/member/modifyNickname" method="post">
				 	<input type="text" id="infoNickname" name="nickname" value="${member.nickname }">	
				 	<input type="hidden" id="email" name='email' value="<%=session.getAttribute("email")%>">
				 	<button type="button" class="dupl-btn" id="infoNicknameCheck">중복 체크</button>
				 	<div style="margin-top: 3%; text-align: left;"><span id="infoSpanNickname"></span></div>
				 </form>
			 	</div>
			 	<!-- end proper -->
			 </div>
			 <!-- end 닉네임 중복체크 -->
			
			<!-- 성별 -->
			<div class="info-content">
				<div class="content-name">성별</div>
				<div class="content-proper">${member.gender }</div> 
			</div>
			
			<!-- 생년월일 -->
			<div class="info-content"> 
				<div class="content-name">생일</div>
				<div class="content-proper">${member.birth }</div> 
			</div>
			
			<!-- 비밀번호 -->
			<div class="info-content">
				<div class="content-name">비밀번호</div>
				<button class="pwd-modiBtn" type='button' id="modal_btn" class="button">비밀번호 재설정</button></div>
		
			<!-- 비밀번호 변경 모달 -->
		<div class="pwdModify_modal">
			<div class="pwModal_close"><a class="pwdModi-aTag" href="#">X</a></div>
		<div>
				<!-- 비밀번호 -->
				<form action="/member/modifyPwd" method="post">
			
				<p style="text-align: center; font-size: 20px; margin-top: 10%; margin-bottom : 10%; font-weight: bold;">비밀번호 변경</p>
				
				<div class="pwd-change-wrap">
				<div class="mod-pwd-div" style="width: 130px; font-weight: bold; padding-top: 1%">현재 비밀번호</div> 
				<input class="pwd-change" type="password" name="inputPwd" id="inputPwd" placeholder="현재 비밀번호"></div>
					<p style="color: dodgerblue; margin-bottom: 5%; margin-top: 1%;">현재 비밀번호를 입력해주세요!</p>
				
				<!-- 새로운 비번 -->					
				<div class="pwd-change-wrap">
				<div class="mod-pwd-div" style="width: 130px; font-weight: bold; padding-top: 1%">새로운 비밀번호</div> 
				<input class="pwd-change" type="password" name="newPwd" id="infoPwd" placeholder="변경할 비밀번호"></div>
					<p style="color: dodgerblue; margin-bottom: 5%; margin-top: 1%;">비밀번호는 숫자/영문자/특수문자를 모두 포함해야 합니다</p>

				<!-- 비밀번호 확인 -->
				<div class="pwd-change-wrap">
				<div class="mod-pwd-div" style="width: 130px; font-weight: bold; padding-top: 1%">새로운 비밀번호 확인</div> 
				<input class="pwd-change" type="password" name="pwdCfmm" id="infoPwdCfm" placeholder="비밀번호 확인"></div>
					<p style="color: dodgerblue; margin-bottom: 5%; margin-top: 1%;">비밀번호는 숫자/영문자/특수문자를 모두 포함해야 합니다</p>
					<p><input type="hidden" id="email" name='email' value="<%=session.getAttribute("email")%>"></p>
				<div class="pwd-change-confirm-btn">
					<button type="submit" class="pwd-pwd" onclick="return infoPwdCheck();">비밀번호 변경하기</button>
				</div>
				
				</form>
			</div>
		</div>
		<!-- end 변경모달 -->
		
		
		<!-- 회원탈퇴 모달 -->
		<div class="member_delete_modal">
			<div class="mdModal_close"><a class="pwdModi-aTag" href="#">X</a></div>
		<div>

			<form action="/member/deleteMember" method="post" onsubmit="return deleteAsk();">
			
				<p style="text-align: center; font-size: 20px; margin-top: 10%; 
				margin-bottom : 10%; font-weight: bold;">여행의정석 회원 탈퇴 확인</p>
				
				<div class="delete_announce">
					<p>회원탈퇴하시면 즉시 해지처리 되며,</p>
					<p style="margin-bottom: 50px">해당 아이디로는 재 가입하실 수 없습니다.</p>
				</div>
				
				<div class="delete-wrap">
					<div class="del-div">회원 이메일 &nbsp;&nbsp;&nbsp; : &nbsp;</div>
					<input style="border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px"
					value="<%=session.getAttribute("email")%>">  
						<input type="hidden" name="email" value="<%=session.getAttribute("email")%>" readonly="readonly">
				</div>
				
				<div class="delete-wrap">				
					<div class="del-div">현재 비밀번호 : &nbsp;</div>
					<input type="password" id="deletePwd"  name="pwd" placeholder="현재 비밀번호">
				</div>
				
				<div class="delete-wrap">
					<div class="del-div">비밀번호 확인 : &nbsp;</div>
					<input type="password" id="deletePwdCfm" placeholder="비밀번호 확인">
				</div>
				
				<div class="delete_confirm_btn">
					<button type="submit" id="delete_confirm" onclick="return memberDeleteValid();">탈퇴하기</button>
				</div>
				
				</form>
			</div>
		</div>
		<!-- end 탈퇴모달 -->
		
	
		<div class="info-content">
			<div class="content-name">가입일</div>
			<div class="content-proper"><fmt:formatDate value="${member.regDate }" type="both" pattern="yyyy-MM-dd"/></div> 
		</div>
		
		<div class="info-content">
			<div class="content-name">최종로그인</div>
			<div class="content-proper"><fmt:formatDate value="${member.lastDate }" type="both" pattern="yyyy-MM-dd"/></div>
		</div>
	</div>
	<!-- end main-wrap-->
			
			<div class="info-foot">
				<!-- 탈퇴 버튼 -->
		            <button class="delete-btn" id="deleteBtn" type='button'>회원탈퇴</button>
	        	 <!-- 탈퇴 버튼 끝 -->
	        	 
	        	
	        	 <!-- 저장하기 버튼 -->
					<button type="submit" class="save-btn" onclick="return infoNickSaveCheck()">저장하기</button>
	        	 <!-- 저장하기 버튼 끝 -->
	        	 
	        	  <!-- 취소 버튼 -->
					<!-- <button type="button" class="back-btn" onclick="history.back()'">홈으로</button> -->
	        	  <!-- 취소 버튼 끝 -->
	        	 
			</div>
			<!-- end foot -->
			
		</div>
		<!-- end info-wrap -->
	</div>
<!-- end container-info -->
		
</body>

<script>

	//모달 기능
	window.onload = function() {
		
		// 비밀번호 변경
		document.getElementById('modal_btn').addEventListener('click', onClick);
		document.querySelector('.pwModal_close').addEventListener('click', offClick);
		
		// 회원 탈퇴
		document.getElementById('deleteBtn').addEventListener('click', deleteOnClick);
		document.querySelector('.mdModal_close').addEventListener('click', deleteOffClick);
		
		// 모달 오픈
		function onClick() {
			document.querySelector('.pwdModify_modal').style.display = 'block';
			document.querySelector('.black_bg').style.display = 'block';
		}
		// 모달 오픈
		function deleteOnClick() {
			document.querySelector('.member_delete_modal').style.display = 'block';
			document.querySelector('.black_bg').style.display = 'block';
		}
		
		// 모달 닫기
		function offClick() {
			document.querySelector('.pwdModify_modal').style.display = 'none';
			document.querySelector('.black_bg').style.display = 'none';
		}
		// 모달 닫기
		function deleteOffClick() {
			document.querySelector('.member_delete_modal').style.display = 'none';
			document.querySelector('.black_bg').style.display = 'none';
		}
		
	};

	//비밀번호 입력 확인(수정)
	function infoPwdCheck() {

		let jPwd = /^(?=.*?[a-zA-Z])(?=.*?[#?!@$%^&*-]).{8,}$/; // 숫자/대문자/소문자/특수문자 1개씩은 포함해서 8자리
		let inputPwd = $("#inputPwd").val() // 현재 비밀번호 입력 태그
		/* let realPwdCfm = $("#realPwdCfm").val(); // 현재 비밀번호 히든 값  */
		let myPwd = $("#infoPwd").val(); // 비밀번호
		let myPwdCfmm = $("#infoPwdCfm").val(); // 비밀번호 확인

		 // 현재 패스워드 입력
		if (inputPwd.length == 0) {
			alert("현재 비밀번호를 입력해 주세요");
			$("#inputPwd").focus();
			return false;
		}

		// 패스워드 입력
		if (myPwd.length == 0) {
			alert("비밀번호를 입력해 주세요");
			$("#infoPwd").focus();
			return false;
		}

		// 숫자/대문자/소문자/특수문자 1개씩은 포함해서 8자리
		if (false === jPwd.test(myPwd) || myPwd.length > 12) {
			alert('비밀번호는 8자리 ~ 12자리이며, \n영문/숫자/특수문자를 포함해야합니다.');
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
								document.getElementById("infoSpanNickname").innerHTML = "중복된 닉네임입니다.";
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
		$("#saveForm").submit();

	} // end nickSaveCheck
	
	
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
		if (confirm("정말 탈퇴하시겠습니까?") == true) { //확인
			document.form.submit();
		} else { //취소
			return false;
		}
	} 
</script>

</html>


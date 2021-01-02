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
	
	 <div class="black_bg_social"></div>
	
<!-- 전체 div -->
<div class="container-info">
	<!-- 정보 div -->
	<div class="info-wrap">	
		<!-- 내정보 div -->
		<div class="info-head">내 정보</div>
	
	<!-- 정보 출력 div  -->
	<div class="api-main-wrap">
	
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
						<input type="text" id="apiInfoNickname" name="nickname" value="${member.nickname }">
						<input type="hidden" id="email" name='email' value="<%=session.getAttribute("email")%>">
						<button type="button" class="dupl-btn" id="apiInfoNicknameCheck">중복 체크</button>
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
		
			<!-- 회원여행성향 -->
			<div class="info-content"> 
				<div class="content-name">여행성향</div>
				
				<c:choose>
				    <c:when test="${member.travelType == null}">
				   		<div class="content-proper">테스트 해주세요!</div> 
				    </c:when>
				    <c:when test="${member.travelType != null}">
						<div class="content-proper">${member.travelType }</div> 
				    </c:when>
				</c:choose>
			</div>
		
		<div class="info-content">
				<div class="content-name">가입일</div>
				<div class="content-proper"><fmt:formatDate value="${member.regDate }" type="both" pattern="yyyy-MM-dd"/></div> 
			</div>
			
			<div class="info-content">
				<div class="content-name">최종로그인</div>
				<div class="content-proper"><fmt:formatDate value="${member.lastDate }" type="both" pattern="yyyy-MM-dd"/></div>
			</div>
		</div>
			<!-- end api-main-wrap-->
			
		
		<!-- 회원탈퇴 모달 -->
		<div class="apiMember_delete_modal">
			<div class="amdModal_close"><a class="pwdModi-aTag" href="#">X</a></div>
		<div>

			<form id="apiDeleteForm" action="/member/deleteApiMember" method="post">
			
				<p style="text-align: center; font-size: 20px; margin-top: 10%; 
				margin-bottom : 10%; font-weight: bold;">여행의정석 회원 탈퇴 확인</p>
				
				<div class="delete_announce">
					<p>탈퇴하시려면 현재 메일로 인증번호를 받아</p>
					<p> 일치해야 탈퇴하실 수 있습니다.</p>
					<p>회원탈퇴하시면 즉시 해지처리 되며,</p>
					<p style="margin-bottom: 50px">해당 아이디로는 재 가입하실 수 없습니다.</p>
				</div>
				
				<div class="delete-wrap-api">
					<div class="del-div" style="font-weight: bold; margin-left: 8%;">
					회원 이메일 &nbsp; : &nbsp;</div>
					<input style="border:none;border-right:0px; border-top:0px; boder-left:0px; boder-bottom:0px"
						id="deleteEmail" name="email" value="<%=session.getAttribute("email")%>">  
					<button class="button" type="button" id="sendEmailBtn">인증메일 보내기</button>
				</div>
				
				<div class="delete-wrap">				
					<div class="del-div">인증번호 입력 : &nbsp;</div>
					<input type="text" id="inputNum">
				</div>
				
				<div class="delete_confirm_btn">
					<button type="button" id="delete_confirm">탈퇴하기</button>
				</div>
				
				</form>
			</div>
		</div>
		<!-- end 탈퇴모달 -->
		
      
      <div class="apiInfo-foot">
		<!-- 탈퇴 버튼 -->
		    <button class="delete-btn" id="apiDeleteBtn" type='button'>회원탈퇴</button>
	    <!-- 탈퇴 버튼 끝 -->
	        	 
	    <!-- 저장하기 버튼 -->
		<button type="submit" class="save-btn" onclick="return apiInfoNickSaveCheck()">저장하기</button>
	     <!-- 저장하기 버튼 끝 -->
	     
	      <!-- 홈으로 -->
	      <button type="button" class="home_btn" onclick="location.href='/main/index'">홈으로</button>
	      <!-- 홈으로 버튼 끝 -->
	
       	</div>     
      </div>
	<!-- end info-wrap -->
	</div>
<!-- end container-info -->
	
</body>

<script>

	//모달 기능
	window.onload = function() {
		
		// 회원 탈퇴
		document.getElementById('apiDeleteBtn').addEventListener('click', apiDeleteOnClick);
		document.querySelector('.amdModal_close').addEventListener('click', apiDeleteOffClick);
		
		// 모달 오픈
		function apiDeleteOnClick() {
			document.querySelector('.apiMember_delete_modal').style.display = 'block';
			document.querySelector('.black_bg_social').style.display = 'block';
		}
		
		// 모달 닫기
		function apiDeleteOffClick() {
			document.querySelector('.apiMember_delete_modal').style.display = 'none';
			document.querySelector('.black_bg_social').style.display = 'none';
		}
		
	}; // end Modal
		

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

	function apiInfoNickSaveCheck() {

		let jNname = /^[ㄱ-ㅎ|가-힣|a-z|A-Z|0-9|\*]+$/; // 닉네임은 문자 제한없이 2~8자리
		let myNickname = $("#apiInfoNickname").val(); // 닉네임

		// 공백확인
		if (myNickname.length == 0) {
			swal("", "닉네임을 입력해주세요.", "warning");
			return false;
		}

		// 닉네임은 2~8자리까지만
		if (!(myNickname.length >= 2 && myNickname.length <= 8)) {
			swal("", "닉네임을 입력해주세요 2~8글자여야 합니다.", "warning");
			$("#nickname").focus();
			return false;
		}

		// 공백 포함 X
		if (myNickname.search(/\s/) != -1) {
			swal("", "닉네임에는 공백이 포함될 수 없습니다.", "warning");
			return false;
		}

		// 닉네임은 한글/영문/숫자만!!
		if (false === jNname.test(myNickname)) {
			swal("", "닉네임은 한글/영문/숫자만 입력가능합니다.", "warning");
			$("#nickname").focus();
			return false;
		}

		// 정상 입력? 저장하자!
		$("#saveForm").submit();
				
	} // end nickSaveCheck
	

	// 탈퇴 인증메일 발송
	$(function() {
		
		let result; // 인증번호를 담을 Global변수

		$("#sendEmailBtn").click(function() {
			
			swal("", "인증메일 발송은 5초정도 소요됩니다.", "warning");

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
								swal("", "메일로 인증번호가 발송되었습니다.", "success");
								return 
							} else {
								swal("", "다시 요청해주세요", "error");
							}
		 				}
				});
			});
					
		$("#delete_confirm").click(function() {
			let input = $("#inputNum").val();
			let deleteForm = $("#apiDeleteForm");
			
			if(input != result){
				swal("", "인증번호가 일치하지 않습니다.", "warning");
				return false;
			}
			deleteForm.submit();
		});
		
}); // end 탈퇴 인증메일

</script>

</html>

<%@ include file="../includes/footer.jsp" %>
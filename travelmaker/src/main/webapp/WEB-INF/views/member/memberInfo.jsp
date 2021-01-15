<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="biggestwrapper">
<%@ include file="../includes/header.jsp" %>
<!-- URL 직접접근 막기 -->
<link href="/resources/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<!DOCTYPE html>
<html>
<head>
<style>
.biggestwrapper{
 	  background-image: url("/resources/img/road.jpg"); 
	  background-size: cover;
	   height:100%;
}

.body{
	width:100%;
	height:100%;
}
.header__nav__button-account {
	background-color:white;
}
.header__nav__button-greyHover {
	color:white;
	font-family:'Nanum Gothic', sans-serif;
	font-size:19px;
    background: transparent;
    transition: box-shadow 0.2s ease;
    text-shadow: 2px 2px #222;
}
.header__nav__button-greyHover:hover {
	background: none;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 1);
}

</style>

<meta charset="UTF-8">
<title>내 정보 조회</title>
	<!-- JQuery-->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> 

<link rel="stylesheet" href="/resources/css/member/memberInfo.css">

</head>
<body>
<%
	String strReferer = request.getHeader("referer");
	
		if (strReferer == null) {
		%>
		<script>
			history.go(-1);
		</script>
		<%
			return;
		}
%>

<!-- 전체 div -->
<div class="info-wrapper">
	<!-- 정보 div -->
	<div class="info-container">	
	
		<div class="info-header">
		<h3>내 정보 수정하기</h3>
		<div class="button-wrapper">
					<!-- 저장하기 버튼 -->
					<button type="submit" class="member-save-btn" onclick="return infoNickSaveCheck()">저장하기</button>

	        	 <!-- 저장하기 버튼 끝 -->
	        	 
	        	 <!-- 홈으로 -->
	        	 <button type="button" class="home_btn" onclick="location.href='/main/index'">홈으로</button>
	        	 <!-- 홈으로 버튼 끝 -->
		</div>
		</div>

			<!-- 정보 출력 div  -->
			<div class="info-body">
			
				<!-- 이메일 -->
				<div class="info-content">
					<div class="content-name">이메일</div>
					<div class="content-proper">${member.email }</div> 
				</div>
			
			<!-- 닉네임 중복체크 -->
			 <div class="info-content">
			 	<div class="content-name">닉네임</div>
				<div class="content-proper">
				 <form id="saveForm" action="/member/saveMember" method="post">
				 	<input type="text" id="infoNickname" name="nickname" value="${member.nickname }">	
				 	<input type="hidden" id="email" name='email' value="<%=session.getAttribute("email")%>">
				 	<button type="button" class="dupl-btn" id="infoNicknameCheck">중복 체크</button>
				 	<div style="margin-top: 3%; text-align: left;"><span id="infoSpanNickname"></span></div>
				 </form>
				 <span>닉네임은 한글,영문,숫자 <br> 두자리 이상 8자리 이하만 가능합니다 </span>
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
		
			
		
		<!-- 회원여행성향 -->
			<div class="info-content"> 
				<div class="content-name">여행성향</div>
				
				<c:choose>
				    <c:when test="${member.travelType == null}">
                           <div class="content-proper" style = "font-size:10px">테스트 결과가 없습니다<br>메인 페이지에서 테스트를 해주세요</div> 				    
				    </c:when>
				    <c:when test="${member.travelType != null}">
						<div class="content-proper">${member.travelType }</div> 
				    </c:when>
				</c:choose>
			</div>
			
			<!-- 현재 가진 point -->
			<div class="info-content"> 
				<div class="content-name"">POINT</div>
				<div class="content-proper" style="margin-top: 1%;" >
					<fmt:formatNumber value="${member.point }" pattern="#,###" /> POINT</div> 
					<button style="margin-left: 3%;" id="check_module" type="button">POINT 충전</button>
			</div>
			
		
		<div class="info-content">
			<div class="content-name">가입일</div>
			<div class="content-proper"><fmt:formatDate value="${member.regDate }" type="both" pattern="yyyy-MM-dd"/></div> 
		</div>
		
		<div class="info-content">
			<div class="content-name">최종로그인</div>
			<div class="content-proper"><fmt:formatDate value="${member.lastDate }" type="both" pattern="yyyy-MM-dd"/></div>
		</div>
		
						<!-- 탈퇴 버튼 -->
						<span class="delete-btn" id="deleteBtn">여행의 정석 계정을 삭제하고 싶으신가요? </span>
		          <!--   <button class="delete-btn" id="deleteBtn" type='button'>회원탈퇴</button> -->
	        	 <!-- 탈퇴 버튼 끝 -->

	</div>
	<!-- end main-wrap-->

		</div>
		<!-- end container-info -->
	</div>
	<!-- end info-wrap -->


<!-- 비밀번호 변경 모달 -->
		<div class="pwdModify_modal modal">
			<div class="Modal_close"><a class="pwdModi-aTag" href="#"><i class="fas fa-times"></i></a></div>
		<div>
				<!-- 비밀번호 -->
				<form class="modifyPwd" action="/member/modifyPwd" method="post">
				
				<h4>비밀번호 변경</h4>
				<div class="container">
				<div class="pwd-wrapper">
				<div class="title">현재 비밀번호</div> 
				<div class="input-wrapper">
					<input class="pwd-change" type="password" name="inputPwd" id="inputPwd" >
					<p>현재 비밀번호를 입력해주세요</p>
				</div>
				</div>
				
				<!-- 새로운 비번 -->					
				<div class="pwd-wrapper">
				<div class="title">새로운 비밀번호</div> 
				<div class="input-wrapper">
				<input class="pwd-change" type="password" name="newPwd" id="infoPwd" >
					<p>비밀번호는 8자리 이상, 12자리 이하의 <br>숫자/영문자/특수문자를 모두 포함해야 합니다</p></div>
					</div>

				<!-- 비밀번호 확인 -->
				<div class="pwd-wrapper">
				<div class="title">새로운 비밀번호 확인</div> 
				<div class="input-wrapper">
				<input class="pwd-change" type="password" name="pwdCfmm" id="infoPwdCfm" >
					<p>다시 한 번 입력해주세요</p></div>
					<p><input type="hidden" id="email" name='email' value="<%=session.getAttribute("email")%>"></p>
					</div>
					
				<div class="modalFooter">
					<button type="submit" class="pwd-pwd confirmBtn" onclick="return infoPwdCheck();">변경하기</button>
				</div>
				</div>
				
				</form>
				
			</div>
		</div>
		<!-- end 변경모달 -->
		
<!-- 회원탈퇴 모달 -->
		<div class="member_delete_modal modal">
			<!-- <div class="mdModal_close"><a class="pwdModi-aTag" href="#"><i class="fas fa-times"></i></a></div> -->
			<div class="Modal_close"><a class="pwdModi-aTag" href="#"><i class="fas fa-times"></i></a></div>
		<div>

			<form action="/member/deleteMember" class="withdraw" method="post" onsubmit="return deleteAsk();">
			
				<h4>여행의정석 회원 탈퇴</h4>
				
				<div class="deleteContainer">
				
				<div class="delete_announce">
					<p>하단의 버튼을 누르면 즉시 탈퇴처리되며,<br>같은 아이디로는 재가입이 불가능합니다</p>
				</div>
				
				<div class="delete-wrap">
					<div class="title">회원 이메일</div>
					<span> <%=session.getAttribute("email")%></span>
						<input type="hidden" name="email" value="<%=session.getAttribute("email")%>" readonly="readonly">
				</div>
				
				<div class="delete-wrap">				
					<div class="title">현재 비밀번호</div>
					<input type="password" id="deletePwd"  name="pwd" placeholder="현재 비밀번호">
				</div>
				
				<div class="delete-wrap">
					<div class="title">비밀번호 확인</div>
					<input type="password" id="deletePwdCfm" placeholder="비밀번호 확인">
				</div>
				
				</div>
				
				<div class="modalFooter">
					
					<button type="submit" id="delete_confirm" class="confirmBtn" onclick="return memberDeleteValid();">탈퇴하기</button>
				</div>
				
				</form>
			</div>
		</div>
		<!-- end 탈퇴모달 -->
		
</body>

<script>

	//모달 기능
	window.onload = function() {
		
		// 비밀번호 변경
		document.getElementById('modal_btn').addEventListener('click', onClick);
		
		let closeBtn = $(".Modal_close");
		closeBtn[0].addEventListener('click', offClick);
		closeBtn[1].addEventListener('click', offClick);
		
		// 회원 탈퇴
		document.getElementById('deleteBtn').addEventListener('click', deleteOnClick);
		// 모달 오픈
		function onClick() {
			document.querySelector('.pwdModify_modal').style.display = 'block';
			document.querySelector('.black_bg').style.display = 'block';
			
		}
		// 모달 오픈
		function deleteOnClick() {
			document.querySelector('.member_delete_modal').style.display = 'block';
			document.querySelector('.black_bg').style.display = 'block';
			 $('body').css("overflow", "hidden");
		}
		
		// 모달 닫기
		function offClick() {
			document.querySelector('.pwdModify_modal').style.display = 'none';
			document.querySelector('.member_delete_modal').style.display = 'none';
			document.querySelector('.black_bg').style.display = 'none';
			$('body').css("overflow", "scroll");
		}
		
		
	};

	//비밀번호 입력 확인(수정)
	function infoPwdCheck() {

		let jPwd = /^(?=.*?[a-zA-Z])(?=.*?[#?!@$%^&*-]).{8,}$/; // 숫자/대문자/소문자/특수문자 1개씩은 포함해서 8자리
		let inputPwd = $("#inputPwd").val() // 현재 비밀번호 입력 태그
		let myPwd = $("#infoPwd").val(); // 비밀번호
		let myPwdCfmm = $("#infoPwdCfm").val(); // 비밀번호 확인

		 // 현재 패스워드 입력
		if (inputPwd.length == 0) {
			swal("", "현재 비밀번호를 입력해 주세요.", "warning");
			$("#inputPwd").focus();
			return false;
		}

		// 패스워드 입력
		if (myPwd.length == 0) {
			swal("", "비밀번호를 입력해 주세요.", "warning");
			$("#infoPwd").focus();
			return false;
		}

		// 숫자/대문자/소문자/특수문자 1개씩은 포함해서 8자리
		if (false === jPwd.test(myPwd) || myPwd.length > 12) {
			swal("", "비밀번호는 8자리 ~ 12자리이며, \n영문/숫자/특수문자를 포함해야합니다.", "warning");
			return false;
		}

		// 패스워드 확인
		if (myPwd != myPwdCfmm) {
			swal("", "비밀번호가 서로 다릅니다. 비밀번호를 확인해 주세요.", "warning");
			return false;
		}

		// 비밀번호는 공백없이!!
		if (myPwd.search(/\s/) != -1) {
			swal("", "비밀번호에는 공백이 포함될 수 없습니다.", "warning");
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
			swal("", "닉네임은 한글/영문/숫자만 입력가능합니다", "warning");
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
			swal("", "비밀번호를 입력해주세요.", "warning");
			return false;
		}
		
		if(pwdChk != pwdCfm){
			swal("", "비밀번호가 일치하지 않습니다.", "warning");
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
 	

	// 결제
	$("#check_module").click(function() {
		var IMP = window.IMP; 
		IMP.init('imp32870043');
		let point = 20000; // 우린 2만원 충전가능해요!
		let msg;
		
		IMP.request_pay({
			pg : 'kakao', 
			merchant_uid : 'merchant_' + new Date().getTime(),
			name : '주문명 : 결제테스트',
			amount : point,
			buyer_email : "${member.email}",
			buyer_name : "${member.nickname}",
			buyer_postcode : '123-456',
		}, function(rsp) {
			console.log(rsp);
			if (rsp.success) {
				msg = '결제가 완료되었습니다.';
				msg += '\n고유ID : ' + rsp.imp_uid;
				msg += '\n상점 거래ID : ' + rsp.merchant_uid;
				msg += '\n결제 금액 : ' + rsp.paid_amount;
				msg += '\n카드 승인번호 : ' + rsp.apply_num;
			       $.ajax({
	                    type: "GET", 
	                    url: "/member/pointCharging", 
	                    data: {
	                        "point" : point,
	                        "email" : "${member.email}"
	                    },
	                });
			} else {
				msg = '결제에 실패하였습니다.';
				msg += '에러내용 : ' + rsp.error_msg;
			}
			alert(msg);
			document.location.href="/member/getMember?email=" + "${member.email}";
		});
	});

</script>

</html>
</div>
<%@ include file="../includes/footer.jsp" %>


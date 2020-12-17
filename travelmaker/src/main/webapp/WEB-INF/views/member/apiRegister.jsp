<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ include file="../includes/header.jsp" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>네이버유저 회원가입</title>

<style type="text/css">

/*datepicker에서 사용한 이미지 버튼 style적용*/
img.ui-datepicker-trigger {
	margin-left: 5px;
	vertical-align: middle;
	cursor: pointer;
}

.reg-font{
	font-weight: bold;
	font-size: 15px;
	padding-left: 10px;
}

.div-reg{
   padding: 8px;
   padding-top: 2px;
}

.btn{
   width: 130px;
   height: 35px;
   text-align: center;
   background-color: orange;
   color: white;
   border: 1px solid #4e266d;
}

#button { /*로그인 버튼*/
   width: 260px;
   height: 50px;
   text-align: center;
   background-color: orange;
   color: white;
   border: 1px solid #4e266d;
}

.apiLogin-wrap{
	margin-left: 30%;
	margin-top: 10%;
}

</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		
		let email = "${email}";
	    let nickname = "${nickname}";
		let gender = "${gender}";
		let randomPwd = Math.floor(Math.random()*99999999);
	    
	    document.getElementById('apiEmail').value = email 		// 네이버 이메일 
	    document.getElementById('apiNickname').value = nickname	// 네이버 닉네임
	    document.getElementById('apiPwd').value = randomPwd	// 임시 비밀번호
	       
		if(gender == 'M' || gender == 'male'){
			$("input:radio[name='gender']:radio[value='M']").prop('checked', true);
		}else{
			$("input:radio[name='gender']:radio[value='F']").prop('checked', true);
		}
	
	});
	
	function snsValidCheck() {
	    
	     // 정규식
	     let jNname = /^[ㄱ-ㅎ|가-힣|a-z|A-Z|0-9|\*]+$/; // 닉네임은 문자 제한없이 2~8자리

	    // 스크립트 태그 변수
	    let myNickname = $("#apiNickname").val(); // 닉네임
	    let myBirth = $("#apiBirth").val();    // 생년월일
	    
	    // 닉네임 입력
	    if(myNickname.length == 0){
	       alert("닉네임을 입력해주세요");
	       $("#nickname").focus();
	       return false;
	    }
	    
	    // 닉네임은 2~8자리까지만
	    if(!(myNickname.length >= 2 && myNickname.length <= 8)){
		   	alert("닉네임을 입력해주세요 2~8글자여야 합니다!");
		   	$("#nickname").focus();
		   	return false;
	   }
	    
	    // 닉네임은 영문/한글/숫자만!!
	    if(false === jNname.test(myNickname)){
	       alert("닉네임은 영문/한글/숫자만 허용됩니다!!");
	       $("#nickname").focus();
	       return false;
	    }
	    
	     // 생년월일 입력
	    if(myBirth.length == 0){
	       alert("생년월일을 입력해주세요");
	       $("#naverBirth").focus();
	       return false;
	    }
	    
	    // 필수입력 완료했으니까 회원가입 성공!
	        return true;
	    
	 } // end snsValidCheck()
	 
	 
	// 닉네임 중복체크 버튼 누르면 실행
	$(function() {
	    $("#apiNicknameCheck").click(function() { 
	        
	       let myNickname = $("#apiNickname").val();     // 닉네임
	       let jNname = /^[ㄱ-ㅎ|가-힣|a-z|A-Z|0-9|\*]+$/; // 닉네임은 문자 제한없이 2~8자리

	         // 닉네임 입력
	          if(myNickname.length == 0){
	             document.getElementById("apiSpanNickname").innerHTML = "닉네임을 입력해주세요";
	             apiSpanNickname.style.color='red';
	          	return;
	       }else{
	          document.getElementById("apiSpanNickname").innerHTML = "";
	       }
	       
	       // 닉네임은 2~8자리
	       if(!(2 < myNickname.length && myNickname.length <= 8)){
	    	   document.getElementById("apiSpanNickname").innerHTML = "닉네임은 2~8자로 입력해주세요";
	    	   apiSpanNickname.style.color = 'red';
	    	   return;
	       }else{
	    	   document.getElementById("apiSpanNickname").innerHTML = "";
	       }
	       
	        
	        // 닉네임 정규식
	         if(false === jNname.test(myNickname)) {     
	            document.getElementById("apiSpanNickname").innerHTML = "닉네임은 한글/영문/숫자로 2~8자리 부탁드립니다";
	            apiSpanNickname.style.color='red';
	             return;  
	         }else{
	             document.getElementById("apiSpanNickname").innerHTML = "사용할 수 있는 닉네임입니다.";
	          }       
	        
	        
	       let nickname = $("#apiNickname").val();
	       let sendDate = {'nickname' : nickname}

	       $.ajax({
	          /* async : true, */
	          type : 'POST',
	          data : sendDate,
	          url : "/member/hasNickname",
	           success : function(data) { // 성공하면 여기로 넘어옴
	              if (data > 0) {
	                document.getElementById("apiSpanNickname").innerHTML = "닉네임이 중복됩니다.";
	                apiSpanNickname.style.color = 'red';
	             } else {
	                document.getElementById("apiSpanNickname").innerHTML = "사용할 수 있는 닉네임입니다.";
	                apiSpanNickname.style.color = 'blue';
	             }
	           }
	       });
	 });
});



	 $(function() {
			$("#apiBirth").datepicker(
					{
						changeMonth : true,
						changeYear : true,
						maxDate : 0, // 오늘 날짜이후로 선택 못 함
						minDate : '-80y', // 년 시작일
						nextText : '다음 달',
						prevText : '이전 달',
						yearRange : 'c-80:c+20', // 년 시작~최대 범위
						showButtonPanel : true,
						currentText : '오늘 날짜',
						closeText : '닫기',
						dateFormat : "yy-mm-dd",
						showAnim : "slide",
						showMonthAfterYear : true,
						dayNamesMin : [ '월', '화', '수', '목', '금', '토', '일' ],
						monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월',
								'7월', '8월', '9월', '10월', '11월', '12월' ]
					
					});
			
		});
	 
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

			<h1 style="text-align: center; font-size: 30px"> 간편 회원가입</h1>
			<div class="apiLogin-wrap"> <!-- 가운데 정렬 -->
			
			<form action="/member/joinMember" method="post">
			
					<!-- 이메일 -->
                  <div class="reg-font">이메일</div>
                  <div class="div-reg"><input type="email" name="email" id="apiEmail" readonly="readonly">
                  <span id="spanEmail"></span></div>
                  
                  <!-- 비밀번호(히든으로 넘어감..) -->
                  <input type="hidden" name="pwd" id="apiPwd" value=" ">
                  
                  <!-- 닉네임 -->
                  <div class="reg-font">닉네임</div>
                  <div class="div-reg"><input type="text" name="nickname" id="apiNickname">
                     <button class="btn" type="button" id="apiNicknameCheck">중복 체크</button>
                     닉네임은 2~8내로 입력해주세요
                  <div class="div-reg"><span id="apiSpanNickname"></span></div></div>
                  
                  <!-- 생년월일 -->
                  <div class="reg-font">생일</div>
                  <div class="div-reg"><input type="text" name="birth" id="apiBirth" placeholder="내 생년월일! Click me!"></div>
                  
                  <!-- 성별 -->
                  <div class="reg-font">성별</div>
                     <input type="radio" name="gender" id="api_man_gender" value="M" readonly="readonly">남 
                     <input type="radio" name="gender" id="api_woman_gender" value="F" readonly="readonly">여
                   <p><span id="spanGender"></span></p>
                  
                  <!-- 상태(정상, 휴면 등...) -->
                  <p><input type="hidden" name="status" id="status" value="MS001"></p>
                  
                  <!-- 등급 : 네이버회원..) -->
                  <p><input type="hidden" name="memGrade" id="mem_grade" value="MG003"><p>
                  
         			</div>
         			
             <div class="wrap-Addition">
               <button style="font-size: 20px" type="submit" id="button" onclick="return snsValidCheck();">가입하기</button></div>
            </form>
            
</body>
</html>
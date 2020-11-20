 /*
function inputCheck() {
	 
	 // 정규식
	 var jEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i; // 이메일
	 var jPwd = /^(?=.*?[a-zA-Z])(?=.*?[#?!@$%^&*-]).{8,}$/; // 숫자/대문자/소문자/특수문자 1개씩은 포함해서 8자리
	 var jNname = /^[\w\Wㄱ-ㅎㅏ-ㅣ가-힣]{2,8}$/; // 닉네임은 문자 제한없이 2~8자리
	 var jBirth = /^(19[0-9][0-9]|20\d{2})(0[0-9]|1[0-2])(0[1-9]|[1-2][0-9]|3[0-1])$/;  // 19990101

	// 스크립트 태그 변수
   var mEmail = $("#email").val();    // 이메일
   var mPwd = $("#pwd").val(); 	   // 비밀번호
   var mNname = $("#nickName").val(); // 닉네임
   var mBirth = $("#birth").val();    // 생년월일
   
   // 이메일 입력
   if(mEmail.length == 0){
		alert("이메일 입력 후, 중복체크를 눌러주세요");
       $("#email").focus();
       return false;
   }
   
   // 이메일 정규식
    if(false === jEmail.test(mEmail)) {     
		    alert('이메일 형식이 잘못되었습니다.');
         return false;         
    }                            
   
    // 패스워드 입력
	if(mPwd.length == 0){
       alert("비밀번호를 입력해 주세요"); 
       $("#pwd").focus();
       return false;
   }

   // 닉네임 입력
   if(mNname.length == 0){
   	alert("닉네임을 입력해주세요");
   	$("#nickName").focus();
   	return false;
   }
   
   if(false === jNname.test(mNname)){
   	alert("닉네임은 2~8내로 입력해주세요");
   	$("#nickName").focus();
   	return false;
   }
   
    // 생년월일 입력
   if(mBirth.length == 0){
   	alert("생년월일을 입력해주세요");
   	$("#birth").focus();
   	return false;
   }
   
   // 생년월일 정규식
    if(false === jBirth.test(mBirth)){
   	alert("생년월일은 총 8자입니다.");
       $("#birth").focus();
   	return false;
   }
   
   // 성별 선택
   if($("input[name=gender]:radio:checked").length < 1){
   	alert("성별을 선택해주세요.");
   	return false;
   }
   
   // 필수입력 완료했으니까 회원가입 성공!
       alert("회원가입을 축하합니다");
       return true;
   
} // end inputCheck()

//	비밀번호 커서 처리
function pwdCheck() {

	var jPwd = /^(?=.*?[a-zA-Z])(?=.*?[#?!@$%^&*-]).{8,}$/; // 숫자/대문자/소문자/특수문자 1개씩은 포함해서 8자리
	
   var mPwd = $("#pwd").val(); 	   // 비밀번호
   var mPwdCfm = $("#pwdCfm").val();    // 비밀번호 확인
   
   // 숫자/대문자/소문자/특수문자 1개씩은 포함해서 8자리
	if(false === jPwd.test(mPwd)) {
		document.getElementById("spanPwdCfm").innerHTML = "비밀번호는 8자리 이상이며, 영문/숫자/특수문자를 포함해야합니다.";
  		spanPwdCfm.style.color='red';		   
  		return false;
	}else{
		document.getElementById("spanPwdCfm").innerHTML = "";
	}
}

// 비밀번호 비교
function comparisonPwd() {
	
	var mPwd = $("#pwd").val(); 	   // 비밀번호
   var mPwdCfm = $("#pwdCfm").val();    // 비밀번호 확인
   
// 패스워드 확인
	if (mPwd != mPwdCfm) {
		document.getElementById("spanPwdCfm").innerHTML = "비밀번호가 서로 다릅니다.";
  		spanPwdCfm.style.color='red';
  		return false;
	}else{
		document.getElementById("spanPwdCfm").innerHTML = "";
	}
	
}

<!--로그인 체크-->
function loginCheck(){

var logEmail = $("#login_email").val();    // 이메일
var logPwd = $("#login_pwd").val(); 	   // 비밀번호

// 이메일 입력(로그인)
if(logEmail.length == 0){
   alert("이메일을 입력해주세요");
   $("#login_email").focus();
   return false;
}

// 비밀번호 입력(로그인)
if(logPwd.length == 0){
   alert("비밀번호를 입력해주세요");
   $("#login_pwd").focus();
   return false;
}

} // end loginCheck
*/
 	
 	//이메일 체크여부 확인 (아이디 중복일 경우 = 0 , 중복이 아닐경우 = 1 )
		$(function() {
			
			$(".emailCheck").click(function() { // email 중복체크 버튼 누르면 실행
				
		 		var mEmail = $("#email").val();    // 이메일
var jEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i; // 이메일정규식
 	
		 		 // 이메일 입력
			   	if(mEmail.length == 0){
			   		document.getElementById("spanEmail").innerHTML = "이메일을 입력해주세요";
			   		spanEmail.style.color='red';
				   return;
				}else{
					document.getElementById("spanEmail").innerHTML = "";
				}
		 		
			    // 이메일 정규식
			     if(false === jEmail.test(mEmail)) {     
			    	 document.getElementById("spanEmail").innerHTML = "이메일 형식이 잘못되었습니다";
				   		spanEmail.style.color='red';
				   		
					   return;  
			     }else{
						document.getElementById("spanEmail").innerHTML = "사용할 수 있는 이메일입니다.";
					}       
				 
				var email = $("#email").val();
				var sendDate = {'email' : email}
	
				$.ajax({
					/* async : true, */
					type : 'POST',
					data : sendDate,
					url : "/member/emailCheck",
				 	success : function(data) { // 성공하면 여기로 넘어옴
						 if (data > 0) {
							document.getElementById("spanEmail").innerHTML = "이메일이 중복됩니다.";
							spanEmail.style.color = 'red';
						} else {
							document.getElementById("spanEmail").innerHTML = "사용할 수 있는 이메일입니다.";
							spanEmail.style.color = 'blue';
						}
				 	}
				});  
			});
		}); // end nickName Dupl
		
// AccountInfo에서 사용되는 스크립트


	// 닉네임 중복체크
	$(function(){
		$(".nickNameCheck").click(function(){
			
			var nickName = $("#nickName").val();
			var sendDate = {'nickName' : nickName}
			
			if(nickName == "${member.nickName}"){
				document.getElementById("spanNickName").innerHTML = "현재 닉네임입니다.";
				spanNickName.style.color ='green';
				return;
			}
			
			 $.ajax({
				type : 'POST',
				data : sendDate, // sendDate 함수를 contrlr에 보냄
				url : "/member/nNameCheck",
				success : function(data){
					if(data > 0){ // 자신의 닉네임이 1이니까 1이상이면 중복
						document.getElementById("spanNickName").innerHTML = "중복된 닉네임입니다. 다른 닉네임을 선택해주세요";
						spanNickName.style.color ='red';
						return false;
					}else{
						document.getElementById("spanNickName").innerHTML = "사용할 수 있는 닉네임입니다.";
						spanNickName.style.color = 'blue';
					} 
				}
			});  
		});
	});

/*
// 비밀번호 입력 확인
function pwdCheck(){
	
	var jPwd = /^(?=.*?[a-zA-Z])(?=.*?[#?!@$%^&*-]).{8,}$/; // 숫자/대문자/소문자/특수문자 1개씩은 포함해서 8자리
	var mdPwd1 = $("#pwd").val(); 	   // 비밀번호1
	var mdPwd2 = $("#pwd2").val(); 	   // 비밀번호2
	
	 // 패스워드 입력
	if(mdPwd1.length == 0){
        alert("비밀번호를 입력해 주세요"); 
        $("#pwd").focus();
        return false;
    }
	
	 // 숫자/대문자/소문자/특수문자 1개씩은 포함해서 8자리
	if(false === jPwd.test(mdPwd1)) {
	    alert('비밀번호는 8자 이상이어야 하며, 숫자/영문자/특수문자를 모두 포함해야 합니다.');
	    return false;
	}
 
    // 패스워드 확인
    if(mdPwd1 != mdPwd2){
        alert("비밀번호가 서로 다릅니다. 비밀번호를 확인해 주세요."); 
        $("#pwd2").focus();
        return false; 
    }
    
    // 비밀번호 변경이 성공적이면 변경한다.
    alert("비밀번호를 성공적으로 변경하였습니다.");
    return true;
    
} // end pwdCheck

	// 모달 기능(accountInfo)
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

// end AccountInfo
		
// deletePage에서 사용되는 스크립트

// 탈퇴하기 누르면 비밀번호 입력여부만 체크
function inputCheck(){
	
	var pwdChk =  $("#pwd").val(); // 비밀번호
	var pwdCfm =  $("#pwdCfm").val(); // 비밀번호 확인
	
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
	
	var pwdChk =  $("#pwd").val(); // 비밀번호
	var pwdCfm =  $("#pwdCfm").val(); // 비밀번호 확인
	
	// 비밀번호 일치여부만 확인..
	if(pwdChk != pwdCfm){
		document.getElementById("spanPwd").innerHTML = "비밀번호가 일치하지 않습니다.";
		spanPwd.style.color = 'red';
	}else if(pwdChk == pwdChm){
		document.getElementById("spanPwd").innerHTML = "비밀번호가 일치합니다!";
		spanPwd.style.color = 'blue';
	}
}

// end deletePage
		
// header 내 정보 로그인 체크

	function infoCheck(){
	
		var session = sessionStorage.getItem('email');

		if(session == null){
			alert("로그인부터 해주세요!");
			return false;
		}
		return true;
	
	}

	function clickLogout(){
		
		
	}
	*/
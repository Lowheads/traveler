<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ include file="../includes/header.jsp" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>카카오유저 회원가입</title>

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


</script>

</head>

<body>

  <!-- 세션에서 token을 가져와서 출력한다. -->
  
  <h1>제발</h1>


    <div
        style="background-color: #15a181; width: 100%; height: 50px; text-align: center; color: white;">
    </div>
    <br>
    
    	<p id="email">${email }</p>
    	<p id="name">${name }</p>
    	<p id="gender">${gender }</p>
    	
    
    <p><a href="/member/main">홈으로</a></p>
    

</body>
</html>
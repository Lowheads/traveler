<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
   
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ include file="../includes/header.jsp" %>

 <!-- 쿠키 -->


<h1 style="text-align: center; color: deeppink;">Travel HomePage</h1>
         
      
      <a href="/member/success">로그인여부확인</a><br>
      
      <!-- 로그인 체크해서 안 됐다면 로그인창.. -->
      <a href="/member/testPage" onclick="return sessionCheck();">로그인 하고 들오세요</a> 
   

</body>

</html>

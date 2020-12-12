<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ include file="../includes/header.jsp" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시물 등록</title>
    <link rel="stylesheet" href="/resources/css/common.css">
    <link rel="stylesheet" href="/resources/css/register.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.1/css/all.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    
<!-- 제이쿼리 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>


<%	String secret = ""; // 비밀글 여부를 위한 변수 선언  %>

<script type="text/javascript">

// 비밀글 판단 여부
$(document).ready(function(){
	
	$("#secret").change(function(){
        if($("#secret").is(":checked")){
        	// 비밀 체크했으면 checked!
			<% secret = "checked"; %>
        }else{
        	//아니면 null
            <% secret = ""; %>
        }
    });
});
    
    // 게시물 체크
	function boardValid(){
    	
    	let title = $("#title").val();
    	let content = $("#content").val();

    	if(title.length == 0){
    		alert("제목은 빈칸일 수 없습니다");
    		return false;
    	}
    	
    	if(content.length == 0){
    		alert("내용을 작성해주세요");
    		return false;
    	}
    	alert("게시물이 등록되었습니다");
    	return true;
    } 
    
    
    
</script>
    
    
</head>
<body>
    <div class="wrapper">
        <div class="header_wrapper">
            <div class="header">
                <div class="logo">
                    <a href="/qnaboard/list">Q&A 게시판</a>
                </div>      
            </div>
        </div>
        <div class="contents">
            <div class="ct_head">
                <h2>게시글 작성</h2>
            </div>
            <div class="ct_body">
            
            	 <form action="/qnaboard/register" method="post">
            	 
            	 			<div class="form-secret" style="padding : 5px;">
                        		<input type="checkbox" id="secret"  name="secret" <%=secret %>> 비밀글
                        		 <img src="/resources/img/lock.svg" style="height: 15px" width="15px">
                        	</div>
            	 			
                        	<div class="form-group">
                        		<label>제목</label> 
                        		<input class="form-control" name="title" id="title">
                        	</div>
                        	
                        	<div class="form-group">
                        		<label>내용</label>
                        		<textarea class="form-control" rows="3" name='content' id="content"></textarea>
                        	</div>
                        	
                        	<div class="form-group">
                        		<label>작성자</label>
                        		<input class="form-control" name='nickname' id="nickname" value="${nickname }" readonly="readonly">
		                	</div>
		                	
		                		<input type="hidden" name="memNo" id="memNo" value="${memNo }">
                			
                	<button type="submit" class="btn" onclick="return boardValid()">등록하기</button>
                	<button type="button" class="btn" onclick="javascript:history.back(-1)">취소</button>
            	</form>
            </div>
			<!-- ct_body -->
        </div>
		<!-- contents -->
    </div>
    

</body>
</html>
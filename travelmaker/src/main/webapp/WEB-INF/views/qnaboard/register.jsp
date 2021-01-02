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
    <link rel="stylesheet" href="/resources/css/qnaboard/common.css">
    <link rel="stylesheet" href="/resources/css/qnaboard/register.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.1/css/all.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    
<!-- 제이쿼리 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>


<%	String secretCheck = ""; // 비밀글 on/off  %>

<script type="text/javascript">

// 비밀글 판단 여부
$(document).ready(function(){
	
	$("#secret").change(function(){
        if($("#secret").is(":checked")){
        	// 비밀 체크했으면 checked!
			<% secretCheck = "checked"; %>
        }else{
        	//아니면 null
            <% secretCheck = ""; %>
        }
    });
});
    
    // 게시물 체크
	function boardValid(){
    	
    	let title = $("#title").val();
    	let content = $("#content").val();
    	
    	if(title.length == 0){
			swal( "" , "제목이 빈칸일 수는 없습니다" , "warning" );
    		return false;
    	}
    	
    	if(title.length > 30){
			swal( "" , "제목은 30자리까지 가능합니다." , "warning" );
    		return false;
    	}
    	
    	if(content.length == 0){
			swal( "" , "내용을 작성해주세요." , "warning" );
    		return false;
    	}
    	
    	if(content.length > 1000){
    		swal( "" , "내용이 너무 많습니다." , "warning" );
    		return false;
    	}
    	
    	return true;
    } 
    
    
</script>
    
    
</head>
<body>
    <div class="wrapper">
        <div class="header_wrapper">
        
        
        </div>
        <div class="contents">
	       
	        
            <div class="ct_head">
            </div>
            <div class="ct_body">
	
			 <div class="title-head">
	        	<h4 style="font-family: 'Bazzi';">Q&A 질문 등록하기</h4>
	        </div>

            	 <form action="/qnaboard/register" method="post">
            	 			
                        	<div class="form-group">
                        		<label>제목</label> 
                        		<input class="form-control" name="title" id="title">
                        	</div>
                        	
                        	<div class="form-secret" style="padding : 5px; padding-left: -2px; margin-left: -4px; margin-bottom: 2%;">
                        		<input type="checkbox" id="secret"  name="secret" <%=secretCheck %>> 비밀글
                        		 <img src="/resources/img/lock.png" style="height: 15px" width="15px">
                        	</div>
                        	
                        	<div class="form-group">
                        		<label>작성자</label>
                        		<input class="writerArea" name='nickname' id="boardRegNickname" value="${nickname }" readonly="readonly">
		                	</div>
                        	
                        	<div class="form-group">
                        		<label>내용</label>
                        		<textarea class="form-control" rows="3" name='content' id="content"></textarea>
                        	</div>
                        	
		                		<input type="hidden" name="memNo" id="memNo" value="${memNo }">
                <div class="btn-wrap">
                	<button type="submit" class="reg-btn" onclick="return boardValid()">등록</button>
                	<button type="button" class="cancel-btn" onclick="javascript:history.back(-1)">취소</button>
                </div>	
            	</form>
            </div>
			<!-- ct_body -->
        </div>
		<!-- contents -->
    </div>
    

</body>
</html>

<%@ include file="../includes/footer.jsp" %>
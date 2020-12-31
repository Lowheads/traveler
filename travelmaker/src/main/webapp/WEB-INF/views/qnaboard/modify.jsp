<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ include file="../includes/header.jsp" %>

<%
	String secret = (String)request.getAttribute("secret"); // 비밀글 여부를 위한 변수 선언
	
	if(secret.equals("Y")){ // 비밀글이었다면 체크되어 있고
		secret = "checked ='checked'";
	}else{ 					// 비밀글이 아니었다면 체크가 안 되어 있다.
		secret = "";
	}
	
%>

<link rel="stylesheet" href="/resources/css/qnaboard/common.css">
<link rel="stylesheet" href="/resources/css/qnaboard/register.css">
<link rel="stylesheet" href="/resources/css/qnaboard/modify.css">

  <!-- 제이쿼리 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>



<div class="wrapper">
        <div class="header_wrapper">
        
        </div>
        <div class="contents">
            <div class="ct_head">
            </div>
            <div class="ct_body">

			<div class="title-head">
				<h4 style="font-family: 'Bazzi';">Q&A 게시글 수정</h4>
			</div>

			<form role="form" action="/qnaboard/modify" method="post">
            				
            				<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum }"/>'>
            				<input type='hidden' name='amount' value='<c:out value="${cri.amount }"/>'>
            				<input type='hidden' name='type' value='<c:out value="${cri.type }"/>'>
            				<input type='hidden' name='keyword' value='<c:out value="${cri.keyword }"/>'>
            				
            				<!-- 히든값 bno -->
                        	<input type="hidden" name="bno" id="bno" value='<c:out value="${board.bno }"/>'>
            				
                        	<div class="form-group">
                        		<label>제목</label> 
                        		<input class="form-control" name="title" id="title"
                        		value='<c:out value="${board.title }"/>'>
                        	</div>
                        	
                        	<div class="form-secret" style="padding : 5px; padding-left: -2px; margin-left: -4px; margin-bottom: 2%;">
                        		<input type="checkbox" id="secret"  name="secret" <%=secret %>> 비밀글
                        		 <img src="/resources/img/lock.png" style="height: 15px" width="15px">
                        	</div>
                        	
                      		<div class="form-group">
                        		<label>작성자</label>
                        		<input style="background-color: white;" class="form-control" name='nickname' 
                        		id="boardModNickname" value='<c:out value="${board.nickname }"/>' readonly="readonly">
                			</div>
                			
                			<div class="form-group">
                        		<label>최종수정일</label>
                        		<input style="background-color: white;" class="form-control" name='updateDate' value='<fmt:formatDate pattern="yyyy/MM/dd" 
                        		value="${board.updateDate }"/>' readonly="readonly">
                        	</div>
                        	
                        	<div class="form-group">
                        		<label>내용</label>
                        	    <textarea class="form-control" rows="3" name='content' id="content"><c:out value="${board.content}" /></textarea>
                        	</div>
                        	
                
	                <div class="btn-wrap">
		                <c:if test="${board.memNo == loginMemNo || myGrade == 'MG002'}">		                	
		            	<button type="submit" data-oper='modify' class="mod-btn" 
		            	onclick="return boardModifyValid()">수정완료</button>
		            	<button type="submit" data-oper='remove' class="del-btn">게시글 삭제</button>
		            	</c:if>
		            	<button type="submit" data-oper='list' class="list-btn">목록</button>
	            	</div>
				</form>  
            </div>
			<!-- ct_body -->
        </div>
		<!-- contents -->
	</div>
	

	
<script type="text/javascript">
    	
    $(document).ready(function(){
    	
    	let formObj = $("form");
    	
		$('button').on("click", function(e){
			e.preventDefault();
			
			let operation = $(this).data("oper");
			let titleLenVal = $("#title").val(); // 제목 길이
			
			 // 삭제전 물어보자
			if(operation === 'remove'){
				if (confirm("정말 삭제하시겠습니까??") == false){    //취소
				    return;
				}
				
				formObj.attr("action", "/qnaboard/remove");
				
			}else if(operation === 'list'){
				formObj.attr("action", "/qnaboard/list").attr("method", "get");
				
				let pageNumTag = $("input[name='pageNum']").clone();
				let amountTag = $("input[name='amount']").clone();
				let keywordTag = $("input[name='keyword']").clone();
				let typeTag = $("input[name='type']").clone();
				
				formObj.empty();
				formObj.append(pageNumTag);
				formObj.append(amountTag);
				formObj.append(keywordTag);
				formObj.append(typeTag);
			}else if(operation === 'modify'){
				
				if(titleLenVal.length > 30){
					alert("제목은 30자리까지 가능합니다");
					return;
				}
			}
			
			formObj.submit();
		});
		
		
		$("#secret").change(function(){
            if($("#secret").is(":checked")){
            	// 비밀 체크했으면 checked!
    			<% secret = "checked"; %>
            }else{
            	//아니면 null
                <% secret = ""; %>
            }
        });
	
		
}); // end document
    
    // 수정 유효성 검사
    function boardModifyValid(){
    	
    	let title = $("#title").val();
    	let content = $("#content").val();
    	
    	if(title.length == 0){
    		alert("제목이 빈칸일 수는 없습니다");
    		$("#title").focus();
    		return false;
    	}
    	
    	if(content.length == 0){
    		alert("내용이 빈칸일 수는 없습니다.");
    		$("#content").focus();
    		return false;
    	}
    	return true;
    }
    
    
</script>

<%@ include file="../includes/footer.jsp" %>
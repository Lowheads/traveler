<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ include file="../includes/header.jsp" %>

<link rel="stylesheet" href="/resources/css/common.css">
<link rel="stylesheet" href="/resources/css/register.css">

  <!-- 제이쿼리 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>



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
                <h2>게시글</h2>
            </div>
            <div class="ct_body">
            				
            		<form role="form" action="/qnaboard/modify" method="post">
            				
            				<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum }"/>'>
            				<input type='hidden' name='amount' value='<c:out value="${cri.amount }"/>'>
            				<input type='hidden' name='type' value='<c:out value="${cri.type }"/>'>
            				<input type='hidden' name='keyword' value='<c:out value="${cri.keyword }"/>'>
            				
            					<div class="form-group">
                        		<label>#게시물 번호</label> 
                        		<input class="form-control" name="bno" id="bno" 
                        		value='<c:out value="${board.bno }"/>' readonly="readonly">
                        	</div>
            				
                        	<div class="form-group">
                        		<label>제목</label> 
                        		<input class="form-control" name="title" id="title"
                        		value='<c:out value="${board.title }"/>'>
                        	</div>
                        	
                        	<div class="form-group">
                        		<label>내용</label>
                        	    <textarea class="form-control" rows="3" name='content' id="content"><c:out value="${board.content}" /></textarea>
                        	</div>
                        	
                        	<div class="form-group">
                        		<label>작성자</label>
                        		<input class="form-control" name='nickname' id="nickname" 
                        		value='<c:out value="${board.nickname }"/>' readonly="readonly">
                			</div>
                			
                        	<div class="form-group">
                        		<label>최종수정일</label>
                        		<input class="form-control" name='updateDate' value='<fmt:formatDate pattern="yyyy/MM/dd" 
                        		value="${board.updateDate }"/>' readonly="readonly">
                        	</div>
                
                <c:if test="${board.memNo == loginMemNo }">		                	
            	<button type="submit" data-oper='modify' class="btn" onclick="return boardModifyValid()">수정완료</button>
            	<button type="submit" data-oper='remove' class="btn">게시글 삭제</button>
            	</c:if>
            	<button type="submit" data-oper='list' class="btn">목록</button>
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
			}
			formObj.submit();
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
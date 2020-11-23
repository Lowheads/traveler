<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ include file="../../includes/mypageheader.jsp" %>

  <!-- Page Content -->
    <div class="row">

       <div class="leftNav">

        <div class="list-group">	
        <ul>
  <li><a href="/mypage/pickPL" class="list-group-item">찜한장소</a></li>
  <li><a href="/mypage/pickSch" class="list-group-item">찜한일정</a></li>
  <li><a href="/mypage/past" class="list-group-item">지나간여행</a></li>
  <li><a href="/mypage/upcomming" class="list-group-item">다가올여행</a></li>
</ul>
        </div>
        </div>
      <!-- /.col-lg-3 -->
 <div class="col-lg-9" style="padding-top: 20px;">
        <div class="row" style="flex-wrap: inherit;">
    <div style="display:block;" >
                <h4 class="card-title"><c:out value="${board.schTitle }"/></h4>
   <div>출발: <c:out value="${board.fromDate }"/></div>
 <div>도착: <c:out value="${board.toDate }"/></div>
  
 <div>최초작성일: <c:out value="${board.schRegDate }"/></div>
  
 <div> 최종수정일: <c:out value="${board.schLastDate }"/></div>
  
  <div>상태: <c:out value="${board.schStatus }"/></div><br>
 <div>메모: <c:out value="${board.memo}"/></div>
  
 <div>지역: <c:out value="${board.schRegion }"/></div>
</div>
</div>
      <div class="pull-right">
      <button data-oper='list'> 목록으로</button>
      </div>
</div>
     
      <form id='operForm' action="/mypage/past" method="get">
      <input type='hidden' id='sch_no' name='sch_no' value='<c:out value="${board.schNo}"/>'>
      <input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum}"/>'>
      <input type='hidden' name='amount' value='<c:out value="${cri.amount}"/>'>
      </form>
      <!-- /.col-lg-9 -->
      <script type="text/javascript">
      
      $(document).ready(function(){
    	  
     var operForm = $("#operForm");
      
      $("button[data-oper='list']").on("click",function(e){
    	
    	  operForm.find("#sch_no").remove();
    	  operForm.attr("action","/mypage/past/").submit();
    	  operForm.submit();
      });
      
      });
      
      
      
      </script>
<%@include file="../../includes/footer.jsp" %>
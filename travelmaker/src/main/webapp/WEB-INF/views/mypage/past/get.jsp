<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ include file="../../includes/mypageheader.jsp" %>
<!-- 경고창 -->
 <div id="remove_modal">
           <h4>정말 삭제하시겠습니까?</h4><br>
           
            <button class="modal_close_btn">취소</button>
            <button class="remove_btn">삭제</button>
        </div>
  <!-- Page Content -->

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
 <div class="content-mypage" style="padding-top: 20px;" >
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
 			<!-- 상세일정 출력 -->
 			<div class="contentAll">
				<c:set var="count" value="0"></c:set>
			<c:forEach items="${Schdt }" begin="0" end="${Schdt.size() }" var="schdt" varStatus="status">
				<c:if test="${Schdt[status.index].SCH_DATE ne Schdt[status.index-1].SCH_DATE  }">
				<div class="dayDt">
					<c:set var="count" value="${count+1 }"/>
						<div class="leftDate">
						<img alt="" src="data:image/png;base64,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" width="50px" height="50px">
						<br>
						<h2>${ count}일차</h2>
						<br>
						<fmt:formatDate value="${schdt.SCH_DATE}" type="date" dateStyle="full" /></div>
					<div class="dayDate">
						<c:forEach items="${Schdt }" begin="0" end="${Schdt.size() }" var="dt" varStatus="vs">
									
							<c:if test="${schdt.SCH_DATE eq dt.SCH_DATE }">
								<div class="dailyscheduleDT">
								<c:if test="${schdt.SCH_DATE eq dt.SCH_DATE}">
									<%-- <c:out value="${dt.FROM_PLC }" /> --%>
									<c:choose>
									<c:when test="${vs.index % 2.0 != 1 }">
									<a href="http://place.map.kakao.com/${dt.FROM_PLC }">
									<img class="plcImg" alt="" src="${dt.FROMIMG }" height="100px;" width="100px;">
									<div class="overlay">
  									  <div class="text"><c:out value="${dt.FROMTITLE }"/></div>
 									 </div>
									</a>
									
								<div class="directionAll">
								<c:choose>
								<c:when test="${schdt.SCH_DATE eq Schdt[vs.index-1].SCH_DATE}"><div class="direction"><div style="width: 100%; height: 10%; background-color:white;"></div></div>
								</c:when>
								<c:when test="${schdt.SCH_DATE ne Schdt[vs.index-1].SCH_DATE}"><div class="direction"></div>
								</c:when>
								</c:choose>
								<div class="direction"><div style="border-radius:50%; background-color:white; width: 100%; height: 100%"></div></div>
								<div class="direction"><div style="width: 100%; height: 10%; background-color:white;"></div></div>
								</div>
								<div style="height: 100px; width: 100px"></div>
									</c:when>
									<c:when test="${vs.index % 2.0 == 1 }">
									<div style="height: 100px; width: 100px"></div>
								<div class="directionAll">
									<c:choose>
								<c:when test="${schdt.SCH_DATE eq Schdt[vs.index-1].SCH_DATE}"><div class="direction"><div style="width: 100%; height: 10%; background-color:white;"></div></div>
								</c:when>
								<c:when test="${schdt.SCH_DATE ne Schdt[vs.index-1].SCH_DATE}"><div class="direction"></div>
								</c:when>
								</c:choose>
								<div class="direction"><div style="border-radius:50%; background-color:white; width: 100%; height: 100%"></div></div>
								<div class="direction"><div style="width: 100%; height: 10%; background-color:white;"></div></div>
								</div>
								<a href="http://place.map.kakao.com/${dt.FROM_PLC }">
									<img class="plcImg" alt="" src="${dt.FROMIMG }" height="100px;" width="100px;">
									<div class="overlay">
  									  <div class="text"><c:out value="${dt.FROMTITLE }"/></div>
 									 </div>
									</a>
									</c:when>
									</c:choose>
									<%-- <c:out value="${dt.DISTANCE }" />
									<c:out value="${dt.DURATION }" />
									<c:out value="${dt.TRANSIT }" /> --%>
									</c:if>
								</div>
								
								<c:if test="${Schdt[status.index].SCH_DATE ne Schdt[vs.index+1].SCH_DATE}">
								<div class="dailyscheduleDT">
								<c:choose>
									<c:when test="${vs.index % 2.0 == 1 }">
									<a href="http://place.map.kakao.com/${dt.TO_PLC }">
									<img class="plcImg" alt="" src="${dt.TOIMG }" height="100px;" width="100px;">
									<div class="overlay">
  									  <div class="text"><c:out value="${dt.TOTITLE }"/></div>
 									 </div>
									</a>
								<div class="directionAll">
								<div class="direction"><div style="width: 100%; height: 10%; background-color:white;"></div></div>
								<div class="direction"><div style="border-radius:50%; background-color:white; width: 100%; height: 100%"></div></div>
								<div class="direction"></div>
								</div>
								<div style="height: 100px; width: 100px"></div>
									</c:when>
									<c:when test="${vs.index % 2.0 != 1 }">
									<div style="height: 100px; width: 100px"></div>	
								<div class="directionAll">
								<div class="direction"><div style="width: 100%; height: 10%; background-color:white;"></div></div>
								<div class="direction"><div style="border-radius:50%; background-color:white; width: 100%; height: 100%"></div></div>
								<div class="direction"></div>
								</div>		
								<a href="http://place.map.kakao.com/${dt.TO_PLC }">
									<img class="plcImg" alt="" src="${dt.TOIMG }" height="100px;" width="100px;">
									<div class="overlay">
  									  <div class="text"><c:out value="${dt.TOTITLE }"/></div>
 									 </div>
									</a>
									</c:when>
									</c:choose>
									<%-- <c:out value="${dt.TO_PLC }" /> --%>
									<%-- <c:out value="${dt.DURATION }" /> --%>
									</div>
									</c:if>
							</c:if>
						</c:forEach> 
					</div>
					<br>
			</div>
				</c:if>
			</c:forEach>
		</div>

      <div class="pull-right">
      <button data-oper='list'> 목록으로</button>
      <button id="popup_open_btn">삭제</button>
      </div>
</div>
</div>
     
	<form id='operForm' action="/mypage/past" method="get">
      <input type='hidden' id='sch_no' name='sch_no' value='<c:out value="${board.schNo}"/>'>
      <input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum}"/>'>
	</form>
      <!-- /.col-lg-9 -->
      <script type="text/javascript">
    	  
var operForm = $("#operForm");
      
      $("button[data-oper='list']").on("click",function(e){
    	
    	  operForm.find("#sch_no").remove();
    	  operForm.attr("action","/mypage/past").submit();
    	  operForm.submit();
      });
      
      $(".remove_btn").on("click",function(){

    	  
    	  let schNo = {
    			  "schNo" : $('input[name=sch_no]').val()
    	  };
    	  
    	  $.ajax({
				type : 'post',
				url : '/mypage/remove',
				data : schNo,
				success : function(data) {
					
					alert("목록에서 삭제되었습니다.");
					location.href="/mypage/past?pageNum="+$('input[name=pageNum]').val();
				},
    	 		error : function (xhr){
    		  		
    	 			alert("삭제실패");
    			 }
    	 
     		 });
      });
      
      function modal(id) {
          var zIndex = 9999;
          var modal = document.getElementById(id);

          // 모달 div 뒤에 희끄무레한 레이어
          var bg = document.createElement('div');
          bg.setStyle({
              position: 'fixed',
              zIndex: zIndex,
              left: '0px',
              top: '0px',
              width: '100%',
              height: '100%',
              overflow: 'auto',
              // 레이어 색갈은 여기서 바꾸면 됨
              backgroundColor: 'rgba(0,0,0,0.4)'
          });
          document.body.append(bg);

          // 닫기 버튼 처리, 시꺼먼 레이어와 모달 div 지우기
          modal.querySelector('.modal_close_btn').addEventListener('click', function() {
              bg.remove();
              modal.style.display = 'none';
          });

          modal.setStyle({
              position: 'fixed',
              display: 'block',
              boxShadow: '0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19)',

              // 시꺼먼 레이어 보다 한칸 위에 보이기
              zIndex: zIndex + 1,

              // div center 정렬
              top: '50%',
              left: '50%',
              transform: 'translate(-50%, -50%)',
              msTransform: 'translate(-50%, -50%)',
              webkitTransform: 'translate(-50%, -50%)'
          });
      };

      // Element 에 style 한번에 오브젝트로 설정하는 함수 추가
      Element.prototype.setStyle = function(styles) {
          for (var k in styles) this.style[k] = styles[k];
          return this;
      };

      document.getElementById('popup_open_btn').addEventListener('click', function() {
          // 모달창 띄우기
          modal('remove_modal');
      });
      
      </script>
<%@include file="../../includes/footer.jsp" %>
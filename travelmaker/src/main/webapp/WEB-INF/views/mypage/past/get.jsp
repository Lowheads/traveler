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
						<img alt="" src="/resources/img/pngwave.png" width="50px" height="50px;">
						<br>
						<h4>${ count}일차</h4>
						<p><fmt:formatDate value="${schdt.SCH_DATE}" type="date" dateStyle="full" /></p>
						</div>
					<div class="dayDate">
						<c:forEach items="${Schdt }" begin="0" end="${Schdt.size() }" var="dt" varStatus="vs">
									
							<c:if test="${schdt.SCH_DATE eq dt.SCH_DATE }">
								<div class="dailyscheduleDT">
								<c:if test="${schdt.SCH_DATE eq dt.SCH_DATE}">
									<%-- <c:out value="${dt.FROM_PLC }" /> --%>
									<c:choose>
									<c:when test="${vs.index % 2.0 != 1 }">
									<a href="http://place.map.kakao.com/${dt.FROM_PLC }" target="blank">
									<img class="plcImg" alt="" src="${dt.FROMIMG }" height="100px;" width="100px;">
									<div class="overlay">
  									  <div class="text"><c:out value="${dt.FROMTITLE }"/></div>
 									 </div>
									</a>
									
								<div class="directionAll">
								<c:choose>
								<c:when test="${schdt.SCH_DATE eq Schdt[vs.index-1].SCH_DATE}"><div class="direction"><div class="dango" style="width: 100%; height: 10%;">
								<p style="font-size: 12px;"><c:out value="${dt.DISTANCE }" />km</p></div></div>
								</c:when>
								<c:when test="${schdt.SCH_DATE ne Schdt[vs.index-1].SCH_DATE}"><div class="direction"></div>
								</c:when>
								</c:choose>
								<div class="direction"><div class="dango" style="border-radius:50%; width: 100%; height: 100%;">
								<c:choose>
								<c:when test="${dt.FROMCATE eq 'CT1' }">
								<img alt="" src="https://www.flaticon.com/svg/static/icons/svg/236/236981.svg">
								</c:when>
								<c:when test="${dt.FROMCATE eq 'PO3' }">
								<img alt="" src="https://www.flaticon.com/svg/static/icons/svg/236/236956.svg">
								</c:when>
								<c:when test="${dt.FROMCATE eq 'AT4' }">
								<img alt="" src="https://www.flaticon.com/svg/static/icons/svg/236/236986.svg">
								</c:when>
								<c:when test="${dt.FROMCATE eq 'AD5' }">
								<img alt="" src="https://www.flaticon.com/svg/static/icons/svg/236/236980.svg">
								</c:when>
								<c:when test="${dt.FROMCATE eq 'FD6' }">
								<img alt="" src="https://www.flaticon.com/svg/static/icons/svg/236/236969.svg">
								</c:when>
								<c:when test="${dt.FROMCATE eq 'CE7' }">
								<img alt="" src="https://www.flaticon.com/svg/static/icons/svg/236/236960.svg">
								</c:when>
								<c:when test="${dt.FROMCATE eq 'HP8' }">
								<img alt="" src="https://www.flaticon.com/svg/static/icons/svg/3209/3209074.svg">
								</c:when>
								<c:when test="${dt.FROMCATE eq 'ET1' }">
								<img alt="" src="https://www.flaticon.com/svg/static/icons/svg/237/237004.svg">
								</c:when>
								
								</c:choose>								
								</div></div>
								<div class="direction"><div class="dango" style="width: 100%; height: 10%;"><p style="font-size: 12px;"><c:out value="${dt.DURATION }" />시간</p></div></div>
								</div>
								<div style="height: 100px; width: 100px"></div>
									</c:when>
									<c:when test="${vs.index % 2.0 == 1 }">
									<div style="height: 100px; width: 100px"></div>
								<div class="directionAll">
									<c:choose>
								<c:when test="${schdt.SCH_DATE eq Schdt[vs.index-1].SCH_DATE}"><div class="direction">
								<div class="dango" style="width: 100%; height: 10%;">
								<p style="font-size: 12px;"><c:out value="${dt.DISTANCE }" />km</p>
								</div></div>
								</c:when>
								<c:when test="${schdt.SCH_DATE ne Schdt[vs.index-1].SCH_DATE}"><div class="direction"></div>
								</c:when>
								</c:choose>
								<div class="direction"><div class="dango" style="border-radius:50%; width: 100%; height: 100%">
								<c:choose>
								<c:when test="${dt.FROMCATE eq 'CT1' }">
								<img alt="" src="https://www.flaticon.com/svg/static/icons/svg/236/236981.svg">
								</c:when>
								<c:when test="${dt.FROMCATE eq 'PO3' }">
								<img alt="" src="https://www.flaticon.com/svg/static/icons/svg/236/236956.svg">
								</c:when>
								<c:when test="${dt.FROMCATE eq 'AT4' }">
								<img alt="" src="https://www.flaticon.com/svg/static/icons/svg/236/236986.svg">
								</c:when>
								<c:when test="${dt.FROMCATE eq 'AD5' }">
								<img alt="" src="https://www.flaticon.com/svg/static/icons/svg/236/236980.svg">
								</c:when>
								<c:when test="${dt.FROMCATE eq 'FD6' }">
								<img alt="" src="https://www.flaticon.com/svg/static/icons/svg/236/236969.svg">
								</c:when>
								<c:when test="${dt.FROMCATE eq 'CE7' }">
								<img alt="" src="https://www.flaticon.com/svg/static/icons/svg/236/236960.svg">
								</c:when>
								<c:when test="${dt.FROMCATE eq 'HP8' }">
								<img alt="" src="https://www.flaticon.com/svg/static/icons/svg/3209/3209074.svg">
								</c:when>
								<c:when test="${dt.FROMCATE eq 'ET1' }">
								<img alt="" src="https://www.flaticon.com/svg/static/icons/svg/237/237004.svg">
								</c:when>
								
								</c:choose>
								</div></div>
								<div class="direction"><div class="dango" style="width: 100%; height: 10%; "><p style="font-size: 12px;"><c:out value="${dt.DURATION }" />시간</p></div></div>
								</div>
								<a href="http://place.map.kakao.com/${dt.FROM_PLC }" target="blank">
									<img class="plcImg" alt="" src="${dt.FROMIMG }" height="100px;" width="100px;">
									<div class="overlay">
  									  <div class="text"><c:out value="${dt.FROMTITLE }"/></div>
 									 </div>
									</a>
									</c:when>
									</c:choose>
									<%-- 나중에 쓸거 
									<c:out value="${dt.DISTANCE }" />
									<c:out value="${dt.DURATION }" />
									<c:out value="${dt.TRANSIT }" /> --%>
									</c:if>
								</div>
								
								<c:if test="${Schdt[status.index].SCH_DATE ne Schdt[vs.index+1].SCH_DATE}">
								<div class="dailyscheduleDT">
								<c:choose>
									<c:when test="${vs.index % 2.0 == 1 }">
									<a href="http://place.map.kakao.com/${dt.TO_PLC }" target="blank">
									<img class="plcImg" alt="" src="${dt.TOIMG }" height="100px;" width="100px;">
									<div class="overlay">
  									  <div class="text"><c:out value="${dt.TOTITLE }"/></div>
 									 </div>
									</a>
								<div class="directionAll">
								<div class="direction"><div class="dango" style="width: 100%; height: 10%; "><p style="font-size: 12px;"><c:out value="${dt.DISTANCE }" />km</p></div></div>
								<div class="direction"><div class="dango" style="border-radius:50%; width: 100%; height: 100%">
								<c:choose>
								<c:when test="${dt.TOCATE eq 'CT1' }">
								<img alt="" src="https://www.flaticon.com/svg/static/icons/svg/236/236981.svg">
								</c:when>
								<c:when test="${dt.TOCATE eq 'PO3' }">
								<img alt="" src="https://www.flaticon.com/svg/static/icons/svg/236/236956.svg">
								</c:when>
								<c:when test="${dt.TOCATE eq 'AT4' }">
								<img alt="" src="https://www.flaticon.com/svg/static/icons/svg/236/236986.svg">
								</c:when>
								<c:when test="${dt.TOCATE eq 'AD5' }">
								<img alt="" src="https://www.flaticon.com/svg/static/icons/svg/236/236980.svg">
								</c:when>
								<c:when test="${dt.TOCATE eq 'FD6' }">
								<img alt="" src="https://www.flaticon.com/svg/static/icons/svg/236/236969.svg">
								</c:when>
								<c:when test="${dt.TOCATE eq 'CE7' }">
								<img alt="" src="https://www.flaticon.com/svg/static/icons/svg/236/236960.svg">
								</c:when>
								<c:when test="${dt.TOCATE eq 'HP8' }">
								<img alt="" src="https://www.flaticon.com/svg/static/icons/svg/3209/3209074.svg">
								</c:when>
								<c:when test="${dt.TOCATE eq 'ET1' }">
								<img alt="" src="https://www.flaticon.com/svg/static/icons/svg/237/237004.svg">
								</c:when>
								</c:choose>
								</div></div>
								<div class="direction"></div>
								</div>
								<div style="height: 100px; width: 100px"></div>
									</c:when>
									<c:when test="${vs.index % 2.0 != 1 }">
									<div style="height: 100px; width: 100px"></div>	
								<div class="directionAll">
								<div class="direction"><div class="dango" style="width: 100%; height: 10%;"><p style="font-size: 12px;"><c:out value="${dt.DISTANCE }" />km</p></div></div>
								<div class="direction"><div class="dango" style="border-radius:50%;  width: 100%; height: 100%">
									<c:choose>
								<c:when test="${dt.TOCATE eq 'CT1' }">
								<img alt="" src="https://www.flaticon.com/svg/static/icons/svg/236/236981.svg">
								</c:when>
								<c:when test="${dt.TOCATE eq 'PO3' }">
								<img alt="" src="https://www.flaticon.com/svg/static/icons/svg/236/236956.svg">
								</c:when>
								<c:when test="${dt.TOCATE eq 'AT4' }">
								<img alt="" src="https://www.flaticon.com/svg/static/icons/svg/236/236986.svg">
								</c:when>
								<c:when test="${dt.TOCATE eq 'AD5' }">
								<img alt="" src="https://www.flaticon.com/svg/static/icons/svg/236/236980.svg">
								</c:when>
								<c:when test="${dt.TOCATE eq 'FD6' }">
								<img alt="" src="https://www.flaticon.com/svg/static/icons/svg/236/236969.svg">
								</c:when>
								<c:when test="${dt.TOCATE eq 'CE7' }">
								<img alt="" src="https://www.flaticon.com/svg/static/icons/svg/236/236960.svg">
								</c:when>
								<c:when test="${dt.TOCATE eq 'HP8' }">
								<img alt="" src="https://www.flaticon.com/svg/static/icons/svg/3209/3209074.svg">
								</c:when>
								<c:when test="${dt.TOCATE eq 'ET1' }">
								<img alt="" src="https://www.flaticon.com/svg/static/icons/svg/237/237004.svg">
								</c:when>
								</c:choose>
								</div></div>
								<div class="direction"></div>
								</div>		
								<a href="http://place.map.kakao.com/${dt.TO_PLC }" target="blank">
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
				url : '/mypage/deleteSchedule',
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
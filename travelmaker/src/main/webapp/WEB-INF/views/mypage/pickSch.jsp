<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ include file="../includes/mypageheader.jsp" %>


  <!-- Page Content -->
     <!-- sort -->
<select id="listSort" style="float:right; margin-right:10%;" > 
<option hidden selected disabled ></option>
<!-- <option value="like">좋아요 순</option> -->
<option value="new">최근에 찜한 순</option>
<option value="old">오래전에 찜한 순</option>
</select>

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
<!-- col-lg-9(content) -->
      <div class="content-mypage" style="padding-top: 20px;">
        <div class="row">

<c:forEach items="${list }" var="sch">
            <div class="card h-100" id="resultcard">
            <a class='move' href='<c:out value="${sch.schNo }"/>'>
           <img class="card-img-top" src="" alt=""></a>
              <div class="card-body">
                <h4 class="card-title">
                   <a class='move' href='<c:out value="${sch.schNo }"/>'>
                   <c:out value="${sch.schTitle }"></c:out>
                   </a>
                        <!-- Like  -->
     <div style="float:right;" class="heart">
       <a sch_no='${sch.schNo}'>
          <i id="heart"  class="fa fa-heart" style="font-size:24px;color:red"></i>
       </a>
   </div>          
             <!-- Like end -->
                </h4>
              </div>
          </div>
</c:forEach>

<form id='actionForm' action="/mypage/pickSch" method='get'>
	<input type='hidden' name='pageNum' value = '${pageMaker.cri.pageNum }'>
	<input type='hidden' name='selected' value = <%= request.getParameter("selected") %>>
</form>
        </div>
        <!-- /.row -->
   <div style="text-align: center;" class="w3-center">
<ul class="w3-bar">
<c:if test="${pageMaker.prev }">
<li class="w3-button" num="${pageMaker.startPage-1 }"><a>&laquo;</a></li>
</c:if>

<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
<li class="w3-button" "${pageMaker.cri.pageNum == num ? "'active' style='background-color:gray; color:white;'":"" }" num="${num}">
<a> ${num }</a></li>
</c:forEach>

<c:if test="${pageMaker.next }">
<li class="w3-button" num="${pageMaker.endPage +1 }">
<a>&raquo;</a></li>
</c:if>
</ul>
</div>
      <!-- /.col-lg-9 -->


<script type="text/javascript">
		
	$(document).ready(function() {

		selectVal();

	});

	var actionForm = $("#actionForm");

	$(".w3-button").on("click", function(e) {

		e.preventDefault();

		actionForm.find("input[name='pageNum']").val($(this).attr("num"));
		actionForm.submit();
	});

	$(".move").on(
			"click",
			function(e) {

				e.preventDefault();
				actionForm.append("<input type='hidden' name='sch_no' value='"
						+ $(this).attr("href") + "'>");
				actionForm.attr("action", "/mypage/pickSch/get");
				actionForm.submit();

			})

	//좋아요 취소하는 버튼
	$(".heart a").on("click", function() {

		$(this).hide(30);
		var sendData = {
			'schNo' : $(this).attr('sch_no'),
		}
		$.ajax({
			type : 'POST',
			url : '/mypage/heart',
			data : sendData,
			success : function(data) {

				alert("목록에서 삭제되었습니다.")
				location.reload();
			}
		});
	});

	$("#listSort").change(function() {

		location.replace("/mypage/pickSch?selected=" + this.value);
	});

	//셀렉트 value 값 설정
	function selectVal() {
		var selVal = document.location.href.split("selected=");

		var selArr = $("#listSort option");
		if (selVal[1] == undefined || selVal[1] == 'null') {
			selArr[0].innerHTML = "정렬 기준";
		}
		if (selVal[1] == "like") {
			selArr[0].innerHTML = "좋아요 순";
		}
		;
		if (selVal[1] == "new") {
			selArr[0].innerHTML = "최근에 찜한 순";
		}
		;
		if (selVal[1] == "old") {
			selArr[0].innerHTML = "오래전에 찜한 순";
		}
		;
	}
</script>   
<%@include file="../includes/footer.jsp" %>
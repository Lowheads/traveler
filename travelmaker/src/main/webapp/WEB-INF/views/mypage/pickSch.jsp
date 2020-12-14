<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ include file="../includes/mypageheader.jsp" %>


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
<!-- col-lg-9(content) -->
      <div class="content-mypage" style="padding-top: 20px;">
         <!-- sort -->
     <!-- sort -->
<select id="listSort" style="float:right; display:block; margin-right:7%;" > 
<option hidden selected disabled ></option>
<option value="like">좋아요 순</option>
<option value="new">최근에 찜한 순</option>
<option value="old">오래전에 찜한 순</option>
</select><br>
        <div class="row">

<c:forEach items="${list }" var="sch">
            <div class="card h-100" id="resultcard">
            <a class='move' href='<c:out value="${sch.SCH_NO }"/>'>
           <img class="card-img-top" src="" alt=""></a>
             <div class="heart">
          <i class="fa fa-heart" data-sch_no="${sch.SCH_NO}" style="font-size:24px;color:red" onclick="likeToggle(this)"></i><br>
   </div>
   <p style="font-size:3px;	">좋아요 <b><c:out value="${sch.PICK_CNT}"/></b>개
      </p>
              <div class="card-body">
                <h4 class="card-title">
                   <a class='move' href='<c:out value="${sch.SCH_NO }"/>'>
                   <c:out value="${sch.SCH_TITLE }"></c:out>
                   </a>
                        <!-- Like  -->
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

		//조와요
		function likeToggle(heart){
			if(heart.className == "fa fa-heart"){
				let sendData = {
						'schNo' : heart.dataset['sch_no'],
					}
					//ajax 기능 추가 
					$.ajax({
						type : 'post',
						url : '/mypage/deletePick',
						data : sendData,
						success : function(data) {
							heart.classList.toggle("fa-heart-o");
							heart.parentElement.nextElementSibling.firstElementChild.innerText = 
								Number(heart.parentElement.nextElementSibling.firstElementChild.innerText)-1;
					 	},
						error : function(error){
							alert("에러발생!! 다시시도해주세요"+error);
						}
					});
			}
			
			if(heart.className == "fa fa-heart fa-heart-o"){
				let sendData = {
						'schNo' : heart.dataset['sch_no'],
					}
					//ajax 기능 추가 
					$.ajax({
						type : 'post',
						url : '/mypage/insertPick',
						data : sendData,
						success : function(data) {
							heart.classList.toggle("fa-heart-o");
							heart.parentElement.nextElementSibling.firstElementChild.innerText = 
								Number(heart.parentElement.nextElementSibling.firstElementChild.innerText)+1;
						},
						error : function(error){
							alert("에러발생!! 다시시도해주세요"+error);
						}
					});
			}
			
		}; 
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
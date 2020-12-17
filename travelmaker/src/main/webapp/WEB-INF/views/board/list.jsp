<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="../includes/jeheader.jsp"%>

<div class="container">

	<div>
		<h1>테마 게시판</h1>
	</div>
	<!-- 모달여는버튼 -->

    <button id="schedulelist_open_btn" class="btn">내 일정 공유</button>
    <button id="hiddenlist_open_btn" class="btn">공개/비공개 설정</button>

	
	<div>
	<c:forEach items="${list }" var="board">
	<div class="responsive" >
	<div class ="row" id="new">
		<div class="gallery">
			<a target="_self" href='/board/get?boardNo=<c:out value="${board.boardNo }"/>
			&pageNum=<c:out value="${pageMaker.cri.pageNum }"/>&amount=<c:out value="${pageMaker.cri.amount }"/>'>
				<img src="/resources${board.boardImg}" >
			</a>
			<div class="desc">
			<c:out value="${board.boardTitle }" /><br>
			작성자 : <c:out value="${board.writer }"/><br>
			조회수 : <c:out value="${board.VCnt }"/> 좋아요 수 : <c:out value="${board.pickCnt }"/><br>
			작성일  : <c:out value="${board.WDate }"/>
			</div>
		</div>
		</div>
	</div>
	</c:forEach>			

</div>
		<form id='actionForm' action="/board/list" method='get'>
			<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum }'>
			<input type='hidden' name='amount' value='${pageMaker.cri.amount }'>
		</form>
<ul class="w3-bar" style='text-align:center'>
	<c:if test="${pageMaker.prev }">
		<li class="w3-button" num="${pageMaker.startPage-1 }"><a>&laquo;</a></li>
	</c:if>

	<c:forEach var="num" begin="${pageMaker.startPage}"
		end="${pageMaker.endPage}">
		<li class="w3-button"
			"${pageMaker.cri.pageNum==num? "'active' style='background-color:gray; color:white;'":"" }" >
			<a href="${num }">${num }</a>
		</li>
	</c:forEach>

	<c:if test="${pageMaker.next }">
		<li class="w3-button" num="${pageMaker.endPage +1 }"><a>&raquo;</a></li>
	</c:if>
</ul>
</div>

<!-- Hiddenlist Modal -->
<div id="hiddenlist_modal" class="modal-content">

	<div>
		<h3>공개/비공개 설정</h3><br>
	</div>
	<div class="modal-body">
		<table class="table table-striped table-sm">
			<thead>
				<tr>
					<th>일정번호</th>
					<th>일정명</th>
					<th>게시글이름</th>
					<th>공개여부</th>

				</tr>
			</thead>

			<c:forEach items="${hiddenlist}" var="hiddenlist">
				<tr>
					<td><c:out value="${hiddenlist.SCHNO }"/></td>
					<td><c:out value="${hiddenlist.SCHTITLE}" /></td>
					<td><c:out value="${hiddenlist.BOARDTITLE}" /></td>
					<td>
					<label class="switch"> 
					<input type="checkbox" ${hiddenlist.HIDDEN eq 'y'? "checked":"" }> <span class="slider round" data-hidden="${hiddenlist.HIDDEN }" data-schno="${hiddenlist.SCHNO }"></span>
					</label></td>
					
					
				</tr>
			</c:forEach>
		</table>
	</div>
	<button class="modal_close_btn"> 확인 </button>

</div>

<!-- Schedulelist Modal -->
	<div id="schedulelist_modal" class="modal-content">
	<h3>내일정 공유 </h3><br>
	<div class="modal-body">
		<table class="table table-striped table-sm">
			<thead>
				<tr>
					<th>일정번호</th>
					<th>일정명</th>
					<th>작성여부</th>

				</tr>
			</thead>

			<c:forEach items="${schedulelist}" var="schedule">
				<tr class="schedulenum">
				<td>
					<c:choose>
					<c:when test="${schedule.schStatus eq 'BS003' }"> 
					<a href='/board/register?schNo=<c:out value="${schedule.schNo}"/>' target='register' class='register_open_btn'><c:out value="${schedule.schNo}" /></a>

					</c:when>
					
					<c:when test="${schedule.schStatus eq 'BS001'}">
					<c:out value="${schedule.schNo}" />
					</c:when>
					
					<c:when test="${schedule.schStatus eq 'BS002'}">
					<a href='/board/dtregister?schNo=<c:out value="${schedule.schNo}"/>'><c:out value="${schedule.schNo}" /></a>
					</c:when>
					
					</c:choose>
					</td>
					
					<td><c:out value="${schedule.schTitle}" /></td>
		<!--  		<td><c:out value="${schedule.schStatus }"/></td>  -->
					<td>
					<c:choose>
					<c:when test="${schedule.schStatus eq 'BS001' }"> 작성 </c:when>
					<c:when test="${schedule.schStatus eq 'BS002' }"> 작성중 </c:when>
					<c:when test="${schedule.schStatus eq 'BS003' }"> 미작성 </c:when>
					</c:choose>
					</td>
					
				</tr>
			</c:forEach>
		</table>	
	</div>
	<button class="modal_close_btn"> 취소 </button>
</div>


<!--  register modal  -->
	<div id="register_modal" class="modal-content">
		<div class="modal-body" style="overflow-x:hidden; overflow-y:hidden">
		<iframe name="register" title="register" width=100% height=100% frameBorder="0" scrolling="no">
		</iframe>
		</div>
		<button class="modal_close_btn"> 취소 </button>
	</div>



<script type="text/javascript">
	$(document).ready(function() {


		var actionForm = $("#actionForm");
		$(".w3-button a").on("click", function(e) {
			e.preventDefault();
			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
			actionForm.submit();
		});

	});
	
	//hiddenlist script
	$(".round").on("click", function() {

		let sendData = {

			"hidden" : $(this).data("hidden"),
			"schNo" : $(this).data("schno")
		};
		$.ajax({
			type : 'post',
			url : '/board/hidden',
			data : sendData,

			success : function(data) {
			}

		});

	});
	
	function modal(id) {
		var zIndex = 9999;
		var modal = document.getElementById(id);

		// 모달 div 뒤에 희끄무레한 레이어
		var bg = document.createElement('div');
		bg.setStyle({
			position : 'fixed',
			zIndex : zIndex,
			left : '0px',
			top : '0px',
			width : '100%',
			height : '100%',
			overflow : 'auto',
			// 레이어 색갈은 여기서 바꾸면 대
			backgroundColor : 'rgba(0,0,0,0.4)'
		});
		bg.classList.add('schedulelistbg');
		document.body.append(bg);

		// 닫기 처리
		modal.querySelector('.modal_close_btn').addEventListener('click',
				function() {
					bg.remove();
					modal.style.display = 'none';
					window.location.reload();
				});

		modal
				.setStyle({
					position : 'fixed',
					display : 'block',
					boxShadow : '0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19)',

					// 시꺼먼 레이어 보다 한칸 위에 보이기
					zIndex : zIndex + 1,

					// 모달 가운데 이쁘게
					top : '50%',
					left : '50%',
					transform : 'translate(-50%, -50%)',
					msTransform : 'translate(-50%, -50%)',
					webkitTransform : 'translate(-50%, -50%)'
				});
	};

	// 이건 먼지모르겟음..
	Element.prototype.setStyle = function(styles) {
		for ( var k in styles)
			this.style[k] = styles[k];
		return this;
	};

	// hiddenlist 모달 띄우기
	document.getElementById('hiddenlist_open_btn').addEventListener('click',
			function() {
				modal('hiddenlist_modal');
			});
	
	//schedulelist 모달 띄우기
	document.getElementById('schedulelist_open_btn').addEventListener('click',
			function() {
				modal('schedulelist_modal');
			});
	//register 모달 띄우기
	$('.register_open_btn').on("click", function() {
				$('#schedulelist_modal').hide();
				$('.schedulelistbg').hide();
				modal('register_modal');
			});
</script>
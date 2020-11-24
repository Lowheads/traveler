<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="../includes/jeheader.jsp"%>


<div class="container">
	<div>
		<h1>테마 게시판</h1>
	</div>
	<button id="regBtn" class="btn btn-sm-btn-primary">내 일정 공유</button>
	<button id="hiddenBtn" class="btn btn-sm-btn-primary">공개/비공개 설정</button>
	<div>
		<table class="board">
			<thead>
				<tr>
					<th>#게시물번호</th>
					<th>일정번호</th>
					<th>게시물명</th>
					<th>최초작성일</th>
					<th>최종수정일</th>
					<th>공개여부</th>
					<th>작성자</th>
					<th>대표사진</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${list}" var="board">
					<tr>
						<td><a class='move'
							href='/board/get?schNo=<c:out value="${board.schNo}"/>&boardNo=<c:out value="${board.boardNo }"/>
				&pageNum=<c:out value="${pageMaker.cri.pageNum }"/>&amount=<c:out value="${pageMaker.cri.amount }"/>'>
								<c:out value="${board.boardNo }" />
						</a></td>
						<td><c:out value="${board.schNo }" /></td>
						<td><c:out value="${board.boardTitle }" /></td>
						<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.WDate}" /></td>
						<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.modDate}" /></td>
						<td><c:out value="${board.hidden }" /></td>
						<td><c:out value="${board.writer }"/></td>
						<td><img class="orgImg" src="<c:out value='${board.boardImg}'/>" /></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<form id='actionForm' action="/board/list" method='get'>
			<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum }'>
			<input type='hidden' name='amount' value='${pageMaker.cri.amount }'>
		</form>
		<div class='text-center'>
			<ul class="pagination">

				<c:if test="${pageMaker.prev }">
					<li class="paginate_button previous"><a
						href="${pageMaker.startPage-1 }">Previous</a></li>
				</c:if>

				<c:forEach var="num" begin="${pageMaker.startPage }"
					end="${pageMaker.endPage }">
					<li class="paginate_button ${pageMaker.cri.pageNum==num? "active":"" }">
						<a href="${num }">${num }</a>
					</li>
				</c:forEach>

				<c:if test="${pageMaker.next }">
					<li class="paginate_button next"><a
						href="${pageMaker.endPage+1 }">Next</a></li>
				</c:if>
			</ul>
		</div>

		<div></div>
	</div>
</div>

<script type="text/javascript">

	$(document).ready(function() {	


				$("#regBtn").on("click",function(){
					self.location="/board/schedulelist";
				});
				
				$("#hiddenBtn").on("click",function(){
					self.location="/board/hiddenlist";
				});
				
				var actionForm = $("#actionForm");
				 $(".paginate_button a").on("click", function(e){
					e.preventDefault();
					actionForm.find("input[name='pageNum']").val($(this).attr("href"));
					actionForm.submit();
				});
				
			});

</script>	


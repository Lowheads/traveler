<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<%@include file="../includes/header.jsp"%>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript">


	$(document).ready(function() {	
				var result='<c:out value="${result}"/>';
				checkModal(result);
				
				history.replaceState({},null,null);
				
				function checkModal(result){
					
					if(result==='' || history.state){
						return;
					}
				}
					/* if(parseInt(result)>0){
						$(".modal-body").html("게시글"+parseInt(result)+"번이 등록되었습니다.");
					}
					$("#myModal").modal("show");
				} */
				$("#regBtn").on("click",function(){
					self.location="/board/schedulelist";
				});
				
//				$(".move").on("click",function(e){
//					e.preventDefault();
//					actionForm.append("<input type='hidden' name='board_no' value='"+$(this).attr("href")+"'>");
//					actionForm.attr("action","/board/get");
//					actionForm.submit();
//				});
				
				var actionForm = $("#actionForm");
				 $(".paginate_button a").on("click", function(e){
					e.preventDefault();
					actionForm.find("input[name='pageNum']").val($(this).attr("href"));
					actionForm.submit();
				});
				
			});

</script>

<div class="container">
<div><h1>테마 게시판</h1></div>

<div class="table-responsive">
	<table class="table table-striped table-sm">
		<thead>
			<tr>
				<th>#게시물번호</th>
				<th>일정번호</th>
				<th>게시물명</th>
				<th>최초작성일</th>
				<th>최종수정일</th>
				<th>공개여부</th>
				<th>대표사진</th>
			</tr>
			</thead>
			
			<c:forEach items="${list}" var="board">
			<tr>
				<td><a class='move' href='/board/get?schNo=<c:out value="${board.schNo}"/>&boardNo=<c:out value="${board.boardNo }"/>
				&pageNum=<c:out value="${pageMaker.cri.pageNum }"/>&amount=<c:out value="${pageMaker.cri.amount }"/>'>
				<c:out value="${board.boardNo }"/></a></td>
				<td><c:out value="${board.schNo }"/></td>
				<td><c:out value="${board.boardTitle }"/></td>
				<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.WDate}"/></td>
				<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.modDate}"/></td>
				<td><c:out value="${board.hidden }"/></td>
				<td><img class="orgImg" src="<c:out value='${board.boardImg}'/>"/></td> 
				</tr>
		</c:forEach>
	</table>
	<form id='actionForm' action="/board/list" method='get'>
		<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum }'>
		<input type='hidden' name='amount' value='${pageMaker.cri.amount }'>
	</form>

			<div class='pull-right'>
				<ul class="pagination">

					<c:if test="${pageMaker.prev }">
						<li class="paginate_button previous"><a
							href="${pageMaker.startPage-1 }">Previous</a></li>
					</c:if>

					<c:forEach var="num" begin="${pageMaker.startPage }"
						end="${pageMaker.endPage }">
						 <li class="paginate_button ${pageMaker.cri.pageNum==num?"active":""}">
							<a href="${num }" class="abutton">${num }</a>
						</li>
					</c:forEach>

					<c:if test="${pageMaker.next }">
						<li class="paginate_button next"><a
							href="${pageMaker.endPage+1 }">Next</a></li>
					</c:if>
				</ul>
			</div>
			<!--  end pagination -->
				<!-- Modal -->
				<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
					aria-labelledby="myModalLabel" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal"
									aria-hidden="true">&times;</button>
								<h4 class="modal-title" id="myModalLabel">Modal title</h4>
							</div>
							<div class="modal-body">처리가 완료되었습니다.</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-default"
									data-dismiss="modal">Close</button>
								<button type="button" class="btn btn-primary">Save
									changes</button>
							</div>
						</div>
						<!-- /.modal-content -->
					</div>
					<!-- /.modal-dialog -->
				</div>
				<!-- /.modal -->			
			

			<div>
	<button id="regBtn"  class="btn btn-sm-btn-primary">내 일정 공유</button>
	</div>
	</div>
</div>
	

</body>

</html>
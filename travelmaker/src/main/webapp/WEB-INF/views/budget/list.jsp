<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../includes/header.jsp" %>
<%
request.setCharacterEncoding("UTF-8");
String paydate= request.getParameter("pay_date"); %>
            <div class="row">
                <div class="col-lg-12">
                    <h3 class="page-header">경비 내역 - 일정</h3>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            모든 일정 보여주기 <!-- <button id='budgetRegBtn' type="button" class="btn-xs pull-right">일별 경비 등록</button> -->
                        </div> 
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <table width="100%" class="table table-striped table-bordered table-hover" id="dataTables-example">
                                <thead>
                                    <tr>
                                        <th>일정 번호</th>
                                        <th>경비 합계</th>
                                        <th>결제 횟수</th>
                                    </tr>
                                </thead>
                                
                                <c:forEach items="${list}" var="budget">
                                <tr>
                                  <td><a href='/daybud/get?schno=<c:out value="${budget.schno}"/>'> 
                                  <c:out value="${budget.schno}" /></a></td>
                                  <td>₩ <c:out value="${budget.totalpay}" /></td>                
                                  <td> <c:out value="${budget.totalcnt}" /> 건</td>
                                </tr>  
                                </c:forEach>
                            </table>
                            
                                        <!-- Modal 추가 -->
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
                    <button type="button" class="btn btn-default" data-
                    dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary">Save changes</button>
                  </div>
                </div>
                <!-- /.modal-content -->
              </div>
              <!-- /.modal-dialog -->
              </div>
              <!-- /.modal -->
                            
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
            </div>
            <!-- /.row -->
            
<script type="text/javascript">
$(document).ready(function() {

	var result = '<c:out value="${result}"/>';
	
	checkModal(result);
	
	/* history.replaceState({}, null, null); */
	
	function checkModal(result) {
		
		if (result === '' || history.state) {
			return;
		}
		
		if (parseInt(result) > 0) {
			$(".modal-body").html(
				"게시글 " + parseInt(result) + " 번이 등록되었습니다.");
		}
		
		$("#myModal").modal("show");
	}
	
	$("#buddtregBtn").on("click", function() {
		
		self.location = "/buddt/register";
		
	});
	
	$("#daybudregBtn").on("click", function() {
		
		self.location = "/daybud/register";
		
	});
	
	$("#budgetRegBtn").on("click", function() {
		
		self.location = "/budget/register";
		
	});
	
});
</script>
            
<%@include file="../includes/footer.jsp" %>
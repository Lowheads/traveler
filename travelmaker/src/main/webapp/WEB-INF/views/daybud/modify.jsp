<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp"%>


<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">&nbsp경비 상세내역 수정/삭제</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
		
			<div class="panel-heading">&nbsp경비 상세내역 수정/삭제</div>
			<!-- /.panel-heading -->
			<div class="panel-body">
			
			<form role="form" action="/buddt/modify" method="post">
			
<%-- 			<!-- p.319 -->
			<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum }"/>'>
			<input type='hidden' name='amount' value='<c:out value="${cri.amount }"/>'>
			<!-- p.346 -->
			<input type='hidden' name='type' value='<c:out value="${cri.type }"/>'>
			<input type='hidden' name='keyword' value='<c:out value="${cri.keyword }"/>'> --%>
			
					<div class="form-group">
						<label>no</label> <input class="form-control" name='no'
						  value='<c:out value="${buddt.no }"/>' readonly="readonly">
					</div>
					
					<div class="form-group">
					  <label>paydate</label> 
					  <%-- <input class="form-control" name='paydate'
						  value='<c:out value="${buddt.paydate }"/>' readonly="readonly"> --%>
							<input type="date" class="form-control" name='paydate'
							value='<c:out value="${buddt.paydate }"/>' readonly="readonly">
					</div>
					
					<div class="form-group">
					  <label>schno</label> <input class="form-control" name='schno'
						  value='<c:out value="${buddt.schno }"/>' readonly="readonly">
					</div>
					
					<div class="form-group">
					  <label>store</label> <input class="form-control" name='store'
						  value='<c:out value="${buddt.store }"/>' >
					</div>
					
					<div class="form-group">
					  <label>expense</label> <input class="form-control" name='expense'
						  value='<c:out value="${buddt.expense }"/>' >
					</div>
					
					<div class="form-group">
					  <label>budcate</label> <input class="form-control" name='budcate'
						  value='<c:out value="${buddt.budcate }"/>' >
					</div>
					
<%-- 					<div class="form-group">
					  <label>Text area</label>
					  <textarea class="form-control" rows="3" name='content' ><c:out
					value="${buddt.content}" /></textarea>
					</div>
					
					<div class="form-group">
					  <label>RegDate</label> 
					  <input class="form-control" name='regDate'
					    value='<fmt:formatDate pattern = "yyyy/MM/dd" value = "${buddt.
					    regdate}" />'  readonly="readonly">
					</div>
					
					<div class="form-group">
					  <label>Update Date</label> 
					  <input class="form-control" name='updateDate'
					    value='<fmt:formatDate pattern = "yyyy/MM/dd" value = "${buddt.
					updateDate}" />'  readonly="readonly">
					</div> --%>
					
					
					<button type="submit" data-oper='modify'
					   class="btn btn-default">수정</button>
					
					<button type="submit" data-oper='remove' 
						class="btn btn-danger">삭제</button>
					
					<button type="submit" data-oper='list' 
						class="btn btn-info">목록</button>
					
					</form>	
					
			</div>
			<!-- end panel-body -->
			
		</div>
		<!-- end panel-body -->
	</div>
	<!-- end panel -->
</div>
<!-- /.row -->

<script type="text/javascript">
$(document).ready(function() {
	
	var formObj = $("form");
	
	$('button').on("click", function(e){
	
		e.preventDefault();
		
		var operation = $(this).data("oper");
		
		console.log(operation);
		
		if(operation === 'remove'){
			formObj.attr("action", "/buddt/remove");
			
		}else if(operation === 'list'){
			// move to list
			self.location= "/buddt/list";
			return;
/* 			formObj.attr("action", "/buddt/list").attr("method","get");
			
			var pageNumTag = $("input[name='pageNum']").clone();
			var amountTag = $("input[name='amount']").clone();
			var keywordTag = $("input[name='keyword']").clone();
			var typeTag = $("input[name='type']").clone();
			
			formObj.empty();
			
			formObj.append(pageNumTag);
			formObj.append(amountTag);
			formObj.append(keywordTag);
			formObj.append(typeTag); */
		}
		formObj.submit();
	});
});
</script>

<%@include file="../includes/footer.jsp"%>

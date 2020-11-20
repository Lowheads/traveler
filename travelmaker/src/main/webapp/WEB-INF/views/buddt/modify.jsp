<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header2.jsp"%>


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
						<label>#no </label> <input class="form-control" name='no'
						  value='<c:out value="${buddt.no }"/>' readonly="readonly">
					</div>
					
					  <%-- <input class="form-control" name='pay_date'
						  value='<c:out value="${buddt.pay_date }"/>' readonly="readonly"> --%>
					<div class="form-group">
					  <label>결제한 날짜 (PK,FK)</label> 
							<input class="form-control" name='paydate'
							value='<c:out value="${buddt.paydate }"/>' readonly="readonly">
					</div>
					
					<div class="form-group">
					  <label>일정 번호 (PK,FK)</label> <input class="form-control" name='schno'
						  value='<c:out value="${buddt.schno }"/>' readonly="readonly">
					</div>
					
					<div class="form-group">
					  <label>가게 이름</label> <input class="form-control" name='store'
						  value='<c:out value="${buddt.store }"/>' 
						  type="text" onkeyup="specialCharRemove(this)" maxlength="15" required>
					</div>
					
					<div class="form-group">
					  <label>금액</label> <input class="form-control" name='expense'
						  value='<c:out value="${buddt.expense }"/>' 
						  type="text" onkeyup="onlyInsertNum(this)" maxlength="7" required>
					</div>
					
					<div class="form-group">
					  <label>카테고리</label> <input class="form-control" name='budcate'
						  value='<c:out value="${buddt.budcate }"/>' 
						  type="text" onkeyup="specialCharRemove(this)" maxlength="5" required>
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

	$('button').on("click", function(e) {

		e.preventDefault();

		var operation = $(this).data("oper");

		console.log(operation);

		if (operation === 'remove') {
			formObj.attr("action", "/buddt/remove");

		} else if (operation === 'list') {
			// move to list
			formObj.attr("action", "/budget/list").attr("method", "get");
			formObj.empty();

		}
		formObj.submit();
	});
});

function specialCharRemove(obj) { // 특수문자 제외 (한글 허용)
	var val = obj.value;
	var pattern = /[^(가-힣ㄱ-ㅎㅏ-ㅣa-zA-Z0-9)]/gi;
	if (pattern.test(val)) {
		obj.value = val.replace(pattern, "");
	}
}

function onlyInsertNum(obj) { // 숫자만 허용
	var valcom;
    var val = obj.value;
    var pattern = /[^(0-9)]/gi;
    if(pattern.test(val)){
    	obj.value = val.replace(pattern,"");
    }
}

function numberWithCommas(x) { // 안 씀
	return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

function getExpenseNum(obj) { // 안 씀
	var n1;
	var n2;
	n1 = obj.value;
	n2 = n1.replace(/\D/g, "");

	n1 = setComma(n2);
	obj.value = n1;
}

function setComma(n) { // 위에랑 세트, 안 씀
	var reg = /(^[+-]?\d+)(\d{3})/;
	n += '';
	while (reg.test(n)) {
		n = n.replace(reg, '$1' + ',' + '$2');
	}
	return n;
}

</script>

<%@include file="../includes/footer.jsp"%>

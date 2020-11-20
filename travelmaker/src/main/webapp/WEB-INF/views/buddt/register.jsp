<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp"%>


<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">경비 상세 입력</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
		
			<div class="panel-heading">경비 상세 입력</div>
			<!-- /.panel-heading -->
			<div class="panel-body">
			
				<form role="form" action="/buddt/register" method="post">

					<div class="form-group"> <!-- 시퀀스 처리 -->
						<label>#no </label> <input type="hidden" class="form-control" name='no'
						type="text" onkeyup="onlyInsertNum(this)">
					</div>

					<div class="form-group"> <!-- 셀렉트 박스 처리 (기존 있는 일정에서 선택 하도록) -->
						<label>일정 번호 (PK,FK)</label> <input class="form-control" name='schno'
						type="text" onkeyup="onlyInsertNum(this)" required>
					</div>

					<div class="form-group">
						<label>결제한 날짜 (PK,FK)</label>
						<input type="date" class="form-control" name='paydate'/>
					</div>

					<div class="form-group">
						<label>가게 이름</label> <input class="form-control" name='store'
						type="text" onkeyup="specialCharRemove(this)" maxlength="15" required>
					</div>

					<div class="form-group"> <!-- 정규식 숫자만 -->
						<label>금액</label> <input class="form-control" name='expense'
						type="text" onkeyup="onlyInsertNum(this)" maxlength="7" required>
					</div>

					<div class="form-group"> <!-- 어차피 셀렉트 박스 (기존 있는 카테고리에서 선택 하도록) -->
						<label>카테고리</label> <input class="form-control" name='budcate'
						type="text" onkeyup="specialCharRemove(this)" maxlength="5" required>
					</div>
					
					<button type="submit" class="btn btn-default">등록</button>
					<button type="reset" class="btn btn-default">초기화</button>
					
					</form>
					
			</div>
			<!-- end panel-body -->
		</div>
		<!-- end panel -->
	</div>
</div>
<!-- /.row --> 

<!-- 1 일정 번호 pk , 일정명 ok / sdfas카테고리 >>>> 셀렉트 박스 >>>> 2 시퀀스 -->  

<script>

function specialCharRemove(obj) { // 특수문자 제외 (한글 허용)
    var val = obj.value;
    var pattern = /[^(가-힣ㄱ-ㅎㅏ-ㅣa-zA-Z0-9)]/gi;
    if(pattern.test(val)){
        obj.value = val.replace(pattern,"");
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

function onlyInsertNum2(obj) { // 숫자만 허용 (콤마), 안 씀
	var valcom;
    var val = obj.value;
    var pattern = /[^(0-9)]/gi;
    if(pattern.test(val)){
        valcom = val.replace(pattern,"");
        val = numberWithCommas(valcom);
        obj.value = val;
    }
}

function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

function getExpenseNum(obj){
    var n1;
    var n2;
    n1 = obj.value;
    n2 = n1.replace(/\D/g,""); 

    n1 = setComma(n2); 
    obj.value = n1;
}

function setComma(n) {
    var reg = /(^[+-]?\d+)(\d{3})/;   // 정규식
    n += '';                          // 숫자를 문자열로 변환         
    while (reg.test(n)) {
       n = n.replace(reg, '$1' + ',' + '$2');
    }         
    return n;
}
	

</script>

<%@include file="../includes/footer.jsp"%>

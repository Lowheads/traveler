<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header2.jsp"%>


<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">경비 상세 입력</h1>
	</div>
</div>

<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">

			<div class="panel-heading">경비 상세 입력</div>
			<!-- /.panel-heading -->
			<div class="panel-body">

				<form role="form" action="/buddt/register" method="post">

					<!-- 시퀀스 처리되어 필드에 보여지지 않아도 괜찮습니다!
					<div class="form-group"> 
						<label>#no </label> <input type="hidden" class="form-control" name='no'
						type="text" onkeyup="onlyInsertNum(this)">
					</div> -->

					<div class="form-group">
						<label>일정 선택</label> &nbsp <select name="schno"
							onChange="schnocheck()">
							<br>
							<c:forEach items="${box}" var="box">
								<option value="<c:out value="${box.schno}" />"><c:out
										value="${box.schno}" /></option>
							</c:forEach>
						</select> <input class="form-control" type="hidden" name="schno2">
					</div>

					<div class="form-group">
						<label>날짜 선택</label> <input type="date" id="myDate"
							class="form-control" name='paydate' min=${buddt.minDate }
							max=${buddt.maxDate } required>
					</div>

					<div class="form-group">
						<label>가게 이름</label> <input class="form-control" name='store'
							type="text" onkeyup="specialCharRemove(this)" maxlength="15"
							required>
					</div>

					<div class="form-group">
						<!-- 정규식 숫자만 -->
						<label>금액</label> <input class="form-control" name='expense'
							type="text" onkeyup="onlyInsertNum(this)" maxlength="7" required>
					</div>

					<div class="form-group">
						<label>카테고리</label> &nbsp <select name="budcate"
							onChange="schnocheck()">
							<br>
							<option value="음식점">음식점</option>
							<option value="카페">카페</option>
							<option value="활동">활동</option>
							<option value="기타">기타</option>
						</select> <input class="form-control" type="hidden" name="schno2">
					</div>

					<button type="submit" class="btn btn-default">등록</button>
					<button type="reset" class="btn btn-default">초기화</button>
					<button type="button" onclick="goBack();">목록</button>

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
	/* 데이트 타입의 공백 체크 */
	function myFunction() {
		var x = document.getElementById("myDate").required;
		document.getElementById("demo").innerHTML = x;
	}

	/* 목록 버튼 선택 시 뒤로 가기 */
	function goBack() {
		window.history.back();
	}

	/* 특수문자를 방지 합니다. 한글만 허용되도록 합니다. 공백 추가 되도록 해야합니다! */
	function specialCharRemove(obj) {
		var val = obj.value;
		var pattern = /[^(가-힣ㄱ-ㅎㅏ-ㅣa-zA-Z0-9)]/gi;
		if (pattern.test(val)) {
			obj.value = val.replace(pattern, "");
		}
	}

	/* 숫자만 허용되도록 합니다. */
	function onlyInsertNum(obj) {
		var valcom;
		var val = obj.value;
		var pattern = /[^(0-9)]/gi;
		if (pattern.test(val)) {
			obj.value = val.replace(pattern, "");
		}
	}

	/* 생성되어 있는 일정만 선택 가능하도록 합니다. */
	function schnocheck() {
		i = document.join.schno.selectedIndex
		var mail = document.join.schno.options[i].value
		document.join.schno2.value = mail
	}

	/* (현재 적용되어 있지 않음) */
	/* 1-1 숫자 입력 시에 3번째 자리마다 콤마가 실시간으로 입력되도록 합니다. */
	function onlyInsertNum2(obj) {
		var valcom;
		var val = obj.value;
		var pattern = /[^(0-9)]/gi;
		if (pattern.test(val)) {
			valcom = val.replace(pattern, "");
			val = numberWithCommas(valcom);
			obj.value = val;
		}
	}
	/* 1-2 */
	function numberWithCommas(x) {
		return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}

	/* (현재 적용되어 있지 않음) */
	/* 2-1 숫자 입력 시에 3번째 자리마다 콤마가 실시간으로 입력되도록 합니다. */
	function getExpenseNum(obj) {
		var n1;
		var n2;
		n1 = obj.value;
		n2 = n1.replace(/\D/g, "");

		n1 = setComma(n2);
		obj.value = n1;
	}

	/* 2-2 */
	function setComma(n) {
		var reg = /(^[+-]?\d+)(\d{3})/;
		n += '';
		while (reg.test(n)) {
			n = n.replace(reg, '$1' + ',' + '$2');
		}
		return n;
	}
</script>

<%@include file="../includes/footer.jsp"%>

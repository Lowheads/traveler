<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header2.jsp"%>
<style>
body {
	/*height: 100vh;*/
	margin: 0;
	padding: 0;
}

.rg-modal {
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.7);
	position: absolute;
	top: 0;
	display: flex;
	justify-content: center;
	align-items: center;
	/* display: none; */
}

.rg-modal-content {
	display: flex;
	flex-direction: column;
	width: 300px;
	height: auto;
	background-color: white;
	border-radius: 5px;
	text-align: center;
	/*padding: 0 0 0 0;*/
	position: relative;
	overflow: auto;
	animation-name: modal-open;
	animation-duration: .5s;
}

@
keyframes modal-open {from { transform:translate(0, 100px);
	opacity: .5;
}

to {
	transform: translate(0, 0);
	opacity: 1;
}

}
.close {
	/*position: absolute;*/
	/*top: 0;*/
	/*right: 14px;*/
	font-size: 32px;
	font-weight: lighter;
	transform: rotate(45deg);
	cursor: pointer;
}

.rg-form-group {
	margin-bottom: 10px;
	display: flex;
	align-items: center;
	justify-content: space-between;
}

select {
	-moz-appearance: none;
	-webkit-appearance: none;
	appearance: none;
	font-family: "Noto Sansf KR", sans-serif;
	/*font-size: 1rem;*/
	/*font-weight: 400;*/
	/*line-height: 1.5;*/
	color: #444;
	background-color: #fff;
	padding: .6em 1.4em .5em .8em;
	/*margin-left: 8px;*/
	border: 1px solid #aaa;
	border-radius: .5em;
	box-shadow: 0 1px 0 1px rgba(0, 0, 0, .04);

	/*width: 150px;*/
}

.date {
	width: 150px;
}

.category {
	padding: .6em 1.4em .5em .6em;
}

select:hover {
	border-color: #888;
}

select:focus {
	border-color: #aaa;
	box-shadow: 0 0 1px 3px rgba(59, 153, 252, .7);
	box-shadow: 0 0 0 3px -moz-mac-focusring;
	color: #222;
	outline: none;
}

input {
	font-family: "Noto Sansf KR", sans-serif;
	/*font-size: 1rem;*/
	/*font-weight: 400;*/
	/*line-height: 1.5;*/
	color: #444;
	background-color: #fff;
	padding: .6em .8em .5em .8em;
	/*margin-left: 8px;*/
	border: 1px solid #aaa;
	border-radius: .5em;
	box-shadow: 0 1px 0 1px rgba(0, 0, 0, .04);
	width: 127px;
}

input:hover {
	border-color: #888;
}

input:focus {
	border-color: #aaa;
	box-shadow: 0 0 1px 3px rgba(59, 153, 252, .7);
	box-shadow: 0 0 0 3px -moz-mac-focusring;
	color: #222;
	outline: none;
}

.btn {
	/*display: flex;*/
	/*justify-content: flex-end;*/
	/*flex: 1 1 auto;*/
	margin: 0 10px;
	padding: 10px;
	text-align: center;
	text-transform: uppercase;
	transition: 0.5s;
	background-size: 200% auto;
	color: black;
	text-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);
	/*box-shadow: 0 0 20px #eee;*/
	border-radius: 10px;
	border: none;
	background-color: white;
	/*background-image: linear-gradient(to right, #ffdb6c 0%, #ffc163 51%, #ffffff 100%);*/
	font-size: 15px;

	/*height: 20px;*/
}

.btn:hover {
	background-position: right center;
	/* change the direction of the change here */
}

.btn-1 {
	color: black;
	background-color: #ffffff;
	border: 1px solid #ddd;
}

.btn-2 {
	background-color: #ffffff;
}

.btn-3 {
	color: white;
	background-color: #c7254e;
}

.rg-modal-header {
	border-bottom: 1px solid #ddd;
	align-content: center;
	padding: 5px 0;
}

.rg-modal-header-content {
	display: flex;
	justify-content: space-between;
	margin: 0 20px;
}

.rg-modal-header-content-title {
	display: flex;
	align-self: center;
}

.rg-form {
	padding: 15px 25px;
}

.rg-form-group:last-of-type {
	margin-bottom: 0;
}

.rg-modal-footer {
	background-color: #f3f3f3;
	height: 120px;
	border: 1px solid #ddd;
	display: flex;
	flex-direction: column;
	justify-content: space-evenly;
}

label {
	font-size: 15px;
}
</style>

<div class="rg-modal">
	<!--  모달 안  -->
	<div class="rg-modal-content">
		<!-- X 버튼 -->

		<!-- modal-modal-modal-modal-modal-modal-modal-modal-modal-modal-modal-modal -->
		<div class="rg-modal-header">
			<div class="rg-modal-header-content">
				<div class="rg-modal-header-content-title">
					<div>내역 추가</div>
				</div>
				<div>
					<div class="close">+</div>
				</div>
			</div>
		</div>


		<div>
			<form role="form" action="/buddt/register" method="post">

				<!-- 시퀀스 처리되어 필드에 보여지지 않아도 괜찮다
					<div class="form-group"> 
						<label>#no </label> <input type="hidden" class="form-control" name='no'
						type="text" onkeyup="onlyInsertNum(this)">
					</div> -->

				<div class="rg-form">
					<div class="rg-form-group">
						<div>
							<label>일정</label>
						</div>
						<div style="display: flex; align-self: center;">
							<select name="schno" onChange="schnocheck()">

								<c:forEach items="${schnoBox}" var="schnoBox">
									<option value="<c:out value="${schnoBox.schno}" />"><c:out
											value="${schnoBox.schno}" /></option>
								</c:forEach>
							</select> <input class="form-control" type="hidden" name="schno2">
						</div>
					</div>

					<div class="rg-form-group">
						<div>
							<label>날짜</label>
						</div>
						<div>
							<input type="date" id="myDate" class="form-control"
								name='paydate' value='<c:out value="${paydate }"/>'
								min=${dateBox.minDate } max=${dateBox.maxDate } required>
						</div>
					</div>

					<div class="rg-form-group">
						<div>
							<label>가게</label>
						</div>
						<div>
							<input class="form-control" name='store' type="text"
								onkeyup="specialCharRemove(this)" maxlength="15" required>
						</div>
					</div>

					<div class="rg-form-group">
						<div>
							<label>금액</label>
						</div>
						<div>
							<input class="form-control" name='expense' type="text"
								onkeyup="onlyInsertNum(this)" maxlength="7" required>
						</div>
					</div>

					<div class="rg-form-group">
						<div>
							<label>카테고리</label>
						</div>
						<div>
							<select name="budcate" onChange="schnocheck()">

								<option value="음식점">음식점</option>
								<option value="카페">카페</option>
								<option value="숙박">숙박</option>
								<option value="교통">교통</option>
								<option value="쇼핑">쇼핑</option>
								<option value="활동">활동</option>
								<option value="주점">주점</option>
								<option value="기타">기타</option>
							</select> <input class="form-control" type="hidden" name="schno2">
						</div>
					</div>
				</div>


				<div class="rg-modal-footer">
					<button type="submit" class="btn btn-1">등록</button>
					<!-- <button type="reset" class="btn btn-default">초기화</button> -->
					<button type="button" class="btn btn-3" onclick="goBack();">목록</button>
				</div>
			</form>
		</div>
	</div>
</div>

<script>
	/* Date 타입 공백 체크 - required */
	function myFunction() {
		var x = document.getElementById("myDate").required;
		document.getElementById("demo").innerHTML = x;
	}

	/* 목록 버튼 선택 시 뒤로 가기 */
	function goBack() {
		window.history.back();
	}

	/* 특수문자 방지. 한글만 허용. (공백 허용 예정..) 사용 중! */
	function specialCharRemove(obj) {
		var val = obj.value;
		var pattern = /[^(가-힣ㄱ-ㅎㅏ-ㅣa-zA-Z0-9)]/gi;
		if (pattern.test(val)) {
			obj.value = val.replace(pattern, "");
		}
	}

	/* 숫자만 허용. 사용 중! */
	function onlyInsertNum(obj) {
		var valcom;
		var val = obj.value;
		var pattern = /[^(0-9)]/gi;
		if (pattern.test(val)) {
			obj.value = val.replace(pattern, "");
		}
	}

	/* 생성되어 있는 일정만 선택 가능하도록 처리 */
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
	/* function getExpenseNum(obj) {
		var n1;
		var n2;
		n1 = obj.value;
		n2 = n1.replace(/\D/g, "");

		n1 = setComma(n2);
		obj.value = n1;
	} */

	/* 2-2 */
	/* function setComma(n) {
		var reg = /(^[+-]?\d+)(\d{3})/;
		n += '';
		while (reg.test(n)) {
			n = n.replace(reg, '$1' + ',' + '$2');
		}
		return n;
	} */
</script>

<!-- <%@include file="../includes/footer.jsp"%> -->
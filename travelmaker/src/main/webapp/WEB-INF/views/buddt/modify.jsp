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

        @keyframes modal-open {
            from {
                transform: translate(0, 100px);
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
            background-position: right center; /* change the direction of the change here */
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
            display:flex;
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
	<div class="rg-modal-content">
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
			<form role="form" id="modiremoveform" action="/buddt/modify" method="post">

				<div class="rg-form">
					<div class="rg-form-group">
						<div>
							<label>시퀀스</label>
						</div>
						<div style="display: flex; align-self: center;">
							<input class="form-control" name='no'
								value='<c:out value="${loadVO.no }"/>' readonly="readonly">
						</div>
					</div>

					<div class="rg-form-group">
						<div>
							<label>날짜</label>
						</div>
						<div>
							<input class="form-control" name='paydate' type="Date"
								value='<c:out value="${loadVO.paydate }"/>' min="" max=""
								required>
						</div>
					</div>

					<div class="rg-form-group">
						<div>
							<label>일정</label>
						</div>
						<div>
							<input class="form-control" name='schno'
								value='<c:out value="${loadVO.schno }"/>' readonly="readonly">
						</div>
					</div>
					
					<div class="rg-form-group">
						<div>
							<label>가게 이름</label>
						</div>
						<div>
							<input class="form-control" name='store'
								value='<c:out value="${loadVO.store }"/>' type="text"
								onkeyup="specialCharRemove(this)" maxlength="15" required>
						</div>
					</div>

					<div class="rg-form-group">
						<div>
							<label>금액</label>
						</div>
						<div>
							<input class="form-control" name='expense'
								value='<c:out value="${loadVO.expense }"/>' type="text"
								onkeyup="onlyInsertNum(this)" maxlength="7" id="default"
								required>
						</div>
						<!-- <button type="button" onclick="modify()">차액 확인(임시)</button> -->
					</div>

					<input type="hidden" name="modifiedExpense" id="result">

					<div class="rg-form-group">
						<div>
							<label>카테고리</label>
						</div>
						<div>
							<select id="flag" name="budcate" onChange="schnocheck()" required>
								<option value='<c:out value="${loadVO.budcate }"/>'>선택</option>
								<option value="음식점">음식점</option>
								<option value="카페">카페</option>
								<option value="활동">활동</option>
								<option value="기타">기타</option>
							</select> <input class="form-control" type="hidden" name="schno2">
						</div>
					</div>
				</div>
				
					<div class="rg-modal-footer">
						<button type="submit" data-oper='modify' class="btn btn-1"
							onclick="modify()">수정</button>

						<button type="button" data-oper='remove' class="btn btn-3"
							id="subbutton">삭제</button>

						<button type="button" onclick="goBack();">목록</button>
					</div>
			</form>
		</div>
	</div>
</div>

<script type="text/javascript">
	var expense = '<c:out value="${loadVO.expense }"/>';

	function modify() {
		var modified = document.getElementById('default'); //
		Number(modified.value); // 바뀌는 값

		var result = Number(expense) - Number(modified.value);
		var li = document.getElementById('result').value
		console.log(li)
		document.getElementById('result').value = result
		var li = document.getElementById('result').value
		console.log(li)

		console.log(result);

		alert(document.getElementById('result').value);

		/* alert(expense+"-"+modified.value+"="+(Number(expense)-Number(modified.value))); */

	}

	var formObj = $("#modiremoveform");
	$("#subbutton").on("click", function(e) {
		var operation = $(this).data("oper");
		if (operation === 'remove') {

			formObj.attr("action", "/buddt/remove");
			formObj.submit();
		}
	});

	function goBack() {
		window.history.back();
	}

	$("#flag").val('<c:out value="${buddt.budcate }"/>').prop("selected", true);

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
		if (pattern.test(val)) {
			obj.value = val.replace(pattern, "");
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

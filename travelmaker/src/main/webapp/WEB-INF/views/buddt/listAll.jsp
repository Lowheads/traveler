<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header2.jsp"%>

<style>
/* html {
	box-sizing: border-box;
} */

body {
	font-family: "Noto Sans KR", sans-serif;
	color: black;
	background-color: white;
	margin: 0;
	padding: 0;
	/* line-height: 1.4; */
}

h3 {
	font-size: 1.2em;
	font-weight: normal;
}

.main {
	width: 100vw;
	height: 100vh;
	overflow: scroll;
}

.main.s_no-scroll {
	pointer-events: none;
}

.board {
	width: 100%;
	margin: 0 50px 50px 0;
	white-space: nowrap;
	border-collapse: collapse;
	font-size: 0.9em;
	overflow: hidden;
	border-radius: 0 0 0 0;
	line-height: 1.4;
}

.board thead tr {
	color: black;
	text-align: left;
	font-size: 21px;
	font-weight: bold;
	border-bottom: 2px solid #dddddd;
}

.board th {
	width: 82px;
	font-size: 1.1rem;
	font-weight: 400;
	color:#333333;
	text-align: center;
	padding: 12px 23px;
}

.board td {
	width: 82px;
	font-weight: lighter;
	color: black;
	text-align: center;
	padding: 12px 23px;
}

.board tbody tr {
	font-size: 15px;
	border-bottom: 1px solid #dddddd;
	background-color: white;
}

.board tbody tr:nth-of-type(even) {
	background-color: #fafafa;
}

.board tbody tr:last-of-type {
	border-bottom: 1px #dddddd solid;
}

.budget-data h1 {
	font-size: 40px;
	font-weight: lighter;
}

.budget-progress {
	grid-column: 3/4; 
	grid-row: 2; 
	margin-top:65px;
}

.budget-progress-box-2 {
	margin-top: 10px;
}

.budget-progress p {
	font-size: 25px;
}

.chart-wrapper {
	/* height: 41rem; */
	width: 21rem;
	padding: 2em 2.8em 2.9em 1.6em;
	border: 1px solid #d2d2d2;
	border-radius: 1em;
	box-shadow: /*0 1px 2px rgba(0, 0, 0, 0.07), */
		/*0 2px 4px rgba(0, 0, 0, 0.07), */ /*0 4px 8px rgba(0, 0, 0, 0.07);*/
		0 8px 16px rgba( 0, 0, 0, 0.17);
	/*0 16px 32px rgba(0, 0, 0, 0.7);*/
	/*0 32px 64px rgba(0, 0, 0, 0.07);*/
	background-color: #fff;
}

p {
	font-size: 30px;
	margin: 0;
}

.add-expense-button {
	background-color: white;
	color: #222;
	/*border: 1px solid black;*/
	/*border-radius: 10px;*/
	font-size: 15px;
	font-weight: normal;
	text-align: center;
	padding: 0px 0px 0px 0px;
	cursor: pointer;
	text-decoration: underline;
	border: none;
	margin-left: 8px;
	margin-right: 8px;
	/*transition-duration: 1s;*/
}

.add-expense-button:hover {
	color: black;
	/*background-color: #c8c8c8;*/
	/*transition-duration: 1s;*/
	/*font-weight: bold;*/
}

a {
	color: #444;
	background-color: #fff;
	border: 1px solid #aaa;
	border-radius: .5em;
	box-shadow: 0 1px 0 1px rgba(0, 0, 0, .04);
	text-decoration: none;
	padding: .2em .6em .2em .6em;
}

a:hover {
	border-color: #888;
}

body::-webkit-scrollbar, .modal-content::-webkit-scrollbar {
	width: 0rem;
}

.rg-modal {
	/* margin: 0; */
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.7);
	position: absolute;
	top: 0;
	display: flex;
	justify-content: center;
	align-items: center;
	display: none;
}

.md-modal {
	/* margin: 0; */
	/* max-height: calc(100vh - 210px); */
    /* overflow-y: auto; */
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.7);
	position: absolute;
	top: 0;
	display: flex;
	justify-content: center;
	align-items: center;
	display: none;
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
	bottom: 50px;
}

@keyframes modal-open {from { transform:translate(0, 100px);
	opacity: .5;
}

to {
	transform: translate(0, 0);
	opacity: 1;
}

}

.rg-close {
	/*position: absolute;*/
	/*top: 0;*/
	/*right: 14px;*/
	font-size: 32px;
	font-weight: lighter;
	transform: rotate(45deg);
	cursor: pointer;
}

.md-close {
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

.hidden-select {
	display:none;
}

.hidden-select:hover {
	border-color: #888;
}

.hidden-select:focus {
	border-color: #aaa;
	box-shadow: 0 0 1px 3px rgba(59, 153, 252, .7);
	box-shadow: 0 0 0 3px -moz-mac-focusring;
	color: #222;
	outline: none;
}

.use-select {
	
	-moz-appearance: none;
	-webkit-appearance: none;
	appearance: none;
	font-family: "Noto Sansf KR", sans-serif;
	color: #444;
	background-color: #fff;
	border: 1px solid #aaa;
	border-radius: .5em;
	box-shadow: 0 1px 0 1px rgba(0, 0, 0, .04);
	text-align: center;
	text-align-last: center;
}

.category {
	width: 50px;
	padding: 7px 0 7px 0;
}

.date {
	width: 90px;
	padding: 7px 6px 7px 6px;
}

.use-select:hover {
	border-color: #888;
}

.use-select:focus {
	border-color: #aaa;
	box-shadow: 0 0 1px 3px rgba(59, 153, 252, .7);
	box-shadow: 0 0 0 3px -moz-mac-focusring;
	color: #222;
	outline: none;
}

option {
  text-align: left;
  /* reset to left*/
}

.md-button {
	font-size: 15px;
	color: #444;
	background-color: #fff;
	border: 1px solid #aaa;
	border-radius: .5em;
	box-shadow: 0 1px 0 1px rgba(0, 0, 0, .04);
	text-decoration: none;
	padding: 4px 9px 5px 9px;
	cursor: pointer;
}

.md-button:hover {
	text-decoration: underline;
	border-color: #888;
}

.md-form-input {
	font-family: "Noto Sansf KR", sans-serif;
	color: #444;
	background-color: #fff;
	padding: 5px;
	/*margin-left: 8px;*/
	border: 1px solid #aaa;
	border-radius: .5em;
	box-shadow: 0 1px 0 1px rgba(0, 0, 0, .04);
	width: 125px;
	text-align:right;
}

.md-form-input:hover {
	border-color: #888;
}

.md-form-input:focus {
	border-color: #aaa;
	box-shadow: 0 0 1px 3px rgba(59, 153, 252, .7);
	box-shadow: 0 0 0 3px -moz-mac-focusring;
	color: #222;
	outline: none;
}

.date-input {
	padding:5px;
	width:125px;
}

.md-store {
	width:110px;
}

.md-expense {
	width:110px;
}
.instead-Hidden {
	font-size:15px;
	font-weight:lighter;
}

.placeholder {
	color:#666666;
	border:none;
	padding-right:0;
	text-align:right;
}

.placeholder:focus {
	outline: none;
}

.btn {
	margin: 0 10px;
	padding: 10px;
	text-align: center;
	text-transform: uppercase;
	transition: 0.5s;
	background-size: 200% auto;
	color: black;
	text-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);
	border-radius: 10px;
	border: none;
	background-color: white;*/
	font-size: 15px;
	cursor: pointer;
}

.btn:hover {
	background-position: right center;
}

.btn-1 {
	color: black;
	background-color: #ffffff;
    border: 1px solid #ddd;
}

.btn-3 {
	color: white;
	background-color: #ff812f;
	border: 1px solid #ddd;
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

.chart-div-margin {
	font-weight: lighter;
    margin: 4px 0 0 4px;
}

</style>

<div class="main">
	<div class="wrapper"
		style="display: grid; grid-template-columns: 15% auto auto 15%; grid-template-rows: 20px auto; grid-gap: 1em; justify-items: stretch; justify-content: center;">

		<div class="allocation"
			style="margin-right: 20px; grid-column: 2/3; grid-row: 2/2;">

			<div
				style="display: flex; flex-direction: column; width: 100%; white-space: nowrap; min-width: 500px;">
				<div
					style="display: flex; flex-direction: row; justify-content: space-between; width: auto;">
					<div>
						<h3>모든 지출 내역</h3>
					</div>
					<div style="display: flex; align-items: center;">
						<div>
							<button class="add-expense-button" type="button" id="rg-button"
								style="outline: none;">
								<%-- <c:out value="${paydate }" /> --%>
								내역 추가
							</button>
						</div>
						<!-- <select onchange="window.open(value,'iframe')">
							<option selected value="">&nbsp;&nbsp;&nbsp;&nbsp;날짜 선택
								&#9662;</option>
							<option value="2020-11-03">&nbsp;&nbsp;2020-11-032</option>
						</select> -->
						<!-- 방금 추가 -->
						<select class="use-select date" id="select" onchange="location.href=value">
							<option selected value="">날짜 선택 &#9662;</option>
							<c:forEach items="${daybud}" var="daybud">
								<option
									value="/buddt/list?paydate=<fmt:formatDate value="${daybud.SCH_DATE}" pattern="yyyy-MM-dd"/>
			&schno=<c:out value="${daybud.SCH_NO }"/>"><fmt:formatDate value="${daybud.SCH_DATE}" pattern="yyyy-MM-dd"/>
								</option>
							</c:forEach>
						</select>
					</div>
				</div>
			</div>

			<div class="" style="width: auto;">
				<table class="board">
					<thead>
						<tr>
							
							<th>날짜</th>
							<!-- <th>일정 번호</th> -->
							<th>상호명</th>
							<th>금액</th>
							<th>카테고리</th>
							<th>&#9998;</th>
						</tr>
					</thead>

					<tbody>
						<c:forEach items="${listAll}" var="listAll">
							<tr>
								
								<td><c:out value="${listAll.paydate}" /></td>
								<%-- <td><c:out value="${listAll.schno}" /></td> --%>
								<td><c:out value="${listAll.store}" /></td>
								<td style="display:flex; justify-content:space-around;">
								<div>₩&nbsp;</div> 
								<div><c:out value="${listAll.expense}" /></div>
								</td>
								<td><c:out value="${listAll.budcate}" /></td>
								<td>
								<%-- <a href='/buddt/modify?no=<c:out value="${listAll.no}"/>&paydate=
								<c:out value="${listAll.paydate}"/>&schno=<c:out value="${listAll.schno}"/>'>
									&#9998;
								</a> --%>
								<!-- <button id="md-button">&#9998;</button> -->
								<button class="md-button" id = <c:out value="${listAll.no}" />>&#9998;</button>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>


		<div class="budget-progress">

			<div class="chart-wrapper"
				style="display: flex; flex-direction: column; position: sticky; top: 20px;">
				<div>
					<p>차트</p>
				</div>

				<div class="budget-progress-box-2">
					<div>
						<label style="font-weight: lighter;">카테고리별 지출</label>
						<canvas id="myChartOne" width="350vw" height="350vh"
							style="display: flex; justify-self: center;"></canvas>
					</div>
				</div>

				<div id="budget-progress-box"
					style="display: flex; justify-content: flex-start; margin-top: 12px;">
					<div class="budget-progress-box-1" style="white-space: nowrap">
						<div>
							<div class="progress-label">
								<p style="font-size: 17px; font-weight: normal;">날짜</p>
							</div>
							<div class="row-row-row">
								<div class="chart-div-margin">
									<c:out value="${dateBox.minDate }" />
									~
									<c:out value="${dateBox.maxDate }" />
								</div>
								<div id="unallocated"></div>
							</div>
							<!--                        <input type="text" id="unallocated" style="border: 0px;" value="￦ 0" readonly>-->
						</div>
						<br>
						<div>
							<p style="font-size: 17px;">지출</p>
							<!--                        <div class="progress-label">지출</div>-->
							<div class="row-row-row">
								<div></div>
								<div id="totalSpent" class="chart-div-margin">
									￦
									<c:out value="${chartTextByListAll.daypay}" />
								</div>
							</div>
							<!--                        <input type="text" id="totalSpent" value="￦ 0" readonly>-->
						</div>
						<br>
						<div>
							<p style="font-size: 17px;">결제 건수</p>
							<div class="row-row-row">
								<div id="totalRemaining"></div>
								<div class="chart-div-margin">
									<c:out value="${chartTextByListAll.daycnt}" />
									건
								</div>
							</div>
							<!--                        <input type="text" id="totalRemaining" value="￦ 0" readonly>-->
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<div class="rg-modal">
		<div class="rg-modal-content">
			<div class="rg-modal-header">
				<div class="rg-modal-header-content">
					<div class="rg-modal-header-content-title">
						<div>내역 추가</div>
					</div>
					<div>
						<div class="rg-close">+</div>
					</div>
				</div>
			</div>

			<div>
				<form role="form" action="/buddt/register" method="post">
					<div class="rg-form">
						<div class="rg-form-group">
							<div style="width:100%; display:flex; flex-direction:row; 
								justify-content:space-between;">
								<div>
									<label>일정</label>
								</div>
								<div class="placeholder">
									<input class="placeholder" value='<c:out value="${schtitle.schtitle }" />'>
								</div>
							</div>
							<div style="display: hidden; align-self: center;">
								<select class="hidden-select" name="schno" onChange="schnocheck()">
									<%-- <c:forEach items="${schnoBox}" var="schnoBox"> --%>
										<option value="<c:out value="${schno}" />">
											<c:out value="${schno}" />
										</option>
									<%-- </c:forEach> --%>
								</select> <input class="form-control" type="hidden" name="schno2">
							</div>
						</div>

						<div class="rg-form-group">
							<div>
								<label>날짜</label>
							</div>
							<div>
								<input type="date" id="myDate" class="md-form-input date-input"
									name='paydate' value='<c:out value="${paydate }"/>'
									min=${dateBox.minDate } max=${dateBox.maxDate } required>
							</div>
						</div>

						<div class="rg-form-group">
							<div>
								<label>상호명</label>
							</div>
							<div>
								<input class="md-form-input" name='store' type="text"
									onkeyup="specialCharRemove(this)" maxlength="15" required>
							</div>
						</div>

						<div class="rg-form-group">
							<div>
								<label>금액</label>
							</div>
							<div>
								<input class="md-form-input" name='expense' type="text"
									onkeyup="getExpenseNum(this)" maxlength="7" required>
							</div>
						</div>

						<div class="rg-form-group">
							<div>
								<label>카테고리</label>
							</div>
							<div>
								<select class="use-select category" name="budcate" onChange="schnocheck()">

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
						<button type="button" class="btn btn-3" onclick="goBack();">뒤로가기</button>
					</div>
				</form>
			</div>

		</div>
	</div>
	
	
	<div class="md-modal">
		<div class="rg-modal-content">
			<div class="rg-modal-header">
				<div class="rg-modal-header-content">
					<div class="rg-modal-header-content-title">
						<div>내역 수정</div>
					</div>
					<div>
						<div class="md-close">+</div>
					</div>
				</div>
			</div>

			<div>
				<form role="form" id="modiremoveform" action="/buddt/modify"
					method="post">

					<div class="rg-form">
						<div class="rg-form-group">
							<div style="width:100%; display:flex; flex-direction:row; 
								justify-content:space-between;">
								<div>
									<label>일정</label>
								</div>
								<div class="instead-Hidden">
									<input class="placeholder" value='<c:out value="${schtitle.schtitle }" />'>
									
								</div>
							</div>
							<div style="display: flex; align-self: center;">
								<input class="form-control dtInput" name='no'
									value='<c:out value="${loadVO.no }"/>' readonly="readonly" type="hidden">
							</div>
						</div>

						<div class="rg-form-group">
							<div style="width:100%; display:flex; flex-direction:row; 
								justify-content:space-between;">
								<div>
									<label>날짜</label>
								</div>
							</div>
							<div>
							<%-- 	<input class="form-control dtInput" name='paydate' type="Date"
									value='<c:out value="${loadVO.paydate }"/>' min="" max=""
									required> --%>
									<input class="placeholder dtInput" name='paydate'
									readonly="readonly">
							</div>
						</div>

						<div class="rg-form-group" style="display:none;">
							<div>
								<label>일정</label>
							</div>
							<div>
								<input class="form-control dtInput" name='schno'
									value='<c:out value="${loadVO.schno }"/>' readonly="readonly">
							</div>
						</div>

						<div class="rg-form-group">
							<div>
								<label>상호명</label>
							</div>
							<div>
								<input class="md-form-input dtInput md-store" name='store'
									value='<c:out value="${loadVO.store }"/>' type="text"
									onkeyup="specialCharRemove(this)" maxlength="15">
							</div>
						</div>

						<div class="rg-form-group">
							<div>
								<label>금액</label>
							</div>
							<div>
								<input class="md-form-input dtInput md-expense" name='expense'
									value='<c:out value="${loadVO.expense }"/>' type="text"
									onkeyup="getExpenseNum(this)" maxlength="7" id="default" required>
							</div>
							<!-- <button type="button" onclick="modify()">차액 확인(임시)</button> -->
						</div>

						<input type="hidden" name="modifiedExpense" id="result">
						
						<!-- <input type="hidden" class="dtInput" name="modifiedExpense" id="result">
 -->
						<div class="rg-form-group">
							<div>
								<label>카테고리</label>
							</div>
							<div>
							<!-- 	<select id="flag" class="dtInput" name="budcate" onChange="schnocheck()"> -->
								<select id="flag" class="dtInput use-select category" name="budcate">
									<option value='<c:out value="${loadVO.budcate }"/>'>선택 &#9662;</option>
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
						<!-- <button type="submit" data-oper='modify' class="btn btn-1"
							onclick="modify()">수정</button> -->
							<!-- <button type="submit" data-oper='modify' class="btn btn-1">수정</button> -->						
							<!-- <button data-oper='modify' id = "sendForm" class="btn btn-1">수정</button> -->
						<!-- 	<button data-oper='modify' id = "sendForm" class="btn btn-1" onclick="return send()" >수정</button>  -->
							<button class="btn btn-1" type="button" id="sendForm" onclick="send(event);">수정</button>
						<button type="button" data-oper='remove' class="btn btn-3"
							id="subbutton" onclick="remove(event);">삭제</button>

						<!-- <button type="button" onclick="goBack();">목록</button> -->
					</div>
				</form>
			</div>
		</div>
	</div>
	
</div>
<!-- wrapper end -->

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.6.0/Chart.min.js"></script>

<script>
	let myChartOne = document.getElementById('myChartOne').getContext('2d');

	let barChart = new Chart(myChartOne, {
		type : 'bar',
		data : {

			labels : [ '음식', '카페', '숙박', '교통', '쇼핑', '활동', '주점', '기타' ],
			datasets : [ {
				label : '매출액',
				data : [ '${restaurantBudget}', '${cafeBudget}',
						'${lodgingBudget}', '${transBudget}',
						'${shoppingBudget}', '${activityBudget}',
						'${entertainmentBudget}', '${etcBudget}'

				],
				backgroundColor : [ "rgba(255, 99, 132, 0.4)",
						"rgba(54, 162, 235, 0.4)", "rgba(255, 206, 86, 0.4)",
						"rgba(75, 192, 192, 0.4)", "rgba(153, 102, 255, 0.4)",
						"rgba(255, 159, 64, 0.4)", "rgba(255, 102, 255, 0.4)",
						"rgba(204,204,204,0.4)" ],
				borderColor : [ "rgba(255, 99, 132, 1)",
						"rgba(54, 162, 235, 1)", "rgba(255, 206, 86, 1)",
						"rgba(75, 192, 192, 1)", "rgba(153, 102, 255, 1)",
						"rgba(255, 159, 64, 1)", "rgba(255, 102, 255, 1)",
						"rgba(204,204,204, 0.7)" ],
				borderWidth : 1
			} ]
		},
		options : {
			responsive : false,
			legend : {
				display : false,
				position : 'top' // right, left, bottom, top
			},
			tooltips : {
				enabled : true
			},
			layout : {
				padding : {
					left : 10,
					right : 10,
					top : 10,
					bottom : 0
				}
			}
		}
	});
</script>

<script>
	document.getElementById('rg-button').addEventListener('click', function() {
		document.querySelector('.rg-modal').style.display = 'flex';
	});

	document.querySelector('.rg-close').addEventListener('click', function() {
		document.querySelector('.rg-modal').style.display = 'none';
	})
 
let btn = document.getElementsByClassName('md-button');

$("button[class=md-button]").click(function(){
	
	const id = $(this).attr("id");
	
			
			$.getJSON("/buddt/getDetail/"+id+".json",
					function(data){
				
				let form = $("form[id=modiremoveform]")[0];
				
				let target = form.children[0].children;
				
				let date = new Date(data.paydate);
				let dateStr = date.getFullYear()+"년 "+(date.getMonth()+1)+"월 "+date.getDate()+"일";
				
				target[0].children[1].children[0].setAttribute("placeholder", data.no)
				target[1].children[1].children[0].setAttribute("placeholder",dateStr)
				target[2].children[1].children[0].setAttribute("placeholder",data.schno)
				target[3].children[1].children[0].setAttribute("placeholder",data.store)
				target[4].children[1].children[0].setAttribute("placeholder",data.expense)
				target[6].children[1].children[0].setAttribute("placeholder",data.budcate)
				
				
				target[0].children[1].children[0].val = data.no
				target[1].children[1].children[0].val = data.paydate
				target[2].children[1].children[0].val = data.schno
				target[3].children[1].children[0].val = data.store
				target[4].children[1].children[0].val = data.expense
				target[6].children[1].children[0].val = data.budcate
				
				
				
				
				 document.querySelector('.md-modal').style.display = 'flex';
				document.querySelector('.md-close').addEventListener('click',
					    function () {
					        document.querySelector('.md-modal').style.display = 'none';
					    })
					    
					    
			}).fail(function(){
				
				alert("fail")
			})

})

function send(event){
	
	var operForm = $("#modiremoveform");
	
	let form = $("form[id=modiremoveform]")[0];
		
		let target = $(".dtInput");
		
		 for(let i =0;i<6;i++){
			
			if((target[i].val!=target[i].value)&&(target[i].value !="")){
				
				target[i].val = target[i].value;
			}
		} 

		 let buddt = {};
		 buddt = {
				 no : target[0].val,
				 paydate : new Date(target[1].val),
				 schno : target[2].val,
				 store : target[3].val,
				 expense : target[4].val.replace(/\,/g, ""),
				 budcate : target[5].val 
		 };
			 
		
		  var jsonData = JSON.stringify(buddt);

		event.preventDefault();
		
		 $.ajax({url:"/buddt/modify", 
				data: jsonData,
				type:'POST',
				contentType:"application/json;charset=utf-8",
				success:function(data){
					location.reload(true); 
				}
		})
		 
		
}

function remove(event){
	
	event.preventDefault();
	
	let target = $(".dtInput");
	
	 let buddt = {};
	 buddt = {
			 no : target[0].val,
			 schno : target[2].val,
			 expense : target[4].val
	 };
	 
	  var jsonData = JSON.stringify(buddt);

	 $.ajax({url:"/buddt/remove", 
			data: jsonData,
			type:'POST',
			contentType:"application/json;charset=utf-8",
			success:function(data){
				
				location.href= "/buddt/listAll?schno="+target[2].val;
			}
	})
	
}

/* 2-1 숫자 입력 시에 3번째 자리마다 콤마가 실시간으로 입력되도록. */
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
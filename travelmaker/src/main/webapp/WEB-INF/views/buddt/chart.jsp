<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp"%>

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.min.js
"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css"
	integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2"
	crossorigin="anonymous">

<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Song+Myung&display=swap"
	rel="stylesheet">

<!--  나눔명조  -->
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Nanum+Myeongjo&display=swap"
	rel="stylesheet">

<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=East+Sea+Dokdo&display=swap"
	rel="stylesheet">

<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Nanum+Gothic:wght@400;700;800&display=swap"
	rel="stylesheet">

<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Jua&display=swap"
	rel="stylesheet">

<style>
html {
	box-sizing: border-box;
	scroll-behavior: smooth;
}

body {
	font-family: "Noto Sans KR", sans-serif;
	color: black;
	background-color: white;
	margin: 0;
	padding: 0;
	/* line-height: 1.4; */
}

body::-webkit-scrollbar {
	width: 0rem;
}

.allocation-btn {
	height: 36px;
    width: 33px;
	padding: 8px;
	margin-top:4px;
	text-decoration: none;
	border: 1px solid #dddddd;
	border-radius: 3px;
}

.allocation-btn:hover {
	background: #ddd;
}

.a-recommend {
	text-align: center;
	color: #444;
	padding: 18px 0.5rem;
	text-decoration: none;
	background-color: white;
	border: 1px solid #ddd;
	border-radius: 3px;
	cursor: pointer;
	
	display:flex;
	align-self:center;
}

.a-recommend:hover {
	color: #444444;
	border-color: #888;
	text-decoration: none;
}

.main {
	width: 100vw;
	height: auto;
	/*overflow: scroll;*/
}

.wrapper {
	display: grid;
	grid-template-rows: auto auto;
	width: auto;
	grid-gap: 50px;
	margin: 40px 140px;
}

h1 {
	font-family: "Nanum Gothic", sans-serif;
	font-size: 45px;
}

.budget {
	display: flex;
	flex-direction: column;
	padding: 10px;
	background-color: #f8f8f8;
	border: #ddd solid 1px;
	border-radius: 5px;
	justify-items: center;
	align-items: center;
	padding: 0;
}

#average {
	background-color: #f8f8f8;
	font-family: "Nanum Myeongjo", sans-serif;
	font-style: oblique;
	font-size: 25px;
}

.budget-box {
	width: 100%;
	display: grid;
	grid-template-rows: repeat(3, 1fr);
	
	height:250px;
}

.css-for-hr {
	display: flex;
	align-self: center;
}

.line-column {
	border-right: 3px solid #dddddd;
	height: 160px;
}

.budget-box-a {
	display: grid;
	grid-template-rows: repeat(3, 1fr);
	grid-template-columns: 1fr;
	margin: 50px;
	justify-items: center;
	align-items: center;
}

.budget-box-a input {
	margin-top: -5px;
	border: none;
	height: auto;
	width: auto;
	text-align: center;
	font-family: "Nanum Gothic", sans-serif;
	font-size: 29px;
	cursor: pointer;
}

.budget-box-a button {
	padding: 0.5rem 0.5rem;
	text-decoration: none;
	background-color: white;
	border: 1px solid #ddd;
	border-radius: 3px;
}

.budget-box-a button:hover {
	background-color: #ddd;
}

h2 {
	font-size: 25px;
	font-weight: normal;
	margin-bottom: 0px;
}

.budget-box-b {
	display: flex;
	flex-direction: row;
	height: 30px;
	margin: 80px;
	justify-self: center;
	align-self: center;
}

.data-table {
	display: flex;
	flex-direction: row;
	justify-content: space-around;
}

.data-table button {
	background-color: #f1f1f1;
}

.allocation {
	
}

.my-table {
	width: 880px;
	margin: 0 50px 50px 0;
	white-space: nowrap;
	border-collapse: collapse;
	font-size: 0.9em;
	min-width: auto;
	overflow: hidden;
	border-radius: 0 0 0 0;
}

.my-table thead tr {
	color: black;
	text-align: left;
	font-size: 18px;
	font-weight: bold;
	border-bottom: 2px solid #dddddd;
}

.my-table th {
	font-weight: normal;
}

.my-table td {
	font-weight: normal;
}

.my-table th, .my-table td {
	text-align: center;
	padding: 12px 23px;
}

.my-table
    .my-table tbody tr {
	font-size: 15px;
	border-bottom: 1px solid #dddddd;
	background-color: white;
}

.my-table tbody tr:last-of-type {
	border-bottom: 1px #dddddd solid;
}

.in-line-row {
	display: flex;
	justify-content: center;
	align-self: center;
	margin-left: 10px;
}

.in-line-row button {
	border: 1px solid #ddd;
	border-radius: 0 5px 5px 0;
	background-color: white;
	outline: none;
}

.in-line-row input:nth-child(1) {
	border: 1px solid #ddd;
	border-radius: 5px 0 0 5px;
	margin-right: -1px;
	height: 60px;
	background-color: #f1f1f1;
}

.in-line-row input:nth-child(2) {
	width: 200px;
	height: 60px;
	border: 1px solid #ddd;
	margin-right: -1px;
	margin-left: 0;
	text-align: center;
	font-size: 24px;
}

.allocation-sign {
	width: 40px;
	height: 40px;
	border: 1px solid #ddd;
	border-radius: 5px 0 0 5px;
	margin-right: -1px;
	background-color: #f1f1f1;
	text-align: center;
	font-size: 17px;
}

.allocation-input {
	width: 119px;
	height: 40px;
	border: 1px solid #ddd;
	border-radius: 0 5px 5px 0;
	margin-left: 0;
	text-align: center;
	font-weight: lighter;
	font-size: 17px;
}

.actual-row {
	display: flex;
	justify-content: center;
}

.wonSign {
	width: 50px;
	border: none;
	cursor: text;
	padding: 5px;
	text-align: center;
	background-color: #ffffff;
	outline: none;
}

input[type="text"] {
	outline: none;
}

.budget-progress-box-1 {
	display: flex;
	flex-direction: column;
}

.budget-progress input {
	border: none;
	height: auto;
	width: auto;
	font-family: "Nanum Gothic", sans-serif;
	cursor: pointer;
}

.progress-label {
	font-weight: normal;
}

.color-restaurant {
	box-sizing: border-box;
	width: 12px;
	height: 12px;
	background-color: rgba(232, 220, 190, 0.8);
	box-shadow: 0 1px 5px rgba(104, 104, 104, 0.8)
}

.color-cafe {
	box-sizing: border-box;
	width: 12px;
	height: 12px;
	background-color: rgba(75, 52, 47, 0.8);
	box-shadow: 0 1px 5px rgba(104, 104, 104, 0.8)
}

.color-lodging {
	box-sizing: border-box;
	width: 12px;
	height: 12px;
	background-color: rgba(25, 75, 70, 0.8);
	box-shadow: 0 1px 5px rgba(104, 104, 104, 0.8)
}

.color-trans {
	box-sizing: border-box;
	width: 12px;
	height: 12px;
	background-color: rgba(174, 114, 80, 0.8);
	box-shadow: 0 1px 5px rgba(104, 104, 104, 0.8);
}

.color-trans-2 {
	box-sizing: border-box;
	width: 12px;
	height: 12px;
	background-color: rgba(174, 114, 80, 0.8);
	box-shadow: 0 1px 5px rgba(104, 104, 104, 0.8);
}

.color-shopping {
	box-sizing: border-box;
	width: 12px;
	height: 12px;
	background-color: rgba(185, 160, 35, 0.8);
	box-shadow: 0 1px 5px rgba(104, 104, 104, 0.8);
}

.color-activity {
	box-sizing: border-box;
	width: 12px;
	height: 12px;
	background-color: rgba(42, 76, 125, 0.8);
	box-shadow: 0 1px 5px rgba(104, 104, 104, 0.8);
}

.color-entertainment {
	box-sizing: border-box;
	width: 12px;
	height: 12px;
	background-color: rgba(190, 75, 59, 0.8);
	box-shadow: 0 1px 5px rgba(104, 104, 104, 0.8);
}

.color-etc {
	box-sizing: border-box;
	width: 12px;
	height: 12px;
	background-color: rgba(132, 130, 131, 0.8);
	box-shadow: 0 1px 5px rgba(104, 104, 104, 0.8);
}

.row-row-row {
	display: flex;
	flex-direction: row;
}

.a-text {
	color: black;
	text-decoration: underline;
	font-weight:normal;
}
</style>

<div class="main">
	<div class="wrapper">

		<!--  Top Container  -->

		<section class="top-container">

			<header id="myFunds">
				<h1>예산</h1>
			</header>

			<div class="budget">

				<div class="budget-box"
					style="display: flex; justify-content: space-evenly;">

					<div class="budget-box-a">
						<div>
							<h2>예산 그래프 이용하기</h2>
						</div>
						<div>
							<!-- <input type="text" id="average" value="￦ 900,000" readonly> -->
							<p>각 카테고리 항목별로 예산</p>
						</div>
						<div>
							<button class="btn-recommend" onclick="divTest()">사용하기</button>
						</div>
					</div> 
					
					<div class="css-for-hr">
						<hr class="line-column">
					</div>

					<div class="budget-box-b">
						<div>
							<h2>내가 설정한 예산</h2>
						</div>
						<div class="in-line-row">
							<input class="wonSign" type="text" value="￦" readonly> <input
								type="text" id="pb" value="0" onchange="testDiv()"
								onkeyup="inputNumberAutoComma(this)"> <a
								class="a-recommend" onclick="recommend()"
								href="#allocation-main">제안받기</a>
						</div>
					</div>

				</div>

			</div>
			
		</section>

<div  id="allocation-main"></div>

		<section class="data-table">
			<div class="allocation">
				<header>
					<h1>예산 및 소비</h1>
				</header>
				<div>
					<table class="my-table">
						<thead>
							<tr>
								<th>카테고리</th>
								<th>적절한 비용</th>
								<th>나의 비용</th>
								<th>실제 사용 금액</th>
							</tr>
						</thead>
						<tbody>
							<tr id="tr-restaurant">
								<td>
									<div
										style="display: flex; align-items: center; justify-content: center;">
										<div class="color-restaurant"></div>
										&nbsp
										<div>음식</div>
									</div>
								</td>

								<div class="allocate-inline">
									<td>
										<div id="average-restaurant" value="">￦ -</div>
										<button class="allocation-btn" onclick="buttonRestaurant()">
											&#8618;
										</button>
									</td>
								</div>

								<td>
									<div class="actual-row">
										<input class="allocation-sign" type="text" value="￦" readonly>
										<input class="allocation-input" type="text" id="cg-restaurant"
											onchange="addDataForRestaurant()"
											onkeyup="inputNumberAutoComma(this)">
									</div>
								</td>

								<td>
									<div class="actual-row">
										<input class="allocation-sign" type="text" value="￦" readonly>
										<input class="allocation-input" type="text" id="ac-restaurant"
											onchange="addRestaurantAC()"
											onkeyup="inputNumberAutoComma(this)">
									</div>
								</td>

							</tr>
						</tbody>

						<tbody>
							<tr id="tr-cafe">
								<td>
									<div
										style="display: flex; align-items: center; justify-content: center;">
										<div class="color-cafe"></div>
										&nbsp
										<div>카페</div>
									</div>
								</td>

								<div class="allocate-inline">
									<td>
										<div id="average-cafe" value="">￦ -</div>
										<button class="allocation-btn" onclick="buttonCafe()">
											&#8618;
										</button>
									</td>
								</div>

								<td>
									<div class="actual-row">
										<input class="allocation-sign" type="text" value="￦" readonly>
										<input class="allocation-input" type="text" id="cg-cafe"
											onchange="addDataForCafe()"
											onkeyup="inputNumberAutoComma(this)">
									</div>
								</td>

								<td>
									<div class="actual-row">
										<input class="allocation-sign" type="text" value="￦" readonly>
										<input class="allocation-input" type="text" id="ac-cafe"
											onchange="addCafeAC()" onkeyup="inputNumberAutoComma(this)">
									</div>
								</td>

							</tr>
						</tbody>
						<tbody>
							<tr id="tr-lodging">
								<td>
									<div
										style="display: flex; align-items: center; justify-content: center;">
										<div class="color-lodging"></div>
										&nbsp
										<div>숙박</div>
									</div>
								</td>

								<div class="allocate-inline">
									<td>
										<div id="average-lodging" value="">￦ -</div>
										<button class="allocation-btn" onclick="buttonLodging()">
											&#8618;
										</button>
									</td>
								</div>

								<td>
									<div class="actual-row">
										<input class="allocation-sign" type="text" value="￦" readonly>
										<input class="allocation-input" type="text" id="cg-lodging"
											onchange="addDataForLodging()"
											onkeyup="inputNumberAutoComma(this)">
									</div>
								</td>

								<td>
									<div class="actual-row">
										<input class="allocation-sign" type="text" value="￦" readonly>
										<input class="allocation-input" type="text" id="ac-lodging"
											onchange="addLodgingAC()"
											onkeyup="inputNumberAutoComma(this)">
									</div>
								</td>

							</tr>
						</tbody>
						<tbody>
							<tr id="tr-trans">
								<td>
									<div
										style="display: flex; align-items: center; justify-content: center;">
										<div class="color-trans-2"></div>
										&nbsp
										<div>교통</div>
									</div>
								</td>

								<div class="allocate-inline">
									<td>
										<div id="average-trans" value="">￦ -</div>
										<button class="allocation-btn" onclick="buttonTrans()">
											&#8618;
										</button>
									</td>
								</div>

								<td>
									<div class="actual-row">
										<input class="allocation-sign" type="text" value="￦" readonly>
										<input class="allocation-input" type="text" id="cg-trans"
											onchange="addDataForTrans()"
											onkeyup="inputNumberAutoComma(this)">
									</div>
								</td>

								<td>
									<div class="actual-row">
										<input class="allocation-sign" type="text" value="￦" readonly>
										<input class="allocation-input" type="text" id="ac-trans"
											onchange="addTransAC()" onkeyup="inputNumberAutoComma(this)">
									</div>
								</td>
							</tr>
						</tbody>
						<tbody>
							<tr id="tr-shopping">
								<td>
									<div
										style="display: flex; align-items: center; justify-content: center;">
										<div class="color-shopping"></div>
										&nbsp
										<div>쇼핑</div>
									</div>
								</td>

								<div class="allocate-inline">
									<td>
										<div id="average-shopping" value="">￦ -</div>
										<button class="allocation-btn" onclick="buttonShopping()">
											&#8618;
										</button>
									</td>
								</div>

								<td>
									<div class="actual-row">
										<input class="allocation-sign" type="text" value="￦" readonly>
										<input class="allocation-input" type="text" id="cg-shopping"
											onchange="addDataForShopping()"
											onkeyup="inputNumberAutoComma(this)">
									</div>
								</td>

								<td>
									<div class="actual-row">
										<input class="allocation-sign" type="text" value="￦" readonly>
										<input class="allocation-input" type="text" id="ac-shopping"
											onchange="addShoppingAC()"
											onkeyup="inputNumberAutoComma(this)">
									</div>
								</td>
							</tr>
						</tbody>
						<tbody>
							<tr id="tr-activity">
								<td>
									<div
										style="display: flex; align-items: center; justify-content: center;">
										<div class="color-activity"></div>
										&nbsp
										<div>활동</div>
									</div>
								</td>

								<div class="allocate-inline">
									<td>
										<div id="average-activity" value="">￦ -</div>
										<button class="allocation-btn" onclick="buttonActivity()">
											&#8618;
										</button>
									</td>
								</div>

								<td>
									<div class="actual-row">
										<input class="allocation-sign" type="text" value="￦" readonly>
										<input class="allocation-input" type="text" id="cg-activity"
											onchange="addDataForActivity()"
											onkeyup="inputNumberAutoComma(this)">
									</div>
								</td>

								<td>
									<div class="actual-row">
										<input class="allocation-sign" type="text" value="￦" readonly>
										<input class="allocation-input" type="text" id="ac-activity"
											onchange="addActivityAC()"
											onkeyup="inputNumberAutoComma(this)">
									</div>
								</td>
							</tr>
						</tbody>

						<tbody>
							<tr id="tr-Entertainment">
								<td>
									<div
										style="display: flex; align-items: center; justify-content: center;">
										<div class="color-entertainment"></div>
										&nbsp
										<div>주점</div>
									</div>
								</td>

								<div class="allocate-inline">
									<td>
										<div id="average-entertainment" value="">￦ -</div>
										<button class="allocation-btn" onclick="buttonEntertainment()">
											&#8618;
										</button>
									</td>
								</div>

								<td>
									<div class="actual-row">
										<input class="allocation-sign" type="text" value="￦" readonly>
										<input class="allocation-input" type="text"
											id="cg-entertainment" onchange="addDataForEntertainment()"
											onkeyup="inputNumberAutoComma(this)">
									</div>
								</td>

								<td>
									<div class="actual-row">
										<input class="allocation-sign" type="text" value="￦" readonly>
										<input class="allocation-input" type="text"
											id="ac-entertainment" onchange="addEntertainmentAC()"
											onkeyup="inputNumberAutoComma(this)">
									</div>
								</td>
							</tr>
						</tbody>

						<tbody>
							<tr id="tr-etc">
								<td>
									<div
										style="display: flex; align-items: center; justify-content: center;">
										<div class="color-etc"></div>
										&nbsp
										<div>기타</div>
									</div>
								</td>

								<div class="allocate-inline">
									<td>
										<div id="average-etc" value="">￦ -</div>
										<button class="allocation-btn" onclick="buttonEtc()">
											&#8618;
										</button>
									</td>
								</div>

								<td>
									<div class="actual-row">
										<input class="allocation-sign" type="text" value="￦" readonly>
										<input class="allocation-input" type="text" id="cg-etc"
											onchange="addDataForEtc()"
											onkeyup="inputNumberAutoComma(this)">
									</div>
								</td>

								<td>
									<div class="actual-row">
										<input class="allocation-sign" type="text" value="￦" readonly>
										<input class="allocation-input" type="text" id="ac-etc"
											onchange="addEtcAC()" onkeyup="inputNumberAutoComma(this)">
									</div>
								</td>
							</tr>
						</tbody>

					</table>
				</div>
			</div>

			<div class="budget-progress">
				<div>
					<h1>&nbsp</h1>
				</div>
				<div id="budget-progress-box"
					style="display: flex; justify-content: space-evenly;">
					<div class="budget-progress-box-1" style="white-space: nowrap">
						<div>
							<div class="progress-label">
								<a href="#myFunds" class="a-text">설정된 예산 :</a>
							</div>
							<div class="row-row-row">
								<div>￦&nbsp</div>
								<div id="unallocated">0</div>
							</div>
						</div>
						<br>
						<div>
							<div class="progress-label">실제 소비 :</div>
							<div class="row-row-row">
								<div>￦&nbsp</div>
								<div id="totalSpent">0</div>
							</div>
						</div>
						<br>
						<div>
							<div class="progress-label">예산에서의 소비:</div>
							<div class="row-row-row">
								<div>￦&nbsp</div>
								<div id="totalRemaining">0</div>
							</div>
						</div>
					</div>
					<div class="budget-progress-box-2">
						<div class="container">
							<div class="column">
								<div style="font-weight:lighter;">
									나의 예산
									<canvas id="myChart" width="400vw" height="400vh"></canvas>
								</div>
								<div style="font-weight:lighter;">
									실제 사용 금액
									<canvas id="myChartTwo" width="400vw" height="400vh"></canvas>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
	</div>

	<script>
		window.onload = function() {
			myChart.update();
		}

		function calculate() {
			let pb = document.getElementById("pb").value;
			let pbNum = Number(pb.replace(/,/g, ''));
			let a = Number(document.getElementById('cg-restaurant').value
					.replace(/,/g, ''));
			let b = Number(document.getElementById('cg-cafe').value.replace(
					/,/g, ''));
			let c = Number(document.getElementById('cg-lodging').value.replace(
					/,/g, ''));
			let d = Number(document.getElementById('cg-trans').value.replace(
					/,/g, ''));
			let e = Number(document.getElementById('cg-shopping').value
					.replace(/,/g, ''));
			let f = Number(document.getElementById('cg-activity').value
					.replace(/,/g, ''));
			let g = Number(document.getElementById('cg-entertainment').value
					.replace(/,/g, ''));
			let h = Number(document.getElementById('cg-etc').value.replace(
					/,/g, ''));
			let result = Number((pbNum - a - b - c - d - e - f - g - h)
					.toFixed(0).replace(/,/g, ''));

			document.getElementById("unallocated").innerText = String(result)
					.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, "$1,");

			redFunds();
			changeColor();
		}

		function calculateB() {
			let pb = document.getElementById("pb").value;
			let pbNum = Number(pb.replace(/,/g, ''));
			let a = Number(document.getElementById('ac-restaurant').value
					.replace(/,/g, ''));
			let b = Number(document.getElementById('ac-cafe').value.replace(
					/,/g, ''));
			let c = Number(document.getElementById('ac-lodging').value.replace(
					/,/g, ''));
			let d = Number(document.getElementById('ac-trans').value.replace(
					/,/g, ''));
			let e = Number(document.getElementById('ac-shopping').value
					.replace(/,/g, ''));
			let f = Number(document.getElementById('ac-activity').value
					.replace(/,/g, ''));
			let g = Number(document.getElementById('ac-entertainment').value
					.replace(/,/g, ''));
			let h = Number(document.getElementById('ac-etc').value.replace(
					/,/g, ''));
			let result = (pbNum - a - b - c - d - e - f - g - h).toFixed(0);
			let resultB = (a + b + c + d + e + f + g + h).toFixed(0);

			document.getElementById("totalRemaining").innerText = String(result)
					.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, "$1,");
			document.getElementById("totalSpent").innerText = String(resultB)
					.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, "$1,");

			redFunds();
			changeColor();
		}

		function divTest() {
			let average = document.getElementById("average").value;
			document.getElementById("pb").value = average.replace(/￦/g, '');
			testDiv();
		}

		// 내 설정 예산을 설정된 예산으로 옮기는 메서드
		function testDiv() {
			let pb = document.getElementById("pb").value;
			calculate();
			calculateB();
		}

		function redFunds() {
			let unallocated = Number(document.getElementById("unallocated").innerText
					.replace(/,/g, '').trim());
			let totalRemaining = Number(document
					.getElementById("totalRemaining").innerText.replace(/,/g,
					'').trim());

			if (unallocated < 0) {
				document.getElementById("unallocated").style.color = "#ff5e5e";
			} else {
				document.getElementById("unallocated").style.color = "black";
			}

			if (totalRemaining < 0) {
				document.getElementById("totalRemaining").style.color = "#ff5e5e";
			} else {
				document.getElementById("totalRemaining").style.color = "black";
			}
		}

		function recommend() {
			let pb = Number(document.getElementById("pb").value.replace(/,/g,
					''));

			document.getElementById("average-restaurant").innerHTML = "￦ "
					+ String((pb * 0.195).toFixed(0)).replace(
							/(\d)(?=(?:\d{3})+(?!\d))/g, "$1,");
			document.getElementById("average-cafe").innerHTML = "￦ "
					+ String((pb * 0.145).toFixed(0)).replace(
							/(\d)(?=(?:\d{3})+(?!\d))/g, "$1,");
			document.getElementById("average-lodging").innerHTML = "￦ "
					+ String((pb * 0.225).toFixed(0)).replace(
							/(\d)(?=(?:\d{3})+(?!\d))/g, "$1,");
			document.getElementById("average-trans").innerHTML = "￦ "
					+ String((pb * 0.195).toFixed(0)).replace(
							/(\d)(?=(?:\d{3})+(?!\d))/g, "$1,");
			document.getElementById("average-shopping").innerHTML = "￦ "
					+ String((pb * 0.035).toFixed(0)).replace(
							/(\d)(?=(?:\d{3})+(?!\d))/g, "$1,");
			document.getElementById("average-activity").innerHTML = "￦ "
					+ String((pb * 0.155).toFixed(0)).replace(
							/(\d)(?=(?:\d{3})+(?!\d))/g, "$1,");
			document.getElementById("average-entertainment").innerHTML = "￦ "
					+ String((pb * 0.025).toFixed(0)).replace(
							/(\d)(?=(?:\d{3})+(?!\d))/g, "$1,");
			document.getElementById("average-etc").innerHTML = "￦ "
					+ String((pb * 0.025).toFixed(0)).replace(
							/(\d)(?=(?:\d{3})+(?!\d))/g, "$1,");

		}

		function changeColor() {
			let cgRestaurant = Number(document.getElementById("cg-restaurant").value
					.replace(/,/g, ''));
			let acRestaurant = Number(document.getElementById("ac-restaurant").value
					.replace(/,/g, ''));
			let cgCafe = Number(document.getElementById("cg-cafe").value
					.replace(/,/g, ''));
			let acCafe = Number(document.getElementById("ac-cafe").value
					.replace(/,/g, ''));
			let cgLodging = Number(document.getElementById("cg-lodging").value
					.replace(/,/g, ''));
			let acLodging = Number(document.getElementById("ac-lodging").value
					.replace(/,/g, ''));
			let cgTrans = Number(document.getElementById("cg-trans").value
					.replace(/,/g, ''));
			let acTrans = Number(document.getElementById("ac-trans").value
					.replace(/,/g, ''));
			let cgShopping = Number(document.getElementById("cg-shopping").value
					.replace(/,/g, ''));
			let acShopping = Number(document.getElementById("ac-shopping").value
					.replace(/,/g, ''));
			let cgActivity = Number(document.getElementById("cg-activity").value
					.replace(/,/g, ''));
			let acActivity = Number(document.getElementById("ac-activity").value
					.replace(/,/g, ''));
			let cgEntertainment = Number(document
					.getElementById("cg-entertainment").value.replace(/,/g, ''));
			let acEntertainment = Number(document
					.getElementById("ac-entertainment").value.replace(/,/g, ''));
			let cgEtc = Number(document.getElementById("cg-etc").value.replace(
					/,/g, ''));
			let acEtc = Number(document.getElementById("ac-etc").value.replace(
					/,/g, ''));

			if (cgRestaurant < acRestaurant) {
				document.getElementById("tr-restaurant").style.backgroundColor = "#f5dfdf";
			} else {
				document.getElementById("tr-restaurant").style.backgroundColor = "white";
			}

			if (cgCafe < acCafe) {
				document.getElementById("tr-cafe").style.backgroundColor = "#f5dfdf";
			} else {
				document.getElementById("tr-cafe").style.backgroundColor = "white";
			}

			if (cgLodging < acLodging) {
				document.getElementById("tr-lodging").style.backgroundColor = "#f5dfdf";
			} else {
				document.getElementById("tr-lodging").style.backgroundColor = "white";
			}

			if (cgTrans < acTrans) {
				document.getElementById("tr-trans").style.backgroundColor = "#f5dfdf";
			} else {
				document.getElementById("tr-trans").style.backgroundColor = "white";
			}

			if (cgShopping < acShopping) {
				document.getElementById("tr-shopping").style.backgroundColor = "#f5dfdf";
			} else {
				document.getElementById("tr-shopping").style.backgroundColor = "white";
			}

			if (cgActivity < acActivity) {
				document.getElementById("tr-activity").style.backgroundColor = "#f5dfdf";
			} else {
				document.getElementById("tr-activity").style.backgroundColor = "white";
			}

			if (cgEntertainment < acEntertainment) {
				document.getElementById("tr-Entertainment").style.backgroundColor = "#f5dfdf";
			} else {
				document.getElementById("tr-Entertainment").style.backgroundColor = "white";
			}

			if (cgEtc < acEtc) {
				document.getElementById("tr-etc").style.backgroundColor = "#f5dfdf";
			} else {
				document.getElementById("tr-etc").style.backgroundColor = "white";
			}

		}

		function buttonRestaurant() {
			let restaurant = document.getElementById("average-restaurant").innerText
					.replace(/￦/g, '').trim();
			document.getElementById('cg-restaurant').value = restaurant;
			document.getElementById('cg-restaurant').onchange();
			calculate();
		}

		function buttonCafe() {
			let cafe = document.getElementById("average-cafe").innerText
					.replace(/￦/g, '').trim();
			document.getElementById('cg-cafe').value = cafe;
			document.getElementById('cg-cafe').onchange();
			calculate();
		}

		function buttonLodging() {
			let lodging = document.getElementById("average-lodging").innerText
					.replace(/￦/g, '').trim();
			document.getElementById('cg-lodging').value = lodging;
			document.getElementById('cg-lodging').onchange();
			calculate();
		}

		function buttonTrans() {
			let trans = document.getElementById("average-trans").innerText
					.replace(/￦/g, '').trim();
			document.getElementById('cg-trans').value = trans;
			document.getElementById('cg-trans').onchange();
			calculate();
		}

		function buttonShopping() {
			let shopping = document.getElementById("average-shopping").innerText
					.replace(/￦/g, '').trim();
			document.getElementById('cg-shopping').value = shopping;
			document.getElementById('cg-shopping').onchange();
			calculate();
		}

		function buttonActivity() {
			let activity = document.getElementById("average-activity").innerText
					.replace(/￦/g, '').trim();
			document.getElementById('cg-activity').value = activity;
			document.getElementById('cg-activity').onchange();
			calculate();
		}

		function buttonEntertainment() {
			let entertainment = document
					.getElementById("average-entertainment").innerText.replace(
					/￦/g, '').trim();
			document.getElementById('cg-entertainment').value = entertainment;
			document.getElementById('cg-entertainment').onchange();
			calculate();
		}

		function buttonEtc() {
			let etc = document.getElementById("average-etc").innerText.replace(
					/￦/g, '').trim();
			document.getElementById('cg-etc').value = etc;
			document.getElementById('cg-etc').onchange();
			calculate();
		}

		function inputNumberAutoComma(obj) {
			// 콤마( , )의 경우도 문자로 인식되기때문에 콤마 따로 제거
			let deleteComma = obj.value.replace(/\,/g, "");

			// 문자 실시간 제거..wow
			let pattern = /[^(0-9)]/gi;
			if (pattern.test(deleteComma)) {
				obj.value = deleteComma.replace(pattern, "");
			}

			// 기존에 들어가있던 콤마( , )를 제거한 이 후의 입력값에 다시 콤마( , )를 삽입
			obj.value = inputNumberWithComma(inputNumberRemoveComma(obj.value));
		}

		// 천단위 이상의 숫자에 콤마( , )를 삽입하는 함수
		function inputNumberWithComma(str) {
			str = String(str);
			return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, "$1,");
		}

		// 콤마( , )가 들어간 값에 콤마를 제거하는 함수
		function inputNumberRemoveComma(str) {
			str = String(str);
			return str.replace(/[^\d]+/g, "");
		}
	</script>

	<script>
		var ctx = document.getElementById('myChart');
		var myChartTwo = document.getElementById('myChartTwo');

		var myChart = new Chart(ctx, {
			type : 'pie',
			data : {
				labels : [ '음식', '카페', '숙박', '교통', '쇼핑', '활동', '주점', '기타' ],
				datasets : [ {
					label : '# of Votes',
					data : [],
					backgroundColor : [ 'rgba(232, 220, 190, 0.8)',
							'rgba(75, 52, 47, 0.8)', 'rgba(25, 75, 70, 0.8)',
							'rgba(174, 114, 80, 0.8)',
							'rgba(185, 160, 35, 0.8)',
							'rgba(42, 76, 125, 0.8)', 'rgba(190, 75, 59, 0.8)',
							'rgba(132, 130, 131, 0.8)' ],
					borderColor : [ 'rgba(232, 220, 190, 1)',
							'rgba(75, 52, 47, 1)', 'rgba(25, 75, 70, 1)',
							'rgba(174, 114, 80, 1)', 'rgba(185, 160, 35, 1)',
							'rgba(42, 76, 125, 1)', 'rgba(190, 75, 59, 1)',
							'rgba(132, 130, 131, 1)' ],
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

		var myChartTwo = new Chart(myChartTwo, {
			type : 'pie',
			data : {
				labels : [ '음식', '카페', '숙박', '교통', '쇼핑', '활동', '주점', '기타' ],
				datasets : [ {
					label : '# of Votes',
					data : [],
					backgroundColor : [ 'rgba(232, 220, 190, 0.8)',
							'rgba(75, 52, 47, 0.8)', 'rgba(25, 75, 70, 0.8)',
							'rgba(174, 114, 80, 0.8)',
							'rgba(185, 160, 35, 0.8)',
							'rgba(42, 76, 125, 0.8)', 'rgba(190, 75, 59, 0.8)',
							'rgba(132, 130, 131, 0.8)' ],
					borderColor : [ 'rgba(232, 220, 190, 1)',
							'rgba(75, 52, 47, 1)', 'rgba(25, 75, 70, 1)',
							'rgba(174, 114, 80, 1)', 'rgba(185, 160, 35, 1)',
							'rgba(42, 76, 125, 1)', 'rgba(190, 75, 59, 1)',
							'rgba(132, 130, 131, 1)' ],
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

		function addDataForRestaurant(chart) {
			let Data = document.getElementById("cg-restaurant").value;
			Number(Data.replace(/,/g, ''))

			myChart.data.datasets[0].data[0] = Number(Data.replace(/,/g, ''));
			myChart.data.labels[1] = "음식";
			myChart.update();
			calculate();
		}

		function addDataForCafe(chart) {
			let Data = document.getElementById("cg-cafe").value;
			Number(Data.replace(/,/g, ''))

			myChart.data.datasets[0].data[1] = Number(Data.replace(/,/g, ''));
			myChart.data.labels[1] = "카페";
			myChart.update();
			calculate();
		}

		function addDataForLodging(chart) {
			let Data = document.getElementById("cg-lodging").value;
			Number(Data.replace(/,/g, ''))

			myChart.data.datasets[0].data[2] = Number(Data.replace(/,/g, ''));
			myChart.data.labels[1] = "숙박";
			myChart.update();
			calculate();
		}

		function addDataForTrans(chart) {
			let Data = document.getElementById("cg-trans").value;
			Number(Data.replace(/,/g, ''))

			myChart.data.datasets[0].data[3] = Number(Data.replace(/,/g, ''));
			myChart.data.labels[1] = "교통";
			myChart.update();
			calculate();
		}

		function addDataForShopping(chart) {
			let Data = document.getElementById("cg-shopping").value;
			Number(Data.replace(/,/g, ''))

			myChart.data.datasets[0].data[4] = Number(Data.replace(/,/g, ''));
			myChart.data.labels[1] = "쇼핑";
			myChart.update();
			calculate();
		}

		function addDataForActivity(chart) {
			let Data = document.getElementById("cg-activity").value;
			Number(Data.replace(/,/g, ''))

			myChart.data.datasets[0].data[5] = Number(Data.replace(/,/g, ''));
			myChart.data.labels[1] = "활동";
			myChart.update();
			calculate();
		}

		function addDataForEntertainment(chart) {
			let Data = document.getElementById("cg-entertainment").value;
			Number(Data.replace(/,/g, ''))

			myChart.data.datasets[0].data[6] = Number(Data.replace(/,/g, ''));
			myChart.data.labels[1] = "주점";
			myChart.update();
			calculate();
		}

		function addDataForEtc(chart) {
			let Data = document.getElementById("cg-etc").value;
			Number(Data.replace(/,/g, ''))

			myChart.data.datasets[0].data[7] = Number(Data.replace(/,/g, ''));
			myChart.data.labels[1] = "기타";
			myChart.update();
			calculate();
		}

		// TEST2 - GRAPH - TEST2 - GRAPH - TEST2 - GRAPH - TEST2 - GRAPH - TEST2 - GRAPH - TEST2 - GRAPH - TEST2 - GRAPH - TEST2 - GRAPH - TEST2 - GRAPH - TEST2 - GRAPH - TEST2 - GRAPH - TEST2 - GRAPH -
		function addRestaurantAC(chart) {
			let Data = document.getElementById("ac-restaurant").value;
			Number(Data.replace(/,/g, ''))

			myChartTwo.data.datasets[0].data[0] = Number(Data.replace(/,/g, ''));
			myChartTwo.data.labels[1] = "음식";
			myChartTwo.update();
			calculateB();
		}

		function addCafeAC(chart) {
			let Data = document.getElementById("ac-cafe").value;
			Number(Data.replace(/,/g, ''))

			myChartTwo.data.datasets[0].data[1] = Number(Data.replace(/,/g, ''));
			myChartTwo.data.labels[1] = "카페";
			myChartTwo.update();
			calculateB();
		}

		function addLodgingAC(chart) {
			let Data = document.getElementById("ac-lodging").value;
			Number(Data.replace(/,/g, ''))

			myChartTwo.data.datasets[0].data[2] = Number(Data.replace(/,/g, ''));
			myChartTwo.data.labels[1] = "숙박";
			myChartTwo.update();
			calculateB();
		}

		function addTransAC(chart) {
			let Data = document.getElementById("ac-trans").value;
			Number(Data.replace(/,/g, ''))

			myChartTwo.data.datasets[0].data[3] = Number(Data.replace(/,/g, ''));
			myChartTwo.data.labels[1] = "교통";
			myChartTwo.update();
			calculateB();
		}

		function addShoppingAC(chart) {
			let Data = document.getElementById("ac-shopping").value;
			Number(Data.replace(/,/g, ''))

			myChartTwo.data.datasets[0].data[4] = Number(Data.replace(/,/g, ''));
			myChartTwo.data.labels[1] = "쇼핑";
			myChartTwo.update();
			calculateB();
		}

		function addActivityAC(chart) {
			let Data = document.getElementById("ac-activity").value;
			Number(Data.replace(/,/g, ''))

			myChartTwo.data.datasets[0].data[5] = Number(Data.replace(/,/g, ''));
			myChartTwo.data.labels[1] = "활동";
			myChartTwo.update();
			calculateB();
		}

		function addEntertainmentAC(chart) {
			let Data = document.getElementById("ac-entertainment").value;
			Number(Data.replace(/,/g, ''))

			myChartTwo.data.datasets[0].data[6] = Number(Data.replace(/,/g, ''));
			myChartTwo.data.labels[1] = "주점";
			myChartTwo.update();
			calculateB();
		}

		function addEtcAC(chart) {
			let Data = document.getElementById("ac-etc").value;
			Number(Data.replace(/,/g, ''))

			myChartTwo.data.datasets[0].data[7] = Number(Data.replace(/,/g, ''));
			myChartTwo.data.labels[1] = "기타";
			myChartTwo.update();
			calculateB();
		}
	</script>
</div>

<%@include file="../includes/footer.jsp"%>
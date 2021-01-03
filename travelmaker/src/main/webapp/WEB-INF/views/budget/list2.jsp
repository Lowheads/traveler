<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%
	request.setCharacterEncoding("UTF-8");
String paydate = request.getParameter("pay_date");
%>
    <style>
        body {
            /*height: 100vh;*/
            margin: 0;
            padding: 0;
        }

        .bg-modal {
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

        /* 폭 여기서 수정 */
        .bg-modal-content {
            width: 600px;
            height: 900px;
            background-color: white;
            border-radius: 5px;
            text-align: center;
            padding-top: 10px;
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
        
        body::-webkit-scrollbar,
        .bg-modal-content::-webkit-scrollbar {
            width: 0rem;
        }

        /* 없어도 됨 */
        img {
            width: 60px;
            height: 60px;
        }

        .bg-modal-close {
            position: absolute;
            top: 0;
            right: 14px;
            font-size: 52px;
            font-weight: lighter;
            transform: rotate(45deg);
            cursor: pointer;
        }

        .bg-modal-close:hover {

        }

        /* 테이블 */
        .bgwrapper {
            margin-top: 20px;
            display: flex;
            flex-direction: column;
            align-content: center;
            justify-content: center;
        }

        .bgboard {
            width: 90%;
            /*margin: 0 50px 50px 0;*/
            margin: auto;
            white-space: nowrap;
            border-collapse: collapse;
            font-size: 0.9em;
            /*min-width: auto;*/
            overflow: hidden;
            border-radius: 0 0 0 0;
        }

        .bgboard thead tr {
            color: black;
            text-align: left;
            font-size: 19px;
            font-weight: bold;
            border-bottom: 2px solid #dddddd;
        }

        .bgboard th,
        .bgboard td {
            font-weight: lighter;
            text-align: center;
            padding: 12px 23px
        }

        .bgboard tbody tr {
            font-size: 15px;
            border-bottom: 1px solid #dddddd;
            background-color: white;
            height: 70px;
        }

        .bgboard tbody tr:nth-of-type(even) {
            background-color: #fafafa;
        }

        .bgboard tbody tr:last-of-type {
            border-bottom: 1px #dddddd solid;
        }

        /* 일정명 버튼처럼 보이게 */
        a {
            color: #444;
            font-weight: normal;
            text-decoration: underline;
        }

        a:hover {
            font-weight: bold;
        }

    </style>


<button id="budgetbutton">내 일정 목록</button>

<div class="bg-modal">
    <!--  모달 안  -->
    <div class="bg-modal-content">
        <!-- X 버튼 -->
        <div class="bg-modal-bg-modal-close">+</div>

        <div class="bgwrapper">

            <span style='font-size:60px;'>&#128184;</span>

            <!-- 테이블 -->
            <div class="container-2">
                <table class="bgboard">
			<thead>
				<tr>
					<!-- <th>번호</th> -->
					<th>일정</th>
					<th>지출</th>
					<th>결제 횟수</th>
				</tr>
			</thead>

			<tbody>

				<c:forEach items="${list}" var="budget">
					<tr>
						<td><a
							href='/buddt/listAll?schno=<c:out value="${budget.schno}"/>'> <c:out
									value="${budget.schtitle}" /></a>
									<div style="display:flex; flex-direction:column;">
							<div>
							<c:out value="${budget.fromdate}" /> ~ <c:out value="${budget.todate}" />
							</div>
									</div>
									</td>
						<td>₩ <c:out value="${budget.totalpay}" /></td>
						<td><c:out value="${budget.totalcnt}" /> 건</td>
					</tr>
				</c:forEach>
                    </tbody>
                </table>
            </div>

        </div>

    </div>
</div>

<script>
    document.getElementById('budgetbutton').addEventListener('click',
        function () {
            document.querySelector('.bg-modal').style.display = 'flex';
        });

    document.querySelector('.bg-modal-close').addEventListener('click',
    function () {
        document.querySelector('.bg-modal').style.display = 'none';
    })
</script>
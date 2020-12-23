<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%String mem= String.valueOf(session.getAttribute("memNo")); %>

<!DOCTYPE html>
<html>
<link rel="stylesheet"
   href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<head>
<style>
.modal-content{
overflow-y: initial !important
}
.modal-body{
height: 85%;
overflow-y: auto;
}
#register_modal{
	display: none;
	width: 600px;
	height: 600px;
	padding: 10px;
	background-color: #fefefe;
	border: 1px solid #888;
	border-radius: 3px;
	text-align : center;
}
#hiddenlist_modal, #schedulelist_modal{
	display: none;
	width: 30%;
	height: 90%;
	padding: 10px;
	background-color: #fefefe;
	border: 1px solid #888;
	border-radius: 3px;
	text-align : center;
}
/* 닫는버튼 */
#hiddenlist_modal .modal_close_btn , #schedulelist_modal .modal_close_btn ,#register_modal .modal_close_btn {
	background-color: white;
	color: black;
	border: none;
	border-radius: 5px;
	text-align : right;
	float:right;
	font-size: 25px;
}
/* toggle */
.switch {
	position: relative;
	display: inline-block;
	width: 60px;
	height: 34px;
}
.switch input {
	opacity: 0;
	width: 0;
	height: 0;
}
.slider {
	position: absolute;
	cursor: pointer;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	background-color: #ccc;
	-webkit-transition: .4s;
	transition: .4s;
}
.slider:before {
	position: absolute;
	content: "";
	height: 26px;
	width: 26px;
	left: 4px;
	bottom: 4px;
	background-color: white;
	-webkit-transition: .4s;
	transition: .4s;
}
input:checked+.slider {
	background-color: #2196F3;
}
input:focus+.slider {
	box-shadow: 0 0 1px #2196F3;
}
input:checked+.slider:before {
	-webkit-transform: translateX(26px);
	-ms-transform: translateX(26px);
	transform: translateX(26px);
}
/* Rounded sliders */
.slider.round {
	border-radius: 34px;
}
.slider.round:before {
	border-radius: 50%;
}

#hiddenlist_open_btn{
	font-size:15px;
	margin-right:3%;
	margin-bottom: 50px;
	background-color:white;
	border: 1px solid gray;
	border-radius: 14px;
	padding: 5px 20px 5px 20px;
	float: right;
	text-decoration: none;
}

#schedulelist_open_btn{
	font-size:15px;
	margin-bottom: 50px;
	background-color:white;
	border: 1px solid gray;
	border-radius: 14px;
	padding: 5px 20px 5px 20px;
	text-decoration: none;
}

#schedulelist_open_btn:hover, #hiddenlist_open_btn:hover{
	background-color: #203341;
   	color:white;

}

.ct_body{
	padding: 30px;
	background-image: url('/resources/img/boardimg.jpg');
	height: 300px;
	background-repeat: no-repeat;
  	background-size: cover;
  	margin-bottom:50px; 
}

.boardContents{
	width: 100%;
	height: auto;
	background-color: white;
	display:inline-block;
}

.gallery {
	width: 100%;
	height: 100%;
	display : flex;
	justify-content: center;
	flex-wrap: wrap;
	margin: 0 auto;
}

.card-contents{
	width: 15%;
	height: 450px;
	margin-right:10px;
	position: relative;
 	z-index: 1;
  	display: block;
	border-radius: 10px;
  	margin-bottom: 30px;

/*   	box-shadow: 2px 2px 2px 2px #D4D4D4; */
  
}

.card-Img{
	position : relative;
	background-size: cover;
	width: 100%;
	height: 70%;
	border-radius: 10px;
	background-position: center; 
	background-repeat: no-repeat; 
	background-size: cover;
	
}
/* .img-cover{
	 position: absolute;
     height: 100%;
     width: 100%;                                                              
     z-index:1;
} */

/* .card-Img img{
	width: 100%;
	height: 100%;
	border-radius: 10px;
	
} */

.card-Img .heart{
     position: absolute;
     top:2%;
     left:93%;
     transform: translate(-50%, -50%);                                                                   
     font-size:5rem;
     color: white;
     z-index: 2;
     text-align: center;
  }

.card-desc{
	margin: 10px;
	height: auto;
	font-size: 15px;
}

.desc_bottom{
	 font-size : 12px;
}

.mainMsg{
	margin-left: 5%;
}

.mainMsg b{
	font-size:30px;
	color:white;

}

/* 페이징 */



.pagination_bar{
   font-size: 8pt;
  font-weight: 400;
  font-family: 'Open Sans', 'Source Sans Pro', Roboto, 'HelveticaNeue-Light', 'Helvetica Neue Light', 'Helvetica Neue', 'Myriad Pro', 'Segoe UI', Myriad, Helvetica, 'Lucida Grande', 'DejaVu Sans Condensed', 'Liberation Sans', 'Nimbus Sans L', Tahoma, Geneva, Arial, sans-serif;
  -webkit-text-size-adjust: 100%;
  margin: 1em auto;
  text-align: center;
  transition: font-size .2s ease-in-out;
}
.pagination_bar{
 list-style-type: none;
  display: inline;
  font-size: 100%;
  margin: 0;
  padding: .5em;
  }
  
.pagination_btn{
   display: inline-block;
  font-size: 100%;
  width: auto;
  border-radius: 3px;
  cursor: pointer;
}

.pagination_btn a{
   color: #777;
    font-size: 140%;
    padding: .5em;
    text-decoration : none;
}

.pagination_btn a:hover{
   color: #f60;
}

.active a{
   color: #f60;
}

</style>

</head>

<body>
<div class="contents">

	<!-- 상단  -->
	<div class="ct_body">
		<div class="mainMsg">
		<b>일정 게시판</b>	
		<br><br>	
		<a href='/board/schedulelist' target="schedulelist" id="schedulelist_open_btn" class="btn">내 일정 공유</a>
		<!--mainMsg끝 -->
		</div>
		
	<!--상단 끝 -->
	</div>
	
		<!-- 페이징 -->

    <div class="pagination" style="text-align: center;">
         <ul class="pagination_bar">
            <c:if test="${pageMaker.prev }">
               <li class="pagination_btn previous"><a href="${pageMaker.startPage-1 }">&laquo;</a></li>
            </c:if>

            <c:forEach var="num" begin="${pageMaker.startPage}"
               end="${pageMaker.endPage}">
               <li class="pagination_btn ${pageMaker.cri.pageNum == num ? 'active':'' }" >
                  <a href="${num}"> ${num }</a>
               </li>
            </c:forEach>

            <c:if test="${pageMaker.next }">
               <li class="pagination_btn next"><a href="${pageMaker.endPage +1 }">&raquo;</a></li>
            </c:if>
         </ul>
      </div>
	
	
	
	
    	<a href='/board/hiddenlist' target='hiddenlist' id="hiddenlist_open_btn" class="btn" >공개/비공개 설정</a>

		<!--게시판 리스트 출력 -->
		<div class="boardContents">
			<div class="gallery">
				<c:forEach items="${list }" var="board">
				<div class="card-contents">
				<c:set var="coverimg" value="${fn:replace(board.boardImg, '\\\\', '/')}" />
				<c:set var="mem" value="<%=mem %>"/>
				<c:choose>
					<c:when test="${mem eq 'null'}">
					<a href='/board/view?boardNo=<c:out value="${board.boardNo }"/>
						&pageNum=<c:out value="${pageMaker.cri.pageNum }"/>&amount=<c:out value="${pageMaker.cri.amount }"/>'>
					<div class="card-Img" style="background-image: url(/resources${coverimg});">
							<%-- <img src="/resources${board.boardImg}" > --%>
								<div class="img-cover"></div>
					</div>
					</a>
					</c:when>
				
					<c:otherwise>
						<a href='/board/get?boardNo=<c:out value="${board.boardNo }"/>
						&pageNum=<c:out value="${pageMaker.cri.pageNum }"/>&amount=<c:out value="${pageMaker.cri.amount }"/>'>
					<div class="card-Img" style="background-image: url(/resources${coverimg});">
							<%-- <img src="/resources${board.boardImg}" > --%>
								<div class="img-cover"></div>
					</div>
					</a>
					</c:otherwise>
				</c:choose>
					<div class="card-desc">
					<b><c:out value="${board.boardTitle }" /></b>
					<div class="desc_bottom">
					<i class="fa fa-eye"></i>&nbsp<c:out value="${board.VCnt }"/>
					<i class="fa fa-heart-o"></i>&nbsp<c:out value="${board.pickCnt }"/>
					<div style="float:right;"><i class="fa fa-pencil-square-o" ></i>&nbsp<c:out value="${board.writer }"/></div>
					</div>
<%-- 					<div class="heart"> <i class="fa fa-heart" data-sch_no="${board.schNo}" style="font-size:24px;color:red;" onclick="likeToggle(this)"></i></div> --%>
					</div>
			</div>
			</c:forEach>
			</div>
		</div>
<!--contents끝 -->
</div>
		<form id='actionForm' action="/board/list" method='get'>
			<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum }'>
			<input type='hidden' name='amount' value='${pageMaker.cri.amount }'>
		</form>





<!-- Hiddenlist Modal -->
<div id="hiddenlist_modal" class="modal-content">

	<div>
	<button class="modal_close_btn"> X </button>
		<h3>공개/비공개 설정</h3><br>
	</div>
	<div class="modal-body">
		<iframe name="hiddenlist" title="hiddenlist" width=100% height=100% frameBorder="0">
		</iframe>
	</div>

</div>


<!-- Schedulelist Modal -->
	<div id="schedulelist_modal" class="modal-content">
	<button class="modal_close_btn"> X </button>
	<h3>내일정 공유 </h3><br>
	<div class="modal-body">
		<iframe name="schedulelist" title="schedulelist" width=100% height=100% frameBorder="0">
		</iframe>
	</div>
</div>


<!--  register modal  -->
	<div id="register_modal" class="modal-content">
		<div class="modal-body" style="overflow-x:hidden; overflow-y:hidden">
		<iframe name="register" title="register" width=100% height=100% frameBorder="0" scrolling="no">
		</iframe>
		</div>
		<button class="modal_close_btn"> 취소 </button>
	</div>



<script type="text/javascript">
	$(document).ready(function() {
		

		var actionForm = $("#actionForm");
		$(".pagination_btn a").on("click", function(e) {
			e.preventDefault();
			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
			//alert(actionForm.find("input[name='pageNum']").val($(this).attr("href")))
			actionForm.submit();
		});

	});
	
	//hiddenlist script
	$(".round").on("click", function() {

		let sendData = {

			"hidden" : $(this).data("hidden"),
			"schNo" : $(this).data("schno")
		};
		$.ajax({
			type : 'post',
			url : '/board/hidden',
			data : sendData,

			success : function(data) {
			}

		});

	});
	
	function modal(id) {
		var zIndex = 9999;
		var modal = document.getElementById(id);

		// 모달 div 뒤에 희끄무레한 레이어
		var bg = document.createElement('div');
		bg.setStyle({
			position : 'fixed',
			zIndex : zIndex,
			left : '0px',
			top : '0px',
			width : '100%',
			height : '100%',
			overflow : 'auto',
			// 레이어 색갈은 여기서 바꾸면 대
			backgroundColor : 'rgba(0,0,0,0.4)'
		});
		bg.classList.add('schedulelistbg');
		document.body.append(bg);

		// 닫기 처리
		modal.querySelector('.modal_close_btn').addEventListener('click',
				function() {
					bg.remove();
					modal.style.display = 'none';
					window.location.reload();
				});

		modal
				.setStyle({
					position : 'fixed',
					display : 'block',
					boxShadow : '0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19)',

					// 시꺼먼 레이어 보다 한칸 위에 보이기
					zIndex : zIndex + 1,

					// 모달 가운데 이쁘게
					top : '50%',
					left : '50%',
					transform : 'translate(-50%, -50%)',
					msTransform : 'translate(-50%, -50%)',
					webkitTransform : 'translate(-50%, -50%)'
				});
	};

	// 이건 먼지모르겟음..
	Element.prototype.setStyle = function(styles) {
		for ( var k in styles)
			this.style[k] = styles[k];
		return this;
	};

	// hiddenlist 모달 띄우기
	document.getElementById('hiddenlist_open_btn').addEventListener('click',
	
		function() {
			var mem= <%=mem%>
			if(mem==null){
				alert('로그인 후 이용가능합니다');
			}
			else{
			 	modal('hiddenlist_modal');
			}
			});
	
	//schedulelist 모달 띄우기
	document.getElementById('schedulelist_open_btn').addEventListener('click',
			
			function() {
				var mem= <%=mem%>
				if(mem==null){
				alert('로그인 후 이용가능합니다');
				}
				else{
				modal('schedulelist_modal');
				}
			});
	//register 모달 띄우기
	$('.register_open_btn').on("click", function() {
				$('#schedulelist_modal').hide();
				$('.schedulelistbg').hide();
				modal('register_modal');
			});
	
	
</script>

</body>

</html>
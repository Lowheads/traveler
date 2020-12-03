<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="includes/adminheader.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>


지역
<br>
테마
<br>
<form method="POST" action="/admin/modifyTheme/${themeNo}" id=sendData >
	<input type = "submit"  class="btn btn-sm- btn-primary"} value="저장하기">
</form>

<table class="table table-bordered" id="dataTable" style="width: 70%">
	<tr>
		<th>장소번호</th>
		<th>장소명</th>
		<th>상세주소</th>
		<th>카테고리</th>
		<th>좋아요 수</th>
	</tr>

	<c:forEach items="${list}" var="list">
		<tr name=row id='<c:out value="${list.plcNo}" />'>
			<td><c:out value="${list.plcNo}" /></td>
			<td><c:out value="${list.plcTitle}" /></td>
			<td><c:out value="${list.addressDt}" /></td>
			<td><c:out value="${list.PCate}" /></td>
			<td><c:out value="${list.likeCnt}" /></td>
			<td><button id="deleteBtn"
					value='<c:out value="${list.plcNo}" />'>X</button></td>
		</tr>
	</c:forEach>
</table>




<div class="w300" style="padding-right: 10px">
	<!--  <input type="text" class="form-control form-control-sm" name="keyword"
		id="keyword">-->
</div>
<button id="addBtn" class="btn btn-sm- btn-primary">검색</button>
</div>

	<!-- Modal -->
					<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
						aria-labelledby="myModalLabel" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal"
										aria-hidden="true">&times;</button>
									<h4 class="modal-title" id="myModalLabel"></h4>
								</div>
								<div class="modal-body">
								<input type="text" class="form-control form-control-sm" name="keyword" id="keyword">
								<button id="searchBtn" class="btn btn-sm- btn-primary">검색</button>
								<div id="resultPage">
								</div>
								<div class="modal-footer">
								<div id="addedResult">
								</div>
									<button id="modalInBtn" type="button" class="btn btn-primary"
										data-dismiss="modal" >확인</button>

								</div>
							</div>
							<!-- /.modal-content -->

						</div>
						<!-- /.modal-dialog -->
					</div>
					<!-- /.modal -->
</div>

<script type="text/javascript" src="/resources/js/admin.js"></script>
<script>
	
	function modify(){
		
		alert("ㅜㅜ");
		
		alert("1"+removedPlaces);
		alert("2"+addedPlaces);
		
		for (let i = 0; i < list.length; i++) {
			if (list[i] != newlist[i]) {
				removedPlaces.push(list[i])
			}
		}

		for (let i = list.length; i < newlist.length; i++) {
			if (newlist[i] != "") {
				addedPlaces.push(newlist[i])
			}
		}
		

		
		
		let str1 = "<input type='hidden' name='addedPlaces' value="+addedPlaces+">"
		let str2 = "<input type='hidden' name='removedPlaces' value="+removedPlaces+">"

		$("#sendData").append(str1);
		$("#sendData").append(str2);
		
		return false;
		
	}

</script>

<script>
	$(document).ready(
			function() {
				
				let removedPlaces = [];
				let addedPlaces = [];
				let i = 0;
				let a = 0;

				let list = [];

				for (let i = 0; i < $("#dataTable tr").length - 1; i++) {
					list[i] = $("#dataTable td")[6* i].innerText
				}

				let newlist = []

				Object.assign(newlist, list)

				

				$("button[id=deleteBtn]").click(function() {

					let num = $(this).attr("value")

					let idx = list.indexOf(num);

					if (idx >= 0) {

						newlist[idx] = ""

						$("tr[id=" + num + "]").remove();

					}
					
					//console.log(newlist);
				})

				$("button[id=addBtn]").click(
						function() {
							$("div[id=resultPage] *").remove()
							$("#myModal").modal("show")
							
							
							/*
							if (keyword.length == 0) {
								alert("검색어를 입력해주세요");
								return;
							}
							if (keyword.length > 100) {
								alert("100자리 이상은 검색할 수 없습니다 ");
								return;
							}*/


							/*							user.place(keyword, function(list){

							 for (let i = 0; i < list.length; i++) {

							 str += "장소이름	:	" + list[i].plcTitle
							 + "	상세주소	:	" + list[i].addressDt
							 + "	카테고리	:	"
							 + list[i].pCate + "<br>";
							 }
							 console.log(str);
							 })*/

							//init();
						})
						
						$("button[id=searchBtn]").click(function(){
								let keyword = $("input[id=keyword]").val();
								let num = keyword.length;
								
								$("div[id=resultPage] *").remove()
								
								if (num == 0) {
									alert("검색어를 입력해주세요");
									return;
								}
								if (num > 100) {
									alert("100자리 이상은 검색할 수 없습니다 ");
									return;
								}
								
								$.getJSON("/admin/getPlaceList/" + keyword
										+ ".json", function(list) {
									
									for (let i = 0; i < list.length; i++) {

										let obj;
										obj = document.createElement('button');
										obj.setAttribute('id', 'added');
										obj.setAttribute('name', list[i].plcNo);
										obj.innerText = "+";
										obj.addEventListener('click', added);

										let ob;
										ob = document.createElement('li');
										ob.setAttribute('id', list[i].plcNo);
										ob.innerText = list[i].plcTitle + "	"
												+ list[i].addressDt;
										ob.append(obj);
										
										$("div[id=resultPage]").append(ob);
									}
									
								});
								
							})

				function added(event) {

					let num = $(this).attr("name")
					
					let idx = list.indexOf(num);
					
					idx= newlist.indexOf(num);
					
					if (idx == -1) {

						newlist.push(num);
						
					//	$("#addedResult").append($("li[id=" + num + "]"));s

						$("li[id=" + num + "]").remove();

						//	let str = "<tr><td></td><td>"++"</td></tr>"
					}else{
						
						alert("이미 저장된 장소입니다");
						return;
					}
					
					console.log(newlist);
					

				}
				
				$("form[id=sendData]").click(function(e){
					
					e.preventDefault();
					for (let i = 0; i < list.length; i++) {
						if (list[i] != newlist[i]) {
							removedPlaces.push(list[i])
						}
					}

					for (let i = list.length; i < newlist.length; i++) {
						if (newlist[i] != "") {
							addedPlaces.push(newlist[i])
						}
					}
					
					if(removedPlaces.length==0&&addedPlaces.length==0){
						return;
					}
					
					let str1 = "<input type='hidden' name='addedPlaces' value="+addedPlaces+">"
					let str2 = "<input type='hidden' name='removedPlaces' value="+removedPlaces+">"

					$("#sendData").append(str1);
					$("#sendData").append(str2);
					
					$("#sendData").submit();
					
				})
				


				/*$("button[id=test]").click(
						function() {


							
							$.ajax({
								url : url,
								method : "POST",
								traditional:true,
								data: {"removedPlaces":removedPlaces, "themeNo":${themeNo}},
								success:function(){
								},error: function(xhr){
									alert(xhr.responseText);
								}
							});

						})*/

			})
</script>

<%@ include file="includes/adminfooter.jsp"%>

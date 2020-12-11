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

<form method="POST" action="/admin/modifyTheme/${themeNo}" id=sendData>
	<input type="submit" class="btn btn-sm- btn-primary" } value="저장하기">
</form>

<div class="uploadDiv">
	<input type='file' name='uploadFile' accept="image/*" required>
</div>
<div class="uploadResult">
	<ul>
	</ul>
</div>
<div class='bigPictureWrapper'>
	<div class='bigPicture'></div>
</div>

<buttno id='uploadBtn'>upload</buttno>

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
				<input type="text" class="form-control form-control-sm"
					name="keyword" id="keyword">
				<button id="searchBtn" class="btn btn-sm- btn-primary">검색</button>
				<div id="resultPage"></div>
				<div class="modal-footer">
					<div id="addedResult"></div>
					<button id="modalInBtn" type="button" class="btn btn-primary"
						data-dismiss="modal">확인</button>

				</div>
			</div>
			<!-- /.modal-content -->

		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->
</div>

<script type="text/javascript" src="/resources/js/admin.js"></script>

<script src="https://code.jquery.com/jquery-3.3.1.min.js"
	integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
	crossorigin="anonymous"></script>

<script>
	$(document).ready(
			function() {
				
				
				let removedPlaces = [];
				let addedPlaces = [];

				let list = [];

				for (let i = 0; i < $("#dataTable tr").length - 1; i++) {
					list[i] = $("#dataTable td")[6* i].innerText
				}

				let newlist = []

				Object.assign(newlist, list)
				
				let themeNo = ${themeNo};
				
				//db에 저장된 사진 보여주기 
				(function(){
					
					$.getJSON("/admin/getAttachment", {themeNo:themeNo},function(result){
						
						let str="";
						
						const fileCallPath = encodeURIComponent("/s_"+result.uuid+"_"+result.fileName);
						
						str+= "<li data-path='"+result.uploadPath+"'data-uuid='"+result.uuid+"'data-fileName='"+result.fileName+
						"' data-type = '"+result.fileType+"'></div>";
						
						str+= "<img src='/admin/display?fileName="+fileCallPath+"'>";
						str += "<span> "+result.fileName+"</span>";
						str += "<button type = 'button' data-file =\ '"+fileCallPath+"\'";
						str += "data-type ='image' class='btn btn-warning btn-circle'> X <iclass = 'fa fa-times'></i></button><br>";
						str+="</div>";
						str+="</li>";
						
						$(".uploadResult ul").html(str);
					
					})
						
				})();
				
				$(".uploadResult").on("click","li", function(e){
					
					let liObj = $(this);
					
					const path = encodeURIComponent(liObj.data("uuid")+"_"+liObj.data("filename"));
					imgupload.showImage(path.replace(new RegExp(/\\/g),"/"));
					console.log("done");
				});
				
				
				let cloneObj= $(".uploadDiv").clone();
				
				let uploadResult = $(".uploadResult ul")
				
				//이미지 업로드와 관련된 함수들
				let imgupload = {
					
					//업로드 한 사진  썸네일 보여주기 
					showUploadedFile : function(image){
						
						let str = "";
						
						const fileCallPath = encodeURIComponent("/s_"+image.uuid+"_"+image.fileName);
						
						str += "<li data-path = '"+image.uploadPath+"' ";
						str += "data-uuid='"+image.uuid+"' data-filename='"+image.fileName+"' data-type='"+image.image+"'";
						str += "><div>";
						str +="<img src = '/admin/display?fileName="+fileCallPath+"'>";
						str += "<span> "+image.fileName+"</span>";
						str += "<button type = 'button' data-file =\ '"+fileCallPath+"\'";
						str += "data-type ='image' class='btn btn-warning btn-circle'> X <iclass = 'fa fa-times'></i></button><br>";
						str += "</div></li>";
						
						uploadResult.append(str);
					}, 
				
					//파일 유효성 체크
					checkExtension: function(fileSize, fileType){
						
						const maxSize = 5242880;
						
						if(fileSize>=maxSize){
							alert("파일 사이즈 초과 ");
							return false;
						}
		
						if(!fileType.includes("image")){
							alert("이미지 파일만 선택해주세요")
							return false
						}
						
						return true;
					},
					
					//사진 누르면 확대하기
					showImage : function(fileCallPath){
						
						$(".bigPictureWrapper").css("display","flex").show();
						
						$(".bigPicture").html("<img src='/admin/display?fileName="+encodeURI(fileCallPath)+"'>")
						.animate({width:'100%',height:'100%'},1000);

					}
					
				}
				
				$(".bigPictureWrapper").on("click",function(e){
					$(".bigPicture").animate({width:'0px', height:'0px'},500);
					setTimeout(() => {
						$(this).hide();
						
					},500);
					
				});
				
				$(".uploadResult").on("click","button",function(e){

					const targetFile = $(this).data("file");
					const type = $(this).data("type");
					
					
					$.ajax({
						url:'/admin/deleteFile',
						data:{fileName:targetFile, type:type},
						dataType :'text',
						type:'POST',
							success: function(result){
								alert("사진을 삭제 완료했습니다");
								$(".uploadResult li").remove();
							}
					});
					
				})
				
				$("input[type='file']").change(function(e){

					const formData = new FormData();
					
					const inputFile = $("input[name='uploadFile']");
					
					const file = inputFile[0].files[0];
					
					if(!imgupload.checkExtension(file.size, file.type)){
						$(".uploadDiv").html(cloneObj.html());
						return false;
					}

					formData.append("uploadFile",file);

					$.ajax({
						url:'/admin/upload/'+${themeNo},
						processData:false,
						contentType:false,
						data:formData,
						type:'POST',
						dataType:'json',
						success:function(image){
							imgupload.showUploadedFile(image);
							$(".uploadDiv").html(cloneObj.html());
						}
						
					});

				})

				$("button[id=deleteBtn]").click(function() {

					let num = $(this).attr("value")
					let idx = list.indexOf(num);
					newlist[idx] = ""

					$(this).parent().parent().remove()
/*
					let idx = list.indexOf(num);

					if (idx >= 0) {

						newlist[idx] = ""

						$("tr[id=" + num + "]").remove();

					}
	*/				
				})

				$("button[id=addBtn]").click(
						function() {
							$("div[id=resultPage] *").remove()
							$("#myModal").modal("show")
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
						
						$("li[id=" + num + "]").remove();

					}else{
						
						alert("이미 저장된 장소입니다");
						return;
					}
				}
				
				$("form[id=sendData]").click(function(e){
					
					e.preventDefault();
					
					let str = "";
					
					if($(".uploadResult ul li").length>0){
						
						const image = $(".uploadResult ul li")[0].dataset;
						
						str += "<input type='hidden' name = 'fileName' value='"+image.filename+"'>";
						str += "<input type='hidden' name = 'uuid' value='"+image.uuid+"'>";
						str += "<input type='hidden' name = 'uploadPath' value='"+image.path+"'>";
						str += "<input type='hidden' name = 'image' value='"+image.type+"'>";
						
					}
					
					
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
					
					let addedPlaceList= "<input type='hidden' name='addedPlaces' value="+addedPlaces+">"
					let removedPlaceList = "<input type='hidden' name='removedPlaces' value="+removedPlaces+">"

					$("#sendData").append(addedPlaceList);
					$("#sendData").append(removedPlaceList);
					$("#sendData").append(str);
					
					$("#sendData").submit();
					
				})
			})
</script>

<%@ include file="includes/adminfooter.jsp"%>

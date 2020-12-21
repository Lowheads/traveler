<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="includes/adminheader.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>

			<h6 class="m-0 font-weight-bold text-primary">여행 테마 수정하기 </h6>
		</div>
	<div class="card-body">
		<div class="btn-group float-right">
			<span class="input-group-btn">
				<button id="addBtn" class="btn btn-sm- btn-primary float-right">
					<i class="fas fa-plus"></i>
				</button>
			</span>
			<form method="POST" action="/admin/modifyTheme/${themeNo}" id=sendData>
				<input type="submit" class="btn btn-sm- btn-primary" value="저장하기">
			</form>	
		</div>	
		<div class="form-group">
			<div class="uploadDiv inline">
				<input type='file' name='uploadFile' accept="image/*" required>
			</div>
		<div class="uploadResult"><ul></ul></div>
		</div>
<div>

	<table class="table table-hover" id="dataTable" style="width: 100%">
		<tr>
			<th>장소번호</th>
			<th>장소명</th>
			<th>상세주소</th>
			<th>카테고리</th>
			<th>좋아요 수</th>
			<th> </th>
		</tr>
	
		<c:forEach items="${list}" var="list">
			<tr name=row id='<c:out value="${list.plcNo}" />'>
				<td><c:out value="${list.plcNo}" /></td>
				<td><c:out value="${list.plcTitle}" /></td>
				<td><c:out value="${list.addressDt}" /></td>
				<td><c:out value="${list.PCate}" /></td>
				<td><c:out value="${list.likeCnt}" /></td>
				<td><button class="btn btn-default" id="deleteBtn"
						value='<c:out value="${list.plcNo}" />'>
						<i class="fas fa-times"></i></button>
						</button></td>
			</tr>
		</c:forEach>
	</table>
</div>

<!-- <div class="w300" style="padding-right: 10px">
	 <input type="text" class="form-control form-control-sm" name="keyword"
		id="keyword">
</div> -->

<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
	
		<div class="modal-content" style="width:120%">
			<div class="modal-header">
			<h6 class="modal-title" id="myModalLabel">새로운 장소 검색하기</h6>
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
			</div>
			
			<div class="modal-body">
			
				<div class="w100 input-group custom-search-form">
 					<input type="text" class="form-control form-control-sm" name="keyword" id="keyword">
					<span class="input-group-btn">
						<button id="searchBtn" class="btn btn-default">
							<i class="fa fa-search"></i>
						</button>
					</span>
				</div>
				<div id="resultPage"></div>
				<div class="modal-footer">
					<ul id="pagination"></ul>
					<button id="modalInBtn" type="button" class="btn btn-primary"
						data-dismiss="modal">확인</button>
				</div>
			</div>
			<!-- end of modal-body -->
		</div>
	</div>
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
				
/* 				if($(".uploadResult img").length!=0){
					$(".uploadDiv").hide()}*/
 				
				let removedPlaces = [];
				let addedPlaces = [];

				let list = [];

				for (let i = 0; i < $("#dataTable tr").length - 1; i++) {
					list[i] = $("#dataTable td")[6* i].innerText;
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
						str+="<div>";
						str+= "<img src='/admin/display?fileName="+fileCallPath+"'>";
						str += "<span> "+result.fileName+"</span>";
						str += "<button type = 'button' data-file =\ '"+fileCallPath+"\'";
						str += "data-type ='image' class='btn btn-warning btn-circle btn-sm'><i class = 'fas fa-times'></i></button>";
						str+="</div>";
						str+="</li>"; 
						$(".uploadResult ul").html(str);
					
					})
						
				})();
				
				$(".uploadResult").on("click","img", function(e){
					
					let liObj = $(this).parent().parent();
					
					const path = encodeURIComponent(liObj.data("uuid")+"_"+liObj.data("filename"));
					console.log(path.replace(new RegExp(/\\/g),"/"));
					theme.showImage(path.replace(new RegExp(/\\/g),"/"));
				});
				
				
				let cloneObj= $(".uploadDiv").clone();
				
			//	let uploadResult = $(".uploadResult ul")
				
				
				$(".bigPictureWrapper").on("click",function(e){
					$(".bigPicture").animate({width:'0px', height:'0px'},500);
					setTimeout(() => {
						$(this).hide();
						
					},500);
					$('body').css("overflow", "scroll");
					
				});
				
				$(".uploadResult").on("click","button",function(e){

					const targetFile = $(this).data("file");
					const type = $(this).data("type");
					
					theme.deleteFile(targetFile,type);
					
				})
				
				$("input[type='file']").change(function(e){
					
					const formData = new FormData();
					
					const inputFile = $("input[name='uploadFile']");
					
					const file = inputFile[0].files[0];

					if($(".uploadResult li").length==1){
						$(".uploadResult li")[0].remove();
					}

				
					if(!theme.checkExtension(file.size, file.type)){
						$(".uploadDiv").html(cloneObj.html());
						return false;
					}
					
					formData.append("uploadFile",file);
					
					console.log(file);
					console.log("1");
					
					theme.uploadFile(${themeNo},formData);

				})

				$("button[id=deleteBtn]").click(function() {

					let num = $(this).attr("value")
					//let idx = list.indexOf(num);
					let idx = list.indexOf(num);
					
					newlist[idx] = ""

					$(this).parent().parent().remove()
			
				})

				$("button[id=addBtn]").click(
			        function() {
			        	$("div[id=resultPage] *").remove()
			        	$("#pagination").empty()
			        	$("#myModal").modal("show")
			        })
						
				$("button[id=searchBtn]").click(function(){
			        let keyword = $("input[id=keyword]").val();
			        let num = keyword.length;
			        
			        $("div[id=resultPage] *").remove()
			        $("#pagination").empty()
			        
			        if (num == 0) {
			        	alert("검색어를 입력해주세요");
			        	return;
			        }
			        if (num > 100) {
			        	alert("100자리 이상은 검색할 수 없습니다 ");
			        	return;
			        }
			        
			        var pageNum = 1;
			        
			        paginate(keyword,pageNum);
			        
			       
							})
							
				$("#modalInBtn").click(function(e){
					
					e.preventDefault();
					
					
				})
				
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
				
				function paginate(keyword, pageNum){
					
					$.getJSON("/admin/getPlaceList/"+keyword+"/"+pageNum, function(list) {
										
										$("div[id=resultPage] *").remove()
										$("#pagination").empty()
					                    
										var pageDto = list.pageMaker;
										var placeList = list.list;
					                    
										//console.log(pageDto)
										
												$("div[id=resultPage]").append(pageDto.cri.pageNum);
												
										//검색결과 보여주기
							 				for (let i = 0; i < placeList.length; i++) {
							 					
												let plus;
												
												plus = document.createElement('i')
												plus.setAttribute('class', 'fas fa-plus')
					                    
												let obj;
												obj = document.createElement('button');
												obj.setAttribute('id', 'added');
												obj.setAttribute('class','btn btn-default');
												obj.setAttribute('name', placeList[i].plcNo);
												obj.addEventListener('click', added);
												obj.append(plus);
												
												let title = document.createElement('span');
												title.innerText = placeList[i].plcTitle;
												let address = document.createElement('span');
												address.innerText = placeList[i].addressDt;
												
												
												ob = document.createElement('li');
												ob.setAttribute('id', placeList[i].plcNo);
												ob.setAttribute('title', placeList[i].plcTitle+","+placeList[i].addressDt+","+placeList[i].pcate+","+placeList[i].likeCnt);
												
												 ob.append(title,address,obj);
												 
												$("div[id=resultPage]").append(ob);
											}//end of repeat 
										
											
										 if(pageDto.cri.pageNum != 1){
				
									        	$("#pagination").append("<li class='goFirstPage'><a><i class='fas fa-angle-double-left'></i></a></li>");        //첫페이지로가는버튼 활성화
				
									        }else{
									        	
									        	$("#pagination").append("<li style='visibility:hidden'><a><<</a></li>");        //첫페이지로가는버튼 비활성화
				
									        }

						
				        if(pageDto.prev==true){            //첫번째 블럭이 아니면
				        	$("#pagination").append("<li class='goBackPage'><a><i class='fas fa-angle-left'></i></a></li>");        //뒤로가기버튼 활성화

				        }else{

				        	$("#pagination").append("<li style='visibility:hidden'><a><</a></li>");        //뒤로가기버튼 비활성화

				        }

										 for(var i = pageDto.startPage ; i <= pageDto.endPage ; i++){        //시작페이지부터 종료페이지까지 반복문
				
										   if(pageDto.cri.pageNum == i){                            //현재페이지가 반복중인 페이지와 같다면
				                           
										                 	$("#pagination").append("<li class=\"disabled active\"><a>"+i+"</a></li>");    //버튼 비활성화
				                           
										         	}else{
				                           
										         		$("#pagination").append("<li class='goPage' data-page=\""+i+"\"><a>"+i+"</a></li>"); //버튼 활성화
				                           
										         	}
				                           
										         }

										        if(pageDto.next==true){            //전체페이지블럭수가 현재블럭수보다 작을때

				        	$("#pagination").append("<li class='goNextPage'><a><i class='fas fa-angle-right'></i></a></li>");         //다음페이지버튼 활성화

				        }else{

				        	$("#pagination").append("<li style='visibility:hidden'><a>></a></li>");        //다음페이지버튼 비활성화

				        }

										 	 
										 	    if(pageDto.cri.pageNum < Math.ceil(pageDto.total/10)){                //현재페이지가 전체페이지보다 작을때
				                           
										     		$("#pagination").append("<li class='goLastPage'><a><i class='fas fa-angle-double-right'></i></a></li>");    //마지막페이지로 가기 버튼 활성화
				                           
										     	}else{
				                           
										     		$("#pagination").append("<li style='visibility:hidden'><a>>></a></li>");        //마지막페이지로 가기 버튼 비활성화
				                           
										     	}
				                           
										     	$(".goFirstPage").click(function(){
				                           
										 	       	page = 1;
				                           
										 	       	pageFlag = 1;
				                           
										 	       	paginate(keyword,page)
				                           
										 	       	pageFlag = 0;
				                           
										         });
										     	$(".goBackPage").click(function(){
				                           
										 	      	page = pageDto.startPage - 1;
					
													console.log(page);
				                           
										 	       	pageFlag = 1;
				                           
										 	       	paginate(keyword,page)
				                           
										 	       	pageFlag = 0;
				                           
										         });
				                           
										     	$(".goPage").click(function(){
				                           
										 			page = $(this).attr("data-page");
				                           
										 			pageFlag = 1;
										 			
										 			paginate(keyword,page)
				                           
										 		       	pageFlag = 0;
				                           
										 		});
				                           
										 		$(".goNextPage").click(function(){
				                           
										 			//page = Number(pageDto.endPage) + 1;
				                           			page = pageDto.endPage + 1;

													console.log(page)
				                           
										 			pageFlag = 1;
				                           
										 			paginate(keyword,page)
				                           
										 		       	pageFlag = 0;
				                           
										 	        });
				        $(".goLastPage").click(function(){

				        	page = Math.ceil(pageDto.total/10);

				        	pageFlag = 1;

					       	paginate(keyword,page)

					      	pageFlag = 0;

				        });



											}).fail(function(result){
														
														console.log("fail");
											});
					
					
				}
				
				function added(){

					let num = $(this).attr("name")+"";
					
					let idx = list.indexOf(num);
					
					idx= newlist.indexOf(num);
					
					if (idx == -1) {

						newlist.push(num);
						
						var data = $("li[id="+num+"]")[0]
						
						var info = data.title.split(",");
						
						var str = '<tr name="row" id='+num+'>'
						str+='<td>'+data.id+'</td>'
						str+='<td>'+info[0]+'</td>'
						str+='<td>'+info[1]+'</td>'
						str+='<td>'+info[2]+'</td>'
						str+='<td>'+info[3]+'</td>'
						str+='<td><button class="btn btn-default" id="deleteBtn" value='+data.id+'><i class="fas fa-times"></i></button></td>'
						
						/* obj.addEventListener('click', added);
									 */
						
						$("tbody").append(str);
						
						console.log(str);
						
						$("li[id=" + num + "]").remove();

					}else{
						
						alert("이미 저장된 장소입니다");
						return;
					}
				 
	}

			})
</script>

<%@ include file="includes/adminfooter.jsp"%>

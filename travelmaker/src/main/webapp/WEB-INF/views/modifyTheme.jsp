<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="includes/adminheader.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>

	<h1 style='display: none'><c:out value="${region}" /></h1>
			<h6 class="m-0 font-weight-bold text-primary">여행 테마 수정하기 </h6>
		</div>
	<div class="card-body">
		<div class="btn-group float-right">
			<span class="input-group-btn">
				<button id="appendNewPlaces" class="btn btn-sm- btn-primary float-right">
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
			<th>장소명</th>
			<th>상세주소</th>
			<th>카테고리</th>
			<th>휴일</th>	
			<th>영업시간</th>
			<th>좋아요 수</th>
			<th> </th>
		</tr>
	
		<c:forEach items="${list}" var="list">
			<tr name=row id='<c:out value="${list.plcNo}" />'>
				<td style='display:none'><c:out value="${list.plcNo}" /></td>
				<td><c:out value="${list.plcTitle}" /></td>
				<td><c:out value="${list.addressDt}" /></td>
				<td><c:out value="${list.PCate}" /></td>
				<td><c:out value="${list.holiday}" /></td>
				<td><c:out value="${list.openingH}" /></td>
				<td><c:out value="${list.likeCnt}" /></td>
				<td><button class="btn btn-default" id = "deleteBtn" value='<c:out value="${list.plcNo}" />'>
						<i class="fas fa-times"></i></button>
						</button></td>
			</tr>
		</c:forEach>
	</table>
</div>

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
				
				let removedPlaces = [];
				let addedPlaces = [];

				let list = [];
				let newlist = []
				
				const regionNo = $("h1")[0].innerText;
				
				for (let i = 0; i < $("#dataTable tr").length - 1; i++) {
					list[i] = $("#dataTable td")[8* i].innerText; 
				}
				
				Object.assign(newlist, list)

				let themeNo = ${themeNo};
				
				
				//db에 저장된 사진 보여주기 
				(function(){
					
					$.getJSON("/admin/getAttachment", {themeNo:themeNo},function(thumbnail){
						
						let str="";
						
						const fileCallPath = encodeURIComponent("/s_"+thumbnail.uuid+"_"+thumbnail.fileName);
						
						str+= "<li data-path='"+thumbnail.uploadPath+"'data-uuid='"+thumbnail.uuid+"'data-fileName='"+thumbnail.fileName+
						"' data-type = true></div>";
						str+="<div>";
						str+= "<img src='/admin/display?fileName="+fileCallPath+"'>";
						str += "<span> "+thumbnail.fileName+"</span>";
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
					theme.showImage(path.replace(new RegExp(/\\/g),"/"));
				});
				
				
				let cloneObj= $(".uploadDiv").clone();
				
				
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
					
				});
				
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
					
					theme.uploadFile(${themeNo},formData);

				});

  				$("button[id=deleteBtn]").click(function() {

					let num = $(this).attr("value")
					let idx = list.indexOf(num);
					
					newlist[idx] = ""

					$(this).parent().parent().remove()
			
				});   
				

				
				$("button[id=appendNewPlaces]").click(
			        function() {
			        	$("input[id='keyword']")[0].value=""
			        	$("div[id=resultPage] *").remove()
			        	$("#pagination").empty()
			        	$("#myModal").modal("show")
			        });
						
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
			       
					});
							
				$("#modalInBtn").click(function(e){
					
					e.preventDefault();
					
				});
				
				$("form[id=sendData]").click(function(e){
					
					e.preventDefault();
					
					let img = "";
					
					if($(".uploadResult ul li").length>0){
						
						const image = $(".uploadResult ul li")[0].dataset;
						
						img += "<input type='hidden' name = 'fileName' value='"+image.filename+"'>";
						img += "<input type='hidden' name = 'uuid' value='"+image.uuid+"'>";
						img += "<input type='hidden' name = 'uploadPath' value='"+image.path+"'>";
						/* img += "<input type='hidden' name = 'image' value='"+image.type+"'>"; */
						img += "<input type='hidden' name = image value="+image.type+">";
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
					$("#sendData").append(img);
					
					$("#sendData").submit();
				});
				
				function paginate(keyword, pageNum){
					
					$.getJSON("/admin/getPlaceList/"+keyword+"/"+pageNum+"/"+regionNo, function(list) {
										
										$("div[id=resultPage] *").remove()
										$("#pagination").empty()
					                    
										var pageDto = list.pageMaker;
										var placeList = list.list;
												
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
												ob.setAttribute('title', placeList[i].plcTitle+","+placeList[i].addressDt+","+placeList[i].pcate+","+placeList[i].holiday+","+placeList[i].openingH+","+placeList[i].likeCnt);
												
												 ob.append(title,address,obj);
												 
												$("div[id=resultPage]").append(ob);
											}
										
										//가장 첫 페이지로 가는 버튼
										 if(pageDto.cri.pageNum != 1){
									        	$("#pagination").append("<li class='goFirstPage'><a><i class='fas fa-angle-double-left'></i></a></li>");      
									     }else{
									        	$("#pagination").append("<li style='visibility:hidden'><a><<</a></li>");  
									    }

										//이전 페이지 블록으로 가기 
								        if(pageDto.prev==true){
								        	$("#pagination").append("<li class='goBackPage'><a><i class='fas fa-angle-left'></i></a></li>");
				
								        }else{
				
								        	$("#pagination").append("<li style='visibility:hidden'><a><</a></li>"); 
				
								        }
										
										//현재페이지 버튼 비활성화하기 
										 for(var i = pageDto.startPage ; i <= pageDto.endPage ; i++){        
				
											   if(pageDto.cri.pageNum == i){                      
					                           
											       $("#pagination").append("<li class=\"disabled active\"><a>"+i+"</a></li>");    
					                           
											   }else{$("#pagination").append("<li class='goPage' data-page=\""+i+"\"><a>"+i+"</a></li>");}
				                           
										  }
										//다음 페이지 블록으로 가기 
										if(pageDto.next==true){  

				        					$("#pagination").append("<li class='goNextPage'><a><i class='fas fa-angle-right'></i></a></li>");     

				       					 }else{

									        	$("#pagination").append("<li style='visibility:hidden'><a>></a></li>");     
					
									     }

										
										//가장 끝페이지로 가기
										if(pageDto.cri.pageNum < Math.ceil(pageDto.total/10)){                
				                           
										     $("#pagination").append("<li class='goLastPage'><a><i class='fas fa-angle-double-right'></i></a></li>");    
				                           
										  }else{
				                           
										     $("#pagination").append("<li style='visibility:hidden'><a>>></a></li>");       
				                           
										  }
				                           
										     	$(".goFirstPage").click(function(){
				                           
										 	       	page = 1;
				                           
										 	       	pageFlag = 1;
				                           
										 	       	paginate(keyword,page)
				                           
										 	       	pageFlag = 0;
				                           
										         });
										     	$(".goBackPage").click(function(){
				                           
										 	      	page = pageDto.startPage - 1;
					
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
				                           
				                           			page = pageDto.endPage + 1;

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
					
				};
				
				function added(){

					let num = $(this).attr("name")+"";
					
					let idx = list.indexOf(num);
					
					idx= newlist.indexOf(num);
					
					if (idx == -1) {

						newlist.push(num);
						
						var data = $("li[id="+num+"]")[0]
						
						var info = data.title.split(",");
						
 						for(var i = 0; i<info.length;i++){
							
							if(info[i]=="null"){
								info[i]="";
							}
						} 
 						
 						let str = document.createElement("tr");
 						str.setAttribute("name","row")
 						str.setAttribute("id",num)
 						
 						for(let i =0;i<6;i++){
 							let inner = document.createElement("td");
 							inner.innerText = info[i];
 	 						str.append(inner);	
 						}
 						
 						let btn = document.createElement("button");
 						btn.setAttribute("class","btn btn-default");
 						btn.setAttribute("id","deleteBtn");
 						btn.setAttribute("value",data.id);
 						
 						let icon = document.createElement("i");
 						icon.setAttribute("class","fas fa-times");
 						
 						btn.append(icon);
 						str.append(btn); 
						
						$("tbody").append(str);
						
						$("li[id=" + num + "]").remove();
						 

					}else{
						
						alert("이미 저장된 장소입니다");
						return;
					}
				 
				};
	
			})
</script>

<%@ include file="includes/adminfooter.jsp"%>

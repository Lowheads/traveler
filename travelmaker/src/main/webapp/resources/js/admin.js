/**
 * 
 */

var user=(function(){
	
	function detail(boardNo, callback, error){
		
		$.getJSON("/admin/getDetail/"+boardNo+".json"
		,function(data){
			if(callback){
				callback(data)}}
				).fail(
			function(xhr, status,err){
				if(error){
					error();
				}
			});
		}	
			return {detail:detail};
})();

var theme = (function(){
	
	let list = [];
	
	let newlist = [];
	
	function showImage(fileCallPath){
		$(".bigPictureWrapper").css("display","flex").show();
		
		console.log(fileCallPath);
						
		$(".bigPicture").html("<img src='/admin/display?fileName="+encodeURI(fileCallPath)+"'>")
						.animate({width:'100%',height:'100%'},1000);
		 $('body').css("overflow", "hidden");
	};
	
	function checkExtension(fileSize, fileType){
	
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
	}
	
	function showUploadedFile(image){
		
		let str = "";
		let uploadResult = $(".uploadResult ul")
						
		const fileCallPath = "/s_"+image.uuid+"_"+image.fileName;
						
        str += "<li data-path = '"+image.uploadPath+"' ";
        str += "data-uuid='"+image.uuid+"' data-filename='"+image.fileName+"' data-type='"+image.image+"'";
        str += "><div>";
        str +="<img src ='/admin/display?fileName="+encodeURI(fileCallPath)+"'>";
        str += "<span> "+image.fileName+"</span>";
        str += "<button type = 'button' data-file =\ '"+fileCallPath+"\'";
        str += "data-type ='image' class='btn btn-warning btn-circle btn-sm'><i class='fas fa-times'></i></button><br>";
        str += "</div></li>";
        
        uploadResult.append(str);
	}
	
	function uploadFile(themeNo,formData){
		
		$.ajax({
			url:'/admin/upload/'+themeNo,
			processData:false,
			contentType:false,
			data:formData,
			type:'POST',
			dataType:'json',
			success:function(image){
				theme.showUploadedFile(image);
				//$(".uploadDiv").html(cloneObj.html());
				},
				error:function(xhr, status, er){
					if(error){
						error(er)
					}
				}
			});
	}
	
	function deleteFile(targetFile,type){
		
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
					
	}
	
/*	function paginate(keyword, pageNum){
		
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
		
		
	}*/
	
	/*function added(){

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
						
						obj.addEventListener('click', added);
									
						
						$("tbody").append(str);
						
						console.log(str);
						
						$("li[id=" + num + "]").remove();

					}else{
						
						alert("이미 저장된 장소입니다");
						return;
					}
				 
	}
*/
	
	
	return {showImage:showImage,
			checkExtension:checkExtension,
			showUploadedFile:showUploadedFile,
			uploadFile:uploadFile,
			deleteFile:deleteFile,
			paginate:paginate,
			list:list,
			newlist:newlist};
})();



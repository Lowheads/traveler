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
		
	function getImage(boardNo, callback,error){
		
		$.getJSON("/admin/getPostImages/"+boardNo+".json"
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
		
			return {detail:detail,
			getImage:getImage};
			
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
	
	return {showImage:showImage,
			checkExtension:checkExtension,
			showUploadedFile:showUploadedFile,
			uploadFile:uploadFile,
			deleteFile:deleteFile/*,
			paginate:paginate,
			list:list,
			newlist:newlist*/};
})();



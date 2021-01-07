<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE gtml PUBLIC "-//W3c//DTD HTML 4.01 Transitinal//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<style type="text/css">
.uploadResult{
	width: 100%;
	background-color: gray;
}

.uploadResult ul{
	display: flex;
	flex-flow: row;
	justify-content: center;
	align-items: center;
}

.uploadResult ul li{
	list-style: none;
	padding: 10px;
}

.uploadResult ul li img{
	width: 20px;
}
</style>

</head>

<body>
<h1> upload with Ajax</h1>



<div class='uploadDiv'>
	<input type='file' name='uploadFile' multiple>
</div>

<div class="uploadResult">
	<ul>
	
	</ul>
</div>

<button id='uploadBtn'>Upload</button>

<script src="https://code.jquery.com/jquery-3.3.1.min.js"
        integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
        crossorigin="anonymous"></script>
        
<script>

$(document).ready(function(){
	
	let regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	let maxSize = 5242880;
	
	function checkExtension(fileName, fileSize){
		
		if(fileSize>= maxSize){
			alert("파일 사이즈 초과");
			return false;
		}
		if(regex.test(fileName)){
			alert("해당 파일은 업로드할 수 없습니다.");
			return false;
		}
		return true;
	}
	
	let uploadResult = $(".uploadResult ul");
	let uploadObj = $(".uploadDiv");
		
	function showUploadedFile(uploadResultArr){
			
		let str = "";
		
		$(uploadResultArr).each(function(i, obj){
			
				if(!obj.image){
					str += "<li><img src='/resources/img/attach.png'>" + obj.fileName + "</li>";
				}else{
					str += "<li>" + obj.fileName + "</li>";
				}
	});
	
	$("#uploadBtn").on("click",function(e){
		var formData = new FormData();
		var inputFile = $("input[name='uploadFile']");
		var files = inputFile[0].files;
		
		console.log(files);
		
		for(var i=0;i<files.length;i++){
			
			if(!checkExtension(files[i].name, files[i].size)){
				return false;
			}
			formData.append("uploadFile",files[i]);
		}
		$.ajax({
			url: '/uploadAjaxAction',
			processData: false,
			contentType: false,
			data: formData,
			type: 'POST',
			success: function(result){
				console.log(result);
				
				showUploadedFile(result);
				$(".uploadDiv").html(uploadObj.html());
			}
		}); //$.ajax
	}); 
	}
}); 
	

</script>


</body>

</html>
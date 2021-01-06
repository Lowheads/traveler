<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>


			<form role="form" id="registerform" action="/board/register" method="post" target="_parent" enctype="multipart/form-data">
	
				<div class="form-group">
				 <input type="hidden" class="form-control" name='schNo' id='schNo' value='${schNo }' readonly="readonly">
				</div>
				<div>
				<div style="text-align:center">
				<label class='filecontent'>
					<input type="file" id="boardImg" name="file" class="boardImg" accept='image/jpg, image/png, image/jpeg, image/gif' />
					
					<!-- <label for = 'boardImg' style="display:inline-block"><i class="far fa-file-image"></i>대표사진 선택</label> -->
					<div class="select_img" style="text-align:center"><img src='/resources/img/plusimg.png' border="1px dotted gray" width="420px" height="300px"></div></label>
				</div>
							
				<br>
						
						<script>
						$("[name=boardTitle]").attr("required",true);
						$("#boardImg").change(function() {
							if (this.files && this.files[0]) {
							var reader = new FileReader;
								reader.onload = function(data) {
							$(".select_img img").attr("src", data.target.result)
								.width(420)
								.height(300);
							$(".select_img img").css("border","none");
							}
							reader.readAsDataURL(this.files[0]);
							}
						});
						</script>				
				<br>
				
				</div>
				<div class="form-group">
					<label>게시글 제목</label>
					<input class="form-control" name='boardTitle' id='boardTitle'>
				</div><br>
						<label>공개여부</label> 
					공개<input type="radio" name='hidden' value="y" required checked> 
					비공개<input type="radio" name='hidden' value="n">

				<div style="float:right;">
				<button type="button" class="btn" id="dtregister" >게시글 작성</button>
 				</div>

			</form>

<style>
* { font-family: 'Spoqa Han Sans Neo', 'sans-serif'; }
body{
 margin : 0;
}
#boardImg{
    width: 0.1px;
	height: 0.1px;
	opacity: 0;
	overflow: hidden;
	position: absolute;
	z-index: -1;
}

#boardImg + label {
    border: 1px solid #d9e1e8;
    background-color: #fff;
    color: #2b90d9;
    border-radius: 2rem;
    padding: 8px 17px 8px 17px;
    font-weight: 500;
    font-size: 15px;
    box-shadow: 1px 2px 3px 0px #f2f2f2;
    outline: none;
}

#boardImg:focus + label,
#boardImg + label:hover {
    cursor: pointer;
}

.btn { 
	font-size:15px;
	margin-top: 30px;
	margin-bottom: 30px;
	background-color:#2196f3;
	color: white;
	border: 1px solid #2196f3;
	border-radius: 7px;
	padding: 5px 20px 5px 20px;
	outline: 0;
}
.btn:hover{
   background-color: #2196f3;
   color:white;
   border: 1px solid #2196f3;
   cursor: pointer;
}

.form-control, select, textarea {
  width: 100%;
  padding: 12px;
  border: 1px solid #ccc;
  border-radius: 4px;
  resize: vertical;
}

.select_img img{
border: 1px dashed gray; 
}
</style>
<script type="text/javascript">

 	$('#dtregister').on("click",function(e){
		e.preventDefault();
		var boardTitle=document.getElementById('boardTitle').value;
		var boardImg=document.getElementById('boardImg').value;
		 
		//게시물 제목 입력 체크
		if(boardTitle==""){		
			alert('게시글 제목을 입력하세요');
			return;
		}	
		//게시물 제목 길이 체크
		if((boardTitle.length>60)){
			alert('게시글 제목을 20자 이내로 작성해주세요');
			document.getElementById('boardTitle').value= "";
			return;
		}
		// 대표사진 등록 체크
		if(boardImg==""){
			alert('대표 사진을 등록하세요');
			return;
		}
		
		//게시물 명 중복 체크
		var formObj = $("#registerform");
			formObj.submit();

		
	});

</script>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="includes/adminheader.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>

			<h6 class="m-0 font-weight-bold text-primary">상세 조회하기 </h6>
		</div>
<div class="card-body">



<button id="searchBtn" class="btn btn-primary float-right" 
onClick = "location.href='/admin/modifyTheme/${themeNo}'">수정하기</button><br>

<div class="uploadResult col-sm-12">
</div>

<div class="table-responsive">
	
<table  class="table table-hover" style="width:100%">
<thead>
<tr>
	<th>장소번호</th>
	<th>장소명</th>
	<th>상세주소</th>
	<th>카테고리</th>
	<th>좋아요 수</th>
</tr>
</thead>
<tbody>
<c:forEach items="${list}" var="list">
	<tr name = row id = '<c:out value="${list.plcNo}" />'>
	<td><c:out value="${list.plcNo}" /></td>
		<td><c:out value="${list.plcTitle}" /></td>
		<td><c:out value="${list.addressDt}" /></td>
		<td><c:out value="${list.PCate}" /></td>
		<td><c:out value="${list.likeCnt}" /></td>
	</tr>
</c:forEach>
</tbody>
</table>
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
								<div class="modal-body"></div>
								<div class="modal-footer">
									<button id="modalInBtn" type="button" class="btn btn-primary"
										data-dismiss="modal">확인</button>
									<button id="modalDefaultBtn" type="button"
										class="btn btn-primary" data-dismiss="modal">close</button>

								</div>
							</div>
							<!-- /.modal-content -->

						</div>
						<!-- /.modal-dialog -->
					</div>
					<!-- /.modal -->
					</div>
					</div>
					</div>

<script type="text/javascript" src="/resources/js/admin.js"></script>
<script>

$(document).ready(function() {
	
	const message = '<c:out value="${message}"/>';

	checkModal(message);

	history.replaceState({}, null, null);
	
	var themeNo = ${themeNo};
	
	//이미지 썸네일로 보여주기 
	(function(){
		
		$.getJSON("/admin/getAttachment", {themeNo:themeNo},function(result){
			
			var str="";
			
			var fileCallPath = encodeURIComponent("/s_"+result.uuid+"_"+result.fileName);
			
/* 			str+= "<li data-path='"+result.uploadPath+"'data-uuid='"+result.uuid+"'data-fileName='"+result.fileName+
			"' data-type = '"+result.fileType+"'><div>";
			str+= "<img src='/admin/display?fileName="+fileCallPath+"'>";
			str+="</div>";
			str+="</li>"; */
			

			str+= "<ul data-uuid="+result.uuid+" data-filename="+result.fileName+"><span s>첨부파일</span><span>"+result.fileName+"</span></ul><br>"
			$(".uploadResult").html(str);

		})
			
	})();

	function checkModal(message) {

		if (message === '' || history.state) {
			return;
		}else{
			showModal("수정을 완료하였습니다");
		}
	}
	
	$("tr[name=row]").click(function(){
		
		const plcNum = $(this).attr("id");
	
		let URL = "https://place.map.kakao.com/"+plcNum;
		
		window.open(URL, "카카오 지도", "width=800, height=700, toolbar=no, menubar=no, scrollbars=no, resizable=yes");
		
	})
	
/* 	$(".uploadResult").on("click","img", function(e){
		
		let liObj = $(this).parent().parent();
		
		const path = encodeURIComponent(liObj.data("uuid")+"_"+liObj.data("filename"));
		
		theme.showImage(path.replace(new RegExp(/\\/g),"/"));
		
	}); */
	
	$(".uploadResult").on("click","span", function(e){
		
		let liObj = $(this).parent();
		
		const path = encodeURIComponent(liObj.data("uuid")+"_"+liObj.data("filename"));
		
		theme.showImage(path.replace(new RegExp(/\\/g),"/"));
		
	}); 

	$(".bigPictureWrapper").on("click",function(e){
		$(".bigPicture").animate({width:'0px', height:'0px'});
		setTimeout(() => {
			$(this).hide();
		},300);
		$('body').css("overflow", "scroll");
	});

	function showModal(msg){
		$(".modal-body").html(msg);
		$("#myModal").modal("show");
	};

})

</script>

<%@ include file="includes/adminfooter.jsp"%>
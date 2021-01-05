<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<!DOCTYPE html>
<html lang="en">
<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Gothic+A1&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">
<title>여정 :: 개인 맞춤형 여행플래너</title>
<style>


tr:hover{
	cursor:pointer;
}

.card-header span{
	cursor:pointer;
}

#pagination li{
	margin:3px;
}

#pagination li:hover{
	color:black;
	font-weight:bold;
	text-decoration:underline;
}

.img-card{
	width:200px;
	height:150px;
	margin:10px;
	display:inline-block;
}

.img-card img{
	height:100%;
	width:100%;
	border-radius:4px;
}


.table{
	margin-top:10px;
	font-size: small;
}
.bigPictureWrapper{
	position:absolute;
	display:none;
	justify-content:center;
	align-items:center;
	top:0%;
	width:100%;
	height:100vh;
	background-color:gray;
	z-index:100;
	background:rgba(0,0,0,0.8); 
}

.bigPicture{
	width:100%;
	height:100%;
	position:absolute;
	display:flex; 
 	justify-content:center;
	align-items:center; 
	
}

.bigPicture img{
	max-width:120vh;
	
}


#resultPage li{

	margin:3px 10px;
}



#pagination li{
	 list-style:none;
	 list-style-type:none;
	     padding: 0 0 0 0;
    border : 0;
    float: left;
}

li{
	 list-style-type:none;
    border : 0;
}


.block{
	background-color: white;
	width:500px;
	height:400px;
	border: 1px solid RGB(234,234,234);
	 border-radius: 10px;
	 box-shadow:3px 3px 10px RGB(189,189,189);
	 display:inline-block;
	 margin-left:10px;
	
}

.uploadResult ul{
	display:inline;
	padding : 0px;
	padding-bottom:10px;
} 


</style>
<script>
	const ss = '<%=session.getAttribute("myGrade")%>';
	
	if(ss!="MG002"){
		location.href="/main/index"
	}
	
</script>
<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>SB Admin 2 - Tables</title>

<!-- Custom fonts for this template -->
<link href="/resources/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">
	
	    <!-- chekc -->

<!-- Custom styles for this template -->
<link href="/resources/css/sb-admin-2.min.css" rel="stylesheet">

<!-- Custom styles for this page -->
<link href="/resources/vendor/datatables/dataTables.bootstrap4.min.css"
	rel="stylesheet">

</head>

<body id="page-top">

	<!-- Page Wrapper -->
	<div id="wrapper">
	
		<div class='bigPictureWrapper not_scroll cont'>
			<div class='bigPicture not_scroll cont'></div>
		</div>
		
		<!-- Sidebar -->
		<ul
			class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion"
			id="accordionSidebar">

			<!-- Sidebar - Brand -->
			<a class="sidebar-brand d-flex align-items-center justify-content-center"
				href="/main/index">
				<div class="sidebar-brand-icon rotate-n-15">
					<i class="fas fa-laugh-wink"></i>
				</div>
				<div class="sidebar-brand-text mx-3">
					여행의 정석
				</div>
			</a>

			<!-- Divider -->
			<hr class="sidebar-divider my-0">

			<!-- Nav Item - Dashboard -->
			<li class="nav-item"><a class="nav-link" href="/admin/main">
					<i class="fas fa-fw fa-tachometer-alt"></i> <span>Dashboard</span>
			</a></li>

			<!-- Divider -->
			<hr class="sidebar-divider">

			<!-- Heading -->
			<div class="sidebar-heading">회원관리 </div>

			<!-- Nav Item - Pages Collapse Menu -->
			<li class="nav-item"><a class="nav-link collapsed" href="#"
				data-toggle="collapse" data-target="#collapseTwo"
				aria-expanded="true" aria-controls="collapseTwo"> <i
					class="fas fa-fw fa-cog"></i> <span>회원관리</span>
			</a>
				<div id="collapseTwo" class="collapse" aria-labelledby="headingTwo"
					data-parent="#accordionSidebar">
					<div class="bg-white py-2 collapse-inner rounded">
						<h6 class="collapse-header">-----</h6>
						<a class="collapse-item" href="/admin/userInfo">전체 회원 조회</a> <a
							class="collapse-item" href="/admin/withdraw">탈퇴회원 관리</a>
					</div>
				</div></li>

			<!-- Nav Item - Utilities Collapse Menu -->
			<li class="nav-item"><a class="nav-link collapsed" href="#"
				data-toggle="collapse" data-target="#collapseUtilities"
				aria-expanded="true" aria-controls="collapseUtilities"> <i
					class="fas fa-fw fa-wrench"></i> <span>게시글관리</span>
			</a>
				<div id="collapseUtilities" class="collapse"
					aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
					<div class="bg-white py-2 collapse-inner rounded">
						<h6 class="collapse-header">-----</h6>
						<a class="collapse-item" href="/admin/boardList">전체 게시글 조회하기</a>
					</div>
					
				</div></li>
				<li class="nav-item"><a class="nav-link collapsed" href="#"
				data-toggle="collapse" data-target="#collapsePages"
				aria-expanded="true" aria-controls="collapsePages"> <i
					class="fas fa-fw fa-folder"></i> <span>테마 등록 관리</span>
			</a>
				<div id="collapsePages" class="collapse"
					aria-labelledby="headingPages" data-parent="#accordionSidebar">
					<div class="bg-white py-2 collapse-inner rounded">
						<h6 class="collapse-header">-----</h6>
						<a class="collapse-item" href="/admin/theme">테마보기</a>
					</div>
				</div></li>

			<!-- Divider -->
			<hr class="sidebar-divider">

			<!-- Divider -->
			<hr class="sidebar-divider d-none d-md-block">

			<!-- Sidebar Toggler (Sidebar) -->
			<div class="text-center d-none d-md-inline">
				<button class="rounded-circle border-0" id="sidebarToggle"></button>
			</div>

		</ul>
		<!-- End of Sidebar -->

		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">
					<!-- Main Content -->
			<div id="content">

				<div class="container fluid">	
<div class="card shadow mb-4 right">
<div class="card-header py-3">
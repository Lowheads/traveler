<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- <!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>SB Admin 2 - Bootstrap Admin Theme</title>

    Bootstrap Core CSS
    <link href="/resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    MetisMenu CSS
    <link href="/resources/vendor/metisMenu/metisMenu.min.css" rel="stylesheet">

    DataTables CSS
    <link href="/resources/vendor/datatables-plugins/dataTables.bootstrap.css" rel="stylesheet">

    DataTables Responsive CSS
    <link href="/resources/vendor/datatables-responsive/dataTables.responsive.css" rel="stylesheet">

    Custom CSS
    <link href="/resources/dist/css/sb-admin-2.css" rel="stylesheet">

    Custom Fonts
    <link href="/resources/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">

    HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries
    WARNING: Respond.js doesn't work if you view the page via file://
    [if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]

</head>

<body>

    <div id="wrapper">

        Navigation
        <nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="/board/list">여행의 정석 : 여정</a>
            </div>
            /.navbar-header

            <ul class="nav navbar-top-links navbar-right">
                /.dropdown
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                        <i class="fa fa-user fa-fw"></i> <i class="fa fa-caret-down"></i>
                    </a>
                    <ul class="dropdown-menu dropdown-user">
                        <li><a href="#"><i class="fa fa-user fa-fw"></i> User Profile</a>
                        </li>
                        <li><a href="#"><i class="fa fa-gear fa-fw"></i> Settings</a>
                        </li>
                        <li class="divider"></li>
                        <li><a href="login.html"><i class="fa fa-sign-out fa-fw"></i> Logout</a>
                        </li>
                    </ul>
                    /.dropdown-user
                </li>
                /.dropdown
            </ul>
            /.navbar-top-links

            <div class="navbar-default sidebar" role="navigation">
                <div class="sidebar-nav navbar-collapse">
                    <ul class="nav" id="side-menu">
                        <li class="sidebar-search">
                            <div class="input-group custom-search-form">
                                <input type="text" class="form-control" placeholder="Search...">
                                <span class="input-group-btn">
                                <button class="btn btn-default" type="button">
                                    <i class="fa fa-search"></i>
                                </button>
                            </span>
                            </div>
                            /input-group
                        </li>
                        <li>
                            <a href="#"><i class="fa fa-bar-chart-o fa-fw"></i>&nbsp여행 경비<span class="fa arrow"></span></a>
                            <ul class="nav nav-second-level">
                                <li>
                                    <a href="/budget/list">여행 경비</a>
                                </li>
                                <li>
                                    <a href="/daybud/list">일별 경비</a>
                                </li>
                                <li>
                                    <a href="/board/list">경비 상세</a>
                                </li>
                            </ul>
                            /.nav-second-level
                        </li>
                        <li>
                            <a href="#"><i class="fa fa-files-o fa-fw"></i> Sample Pages<span class="fa arrow"></span></a>
                            <ul class="nav nav-second-level">
                                <li>
                                    <a href="blank.html">Blank Page</a>
                                </li>
                                <li>
                                    <a href="login.html">Login Page</a>
                                </li>
                            </ul>
                            /.nav-second-level
                        </li>
                    </ul>
                </div>
                /.sidebar-collapse
            </div>
            /.navbar-static-side
        </nav>
        
        <div id="page-wrapper">
        
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->
        
<!DOCTYPE html>
<html lang="ko">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<head>
<meta charset="utf-8">
<title>CSS 3000</title>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>SB Admin 2 - Bootstrap Admin Theme</title>

    <link href="/resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <link href="/resources/vendor/metisMenu/metisMenu.min.css" rel="stylesheet">

    <link href="/resources/vendor/datatables-plugins/dataTables.bootstrap.css" rel="stylesheet">

    <link href="/resources/vendor/datatables-responsive/dataTables.responsive.css" rel="stylesheet">

    <link href="/resources/dist/css/sb-admin-2.css" rel="stylesheet">

    <link href="/resources/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">

        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>

</head>

<style type="text/css">

body{
 padding: 0px; 
 margin: 0px; 
 font-family: Times New Roman;
}

ul {
  list-style-type: none;
  margin: 0;
  padding: 0;
  overflow: hidden;
  float : right;
}

li {
 float: left;
 border-radius: 50px;
}

.navbar { /* 전체 메뉴 막대의 속성 */
 overflow: hidden; /* 파악 요구 */
 background-color: white; /* 위와 아래 중에 하나만 있어도 무방 */
 /* background: linear-gradient(90deg, rgb(252, 202, 211), #f0f0ae, #fad2a6, #fbcab3, #fad1ef); */
}

a {
 margin-top: 5px;
 margin-bottom: 5px;
}

.nomargin{
  margin-top: 0;
  margin-bottom: 0;
}

.navbar a { /* 메뉴 막대 위로 보여지는 Home과 News 메뉴의 폰트 속성 */
 float: left; /* 폰트의 배열 시작 위치 */
 font-size: 16px;
 font-family: Arial, Helvetica, sans-serif;
 color: black;
 text-align: center;
 padding: 16px 18px;
 text-decoration: none;
}



.dropdown {
  float: right;
  overflow: hidden;
  font-family: Arial, Helvetica, sans-serif;
}

.dropdown .dropbtn { /* 막대 위로 보여지는 Dropdown 메뉴 폰트의 속성 */
 font-size: 16px; 
 font-family: Arial, Helvetica, sans-serif;
 border: none;
 outline: none;
 color: black; /* 홈, 뉴스 등의 폰트 색상 */
 padding: 16px 18px;
 background-color: inherit;
 font-family: inherit;
 margin: 0;
 border-radius: 5px;
}

.navbar .dropdown:hover .dropbtn { /* a:hover, */
  background-color: #ddd; /* 마우스가 메뉴 위로 올라갈 때, 보여지는 색상 */
}

.dropdown-content { /*내용*/
  display: none;
  position: absolute;
  right: 0;
  background-color: #f9f9f9;
  min-width: 150px;
  box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2); /*그림자*/
  z-index: 1;
  border-radius: 10px;
}

.dropdown-content a {
 float: none;
 color: black;
 padding: 12px 16px;
 text-decoration: none;
 display: block;
 text-align: left;
}

.dropdown-content a:hover {
  background-color: #ddd;
}

.dropdown:hover .dropdown-content {
  display: block;
}

#header {
 padding: 1px;
 margin-bottom: 10px;
 border: 1px solid white;
 background-color: white;
 font-size: 20px;
 color:black;
}

#header > p {
 font-size: 0.85rem;
 color: rgba(10, 0, 0, 0.85);
 text-align: center;
 text-shadow: 1px 1px 1px rgba(0,0,0,0.2);
}

#footer {
 clear: both;
 padding: 20px;
 border: 1px solid whitesmoke;
 background-color: whitesmoke;
}


</style>

  <body> <!--드롭다운메뉴-->
<!--       <div class="navbar">

  <a href="#home" class="nomargin">LOGO</a>
        <ul>
  <div class="dropdown">
    <button onclick="myFunction()" class="dropbtn">회원</button>
    <div id="myDropdown" class="dropdown-content">
      <a href="Main1.html">회원가입</a>
      <a href="#">로그인</a>
      <a href="upcoming.html">로그아웃</a>
    </div>
  </div> 
  
</ul>
</div> -->

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>	
<html>
<head>
  <meta charset="UTF-8">  
  <title>title</title>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"> 
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</head>

<style>

	/* Paging Style Set */

.pagination a {
  color: black;
  float: left;
  padding: 8px 16px;
  text-decoration: none;
}

.pagination a.active {
  background-color: #4CAF50;
  color: white;
}

.pagination a:hover:not(.active) {background-color: #ddd;}

.pagination li{ list-style-type:none; float: left;}

	.container {
		width: 1440px;
		margin: 0 auto;
		
	}
	table a {
        text-decoration: none;
        color: #f9cf74 bold;
    }
    table a:hover {
        color:salmon;
    }
.board {
	border-collapse: collapse;
	margin: 25px 0;
	font-size: 0.9em;
	min-width: 1200px;
	border-radius: 5px 5px 0 0;
	overflow: hidden;
	box-shadow: 0 0 20px rgba(0, 0, 0, 0.15);
	width: 60%;
	margin: auto;
	text-align: center;
}

.board thead tr {
	background-color: #f9cf74;
	color: #ffffff;
	text-align: left;
	font-weight: bold;
}

.board th, .board td {
	padding: 12px 15px;
}

.board tbody tr {
	border-bottom: 1px solid #dddddd;
}

.board tbody tr:nth-of-type(even) {
	background-color: #f5f5f5;
}

.board tbody tr:last-of-type {
	border-bottom: 2px #f9cf74 solid;
}

.board tbody tr.active-row {
	font-weight: bold;
	color: #f9cf74;
}

body {
	padding: 0px;
	margin: 0px;
	font-family: san-serif;
}

#Btn, #regBtn{
	border-top-left-radius: 5px;
	border-bottom-left-radius: 5px;
	margin-right: -4px;
	border: 1px solid white;
	background-color: #f9cf74;
	color: white;
	padding: 5px;
}

.orgImg {
	width: 100px;
	height: 100px;
}

.select_img img {
	margin: 20px 0;
}
</style>
<body>


  <!-- 네비게이션(nav) 컨트롤에 사요하는 드롭다운. -->
  <div style="margin:20px;">
    <nav id="navbar-example" class="navbar navbar-default navbar-static">
      <div class="container-fluid">
        <!-- 네비게이션(nav)의 기본 설정으로 모바일일 때, 메뉴 버튼이 나온다. -->
        <div class="navbar-header">
          <button class="navbar-toggle collapsed" type="button" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <!-- 타이틀임. -->
          <a class="navbar-brand" href="#">여정</a>
        </div>
        <!-- 메뉴 설정 -->
        <div class="collapse navbar-collapse">
          <!-- 메뉴는 왼쪽으로 두개 설정 -->
          <ul class="nav navbar-nav">
            <!-- 메뉴 이름은 Hello로 서브 옵션은 Test1과 Test2가 있다. -->
            
            <!-- 메뉴 이름은 World로 서브 옵션은 Test3과 Test4가 있다. -->
            
          </ul>
          <!-- 메뉴를 오른쪽 정렬로 설정 가능 -->
          <ul class="nav navbar-nav navbar-right">
            <!-- 메뉴 이름은 Right!로 서브 옵션은 Test5와 Test6가 있다. -->
            <li>
              <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                USER
                <!-- 아래 화살표 -->
                <span class="caret"></span>
              </a>
              <ul class="dropdown-menu">
                <li><a href="#">회원가입</a></li>
                <li><a href="#">로그인</a></li>
                <li><a href="#">로그아웃</a></li>
              </ul>
            </li>
          </ul>
        </div>
      </div>
    </nav>
  </div>


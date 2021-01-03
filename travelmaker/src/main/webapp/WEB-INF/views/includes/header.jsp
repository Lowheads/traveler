<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
 
 <!-- 쿠키 -->
 <%
 
      String remember = "";
        String id = "";
        String loginBtn = "";
        String sessionBtn = "";
        String modifyBtn = "";
        String deleteBtn = "";
       String mypage = "";
       String registerBtn = "";
       String qnapage = "";
       String budgetBtn = "";
   // 쿠키 확인
      Cookie[] cookies = request.getCookies();
   if(cookies != null){
      for(int i=0; i < cookies.length; i++){
         if(cookies[i].getName().trim().equals("email")){
         // 쿠키가 있으면 아이디 표시
            id = cookies[i].getValue();
         // id기억하기 체크 표시
            remember = "checked='checked'";
         }
      }
   }
   // 로그인 되었다면, 로그아웃, 정보수정, 회원탈퇴 버튼이 보인다.
   if(session.getAttribute("email") != null){
      sessionBtn = "<li><a href='/member/logout'>로그아웃</a></li>";
      modifyBtn = "<li><a href='/member/getMember?email="+session.getAttribute("email")+"\'\">정보수정</a></li>";
        mypage = "<li><a href='/mypage/pickPL'>위시리스트</a></li>";
        qnapage = "<li><a href='/qnaboard/list'>Q&A게시판</a></li>";
   }
   else{
     sessionBtn = "<li><a href='#' id='login_modal_btn'>로그인 </a></li>";
     registerBtn = "<li><a href='#' id='register_modal_btn'>회원가입</a></li>";
   }
%>
<!DOCTYPE html>
<html lang="en">
    <meta charset="utf-8">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>여정 :: 개인 맞춤형 여행플래너</title>
<head>
<link rel="stylesheet"
   href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<meta charset="utf-8">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

<!-- alert -->
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<!-- JavaScript 파일 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- 생년월일 달력 -->
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="http://code.jquery.com/ui/1.11.4/jquery-ui.min.js"></script>
<!-- datepicker 하나 쓰시는 거니까여 -->
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/i18n/datepicker-ko.js"></script>
<link href='//spoqa.github.io/spoqa-han-sans/css/SpoqaHanSansNeo.css' rel='stylesheet' type='text/css'>
<style>

*{  
	outline:0;
}
/*헤더 스타일 */
a{text-decoration: none;
   color:black;}
a:hover{text-decoration: none;}
a:visited{text-decoration: none;}
:root {
    --grey-med: #ddd;
    --grey-light: #f7f7f7;
    --grey-text-light: #717171;
    --grey-text-dark: #222;
    --pink: #ff385c;
}
.header {
    height: 80px;
    padding: 0 90px;
    display: flex;
    align-items: center;
    box-shadow: rgba(0, 0, 0, 0.08) 0px 1px 12px;
    justify-content: space-between;
    white-space: nowrap;
    z-index:1;
}
.header__logo, .header__nav {
    flex: 1 0 140px;
}
.header__search {
    display: inline-flex;
    border-radius: 24px;
    overflow: hidden;
    align-items: center;
    border: 1px solid var(--grey-med);
    transition: box-shadow 0.2s ease;
}
.header__search:hover {
    box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.18);
}
.header__search button {
    background: transparent;
    height: 40px;
    padding: 0px 16px;
    display: flex;
    align-items: center;
    border: none;
    font-family: 'AirbnbCereal-Medium';
    cursor: pointer;
}
.header__search button:first-of-type {
    padding-left: 24px;
}
.header__search button:last-of-type {
    padding-right: 24px;
}
.header__search span {
    width: 1px;
    height: 24px;
    background: var(--grey-med);
}
.header__searchIcon {
    width: 32px;
    height: 32px;
    border-radius: 50%;
    background: rgb(255, 194, 34);
    display: flex;
    align-items: center;
    justify-content: center;
    margin-left: 16px;
}
.header__searchIcon img {
    width: 12px;
    height: 12px;
}
.header__nav {
    display: flex;
    justify-content: flex-end;
    position: relative;
}
.header__nav__button {
    font-weight: bold;
    background: transparent;
    border: none;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 10px 16px;
    border-radius: 22px;
    cursor: pointer;
    text-decoration: none;
    color: #222;
    height: 40px;
}
.header__nav__button-greyHover:hover {
    background: var(--grey-light);
}
 .header__nav__button-account {
    border: 1px solid var(--grey-med);
    height: 42px;
    border-radius: 22px;
    padding: 5px 5px 5px 12px;
    transition: box-shadow 0.2s ease;
} 
.header__nav__button-account:hover {
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.18);
}
.header__nav__button-account img:first-child {
    height: 18px;
    width: 18px;
}
.header__nav__button-account img:last-child {
    width: 30px;
    height: 30px;
    margin-left: 12px;
}
.header__nav__button-language img:first-child {
    width: 16px;
    height: 16px;
}
.header__nav__button-language img:last-child {
    width: 9px;
    height: 6px;
    margin-left: 6px;
}
.header__drop__menu {
   z-index: 97;
}
.header__nav .active{
   display:flex;
}
.header__nav ul {
    position: absolute;
    background: rgb(255, 255, 255);
    margin-top: 50px;
    padding: 0;
    width: 200px;
    height: 150px;
    display: none;
    /*justify-content: space-around;*/
    align-items: center;
    flex-direction: column;
    list-style: none;
    border-radius: 10px;
    /* pointer-events: none; */
    transform: translateY(-5px);
    transition: all 0.4s ease;
    box-shadow: 0 1px 5px rgba(104, 104, 104, 0.8);
    
}
.header__nav a {
    padding-top: 6.5px;
    width: 100%;
    font-family: AirbnbCereal-Light;
    color: black;
    text-decoration: none;
    height: 30px;
    margin-left: 14px;
}
.header__nav li {
    width: 100%;
    height: 30%;
    display: flex;
    /*justify-content: center;*/
    justify-items: center;
    /*align-items: center;*/
}
.header__nav li:hover {
    background-color: rgb(248, 248, 248);
    cursor: pointer;
}
/* 
.header__nav button:focus + ul {
    pointer-events: all;
    transform: translateY(0px);   
} */
.header__nav li:first-of-type {
    margin-top: 8px;
}
.header__nav li:last-of-type {
    margin-bottom: 18px;
}
.header__nav li:last-child {
    margin-bottom: 100px;
}
/*성현 style */
.login_modal {
   display: none;
   width: 32%;
   height : 600px;
   position: fixed;
   left:30%;
   background: white;
   margin-left: 3.5%;
   z-index: 99;
}
.modal-dialog{
   background-color: white;
   width: 100%;
   height: 100%;
}
.modalCloseBtn{ /* 로그인 닫기 버튼 */
   float: right;
    font-size: 17px;
    font-weight: bold;
    color: black;
    margin: 2%;
}
.reg-modalCloseBtn{
   float: right;
   font-size: 17px;
    font-weight: bold;
    color: black;
    margin-right: 2%;
}
/* --- 또는 ---- */
.hr-sect {
   display: flex;
   flex-basis: 100%;
   align-items: center;
   font-size: 18px;
   color : black;
   margin: 8px 0px;
   padding-left: 20%;
   padding-right: 20%;
   padding-top: 2%;
    padding-bottom: 3%;
}
.hr-sect::before,
.hr-sect::after {
   content: "";
   flex-grow: 1;
   background: #D3D3D3;
   height: 2px;
   font-size: 0px;
   line-height: 0px;
   margin: 0px 16px;
}
.register_modal{
   display: none;
   width: 40%;
   position: fixed;
   left:30%;
   background: white;
   z-index: 99;
}
#man_gender{
   margin-left: 7px;
}
#woman_gender{
   margin-left: 7px;
}
.black_bg {
   display: none;
   position: fixed;
   top: 0;
   left: 0;
   width: 100%;
   height: 100%;
   background-color: rgba(0, 0, 0, 0.5);
   z-index: 10;
}
.aTag{ /* a태그 글씨색 */
   color: black;
}
#email{ /* 회원가입 편지 이미지 */
   background-image: url("/resources/img/email.png");
   background-position: right;
    background-size: 22px 17px;
    background-repeat: no-repeat;
}
#pwd{ /* 회원가입 열쇠 이미지 */
   background-image: url("/resources/img/key.jpg");
   background-position: right;
    background-size: 22px 17px;
    background-repeat: no-repeat;
}
#pwdCfm{ /* 회원가입 열쇠 이미지 */
   background-image: url("/resources/img/key.jpg");
   background-position: right;
    background-size: 22px 17px;
    background-repeat: no-repeat;
}
#nickname{ /* 회원가입 사람 이미지 */
   background-image: url("/resources/img/human.png");
   background-position: right;
    background-size: 22px 17px;
    background-repeat: no-repeat;
}
#birth{ /* 회원가입 케이크 이미지 */
   background-image: url("/resources/img/cake.png");
   background-position: right;
    background-size: 22px 17px;
    background-repeat: no-repeat;
}
.searchPwd_modal{ /* 비밀번호 찾기 모달 */
   display: none;
   width: 32%;
   position: fixed;
   border: 1px solid black;
   left:30%;
   background: white;
   margin-left: 3.5%;
   z-index: 99;
}
.pwdPTag{ /* 비밀번호 찾기 P태그 */
   font-size: 18px;
    color: deeppink;
}
#searchPwdBtn{
   width: 260px;
    height: 50px;
    text-align: center;
    background-color: white;
    color: black;
    border: 1px solid #4e266d;
}
#searchPwdBtn:hover{
   background-color: #ff8b3d;
   color: white;
   border: 1px solid #ff8b3d;
}
#menu_wrap {
   position: absolute;
   top: 0;
   left: 0;
   bottom: 0;
   width: 250px;
   margin: 10px 0 30px 10px;
   padding: 5px;
   overflow-y: auto;
   background: rgba(255, 255, 255, 0.7);
   z-index: 1;
   font-size: 12px;
   border-radius: 10px;
}
#menu_wrap hr {
   display: block;
   height: 1px;
   border: 0;
   border-top: 2px solid #5F5F5F;
   margin: 3px 0;
}
#menu_wrap .option p {
   margin: 10px 0;
}
#menu_wrap .option button {
   margin-left: 5px;
}
#pagination {
   margin: 10px auto;
   text-align: center;
}
#pagination a {
   display: inline-block;
   margin-right: 10px;
}
#pagination .on {
   font-weight: bold;
   cursor: default;
   color: #777;
}
body {
   padding : 0px;
   margin : 0px;
   font-family: 'Spoqa Han Sans Neo,sans-serif';
}
#regBtn {
   border-top-left-radius: 5px;
   border-bottom-left-radius: 5px;
   margin-right: -4px;
   border: 1px solid skyblue;
   background-color: #4774d9;
   color: white;
   padding: 5px;
}
#button { /*로그인 버튼*/
   width: 260px;
   height: 50px;
   text-align: center;
   background-color: white;
   border: 1px solid #4e266d;
}
#button:hover { /*로그인 버튼 hover*/
   color: white;
   background-color: #ff8b3d;
   border: 1px solid #ff8b3d;
}
.wrap-main{
    padding: 5px;
    margin-top: 10px
}
.center {
   text-align: center;
   /* padding: 4px; */
}
.wrap-Addition{ /* email기억하기 & 로그인 */
text-align: center;
   padding: 5px;
}
.wrap-regi-regiBtn{ /* 회원가입 - 가입하기 버튼 */
   text-align: center;
}
.findInfo{ /* 비밀번호 찾기 */
   text-align: center;
   margin-bottom: 10px;
}
.div-reg{
   padding: 5px;
   padding-top: 2px;
   margin-left: 5%;
}
.btn{ /* 닉네임 중복체크 버튼 */
 	width: 130px;
    height: 35px;
    text-align: center;
    background-color: #ff8b3d;
    color: white;
    border: 1px solid white;
    border-radius: 7px;

}
/* dropdown  */
.dropbtn {
  width: 30px;
  height: 3px;
  background-color: black;
  margin: 6px 0;
  font-size: 16px;
  border: none;
}
/* The container <div> - needed to position the dropdown content */
.dropdown {
   margin-top: 10px;
  position: relative;
  display: inline-block;
}
/* Dropdown Content (Hidden by Default) */
.dropdown-content {
  display: none;
  position: absolute;
  right: 0;
  background-color: #f9f9f9;
  min-width: 160px;
  z-index: 1;
}
/* Links inside the dropdown */
.dropdown-content a {
  color: black;
  padding: 12px 16px;
  display: block;
}
/* Change color of dropdown links on hover */
.dropdown-content a:hover {background-color: #f1f1f1}
/* Show the dropdown menu on hover */
.dropdown:hover .dropdown-content {
  display: block;
}
.reg-font{
   font-weight: bold;
   font-size: 17px;
   padding-left: 8%;
   margin-bottom: 1%;
   }
   
/* div > span{
            border:solid 3px rgb(62, 40, 192);  
}
 */
<!-- theme페이지 이미지 슬라이드쇼-->
.submit{
}
.button-btn-submit{
	position:absolute;
	right:2vh;
	top:60vh; 
	background-color: rgba(0,0,0,0.6);
    margin : 3px;
    padding: 7px 14px;
    border-radius: 7px;
    display:inline-block;
    z-index:1;
    font-weight: bold;
    color:rgba(255, 255, 255, 0.9);
}
.button-btn-submit:hover{
	background-color: #ff8b3d;
	color:rgba(255, 255, 255, 0.9);
	font-weight: bold;
}
.dots{
    position:absolute;
    top:5%;
    left:45%;
    z-index:1;
}
.dot {
      margin: 0 2px;
      background-color:rgba(218, 212, 212, 0.7);
      border-radius: 50%;
      display: inline-block;
      transition: background-color 0.6s ease;
       border:solid 2px rgba(128, 128, 128, 0.7);
      cursor: pointer;
      height:20px;
      width: 20px;
      z-index:1;
}
.dot:hover {
   background-color:rgba(82, 82, 82, 0.7);
}
.current{
   background-color:rgba(255, 255, 255, 0.9); 
}
@-webkit-keyframes fade {
  from {opacity: .4}
  to {opacity: 1}
}
@keyframes fade {
  from {opacity: .4}
  to {opacity: 1}
}
.slideWrapper{
   position:relative;
    width:100%;
    height:80%;
}
 .mySlides {
      width:70%;
     height:auto;
     border-radius: 25px;
     margin:0 auto;
     padding-bottom:15px;
      text-align: center;
      position:relative;
     background:rgb(255, 255, 255);
     box-shadow:0 4px 8px 0 rgba(0,0,0,0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
 }
        
 .themeImage{
     width:100%;
     height:65vh;
     overflow:hidden;
     border-radius:25px 25px 0px 0px;
     margin: 0px;
     box-sizing: border-box;
 }
.themeImage img{
    width:100%;
    object-fit: cover;
}
.travel-theme{
   font-weight:bold;
    width:100%;
    height:auto;
    padding: 15px 30px 10px;
    box-sizing: border-box;
    text-align: left;
     font-size: larger;
}
.placeList{
    width:100%;
    height:auto; 
    padding: 5px 25px 5px;   
}
.recPlace{
   height:35px;
    float: left;
    border:solid 2px rgba(213, 213, 213, 0.9);
    margin : 3px;
    padding: 5px 14px;
    border-radius: 7px;
}
.recPlace:hover{
    color:rgba(255, 255, 255, 0.9);
    background-color: #ff8b3d;
    
}
.clicked{
	 color:rgba(255, 255, 255, 0.9);
	background-color: #ff8b3d;
}
.prev, .next {
    cursor: pointer;
    position: absolute;
    top: 35vh;
    margin-top: -22px;
    padding: 16px;
    color: white; 
    font-weight: bold;
    font-size: 18px;
    transition: 0.6s ease;
    border-radius: 0 3px 3px 0;
    user-select: none;
    z-index:1;
    background-color: rgba(0,0,0,0.3);
    }
.prev{
    left:0;
}
    
.next {
  right: 0;
  border-radius: 3px 0 0 3px;
}
.prev:hover, .next:hover {
  background-color: rgba(0,0,0,0.8);
  
}
.reg-input{
   border: 1px solid black;
}
/* 경비스타일  */
        .bg-modal {
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.7);
            position: absolute;
            top: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            display: none;
        }
        /* 폭 여기서 수정 */
        .bg-modal-content {
            width: 600px;
            height: 90%;
            background-color: white;
            border-radius: 5px;
            text-align: center;
            position: fixed;
            z-index:99;
            overflow: auto;
           /*  animation-name: modal-open;
            animation-duration: .2s; */
            display: none;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            msTransform: translate(-50%, -50%);
            webkitTransform: translate(-50%, -50%);
        }
        @keyframes modal-open {
            from {
                transform: translate(0, 100px);
                opacity: .5;
            }
            to {
                transform: translate(0, 0);
                opacity: 1;
            }
        }
        
        body::-webkit-scrollbar,
        .bg-modal-content::-webkit-scrollbar {
            width: 0rem;
        }

       .bg-modal-add{
  		    position: absolute;
            margin-top:3%;
            left: 14px;
  			font-size:15px;
  			background-color:white;
  			border: 1px solid gray;
  			border-radius: 14px;
  			padding: 5px 20px 5px 20px;
  			cursor:pointer;
		}
		.bg-modal-add:hover{
		 	background-color:#ff8b3d;
  		 	color:white;
  		 	border: 1px solid #ff8b3d;
  		 	border-radius: 14px;
		}
        
        
        
        
       .bg-modal-close {
            position: absolute;
            top: 0;
            right: 14px;
            font-size: 52px;
            font-weight: lighter;
            transform: rotate(45deg);
            cursor: pointer;
        }
        .bg-modal-close:hover {
        }
        /* 테이블 */
        .bgwrapper {
            margin-top: 20px;
            display: flex;
            flex-direction: column;
            align-content: center;
            justify-content: center;
        }
        .bgboard {
            width: 90%;
            /*margin: 0 50px 50px 0;*/
            margin: auto;
            white-space: nowrap;
            border-collapse: collapse;
            font-size: 0.9em;
            /*min-width: auto;*/
            overflow: hidden;
            border-radius: 0 0 0 0;
        }
        .bgboard thead tr {
            color: black;
            text-align: left;
            font-size: 19px;
            font-weight: bold;
            border-bottom: 2px solid #dddddd;
        }
        .bgboard th,
        .bgboard td {
            font-weight: lighter;
            text-align: center;
            padding: 12px 23px
        }
        .bgboard tbody tr {
            font-size: 15px;
            border-bottom: 1px solid #dddddd;
            background-color: white;
            height: 70px;
        }
        .bgboard tbody tr:nth-of-type(even) {
            background-color: #fafafa;
        }
        .bgboard tbody tr:last-of-type {
            border-bottom: 1px #dddddd solid;
        }
.budgetschtable {
	 width: 90%;
            /*margin: 0 50px 50px 0;*/
            margin: auto;
            white-space: nowrap;
            border-collapse: collapse;
            font-size: 0.9em;
            /*min-width: auto;*/
            overflow: hidden;
            border-radius: 0 0 0 0;
}
.budgetschtable thead tr {
	  color: black;
            text-align: left;
            font-size: 19px;
            font-weight: bold;
            border-bottom: 2px solid #dddddd;
}
.budgetschtable th, .budgetschtable td {
    font-weight: lighter;
            text-align: center;
            padding: 12px 23px
}
.budgetschtable tbody tr {
	   font-size: 15px;
            border-bottom: 1px solid #dddddd;
            background-color: white;
            height: 70px;
}
.budgetschtable tbody tr:nth-of-type(even) {
	  background-color: #fafafa;
}
.budgetschtable tbody tr:last-of-type {
	border-bottom: 1px #dddddd solid;
}
/* 경비스타일 끝 */
</style>


</head>

<body>

<header class="header">

    <div class="header__logo">
        <a href="/main/index">
            <img src="/resources/icons/tmlogo.png" width="100px" alt="">
        </a>
    </div>

         <div class="header__nav">
        <button type="button" onclick="location.href='/board/list'" class="header__nav__button header__nav__button-greyHover"> 게시판
        </button>

        <button id="budgetbutton" class="header__nav__button
            header__nav__button-language
            header__nav__button-greyHover" style="margin-right: 7px;">
            <img src="/resources/icons/north-korea-won.png" alt="Globe"/>
            <img src="/resources/icons/chevron.png" alt="Globe"/> 
        </button>

        <button class="header__nav__button header__nav__button-account" onclick="dropMenu()"> 
            <img class="accountImg" src="/resources/icons/hamburger.svg" alt="Hamburger"/>
            <img class="accountImg" src="/resources/icons/user-1.png" alt="Account"/>
        </button>
        <ul class="header__drop__menu">
            <%= sessionBtn %>
          <%= modifyBtn %>
           <%= mypage %>
           <%= registerBtn %>
           <%= qnapage %>
        </ul>
    </div>
</header>
    <div class="black_bg"></div>


<% if(session.getAttribute("email") != null){  %>
<!-- 경비모달 html -->
    <!--  모달 안  -->
    <div class="bg-modal-content">
    <!-- BUDGET 추가버튼  -->
    <div class="bg-modal-add">일정추가</div>
        <!-- X 버튼 -->
        <div class="bg-modal-close">+</div>

        <div class="bgwrapper">

            <span style='font-size:60px;'>&#128184;</span>

            <!-- 테이블 -->
            <div class="container-2">
                <table class="bgboard">
         <thead>
            <tr>
               <!-- <th>번호</th> -->
               <th>일정</th>
               <th>지출</th>
               <th>결제 횟수</th>
            </tr>
         </thead>

         <tbody>

            <c:forEach items="${budList}" var="budget">
               <tr>
                  <td><a
                     href='/buddt/listAll?schno=<c:out value="${budget.schno}"/>'> <c:out
                           value="${budget.schtitle}" /></a>
                           <div style="display:flex; flex-direction:column;">
                     <div>
                     <c:out value="${budget.fromdate}" /> ~ <c:out value="${budget.todate}" />
                     </div>
                           </div>
                           </td>
                  <td>₩ <c:out value="${budget.totalpay}" /></td>
                  <td><c:out value="${budget.totalcnt}" /> 건</td>
               </tr>
            </c:forEach>
                    </tbody>
                </table>
            </div>

        </div>

    </div>
<!-- 경비모달 끝 -->
<% } %>
<form action="/budget/list2" id="insertBudget" method="post">
<input type="hidden" name="schNo" id="budgetSchNo" value="">
</form>

<div class="container">

            <!-- 모달 클릭시 뒷 배경 -->
    
    <!-- Login Modal -->
    <div class="login_modal" style="border:1px solid black;">
      <div class="lModal_close"><a class="modalCloseBtn" href="#">X</a></div>   
       
       <div> 
           <p style="text-align: center; font-size: 30px; padding-top: 10px; margin-left: 8%">로그인</p>
        </div>
            
            <div class="wrap-main">
            
            <form action="/member/login" method="post">
               <div class="center" style="margin-bottom: 2%;">
                     <input type="text" style="width: 250px; height: 30px;" 
                     placeholder="이메일" id="login_inputEmail" name="email" value="<%=id %>"></div>
               
               <div class="center">
                     <input type="password" style="width: 250px; height: 30px; margin-bottom: 3%;" 
                     placeholder="비밀번호" id="login_pwd" name="pwd"></div>
               
               <div class="wrap-Addition"  style="font-size: 15px; margin-bottom: 2%;"> 
                  <input type="checkbox" name="remember" <%=remember %>>   email 기억하기</div>
               <div class="wrap-Addition"> 
               <button style="font-size: 20px; " type="submit" id="button" onclick="return loginCheck()">로그인</button> </div>
            </form>
            </div>
            <!-- 또는 영역 -->
         <div class="hr-sect">또는</div> 
               
         <!-- 네이버 로그인 -->
            <div id="naverIdLogin" style="text-align:center; margin-bottom: 0.5%;"><a href="${url}">
            <img src="/resources/img/naverLogin.PNG" style="height: 50px" width="260px"></a>
            <br>
            
            <a href="/member/kakao"> <!-- 카카오 로그인 -->
            <img src="/resources/img/kakaoBtn.png" style="height: 60px" width="288px"></a></div>
            <br>
            
            <div class="findInfo">
            
         <a class="aTag" onclick="fromLoginToRegister()" style="font-size: 15px;">회원가입</a>
         <span style="color: black;">|</span>
         <a class="aTag" onclick="fromLoginToSearchPwd()" id="searchPwd_modal_btn" style="font-size: 15px;">비밀번호 찾기</a>
            </div>
            
            <!-- <p style="padding-bottom: 10px"></p> -->
    </div>
   <!-- end Login Modal -->
   
   
           <!-- 모달 클릭시 뒷 배경 -->
    <div class="black_bg"></div>
    
    <!-- searchPwd Modal -->
    <div class="searchPwd_modal">
    
       <div class="spModal_close"><a class="modalCloseBtn" href="#">X</a></div>

       <div> 
           <p style="text-align: center; font-size: 30px; padding-top: 25px; margin-left: 3%; margin-bottom: -20px;">
           비밀번호 찾기</p>
        </div>
            <p style="padding-bottom: 10px"></p>
            
         <div class="wrap-main">
            
           <form action="/search/sendPwd" method="post">
           
            <div class="center"><p style="font-weight: bold; font-size: 20px">이메일
               <input type="text" style="width: 210px; height: 30px;" 
               id="serachEmail" name="email"></p></div>
         
         <div class="center">
         <p class="pwdPTag">계정으로 사용하시는 이메일 주소를 입력하시면</p>
         <p class="pwdPTag">임시 비밀번호를 전송해드리겠습니다.</p></div>
         
         <div class="center"><input type="submit" id="searchPwdBtn" onclick="return inputCheck()" value="메일 보내기"></div>
         </form>
         
         </div>
         
         <div style="text-align: center;">
            <img src="/resources/img/searchPwd.png" alt="search" style="width: 180px; margin-bottom: 8px;">
         </div>
         
          <div class="findInfo">
            
         <a class="aTag" onclick="fromSearchPwdToRegister()" style="font-size: 15px;">회원가입</a>
         <span style="color: black;">|</span>
         <a class="aTag" onclick="fromSearchPwdToLogin()" style="font-size: 15px;">로그인하러가기</a>
            </div>
         
    </div>
   <!-- end searchPwd Modal -->
   
   
   <!-- register Modal  -->
    <!-- Modal -->
    <div class="register_modal">
    <div id="register" style="background-color:white; border:1px solid black;">
        <!-- 닫기버튼 -->
        <div class="rModal_close"><a class="reg-modalCloseBtn" href="#" style="margin :2%;">X</a></div>

        <div class="modal-dialog" style="display: table;">
            <h4 style="text-align: center; font-size: 30px; margin-left: 4%; margin-top: -20px;">회원가입</h4>
         <div class="wrap-main">
            <form action="/member/joinMember" method="post">
                  
                  <!-- 이메일 -->
                  <div class="reg-font">이메일</div>
                  <div class="div-reg">
                      <input class="reg-input" type="text" name="email" id="email" placeholder="이메일주소" size="30">
                     <button class="btn" type="button" id="emailCheckBtn">이메일 중복체크</button></div>
                 <div class="div-reg"> <span id="spanEmail"></span></div>
                  
                  <!-- 비밀번호 -->
                  <div class="reg-font">비밀번호</div>
                  <div class="div-reg">
                     <input class="reg-input" type="password" name="pwd" id="pwd" placeholder="비밀번호" onblur="pwdCheck()" size="30">
                     비밀번호는 숫자/영문자/특수문자를 모두 포함해주세요
                  <div class="div-reg"><span id="spanPwd"></span></div></div>
                  
                  <!-- 비밀번호 확인 -->
                  <div class="reg-font">비밀번호 확인</div>
                   <div class="div-reg">
                       <input class="reg-input" type="password" name="pwdCfm" id="pwdCfm" placeholder="비밀번호 확인" 
                   onblur="pwdCheck()" size="30">
                     비밀번호 확인
                  <p><span id="spanPwdCfm"></span></p></div>
                     
                  
                  <!-- 닉네임 -->
                  <div class="reg-font">닉네임</div>
                  <div class="div-reg">
                       <input class="reg-input"  type="text" name="nickname" id="nickname" placeholder="닉네임" size="30">
                     <button class="btn" type="button" id="nicknameCheck">중복 체크</button>
                     닉네임은 2~8내로 입력해주세요</div>
                  <div class="div-reg"><span id="spanNickname"></span></div>
                  
                  <!-- 생년월일 -->
                  <div class="reg-font">생년월일</div>
                  <div class="div-reg" style="margin-bottom: 1%;">
                  <input class="reg-input" type="text" name="birth" id="birth" placeholder="누르면 달력이 나와요!" size="30" readonly="readonly"></div>
                  
                  <!-- 성별 -->
                  <div class="reg-font">성별</div>
                   <div class="div-reg">
                     <input type="radio" name="gender" id="man_gender" value="M">남 
                     <input type="radio" name="gender" id="woman_gender" value="F">여
                     <p><span id="spanGender"></span></p>
                   </div>
                  
                  <!-- 상태(정상, 휴면 등...) -->
                  <p><input type="hidden" name="status" id="status" value="MS001"></p>
                  
                  <!-- 등급?(일반회원, 관계자 등..) -->
                  <p><input type="hidden" name="memGrade" id="mem_grade" value="MG001"><p>
                  
               <div class="wrap-regi-regiBtn">
               <button style="font-size: 20px" type="submit" id="button" onclick="return registerValidCheck();">가입하기</button></div>
            </form>
            </div>
            
             <div class="findInfo" style="margin-top: 5px;">
            
         <a class="aTag" onclick="fromRegisterToSearchPwd()" style="font-size: 15px; ">비밀번호 찾기</a>
         <span>|</span>
         <a class="aTag" onclick="fromRegisterToLogin()" style="font-size: 15px;">로그인하러가기</a>
            </div>
            
      </div>
   </div>
        </div>
    </div>
    <script type="text/javascript">
    
    //모달보고 닫는 이벤트 추가
    if(document.getElementById('login_modal_btn')!=null){
    document.getElementById('login_modal_btn').addEventListener('click', lModalShow);
    }
    document.querySelector('.lModal_close').addEventListener('click', lModalClose);
    if(document.getElementById('register_modal_btn')!=null){
    document.getElementById('register_modal_btn').addEventListener('click', rModalShow);
    }
    document.querySelector('.rModal_close').addEventListener('click', rModalClose);
    document.getElementById('searchPwd_modal_btn').addEventListener('click', spModalShow);
    document.querySelector('.spModal_close').addEventListener('click', spModalClose);
    
    //모달 보여지는 메서드
    function lModalShow() {
        document.querySelector('.login_modal').style.display = 'block';
        document.querySelector('.black_bg').style.display = 'block';
    };
    //모달 보여지는 메서드
    function rModalShow() {
        document.querySelector('.register_modal').style.display = 'block';
        document.querySelector('.black_bg').style.display = 'block';
    };
  //모달 보여지는 메서드
    function spModalShow() {
        document.querySelector('.searchPwd_modal').style.display = 'block';
        document.querySelector('.black_bg').style.display = 'block';
    };
    
    //모달 사라지는 메서드
    function lModalClose() {
        document.querySelector('.login_modal').style.display = 'none';
        document.querySelector('.black_bg').style.display = 'none';
    }
    //모달 사라지는 메서드
    function rModalClose() {
        document.querySelector('.register_modal').style.display = 'none';
        document.querySelector('.black_bg').style.display = 'none';
    }
  //모달 사라지는 메서드
    function spModalClose() {
        document.querySelector('.searchPwd_modal').style.display = 'none';
        document.querySelector('.black_bg').style.display = 'none';
    }
    
    // 로그인창에서 회원가입 누르면 실행
    function fromLoginToRegister(){
       lModalClose();
       rModalShow();
    }; // end moveRegisterPage()
    
    // 로그인창에서 비밀번호찾기 누르면 실행
    function fromLoginToSearchPwd(){
       lModalClose();
       spModalShow();
    }; // end moveRegisterPage()
    
    // 비밀번호 찾기 창에서 회원가입 누르면 실행
    function fromSearchPwdToRegister(){
       spModalClose();
       rModalShow();
    }; 
    
    // 비밀번호 찾기창에서 로그인 누르면 실행
    function fromSearchPwdToLogin(){
       spModalClose();
       lModalShow();
    }; 
    
    // 회원가입 찾기창에서 로그인 누르면 실행
    function fromRegisterToLogin(){
       rModalClose();
       lModalShow();
    }; 
    
    // 회원가입 찾기창에서 비밀번호 찾기 누르면 실행
    function fromRegisterToSearchPwd(){
       rModalClose();
       spModalShow();
    }; 
    
    
   // RedirectAttribute 메시지
    let responseMessage = '<c:out value="${msg}" />';
    
       checkAlert(responseMessage);
      
      history.replaceState({}, null, null);
      
      function checkAlert(responseMessage){
         
         if(responseMessage === '' || history.state){
            return;
         }
         
          if(responseMessage.length > 0){ /* 이거 안 해주면 alert 아예 안 뜬다.. */
            swal("", responseMessage);
         } 
      } 
    
    
    /* 회원가입 */
    
 // email 중복체크 버튼 누르면 실행
    $("#emailCheckBtn").click(function() { 
        
       let myEmail = $("#email").val();    // 이메일
       let jEmail = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i; // 이메일정규식
         // 이메일 입력
          if(myEmail.length == 0){
             document.getElementById("spanEmail").innerHTML = "이메일을 입력해주세요";
             spanEmail.style.color='red';
             return;
       }else{
          document.getElementById("spanEmail").innerHTML = "";
       }
        
        // 이메일 정규식
         if(false === jEmail.test(myEmail)) {     
            document.getElementById("spanEmail").innerHTML = "이메일 형식이 잘못되었습니다";
            spanEmail.style.color='red';
             return;  
         }else{
             document.getElementById("spanEmail").innerHTML = "사용할 수 있는 이메일입니다.";
          }       
        
       let email = $("#email").val();
       let sendDate = {'email' : email}
       $.ajax({
          /* async : true, */
          type : 'POST',
          data : sendDate,
          url : "/member/hasEmail",
           success : function(data) { // 성공하면 여기로 넘어옴
              if (data > 0) {
                document.getElementById("spanEmail").innerHTML = "이메일이 중복됩니다.";
                spanEmail.style.color = 'red';
             } else {
                document.getElementById("spanEmail").innerHTML = "사용할 수 있는 이메일입니다.";
                spanEmail.style.color = 'blue';
             }
           }
       });
       
 });
    
 // 닉네임 중복체크 버튼 누르면 실행
    $("#nicknameCheck").click(function() { 
        
       let myNickname = $("#nickname").val();    // 닉네임
       let jNname = /^[ㄱ-ㅎ|가-힣|a-z|A-Z|0-9|\*]+$/; // 닉네임은 문자 제한없이 2~8자리
         // 닉네임 입력
          if(myNickname.length == 0){
             document.getElementById("spanNickname").innerHTML = "닉네임을 입력해주세요";
             spanNickname.style.color='red';
             return;
       }else{
          document.getElementById("spanNickname").innerHTML = "";
       }
       
          // 닉네임은 2~8자리
          if(!(2 <= myNickname.length && myNickname.length <= 8)){
             document.getElementById("spanNickname").innerHTML = "닉네임은 2~8자로 입력해주세요";
             spanNickname.style.color = 'red';
             return;
          }else{
             document.getElementById("spanNickname").innerHTML = "";
          }
        
        // 닉네임 정규식
         if(false === jNname.test(myNickname)) {     
            document.getElementById("spanNickname").innerHTML = "닉네임은 한글/영문/숫자로 2~8자리 부탁드립니다";
            spanNickname.style.color='red';
             return;  
         }else{
             document.getElementById("spanNickname").innerHTML = "사용할 수 있는 닉네임입니다.";
          }       
        
        
       let nickname = $("#nickname").val();
       let sendDate = {'nickname' : nickname}
       $.ajax({
          /* async : true, */
          type : 'POST',
          data : sendDate,
          url : "/member/hasNickname",
           success : function(data) { // 성공하면 여기로 넘어옴
              if (data > 0) {
                document.getElementById("spanNickname").innerHTML = "닉네임이 중복됩니다.";
                spanNickname.style.color = 'red';
             } else {
                document.getElementById("spanNickname").innerHTML = "사용할 수 있는 닉네임입니다.";
                spanNickname.style.color = 'blue';
             }
           }
       });
       
 });
    // 회원가입 유효성체크
 function registerValidCheck() {
    
     // 정규식
     // jEamil = local@앞에 3글자 이상 
    let jEmail = /^[0-9a-zA-Z][0-9a-zA-Z\_\-\.\+]+[0-9a-zA-Z]@[0-9a-zA-Z][0-9a-zA-Z\_\-]*[0-9a-zA-Z](\.[a-zA-Z]{2,6}){1,2}$/;
     let jPwd = /^(?=.*?[a-zA-Z])(?=.*?[#?!@$%^&*-]).{8,}$/; // 숫자/대문자/소문자/특수문자 1개씩은 포함해서 8자리
     let jNname = /^[ㄱ-ㅎ|가-힣|a-z|A-Z|0-9|\*]+$/; // 닉네임은 문자 제한없이 2~8자리
    
     // 스크립트 태그 변수
    let myEmail = $("#email").val();    // 이메일
    let myPwd = $("#pwd").val();       // 비밀번호
    let myPwdCfm = $("#pwdCfm").val();  // 비밀번호 확인
    let myNickname = $("#nickname").val(); // 닉네임
    let myBirth = $("#birth").val();    // 생년월일
   
    // 이메일 입력
    if(myEmail.length == 0){
    	swal("", "이메일 입력 후, 중복체크를 눌러주세요.", "warning");
        $("#email").focus();
        return false;
    }
    
    // 이메일 정규식
     if(false === jEmail.test(myEmail)) {     
     	swal("", "이메일 형식이 잘못되었습니다. \n이메일은 공백없이 3글자 이상입니다.", "warning");
          return false;         
     }                            
    
     // 패스워드 입력
    if(myPwd.length == 0){
     	swal("", "비밀번호를 입력해 주세요.", "warning");
        $("#pwd").focus();
        return false;
    }
     
    // 비밀번호 정규식
    if(false === jPwd.test(myPwd) || myPwd.length > 12) {     
     	swal("", "비밀번호는 8자리 ~ 12자리이며, \n영문/숫자/특수문자를 포함해야합니다.", "warning");
      $("#pwd").focus();
        return false;         
    }   
    
     // 패스워드 확인
     if(myPwd != myPwdCfm){
      	swal("", "비밀번호가 일치하지 않습니다.", "warning");
        $("#pwdCfm").focus();
        return false;
     }
     
     // 비밀번호에 공백 포함 X
     if(myPwd.search(/\s/) != -1){
       	swal("", "비밀번호는 공백 없이 입력해주세요.", "warning");
          return false;
     }
    // 닉네임 입력
    if(myNickname.length == 0){
       	swal("", "닉네임을 입력해주세요.", "warning");
       $("#nickname").focus();
       return false;
    }
    
    // 닉네임은 2~8자리까지만
    if(!(2 <= myNickname.length && myNickname.length <= 8)){
       	swal("", "닉네임은 2~8글자여야 합니다.", "warning");
         $("#nickname").focus();
         return false;
   }
    
    // 닉네임은 영문/한글/숫자만!!
    if(false === jNname.test(myNickname)){
       	swal("", "닉네임은 영문/한글/숫자만 허용됩니다.", "warning");
       $("#nickname").focus();
       return false;
    }
    
     // 생년월일 입력
    if(myBirth.length == 0){
       	swal("", "생년월일을 선택해주세요", "warning");
       $("#birth").focus();
       return false;
    }
   
     // 성별 선택
    if($("input[name=gender]:radio:checked").length < 1){
       	swal("", "성별을 선택해주세요.", "warning");
       return false;
    }
    
    // 필수입력 완료했으니까 회원가입 성공!
    
        return true;
    
 } // end registerValidCheck()
 //   비밀번호 커서 처리(blur)
 function pwdCheck() {
    let jPwd = /^(?=.*?[a-zA-Z])(?=.*?[#?!@$%^&*-]).{8,}$/; // 숫자/대문자/소문자/특수문자 1개씩은 포함해서 8자리
    
    let myPwd = $("#pwd").val();       // 비밀번호
    let myPwdCfm = $("#pwdCfm").val();    // 비밀번호 확인
    
    // 숫자/대문자/소문자/특수문자 1개씩은 포함해서 8~12자리 (공백 당연히 안됨!)
    if(false === jPwd.test(myPwd) || myPwd.search(/\s/) != -1) {
       document.getElementById("spanPwdCfm").innerHTML = "비밀번호는 8자리 ~ 12자리이며, \n영문/숫자/특수문자를 포함해야합니다. 공백없이!!";
         spanPwdCfm.style.color='red';         
         return false;
    }else{
       document.getElementById("spanPwdCfm").innerHTML = "";
    }
    
 // 패스워드 확인
    if (myPwd != myPwdCfm) {
       document.getElementById("spanPwdCfm").innerHTML = "비밀번호가 서로 다릅니다.";
         spanPwdCfm.style.color='red';
         return false;
    }else{
       document.getElementById("spanPwdCfm").innerHTML = "";
    }
    
 }
 
 
   //회원가입시 생년월일 입력 받기
    $("#birth").datepicker(
          {
             changeMonth : true,
             changeYear : true,
             maxDate : 0, // 오늘 날짜이후로 선택 못 함
             minDate : '-80y', // 년 시작일
             nextText : '다음 달',
             prevText : '이전 달',
             yearRange : 'c-80:c+20', // 년 시작~최대 범위
             showButtonPanel : true,
             currentText : '오늘 날짜',
             closeText : '닫기',
             dateFormat : "yy-mm-dd",
             showAnim : "slide",
             showMonthAfterYear : true,
             dayNamesMin : [ '월', '화', '수', '목', '금', '토', '일' ],
             monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월',
                   '7월', '8월', '9월', '10월', '11월', '12월' ]
          });
 //======================회원가입 끝============================================ 
 
   /* 로그인 */
    
 // 로그인 모달 유효성 체크
 function loginCheck(){
    
    let loginInputEmail = $("#login_inputEmail").val();    // 이메일
    let loginPwd = $("#login_pwd").val();       // 비밀번호
    
    // 이메일 입력(로그인)
    if(loginInputEmail.length == 0){
    	swal("", "이메일을 입력해주세요.", "warning");
       $("#login_inputEmail").focus();
       return false;
    }
    
    // 비밀번호 입력(로그인)
    if(loginPwd.length == 0){
    	swal("", "비밀번호를 입력해주세요.", "warning");
       $("#login_pwd").focus();
       return false;
    }
 } // end loginCheck
 
 //======================로그인 끝========================================== 
    
    function sessionCheck(){
    
    if('<%=session.getAttribute("email") %>' == null){
    	swal("", "로그인 후 이용가능합니다.", "warning");
       document.getElementById('register').style.display='block';
       return false;
    };
       return true;
    };
    
   function inputCheck(){ // 입력 널 체크
      
      let searchEmail = $("#serachEmail").val();    // 이메일
      
      // 이메일을 입력 안했다면..
      if(searchEmail.length == 0){
      	swal("", "이메일을 입력해주세요.", "warning");
           return false;
      }
      return true;
   }
     
       
       function dropMenu(){
          
          document.getElementsByClassName('header__drop__menu')[0].classList.toggle('active');
       }
       
       window.onclick = function(event) {
          if (!event.target.matches('.header__nav__button-account') && !event.target.matches('.accountImg')) {
            let dropdowns = document.getElementsByClassName("header__drop__menu");
              if (dropdowns[0].classList.contains('active')) {
                 dropdowns[0].classList.remove('active');
            }
          }
        }
       
       
       //경비
           document.getElementById('budgetbutton').addEventListener('click',
        function () {
        	   if('<%=session.getAttribute("email") %>' != 'null'){
            document.querySelector('.black_bg').style.display = 'block';
            document.querySelector('.bg-modal-content').style.display = 'block';
        	   }
        	   else{
        	    	swal("", "로그인 후 이용가능합니다.", "warning");
        		   return;
        	   }            
        });
           if(document.getElementsByClassName('bg-modal-close')[0]!=null){
    document.querySelector('.bg-modal-close').addEventListener('click',
    function () {
    	$('.budgetschtable').hide();
    	  $('.bgboard').show();
        document.querySelector('.black_bg').style.display = 'none';
        document.querySelector('.bg-modal-content').style.display = 'none';
    })
           }
    
    $(".bg-modal-add").on("click",function(){
    	
    	let sendData = {
    		"email" : '<%=session.getAttribute("email") %>',
    	}
    	
    	  $.ajax({
              type : 'post',
              url : '/main/getSchedule',
              data : sendData,
              success : function(data) {
            	  $('.bgboard').hide();
            	  let schList = "<table class='budgetschtable'><thead><tr><th>날짜</th><th>일정명</th><th>작성여부</th></tr></thead><tbody class='schresult'></tbody><tbody>"
            	  $('.container-2').append(schList)
            	  /* alert(data[0].SCH_NO) */
            	   for (let i = 0; i < data.length; i++) {
            		   let img = "<img src='/resources/img/edit.png'>";
            		   if(data[i].CHECKED == 'BS001' || data[i].CHECKED == 'BS002'){
            			   img = "<img src='/resources/img/check.png'>";
            		   }
            		   let result = "<tr><td>"+getDate(new Date(data[i].FROM_DATE))+" ~ "+getDate(new Date(data[i].TO_DATE))+"</td><td>"+data[i].SCH_TITLE+"</td><td><a href='#' class='gotoBudget' data-schno="+data[i].SCH_NO+" onclick=gotoBudget(this)>"+img+"</a></td></tr>"
					$('.schresult').append(result)
				} 
              },
              error : function(error) {
                 alert("에러발생!! 다시시도해주세요" + error);
              }
           }); 
    	
    })
    
    function getDate(date){
    	let year = date.getFullYear();
    	let month = (1+ date.getMonth());
    	month = month >= 10? month : '0' + month;
    	let day = date.getDate();
    	day = day >= 10 ? day:'0'+day;
    	return year+'-'+month+'-'+day;
    }
    
  	function gotoBudget(atag){
  		if(atag.firstChild.getAttribute('src')=="/resources/img/edit.png"){
  			$('#budgetSchNo').attr("value",atag.dataset["schno"])
  	  		$('#insertBudget').submit();
  		}
  		else{
			return;
  		} 
  		
  	}
</script>
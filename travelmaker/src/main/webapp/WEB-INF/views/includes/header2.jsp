<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>
</head>
<style>
@import
	url('https://fonts.googleapis.com/css2?family=Montserrat:wght@500&display=swap')
	;

* {
	box-sizing: border-box;
	margin: 0;
}

.header-li, .header-a, .header-button {
	font-family: "Montserrat", sans-serif;
	font-weight: 500;
	font-size: 16px;
	color: black;
	text-decoration: none;
}

header {
	display: flex;
	justify-content: flex-end;
	align-items: center;
	padding: 30px 10%;
}

.logo {
	cursor: pointer;
	margin-right: auto;
}

.nav__links {
	list-style: none;
}

.nav__links li {
	display: inline-block;
	padding: 0px 20px;
}

.nav__links li a {
	transition: all 0.4s ease 0s;
}

.nav__links li a:hover {
	color: #f9d270;
}

.header-button {
	margin-left: 20px;
	padding: 9px 25px;
	background-color: rgb(247, 222, 123, 1);
	border: none;
	border-radius: 50px;
	cursor: pointer;
	transition: all 0.3s ease 0s;
}

.header-button:hover {
	background-color: rgba(247, 222, 123, 0.6);
}

h1 {
	margin: 0 25px;
}

.board {
	border-collapse: collapse;
	margin: 25px 25px;
	font-size: 0.9em;
	min-width: 200px;
	border-radius: 5px 5px 0 0;
	overflow: hidden;
	box-shadow: 0 0 20px rgba(0, 0, 0, 0.15);
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
	background-color: white;
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
</style>

<body>

	<div class="container">
		<script
			src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
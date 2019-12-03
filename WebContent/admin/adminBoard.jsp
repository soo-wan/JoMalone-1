<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>adminPage</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">

<style>
       .Menu:hover{
            background-color: red;
        }
        table,tr,th,td{
            border:1px solid black;
        } 
        tr{
        background-color:#e3e3e3;
        }
      	table{
      		width:1500px;
      		margin:auto;
      	text-align:center;
      	}
       #container{
       	height:800px;
     	width:1300px;
     	float:left;
     	padding: 20px;
     	overflow-x:scroll;
     	border:1px solid black;
       }
  
	#sidebar{ float:left; width:150px; margin:0px; padding:0px; }
    #sidebar .menu{ list-style-type: none; text-align: right; margin:15px 0px; color:#1e2d47; width:100%;}
    .menu{height:30px; width:100%;}
    .Wrap{height:800px;  width:200px; margin:0px; float:left; }
    h4{margin:0px; padding:20px 10px; text-align: right; font-size: 20px;  }
    .menu>a{text-decoration: none; color:#1e2d47}
    
    #wrapper{width:1500px; bolder:1px solid black; overflow:hidden; margin:auto; }
</style>
</head>
<body>
<jsp:include page="../Resource/key/topAdmin.jsp" flush="false"/>
<div id="wrapper">
	<div class=Wrap>
		<h4>게시판관리</h4>
			<ul id="sidebar">
			    <li class="menu"><a href="#">공지</a></li>
			    <li class="menu" id="askAll"><a href="#">신규 1:1 문의</a></li>
			    <li class="menu" id="askAll"><a href="#">전체 1:1 문의</a></li>
                <li class="menu"><a href="#">신규 신고글</a></li>
                <li class="menu"><a href="#">전체 신고글</a></li>
                <li class="menu"><a href="#">리뷰</a></li>
			</ul>
      </div>
	<div id="container">
  내용내용
    </div>
    </div>
</body>
</html>
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
     
       }
  
	#sidebar{ float:left; width:150px; margin:0px; padding:0px; }
    #sidebar .menu{ list-style-type: none; text-align: right; margin:15px 0px; color:#1e2d47; width:100%;}
    .menu{height:30px; width:100%; font-family: 'Alata', sans-serif;}
    .Wrap{height:800px;  width:200px; margin:0px; float:left; }
    h4{margin:0px; padding:20px 10px; text-align: right; font-size: 20px; font-family: 'Alata', sans-serif;
    }
    .menu>a{text-decoration: none; color:#1e2d47}
    
    #wrapper{width:1500px; bolder:1px solid black; overflow:hidden; margin:auto; }
</style>
</head>
<body>
<jsp:include page="Resource/key/topAdmin.jsp" flush="false"/>
<div id="wrapper">
	<div class=Wrap>
		<h4>회원 관리</h4>
			<ul id="sidebar">
			    <li class="menu"><a href="#">회원관리</a></li>
             
			</ul>
      </div>
	<div id="container">
    <table>
        <tr cols=14>
            <th>아이디</th>
            <th>로그인타입</th>
            <th>이름</th>
            <th>전화번호</th>
            <th>이메일</th>
            <th>우편번호</th>
            <th>주소1</th>
            <th>주소2</th>
            <th>생년월일</th>
            <th>성별</th>
            <th>가입날짜</th>
            <th>최근로그인</th>
            <th>블랙여부</th>
            <th>블랙날짜</th>
        </tr>
        <c:forEach items="${list }" var="dto">
        <tr>
            <td>${dto.id}</td>
            <td>${dto.logintype}</td>
            <td>${dto.name}</td>
            <td>${dto.phone}</td>
            <td>${dto.email}</td>
            <td>${dto.zip_code}</td>
            <td>${dto.address1}</td>
            <td>${dto.address2}</td>
            <td>${dto.birth}</td>
            <td>${dto.gender}</td>
            <td>${dto.enrolldate}</td>
            <td>${dto.lastlogin}</td>
            <td>${dto.black_yn}</td>
            <td>${dto.blackdate}</td>
        </tr>
        </c:forEach>
    	</table>
    </div>
    </div>
</body>
</html>
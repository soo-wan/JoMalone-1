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
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Alata&display=swap">
<style>
	#sidebar{ float:left; width:200px; margin:0px; padding:0px; }
    #sidebar>.menu{ list-style-type: none; text-align: right; margin:auto; color:#1e2d47; text-align:center;
    padding:0px 10px; width:80%; line-height:30px; background-color : #1e2d47; color:white;}
    .menu{height:30px; width:100%; font-family: 'Alata', sans-serif; border:1px solid black; border-radius:3px;}
    
    .Wrap{height:800px;  width:200px; margin:0px; float:left; }
    h4{margin:0px; padding:20px 20px; text-align: right; font-size: 20px; font-family: 'Alata', sans-serif;
    }
    .menu>a{text-decoration: none; color:white;}
    #wrapper{width:1500px; bolder:1px solid black; overflow:hidden; margin:auto; }
   
	#searchbar{float:left; width:1300px; heigth:30px; text-align:center; margin:auto; padding:0 0 10px 0;
	text-align:center;}
	
    #container{
     height:600px;
     width:1300px;
     float:left;
     padding: 20px;
     overflow-x:scroll;
     background-color:#f2f2f2;}
     
    th {background-color:#1e2d47; color:white;}
    
    table{
	    width:1800px;
	    border-collapse: collapse; 
		border-spacing: 0;		
	    margin:auto;
	    height:30px;
	    text-align:center;
      	}
	
	td{overflow:hidden; white-space : nowrap;}
  	 .contents{height:600px;}
  	 #search,#all{background-color:transparent; border:1px solid black; border-radius:2px;}
     #id, #name, #phone, #logintype{ border-radius:3px; border:1px solid black;}
     input[type=text]{margin: 0 5px 0 0;}
</style>
</head>
<body>
<jsp:include page="Resource/key/topAdmin.jsp" flush="false"/>

<div id="wrapper">
	<div class=Wrap>
		<h4>회원 관리</h4>
			<ul id="sidebar">
			    <li class="menu"><a href='${pageContext.request.contextPath}/admin.mem'> 회원관리</a></li>
			</ul>
      </div>
      
      <div id="searchbar">
    	<form action="${pageContext.request.contextPath}/search.mem" method="post">
    		Logintype  <input type="text" placeholder=" normal/kakao/naver" id="logintype" name="logintype">
	    	ID  <input type="text" placeholder=" 아이디입력" id="id" name="id">
	    	Name <input type="text" placeholder=" 이름입력" id="name" name="name">
	    	Phone <input type="text" placeholder=" 전화번호 '-' 붙혀서 입력" id="phone" name="phone">
	    	<input type="submit" value="검색" id="search">
	    	<input type="button" value="전체보기" id="all">
    	</form>
    	</div>
	<div id="container">
    	<table id="table" border=1px;>
    	<tr>
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
        <c:choose>
        <c:when  test="${AdminId == null }">
        <tr class="contents">
        <td colspan=14>정보가 없습니다.
        </tr>
        </c:when>
        <c:otherwise>
        <c:forEach items="${list }" var="dto">
        <tr>
            <td> ${dto.id} </td>
            <td> ${dto.logintype} </td>
            <td> ${dto.name} </td>
            <td> ${dto.phone} </td>
            <td> ${dto.email} </td>
            <td> ${dto.zip_code} </td>
            <td> ${dto.address1} </td>
            <td> ${dto.address2} </td>
            <td> ${dto.birth} </td>
            <td> ${dto.gender} </td>
            <td> ${dto.enrolldate} </td>
            <td> ${dto.lastlogin} </td>
            <td> ${dto.black_yn} </td>
            <td> ${dto.blackdate}</td>
        </tr>
        </c:forEach>
        </c:otherwise>
        </c:choose>
        
    	</table>
    </div>
    </div>
    <script>
  $("#all").on("click",function(){
	  location.href="${pageContext.request.contextPath}/admin.mem"
  })
    </script>
</body>
</html>
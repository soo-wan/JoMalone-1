<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Top</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Alata&display=swap">    <!-- Jo Malone / Korea -->
<style>
	#top_bar {margin: 0px; height: 25px; background-color: #AAA9AE;}
	#middle_bar {margin: 0px; height: 160px;}
	#title {padding: 30px; text-align: center; font-family: 'Alata', sans-serif;}
	#top-two {padding: 0px;}
	#navbar {margin: 0px; padding: 0px; width: 100%; height: 40px;}
	
	#nav-ul {margin: 0px; padding: 0px; height: 40px; list-style: none;}
	.nav-item {float: left; width: 190px; height: 40px; text-align: center;}
	.nav-link {color: #5D5D5D;}
	.nav-link:hover {color: #5D5D5D;}
	
	#lo-title {padding-top: 8px; font-size: 14px; text-align: center;}
	#con-div {margin: auto; height: 20px;}
	.a-tag {color: black; cursor: pointer;}
	.a-tag:hover {text-decoration: none; color: black;}
	.a-tag>h6 {width: 50%; float:left; text-align: center; font-size: 12px; cursor: pointer;}
	
	#lo-title2 {padding-top: 8px; font-size: 14px; text-align: center;}
	#con-div2 {margin: auto; height: 20px;}
	.b-tag {color: black;}
	.b-tag:hover {text-decoration: none; color: black; cursor: pointer;}
	.b-tag>h6 {width: 50%; float:left; text-align: center; font-size: 12px; cursor: pointer;}
</style>
</head>
<body>
    <div id="top-one" class="container-fulid">
        <div id="top_bar" class="row"></div>
        <div id="middle_bar" class="row">
            <div style="float:left; width: 800px;"></div>
            <div style="float:left; width: 300px;" id="title" style="cursor:pointer;">
				<h1 style="cursor:pointer;">Jo Malone</h1>
				<h5 style="cursor:pointer;">Korea</h5>
			</div>
            <div id="img_bar" style="float:left; padding: 50px 50px 50px 150px; width: 420px; height: 100%;">
            	<div style="float:left;">
            		<img src="/JoMalone/Resource/img/notice.png" style="width:50px; height: 50px; cursor:pointer;">
            	</div>
            	<c:choose>
            	<c:when test="${sessionScope.loginInfo == null }">
            	<div id="info-box" style="float:left;">
            		<img src="/JoMalone/Resource/img/info.png" style="width:50px; height: 50px; cursor:pointer;" id="information" tabindex="0" data-trigger="focus" data-toggle="popover" data-placement="bottom" title="<h6 id='lo-title'>로그인이 필요한 서비스입니다.<h6>" data-html="true" data-content="<div id='con-div'><a class='a-tag' href='/JoMalone/Member/login.jsp'><h6>로그인</h6></a><a id='logout' class='a-tag' href='/JoMalone/Member/signup.jsp'><h6>회원가입</h6></a></div>">
            	</div>
            	</c:when>
            	<c:otherwise>
            	<div id="info-box2" style="float:left;">
            		<img src="/JoMalone/Resource/img/info.png" style="width:50px; height: 50px; cursor:pointer;" id="information" tabindex="0" data-trigger="focus" data-toggle="popover" data-placement="bottom" title="<h6 id='lo-title2'>${sessionScope.name } 회원님 환영합니다.<h6>" data-html="true" data-content="<div id='con-div2'><a class='b-tag' href='/JoMalone/Member/mypage.jsp'><h6>마이페이지</h6></a><a id='logout' class='b-tag' href='logout.log'><h6>로그아웃</h6></a></div>">
            	</div>
            	</c:otherwise>
            	
            	</c:choose>
                <div style="float:left;">
                	<img src="/JoMalone/Resource/img/cart.png" style="width:50px; height: 50px; cursor:pointer;" id="cart">
                </div>
                <div style="float:left;">
                	<img src="/JoMalone/Resource/img/search.png" style="width:50px; height: 50px; cursor:pointer;">
                </div>
            </div>
            <div style="float:left; width: 383px; height: 100%;"></div>
        </div>
    </div>
    
    <div id="top-two" class="container"">
        <div id="navbar" class="row" style="background-color: #F6F6F6; list-style: none;">
			<ul id="nav-ul">
				 <li class="nav-item">
	                <a class="nav-link" href="/JoMalone/Goods/citrus.jsp">Citrus</a>
	            </li>
	            <li class="nav-item">
	                <a class="nav-link" href="/JoMalone/Goods/fruits.jsp">Fruits</a>
	            </li>
	            <li class="nav-item">
	                <a class="nav-link" href="/JoMalone/Goods/woody.jsp">Woody</a>
	            </li>
	            <li class="nav-item">
	                <a class="nav-link" href="/JoMalone/Goods/spicy.jsp">Spicy</a>
	            </li>
	            <li class="nav-item">
	                <a class="nav-link" href="/JoMalone/Goods/floral.jsp">Floral</a>
	            </li>
	            <li class="nav-item">
	                <a class="nav-link" href="/JoMalone/Goods/light_floral.jsp">Light Floral</a>
	            </li>
			</ul>
        </div>
    </div>
    
    <script>
	    $(function () {
	    	$('[data-toggle="popover"]').popover();
	    })
    	    
    	$("#title").on("click", function() {
    		location.href= "/JoMalone/home.jsp";
    	})
		
    	$("#cart").on("click", function() {
    		<c:choose>
    		<c:when test="${loginInfo == null}">
	    		alert("로그인이 필요한 서비스 입니다.");
    			location.href = "/JoMalone/Member/login.jsp";
    		</c:when>
    		<c:otherwise>
    			location.href= "${pageContext.request.contextPath}/list.ca";
    		</c:otherwise>
    		</c:choose>
    	})
    </script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Top</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Alata&display=swap">    <!-- Jo Malone / Korea -->
<link rel="stylesheet" href="/JoMalone/Resource/css/top.css">
<style>
	#top_bar {margin: 0px; height: 25px; background-color: lightgray;}
	#middle_bar {margin: 0px; height: 160px;}
	#title {padding: 30px; text-align: center; font-family: 'Alata', sans-serif;}
	#top-two {padding: 0px;}
	.nav-link {color: dimgray;}
	.nav-link:hover {color: dimgray;}

	#lo-title {padding-top: 8px; font-size: 14px; text-align: center;}
	#con-div {margin: auto; height: 20px;}
	.a-tag {color: black;}
	.a-tag:hover {text-decoration: none; color: black;}
	.a-tag>h6 {width: 50%; float:left; text-align: center; font-size: 12px;}
	
	#lo-title2 {padding-top: 8px; font-size: 14px; text-align: center;}
	#con-div2 {margin: auto; height: 20px;}
	.b-tag {color: black;}
	.b-tag:hover {text-decoration: none; color: black;}
	.b-tag>h6 {width: 50%; float:left; text-align: center; font-size: 12px;}
</style>
</head>
<body>
    <div id="top-one" class="container-fulid">
        <div id="top_bar" class="row"></div>
        <div id="middle_bar" class="row">
            <div style="float:left; width: 800px;"></div>
            <div style="float:left; width: 300px;" id="title" style="cursor:pointer;">
				<h1>Jo Malone</h1>
				<h5>Korea</h5>
			</div>
            <div id="img_bar" style="float:left; padding: 50px 50px 50px 150px; width: 420px; height: 100%;">
            	<div style="float:left;">
            		<img src="/JoMalone/Resource/img/notice.png" style="width:50px; height: 50px; cursor:pointer;">
            	</div>
            	<c:choose>
            	<c:when test="${sessionScope.loginInfo == null}">
            	<div id="info-box" style="float:left;">
            		<img src="/JoMalone/Resource/img/info.png" style="width:50px; height: 50px; cursor:pointer;" id="information" data-toggle="popover" data-placement="bottom" title="<h6 id='lo-title'>로그인이 필요한 서비스입니다.<h6>" data-html="true" data-content="<div id='con-div'><a class='a-tag' href='/JoMalone/Member/login.jsp'><h6>로그인</h6></a><a class='a-tag' href='/JoMalone/Member/signup.jsp'><h6>회원가입</h6></a></div>">
            	</div>
            	</c:when>
            	<c:otherwise>
            	<div id="info-box2" style="float:left;">
            		<img src="/JoMalone/Resource/img/info.png" style="width:50px; height: 50px; cursor:pointer;" id="information" data-toggle="popover" data-placement="bottom" title="<h6 id='lo-title2'>안소희 회원님 환영합니다.<h6>" data-html="true" data-content="<div id='con-div2'><a class='b-tag' href='/JoMalone/Member/mypage.jsp'><h6>마이페이지</h6></a><a id='logout' class='b-tag' href='#'><h6>로그아웃</h6></a></div>">
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
    
    <div id="top-two" class="container">
        <nav class="navbar navbar-expand-md navbar-light p-0">
            <button class="navbar navbar-toggler m-1 border-0 text-center" type="button" data-toggle="collapse" data-target="#navbar">
            <span>Menu</span>	
            </button>
        <div id="navbar" class="collapse navbar-collapse nav-justified" style="background-color: lightgray; list-style: none;">
            <li class="nav-item">
                <a class="nav-link" href="#">Citrus</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">Fruits</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">Woody</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">Spicy</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">Floral</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">Light Floral</a>
            </li>
        </div>
        </nav>
    </div>
    
    <script>
	    $(function () {
	    	  $('[data-toggle="popover"]').popover()
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
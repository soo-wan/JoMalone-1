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
</head>
<body>
    <div id="top-one" class="container-fulid">
        <div id="top_bar" class="row"></div>
        <div id="middle_bar" class="row">
            <div class="col-2"></div>
            <div class="col-2"></div>
            <div id="title" class="col-4" style="cursor:pointer;">
				<h1>Jo Malone</h1>
				<h5>Korea</h5>
			</div>
            <div id="img_bar" class="col-2">
                <img src="/JoMalone/Resource/img/notice.png">
                <img src="/JoMalone/Resource/img/info.png" id="information">
                <img src="/JoMalone/Resource/img/cart.png" id="cart">
                <img src="/JoMalone/Resource/img/search.png">
            </div>
            <div class="col-2"></div>
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
    	$("#title").on("click", function() {
    		location.href= "/JoMalone/home.jsp";
    	})
    
    	$("#information").on("click", function() {
    		<c:choose>
    		<c:when test="${loginInfo == null}">
	    		alert("로그인이 필요한 서비스 입니다.");
	    		location.href = "/JoMalone/Member/login.jsp";
	    	</c:when>
	    	<c:otherwise>
    			location.href = "/JoMalone/Member/mypage.jsp";
        	</c:otherwise>
        	</c:choose>
    	})
    	
    	$("#cart").on("click", function() {
    		<c:choose>
    		<c:when test="${loginInfo == null}">
	    		alert("로그인이 필요한 서비스 입니다.");
    			location.href = "/JoMalone/Member/login.jsp";
    		</c:when>
    		<c:otherwise>
    			location.href= "/JoMalone/Product/cart.jsp";
    		</c:otherwise>
    		</c:choose>
    	})
    </script>
</body>
</html>
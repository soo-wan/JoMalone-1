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
	#top_bar {margin: 0px; height: 25px; background-color: lightgray;}
	#middle_bar {margin: 0px; height: 160px;}
	#title {padding: 30px; text-align: center; font-family: 'Alata', sans-serif;}
	#top-two {padding: 0px;}
	.nav-link {color: dimgray;}
	.nav-link:hover {color: dimgray;}

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
				<h1>Jo Malone</h1>
				<h5>관 리 자</h5>
			</div>

        </div>
    </div>
                <c:choose>
            	<c:when test="${sessionScope.loginInfo == null }">
            	</c:when>
            	</c:choose>
    
    <div id="top-two" class="container">
        <nav class="navbar navbar-expand-md navbar-light p-0">
            <button class="navbar navbar-toggler m-1 border-0 text-center" type="button" data-toggle="collapse" data-target="#navbar">
            <span>Menu</span>	
            </button>
        </nav>
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
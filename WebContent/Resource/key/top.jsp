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
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Alata&display=swap">    <!-- Jo Malone / Korea -->
<style>

	#toptop{height:250px; margin:auto; width:1200px;}
	#top_bar {margin: 0px; height: 25px; background-color: #F6F6F6;}
	#middle_bar {margin: 0px; height: 160px; width:1140px; margin:auto;}
	#title {padding: 30px 0px 30px 200px;  font-family: 'Alata', sans-serif; float:left; width:930px; height:160px; text-align:center;}
	
	#img_bar{float:left; width:210px; height:160px; line-height:160px;}
	 .cart, .search, .information, .notice{float:left; height:160px; padding:55px 0 0 0;}	
	 #cart, #search, #information, #notice{float:left; width:50px; height:50px;}	
	
	#top-two {padding: 0px; margin:auto; height: 40px; width:1140px; background-color: #F6F6F6; line-height:40px;}
	#nav-ul { padding: 0px; height: 40px; list-style: none; width:1140px; float:left; list-style-type: none;}
	.nav-item { float:left; width:190px; height: 100%; line-height:40px; text-align: center; }
	.nav-link2 {color: #5D5D5D; width:100%; display:block; height:40px; text-align: center;  padding:0px; text-decoration-line: none;}
	.nav-link2:hover {color: #5D5D5D; text-decoration-line: none;}
	
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
        <div id="top_bar"></div>
<div id="toptop">
        <div id="middle_bar">
            <div id="title" style="cursor:pointer;">
				<h1 style="cursor:pointer;">Jo Malone</h1>
				<h5 style="cursor:pointer;">Korea</h5>
			</div>
            <div id="img_bar" >
            	<div class="notice">
            		<a href="/JoMalone/list.notice"><img src="/JoMalone/Resource/img/notice3.png" id="notice" style="cursor:pointer;"></a>
            	</div>
            	<c:choose>
            	<c:when test="${sessionScope.loginInfo != null }">
            	<div class="information"  >
            		<img src="/JoMalone/Resource/img/info.png" id="information" style=" cursor:pointer;"  tabindex="0" data-trigger="focus" data-toggle="popover" data-placement="bottom" title="<h6 id='lo-title2'>${sessionScope.name } 회원님 환영합니다.<h6>" data-html="true" data-content="<div id='con-div2'><a class='b-tag' href='/JoMalone/Member/mypage.jsp'><h6>마이페이지</h6></a><a id='logout' class='b-tag' href='${pageContext.request.contextPath}/logout.log'><h6>로그아웃</h6></a></div>">
            	</div>
            	
            	</c:when>
            	<c:when test="${adminId != null }">
            	<div class="information"  >
            		<img src="/JoMalone/Resource/img/info.png" id="information" style=" cursor:pointer;"  tabindex="0" data-trigger="focus" data-toggle="popover" data-placement="bottom" title="<h6 id='lo-title2'>${sessionScope.name } 회원님 환영합니다.<h6>" data-html="true" data-content="<div id='con-div2'><a class='b-tag' href='/JoMalone/Member/mypage.jsp'><h6>마이페이지</h6></a><a id='logout' class='b-tag' href='${pageContext.request.contextPath}/logout.log'><h6>로그아웃</h6></a></div>">
            	</div>
            	</c:when>
            	<c:otherwise>
            	<div class="information"  >
            		<img src="/JoMalone/Resource/img/info.png" id="information" style=" cursor:pointer;"  tabindex="0" data-trigger="focus" data-toggle="popover" data-placement="bottom" title="<h6 id='lo-title'>로그인이 필요한 서비스입니다.<h6>" data-html="true" data-content="<div id='con-div'><a class='a-tag' href='/JoMalone/Member/login.jsp'><h6>로그인</h6></a><a id='logout' class='a-tag' href='/JoMalone/Member/signup.jsp'><h6>회원가입</h6></a></div>">
            	</div>
            	</c:otherwise>
            	</c:choose>
                <div class="cart">
                	<img src="/JoMalone/Resource/img/cart.png" style=" cursor:pointer;" id="cart">
                </div>
                <div class="search">
                	<img src="/JoMalone/Resource/img/search.png" style=" cursor:pointer;" id="search">
                </div>
			</div>
            </div>
   
    
    <div id="top-two" class="container">
			<ul id="nav-ul">
				 <li class="nav-item">
	                <a class="nav-link2" href="${pageContext.request.contextPath}/prod.prod?prod_Category=Citrus&url=citrus.jsp">Citrus</a>
	            </li>
	            <li class="nav-item">
	                <a class="nav-link2" href="${pageContext.request.contextPath}/prod.prod?prod_Category=Fruits&url=fruits.jsp">Fruits</a>
	            </li>
	            <li class="nav-item">
	                <a class="nav-link2" href="${pageContext.request.contextPath}/prod.prod?prod_Category=Woody&url=woody.jsp">Woody</a>
	            </li>
	            <li class="nav-item">
	                <a class="nav-link2" href="${pageContext.request.contextPath}/prod.prod?prod_Category=Spicy&url=spicy.jsp">Spicy</a>
	            </li>
	            <li class="nav-item">
	                <a class="nav-link2" href="${pageContext.request.contextPath}/prod.prod?prod_Category=Floral&url=floral.jsp">Floral</a>
	            </li>
	            <li class="nav-item">
	                <a class="nav-link2" href="${pageContext.request.contextPath}/prod.prod?prod_Category=LightFloral&url=lightfloral.jsp">Light Floral</a>
	            </li>
			</ul>
        </div>
    </div>
</div>
    <script>
	    $("#search").on("click",function(){
	 		alert("현재 준비중인 서비스입니다.");
		})
    
	    $(function () {
	    	$('[data-toggle="popover"]').popover();
	    })
    	    
    	$("#title").on("click", function() {
    		location.href= "/JoMalone/home.jsp";
    	})
		
    	$("#cart").on("click", function() {	
    		console.log("회원" + "${sessionScope.loginInfo}"); //회원아이디
    		console.log("관리자" + "${sessionScope.adminId}"); //admin1
    		var mem = "${sessionScope.loginInfo}";
    		var admin = "${sessionScope.adminId}";
    		if(mem == "" && admin == ""){
	    		alert("로그인이 필요한 서비스 입니다.");
				location.href = "/JoMalone/Member/login.jsp";
    		}
    		else if(mem == "" && admin != ""){
  				alert("지금 로그인 계정은 관리자 계정입니다.");
    			location.href = "${pageContext.request.contextPath}/home.jsp"; 
    		}
    		else{
    			location.href= "${pageContext.request.contextPath}/list.ca";
    		}
    	})
    </script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Top</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>

<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Alata&display=swap">    <!-- Jo Malone / Korea -->
<style>
    #top-one {margin: auto; width: 1500px; height:280px; }
	#top_bar, .top {margin: auto; width: 1500px; height: 25px; background-color:#1e2d47}
	#middle_bar {margin: 0px; height: 160px;}
	#title {padding: 0; text-align: center; font-family: 'Alata', sans-serif;}
	.navi{ float:left ; width:1500px;;background-color: #1e2d47; margin:auto;  height:40px; padding:0px;}
    .navi-item > a {
        width:100%;
        color:#ebebeb;
        height: 100%;
        display:block;
        text-decoration: none;
        font-family: 'Alata', sans-serif;
        
    }
	.navi-item{
		
            float: left;
            list-style-type: none;
            width:300px;
            height: 100%;
            line-height: 40px;
            text-align: center;
            font-family: 'Alata', sans-serif;;
    		font-size: 17px;
        }
    #title{
        margin:auto;
        text-align: center;
        text-decoration: none;
    }
	
    .who{ float:right; padding:0px 5px;}
    #logoutBtn{text-align: center; background-color:transparent;
    border: 1px solid black; border-radius:3px;}
     
</style>
</head>
<body>
     <div id="top-one" class="container-fulid"> 
     <div id="top_bar" ></div> 
        <div id="middle_bar">
            <div style=" width: 800px;"></div>
            <div style="width: 300px;" id="title" style="cursor:pointer;">
				<h1>Jo Malone</h1>
				<h5>관 리 자</h5>
			</div>
			<div class="who">${name}님  
              <div class="who"><button id="logoutBtn" >로그아웃</button></div>
			</div>
        </div>     
    
		
			<ul class="navi">
				<li class="navi-item"><a href="${pageContext.request.contextPath}/admin.mem">회원관리</a></li>
				<li class="navi-item"><a href="${pageContext.request.contextPath}/admin/adminProduct.jsp">상품관리</a></li>
				<li class="navi-item"><a href="${pageContext.request.contextPath}/list.notice">게시판관리</a></li>
				<li class="navi-item"><a href="${pageContext.request.contextPath}/admin/adminDelivery.jsp">배송관리</a></li>
				<li class="navi-item"><a href="${pageContext.request.contextPath}/admin/adminStatistics.jsp">통계</a></li>
			</ul>
	
		</div>
    <script>
	    $(function () {
	    	$('[data-toggle="popover"]').popover();
	    })
    	    
    	$("#title").on("click", function() {
    		location.href= "${pageContext.request.contextPath}/admin.jsp";
    	})
		
    	
    	$("#logoutBtn").on("click",function(){
    		location.href="${pageContext.request.contextPath}/adminlogout.mem"
    	})
    </script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Notice | Jo Malone</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Alata&display=swap">
<style>
#sidebar{ float:left; width:200px; margin:0px; padding:0px; }
    #sidebar>.menu{ list-style-type: none; text-align: right; margin:auto; color:#1e2d47; text-align:center;
    padding:0px 10px; margin: 10px; width:80%; line-height:30px; background-color : #1e2d47; color:white;}
    .menu{height:30px; width:100%; font-family: 'Alata', sans-serif; border:1px solid black; border-radius:3px;}
    
    .Wrap{height:800px;  width:200px; margin:0px; float:left; }
    h4{margin:0px; padding:20px 20px; text-align: right; font-size: 20px; font-family: 'Alata', sans-serif;
    }
    .menu>a{text-decoration: none; color:white;}
    #wrapper{width:1500px; bolder:1px solid black; overflow:hidden; margin:auto; }
    #container{
       	height:800px;
     	width:1300px;
     	float:left;
     	padding: 20px;
     	overflow-x:scroll;
     	border:1px solid black;
    }
       
	#headDiv {padding: 0px;	margin: 0px; padding-top: 20px;	padding-bottom: 20px;}
	#headDiv>div {padding: 0px; margin: 0px; font-weight: bold; font-size: 20px; line-height: 30px;}
	.article {padding-bottom: 10px;}
	.article:hover {background-color: #cbe7ff90;}		
	a:hover {text-decoration: none;}
	.naviBar{
	font-size: 20px;
    word-spacing: 5px;
    font-weight: bold;    
	}
	.naviPage:visited{
	color: black;
	}
</style>
</head>
<body>
<jsp:include page="../Resource/key/topAdmin.jsp" flush="false"/>

<div id="wrapper">
	<div class=Wrap>
		<h4>게시판관리</h4>
			<ul id="sidebar">
			    <li class="menu"><a href="list.notice">공지</a></li>
			    <li class="menu" id="askNew"><a href="newList.ask">신규 1:1 문의</a></li>
			    <li class="menu" id="askAll"><a href="allList.ask">전체 1:1 문의</a></li>
                <li class="menu"><a href="newList.report">신규 신고글</a></li>
                <li class="menu"><a href="allList.report">전체 신고글</a></li>
                <li class="menu"><a href="allList.review">리뷰</a></li>
			</ul>
      </div>
	<div id="container">
				<div class="row" style="text-align: center;" id="headDiv">
			<div class="col-12">공지사항</div>
		</div>
		<div class="row" style="text-align: center;">
			<div class="col-1">번호</div>
			<div class="col-8">제목</div>
			<div class="col-3">등록일</div>			
		</div>
		<hr>
		<c:choose>
			<c:when test="${selectResult.size()==0 }">
				<div class="row">
					<div class="col-12"
						style="text-align: center; height: 500px; line-height: 500px;">등록된 공지가 없습니다.</div>
				</div>
			</c:when>
			<c:otherwise>
				<c:forEach items="${selectResult }" var="dto">
					<div class="row article p-1" style="text-align: center;">
						<div class="col-1">${dto.notice_seq }</div>
						<div class="col-8" style="text-align: left;">
							<a href="read.notice?no=${dto.notice_seq }">${dto.title }</a>							
						</div>
						<div class="col-3">${dto.formedFullDate }</div>						
					</div>
				</c:forEach>
			</c:otherwise>
		</c:choose>
		<hr>
		
		<div class="row" style="text-align: center;">
			<div class="col-12 naviBar" style="color:black;">${pageNavi }</div>
		</div>
		<div class="row">
			<div class="col-12" style="text-align: right;">
				<input type="button" value="메인으로" id="toIndex"> 
				<c:choose>
	                <c:when test="${sessionScope.adminId != null}">
	                    <input type="button" value="공지쓰기" id="toWrite">	                  
	                </c:when>
                </c:choose>			
			</div>
		</div>
    </div>
</div>
    <script>
    $("#toIndex").on("click", function() {
		location.href = "home.jsp";
	});	
	$("#toWrite").on("click", function(){
		location.href = "/JoMalone/noticeboard/NoticeWriteCall.jsp";
	});
    </script>
</body>
</html>
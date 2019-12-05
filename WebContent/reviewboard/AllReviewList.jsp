<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin All Review | Jo Malone</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
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
.naviBar {
	font-size: 20px;
	word-spacing: 5px;
	font-weight: bold;
}
.naviPage:visited {
	color: black;
}
input[type="button"] {width: 100px; height: 30px; border: 0px; background-color: lightgray; font-size: 13px;}
#blindColumn{
	color: crimson;
}
.star_rating {font-size:0; letter-spacing:-4px;}
.star_rating a {
    font-size:15px;
    letter-spacing:0;
    display:inline-block;
    margin-left:-1px;
    color:#ccc;
    text-decoration:none;
}
.star_rating a:first-child {margin-left:0;}
.star_rating a.on {color:#ffd800;}
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
      
      <c:choose>
		<c:when test="${sessionScope.adminId!=null }">		
	<div class=container>
		<div class="row" style="text-align: center;" id="headDiv">
			<div class="col-12">전체 구매 후기</div>
		</div>
		<div class="row" style="text-align: center; font-size:15px;">
			<div class="col-3 d-none d-sm-block">구매상품</div>
			<div class="col-2 d-none d-sm-block">별점</div>
			<div class="col-3 d-none d-sm-block">제목</div>
			<div class="col-1 d-none d-sm-block">작성자</div>
			<div class="col-2 d-none d-sm-block">작성일</div>
			<div class="col-1 d-none d-sm-block">블라인드</div>
		</div>
		<hr>
		<c:choose>
			<c:when test="${selectResult.size()==0 }">
				<div class="row">
					<div class="col-12" style="text-align: center; height: 500px; line-height: 500px;">등록된
						리뷰가 없습니다.</div>
				</div>
			</c:when>
			<c:otherwise>
				<c:forEach items="${selectResult }" var="dto">
					<div class="row article p-1" style="text-align: center; height: 55px;  font-size:15px;" id="reviewItemsRow">
						<div class="col-3">${dto.prod_name }</div>
						<div class="col-2">
							<p class="star_rating">
							    <c:forEach var="i" begin="1" end="${dto.grade}">
									 <a href="#" class="on">★</a>									
								</c:forEach>
								<c:forEach var="i" begin="${dto.grade+1}" end="5">
									 <a href="#">★</a>									
								</c:forEach>
							</p>
						</div>
						<div class="col-3" style="text-align: left;"><a href="read.review?no=${dto.review_seq }&location=adminReviews">${dto.title }</a></div>
						<div class="col-1">${dto.mem_id }</div>
						<div class="col-2">${dto.formedOnlyDate }</div>
						<div class="col-1" id="blindColumn">${dto.blindByReport }</div>						
					</div>
				</c:forEach>
			</c:otherwise>
		</c:choose>
		<hr>
		
				<form action="review.search" method="get" id="searchFrm">
					<div class="row" style="text-align: center;">
						<div class="col-12 searchBar">
							<input type="hidden" name="rootPage" value="fromAdmin"> <select
								name="reviewSearch" id="reviewSearch">
								<option value="title">제목</option>
								<option value="contents">내용</option>
								<option value="prod_name">상품명</option>
								<option value="mem_id">아이디</option>
							</select> <input id="searchInput" name="searchInput" type=text> <input
								type="button" value="검색" id="toSearch">
						</div>
					</div>
				</form>
		
		
		<div class="row" style="text-align: center;">
			<div class="col-12 naviBar" style="color: black;">${pageNavi }</div>
		</div>
		<div class="row">
			<div class="col-12" style="text-align: right;">
				<input type="button" value="메인으로" id="toIndex">
			</div>
		</div>
	</div>
	</c:when>
		<c:otherwise>
		<div><p>잘못된 접근입니다.</p></div>
		</c:otherwise>
	</c:choose>
</div>

	<script>

		$("#reviewItemsRow").children("div").css("line-height","50px");

		$("#toIndex").on("click", function() {
			location.href = "home.jsp";
		});
		$("#toSearch").on("click", function(){
			$("#searchFrm").submit();
		});
	</script>
</body>
</html>
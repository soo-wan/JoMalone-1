<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구매 후기</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<style>
div{
	font-size: 15px;
}

#headDiv {
	padding: 0px;
	margin: 0px;
	padding-top: 20px;
	padding-bottom: 20px;
}

#headDiv>div {
	padding: 0px;
	margin: 0px;
	font-weight: bold;
	font-size: 20px;
	line-height: 30px;
}

.article {
	padding-bottom: 10px;
}

.article:hover {
	background-color: #cbe7ff90;
}

a:hover {
	text-decoration: none;
}

.naviBar {
	font-size: 20px;
	word-spacing: 5px;
	font-weight: bold;
}

.naviPage:visited {
	color: black;
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

	<div class=container>
		<div class="row" style="text-align: center;" id="headDiv">
			<div class="col-12">구매 후기</div>
		</div>
		<div class="row" style="text-align: center;">
			<div class="col-3 d-none d-sm-block">구매상품</div>
			<div class="col-2 d-none d-sm-block">별점</div>
			<div class="col-4 d-none d-sm-block">제목</div>
			<div class="col-1 d-none d-sm-block">작성자</div>
			<div class="col-2 d-none d-sm-block">작성일</div>
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
					<div class="row article p-1" style="text-align: center;">
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
						<div class="col-4" style="text-align: left;"><a href="read.review?no=${dto.review_seq }&location=allReviews&search=${fromSearch}">${dto.title }</a></div>
						<div class="col-1">${dto.blindId }</div>
						<div class="col-2">${dto.formedOnlyDate }</div>						
					</div>
				</c:forEach>
			</c:otherwise>
		</c:choose>
		<hr>
		
				<form action="review.search" method="get" id="searchFrm">
					<div class="row" style="text-align: center;">
						<div class="col-12 searchBar">
							<input type="hidden" name="rootPage" value="listPage"> <select
								name="reviewSearch" id="reviewSearch">
								<option value="title">제목</option>
								<option value="contents">내용</option>
								<option value="prod_name">상품명</option>								
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


	<script>	
		var blindCheck = "${blind}";
		if(blindCheck!=""){
			alert("해당 리뷰는 신고 접수되어 블라인드처리되었습니다.");		
		}
		$("#toIndex").on("click", function() {
			location.href = "home.jsp";
		});
		$("#toSearch").on("click", function(){
			$("#searchFrm").submit();
		});
	</script>
</body>
</html>
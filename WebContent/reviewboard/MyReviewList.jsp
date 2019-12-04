<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의 구매 후기</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
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

.modal {
    display: none;
    position: fixed;
    z-index: 1;
    left: 0;
    top: 0;
    width: 100%; 
    height: 100%; 
   	background-color: #00000040;   
}

.modal-content {
    background-color: #ffffff;
    margin: 15% auto; 
    padding: 20px;
    width: 20%; 
    line-height: 15px;                          
}
#closeBtn{
	cursor:pointer;
	background-color:#dddddd;
	text-align: center;
	font-size: 15px;
	padding-bottom: 10px;
	padding-top: 10px;
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
	
	<c:if test="${overLimit!=null }">
		<div id="myModal" class="modal">
      		<div class="modal-content">
      			<p><br></p> 
                <p style="text-align: center;">해당 주문으로 구매하신 상품에 대한</p>
                <p style="text-align: center;">구매평을 이미 작성하셨습니다^^</p>               
                <p><br></p> 
            	<div id="closeBtn">닫기</div>                            
			</div>
    	</div>
	</c:if>
	
		<div class="row" style="text-align: center;" id="headDiv">
			<div class="col-12">나의 구매 후기</div>
		</div>
		<div class="row" style="text-align: center;">
			<div class="col-3 d-none d-sm-block">구매상품</div>
			<div class="col-2 d-none d-sm-block">별점</div>
			<div class="col-4 d-none d-sm-block">제목</div>
			<div class="col-3 d-none d-sm-block">작성일</div>
		</div>
		<hr>
		<c:choose>
			<c:when test="${selectResult.size()==0 }">
				<div class="row">
					<div class="col-12"
						style="text-align: center; height: 500px; line-height: 500px;">아직 작성하신 구매 후기가 없습니다.</div>
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
						<div class="col-4" style="text-align: left;"><a href="read.review?no=${dto.review_seq }&location=myReviews">${dto.title }</a></div>
						<div class="col-3">${dto.formedFullDate }</div>						
					</div>
				</c:forEach>
			</c:otherwise>
		</c:choose>
		<hr>
		
				<form action="review.search" method="get" id="searchFrm">
					<div class="row" style="text-align: center;">
						<div class="col-12 searchBar">
							<input type="hidden" name="rootPage" value="myPage"> <select
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
	
	$('#myModal').show();
    $("#closeBtn").on("click",function(){
        $('#myModal').hide();        
    });
   
	$("#toIndex").on("click", function() {
		location.href = "index.jsp";
	});
	$("#toSearch").on("click", function(){
		$("#searchFrm").submit();
	});
	</script>
</body>
</html>
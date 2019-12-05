<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Review Detail | Jo Malone</title>
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
    
    
    
    
#titleBox {margin-top: 5px; margin-bottom: 5px;}
	#contents {padding-top: 10px; padding-bottom: 10px;	min-height: 500px;}	
	input[type="button"] {width: 100px; height: 30px; border: 0px; background-color: lightgray; font-size: 13px;}
#toReport,#toDealReview {
	border-style: none;
	background-color: crimson;
	color: white;
	line-height: 25px;
}
.star_rating {font-size:0; letter-spacing:-4px; padding-top: 10px;}
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
	
	
	<c:choose>
	<c:when test="${sessionScope.adminId !=null}">
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
	</c:when>
	<c:otherwise>
	<jsp:include page="/Resource/key/top.jsp" flush="true" />
	</c:otherwise>
</c:choose>

		<div class=container>
		<div class="row" style="text-align: center;" id="headDiv">
			<div class="col-12">상품 후기</div>
		</div>
		<div class="row" id=orderProdBox>
	          <div class="col-12"><span style="font-weight:bold;">${readDTO.prod_name}</span></div>
	     </div>
	    <div class="row" id=starBox>
				<div class="col-12">
					<p class="star_rating">
					    <a href="#">★</a>
					    <a href="#">★</a>
					    <a href="#">★</a>
					    <a href="#">★</a>
					    <a href="#">★</a>
					</p>
				</div>
				<input type=hidden name="grade" id="grade">
			</div>
		<!-- 리뷰제목 -->
		<div class="row" id="titleBox">
			<div class="col-12" style="font-weight: bold;">${readDTO.title}</div>
		</div>
		<div class="row" style="font-size: 13px;">
			<form action="modify.review" method="post" id="modifyFrm">
				<input type=hidden name=reviewSeq id=reviewSeq
					value=${readDTO.review_seq }>
			</form>
			<div class="col-4">작성자 : ${readDTO.blindId }</div>
			<div class="col-8">작성일 : ${readDTO.formedFullDate }</div>
		</div>
		<hr>
		<!-- 리뷰본문 -->
		<div class="row">
			<div class="col-12" id=contents>${readDTO.contents }</div>
		</div>
		<div class="row">
			<div class="col-12" id=blindMsg>
			<c:if test="${readDTO.blind_yn eq 'Y' }">
				<span style="color:crimson;">블라인드 처리된 글입니다.</span>
			</c:if>
			</div>
		</div>
		<hr>
		<div class="row">
			<div class="col-12" style="text-align: right;">
			<c:choose>
				<c:when test="${sessionScope.adminId==null}">
					<input type="button" value="게시글신고" id="toReport"> 
				</c:when>
				<c:otherwise>
					<input type="button" value="게시글관리" id="toDealReview">
				</c:otherwise>
			</c:choose>
				<input type="button" value="목록" id="toMain">
				<c:choose>
					<c:when test="${sessionScope.loginInfo == readDTO.mem_id}">
						<input type="button" value="수정" id="toModify">
						<input type="button" value="삭제" id="toDelete">
					</c:when>
				</c:choose>
			</div>
		</div>
		<br>
	</div>

	<c:choose>
		<c:when test="${sessionScope.adminId !=null}">
		</div>
		</c:when>
		<c:otherwise>
		<jsp:include page="/Resource/key/bottom.jsp" flush="true" />
		</c:otherwise>
	</c:choose>
	
	<script>
	
	$(".star_rating a:nth-child(${readDTO.grade})").prevAll("a").addClass("on");
	$(".star_rating a:nth-child(${readDTO.grade})").addClass("on");
	$("#toMain").on("click", function() {
		
		var fromSearch = "${search}";
		if(fromSearch=="yes"){
			location.href = "review.search?rootPage=${rootPage}&reviewSearch=${reviewSearch}&searchInput=${searchInput}";
		}
		
    	var root = "${root}";
        if(root=="adminReviews"||root=="report"){
        	location.href = "allList.review";            	
        }else if(root=="allReviews"){
        	location.href = "list.review";
        }else{
        	location.href = "myList.review";
        }
    });
    $("#toModify").on("click", function() {
    	document.getElementById("modifyFrm").submit();
    });
    $("#toDelete").on("click", function() {
        var check = confirm("정말 삭제하시겠습니까?");
        if (check) {
           location.href = "${pageContext.request.contextPath}/delete.review?no=${readDTO.review_seq}&location=${root}";
        }
    });        
    $("#toReport").on("click",function(){
       location.href = "write.report?no=${readDTO.review_seq}";
    });
    $("#toDealReview").on("click",function(){
    	location.href="deal.report?no=${readDTO.review_seq}";
    });
    </script>
</body>
</html>
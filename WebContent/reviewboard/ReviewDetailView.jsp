<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구매 후기</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<style>
#titleBox {
	margin-top: 5px;
	margin-bottom: 5px;
}

#contents {
	padding-top: 10px;
	padding-bottom: 10px;
	min-height: 500px;
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

.coWritingDiv {
	padding-top: 20px;
}

#emailCheck {
	font-size: 15px;
}
#toReport {
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
				<input type="button" value="게시글신고" id="toReport"> <input
					type="button" value="리뷰목록" id="toMain">
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

	<script>
		$(".star_rating a:nth-child(${readDTO.grade})").prevAll("a").addClass("on");
		$(".star_rating a:nth-child(${readDTO.grade})").addClass("on");
		$("#toMain").on("click", function() {
			/*
			var fromSearch = "${search}";
			if(fromSearch=="yes"){
				location.href = "review.search?rootPage=${rootPage}&reviewSearch=${reviewSearch}&searchInput=${searchInput}";
			}
			*/
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
    </script>

</body>
</html>
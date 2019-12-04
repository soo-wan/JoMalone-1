<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin | Jo Malone</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<style>
	#headDiv {padding: 0px;	margin: 0px; padding-top: 20px;	padding-bottom: 20px;}
	#headDiv>div {padding: 0px; margin: 0px; font-weight: bold; font-size: 20px; line-height: 30px;}
	.article {padding-bottom: 10px;}
	.article:hover {background-color: #cbe7ff90;}
	a:link {color: black;}
	a:visited {color: #887f7f;}
	a:hover {text-decoration: none;}
</style>
</head>

<body>
	<c:choose>
		<c:when test="${sessionScope.adminId!=null }">
			<div class=container>
				<div class="row" style="text-align: center;" id="headDiv">
					<div class="col-12">신규 1:1 문의</div>
				</div>
				<div class="row" style="text-align: center;">
					<div class="col-2 d-none d-sm-block">문의종류</div>
					<div class="col-7 d-none d-sm-block">제목</div>
					<div class="col-1 d-none d-sm-block">작성자</div>
					<div class="col-2 d-none d-sm-block">날짜</div>
				</div>
				<hr>
				<c:choose>
					<c:when test="${selectResult.size()==0 }">
						<div class="row">
							<div class="col-12"
								style="text-align: center; height: 500px; line-height: 500px;">새로운
								문의글이 없습니다.</div>
						</div>
					</c:when>
					<c:otherwise>
						<c:forEach items="${selectResult }" var="dto">
							<div class="row article p-1" style="text-align: center;">
								<div class="col-2">${dto.askCodeKor }</div>
								<div class="col-7" style="text-align: left;">
									<a href="read.ask?no=${dto.ask_seq }">${dto.title }</a>
								</div>
								<div class="col-1">${dto.mem_id }</div>
								<div class="col-2">${dto.formedFullDate }</div>
							</div>
						</c:forEach>
					</c:otherwise>
				</c:choose>
				<hr>
				<div class="row" style="text-align: center;">
					<div class="col-12 naviBar">${pageNavi }</div>
				</div>
				<div class="row">
					<div class="col-12" style="text-align: right;">
						<input type="button" value="메인으로" id="toIndex">
						<input type="button" value="관리자페이지로" id="toAdminPage">
					</div>
				</div>
			</div>
		</c:when>
		<c:otherwise>
		<div><p>잘못된 접근입니다.</p></div>
		</c:otherwise>
	</c:choose>


	<script>
		$("#toIndex").on("click", function() {
			location.href = "home.jsp";
		});
	</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Spicy | Jo Malone</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<style>
	.look {margin: 10px 0px 5px 0px; width: 100px; height: 30px; border: 0px; background-color: #353535; color: white;}
</style>
</head>
<body>
	<jsp:include page="/Resource/key/top.jsp" flush="false"/>
	
	<div class="container">
		<div class="row" style="margin-bottom: 130px;">
			<img src="/JoMalone/Resource/img/spicy-main.jpg" style="margin: 10px 0px 10px 0px; width: 100%;">
			<div style="width: 100%; height: 0px;">
				<div style="position: relative; bottom: 130px; width: 100%; height: 70px; text-align: center; background-color: #FFC6C6; opacity: 0.6;"></div>
				<div style="position: relative; bottom: 195px; width: 100%; height: 70px; text-align: center;">
					<h4 style="line-height: 35px;">스파이시 코롱</h4>
					<h6 style="line-height: 20px;">따뜻하고 정열적이며 강렬한 매력의 향</h6>
				</div>
			</div>
		</div>
		
		<div class="row" style="margin-bottom: 130px; border: 1px solid green;">
			<c:forEach items="${list}" var="dto">
				<div style="margin: 10px auto 20px auto; width: 300px; height: 300px; border: 1px solid red; text-align: center;">
					<img src="/JoMalone/Resource/img/${dto.productCode}.jpg">
					<h5 style="margin: 10px 0px 10px 0px; font-size: 17px;">${dto.productName }</h5>
					<h6 style="margin: 5px 0px 5px 0px; font-size: 14px;">$${dto.price}</h6>
					<button class =look type=button onclick="toDetail()">자세히보기</button>
				</div>
			</c:forEach>
		</div>
	</div>
	
	<script>
		$(".look").on("click", function() {
			location.href = "/JoMalone/Goods/goods_detail.jsp";
		})
	</script>
	
	<jsp:include page="/Resource/key/bottom.jsp" flush="false"/>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Buy List | Jo Malone</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet" href="/JoMalone/Resource/css/buylist.css">
<style>
*{
	    font-family: -apple-system,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,"Noto Sans",sans-serif,"Apple Color Emoji","Segoe UI Emoji","Segoe UI Symbol","Noto Color Emoji";
}
	#writereview{
		background-color:black;
		color:white;
	}
	a:visited, a:link{
		color:white;	
	}
	#cjInfo:hover{
		color:red;
	}
	#writereview:hover{
		color:red;
	}
</style>

</head>
<body>
	<jsp:include page="/Resource/key/top.jsp" flush="false" />

	<div id="cart-page" class="container">
		<div id="cart-title" class="row">
			<h4>BUY LIST</h4>
		</div>
		<div id="cart-list" class="row">
			<ul class="nav nav-tabs" id="myTab" role="tablist">
				<li class="nav-item"><a class="nav-link active"
					id="korea-title" data-toggle="tab" href="#korea" role="tab"><h6>주문
							내역 조회</h6></a></li>
				<li class="nav-item"><a class="nav-link" id="country-title"
					data-toggle="tab" href="#country" role="tab"><h6>취소/반품/교환
							내역</h6></a></li>

			</ul>
			<div class="tab-content" id="myTabContent">
				<div class="tab-pane fade show active" id="korea" role="tabpanel">
					<table class="cart-table">
						<tr
							style="border-top: 1px solid lightgray; border-bottom: 1px solid lightgray;">
							<td style="width: 150px;">ORDER DATE
							<td colspan="2" style="width: 280px;">ITEM
							<td style="width: 100px;">QTY
							<td style="width: 130px;">PRICE
							<td style="width: 160px;">ORDER STATE
						</tr>
						<c:choose>
							<c:when test="${fn:length(list) == 0}">
								<td colspan="7"
									style="height: 100px; border-bottom: 1px solid lightgray; text-align: center;">주문
									내역이 없습니다.
								</tr>
							</c:when>
							<c:otherwise>
								<c:forEach items="${list}" var="dto">
									<tr class="my-item">
										<td style="width: 150px;">${dto.date}
										<td style="width: 130px;"><img class="item-img" src="/JoMalone/Resource/img/img.jpg">
										<td style="width: 150px;">${dto.prod_name}
										<td style="width: 100px;">${dto.prod_quantity}
										<td style="width: 130px;">${dto.price }
										<td style="width: 160px;">CJ 대한통운 <br>
										<div id="cjInfo">[<a class="button view" id="cj2" style="cursor: pointer;">626978391140</a>]</div>
										<button id=writereview><a href="write.review?seq=${dto.order_seq}&prodName=${dto.prod_name}">리뷰쓰기</a></button>
									</tr>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</table>
				</div>
				<div class="tab-pane fade" id="country" role="tabpanel">
					<table class="cart-table">
						<tr
							style="border-top: 1px solid lightgray; border-bottom: 1px solid lightgray;">
							<td style="width: 50px;"><input type="checkbox">
							<td style="width: 130px;">IMAGE
							<td style="width: 400px;">ITEM
							<td style="width: 130px;">PRICE
							<td style="width: 130px;">QTY
							<td style="width: 130px;">CHARGE
							<td>TOTAL
						</tr>
						<tr>
							<td colspan="7"
								style="height: 100px; border-bottom: 1px solid lightgray; text-align: center;">취소/반품/교환
								내역이 없습니다.
						</tr>
					</table>
				</div>
			</div>
			<div id="page-navi"></div>


		</div>
	</div>

	<jsp:include page="/Resource/key/bottom.jsp" flush="false" />
	<script>
		$("#cj2").click(function() {
			window.open("https://www.cjlogistics.com/ko/tool/parcel/tracking?gnbInvcNo="+$("#cj2").html());
		});

	</script>
</body>
</html>
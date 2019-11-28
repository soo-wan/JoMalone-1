<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cart | Jo Malone</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet" href="/JoMalone/Resource/css/cart.css">
</head>
<body>
	<jsp:include page="/Resource/key/top.jsp" flush="false"/>
	
	<div id="cart-page" class="container">
		<div id="cart-title" class="row"><h4>CART</h4></div>
		<div id="cart-list" class="row">
			<ul class="nav nav-tabs" id="myTab" role="tablist">
			  <li class="nav-item">
			    <a class="nav-link active" id="korea-title" data-toggle="tab" href="#korea" role="tab">국내 배송상품</a>
			  </li>
			  <li class="nav-item">
			    <a class="nav-link" id="country-title" data-toggle="tab" href="#country" role="tab">해외 배송상품</a>
			  </li>
			  <li>
			  	<h6 style="width: 867px; line-height: 50px; text-align: right; font-size: 12px;">장바구니에 담긴 상품은 30일 동안 보관됩니다.</h6> 
			  </li>
			</ul>
			<div class="tab-content" id="myTabContent">
				<div id="all-delete">
					<input id="all-btn" type="button" value="장바구니 비우기">
				</div>
			    <div class="tab-pane fade show active" id="korea" role="tabpanel">
			  	  <table class="cart-table">
			  	  	<tr style="border-top: 1px solid lightgray; border-bottom: 1px solid lightgray;">
			  	  		<td style="width: 50px;"><input type="checkbox">
			  	  		<td style="width: 130px;">IMAGE
			  	  		<td style="width: 400px;">ITEM
			  	  		<td style="width: 130px;">PRICE
			  	  		<td style="width: 130px;">QTY
			  	  		<td style="width: 130px;">CHARGE
			  	  		<td>TOTAL
			  	  	</tr>
			  	  	<tr class="my-item">
			  	  		<td style="width: 50px;"><input type="checkbox">
			  	  		<td style="width: 130px;"><img class="item-img" src="/JoMalone/Resource/img/img.jpg">
			  	  		<td style="width: 400px;">Lime Basil & Mandarin Cologne
			  	  		<td style="width: 130px;">99,000 		
			  	  		<td style="width: 130px;"><input type="text" style="width: 35px; height: 20px; text-align: center;" value="1">
			  	  		<td style="width: 130px;">2,000
			  	  		<td>
			  	  	</tr>
			  	  	<tr class="my-item">
			  	  		<td style="width: 50px;"><input type="checkbox">
			  	  		<td style="width: 130px;"><img class="item-img" src="/JoMalone/Resource/img/img.jpg">
			  	  		<td style="width: 400px;">Lime Basil & Mandarin Cologne
			  	  		<td style="width: 130px;">99,000 		
			  	  		<td style="width: 130px;"><input type="text" style="width: 35px; height: 20px; text-align: center;" value="1">
			  	  		<td style="width: 130px;">2,000
			  	  		<td>
			  	  	</tr>
			  	  </table>
			    </div>
			    <div class="tab-pane fade" id="country" role="tabpanel">
			    	<table class="cart-table">
				  	  	<tr style="border-top: 1px solid lightgray; border-bottom: 1px solid lightgray;">
				  	  		<td style="width: 50px;"><input type="checkbox">
				  	  		<td style="width: 130px;">IMAGE
				  	  		<td style="width: 400px;">ITEM
				  	  		<td style="width: 130px;">PRICE
				  	  		<td style="width: 130px;">QTY
				  	  		<td style="width: 130px;">CHARGE
				  	  		<td>TOTAL
				  	  	</tr>
				  	  	<tr>
				  	  		<td colspan="7" style="height: 100px; border-bottom: 1px solid lightgray; text-align: center;">선택하신 상품이 존재하지 않습니다.
				  	  	</tr>
			  		</table>
			    </div>
			</div>
			<div id="check-delete">
				<h6 style="margin: 10px 10px 0px 7px; float: left; font-size: 12px;">선택상품</h6>
				<input type="button" id="check-btn" value="삭제하기" style="float: left;">
			</div>
			<div id="cart-money">
				<table id="money-table" style="width:100%;">
					<tr style="border-top: 1px solid lightgray; border-bottom: 1px solid lightgray;">
						<td>총 상품금액
						<td>총 배송비
						<td>결제 예정금액
					</tr>
					<tr style="height: 100px; border-bottom: 1px solid lightgray;">
						<td>99,000
						<td>+2,000
						<td>=102,000
					</tr>
				</table>
			</div>
			<div id="money-btn">
				<input class="select-btn" type="button" value="전체상품주문">
				<input class="select-btn" type="button" value="선택상품주문">
			</div>
			<div id="gogo-btn"><input class="gogo-btn" type="button" value="쇼핑계속하기"></div>
		</div>
	</div>
	
	<script>
		$(".select-btn").on("click", function() {
			location.href = "order.jsp";
		})
		
		$(".gogo-btn").on("click", function() {
			location.href = "/JoMalone/home.jsp";
		})
	</script>
	
	<jsp:include page="/Resource/key/bottom.jsp" flush="false"/>
</body>
</html>
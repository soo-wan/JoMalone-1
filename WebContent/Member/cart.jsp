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
			  	  <table id="table">
			  	  	<tr style="border-top: 1px solid lightgray; border-bottom: 1px solid lightgray;">
			  	  		<td style="width: 50px;"><input type="checkbox">
			  	  		<td style="width: 130px;">IMAGE
			  	  		<td style="width: 300px;">ITEM
			  	  		<td style="width: 130px;">PRICE
			  	  		<td style="width: 130px;">QTY
			  	  		<td>CHARGE
			  	  		<td>TOTAL
			  	  	</tr>
			  	  	<tr class="my-item">
			  	  		<td style="width: 50px;"><input type="checkbox">
			  	  		<td style="width: 130px;"><img class="item-img" src="/JoMalone/Resource/img/img.jpg">
			  	  		<td style="width: 300px;">Lime Basil & Mandarin Cologne
			  	  		<td style="width: 130px;">99,000 		
			  	  		<td style="width: ">
			  	  		<td>
			  	  		<td>
			  	  	</tr>
			  	  </table>
			    </div>
			    <div class="tab-pane fade" id="country" role="tabpanel">
			    aaa
			    </div>
			</div>
		</div>
	</div>
	
	<jsp:include page="/Resource/key/bottom.jsp" flush="false"/>
</body>
</html>
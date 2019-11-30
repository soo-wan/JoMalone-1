<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <!-- 화폐 표시 tag lib -->
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cart | Jo Malone</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
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
			    <a class="nav-link active" id="korea-title" data-toggle="tab" href="#korea" role="tab"><h6>국내 배송상품</h6></a>
			  </li>
			  <li class="nav-item">
			    <a class="nav-link" id="country-title" data-toggle="tab" href="#country" role="tab"><h6>해외 배송상품</h6></a>
			  </li>
			  <li>
			  	<h6 style="width: 875px; line-height: 50px; text-align: right; font-size: 12px;">장바구니에 담긴 상품은 30일 동안 보관됩니다.</h6> 
			  </li>
			</ul>
			<div class="tab-content" id="myTabContent">
				<div id="all-delete">
					<!-- <input id="all-btn" type="button" value="장바구니 비우기"> -->
				</div>
			    <div class="tab-pane fade show active" id="korea" role="tabpanel">
			  	  <table class="cart-table">
			  	  	<tr style="border-top: 1px solid lightgray; border-bottom: 1px solid lightgray;">
			  	  		<td style="width: 50px;"><!-- <input type="checkbox">  -->
			  	  		<td style="width: 130px;">IMAGE
			  	  		<td style="width: 400px;">ITEM
			  	  		<td style="width: 130px;">PRICE
			  	  		<td style="width: 130px;">QTY
			  	  		<td style="width: 130px;">CHARGE
			  	  		<td>TOTAL
			  	  	</tr>
			  	  	<c:choose>
			  	  		<c:when test="${list.size() == 0}">
				  	  		<td colspan="7" style="height: 100px; border-bottom: 1px solid lightgray; text-align: center;">선택하신 상품이 존재하지 않습니다.
				  	  	</tr>
						</c:when>
					<c:otherwise>
					<c:forEach items="${list}" var="dto">
						<tr class="my-item">
				  	  		<td style="width: 50px;"><input type="checkbox" id="check${dto.seq}" name="checks" class="delcheck">
				  	  		<td style="width: 130px;"><img class="item-img" src="/JoMalone/Resource/img/img.jpg">
				  	  		<td style="width: 400px;">${dto.prod_name}
				  	  		<td style="width: 130px;">${dto.price} 		
				  	  		<td style="width: 130px;"><input type="text" style="width: 35px; height: 20px; text-align: center;" class="count${dto.seq}" value="${dto.prod_quantity}">
				  	  		<button id="updateBtn" onclick ="updateCart(${dto.seq})">변경</button></td>
				  	  		<td style="width: 130px;">2,000
				  	  		<td><fmt:formatNumber value="${dto.price*dto.prod_quantity+2000}" pattern="#,###" />
							<c:set var= "sum" value="${sum + dto.price*dto.prod_quantity}"/>	
							
				  	  	</tr>
				  	  	</c:forEach>
					</c:otherwise>
			  	  	</c:choose>
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
				<input id="all-btn" type="button" value="장바구니 비우기" style="float: left;">
			</div>
			<div id="cart-money">
				<table id="money-table" style="width:100%;">
					<tr style="border-top: 1px solid lightgray; border-bottom: 1px solid lightgray;">
						<td>총 상품금액
						<td>총 배송비
						<td>결제 예정금액
					</tr>
					<tr style="height: 100px; border-bottom: 1px solid lightgray;">
						<td><fmt:formatNumber value="${sum}" pattern="#,###" /></td>	 <!-- cout 대신에 formatNumber -->	
						<td>+2,000
						<td><fmt:formatNumber value="${sum+2000}" pattern="#,###" /></td>
					</tr>
				</table>
			</div>
			<div id="money-btn">
				<input class="select-btn" type="button" value="전체상품주문">
				<input class="select-btn" type="button" value="선택상품주문">
			</div>
			<div id="gogo-btn"><input class="gogo-btn" type="button" value="쇼핑계속하기"></div>
			<div style="margin-top: 30px; width: 1140px; height: 260px;">
				<h6 style="font-size: 12px; line-height: 20px;">이용안내</h6>
				<h6 style="font-size: 12px; color: darkgray; line-height: 20px;">[장바구니 이용안내]</h6>
				<h6 style="font-size: 11px; color: darkgray; line-height: 20px;">
					1. 해외배송 상품과 국내배송 상품은 함께 결제하실 수 없으니 장바구니 별도 따로 결제해 주시기 바랍니다.<br>
					2. 해외배송 가능 상품의 경우 국내배송 장바구니에 담았다가 해외배송 장바구니로 이동하여 결제하실 수 있습니다.<br>
					3. 선택하신 상품의 수량을 변경하시려면 수량변경 입력창에 갯수 변경을 하시면 됩니다.<br>
					4. [쇼핑계속하기] 버튼을 누르시면 쇼핑을 계속 하실 수 있습니다.<br>
					5. 장바구니와 관심상품을 이용하여 원하시는 상품만 주문하거나 관심상품으로 등록하실 수 있습니다.<br>
				</h6>
				<h6 style="font-size: 12px; color: darkgray; line-height: 20px;">[무이자할부]</h6>
				<h6 style="font-size: 11px; color: darkgray; line-height: 20px;">
					1. 상품별 무이자할부 혜택을 받으시려면 무이자할부 상품만 선택하여 [주문하기] 버튼을 눌러 주문/결제 하시면 됩니다.<br>
					2. [전체상품주문] 버튼을 누르시면 장바구니의 구분없이 선택된 모든 상품에 대한 주문/결제가 이루어집니다.<br>
					3. 단, 전체 상품을 주문/결제하실 경우, 상품별 무이자할부 혜택을 받으실 수 없습니다.<br>
				</h6>
			</div>
		</div>
	</div>
	
	<script>
		$(".select-btn").on("click", function() {
			location.href = "order.jsp";
		})
		
		$(".gogo-btn").on("click", function() {
			location.href = "/JoMalone/home.jsp";
		})
		
		function updateCart(seq){
			var countval = $(".count"+seq).val();
			location.href="update.ca?prod_quantity="+countval+"&seq="+seq;
        }
		
	    // 체크박스 전체 선택&해제
	    $('#ck_all').click(function(){
	         if($("#ck_all").prop("checked")){
	            $("input[type=checkbox]").prop("checked",true); 
	        }else{
	            $("input[type=checkbox]").prop("checked",false); 
	        }
	    });
	    
		$("#check-btn").on("click",function(){ // 선택 체크 삭제
			var check = $(".delcheck").get(); //.get()은 선택한 요소를 배열로 가져온다.
			if(confirm("선택 상품을 삭제하시겠습니까?")){
				for(var i=0;i<check.length;i++){
					//console.log(check[i].value);
					if(check[i].value=="check"){
					//console.log(check[i].id);
					//	ArrayList<String> list = new ArrayList<>();
					//	list.add(check[i].id);
						var seq = check[i].id;
					//	location.href="delete.ca?seq="+list;
						console.log(seq);
						$.ajax({
							url:"delete.ca",
							type:"post",		
							data:{
								seq:seq
							},dataType:"json"
						}).done(function(data){
							console.log("성공");
						}).fail(function(){
							console.log("실패");
						});
					}
				}
			}else{
	            return false;
	        }
		});
		
        $("#all-btn").on("click",function(){
        	if(confirm("정말로 전체 삭제하시겠습니까?")){
            	location.href="deleteAll.ca";
        	}
        })
	</script>
	
	<jsp:include page="/Resource/key/bottom.jsp" flush="false"/>
</body>
</html>
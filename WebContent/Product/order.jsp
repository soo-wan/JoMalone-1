<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
<meta charset="UTF-8">
<title>Order | Jo Malone</title>
<!-- iamport.payment.js -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link rel="stylesheet" href="/JoMalone/Resource/css/order.css">
</head>
<body>
	<jsp:include page="/Resource/key/top.jsp" flush="false"/>
	<form>
	<div id="order-page" class="container">
	    <div id="order-title" class="row"><h4>ORDER</h4></div>
	    <div class="row" style="padding-left: 10px; height: 18px;"><h6 style="font-size: 13px;">국내배송상품 주문내역</h6></div>
	    <div id="order-list" class="row">
	    	<table class="order-table">
				<tr style="border-top: 1px solid lightgray; border-bottom: 1px solid lightgray;">
			  	 	<td style="width: 100px;"><input type="checkbox" id="ck_all">
			  	  		<td style="width: 180px;">상품이미지
			  	  		<td style="width: 300px;">상품명
			  	  		<td style="width: 130px;">가격
			  	  		<td style="width: 130px;">수량
			  	  		<td style="width: 130px;">배송비
			  	  		<td>총 가격
			  	</tr>
			  		<c:choose>
			  	  		<c:when test="${fn:length(list) == 0}">
				  	  		<tr>
					  	  		<td colspan="7" style="height: 100px; border-bottom: 1px solid lightgray; text-align: center;">선택하신 상품이 존재하지 않습니다.
					  	  	</tr>
						</c:when>
						<c:otherwise>
							<c:forEach items="${list}" var="dto">
								<tr class="my-item">
						  	  		<td style="width: 50px;"><input type="checkbox" id="check${dto.seq}" name="checks" class="delcheck" data-cartNum="${dto.seq}">
						  	  		<td style="width: 130px;"><img class="item-img" src="/JoMalone/Resource/img/${dto.prod_code }.jpg">
						  	  		<td style="width: 400px;"><span class=buy_name>${dto.prod_name}</span> 
						  	  		<td style="width: 130px;"><span class=prices>${dto.price}</span> 		
						  	  		<td style="width: 130px;"><span style="width: 35px; height: 20px; text-align: center;" class=prod_quantitys>${dto.prod_quantity}</span>
						  	  		<input type=hidden class="count${dto.seq}" value ="${dto.prod_quantity}" >
						  	  		
				  	  		
						  	  		<td style="width: 130px;">20
						  	  		<td><fmt:formatNumber value="${dto.price*dto.prod_quantity}" pattern="#,###" />
									<c:set var= "sum" value="${sum + dto.price*dto.prod_quantity}"/>	
						  	  	</tr>
						  	</c:forEach>
						</c:otherwise>
			  	  	</c:choose>	
			</table>
	    </div>
	    <div id="money-info" class="row" style="height: 40px; border-bottom: 2px solid lightgray;">
	    	<div style="float: left; margin: 10px 0px 0px 5px;"><h6 style="font-size: 13px;">[기본배송]</h6></div>
	    	<div style="float: left; margin-top: 10px; padding-right: 5px; width: 1070px; text-align: right;">
	    	<h6 style="float:right; width: 335px; text-align: right; font-size: 13px;">
	    	<div style="float:left; margin-left:5px;">상품구매금액 </div>
	    	<div style="float:left; margin-left:5px;" id=ok><fmt:formatNumber value="${sum}" pattern="#,###" /></div>
	    	<div style="float:left; margin-left:5px;"> + 배송비 20원 = 총 가격 = </div>
	    	<div style="float:left; margin-left:5px;" name="totalPrice" id="totalPrice"><fmt:formatNumber value="${sum+20}" pattern="#,###" /></div></h6></div>
	    </div>
	    <div class="row" style="padding: 5px 0px 1px 5px;"><h6 style="font-size: 11px;">** 상품의 옵션 및 수량 변경은 상품상세 또는 장바구니에서 가능합니다.</h6></div>
		<div class="row" style="height: 25px;">
		    <div id="check-delete" style=" width: 150px; height: 25px;">
				<h6 style="margin: 2px 10px 0px 2px; float: left; font-size: 12px;">선택상품</h6>
				<input type="button" id="check-btn" value="삭제하기" style="float: left;">
			</div>
			<div style="width: 987px; height: 25px; text-align: right;">
				<input type="button" id="return" value="이전페이지" style="float: right;">
			</div>
		</div>
		<div class="row" style="margin-top: 70px; height: 25px;">
			<div id="delevery-info" style="width: 100px; height: 25px;">
				<h6 style="margin: 2px 10px 0px 2px; float: left; font-size: 13px;">배송 정보</h6>
			</div>
			<div style="width: 1030px; height: 25px; text-align: right;">
				<h6 style="font-size: 13px; float: right;"><span style="color: crimson">*</span>필수입력사항</h6>
			</div>
		</div>
		<div id="dele-table" class="row" style="height: 332px; border: 1px solid lightgray; border-radius: 5px;">
			<table>
				<tr style="border-bottom: 1px solid lightgray;">
					<td style="width: 100px; height: 20px; text-align: center;"><h6 style="padding-top: 5px;; font-size: 13px;">배송지 선택</h6>
					<td style="padding: 6px 0px 0px 10px; width: 1040px; height: 20px; text-align: left;">
						<input type="radio" style="float: left; margin-top: 1px;" id="memberSame" name= selectinfo>
						<h6 style="float: left; margin-left: 10px; font-size: 13px;">회원정보와 동일</h6>
						<input type="radio" style="float: left; margin: 1px 0px 0px 20px;" id="memberNew" name= selectinfo>
						<h6 style="float: left; margin-left: 9px; font-size: 13px;">새로운 배송지</h6>
				</tr>
				<tr style="border-bottom: 1px solid lightgray;">
					<td style="width: 100px; height: 20px; text-align: center;"><h6 style="padding-top: 5px;; font-size: 13px;">받으시는 분<span style="color: crimson;"> *</span></h6>
					<td style="padding: 0px 0px 0px 10px; width: 1040px; height: 20px; text-align: left;">
					<input type="text" style="width: 200px; height: 20px; border-radius: 5px; border: 1px solid lightgray; font-size: 11px;" name="name" id="name">
				</tr>
				<tr style="border-bottom: 1px solid lightgray;">
					<td style="width: 100px; height: 90px; text-align: center;"><h6 style="padding-top: 5px;; font-size: 13px;">주소<span style="color: crimson;"> *</span></h6>
					<td style="padding-left: 10px; width: 1040px; height: 90px; text-align: left;">
						<input type="text" id="zip_code" style="width: 130px; height: 20px; border-radius: 5px; border: 1px solid lightgray; font-size: 11px;">
						<input type="button" onclick="postcode()" value="주소찾기" style="margin-bottom: 0px; width: 100px; height: 20px; background-color: lightgray; border: 0px; border-radius: 5px; font-size: 11px;"><br>
						<input type="text" id="address1" style="width: 250px; height: 20px; border-radius: 5px; border: 1px solid lightgray; font-size: 11px;"><br>
						<input type="text" id="address2" style="width: 250px; height: 20px; border-radius: 5px; border: 1px solid lightgray; font-size: 11px;"><br>
				</tr>
				<tr style="border-bottom: 1px solid lightgray;">
					<td style="width: 100px; height: 20px; text-align: center;"><h6 style="padding-top: 5px;; font-size: 13px;">일반전화</h6>
					<td style="padding-left: 10px; width: 1040px; height: 20px; text-align: left;">
						<select id="phone4" style="padding-left: 5px; width: 70px; height: 20px; border-radius: 5px; font-size: 13px;">
							<option value="02">02</option>
							<option value="031">031</option>
							<option value="032">032</option>
							<option value="033">033</option>
							<option value="041">041</option>
							<option value="042">042</option>
							<option value="043">043</option>
							<option value="044">044</option>
							<option value="051">051</option>
							<option value="052">052</option>
							<option value="053">053</option>
							<option value="054">054</option>
							<option value="055">055</option>
							<option value="061">061</option>
							<option value="062">062</option>
							<option value="063">063</option>
							<option value="064">064</option>
						</select>
						<span style="margin: 0px 5px 0px 5px; height:20px; color: black;"> - </span>
						<input type="text" id="phone5" style="margin-left: 0px; width: 70px; height: 20px; border-radius: 5px; border: 1px solid lightgray; font-size: 13px;">
						<span style="margin: 0px 5px 0px 5px; height:20px; color: black;"> - </span>
						<input type="text" id="phone6" style="margin-left: 0px; width: 70px; height: 20px; border-radius: 5px; border: 1px solid lightgray; font-size: 13px;">						
				</tr>
				<tr style="border-bottom: 1px solid lightgray;">
					<td style="width: 100px; height: 20px; text-align: center;"><h6 style="padding-top: 5px;; font-size: 13px;">휴대전화<span style="color: crimson;"> *</span></h6>
					<td style="padding-left: 10px; width: 1040px; height: 20px; text-align: left;">
						<select  id="phone1" style="padding-left: 5px; width: 70px; height: 20px; border-radius: 5px; font-size: 13px;">
							<option value="010">010</option>
							<option value="011">011</option>
							<option value="016">016</option>
							<option value="017">017</option>
							<option value="017">018</option>
							<option value="017">019</option>
						</select>
						<span style="margin: 0px 5px 0px 5px; height:20px; color: black;"> - </span>
						<input type="text"  id="phone2" style="margin-left: 0px; width: 70px; height: 20px; border-radius: 5px; border: 1px solid lightgray; font-size: 13px;">
						<span style="margin: 0px 5px 0px 5px; height:20px; color: black;"> - </span>
						<input type="text"  id="phone3" style="margin-left: 0px; width: 70px; height: 20px; border-radius: 5px; border: 1px solid lightgray; font-size: 13px;">						
				</tr>
				<tr style="border-bottom: 1px solid lightgray;">
					<td style="width: 100px; height: 50px; text-align: center;"><h6 style="padding-top: 5px;; font-size: 13px;">이메일</h6>
					<td style="padding-left: 10px; width: 1040px; height: 50px; text-align: left;">
						<input  id="email1" type="text" style="margin-left: 0px; width: 130px; height: 20px; border-radius: 5px; border: 1px solid lightgray; font-size: 13px;">
						<span style="margin: 0px 5px 0px 5px; height:20px; color: black;"> @ </span>
						<input  id="email2"type="text" placeholder="직접입력" name="writeEmail" style="margin-left: 0px; padding-left: 7px; width: 130px; height: 20px; border-radius: 5px; border: 1px solid lightgray; font-size: 13px;">
						<select id="email3" style="margin-left: 10px; padding-left: 5px; width: 105px; height: 20px; border-radius: 5px; border: 1px solid lightgray; font-size: 13px;">
							<option value="input">-- 선택없음</option>
							<option value="naver.com">naver.com</option>
							<option value="daum.net">daum.net</option>
							<option value="gmail.com">gmail.com</option>
						</select>
						<br>
						<h6 style="line-height: 25px; font-size: 11px;">이메일을 통해 결제완료내역을 보내드립니다.</h6>
				</tr>
				<tr>
					<td style="width: 100px; height: 20px; text-align: center;"><h6 style="padding-top: 5px;; font-size: 13px;">배송메시지</h6>
					<td style="padding: 5px 0px 0px 10px; width: 1040px; height: 20px; text-align: left;">
						<textarea cols="50" rows="2" style="resize: none; border: 1px solid lightgray; padding-left: 10px; border-radius: 5px; font-size: 12px;" id="textA">부재시 경비실에 맡겨주세요.</textarea>
				</tr>
			</table>
		</div>
		<div class="row" style="margin-top: 70px; height: 25px;">
			<div id="payment-money" style="width: 100%; height: 25px;">
				<h6 style="margin: 2px 10px 0px 2px; font-size: 13px;">결제 예정 금액</h6>
			</div>
		</div>
		<div class="row">
			<table id="money-table" style="width:100%; text-align: center;">
				<tr style="border-top: 1px solid lightgray; border-bottom: 1px solid lightgray;">
					<td>총 상품금액
					<td>총 배송비
					<td>결제 예정금액
				</tr>
				<tr style="height: 100px; border-bottom: 1px solid lightgray;">
					<td><fmt:formatNumber value="${sum}" pattern="#,###" />
					<td>+20
					<td>=<fmt:formatNumber value="${sum+20}" pattern="#,###" />
				</tr>
			</table>
		</div>
		<div class="row" style="margin-top: 100px; height: 150px;">
			<div style="width: 785px; height: 130px; border: 1px solid lightgray; border-radius: 5px 0px 0px 5px;">
				<div style="padding: 15px 0px 15px 15px; width: 785px; height: 50px;"><input type="checkbox" checked style="float:left; margin-right: 10px;"><h6 style="float:left; line-height: 13px;">카드결제</h6></div>
				<div style="padding: 10px 0px 20px 20px; width: 785px; height: 80px;">
					<h6 style="font-size: 11px;">- 최소 결제 가능 금액은 결제금액에서 배송비를 제외한 금액입니다.</h6>
					<h6 style="font-size: 11px;">- 소액 결제의 경우 PG사 정책에 따라 결제 금액 제한이 있을 수 있습니다.</h6>
				</div>
			</div>
			<div style="width: 350px; height: 130px; border: 1px solid lightgray; border-radius: 0px 5px 5px 0px;">
				<div style="width: 350px; height: 70px;">
					<h6 style="padding: 30px 0px 0px 0px; text-align: center;">최종결제금액 <span style="margin-left: 30px;"><fmt:formatNumber value="${sum+20}" pattern="#,###" />원</span></h6>
				</div>
				<div style="width: 350px; height: 60px;">
					<div style="padding: 10px 0px 0px 0px; text-align: center;"><input id="buy" type="button" value="결제하기" style="width: 300px; height: 30px; background-color: lightgray; border: 0px; border-radius: 5px; text-align: center; font-size: 14px;"></div>
				</div>
			</div>
		</div>
		<div class="row" style="margin-top: 10px; height: 80px;">
			<h6 style="width: 1140px; font-size: 11px;">무이자 할부 이용안내</h6>
			<h6 style="width: 1140px; font-size: 10px; color: darkgray;">- 무이자할부가 적용되지 않은 상품과 무이자할부가 가능한 상품을 동시에 구매할 경우 전체 주문 상품 금액에 대해 무이자할부가 적용되지 않습니다.</h6>
			<h6 style="width: 1140px; font-size: 10px; color: darkgray;">- 무이자할부를 원하시는 경우 장바구니에서 무이자할부 상품만 선택하여 주문하여 주시기 바랍니다.</h6>
		</div>
	</div>
	</form>
	<jsp:include page="/Resource/key/bottom.jsp" flush="false"/>
	
	<script>
		$("#buy").on("click",function(){
			console.log(${list.size()});
			console.log($("#name").val());
			if(${list.size()}=='0'){
				alert("구매할 상품이 없습니다.");
			}else if($("#name").val()=="" || $("#zip_code").val()==""|| $("#address1").val()=="" || $("#address2").val()=="" || $("#phone2").val()=="" ||$("#phone3").val()==""){
				alert("필수 입력사항이 입력되지 않았습니다.");
			}else{
				var email = $("#email1").val()+"@"+$("#email2").val();
				var phone = $("#phone1").val()+$("#phone2").val()+$("#phone3").val();
				var address = $("#address1").val()+ $("#address2").val();
				console.log($("#name").val());
				console.log(email);
				console.log(phone);
				console.log(address);
				var buy_name = "";
		        $(".buy_name").each(function(){
		        	buy_name = buy_name  + $(this).text()+",";
		        });
		        var prices = "";
		        $(".prices").each(function(){
		        	prices = prices  + $(this).text()+",";
		        });
		        var prod_quantitys = "";
		        $(".prod_quantitys").each(function(){
		        	prod_quantitys = prod_quantitys  + $(this).text()+",";
		        });
				console.log("시작!");
				console.log(prices);
				console.log(prod_quantitys);
				$.ajax({
					url:"callMerchantuid.buy",
					type:"post",
					data:{
						name : $("#name").val(),
						buy_name : buy_name ,
						totalPirce : $("#totalPrice").html() ,
						phone : phone ,
						address : address ,
						zip_code : $("#zip_code").val() ,
						email : email ,
						prices : prices ,
						prod_quantitys : prod_quantitys
					},
					dataType:"json"
				}).done(function(data){
					console.log(data);
					var IMP = window.IMP;
			        IMP.init("imp97337518");
	                console.log(buy_name);
					IMP.request_pay({
						pg : data.pg,
						pay_method : data.pay_method,
						merchant_uid : data.merchant_uid,
						name : data.name,
						amount : data.amount,
						buyer_email : data.buyer_email,
						buyer_name : data.buyer_name,
						buyer_tel : data.buyer_tel,
						buyer_addr : data.buyer_addr,
						buyer_postcode : data.buyer_postcode,
					}, function(rsp) { // callback
						console.log(rsp);
						console.log("callback 시작!")
						if (rsp.success) {
							$.ajax({
								url:"buyComplet.buy",
								type:"post",
								data:rsp,
								dataType:"json"
							}).done(function(){
								console.log("결제 완료!");
								location.href= "${pageContext.request.contextPath}/buylist.buy";
							})
						}
						 else {
							 console.log("실패함");
							$.ajax({
								url:"${pageContext.request.contextPath}/buyFailed.buy",
								type:"post",
								data:rsp,
								dataType:"json"
							}).done(function(){
								alert("결제가 취소되었습니다.");
							}) 
						}
					});
				}).fail(function(){
					console.log("fail");
				})
			}
			
		})
	
		$("#return").on("click", function() {
			location.href = "${pageContext.request.contextPath}/list.ca";
		})
		
		function updateCart(seq){
			var countval = $(".count"+seq).html();
			location.href="orderUpdate.or?prod_quantity="+countval+"&seq="+seq;
        }
		
		// 주소찾기	
        function postcode() {
            new daum.Postcode({
                oncomplete: function(data) {
                	var roadAddr = data.roadAddress;
	                var extraRoadAddr = '';
                    document.getElementById("zip_code").value = data.zonecode;
                    document.getElementById("address1").value = roadAddr;
                }
            }).open();
        }
		
	    $('#ck_all').click(function(){
	         if($("#ck_all").prop("checked")){
	            $(".delcheck").prop("checked",true); 
	        }else{
	            $(".delcheck").prop("checked",false); 
	        }
	    });
	        
	   $("#memberSame").change(function(){
	    if($("#memberSame").is(":checked")){
	    	$.ajax({
	    		url:"memberSame.or",
	    		type:"post",
	    		data:{
	    			
	    		},dataType:"json"
	    	}).done(function(data){
		    	console.log("체크");
		    	console.log(data.name);
		    	
	 	    	$("#name").val(data.name);
		    	$("#zip_code").val(data.zip_code);
		    	$("#address1").val(data.address1);
		    	$("#address2").val(data.address2);
		    	$("#phone1").val(data.phone1);
		    	$("#phone2").val(data.phone2);
		    	$("#phone3").val(data.phone3);
		    	$("#email1").val(data.email1);
		    	$("#email2").val(data.email2);
	    	});
	    }
	    else{
	        //Uncheck event
	    }
	});

		$("#memberNew").change(function(){
	    if($("#memberNew").is(":checked")){
	    	console.log("체크");
 	    	$("#name").val("");
	    	$("#zip_code").val("");
	    	$("#address1").val("");
	    	$("#address2").val("");
	    	$("#phone2").val("");
	    	$("#phone3").val("");
	    	$("#phone5").val("");
	    	$("#phone6").val("");
	    	$("#email1").val("");
	    	$("#email2").val("");
	    	//$("#textA").val("");
	    }
	    else{
	        //Uncheck event
	    }
	});
		$("#email3").on("change",function(){
			$("#email2").val($("#email3").val());
		})
		
		$("#check-btn").on("click",function(){ 
			if(confirm("선택 상품을 삭제하시겠습니까?")){
	                var checkArr = new Array();
	                $("input[name='checks']:checked").each(function(){
	                    checkArr.push($(this).attr("data-cartNum"));
	                });
	                	console.log(checkArr);
						$.ajax({
							url:"orderSelectDelete.or",
							type:"post",		
							data:{
								seq:JSON.stringify(checkArr) 
							}
						}).done(function(data){
							console.log("왔음");
							location.href="orderAll.or";
						}).fail(function(){
							console.log("실패");
						});
				}
			else{
	            return false;
	        }
		});
	</script>
	

</body>
</html>
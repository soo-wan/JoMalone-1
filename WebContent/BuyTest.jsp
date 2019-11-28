<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Document</title>
<!-- jQuery -->
<script type="text/javascript"
	src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<!-- iamport.payment.js -->
<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
</head>
<body>
	<button id=refund>환불하기</button>
	<button id=bt>BT</button>
	<script>
		$("#refund").on("click", function() {
			console.log("refundtest로 ㄱㄱ")
			$(location).attr("href","Refund.refund");
		});

		var IMP = window.IMP; 
		IMP.init("imp97337518"); 
		$("#bt").on("click", function() {
			IMP.request_pay({
				pg : "inicis",
				pay_method : "card",
				merchant_uid : "ORD0011",	// 방식정할것
				name : "노르웨이 회전 의자",		// 여러개일시   처음것 외 N개 
				amount : 100,				// 총합 가격
				buyer_email : "asdf@naver.com",		// 이메일 입력
				buyer_name : "홍길동",		// 이름
				buyer_tel : "010-4242-4242",		//전화번호
				buyer_addr : "서울특별시 강남구 신사동", 	//addr1 + addr2 
				buyer_postcode : "01181"	// 우편번호
			}, function(rsp) { // callback
				console.log(rsp);
				if (rsp.success) {
					$.ajax({
						url:"buyComplet.buy",
						type:"post",
						data:rsp,
						dataType:"json"
					})
				}		
				 else {
				}
			});
		})
	</script>
</body>
</html>
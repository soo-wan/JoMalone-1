<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dilivery</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
</head>
<body>		
<input type="text" id="cjInfo" style="width: 300px;" placeholder="송장번호입력">								
<a class="button view" id="cj" style="cursor: pointer;">택배조회</a>

<span id="err">( - )제외한 숫자만 입력해주세요.</span><br>
<span>※ 배송이 시작되면 주문 정보에서 송장번호를 확인 후 조회 가능합니다. </span>

<script>
$("#err").css({'color':'darkgray','font-size':'12px'});
$( "#cj" ).click(function() {
	if(!$("#cjInfo").val()){
		$("#err").text("송장번호를 입력해 주세요!").css({'color':'red','font-size':'12px'});
		return false;
	}
	$("#err").text("");
	
	window.open("http://nexs.cjgls.com/web/info.jsp?slipno="+$("#cjInfo").val());
});
</script>
</body>
</html>
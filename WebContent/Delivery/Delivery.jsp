<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Delivery</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
</head>
<body>		
<div>CJ 대한통운</div>								
<div id="cjInfo">[<a class="button view" id="cj" style="cursor: pointer;">626978391140</a>]</div>
<div id="cjInfo">[<a class="button view" id="cj2" style="cursor: pointer;">626978391140</a>]</div>


<span id="msg">※ 운송장 번호를 클릭시 배송 조회가 가능합니다.</span><br>
<script>
$("#msg").css({'color':'darkgray','font-size':'12px'});
$( "#cj" ).click(function() {
	window.open("http://nexs.cjgls.com/web/info.jsp?slipno="+$("#cj").html());
});


$( "#cj2" ).click(function() {
	window.open("https://www.cjlogistics.com/ko/tool/parcel/tracking?gnbInvcNo="+$("#cj").html());
});

</script>
</body>
</html>
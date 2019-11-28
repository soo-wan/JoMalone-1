<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Page | Jo Malone</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet" href="Resource/css/mypage.css">
</head>
<body>
	<jsp:include page="Resource/key/top.jsp" flush="false"/>
	
	<div id="mypage-home" class="container">
		<div id="welcome-msg" class="row"><h5>안소희 회원님 마이페이지에 오신걸 환영합니다!</h5></div> <!-- 이름 값 받아오기 -->
		<div id="mypage-menu" class="row">
			<div id="my-profile"><img src="Resource/img/my-profile.png"><h5>PROFILE</h5></div>
			<div id="my-cart"><img src="Resource/img/my-cart.png"><h5>CART</h5></div>
			<div id="my-buylist"><img src="Resource/img/my-buylist.png"><h5>BUY LIST</h5></div>
			<div id="my-enquiry"><img src="Resource/img/my-enquiry.png"><h5>1:1 ENQUIRY</h5></div>
			<div id="my-delevery"><img src="Resource/img/my-delevery.png"><h5>DELEVERY</h5></div>
		</div>
	</div>
	
	<jsp:include page="Resource/key/bottom.jsp" flush="false"/>
</body>
</html>
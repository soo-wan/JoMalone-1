<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login | Jo Malone</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet" href="Resource/css/login.css">
</head>
<body>
	<jsp:include page="Resource/key/top.jsp" flush="false"/>
	
	<div id="general-login" class="container">
	    <div id="login-title" class="row"><h4>LOGIN</h4></div>
	    <div id="login-inputbox" class="row">
	    	<div id="login-id" class="col-12"><input type="text" placeholder="Input Your ID "></div>
	    	<div id="login-pw" class="col-12"><input type="password" placeholder="Input Your PW "></div>
	    	<div id="check"></div>
	    	<div id="cookie-check" class="col-12"><input type="checkbox"><h6>아이디저장</h6></div>
	    	<div id="login-btn" class="col-12"><input type="button" value="LOGIN"></div>
	    	<div id="button-list" class="col-12">
	    		<input type="button" value="FIND ID" id="general-findid">
	    		<input type="button" value="FIND PW" id="general-findpw">
	    		<input type="button" value="SIGN UP" id="general-signup">
	    	</div>
	    </div>
	</div>
	
	<div id="sns-login" class="container">
		<div id="sns-title" class="row"><h5>SNS 간편 로그인</h5></div>
		<hr style="margin-bottom: 30px;">
		<div id="sns-btn" class="row">
			<div id="kakao" class="col-12">
				<img src="Resource/img/kakao.png">
				<h5>카카오 로그인</h5>
			</div>
			<div id="naver" class="col-12">
				<img src="Resource/img/naver.jpg">
				<h5>네이버 로그인</h5>
			</div>
		</div>
	</div>
	
	<script>
		$("#general-signup").on("click", function() {
			location.href = "signup.jsp";
		})
	</script>
	
	<jsp:include page="Resource/key/bottom.jsp" flush="false"/>
</body>
</html>
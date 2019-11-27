<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login | Jo Malone</title>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet" href="Resource/css/login.css">
</head>
<body>
	<jsp:include page="Resource/key/top.jsp" flush="false"/>
	
	<div id="login" class="container">
	    <div id="login-title" class="row"><h4>LOGIN</h4></div>
	    <div id="login-inputbox" class="row">
	    	<div id="login-id" class="col-12"><input type="text" placeholder=" Input Your ID "></div>
	    	<div id="login-pw" class="col-12"><input type="password" placeholder=" Input Your PW "></div>
	    	<div id="cookie-check"><input type="checkbox"> <h6>아이디 저장</h6></div>
	    </div>
	</div>
	
	<jsp:include page="Resource/key/bottom.jsp" flush="false"/>
</body>
</html>
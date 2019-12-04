<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Profile | Jo Malone</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link rel="stylesheet" href="/JoMalone/Resource/css/profile.css">
</head>
<body>
	<jsp:include page="/Resource/key/top.jsp" flush="false"/>
	
	<form action="profile.p" method="post" id="profileform">
		<div id="profile" class="container">
			<div id="profile-title" class="row"><h4>MY PROFILE</h4></div>
			
			<div id="modify-btn" class="">
				<input id="profile-modi" type="button" value="modify">
				<input id="profile-re" type="button" value="backward">
			</div>
			</div>
	</form>
	
	<script>
		$("#profile-modi").on("click", function() {
			
		})
		
		$("#profile-re").on("click", function() {
			
		})
	</script>
	
	<jsp:include page="/Resource/key/bottom.jsp" flush="false"/>
</body>
</html>
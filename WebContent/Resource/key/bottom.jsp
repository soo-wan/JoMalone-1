<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Bottom</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet" href="/JoMalone/Resource/css/bottom.css">
</head>
<body>




	<div id="bottom-one" class="container">
		<div id="others" class="row">
			<div id="customer" class="col-3">
				<h5>CUSTOMER CENTER</h5>
				<h2 id="phone">010-7327-3143</h2>
				<h5>전화 상담</h5>
				<h6>평일 09:00 ~ 18:00</h6>
				<h6>점심 12:50 ~ 14:00</h6>
				<hr>
				<h5>게시판 상담</h5>
				<h6>평일 09:00 ~ 18:00</h6>
			</div>
			<div id="latestNotices" class="col-3" style="padding:20px;">
				<h5>NOTICE</h5>
				<hr>
			</div>
			<div id="info" class="col-3">
				<p>
					<a href="https://www.facebook.com/JoMaloneLondon/" target="_blank"><img
						src="/JoMalone/Resource/img/facebook.png"></a> <a
						href="https://twitter.com/JoMaloneLondon/" target="_blank"><img
						src="/JoMalone/Resource/img/twitter.png"></a> <a
						href="https://www.instagram.com/jomalonelondon/" target="_blank"><img
						src="/JoMalone/Resource/img/insta.png"></a>
				</p>
				<h5>GUIDE</h5>
				<h6>이용약관</h6>
				<h6 id="guide">개인정보 처리방침</h6>
				<h5>INFO</h5>
				<h6>사업자 정보조회</h6>
			</div>
			<div id="company" class="col-3">
				<h5>COMPANY</h5>
				<h6 id="company-name">ⓒ Jomalone Korea</h6>
				<h5>LOCATION</h5>
				<h6 id="location">서울시 강남구 강남대로 382 메리츠타워</h6>
				<h5>REPRESENTATIVE</h5>
				<h6 id="representative">Please Buy (JoMalone@gmail.com)</h6>
			</div>
		</div>
		<div id="margin" class="row"></div>
	</div>
	<script>
    	$(document).ready(function(){
    		$.ajax({
    			url : "home.notice",
    			type : "post",
    			dataType : "json",
    			data : {}
    		}).done(function(data){
    			if(data.length==0){
    				$("#latestNotices").append('<div><p>최신 공지가 없습니다.</p></div><hr>');
    			}else{
    			for(var i=0;i<data.length;i++){
    				var titleBox = '<div>'+'<a href="read.notice?no='+data[i].notice_seq+'">'+data[i].title+'</div>';
    				$("#latestNotices").append(titleBox);	
    			}$("#latestNotices").append('<hr>');
    			}
    		}).fail(function(data){
    			$("#latestNotices").append('<div><p>최신 공지가 없습니다.</p></div><hr>');
    		})   	
    	});
    </script>
</body>
</html>
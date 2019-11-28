<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>adminPage</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet" href="Resource/css/home.css">
</head>
<body>
	<jsp:include page="Resource/key/top.jsp"/>
	
	<div id="main-event" class="container">
	    <div id="main" class="row">
            <a href="#"><img src="Resource/img/Main_event.jpg"></a>
	    </div>
	    <div id="details" class="row">
	        <div class="col-12">
	        	<a href="#"><h4>GIVE A GIFT</h4></a>
	        	<a href="#"><h6>기브 어 기프트</h6></a><br>
	        	<a href="#"><input id="main-btn" type="button" value="자세히보기"></a>
	        </div>
	    </div>
	</div>
	
	<div id="event" class="container">
	    <div id="event-one" class="row">
	        <div class="col-5">
	            <a href="#"><div class="bg"><h4>ORANGE BITTERS COLOGNE</h4><h5>오렌지 비터스 코롱</h5><input type="button" value="자세히보기"></div><img src="Resource/img/event01.jpg"></a>
	        </div>
	        <div class="col-2"></div>
	        <div class="col-5">
	        	<a href="#"><div class="bg"><h4>LIMITED EDITION</h4><h5>크리스마스 리미티드 에디션</h5><input type="button" value="자세히보기"></div><img src="Resource/img/event02.jpg"></a>
	        </div>
	    </div>
	    <div id="event-two" class="row">
	    	<div class="col-5">
	    		<a href="#"><div class="bg"><h4>ENGLISH PEAR & FREESIA DIFFUSER</h4><h5>잉글리쉬 페어 앤 프리지아 디퓨저</h5><input type="button" value="자세히보기"></div><img src="Resource/img/event03.jpg"></a>
	    	</div>
	        <div class="col-2"></div>
	        <div class="col-5">
	        	<a href="#"><div class="bg"><h4>HOUSE OF JO MALONE</h4><h5>하우스 오브 조 말론 런던</h5><input type="button" value="자세히보기"></div><img src="Resource/img/event04.jpg"></a>
	        </div>
	    </div>
	    <div id="event-three" class="row">
	    	<div class="col-5">
	    		<a href="#"><div class="bg"><h4>AT YOUR SERVICE</h4><h5>온라인 부티크 혜택</h5><input type="button" value="자세히보기"></div><img src="Resource/img/event05.gif"></a>
	    	</div>
	        <div class="col-2"></div>
	        <div class="col-5">
	        	<a href="#"><div class="bg"><h4>ALL SCENTS</h4><h5>전체 프레그런스 보기</h5><input type="button" value="자세히보기"></div><img src="Resource/img/event06.jpg"></a>
	        </div>
	    </div>
	</div>
	
	<jsp:include page="Resource/key/bottom.jsp" flush="false"/>
</body>
</html>
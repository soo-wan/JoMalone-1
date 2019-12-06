<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home | Jo Malone</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet" href="Resource/css/home.css?b=115">
</head>
<body>
	<jsp:include page="Resource/key/top.jsp" flush="false"/>
	<div id="homebody">
	<div id="main-event" class="container">
	<!-- 
	    <div id="main" style="margin-top: 0px;">
            <a href="#"><img src="Resource/img/Main_event.jpg"></a>
	    </div>
	    <div id="details">
	        <div>
	        	<a href="#"><h4>GIVE A GIFT</h4></a>
	        	<a href="#"><h6>기브 어 기프트</h6></a><br>
	        	<a href="#"><input id="main-btn" type="button" value="자세히보기"></a>
	        </div>
	    </div>
	 -->
	        <div class="col-12 bg-dark px-0 my-2 my-lg-2">
        <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
          <ol class="carousel-indicators">
            <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active d-none d-lg-block"></li>
            <li data-target="#carouselExampleIndicators" data-slide-to="1" class="d-none d-lg-block"></li>
            <li data-target="#carouselExampleIndicators" data-slide-to="2" class="d-none d-lg-block"></li>
            <li data-target="#carouselExampleIndicators" data-slide-to="3" class="d-none d-lg-block"></li>
          </ol>
          <div class="carousel-inner">
            <div class="carousel-item active">
              <img src="Resource/img/Main_event11.jpg" style="width:1140px; height: 540px;" class="d-block w-100" alt="...">
            </div>
            <div class="carousel-item">
              <img src="Resource/img/Main_event44.jpg" style="width:1140px; height: 540px;" class="d-block w-100" alt="...">
            </div>
            <div class="carousel-item">
              <img src="Resource/img/Main_event55.jpg" style="width:1140px; height: 540px;" class="d-block w-100" alt="...">
            </div>
            <div class="carousel-item">
              <img src="Resource/img/Main_event22.jpg" style="width:1140px; height: 540px;" class="d-block w-100" alt="...">
            </div>
          </div>
          <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
            <span class="carousel-control-prev-icon d-none d-lg-block" aria-hidden="true"></span>
            <span class="sr-only">Previous</span>
          </a>
          <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
            <span class="carousel-control-next-icon d-none d-lg-block" aria-hidden="true"></span>
            <span class="sr-only">Next</span>
          </a>
        </div>
    </div>
	</div>
	
	<div id="event" class="container">
	    <div id="event-one" class="row">
	        <div class="col-5">
	        	<a href="/JoMalone/eachProduct.admini?productCode=Ci002"><div class="bg"><h4>GRAPE FRUIT</h4><h5>그레이프 프루트</h5><input type="button" value="자세히보기"></div><img src="Resource/img/event44.jpg"></a>
	        </div>
	        <div class="col-2"></div>
	        <div class="col-5">
	    		<a href="/JoMalone/eachProduct.admini?productCode=Li002"><div class="bg"><h4>RED ROSES</h4><h5>레드 로즈</h5><input type="button" value="자세히보기"></div><img src="Resource/img/event55.jpg"></a>
	    	</div>
	    </div>
	    <div id="event-two" class="row">
	    	<div class="col-5">
	    		<a href="/JoMalone/eachProduct.admini?productCode=Fr003"><div class="bg"><h4>NECTARINE BLOSSOM & HONEY</h4><h5>넥타린 블로썸 앤 허니</h5><input type="button" value="자세히보기"></div><img src="Resource/img/event33.jpg"></a>
	    	</div>
	        <div class="col-2"></div>
	        <div class="col-5">
	            <a href="/JoMalone/eachProduct.admini?productCode=Fl001"><div class="bg"><h4>ORANGE BLOSSOM</h4><h5>오렌지 블로썸</h5><input type="button" value="자세히보기"></div><img src="Resource/img/event11.jpg"></a>
	        </div>
	    </div>
	    <div id="event-three" class="row">
	        <div class="col-5">
	        	<a href="/JoMalone/eachProduct.admini?productCode=Fr002"><div class="bg"><h4>BLACKBERRY & BAY</h4><h5>블랙베리 앤 베이</h5><input type="button" value="자세히보기"></div><img src="Resource/img/event22.jpg"></a>
	        </div>
	        <div class="col-2"></div>
	        <div class="col-5">
	        	<a href="/JoMalone/eachProduct.admini?productCode=Sp001"><div class="bg"><h4>AMBER & LAVENDER</h4><h5>앰버 앤 라벤더 코롱</h5><input type="button" value="자세히보기"></div><img src="Resource/img/event66.jpg"></a>
	        </div>
	    </div>
	</div>
	</div>
	<jsp:include page="Resource/key/bottom.jsp" flush="false"/>
</body>
</html>
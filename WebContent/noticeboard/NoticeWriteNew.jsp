<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Notice | Jo Malone</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">

<style>
#sidebar{ float:left; width:200px; margin:0px; padding:0px; }
    #sidebar>.menu{ list-style-type: none; text-align: right; margin:auto; color:#1e2d47; text-align:center;
    padding:0px 10px; margin: 10px; width:80%; line-height:30px; background-color : #1e2d47; color:white;}
    .menu{height:30px; width:100%; font-family: 'Alata', sans-serif; border:1px solid black; border-radius:3px;}
    
    .Wrap{height:800px;  width:200px; margin:0px; float:left; }
    h4{margin:0px; padding:20px 20px; text-align: right; font-size: 20px; font-family: 'Alata', sans-serif;
    }
    .menu>a{text-decoration: none; color:white;}
    #wrapper{width:1500px; bolder:1px solid black; overflow:hidden; margin:auto; }
    #container{
       	height:800px;
     	width:1300px;
     	float:left;
     	padding: 20px;
     	overflow-x:scroll;
     	border:1px solid black;
    }
       
	#headDiv {padding: 0px;	margin: 0px; padding-top: 20px;	padding-bottom: 20px;}
	#headDiv>div {padding: 0px; margin: 0px; font-weight: bold; font-size: 20px; line-height: 30px;}
	.article {padding-bottom: 10px;}
	.article:hover {background-color: #cbe7ff90;}		
	a:hover {text-decoration: none;}
	.naviBar{
	font-size: 20px;
    word-spacing: 5px;
    font-weight: bold;    
	}
	.naviPage:visited{
	color: black;
	}
</style>
</head>
<body>
<jsp:include page="../Resource/key/topAdmin.jsp" flush="false"/>

<div id="wrapper">
	<div class=Wrap>
		<h4>게시판관리</h4>
			<ul id="sidebar">
			    <li class="menu"><a href="#">공지</a></li>
			    <li class="menu" id="askAll"><a href="#">신규 1:1 문의</a></li>
			    <li class="menu" id="askAll"><a href="#">전체 1:1 문의</a></li>
                <li class="menu"><a href="#">신규 신고글</a></li>
                <li class="menu"><a href="#">전체 신고글</a></li>
                <li class="menu"><a href="#">리뷰</a></li>
			</ul>
      </div>
	
	<form action="/JoMalone/write.notice" method="post" id="writeFrm">
		<div id="container">
				<div class="row" style="text-align: center;" id="headDiv">
			<div class="col-12">공지작성</div>
		</div>
			<div class="row" id=titleBox style="height: 30px;">
				<input type=text placeholder="제목을 입력해주세요." id="askTitle" name="askTitle" style="margin: 0px; padding: 0px 0px 0px 7px; width: 100%; height: 30px; text-align: left;">
			</div>
			<div class="row" id=contentsBox>
				<div class="col-12 p-0">
					<textarea class="summernote" style="width: 100%;" id="contents"
						name="contents"></textarea>
				</div>
			</div>
			<hr>
			<div class="row" id=btnBox>
				<div class="col-12 p-0" style="text-align: right;">
					<input type="button" value="취소" id="cancel"> <input
						type="button" value="글쓰기" id="toWrite">
				</div>
			</div>
		</div>
	</form>
	
	
	
</div>
    <script>
    $("#toIndex").on("click", function() {
		location.href = "home.jsp";
	});	
	$("#toWrite").on("click", function(){
		location.href = "/JoMalone/noticeboard/NoticeWriteCall.jsp";
	});
    </script>
</body>
</html>
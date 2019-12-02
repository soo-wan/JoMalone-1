<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>adminPage</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet" href="Resource/css/home.css">

    <style>
    	a{
    		text-decoration: none;
    	}
        .navi{
            overflow: hidden;
            padding: 0px;
            height:40px;
            background-color:lightgray;
            color:black;
        }
        .navi-item{
            float: left;
            list-style-type: none;
            width:20%;
            height: 100%;
            line-height: 40px;
            text-align: center;
        }
        .middle>.contents{
        	float : left;
        	width:20%;
        	line-height: 40px;
        	text-align: center;
        }
        .navi-item>a{
            color:black;
            width: 100%;
            height: 100%;
            display:block;
        }
        .navi-item>a:hover{
            background-color: dimgray;
        }
    </style>
    
</head>
<body>

	<jsp:include page="Resource/key/topAdmin.jsp" flush="false"/>
	
	<div class="top">
		<ul class="navi">
			<li class="navi-item"><a href="#">회원관리</a></li>
			<li class="navi-item"><a href="#">상품관리</a></li>
			<li class="navi-item"><a href="#">게시판관리</a></li>
			<li class="navi-item"><a href="#">배송관리</a></li>
			<li class="navi-item"><a href="#">통계</a></li>
		</ul>
	</div>
	

</body>
</html>
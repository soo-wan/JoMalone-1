<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Document</title>
    </head>
    <style>
    	a{
    		text-decoration: none;
    	}
        .navi{
            overflow: hidden;
            padding: 0px;
            height:40px;
            background-color:beige;
            color:black;
        }
        .navi-item{
            float: left;
            list-style-type: none;
            width:15%;
            height: 100%;
            line-height: 40px;
            text-align: center;
        }
        .navi-itemC{
            float: left;
            list-style-type: none;
            width:40%;
            height: 100%;
            line-height: 40px;
            text-align: center;
        }
        .middle>.contents{
        	float : left;
        	width:15%;
        	line-height: 40px;
        	text-align: center;
        }
        .middle>.contentsC{
        	float : left;
        	width:40%;
        	line-height: 40px;
        	text-align: center;
        }
        .navi-item>a{
            color:blue;
            width: 100%;
            height: 100%;
            display:block;
        }
        .navi-item>a:hover{
            background-color: deepskyblue;
        }
    </style>
<body>
	<div class="top">
		<ul class="navi">
			<li class="navi-item"><a href="#">주문일자</a></li>
			<li class="navi-itemC"><a href="#">상품정보</a></li>
			<li class="navi-item"><a href="#">수량</a></li>
			<li class="navi-item"><a href="#">상품구매금액</a></li>
			<li class="navi-item"><a href="#">주문처리상태</a></li>
		</ul>
	</div>
	<div class="middle">
		<div class="contents">내용1</div>
		<div class="contentsC">
			<a href="#">
				<img src="${pageContext.request.contextPath}/image11.gif" width=100 height=100>
			</a> 내용2
		</div>
		<div class="contents">내용3</div>
		<div class="contents">내용4</div>
		<div class="contents">내용5</div>
	</div>
</body>
</html>